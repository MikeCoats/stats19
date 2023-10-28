#!/bin/bash

set -euo pipefail

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
	sqlite3 stats19.sqlite <<-EOF_META
		drop table if exists ${meta};
		create table ${meta} (
			id          integer primary key,
			description text    not null
		);
	EOF_META
done

for meta in local_authority_highway local_authority_ons_district; do
	sqlite3 stats19.sqlite <<-EOF_META_TEXT
		drop table if exists ${meta};
		create table ${meta} (
			id          text primary key,
			description text    not null
		);
	EOF_META_TEXT
done

for table in collision vehicle casualty; do
	sqlite3 ./stats19.sqlite <"./schemas/${table}.sql"
done



