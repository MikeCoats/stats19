#!/bin/bash

set -euo pipefail

cat <<-EOF_MODE >> script.sql
	.mode csv
EOF_MODE

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
	local_authority_district \
	local_authority_highway \
	local_authority_ons_district \
	pedestrian_crossing_human_control \
	pedestrian_crossing_physical_facilities \
	pedestrian_location \
	pedestrian_movement \
	pedestrian_road_maintenance_worker \
	police_force \
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
	vehicle_type \
	weather_conditions; do
	cat <<-EOF_META_IMPORT >> script.sql
		.import ./data/${meta}.csv ${meta}
	EOF_META_IMPORT
done

for year in $(seq 2018 2022); do
	for table in collision vehicle casualty; do
		cat <<-EOF_DATA_IMPORT  >> script.sql
			.import ./data/${table}-${year}.csv ${table}
		EOF_DATA_IMPORT
	done
done

cat <<-EOF_END >>script.sql
	vacuum main into './stats19.db';
EOF_END

sqlite3 ':memory:' <script.sql || true
