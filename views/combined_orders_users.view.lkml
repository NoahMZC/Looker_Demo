view: combined_orders_users {
  sql_table_name: `Looker_Demo_ecomm.combined_orders_users`
    ;;

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [users.last_name, users.id, users.first_name]
  }
}
