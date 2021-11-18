connection: "se_redshift"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: otherevents {
  sql_always_where: otherevents.eventtimestamp - coalesce(otherevents.firstseentimestamp, 0) >= 0 ;;

  join: users {
    sql_on: ${otherevents.mparticle_user_id} = ${users.mparticle_user_id} ;;
    relationship: many_to_one
  }
}
