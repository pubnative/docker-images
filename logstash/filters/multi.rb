# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"

# Add any asciidoc formatted documentation here
# This example filter will replace the contents of the default
# message field with whatever you specify in the configuration.
#
# It is only intended to be used as an example.
class LogStash::Filters::Multi < LogStash::Filters::Base

  # Setting the config_name here is required. This is how you
  # configure this filter from your Logstash config.
  #
  # filter {
  #   multi { source => "message" }
  # }
  config_name "multi"

  # Replace the message with this value.
  config :source, :validate => :hash, :default => {'dsps_action_lost' => 'lost', 'dsps_action_won' => 'won'}
  config :field_name, :validate => :string, :default => 'dsp_id'
  config :field_value, :validate => :string, :default => 'dsp.auction.status'
  config :exclude_fields, :validate => :array, :default => ["request_uri", "context", "endpoint", "user_agent", "request_ip", "client_ip", "isp", "auth_token", "request_id", "request_time_nanosec", "created_at"]

  public
  def register
    # Add instance variables
  end

  # def register

  public
  def filter(event)

    @source.each do |s, v|
      if event[s] && event[s].is_a?(Array)
        event[s].each do |item|
          custom_event               = event.clone
          custom_event[@field_name]  = item
          custom_event[@field_value] = v
          custom_event["message"]    = s
          custom_event["metric"]     = "dsp_auction"
          custom_event.remove(s)
          @exclude_fields.each {|f| custom_event.remove(f) }
          yield custom_event
        end
      end
    end

    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter

end # class LogStash::Filters::Example
