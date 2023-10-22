	drop table if exists casualty;
	create table casualty (
		accident_index                      text    not null references collision (accident_index),
		accident_year                       integer not null,
		accident_reference                  text    not null,
		vehicle_reference                   integer not null,
		casualty_reference                  integer not null,
		casualty_class                      integer not null references casualty_class (id),
		sex_of_casualty                     integer not null references sex_of_casualty (id),
		age_of_casualty                     integer not null,
		age_band_of_casualty                integer not null references age_band_of_casualty (id),
		casualty_severity                   integer not null references casualty_severity (id),
		pedestrian_location                 integer not null references pedestrian_location (id),
		pedestrian_movement                 integer not null references pedestrian_movement (id),
		car_passenger                       integer not null references car_passenger (id),
		bus_or_coach_passenger              integer not null references bus_or_coach_passenger (id),
		pedestrian_road_maintenance_worker  integer not null references pedestrian_road_maintenance_worker (id),
		casualty_type                       integer not null references casualty_type (id),
		casualty_home_area_type             integer not null references casualty_home_area_type (id),
		casualty_imd_decile                 integer not null references casualty_imd_decile (id),
		lsoa_of_casualty                    text    not null,

		primary key (accident_index, casualty_reference),
		foreign key (accident_index, vehicle_reference) references vehicle (accident_index, vehicle_reference)
	);