# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"

# Add any asciidoc formatted documentation here
# This example filter will replace the contents of the default
# message field with whatever you specify in the configuration.
#
# It is only intended to be used as an example.
class LogStash::Filters::Mesos < LogStash::Filters::Base

  # Setting the config_name here is required. This is how you
  # configure this filter from your Logstash config.
  #
  # filter {
  #   mesos { source => "message" }
  # }
  config_name "mesos"

  # Replace the message with this value.
  # config :source, :validate => :hash, :default => {}
  config :slave_attributes, :validate => :hash, :default => {}
  config :required_resources, :validate => :hash, :default => {'mem' => 0, 'cpus' => 0, 'disk' => 0}
  config :required_instances, :validate => :number, :default => 1
  # config :exclude_fields, :validate => :array, :default => []

  public
  def register
    # Add instance variables
  end

  def filter(event)
    if event['slaves'].size != 0
      have_resources = []
      event['slaves'].map! do |slave|
        slave['free_resources'] = {}
        %w(mem cpus disk).each do |metric|
          slave['free_resources'][metric] = slave['unreserved_resources'][metric] - slave['used_resources'][metric]
        end
        have_resources << slave['hostname'] if subject?(slave['attributes']) && enough_resources?(slave['free_resources'])
        slave
      end
      @logger.debug("Found resources: #{have_resources}", required_instances: @required_instances, instances_count: have_resources)

      notification_event = create_event(have_resources)
      notification_event['type'] = event['type']
      if @required_instances > have_resources.size
        notification_event['message'] = "Not Enough Mesos Resources [#{@required_instances}/#{have_resources.size}]"
        notification_event['is_invalid'] = true
        notification_event['warning'] = true
      end
      yield notification_event
    end
    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end

  private

  def enough_resources?(free_resources)
    @logger.debug(free_resources)
    @required_resources.keys.all? { |k| free_resources[k] >= @required_resources[k] }
  end

  def subject?(slave_attributes)
    @slave_attributes.all? do |k, v|
      slave_attributes[k] == v
    end
  end

  def create_event(instances)
    LogStash::Event.new('instances_count' => instances.size,
                        'valid_instances' => instances,
                        'required_instances' => @required_instances,
                        'slave_attributes' => @slave_attributes,
                        'required_resources' => @required_resources
                        )
  end
end
