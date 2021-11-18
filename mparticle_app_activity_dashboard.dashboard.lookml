- dashboard: mparticle_dashboard
  title: mParticle App Activity Dashboard
  layout: grid
  rows:
    - elements: [session_count, average_session_length, total_installs]
      height: 220
    - elements: [uu by App Platform,session_cnt_breakdown]
      height: 400
    - elements: [Dau by app Platform,Daily Avg Session Length by App Platform]
      height: 400
    - elements: [daily_time_spent_in_app, session_cnt_by_hour]
      height: 400
    - elements: [Daily Installs by App Platform, Daily Revenue by App Platform]
      height: 400
    - elements: [Daily Session Count by App Platform, Top 50 Event Name Stats]
      height: 400
    - elements: [Funnel Analytics by App Platform, user_retention]
      height: 400
  refresh: 1 hour

  filters:
    - name: date
      title: Event Date
      type: date_filter
      default_value: 30 Days

    - name: install_date
      title: Install Date
      type: date_filter
      default_value: 30 Days

    - name: platform
      type: field_filter
      explore: rawevents
      field: rawevents.platform

    - name: is_debug_data
      type: field_filter
      explore: rawevents
      field: rawevents.is_debug

    - name: event_1
      type: field_filter
      explore: rawevents
      field: rawevents.event_name

    - name: event_2
      type: field_filter
      explore: rawevents
      field: rawevents.event_name

    - name: event_3
      type: field_filter
      explore: rawevents
      field: rawevents.event_name

    - name: event_4
      type: field_filter
      explore: rawevents
      field: rawevents.event_name

  elements:
    - name: session_count
      title: Session Count
      type: single_value
      model: mparticle_looker_blocks
      explore: rawevents
      measures: [rawevents.session_count]
      listen:
        date: rawevents.event_date
        platform: rawevents.platform
        is_debug_data: rawevents.is_debug
      sorts: [rawevents.event_type_id, rawevents.platform, rawevents.session_count desc]
      limit: 500
      font_size: small
      height: 2
      width: 4

    - name: average_session_length
      title: Average Session Length (Seconds)
      type: single_value
      model: mparticle_looker_blocks
      explore: rawevents
      measures: [rawevents.avg_session_length]
      listen:
        date: rawevents.event_date
        platform: rawevents.platform
        is_debug_data: rawevents.is_debug
      sorts: [rawevents.event_type_id, rawevents.platform, rawevents.avg_session_length desc]
      limit: 500
      font_size: small
      height: 2
      width: 4

    - name: total_installs
      title: Total Installs
      type: single_value
      model: mparticle_looker_blocks
      explore: rawevents
      measures: [rawevents.install_count]
      listen:
        date: rawevents.event_date
        platform: rawevents.platform
        is_debug_data: rawevents.is_debug
      sorts: [rawevents.event_type_id, rawevents.platform, rawevents.install_count desc]
      limit: 500
      font_size: small
      height: 2
      width: 4

    - name: uu by App Platform
      title: Active Users by App Platform
      type: looker_column
      model: mparticle_looker_blocks
      explore: rawevents
      dimensions: [rawevents.app_name_platform]
      measures: [rawevents.unique_user_count]
      listen:
        date: rawevents.event_date
        platform: rawevents.platform
        is_debug_data: rawevents.is_debug
      sorts: [rawevents.unique_user_count desc]
      limit: 500
      column_limit: 50
      show_row_numbers: true
      ordering: none
      show_null_labels: false
      stacking: ''
      show_value_labels: true
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      show_null_points: true
      point_style: circle
      interpolation: linear
      value_labels: legend
      label_type: labPer
      font_size: medium
      show_view_names: true
      y_axis_labels: [Monthly Active Users]
      x_axis_label: App

    - name: session_cnt_breakdown
      title: Session Count Breakdown by OS Version
      type: looker_column
      model: mparticle_looker_blocks
      explore: rawevents
      listen:
        date: rawevents.event_date
        platform: rawevents.platform
        is_debug_data: rawevents.is_debug
      dimensions: [rawevents.os_version, rawevents.platform]
      pivots: [rawevents.platform]
      measures: [rawevents.session_count]
      dynamic_fields:
      - table_calculation: session_pct
        label: session_pct
        expression: ${rawevents.session_count} / ${rawevents.session_count:total}
        value_format: 0.0%
      sorts: [rawevents.session_count desc 0, rawevents.platform]
      limit: 500
      column_limit: 50
      total: true
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      ordering: none
      show_null_labels: false
      value_labels: legend
      label_type: labPer
      hidden_fields: [rawevents.session_count]
      y_axis_labels: ['% of Sessions']
      y_axis_value_format: 0.0%
      x_axis_label: OS Version

    - name: Dau by app Platform
      title: DAU by App Platform
      type: looker_area
      model: mparticle_looker_blocks
      explore: rawevents
      listen:
        date: rawevents.event_date
        platform: rawevents.platform
        is_debug_data: rawevents.is_debug
      dimensions: [rawevents.app_name_platform, rawevents.event_date]
      pivots: [rawevents.app_name_platform]
      measures: [rawevents.unique_user_count]
      sorts: [rawevents.event_date desc, rawevents.app_name_platform]
      limit: 500
      column_limit: 50
      show_view_names: true
      stacking: normal
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      point_style: none
      interpolation: linear
      show_null_points: true
      value_labels: legend
      label_type: labPer
      ordering: none
      show_null_labels: false
      x_axis_label: Date
      y_axis_labels: [Daily Active Users]

    - name: Daily Avg Session Length by App Platform
      title: Daily Avg Session Length by App Platform
      type: looker_line
      model: mparticle_looker_blocks
      explore: rawevents
      listen:
        date: rawevents.event_date
        platform: rawevents.platform
        is_debug_data: rawevents.is_debug
      dimensions: [rawevents.event_date, rawevents.app_name_platform]
      pivots: [rawevents.app_name_platform]
      measures: [rawevents.avg_session_length]
      sorts: [rawevents.event_date desc, rawevents.app_name_platform]
      limit: 500
      column_limit: 50
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      point_style: none
      interpolation: linear
      ordering: none
      show_null_labels: false
      show_null_points: true
      y_axis_labels: [Avg Session Length (in sec)]
      x_axis_label: Date

    - name: daily_time_spent_in_app
      title: Daily Time Spent In App Per User by App
      type: looker_line
      model: mparticle_looker_blocks
      explore: rawevents
      listen:
        date: rawevents.event_date
        platform: rawevents.platform
        is_debug_data: rawevents.is_debug
      dimensions: [rawevents.event_date, rawevents.app_name_platform]
      pivots: [rawevents.app_name_platform]
      measures: [rawevents.time_spent_in_app, rawevents.unique_user_count]
      dynamic_fields:
      - table_calculation: time_spent_in_app_per_user
        label: Time Spent In App Per User
        expression: ${rawevents.time_spent_in_app} / ${rawevents.unique_user_count}
        value_format: '0'
      sorts: [rawevents.session_count desc 0, rawevents.platform, rawevents.app_name_platform]
      limit: 500
      column_limit: 50
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      show_null_points: true
      point_style: none
      interpolation: linear
      x_axis_label: Date
      y_axis_labels: [Time Spent In App Per User (in sec)]
      hidden_fields: [rawevents.unique_user_count, rawevents.time_spent_in_app]

    - name: session_cnt_by_hour
      title: Session Count by Hour of Day by App
      type: looker_area
      model: mparticle_looker_blocks
      explore: rawevents
      listen:
        date: rawevents.event_date
        platform: rawevents.platform
        is_debug_data: rawevents.is_debug
      dimensions: [rawevents.app_name_platform, rawevents.hour]
      pivots: [rawevents.app_name_platform]
      measures: [rawevents.session_count]
      sorts: [rawevents.session_count desc 1, rawevents.app_name_platform]
      limit: 500
      column_limit: 50
      show_view_names: true
      ordering: none
      show_null_labels: false
      stacking: normal
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      point_style: none
      interpolation: linear
      show_null_points: true
      value_labels: legend
      label_type: labPer
      x_axis_label: Hour of Day
      y_axis_labels: [Session Count]

    - name: Daily Installs by App Platform
      title: Daily Installs by App Platform
      type: looker_area
      model: mparticle_looker_blocks
      explore: rawevents
      listen:
        date: rawevents.event_date
        platform: rawevents.platform
        is_debug_data: rawevents.is_debug
      dimensions: [rawevents.app_name_platform, rawevents.event_date]
      pivots: [rawevents.app_name_platform]
      measures: [rawevents.install_count]
      sorts: [rawevents.event_date desc, rawevents.app_name_platform]
      limit: 500
      column_limit: 50
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      point_style: none
      interpolation: linear
      ordering: none
      show_null_labels: false
      show_null_points: true
      y_axis_labels: [Installs]
      x_axis_label: Date

    - name: Daily Revenue by App Platform
      title: Daily Revenue by App Platform
      type: looker_area
      model: mparticle_looker_blocks
      explore: rawevents
      listen:
        date: rawevents.event_date
        platform: rawevents.platform
        is_debug_data: rawevents.is_debug
      dimensions: [rawevents.app_name_platform, rawevents.event_date]
      pivots: [rawevents.app_name_platform]
      measures: [rawevents.revenue]
      sorts: [rawevents.event_date desc, rawevents.app_name_platform]
      limit: 500
      column_limit: 50
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      point_style: none
      interpolation: linear
      ordering: none
      show_null_labels: false
      show_null_points: true
      x_axis_label: Date
      y_axis_labels: [Revenue]
      y_axis_value_format: $#,##0.00

    - name: Daily Session Count by App Platform
      title: Daily Session Count by App Platform
      type: looker_area
      model: mparticle_looker_blocks
      explore: rawevents
      listen:
        date: rawevents.event_date
        platform: rawevents.platform
        is_debug_data: rawevents.is_debug
      dimensions: [rawevents.app_name_platform, rawevents.event_date]
      pivots: [rawevents.app_name_platform]
      measures: [rawevents.session_count]
      sorts: [rawevents.event_date desc, rawevents.app_name_platform]
      limit: 500
      column_limit: 50
      stacking: normal
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      point_style: none
      interpolation: linear
      ordering: none
      show_null_labels: false
      show_null_points: true
      x_axis_label: Date
      y_axis_labels: [Session Count]

    - name: Top 50 Event Name Stats
      title: Top 50 Event Name Stats
      type: table
      model: mparticle_looker_blocks
      explore: rawevents
      listen:
        date: rawevents.event_date
        platform: rawevents.platform
        is_debug_data: rawevents.is_debug
      dimensions: [rawevents.event_name]
      measures: [rawevents.count, rawevents.unique_user_count]
      dynamic_fields:
      - table_calculation: event_count_per_user
        label: Event count per user
        expression: ${rawevents.count} / ${rawevents.unique_user_count}
        value_format: '0.00'
      filters:
        rawevents.event_name: -EMPTY
        rawevents.message_type_id: '4,16'
      sorts: [rawevents.count desc]
      limit: 50
      column_limit: 50
      show_view_names: true
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      ordering: none
      show_null_labels: false
      show_row_numbers: true

    - name: Funnel Analytics by App Platform
      title: Funnel Analytics by App Platform
      type: looker_column
      model: mparticle_looker_blocks
      explore: rawevents
      measures: [funnel.event_1_uu_count, funnel.event_2_uu_count, funnel.event_3_uu_count,
        funnel.event_4_uu_count]
      dimensions: [rawevents.app_name_platform]
      listen:
        date: rawevents.event_date
        event_1: rawevents.event_1
        event_2: rawevents.event_2
        event_3: rawevents.event_3
        event_4: rawevents.event_4
        platform: rawevents.platform
        is_debug_data: rawevents.is_debug
      limit: 500
      column_limit: 50
      show_view_names: true
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      x_axis_label: App Platform
      ordering: none
      show_null_labels: false
      show_row_numbers: true
      show_dropoff: true
      y_axis_labels: [Unique User Count]
      y_axis_value_format: '#,##0'
      series_labels:
        funnel.event_1_uu_count: Event 1
        funnel.event_2_uu_count: Event 2
        funnel.event_3_uu_count: Event 3
        funnel.event_4_uu_count: Event 4

    - name: user_retention
      title: User Retention by Attribution Source
      type: looker_line
      model: mparticle_looker_blocks
      explore: rawevents
      listen:
        date: rawevents.event_date
        install_date: users.install_timestamp_date
        platform: rawevents.platform
        is_debug_data: rawevents.is_debug
      dimensions: [rawevents.weeks_since_install, users.attribution_source]
      pivots: [users.attribution_source]
      measures: [rawevents.unique_user_count]
      filters:
        rawevents.weeks_since_install: NOT NULL
        users.attribution_source: -NULL
      dynamic_fields:
      - table_calculation: user_retention_pct
        label: user retention pct
        expression: ${rawevents.unique_user_count} / max(${rawevents.unique_user_count})
        value_format: '#,##0.00%'
      sorts: [rawevents.weeks_since_install, rawevents.unique_user_count desc 0, users.attribution_source]
      limit: 500
      column_limit: 50
      hidden_fields: [rawevents.unique_user_count]
      show_row_numbers: true
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      show_null_points: true
      point_style: none
      interpolation: linear
      font_size: medium
      show_view_names: true
      value_labels: legend
      label_type: labPer
      ordering: none
      show_null_labels: false
      show_dropoff: false
      y_axis_labels: [User Retention Percent %]
      y_axis_value_format: 0%
      x_axis_label: Weeks since install
