create table citzen(
    nid INT,
    name VARCHAR2(100),
    dob DATE,
    occupation VARCHAR2(50),
    blood_group VARCHAR2(3),
    division_name VARCHAR2(100),
    district_name VARCHAR2(100),
    license_id INT NULL
    CONSTRAINT pk_nid primary key (nid)
    CONSTRAINT fk_division FOREIGN KEY(division_name) references Division(name)
    CONSTRAINT fk_district FOREIGN KEY(district_name) references District(name)
    CONSTRAINT fk_division FOREIGN KEY(license_id) references License(license_id)
);


create table License(
    license_id INT,
    type VARCHAR2(20),
    issue_date DATE,
    exp_date DATE

    CONSTRAINT pk_license_id primary key (license_id)
);


create table Division(
    name VARCHAR2(100),
    size INT,
    description VARCHAR2(2000)

    constraint pk_div_name primary key (name)
);

create table district(
    name VARCHAR2(100),
    size INT,
    description VARCHAR2(2000),
    division_name VARCHAR2(100)

    CONSTRAINT pk_dis_name primary key(name)
    CONSTRAINT fk_div_name foreign key (division_name) references Division(name)
);


create table central_system(
    occurence_id VARCHAR2(20),
    date_time_accident DATE,
    LOCATION VARCHAR2(100),
    number_deaths INT NULL,
    license_id INT
    CONSTRAINT pk_occ_id primary key (occurence_id)
    CONSTRAINT fk_license_id foreign key(license_id) references License(license_id)

);

CREATE TABLE Admission(
    admission_id VARCHAR2(20),
    dateofadmission DATE,
    description VARCHAR2(2000),
    release_date DATE,
    nid INT,
    hospital_id INT

    CONSTRAINT pk_admission_id primary key(admission_id)
    CONSTRAINT fk_nid foreign key (nid) references Citizen(nid)
    CONSTRAINT fk_hospital_id FOREIGN KEY (hospital_id) references Hospital(hospital_reg_id)
);

create or replace TYPE vcontact AS VARRAY(10) OF VARCHAR2(11);


create table Hospital(
    hospital_reg_id INT,
    name VARCHAR2(100),
    contact_number vcontact

    CONSTRAINT pk_hospital_id PRIMARY key (hospital_reg_id)    

);