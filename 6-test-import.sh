#!/bin/bash

set -euo pipefail

echo "TAP version 14"
echo "1..55"

for data in casualty collision vehicle; do

	data_csv=$(cat "./data/${data}-"*.csv | wc -l)
	data_sql=$(sqlite3 stats19.db <<<"select count(1) from ${data};")
	[[ "${data_csv}" == "${data_sql}" ]] && echo "ok" || echo "not ok - ${data}"

done

for meta in accident_severity \
	age_band_of_casualty \
	age_band_of_driver \
	bus_or_coach_passenger \
	car_passenger \
	carriageway_hazards \
	casualty_class \
	casualty_home_area_type \
	casualty_imd_decile \
	casualty_severity \
	casualty_type \
	day_of_week \
	did_police_officer_attend_scene_of_accident \
	driver_home_area_type \
	driver_imd_decile \
	first_point_of_impact \
	first_road_class \
	hit_object_in_carriageway \
	hit_object_off_carriageway \
	journey_purpose_of_driver \
	junction_control \
	junction_detail \
	junction_location \
	light_conditions \
	pedestrian_crossing_human_control \
	pedestrian_road_maintenance_worker \
	propulsion_code \
	road_surface_conditions \
	road_type \
	second_road_class \
	sex_of_casualty \
	sex_of_driver \
	skidding_and_overturning \
	special_conditions_at_site \
	towing_and_articulation \
	trunk_road_flag \
	urban_or_rural_area \
	vehicle_direction_from \
	vehicle_direction_to \
	vehicle_leaving_carriageway \
	vehicle_left_hand_drive \
	vehicle_location_restricted_lane \
	vehicle_manoeuvre \
	weather_conditions\
	local_authority_highway \
	pedestrian_crossing_physical_facilities \
	pedestrian_location \
	pedestrian_movement; do

	meta_csv=$(wc -l <"./data/${meta}.csv")
	meta_sql=$(sqlite3 stats19.db <<<"select count(1) from ${meta};")
	[[ "${meta_csv}" == "${meta_sql}" ]] && echo "ok" || echo "not ok - ${meta}"

done

for meta in police_force \
	vehicle_type \
	local_authority_district \
	local_authority_ons_district; do

	meta_csv=$(wc -l <"./data/${meta}.csv")
	meta_sql=$(sqlite3 stats19.db <<<"select count(1) from ${meta};")
	[[ "${meta_csv}" == "${meta_sql}" ]] && echo "ok" || echo "not ok - ${meta} #skip"

done
