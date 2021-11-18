- dashboard: mparticle_app_version_dashboard
  title: mParticle App Version Dashboard
  layout: grid
  rows:
    - elements: [Total Sessions by App Version, Daily Sessions by App Version]
      height: 400
    - elements: [Daily Avg Session Length by App Version, Daily ARPU by App Version]
      height: 400
    - elements: [user_retention]
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
      default_value: Android

    - name: is_debug_data
      type: field_filter
      explore: rawevents
      field: rawevents.is_debug

  elements:

    - name: Total Sessions by App Version
      title: Total Sessions by App Version
      type: looker_column
      model: mparticle_looker_blocks
      explore: rawevents
      listen:
        date: rawevents.event_date
        platform: rawevents.platform
        is_debug_data: rawevents.is_debug
      dimensions: [rawevents.app_version]
      measures: [rawevents.session_count]
      sorts: [rawevents.session_count desc]
      limit: 500
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
      x_axis_label: App Version
      y_axis_labels: [Session Count]

    - name: Daily Sessions by App Version
      title: Daily Sessions by App Version
      type: looker_line
      model: mparticle_looker_blocks
      explore: rawevents
      listen:
        date: rawevents.event_date
        platform: rawevents.platform
        is_debug_data: rawevents.is_debug
      dimensions: [rawevents.app_version, rawevents.event_date]
      pivots: [rawevents.app_version]
      measures: [rawevents.session_count]
      sorts: [rawevents.session_count desc 1, rawevents.app_version]
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
      y_axis_labels: [Session Count]

    - name: Daily Avg Session Length by App Version
      title: Daily Avg Session Length by App Version
      type: looker_line
      model: mparticle_looker_blocks
      explore: rawevents
      listen:
        date: rawevents.event_date
        platform: rawevents.platform
        is_debug_data: rawevents.is_debug
      dimensions: [rawevents.app_version, rawevents.eventhour_date]
      pivots: [rawevents.app_version]
      measures: [rawevents.avg_session_length]
      sorts: [rawevents.session_count desc 1, rawevents.app_version]
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
      y_axis_labels: [Avg Session Length (in sec)]
      x_axis_label: Date

    - name: Daily ARPU by App Version
      title: Daily ARPU by App Version
      type: looker_line
      model: mparticle_looker_blocks
      explore: rawevents
      listen:
        date: rawevents.event_date
        platform: rawevents.platform
        is_debug_data: rawevents.is_debug
      dimensions: [rawevents.app_version, rawevents.eventhour_date]
      pivots: [rawevents.app_version]
      measures: [rawevents.arpu]
      sorts: [rawevents.session_count desc 1, rawevents.app_version]
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
      y_axis_labels: [ARPU]
      x_axis_label: Date

    - name: user_retention
      title: User Retention by App Version at Install
      type: looker_line
      model: mparticle_looker_blocks
      explore: rawevents
      listen:
        date: rawevents.event_date
        install_date: users.install_timestamp_date
        platform: rawevents.platform
        is_debug_data: rawevents.is_debug
      dimensions: [rawevents.weeks_since_install, users.app_version_at_install]
      pivots: [users.app_version_at_install]
      measures: [rawevents.unique_user_count]
      filters:
        rawevents.weeks_since_install: NOT NULL
        users.app_version_at_install: -NULL
      dynamic_fields:
      - table_calculation: user_retention_pct
        label: user retention pct
        expression: ${rawevents.unique_user_count} / max(${rawevents.unique_user_count})
        value_format: '#,##0.00%'
      sorts: [rawevents.weeks_since_install, rawevents.unique_user_count desc 0, users.app_version_at_install]
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
