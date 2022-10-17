view: demo_transaction {
  derived_table: {
    sql:
      SELECT
        transaction_timestamp
       ,transaction_id
       ,channel_id
       ,product_id
       ,sale_price
       ,gross_margin
      FROM
        `looker-private-demo.retail.transaction_detail`
       ,UNNEST(line_items);;
  }
  dimension_group: transaction_timestamp {
    group_label: "시점"
    label: "거래 일시"
    type: time
    timeframes: [
      time,
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: timestamp
    sql: ${TABLE}.transaction_timestamp  ;;
  }
  dimension: transaction_weekend{
    group_label: "시점"
    label: "거래 주차"
    type: string
    sql: DATE_TRUNC(extract(DATE from transaction_timestamp), WEEK(SUNDAY))
       ||"~"||
        DATE_ADD((DATE_TRUNC(extract(DATE from transaction_timestamp), WEEK(SUNDAY))),interval 6 day)
         || " (" || EXTRACT(WEEK FROM transaction_timestamp)||"주)";;
  }

  dimension: transaction_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.transaction_id ;;
  }

  dimension: product_id {
    hidden: yes
    type: string
    sql: ${TABLE}.product_id ;;
    drill_fields: [sales_detail*]
  }
  dimension: channel_id {
    hidden: yes
    type: string
    sql: ${TABLE}.channel_id ;;
    drill_fields: [sales_detail*]
  }
  measure: sale_price {
    label: "판매액"
    type: sum
    sql: ${TABLE}.sale_price ;;
    value_format: "$0.00"
    drill_fields: [sales_detail*]
  }
  measure: gross_margin {
    label: "매출 총 이익"
    type: sum
    sql: ${TABLE}.gross_margin ;;
    value_format: "$0.00"
    drill_fields: [sales_detail*]
  }
  measure: count {
    type: count
    drill_fields: [sales_detail*]
  }
  set: sales_detail {
    fields: [demo_production.name, count]
  }
  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: demo_transaction {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
