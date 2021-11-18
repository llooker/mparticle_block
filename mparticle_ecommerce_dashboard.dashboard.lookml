- dashboard: mparticle_ecommerce_dashboard
  title: mParticle eCommerce Dashboard
  layout: grid
  rows:
    - elements: [total_revenue, unique_user_count, arpu]
      height: 220
    - elements: [Revenue by Attribution Source, Revenue by Hour of Day]
      height: 400
    - elements: [Revenue & ARPU by Day, Purchase Funnel Analytics by App Platform]
      height: 400
  refresh: 1 hour

  filters:
    - name: date
      title: Event Date
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
      default_value: "eCommerce - ViewDetail"

    - name: event_2
      type: field_filter
      explore: rawevents
      field: rawevents.event_name
      default_value: "eCommerce - AddToWishlist"

    - name: event_3
      type: field_filter
      explore: rawevents
      field: rawevents.event_name
      default_value: "eCommerce - AddToCart"

    - name: event_4
      type: field_filter
      explore: rawevents
      field: rawevents.event_name
      default_value: "eCommerce - Checkout"

    - name: event_5
      type: field_filter
      explore: rawevents
      field: rawevents.event_name
      default_value: "eCommerce - Purchase"

  elements:

  - name: total_revenue
    title: Total Revenue
    type: single_value
    model: mparticle_looker_blocks
    explore: rawevents
    measures: [rawevents.revenue]
    listen:
      date: rawevents.event_date
      platform: rawevents.platform
      is_debug_data: rawevents.is_debug
    sorts: [rawevents.revenue desc]
    limit: 500
    font_size: small
    height: 2
    width: 4

  - name: unique_user_count
    title: Unique User Count
    type: single_value
    model: mparticle_looker_blocks
    explore: rawevents
    measures: [rawevents.unique_user_count]
    listen:
      date: rawevents.event_date
      platform: rawevents.platform
      is_debug_data: rawevents.is_debug
    sorts: [rawevents.unique_user_count desc]
    limit: 500
    font_size: small
    height: 2
    width: 4

  - name: arpu
    title: ARPU
    type: single_value
    model: mparticle_looker_blocks
    explore: rawevents
    measures: [rawevents.arpu]
    listen:
      date: rawevents.event_date
      platform: rawevents.platform
      is_debug_data: rawevents.is_debug
    sorts: [rawevents.arpu desc]
    limit: 500
    font_size: small
    height: 2
    width: 4


  - name: Revenue by Attribution Source
    title: Revenue by Attribution Source
    listen:
      date: rawevents.event_date
      platform: rawevents.platform
      is_debug_data: rawevents.is_debug
    type: looker_column
    model: mparticle_looker_blocks
    explore: rawevents
    dimensions: [rawevents.attribution_publisher_name]
    measures: [rawevents.revenue, rawevents.arpu]
    sorts: [rawevents.revenue desc]
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axis_combined: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    point_style: circle
    interpolation: linear
    show_null_points: true
    x_axis_label: Attribution Source
    y_axis_labels: [Total Revenue, ARPU]
    y_axis_value_format: $#,##0.00
    series_types:
      rawevents.arpu: line
    series_labels:
      rawevents.arpu: ARPU
      rawevents.revenue: Total Revenue
    y_axis_orientation: [left, right]

  - name: Revenue by Hour of Day
    title: Revenue by Hour of Day
    listen:
      date: rawevents.event_date
      platform: rawevents.platform
      is_debug_data: rawevents.is_debug
    type: looker_column
    model: mparticle_looker_blocks
    explore: rawevents
    dimensions: [rawevents.hour]
    measures: [rawevents.revenue, rawevents.arpu]
    sorts: [rawevents.hour]
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axis_combined: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    point_style: circle
    interpolation: linear
    show_null_points: true
    x_axis_label: Hour of Day
    y_axis_labels: [Total Revenue, ARPU]
    y_axis_value_format: $#,##0.00
    series_types:
      rawevents.arpu: line
    series_labels:
      rawevents.arpu: ARPU
      rawevents.revenue: Total Revenue
    y_axis_orientation: [left, right]

  - name: Revenue & ARPU by Day
    title: Revenue & ARPU by Day
    listen:
      date: rawevents.event_date
      platform: rawevents.platform
      is_debug_data: rawevents.is_debug
    type: looker_column
    model: mparticle_looker_blocks
    explore: rawevents
    dimensions: [rawevents.event_date]
    measures: [rawevents.revenue, rawevents.arpu]
    sorts: [rawevents.event_date]
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axis_combined: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    point_style: circle
    interpolation: linear
    show_null_points: true
    x_axis_label: Date
    y_axis_labels: [Total Revenue, ARPU]
    y_axis_value_format: $#,##0.00
    series_types:
      rawevents.arpu: line
    series_labels:
      rawevents.arpu: ARPU
      rawevents.revenue: Total Revenue
    y_axis_orientation: [left, right]

  - name: Purchase Funnel Analytics by App Platform
    title: Purchase Funnel Analytics by App Platform
    type: looker_column
    model: mparticle_looker_blocks
    explore: rawevents
    measures: [funnel.event_1_uu_count, funnel.event_2_uu_count, funnel.event_3_uu_count,
      funnel.event_4_uu_count, funnel.event_5_uu_count]
    #dimensions: [rawevents.app_name_platform]
    listen:
      date: rawevents.event_date
      event_1: rawevents.event_1
      event_2: rawevents.event_2
      event_3: rawevents.event_3
      event_4: rawevents.event_4
      event_5: rawevents.event_5
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
    #x_axis_label: App Platform
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
      funnel.event_5_uu_count: Event 5
