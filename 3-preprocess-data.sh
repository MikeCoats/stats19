#!/bin/bash

for year in $(seq 2018 2022); do
	for table in collision vehicle casualty; do
		echo "Preprocessing $year $table data..."
		tail -n +2 "./tmp/$table-$year.csv" >"./data/$table-$year.csv"
	done
done

echo "Preprocessing metadata..."
xlsx2csv ./tmp/metadata.xlsx ./tmp/metadata.csv

for meta in accident_severity \
	police_force \
	day_of_week \
	first_road_class \
	road_type \
	junction_detail \
	junction_control \
	second_road_class \
	pedestrian_crossing_human_control \
	light_conditions \
	weather_conditions \
	road_surface_conditions \
	special_conditions_at_site \
	carriageway_hazards \
	urban_or_rural_area \
	did_police_officer_attend_scene_of_accident \
	trunk_road_flag \
	vehicle_type \
	towing_and_articulation \
	vehicle_manoeuvre \
	vehicle_direction_from \
	vehicle_direction_to \
	vehicle_location_restricted_lane \
	junction_location \
	skidding_and_overturning \
	hit_object_in_carriageway \
	vehicle_leaving_carriageway \
	hit_object_off_carriageway \
	first_point_of_impact \
	vehicle_left_hand_drive \
	journey_purpose_of_driver \
	sex_of_driver \
	age_band_of_driver \
	propulsion_code \
	driver_imd_decile \
	driver_home_area_type \
	casualty_class \
	sex_of_casualty \
	age_band_of_casualty \
	casualty_severity \
	car_passenger \
	bus_or_coach_passenger \
	pedestrian_road_maintenance_worker \
	casualty_type \
	casualty_imd_decile \
	casualty_home_area_type; do
	echo "Preprocessing $meta metadata..."
	grep ",$meta," ./tmp/metadata.csv | cut -d',' -f3-4 >"./data/$meta.csv"
done

for meta in local_authority_district \
	pedestrian_crossing_physical_facilities \
	pedestrian_location \
	pedestrian_movement \
	local_authority_ons_district \
	local_authority_highway; do
	echo "Preprocessing $meta metadata..."
	grep ",$meta," ./tmp/metadata.csv | cut -d',' -f3- | sed 's/,*$//g' | sed 's/\"//g' >"./data/$meta.csv"
done
