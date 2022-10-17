connection: "looker_demo_noah"

include: "*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard
# explore: demo_transaction2 {
#   join: demo_transaction {
#     type: inner
#     sql_on: ${demo_transaction.transaction_id} = ${demo_transaction2.transaction_id} ;;
#     relationship: one_to_one
#   }
#   join: demo_production {
#     type: full_outer
#     sql_on: ${demo_transaction.product_id} = ${demo_production.id} ;;
#     relationship: many_to_one
#   }
#   join: demo_channel {
#     type: full_outer
#     sql_on: ${demo_transaction2.channel_id} = ${demo_channel.id};;
#     relationship: many_to_one
#   }
# }
explore: demo_channel {}

explore: demo_production{}

explore: demo_transaction {
  join: demo_production {
    type: full_outer
    sql_on: ${demo_transaction.product_id} = ${demo_production.id} ;;
    relationship: many_to_one
  }
  join: demo_channel {
    type: full_outer
    sql_on: ${demo_transaction.channel_id} = ${demo_channel.id};;
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
