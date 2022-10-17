connection: "looker_demo_noah"

include: "*.view.lkml"                # include all views in the views/ folder in this project

explore: demo_channel {
  group_label: "load_complete Trial"
  label: "채널 정보"
}

explore: demo_production{
  group_label: "load_complete Trial"
  label: "제품 정보"
}

explore: demo_transaction {
  group_label: "load_complete Trial"
  label: "거래 내역"
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
