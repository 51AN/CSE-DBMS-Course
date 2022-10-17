create table branch(
    branch_id varchar2(10),
    location varchar2(30),
    year_est DATE,
    nid varchar2(17)

    constraint pk_branch primary key (branch_id)
    constraint fk_nid FOREIGN KEY (nid) references employee(nid)
)

create table employee(
    nid varchar2(17),
    name varchar2(30),
    blood_group varchar2(3),
    dob DATE,
    type varchar2(10)

    Constraint pk_employee primary key (nid)
    CONSTRAINT uc_nid unique(nid)
    CONSTRAINT fk_etypes FOREIGN KEY (type) REFERENCES etypes(type)
)

create table etypes(
    type VARCHAR2(10),
    base_salary NUMBER,
    h_allowance NUMBER

    constraint pk_type primary key (type)

)

create table book_branch(
    branch_id varchar2(10),
    ISBN varchar2(20) 

    constraint primary key (branch_id, ISBN)

    constraint fk_branch_id FOREIGN KEY (branch_id) REFERENCES branch(BRANCH_ID)
    constraint fk_ISBN FOREIGN KEY (ISBN) REFERENCES book(ISBN)

    


)

create table book(
    ISBN VARCHAR2(13),
    name varchar2(20),
    author varchar2(20),
    genre varchar2(20),
    price NUMBER


    constraint pk_book primary key (ISBN)
    constraint uc_ISBM unique (ISBN)
    
)

create table publisher(
    name varchar2(30),
    city varchar2(20),
    est_year varchar2(4),
    ISBN varchar2(13)
    constraint pk_publisher primary key (name, city)
    constraint fk_ISBN FOREIGN KEY (ISBN) REFERENCES book(ISBN)
)

create table user(
    username varchar2(20),
    name varchar2(30),
    dob date,
    hometown varchar2(20),
    occupation varchar2(20)

    constraint pk_user primary key (username)
    constraint uc_username unique (username)
)

create table issue(
    date_issue date,
    duration number default 15,
    username varchar2(20) references user(username),
    ISBN varchar2(13) references book(ISBN),
    nid varchar2(17) references employee(nid)

    constraint fk_user FOREIGN KEY (username) references user(username)
    constraint fk_ISBN FOREIGN KEY (ISBN) references book(ISBN)
    constraint fk_NID FOREIGN KEY (nid) references employee(nid)

)


create table shift(
    start_time time,
    duration number,
    branch_id varchar2(10)

    CONSTRAINT pk_start_time primary key (start_time)
    constraint fk_branch_id FOREIGN KEY (branch_id) REFERENCES branch(BRANCH_ID)
)

create table shift_emp(
    NID varchar2(17) references employee(NID),
    start_time time references shift(start_time)

    constraint pk_NID_start_time primary key (NID, start_time)

    constraint fk_NID FOREIGN KEY (NID) REFERENCES employee(NID)
    constraint fk_start_time FOREIGN KEY (start_time) REFERENCES shift(start_time)

)
