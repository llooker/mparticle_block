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
      explore: otherevents
      field: otherevents.platform

    - name: is_debug_data
      type: field_filter
      explore: otherevents
      field: otherevents.is_debug

    - name: event_1
      type: field_filter
      explore: otherevents
      field: otherevents.event_name

    - name: event_2
      type: field_filter
      explore: otherevents
      field: otherevents.event_name

    - name: event_3
      type: field_filter
      explore: otherevents
      field: otherevents.event_name

    - name: event_4
      type: field_filter
      explore: otherevents
      field: otherevents.event_name

  elements:
    - name: session_count
      title: Session Count
      type: single_value
      model: mparticle_looker_blocks
      explore: otherevents
      measures: [otherevents.session_count]
      listen:
        date: otherevents.event_date
        platform: otherevents.platform
        is_debug_data: otherevents.is_debug
      sorts: [otherevents.event_type_id, otherevents.platform, otherevents.session_count desc]
      limit: 500
      font_size: small
      height: 2
      width: 4

    - name: average_session_length
      title: Average Session Length (Seconds)
      type: single_value
      model: mparticle_looker_blocks
      explore: otherevents
      measures: [otherevents.avg_session_length]
      listen:
        date: otherevents.event_date
        platform: otherevents.platform
        is_debug_data: otherevents.is_debug
      sorts: [otherevents.event_type_id, otherevents.platform, otherevents.avg_session_length desc]
      limit: 500
      font_size: small
      height: 2
      width: 4

    - name: total_installs
      title: Total Installs
      type: single_value
      model: mparticle_looker_blocks
      explore: otherevents
      measures: [otherevents.install_count]
      listen:
        date: otherevents.event_date
        platform: otherevents.platform
        is_debug_data: otherevents.is_debug
      sorts: [otherevents.event_type_id, otherevents.platform, otherevents.install_count desc]
      limit: 500
      font_size: small
      height: 2
      width: 4

    - name: uu by App Platform
      title: Active Users by App Platform
      type: looker_column
      model: mparticle_looker_blocks
      explore: otherevents
      dimensions: [otherevents.app_name_platform]
      measures: [otherevents.unique_user_count]
      listen:
        date: otherevents.event_date
        platform: otherevents.platform
        is_debug_data: otherevents.is_debug
      sorts: [otherevents.unique_user_count desc]
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
      explore: otherevents
      listen:
        date: otherevents.event_date
        platform: otherevents.platform
        is_debug_data: otherevents.is_debug
      dimensions: [otherevents.os_version, otherevents.platform]
      pivots: [otherevents.platform]
      measures: [otherevents.session_count]
      dynamic_fields:
      - table_calculation: session_pct
        label: session_pct
        expression: ${otherevents.session_count} / ${otherevents.session_count:total}
        value_format: 0.0%
      sorts: [otherevents.session_count desc 0, otherevents.platform]
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
      hidden_fields: [otherevents.session_count]
      y_axis_labels: ['% of Sessions']
      y_axis_value_format: 0.0%
      x_axis_label: OS Version

    - name: Dau by app Platform
      title: DAU by App Platform
      type: looker_area
      model: mparticle_looker_blocks
      explore: otherevents
      listen:
        date: otherevents.event_date
        platform: otherevents.platform
        is_debug_data: otherevents.is_debug
      dimensions: [otherevents.app_name_platform, otherevents.event_date]
      pivots: [otherevents.app_name_platform]
      measures: [otherevents.unique_user_count]
      sorts: [otherevents.event_date desc, otherevents.app_name_platform]
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
      explore: otherevents
      listen:
        date: otherevents.event_date
        platform: otherevents.platform
        is_debug_data: otherevents.is_debug
      dimensions: [otherevents.event_date, otherevents.app_name_platform]
      pivots: [otherevents.app_name_platform]
      measures: [otherevents.avg_session_length]
      sorts: [otherevents.event_date desc, otherevents.app_name_platform]
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
      explore: otherevents
      listen:
        date: otherevents.event_date
        platform: otherevents.platform
        is_debug_data: otherevents.is_debug
      dimensions: [otherevents.event_date, otherevents.app_name_platform]
      pivots: [otherevents.app_name_platform]
      measures: [otherevents.time_spent_in_app, otherevents.unique_user_count]
      dynamic_fields:
      - table_calculation: time_spent_in_app_per_user
        label: Time Spent In App Per User
        expression: ${otherevents.time_spent_in_app} / ${otherevents.unique_user_count}
        value_format: '0'
      sorts: [otherevents.session_count desc 0, otherevents.platform, otherevents.app_name_platform]
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
      hidden_fields: [otherevents.unique_user_count, otherevents.time_spent_in_app]

    - name: session_cnt_by_hour
      title: Session Count by Hour of Day by App
      type: looker_area
      model: mparticle_looker_blocks
      explore: otherevents
      listen:
        date: otherevents.event_date
        platform: otherevents.platform
        is_debug_data: otherevents.is_debug
      dimensions: [otherevents.app_name_platform, otherevents.hour]
      pivots: [otherevents.app_name_platform]
      measures: [otherevents.session_count]
      sorts: [otherevents.session_count desc 1, otherevents.app_name_platform]
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
      explore: otherevents
      listen:
        date: otherevents.event_date
        platform: otherevents.platform
        is_debug_data: otherevents.is_debug
      dimensions: [otherevents.app_name_platform, otherevents.event_date]
      pivots: [otherevents.app_name_platform]
      measures: [otherevents.install_count]
      sorts: [otherevents.event_date desc, otherevents.app_name_platform]
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
      explore: otherevents
      listen:
        date: otherevents.event_date
        platform: otherevents.platform
        is_debug_data: otherevents.is_debug
      dimensions: [otherevents.app_name_platform, otherevents.event_date]
      pivots: [otherevents.app_name_platform]
      measures: [otherevents.revenue]
      sorts: [otherevents.event_date desc, otherevents.app_name_platform]
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
      explore: otherevents
      listen:
        date: otherevents.event_date
        platform: otherevents.platform
        is_debug_data: otherevents.is_debug
      dimensions: [otherevents.app_name_platform, otherevents.event_date]
      pivots: [otherevents.app_name_platform]
      measures: [otherevents.session_count]
      sorts: [otherevents.event_date desc, otherevents.app_name_platform]
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
      explore: otherevents
      listen:
        date: otherevents.event_date
        platform: otherevents.platform
        is_debug_data: otherevents.is_debug
      dimensions: [otherevents.event_name]
      measures: [otherevents.count, otherevents.unique_user_count]
      dynamic_fields:
      - table_calculation: event_count_per_user
        label: Event count per user
        expression: ${otherevents.count} / ${otherevents.unique_user_count}
        value_format: '0.00'
      filters:
        otherevents.event_name: -EMPTY
        otherevents.message_type_id: '4,16'
      sorts: [otherevents.count desc]
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
      explore: otherevents
      measures: [funnel.event_1_uu_count, funnel.event_2_uu_count, funnel.event_3_uu_count,
        funnel.event_4_uu_count]
      dimensions: [otherevents.app_name_platform]
      listen:
        date: otherevents.event_date
        event_1: otherevents.event_1
        event_2: otherevents.event_2
        event_3: otherevents.event_3
        event_4: otherevents.event_4
        platform: otherevents.platform
        is_debug_data: otherevents.is_debug
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
      explore: otherevents
      listen:
        date: otherevents.event_date
        install_date: users.install_timestamp_date
        platform: otherevents.platform
        is_debug_data: otherevents.is_debug
      dimensions: [otherevents.weeks_since_install, users.attribution_source]
      pivots: [users.attribution_source]
      measures: [otherevents.unique_user_count]
      filters:
        otherevents.weeks_since_install: NOT NULL
        users.attribution_source: -NULL
      dynamic_fields:
      - table_calculation: user_retention_pct
        label: user retention pct
        expression: ${otherevents.unique_user_count} / max(${otherevents.unique_user_count})
        value_format: '#,##0.00%'
      sorts: [otherevents.weeks_since_install, otherevents.unique_user_count desc 0, users.attribution_source]
      limit: 500
      column_limit: 50
      hidden_fields: [otherevents.unique_user_count]
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
