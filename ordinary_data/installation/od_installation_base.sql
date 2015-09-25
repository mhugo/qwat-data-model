/*
	qWat - QGIS Water Module

	SQL file :: base table for installations
*/

/* CREATE TABLE */
CREATE TABLE qwat_od.installation (id serial PRIMARY KEY);
COMMENT ON TABLE qwat_od.installation IS 'This is the base table for all installation types.';

/* COLUMNS */
ALTER TABLE qwat_od.installation ADD COLUMN name               varchar(60)      ;
ALTER TABLE qwat_od.installation ADD COLUMN identification     varchar(25)      ;
ALTER TABLE qwat_od.installation ADD COLUMN fk_parent          integer          ;
ALTER TABLE qwat_od.installation ADD COLUMN fk_status          integer not null ;
ALTER TABLE qwat_od.installation ADD COLUMN fk_distributor     integer not null ;
ALTER TABLE qwat_od.installation ADD COLUMN fk_remote          integer          ;
ALTER TABLE qwat_od.installation ADD COLUMN fk_watertype       integer not null ;
ALTER TABLE qwat_od.installation ADD COLUMN fk_locationtype    integer[]	    ;
ALTER TABLE qwat_od.installation ADD COLUMN fk_precisionalti   integer          ;
ALTER TABLE qwat_od.installation ADD COLUMN fk_object_reference integer not null;
ALTER TABLE qwat_od.installation ADD COLUMN year               smallint    CHECK (year IS NULL OR year > 1800 AND year < 2100);
ALTER TABLE qwat_od.installation ADD COLUMN year_end           smallint    CHECK (year_end IS NULL OR year > 1800 AND year < 2100);
ALTER TABLE qwat_od.installation ADD COLUMN parcel             varchar(30)  ;
ALTER TABLE qwat_od.installation ADD COLUMN eca                varchar(30)  ;
ALTER TABLE qwat_od.installation ADD COLUMN remark             text         ;
ALTER TABLE qwat_od.installation ADD COLUMN open_water_surface boolean     default false  ;

/* GEOMETRY */
/* POINT                              ( table_name,       srid, is_node, create_node, create_schematic, get_pipe, auto_district, auto_pressurezone)*/
-- SELECT qwat_od.fn_geom_tool_point('installation', :SRID,true,    true,        true,             false ,    true         , false);
/* POLYGON */
ALTER TABLE qwat_od.installation ADD COLUMN geometry_polygon geometry('MULTIPOLYGON',:SRID);
CREATE INDEX installation_poly_geoidx ON qwat_od.installation USING GIST ( geometry_polygon );

/* LABELS */
-- SELECT qwat_od.fn_label_create_fields('installation');


/* CONSTRAINTS AND INDEXES */
ALTER TABLE qwat_od.installation ADD CONSTRAINT installation_fk_parent           FOREIGN KEY (fk_parent)           REFERENCES qwat_od.installation(id)     MATCH FULL; CREATE INDEX fki_installation_fk_parent           ON qwat_od.installation(fk_parent)          ;
ALTER TABLE qwat_od.installation ADD CONSTRAINT installation_fk_status           FOREIGN KEY (fk_status)           REFERENCES qwat_vl.status(id)           MATCH FULL; CREATE INDEX fki_installation_fk_status           ON qwat_od.installation(fk_status)          ;
ALTER TABLE qwat_od.installation ADD CONSTRAINT installation_fk_distributor      FOREIGN KEY (fk_distributor)      REFERENCES qwat_od.distributor(id)      MATCH FULL; CREATE INDEX fki_installation_fk_distributor      ON qwat_od.installation(fk_distributor)     ;
ALTER TABLE qwat_od.installation ADD CONSTRAINT installation_fk_remote           FOREIGN KEY (fk_remote)           REFERENCES qwat_vl.remote_type(id)      MATCH FULL; CREATE INDEX fki_installation_fk_remote           ON qwat_od.installation(fk_remote)          ;
ALTER TABLE qwat_od.installation ADD CONSTRAINT installation_fk_watertype        FOREIGN KEY (fk_watertype)        REFERENCES qwat_vl.watertype(id)        MATCH FULL; CREATE INDEX fki_installation_watertype           ON qwat_od.installation(fk_watertype)       ;
ALTER TABLE qwat_od.installation ADD CONSTRAINT installation_fk_precisionalti    FOREIGN KEY (fk_precisionalti)    REFERENCES qwat_vl.precisionalti(id)    MATCH FULL; CREATE INDEX fki_installation_fk_precisionalti    ON qwat_od.installation(fk_precisionalti)   ;
ALTER TABLE qwat_od.installation ADD CONSTRAINT installation_fk_object_reference FOREIGN KEY (fk_object_reference) REFERENCES qwat_vl.object_reference(id) MATCH FULL; CREATE INDEX fki_installation_fk_object_reference ON qwat_od.installation(fk_object_reference);


