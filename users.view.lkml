view: users {
  # change to relevant schema name for block implementation
  derived_table: {
    sql_trigger_value: SELECT CURRENT_DATE ;;
    distribution: "mparticle_user_id"
    sortkeys: ["install_timestamp"]
    sql: select *
      from (
        select mparticleuserid as mparticle_user_id,
          case when min(firstseentimestamp) is not null and min(firstseentimestamp) > 0 then min(firstseentimestamp) else
            min(case when messagetypeid = 7 then eventtimestamp end) end as install_timestamp,
          isnull(min(attributionpublisher), 'Unattributted') as attribution_source,
          count(*) as event_count,
          isnull(sum(case when messagetypeid = 1 then 1 end), 0) as session_count,
          count(distinct eventdate) as active_day_count,
          isnull(sum(eventltvvalue), 0) as ltv,
          isnull(sum(case when messagetypeid = 2 then eventlength / 1000 end), 0) as time_spent_in_app,
          min(case when messagetypeid = 7 then appversion end) as app_version_at_install
        from app_191.eventsview
        group by 1)
      where install_timestamp is not null
       ;;
  }

  dimension: mparticle_user_id {
    type: number
    sql: ${TABLE}.mparticle_user_id ;;
  }

  dimension_group: install_timestamp {
    type: time
    datatype: epoch
    timeframes: [time, date, week, month, year]
    sql: (${TABLE}.install_timestamp::bigint)/1000 ;;
  }

  dimension: attribution_source {
    type: string
    sql: ${TABLE}.attribution_source ;;
  }

  dimension: event_count {
    type: number
    sql: ${TABLE}.event_count ;;
  }

  dimension: session_count {
    type: number
    sql: ${TABLE}.session_count ;;
  }

  dimension: active_day_count {
    type: number
    sql: ${TABLE}.active_day_count ;;
  }

  dimension: ltv {
    type: number
    sql: ${TABLE}.ltv ;;
    value_format: "$#,##0.00"
  }

  dimension: spender_type {
    sql: case when ${ltv} > 0 then 'spender' else 'non-spender' end ;;
  }

  dimension: time_spent_in_app {
    type: number
    sql: ${TABLE}.time_spent_in_app ;;
  }

  dimension: app_version_at_install {
    sql: ${TABLE}.app_version_at_install ;;
  }

  measure: count {
    type: count
  }
}