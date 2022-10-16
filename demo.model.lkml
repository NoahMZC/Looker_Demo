connection: "looker_demo_noah"

include: "*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard
explore: demo_transaction {
  join: demo_production {
    type: left_outer
    sql_on: ${demo_transaction.product_id} = ${demo_production.id} ;;
    relationship: many_to_one
  }
  join: demo_channel {
    type: left_outer
    sql_on: ${demo_transaction.product_id} = ${demo_channel.id};;
    relationship: many_to_one
  }
}

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
