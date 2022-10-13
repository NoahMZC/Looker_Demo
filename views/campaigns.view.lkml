view: campaigns {
  sql_table_name: `Looker_Demo_ecomm.campaigns`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: advertising_channel {
    label: "영문/채널 종류"
    group_label: "채널"
    type: string
    sql: ${TABLE}.advertising_channel ;;
  }

  dimension: channel {
    label: "국문/채널 종류"
    group_label: "채널"
    type: string
    sql: CASE
      WHEN ${advertising_channel} = 'Video' then '비디오'
      WHEN ${advertising_channel} = 'Search' then '검색'
      WHEN ${advertising_channel} = 'Display' then '디스플레이'
    END;;
    #drill_fields: [bid_type, campaign_name, created_date]
    drill_fields: [user_details*]
  }


  dimension: channel2 {
    label: "국문+아이콘/채널 종류"
    group_label: "채널"
    type: string
    sql: ${TABLE}.advertising_channel ;;
    html: {% if value == 'Video' %}
    <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% elsif value == 'Search' %}
    <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% else %}
    <p style="color: black; background-color: orange; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% endif %}
    ;;
  }

  measure: amount {
    label: "계"
    type: sum
    sql: ${TABLE}.amount ;;
    drill_fields: [user_details*]
  }

  set: user_details {
    fields: [id, bid_type, campaign_name, created_date]
  }

  dimension: bid_type {
    type: string
    sql: ${TABLE}.bid_type ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.created_at ;;
  }

  dimension: create_date {
    type: string
    sql: cast(EXTRACT(year from ${TABLE}.created_at) as string) || '년 '
         ||  cast(EXTRACT(month from ${TABLE}.created_at) as string) || '월';;
  }

  dimension: created_weekend {
    type: string
    sql: DATE_TRUNC(campaigns.created_at, WEEK(SUNDAY))
       ||"~"||
        DATE_ADD((DATE_TRUNC(campaigns.created_at, WEEK(SUNDAY))),interval 6 day)
         || " (" || EXTRACT(WEEK FROM campaigns.created_at)||"주)";;
  }
##ㅈㄷ
  dimension_group: last_date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: DATE_SUB(${TABLE}.created_at, INTERVAL 1 Month)  ;;
  }

  dimension: period {
    type: string
    sql: ${TABLE}.period ;;
  }

  measure: count {
    type: count
    drill_fields: [id, campaign_name, ad_groups.count]
  }
}
