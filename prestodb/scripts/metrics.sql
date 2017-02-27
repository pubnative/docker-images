select
    user
    , query_id
    , node_id
    , source
    , state "state::multi-filter"
    , created created_at
    , started created_at
    , "end" ended_at
    , date_diff('millisecond', started, "end") duration
    , queued_time_ms
    , analysis_time_ms
    , distributed_planning_time_ms

from system.runtime.queries
where state NOT IN ('STARTING', 'RUNNING')
    and "end" > now() - interval '1' minute
    and user != 'prestodb-metrics'
order by created desc;
