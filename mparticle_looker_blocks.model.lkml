connection: "qa_redshift"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: rawevents {
  sql_always_where: rawevents.eventtimestamp - coalesce(rawevents.firstseentimestamp, 0) >= 0 ;;

  join: users {
    sql_on: ${rawevents.mparticle_user_id} = ${users.mparticle_user_id} ;;
    relationship: many_to_one
  }
}
