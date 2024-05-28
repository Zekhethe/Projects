USE Master

--Please create the following folders for the database to work properly
--C:\DBD281_Project_Clapham

--Section A - Database Creation
CREATE DATABASE ClaphamHigh
ON 
(Name = ClaphamHighDataFile1,
 FILENAME = 'C:\DBD281_Project_Clapham\ClaphamHighDataFile1.mdf',
 SIZE = 2MB,
 MAXSIZE = UNLIMITED,
 FILEGROWTH = 2MB)

LOG ON
(NAME = ClaphamHighLogFile1,
 FILENAME = 'C:\DBD281_Project_Clapham\ClaphamHighLogFile1.ldf',
 SIZE = 2MB,
 MAXSIZE = 500MB,
 FILEGROWTH = 2MB)
 GO

 --Section B - Table Creation

USE ClaphamHigh
GO

CREATE TABLE Teacher
(TeacherNum						INT				IDENTITY(1000,1)		PRIMARY KEY,
 TeacherFirstName				VARCHAR(40)		NOT NULL,
 TeacherMiddleNames				VARCHAR(100),
 TeacherLastName				VARCHAR(40)		NOT NULL,
 TeacherIDNum					CHAR(13)		NOT NULL,
 TeacherGender					VARCHAR(6)		NOT NULL,
 CONSTRAINT check_gender_teacher
	CHECK (TeacherGender = 'Male' OR TeacherGender = 'Female'),
 TeacherAge						INT				NOT NULL,
 TeacherContactAddress			VARCHAR(255)			NOT NULL,
 TeacherEmail					VARCHAR(30)		NOT NULL				UNIQUE,
 TeacherClassRoom				VARCHAR(5)		NOT NULL				UNIQUE)
 GO

 CREATE TABLE Course
 (CourseID						INT				IDENTITY(1,1)			PRIMARY KEY,
  CourseName					VARCHAR(30)		NOT NULL,
  CourseDescription				VARCHAR(255)	NOT NULL,
  CourseTuitionFee				MONEY			NOT NULL)
GO

CREATE TABLE [Subject]
(SubjectCode					CHAR(5)			PRIMARY KEY,
 SubjectName					VARCHAR(30)		NOT NULL)
GO

 CREATE TABLE SubjectTeacher
 (TeacherNum					INT				REFERENCES Teacher(TeacherNum),
  SubjectCode					CHAR(5)			REFERENCES [Subject](SubjectCode))
GO

CREATE TABLE Student
(StudentNumber					INT				IDENTITY(10300,1)		PRIMARY KEY,
 StudentFirstName				VARCHAR(40)		NOT NULL,
 StudentMiddleNames				VARCHAR(100),
 StudentLastName				VARCHAR(40)		NOT NULL,
 StudentIDNum					CHAR(13)		NOT NULL,
 StudentGender					VARCHAR(6)		NOT NULL,
 CONSTRAINT check_gender_student
	CHECK (StudentGender = 'Male' OR StudentGender = 'Female'),
 StudentAge						INT				NOT NULL,
 StudentContactAddress			VARCHAR(255)	NOT NULL,
 StudentEmail					VARCHAR(30)		UNIQUE,
 StudentGrade					INT				NOT NULL,
 CONSTRAINT check_grade
	CHECK (StudentGrade BETWEEN 8 AND 12),
 DateEnrolled					DATE			DEFAULT(getdate())		NOT NULL,
 CourseID						INT				REFERENCES Course(CourseID),
 StudentTuitionFeesPaid			MONEY			NOT NULL,
 StudentTuitionFeesPaidDate		DATETIME		NOT NULL)
GO

CREATE TABLE StudentSubject
(StudentNumber					INT				REFERENCES Student(StudentNumber),
 SubjectCode					CHAR(5)			REFERENCES [Subject](SubjectCode),
 SubjectMarks					INT)
GO

--Section C - Data Input

INSERT INTO Teacher (TeacherFirstName,TeacherMiddleNames,TeacherLastName,TeacherIDNum,TeacherGender,TeacherAge,TeacherContactAddress,TeacherEmail,TeacherClassRoom)
VALUES ('Valdemar',		'Stévina Eric',		'Cabena',	9102266990188, 'Male',		32,	'144, Milner Avenue; Montroux, Johannesburg; City of Johannesburg Metropolitan Municipality; Gauteng; 2001; South Africa',					'vcabena.thetimes.co.uk',	'ENG21'),
       ('Adore',		NULL,				'Ortler',	9511073205087, 'Female',	28, 'Berriman Household, 20, Thornhill Road; Antwerp, Sandton; City of Johannesburg Metropolitan Municipality; Gauteng; 1609; South Africa',		'aortler@unblog.fr',		'AFR32'),
       ('Elizabet',		'Eléonore',			'Raccio',	9504012861185, 'Female',	28, '424B, Phiriphiri Street; Meadowlands West, Soweto; City of Johannesburg Metropolitan Municipality; Gauteng; 1852; South Africa',			'eraccio@zdnet.com',		'MAT76'),
       ('Bale',			NULL,				'Marcus',	7907207046185, 'Male',		43, '49, Denise Road; Johannesburg Ward 32, Sandton; City of Johannesburg Metropolitan Municipality; Gauteng; 2052; South Africa',				'bmarcus@vinaora.com',		'EGO98'),
       ('Trudie',		'Bérangèr',			'Kohlert',	8010200751081, 'Female',	42, '49, Crossberry Crescent; Johannesburg Ward 32, Sandton; City of Johannesburg Metropolitan Municipality; Gauteng; 1620; South Africa',			'tkohlert@bbc.co.uk',		'BIO75'),
       ('Nelie',		'Faîtes',			'Muzzillo', 7201170889189, 'Female',	51, '17, Appaloosa Avenue; City of Johannesburg Metropolitan Municipality; Gauteng; 1683; South Africa',											'nmuzzillo@delicious.com',	'ECO29'),
       ('Kelley',		'Maïly',			'Uccelli',	7609093082189, 'Female',	46, '144, Milner Avenue; Montroux, Johannesburg; City of Johannesburg Metropolitan Municipality; Gauteng; 2001; South Africa',						'kuccelli@buzzfeed.com',	'PHY96'),
       ('Vincents',		NULL,				'Walley',	7912159142081, 'Male',		43, '17, Park Royal Road; City of Johannesburg Metropolitan Municipality; Gauteng; 2086; South Africa',											'vwalley@senate.gov',		'TRM10'),
       ('Rita',			'Uò',				'Riddell',	6912060795085, 'Female',	54, '301, Forbes Road; Johannesburg Ward 43, Soweto; City of Johannesburg Metropolitan Municipality ;Gauteng; Postcode: 1863; South Africa',	'rriddell@discovery.com',	'ACC92'),
       ('Harvey',		NULL,				'Tarplee',	8104128175082, 'Male',		41, '365, Ontdekkers Road; Constantia Kloof, Roodepoort; City of Johannesburg Metropolitan Municipality; Gauteng; 1709; South Africa',				'htarplee@blogger.com',		'ENG48')
GO

INSERT INTO dbo.Course(CourseName,CourseDescription,CourseTuitionFee)
VALUES ('Training',				'Raynor, Koch and Schmitt',			86921),
       ('Business Development', 'Balistreri-Jacobson',				64970),
       ('Marketing',			'Botsford, Emmerich and Wiegand',		80938),
       ('Marketing',			'Nikolaus-Jones',						67120),
       ('Engineering',			'Ratke LLC',						89105),
       ('Sales',				'DuBuque LLC',							80321),
       ('Legal',				'Stiedemann-Jenkins',					60525),
       ('Product Management',	'Mann Group',							78771),
       ('Sales',				'Kshlerin and Sons',					71503),
       ('Human Resources',		'Romaguera, Watsica and Koss',		84831)
GO

INSERT INTO dbo.Subject (SubjectCode,SubjectName)
VALUES	('AFR81', 'AfrikaansGrade8'),
		('ENG81', 'EnglishGrade8'),
		('MAT81', 'MathGrade8'),
		('SCN81', 'ScienceGrade8'),
		('AFR91', 'AfrikaansGrade9'),
		('ENG91', 'EnglishGrade9'),
		('MAT91', 'MathGrade9'),
		('SCN91', 'ScienceGrade9'),
		('AFR10', 'AfrikaansGrade10'),
		('ENG10', 'EnglishGrade10'),
		('MAT10', 'MathGrade10'),
		('BIO10', 'BiologyGrade10'),
		('INT10', 'InformationTechnologyGrade10'),
		('ACC10', 'AccountingGrade10'),
		('PHY10', 'PhysicsGrade10'),
		('ECO10', 'EconomicsGrade10')
GO

INSERT INTO SubjectTeacher
VALUES	(1000, 'ENG81'),
		(1000, 'ENG91'),
		(1000, 'ENG10'),
		(1009, 'ENG81'),
		(1009, 'ENG91'),
		(1009, 'ENG10'),
		(1001, 'AFR81'),
		(1001, 'AFR91'),
		(1001, 'AFR10'),
		(1002, 'MAT81'),
		(1002, 'MAT91'),
		(1002, 'MAT10'),
		(1003, 'BIO10'),
		(1004, 'BIO10'),
		(1005, 'ECO10'),
		(1006, 'SCN81'),
		(1006, 'SCN91'),
		(1006, 'PHY10'),
		(1007, 'INT10'),
		(1008, 'ACC10')
GO 

INSERT INTO Student (StudentFirstName, StudentMiddleNames, StudentLastName, StudentIDNum, StudentGender, StudentAge, StudentContactAddress, StudentEmail, StudentGrade, DateEnrolled, CourseID, StudentTuitionFeesPaid, StudentTuitionFeesPaidDate) 
VALUES	('Mattias',		'Kristoffer',		'Alexsandrovich',		0802069534187,		'Male',		15,	'081 Transport Park',		'kalexsandrovich0@weibo.com',		9,	'8/3/2019',		9,	'$97921.62',	'3/9/2023'),
		('Angeline',	'Rivy',				'Wetwood',				0705033158084,		'Female',	16,	'21 Talmadge Center',		'rwetwood1@zdnet.com',				10,	'9/22/2019',	10, '$60795.03',	'2/7/2023'),
		('Shani',		null,				'Soda',					0610234821086,		'Female',	16, '07 Nancy Alley',			'hsoda2@apache.org',				10,	'8/8/2022',		10, '$95225.73',	'2/26/2023'),
		('Coletta',		null,				'Roggeman',				0711081627186,		'Female',	15, '23521 Eagan Avenue',		'troggeman3@columbia.edu',			9,	'4/14/2019',	3,	'$62333.38',	'3/8/2023'),
		('Berna',		'Elena',			'Kunes',				0502040216082,		'Female',	18, '60289 Blackbird Terrace',	'ekunes4@acquirethisname.com',		12, '11/20/2019',	2,	'$73932.63',	'2/25/2023'),
		('Alasdair',	'Hillary',			'Pinyon',				0801075161084,		'Male',		15, '283 Fisk Place',			'hpinyon5@examiner.com',			8,	'6/23/2021',	3,	'$84826.68',	'2/15/2023'),
		('Jarad',		null,				'Gealle',				0410279183082,		'Male',		18, '43 Paget Parkway',			'hgealle6@sciencedirect.com',		11, '4/23/2022',	6,	'$95387.30',	'2/18/2023'),
		('Elmore',		'Nappy',			'Iacobassi',			0704235254189,		'Male',		15, '16879 Oak Drive',			'niacobassi7@printfriendly.com',	8,	'8/2/2021',		5,	'$31142.28',	'4/4/2023'),
		('Agnese',		'Mela',				'Simmell',				0305204075082,		'Female',	19, '84 Summit Junction',		'msimmell8@businessweek.com',		12,	'5/21/2018',	9,	'$93278.92',	'3/28/2023'),
		('Corby',		null,				'Jizhaki',				0708105992083,		'Male',		15, '152 Donald Alley',			'cjizhaki9@netscape.com',			9,	'4/23/2019',	1,	'$27994.50',	'2/3/2023'),
		('Daisi',		null,				'Gibbeson',				0707302257084,		'Female',	15, '810 Village Parkway',		'mgibbesona@ezinearticles.com',		9,	'9/16/2020',	9,	'$29575.52',	'3/13/2023'),
		('Berton',		'Tabbie',			'Birth',				0304148457084,		'Male',		19, '638 Monterey Terrace',		'tbirthb@networkadvertising.org',	12, '9/19/2021',	4,	'$89558.18',	'3/17/2023'),
		('Emmeline',	null,				'Booty',				0610288718188,		'Male',		16, '5 Hermina Crossing',		'bbootyc@sbwire.com',				10,	'6/11/2019',	7,	'$55429.10',	'1/22/2023'),
		('Selestina',	'Rowe',				'Gjerde',				0508093161182,		'Female',	17, '0952 Eastwood Way',		'rgjerded@lycos.com',				11,	'12/10/2021',	10, '$81328.65',	'2/16/2023'),
		('Bernelle',	'Gretna',			'Timmins',				0604250632188,		'Female',	16, '3 Tomscot Trail',			'gtimminse@epa.gov',				10,	'1/3/2023',		8,	'$33134.04',	'3/14/2023'),
		('Bibbye',		'Shanda',			'Guichard',				0310231523187,		'Female',	19, '0 Kinsman Street',			'sguichardf@yellowpages.com',		12,	'12/23/2018',	9,	'$239.50',		'3/25/2023'),
		('Obediah',		null,				'Scholard',				0405299056086,		'Male',		18, '68762 Vidon Pass',			'cscholardg@admin.ch',				12,	'5/12/2018',	9,	'$65753.66',	'2/20/2023'),
		('Emlynn',		'Grazia',			'Jansen',				0812164924183,		'Female',	14, '06127 Vera Trail',			'gjansenh@admin.ch',				8,	'8/29/2021',	9,	'$15544.68',	'2/22/2023'),
		('Valentia',	'Cicely',			'Sargeaunt',			0810303539185,		'Female',	14, '77 Mendota Street',		'csargeaunti@eventbrite.com',		8,	'12/5/2021',	2,	'$67568.78',	'3/7/2023'),
		('Francklyn',	'Kalvin',			'Verity',				0605265554085,		'Male',		16, '8 Towne Road',				'kverityj@techcrunch.com',			10, '8/4/2022',		8,	'$75709.54',	'3/23/2023'),
		('Windham',		'Shea',				'Abbett',				0505085360186,		'Male',		17, '13430 Mccormick Street',	'sabbettk@paypal.com',				11,	'8/27/2019',	7,	'$97450.21',	'3/2/2023'),
		('Mariel',		'Margalit',			'Ruston',				0405103762085,		'Female',	18, '59237 Westport Pass',		'mrustonl@sphinn.com',				12,	'6/23/2022',	8,	'$40065.95',	'3/20/2023'),
		('Geralda',		'Pietrek',			'Friedank',				0311119193184,		'Male',		19, '0508 Susan Circle',		'pfriedankm@prweb.com',				12,	'9/20/2021',	2,	'$39119.64',	'1/10/2023'),
		('Cher',		'Grissel',			'Semaine',				0802051210085,		'Female',	15, '413 Trailsway Hill',		'gsemainen@stumbleupon.com',		9,	'8/3/2020',		8,	'$75733.99',	'4/3/2023'),
		('Sydel',		'Mariejeanne',		'Warke',				0503201750182,		'Female',	18, '7303 Dahle Street',		'mwarkeo@edublogs.org',				12,	'1/3/2020',		4,	'$49581.42',	'1/7/2023'),
		('Lane',		null,				'Comberbach',			0507091839088,		'Female',	17, '11 Florence Lane',			'ecomberbachp@ocn.ne.jp',			11, '10/15/2021',	2,	'$74196.07',	'1/6/2023'),
		('Tudor',		'Marietta',			'Cobleigh',				0602197466082,		'Male',		17, '00920 Ridgeview Crossing', 'mcobleighq@yellowpages.com',		11, '9/3/2021',		6,	'$81405.12',	'2/1/2023'),
		('Tracie',		'Lindon',			'Bowling',				0404066231089,		'Male',		19, '68 Hudson Park',			'lbowlingr@cnet.com',				12, '10/26/2019',	10, '$67083.38',	'2/3/2023'),
		('Lucho',		'Barclay',			'McCalum',				0510075783082,		'Male',		18, '3 Independence Court',		'bmccalums@chron.com',				12, '2/2/2018',		7,	'$6237.31',		'1/20/2023'),
		('Kane',		'Orville',			'Phythien',				0407189657081,		'Male',		18, '35363 Sycamore Point',		'ophythient@blogspot.com',			12,	'10/13/2020',	5,	'$71619.95',	'2/25/2023'),
		('Garwood',		'Bruce',			'Gerwood',				0401219840188,		'Male',		19, '8691 Di Loreto Trail',		'bgerwoodu@123-reg.co.uk',			12, '12/10/2019',	9,	'$64088.32',	'1/20/2023'),
		('Yevette',		'Concettina',		'Whitty',				0910062635181,		'Female',	14, '16927 Jana Avenue',		'cwhittyv@plala.or.jp',				8,	'5/5/2019',		3,	'$42400.07',	'2/11/2023'),
		('Juan',		'Gibby',			'Demsey',				0710125874085,		'Male',		15, '19 Golden Leaf Plaza',		'gdemseyw@house.gov',				10, '12/2/2018',	5,	'$63886.48',	'2/19/2023'),
		('Parnell',		'Ely',				'Lippiatt',				0502125901087,		'Male',		18, '5920 Sage Road',			'elippiattx@aboutads.info',			11, '1/7/2023',		9,	'$17210.39',	'2/14/2023'),
		('Case',		null,				'Di Frisco',			0503260790087,		'Female',	18, '68 Dawn Center',			'gdifriscoy@arizona.edu',			12,	'8/12/2020',	1,	'$53584.09',	'3/7/2023'),
		('Chrystel',	'Yvonne',			'Marples',				0912304975184,		'Female',	13, '14 Di Loreto Alley',		'ymarplesz@163.com',				8,	'8/10/2022',	10, '$95401.22',	'3/11/2023'),
		('Olivier',		'Darrick',			'Abdey',				0509027262088,		'Male',		18, '59 Helena Crossing',		'dabdey10@shinystat.com',			12, '9/20/2021',	6,	'$10879.52',	'1/16/2023'),
		('Stanton',		null,				'Shepperd',				0803225550182,		'Male',		15, '08025 Fallview Court',		'bshepperd11@ucla.edu',				9,	'12/21/2018',	7,	'$44349.43',	'4/3/2023'),
		('David',		'Ira',				'Irce',					0305186383181,		'Male',		19, '41 Iowa Alley',			'iirce12@dot.gov',					12, '8/25/2022',	7,	'$82498.60',	'1/18/2023'),
		('Issy',		'Beryl',			'Labram',				0406074885186,		'Female',	19, '0 Melody Alley',			'blabram13@tiny.cc',				12, '10/1/2021',	5,	'$12109.13',	'1/23/2023'),
		('Nonie',		'Flo',				'Southcombe',			0711020181089,		'Female',	16, '0175 Dexter Street',		'fsouthcombe14@zimbio.com',			10,	'6/26/2019',	8,	'$47865.60',	'1/5/2023'),
		('Averell',		'Kane',				'Adger',				0808217668082,		'Male',		14, '9037 Melrose Road',		'kadger15@oracle.com',				8,	'2/25/2019',	10, '$1334.34',		'1/18/2023'),
		('Romola',		'Ursala',			'Greenmon',				1001234802087,		'Female',	13, '574 Superior Alley',		'ugreenmon16@umich.edu',			8,	'3/21/2020',	8,	'$8423.41',		'1/24/2023'),
		('Lusa',		'Reuben',			'Dansie',				0608255919185,		'Male',		16, '98 School Drive',			'rdansie17@mail.ru',				10, '10/29/2018',	9,	'$30972.46',	'1/8/2023'),
		('Fiona',		'Bellanca',			'Gerlack',				0806181815184,		'Female',	14, '1744 Erie Point',			'bgerlack18@techcrunch.com',		8,	'3/23/2019',	3,	'$29163.37',	'3/15/2023'),
		('Delia',		'Kaja',				'Brooking',				0502202257189,		'Female',	18, '7049 Daystar Junction',	'kbrooking19@live.com',				12, '10/1/2021',	5,	'$3857.49',		'1/25/2023'),
		('Salvatore',	'Eddy',				'Snel',					0903278786186,		'Male',		14, '248 Village Green Center', 'esnel1a@prlog.org',				8,	'8/16/2021',	5,	'$81524.72',	'3/31/2023'),
		('Edgar',		null,				'Pods',					0802258460087,		'Male',		15, '96643 Eagan Plaza',		'kpods1b@yahoo.co.jp',				9,	'7/4/2021',		4,	'$62469.36',	'2/25/2023'),
		('Ottilie',		'Lynnett',			'Faloon',				0805234638081,		'Female',	14, '51577 Sheridan Junction',	'lfaloon1c@zdnet.com',				8,	'2/8/2020',		4,	'$33567.11',	'4/2/2023'),
		('Gilles',		'Lothaire',			'Pounds',				0612289052187,		'Male',		16, '54851 Corben Trail',		'lpounds1d@ed.gov',					10, '9/30/2018',	9,	'$63323.76',	'2/16/2023')
GO

INSERT INTO StudentSubject 
VALUES	(10322, 'PHY10', 79),
		(10345, 'ENG91', 53),
		(10345, 'ENG91', 79),
		(10305, 'ENG81', 38),
		(10333, 'BIO10', 83),
		(10302, 'ENG81', 33),
		(10302, 'ENG81', 59),
		(10344, 'ACC10', 93),
		(10335, 'SCN91', 72),
		(10340, 'ECO10', 45),
		(10313, 'PHY10', 71),
		(10344, 'ACC10', 96),
		(10300, 'ENG91', 94),
		(10310, 'MAT81', 100),
		(10328, 'AFR10', 95),
		(10305, 'ENG81', 51),
		(10335, 'SCN91', 72),
		(10307, 'MAT91', 100),
		(10323, 'ENG10', 42),
		(10303, 'SCN91', 36),
		(10321, 'MAT81', 44),
		(10333, 'BIO10', 85),
		(10329, 'MAT91', 62),
		(10305, 'ENG81', 43),
		(10325, 'AFR91', 73),
		(10321, 'MAT81', 33),
		(10338, 'ENG81', 62),
		(10301, 'SCN81', 92),
		(10308, 'MAT81', 85),
		(10326, 'MAT10', 34),
		(10336, 'AFR91', 30),
		(10320, 'SCN81', 61),
		(10343, 'PHY10', 76),
		(10349, 'MAT10', 57),
		(10336, 'AFR91', 62),
		(10338, 'ENG81', 73),
		(10321, 'MAT81', 40),
		(10337, 'AFR10', 62),
		(10321, 'MAT81', 59),
		(10315, 'SCN81', 97),
		(10302, 'ENG81', 50),
		(10332, 'ECO10', 48),
		(10302, 'ENG81', 31),
		(10322, 'MAT91', 48),
		(10307, 'MAT91', 82),
		(10346, 'BIO10', 37),
		(10326, 'MAT10', 86),
		(10346, 'BIO10', 70),
		(10325, 'AFR91', 59),
		(10339, 'AFR10', 41),
		(10310, 'MAT81', 71),
		(10311, 'SCN81', 76),
		(10315, 'SCN81', 39),
		(10328, 'AFR10', 77),
		(10337, 'AFR10', 94),
		(10303, 'SCN91', 92),
		(10318, 'AFR81', 65),
		(10347, 'INT10', 65),
		(10327, 'INT10', 79),
		(10313, 'PHY10', 68),
		(10346, 'BIO10', 37),
		(10303, 'SCN91', 67),
		(10323, 'ENG10', 45),
		(10346, 'BIO10', 40),
		(10300, 'ENG91', 49),
		(10346, 'BIO10', 67),
		(10313, 'PHY10', 67),
		(10337, 'AFR10', 52),
		(10314, 'ENG10', 40),
		(10309, 'AFR81', 40),
		(10327, 'INT10', 71),
		(10310, 'MAT10', 45),
		(10316, 'AFR81', 86),
		(10327, 'INT10', 97),
		(10335, 'SCN91', 84),
		(10339, 'AFR10', 43),
		(10313, 'PHY10', 62),
		(10349, 'MAT10', 65),
		(10342, 'SCN91', 48),
		(10341, 'ENG91', 92),
		(10322, 'PHY10', 63),
		(10347, 'INT10', 73),
		(10326, 'MAT10', 64),
		(10340, 'BIO10', 54),
		(10302, 'ENG81', 98),
		(10336, 'AFR91', 67),
		(10325, 'AFR91', 80),
		(10305, 'ENG81', 68),
		(10312, 'ACC10', 82),
		(10322, 'PHY10', 75),
		(10315, 'SCN81', 97),
		(10341, 'ENG91', 80),
		(10335, 'SCN91', 55),
		(10349, 'MAT10', 82),
		(10342, 'SCN91', 40),
		(10307, 'MAT91', 64),
		(10306, 'ENG10', 33),
		(10320, 'SCN81', 71),
		(10304, 'BIO10', 88),
		(10320, 'SCN81', 48),
		(10329, 'MAT91', 37),
		(10334, 'ECO10', 31),
		(10344, 'ACC10', 60),
		(10309, 'AFR10', 34),
		(10338, 'ENG81', 48),
		(10333, 'BIO10', 53),
		(10304, 'AFR91', 81),
		(10309, 'AFR81', 40),
		(10345, 'ENG91', 78),
		(10334, 'ECO10', 33),
		(10328, 'AFR10', 100),
		(10321, 'MAT81', 61),
		(10349, 'MAT10', 80),
		(10333, 'BIO10', 35),
		(10331, 'AFR91', 65),
		(10338, 'ENG81', 32),
		(10340, 'ECO10', 91),
		(10304, 'AFR91', 43),
		(10327, 'INT10', 83),
		(10342, 'SCN91', 99),
		(10307, 'MAT91', 71),
		(10331, 'AFR91', 65),
		(10337, 'AFR10', 43),
		(10337, 'AFR10', 92),
		(10349, 'MAT10', 91),
		(10304, 'AFR91', 34),
		(10313, 'PHY10', 87),
		(10315, 'SCN81', 49),
		(10302, 'ENG81', 40),
		(10307, 'MAT91', 91),
		(10349, 'MAT10', 78),
		(10327, 'INT10', 100),
		(10348, 'INT10', 89),
		(10301, 'PHY10', 55),
		(10309, 'AFR81', 72),
		(10326, 'MAT10', 49),
		(10301, 'PHY10', 80),
		(10329, 'MAT91', 44),
		(10343, 'PHY10', 100),
		(10300, 'ENG91', 58),
		(10348, 'MAT10', 33),
		(10340, 'ECO10', 72),
		(10322, 'MAT91', 97),
		(10311, 'SCN81', 49),
		(10331, 'AFR91', 75),
		(10326, 'MAT10', 77),
		(10300, 'ENG91', 75),
		(10307, 'MAT91', 62),
		(10337, 'AFR10', 42),
		(10337, 'AFR10', 58),
		(10347, 'ENG91', 34),
		(10349, 'MAT10', 62),
		(10347, 'INT10', 33),
		(10335, 'SCN91', 52),
		(10309, 'AFR10', 66),
		(10348, 'MAT10', 46),
		(10304, 'BIO10', 43),
		(10312, 'ACC10', 57),
		(10346, 'BIO10', 48),
		(10343, 'PHY10', 94),
		(10303, 'SCN91', 91),
		(10303, 'SCN91', 68),
		(10320, 'SCN81', 43),
		(10313, 'PHY10', 52),
		(10345, 'ENG91', 61),
		(10314, 'ENG10', 92),
		(10306, 'ENG10', 80),
		(10327, 'INT10', 93),
		(10315, 'SCN81', 99),
		(10310, 'MAT10', 71),
		(10302, 'ENG81', 63),
		(10336, 'AFR91', 69),
		(10341, 'ENG91', 87),
		(10303, 'SCN91', 70),
		(10338, 'ENG81', 67),
		(10331, 'AFR91', 94),
		(10327, 'INT10', 47),
		(10315, 'SCN81', 73),
		(10324, 'MAT91', 45),
		(10337, 'AFR10', 57),
		(10327, 'INT10', 41),
		(10347, 'INT10', 88),
		(10301, 'PHY10', 98),
		(10317, 'ENG10', 62),
		(10326, 'MAT10', 73),
		(10300, 'ENG91', 67),
		(10318, 'AFR81', 85),
		(10339, 'AFR10', 90),
		(10335, 'SCN91', 36),
		(10332, 'ECO10', 88),
		(10341, 'ENG91', 35),
		(10313, 'PHY10', 52),
		(10337, 'AFR10', 96),
		(10307, 'MAT91', 35),
		(10324, 'MAT91', 68)
GO

--Section D - Indexes

USE ClaphamHigh
GO

CREATE INDEX IN_QuickStudentDetails
ON Student(studentNumber, StudentFirstName, StudentMiddleNames, StudentLastName)

CREATE INDEX IN_QuickTeacherDetails
ON Teacher(TeacherNum, TeacherFirstName, TeacherMiddleNames, TeacherLastName)


--Section E - Queries

	--Outstanding school fees
USE ClaphamHigh
GO

SELECT StudentNumber, StudentFirstName + ' ' + StudentLastName AS Name, Course.CourseTuitionFee - Student.StudentTuitionFeesPaid AS OustandingFee
FROM Student
INNER JOIN Course
ON Student.CourseID = Course.CourseID
WHERE Course.CourseTuitionFee - Student.StudentTuitionFeesPaid > 0
ORDER BY StudentNumber
GO

	--Identifying students' performance
SELECT s.StudentFirstName, s.StudentLastName, AVG(ss.SubjectMarks) as Marks, CASE
			WHEN AVG(ss.SubjectMarks) >= 80 AND AVG(ss.SubjectMarks) <= 100 THEN 'Distinction obtained.'
			WHEN AVG(ss.SubjectMarks) >= 50 AND AVG(ss.SubjectMarks) <= 79 THEN 'Promotion obtained'
			WHEN AVG(ss.SubjectMarks) >= 0 AND AVG(ss.SubjectMarks) <= 49 THEN 'At risk of failing the year!'
			END AS 'Performance description'
FROM Student s 
INNER JOIN StudentSubject ss
ON s.StudentNumber = ss.StudentNumber
GROUP BY s.StudentFirstName, s.StudentLastName
ORDER BY AVG(ss.SubjectMarks) DESC
GO

	--Selecting what teacher teaches what subject
SELECT Teacher.TeacherFirstName + ' ' + Teacher.TeacherLastName AS 'Teacher', Subject.SubjectName
FROM Teacher
INNER JOIN SubjectTeacher
ON	Teacher.TeacherNum = SubjectTeacher.TeacherNum
INNER JOIN	Subject
ON SubjectTeacher.SubjectCode = Subject.SubjectCode
GO

--Section F - Stored Procedures

	--New course being added to curriculum
CREATE PROCEDURE spAddCourse
(
    @CourseName NVARCHAR(50),
    @descript NVARCHAR(50),
    @tuition INT
)
AS
BEGIN
    INSERT INTO Courses (CourseNAme, CourseDescription, CourseTuitionFee)
    VALUES (@CourseName, @descript, @tuition);
END
GO

	--Retrieving the marks, course and subjects of any student 
CREATE PROCEDURE spGetStudentMarks
    @StudentID INT
AS
BEGIN
    SELECT s.StudentNumber, s.StudentFirstName, s.StudentLastName, c.CourseNAme, t.TeacherFirstName + ' ' + t.TeacherLastName AS TeacherName, ss.SubjectMarks
    FROM Student s
    INNER JOIN StudentSubject ss ON s.StudentNumber = ss.StudentNumber
    INNER JOIN Course c ON s.CourseID = c.CourseID
	INNER JOIN SubjectTeacher st ON ss.SubjectCode = st.SubjectCode
    INNER JOIN Teacher t ON st.TeacherNum = t.TeacherNum
    WHERE s.StudentNumber = @StudentID
END
GO

--Section G - Triggers
USE ClaphamHigh
GO

	--Update on the student address
CREATE TRIGGER trStudentContactAddress
ON Student
AFTER UPDATE
AS
BEGIN
	IF UPDATE(StudentContactAddress)
	BEGIN
		PRINT 'Student has relocated'
		ROLLBACK TRANSACTION
	END
END
GO

	--Update tuitionfeespaid
CREATE TRIGGER trUpdateTuitionFees
ON Student
AFTER UPDATE
AS
BEGIN
	PRINT 'Student tuitionfee paid updated.'
END;
GO


--Section H - Views
USE ClaphamHigh
GO

	--Displaying teachers who are at their retirement age (>=60) and the subjects they teach
CREATE VIEW vRetirementAge (TeacherName, TeacherAge, SubjectCode, SubjectName)
AS
	SELECT (TeacherFirstName + ' ' + TeacherMiddleNames + ' ' + TeacherLastName) AS 'Teacher', TeacherAge, s.SubjectCode, SubjectName
	FROM Teacher t 
	INNER JOIN SubjectTeacher st
	ON t.TeacherNum = st.TeacherNum
	INNER JOIN [Subject] s 
	ON st.SubjectCode = s.SubjectCode
	WHERE TeacherAge >= 60
GO

	--How many students are in each course
CREATE VIEW vCourseTotal AS
	SELECT c.CourseNAme, COUNT(s.StudentNumber) AS num_students
	FROM Course c 
	LEFT JOIN Student s 
	ON c.CourseID = s.CourseID 
	GROUP BY c.CourseID, c.CourseNAme;
GO

	--Top 10 students
CREATE VIEW vTopStudents AS
	SELECT TOP(10) s.StudentFirstName, s.StudentLastName, s.StudentGrade, AVG(ss.SubjectMarks) as Marks
	FROM Student s INNER JOIN StudentSubject ss
	ON s.StudentNumber = ss.StudentNumber
	GROUP BY s.StudentFirstName, s.StudentLastName, s.StudentGrade
GO

--Section I - User Login

USE ClaphamHigh
GO

CREATE LOGIN FullAccessAdmin WITH PASSWORD = '@CC3SED';
GO

GRANT CONTROL ON DATABASE::ClaphamHigh TO FullAccessAdmin;
GO

--Section J - Backup

USE ClaphamHigh
GO

BACKUP DATABASE ClaphamHigh
TO DISK = 'C:\DBD281_Project_Clapham\ClaphamHigh.bak'
WITH INIT