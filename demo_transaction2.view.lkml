view: demo_transaction2 {
  sql_table_name: `Looker_Demo_retail.transaction_detail` ;;
  dimension_group: transaction_timestamp {
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
  dimension: created_weekend {
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
    drill_fields: [sales_detail*]
  }
  dimension: channel_id {
    type: string
    sql: ${TABLE}.channel_id ;;
    drill_fields: [sales_detail*]
  }
  measure: count {
    type: count
  }
  set: sales_detail {
    fields: [transaction_id, demo_channel.name, demo_production.name,demo_transaction.sale_price]
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
