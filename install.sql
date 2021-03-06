-- page
DROP TABLE IF EXISTS cms1_page;
CREATE TABLE cms1_page (
	pageID INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	isHome TINYINT(1) NOT NULL DEFAULT 0,

	authorID INT(10) DEFAULT NULL,
	authorName VARCHAR(255) NOT NULL DEFAULT '',
	lastEditorID INT(10) DEFAULT NULL,
	lastEditorName VARCHAR(255) NOT NULL DEFAULT '',
	creationTime INT(10) NOT NULL DEFAULT 0,
	lastEditTime INT(10) NOT NULL DEFAULT 0,
	comments INT(10) NOT NULL DEFAULT 0,
	clicks INT (10) NOT NULL DEFAULT 0,

	-- general data
	title VARCHAR(255) NOT NULL DEFAULT '',
	alias VARCHAR(255) NOT NULL,
	description MEDIUMTEXT,

	-- meta information
	metaDescription MEDIUMTEXT,
	metaKeywords VARCHAR(255),
	allowIndexing TINYINT(1) NOT NULL DEFAULT 1,

	-- position
	parentID INT(10) DEFAULT NULL,
	showOrder INT(10) NOT NULL DEFAULT 0,
	invisible TINYINT(1) NOT NULL DEFAULT 0,

	-- publication
	isDisabled TINYINT(1) NOT NULL DEFAULT 0,
	isPublished TINYINT(1) NOT NULL DEFAULT 1,
	publicationDate INT(10) NOT NULL DEFAULT 0,
	deactivationDate INT(10) NOT NULL DEFAULT 0,

	-- settings
	menuItemID INT(10) DEFAULT NULL,
	isCommentable TINYINT(1) NOT NULL DEFAULT 0,
	availableDuringOfflineMode TINYINT(1) NOT NULL DEFAULT 0,
	allowSubscribing TINYINT(1) NOT NULL DEFAULT 1,

	-- display
	styleID INT(10) DEFAULT NULL,

	-- display settings
	sidebarOrientation ENUM('left', 'right') NOT NULL DEFAULT 'right',
	
	-- page type
	objectTypeID INT(10),
	
	-- additional data
	additionalData MEDIUMTEXT DEFAULT NULL
);

DROP TABLE IF EXISTS cms1_page_revision;
CREATE TABLE cms1_page_revision(
	revisionID INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	pageID INT(10) NOT NULL,
	action VARCHAR(255),
	userID INT(10),
	username VARCHAR(255) NOT NULL DEFAULT '',
	time INT(10) NOT NULL DEFAULT 0,
	data LONGBLOB NOT NULL,
	contentData LONGBLOB NOT NULL
);

-- content
DROP TABLE IF EXISTS cms1_content;
CREATE TABLE cms1_content (
	contentID INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	parentID INT(10),
	pageID INT(10),
	title VARCHAR(255) NOT NULL DEFAULT '',
	contentTypeID INT(10),
	contentData MEDIUMTEXT,
	showOrder INT(10) DEFAULT 0,
	isDisabled TINYINT(1) DEFAULT 0,
	position ENUM('body', 'sidebar') NOT NULL DEFAULT 'body',
	cssClasses VARCHAR(255),
	showHeadline TINYINT(1) NOT NULL DEFAULT 0,
	additionalData MEDIUMTEXT DEFAULT NULL
);

-- stylesheet
DROP TABLE IF EXISTS cms1_stylesheet;
CREATE TABLE cms1_stylesheet (
	stylesheetID INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(255) NOT NULL,
	less MEDIUMTEXT
);

DROP TABLE IF EXISTS cms1_stylesheet_to_page;
CREATE TABLE cms1_stylesheet_to_page (
	stylesheetID INT(10) NOT NULL,
	pageID INT(10) NOT NULL,

	PRIMARY KEY (stylesheetID, pageID)
);

-- file
DROP TABLE IF EXISTS cms1_file;
CREATE TABLE cms1_file (
	fileID INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(255) NOT NULL DEFAULT '',
	filesize INT(10) NOT NULL DEFAULT 0,
	fileType VARCHAR(255) NOT NULL DEFAULT '',
	width INT(10) NOT NULL DEFAULT 0,
	height INT(10) NOT NULL DEFAULT 0,
	filesizeThumbnail INT(10) NOT NULL DEFAULT 0,
	fileTypeThumbnail VARCHAR(255) NOT NULL DEFAULT '',
	widthThumbnail INT(10) NOT NULL DEFAULT 0,
	heightThumbnail INT(10) NOT NULL DEFAULT 0,
	fileHash VARCHAR(40) NOT NULL DEFAULT '',
	uploadTime INT(10) NOT NULL DEFAULT 0,
	downloads INT(10) DEFAULT 0,
	filename VARCHAR(255) NOT NULL DEFAULT ''
);

DROP TABLE IF EXISTS cms1_file_to_category;
CREATE TABLE cms1_file_to_category (
	fileID INT(10) NOT NULL,
	categoryID INT(10) NOT NULL,

	PRIMARY KEY (fileID, categoryID)
);

-- counter
DROP TABLE IF EXISTS cms1_counter;
CREATE TABLE cms1_counter (
	day INT(2) NOT NULL DEFAULT '1',
	month INT(2) NOT NULL DEFAULT '1',
	year INT(4) NOT NULL DEFAULT '2014',
	visits INT(10) NOT NULL DEFAULT 0,
	users INT(10) NOT NULL DEFAULT 0,
	spiders INT(10) NOT NULL DEFAULT 0,
	browsers MEDIUMTEXT,
	platforms MEDIUMTEXT,
	devices MEDIUMTEXT
);

-- dashboard boxes
-- since 2.2.0 Beta 1
DROP TABLE IF EXISTS cms1_content_to_dashboardbox;
CREATE TABLE cms1_content_to_dashboardbox (
	contentID INT(10),
	boxID INT(10),
	position VARCHAR(255) NOT NULL DEFAULT '',
	PRIMARY KEY (contentID, boxID)
);

-- foreign keys
ALTER TABLE cms1_content ADD FOREIGN KEY (parentID) REFERENCES cms1_content (contentID) ON DELETE SET NULL;
ALTER TABLE cms1_content ADD FOREIGN KEY (pageID) REFERENCES cms1_page (pageID) ON DELETE CASCADE;
ALTER TABLE cms1_content ADD FOREIGN KEY (contentTypeID) REFERENCES wcf1_object_type (objectTypeID) ON DELETE CASCADE;

ALTER TABLE cms1_file_to_category ADD FOREIGN KEY (fileID) REFERENCES cms1_file (fileID) ON DELETE CASCADE;
ALTER TABLE cms1_file_to_category ADD FOREIGN KEY (categoryID) REFERENCES wcf1_category (categoryID) ON DELETE CASCADE;

ALTER TABLE cms1_page ADD FOREIGN KEY (parentID) REFERENCES cms1_page (pageID) ON DELETE SET NULL;
#ALTER TABLE cms1_page ADD FOREIGN KEY (menuItemID) REFERENCES wcf1_page_menu_item (menuItemID) ON DELETE SET NULL;
ALTER TABLE cms1_page ADD FOREIGN KEY (styleID) REFERENCES wcf1_style (styleID) ON DELETE SET NULL;
ALTER TABLE cms1_page ADD FOREIGN KEY (authorID) REFERENCES wcf1_user (userID) ON DELETE SET NULL;
ALTER TABLE cms1_page ADD FOREIGN KEY (lastEditorID) REFERENCES wcf1_user (userID) ON DELETE SET NULL;
ALTER TABLE cms1_page ADD FOREIGN KEY (objectTypeID) REFERENCES wcf1_object_type (objectTypeID) ON DELETE CASCADE;

ALTER TABLE cms1_page_revision ADD FOREIGN KEY (pageID) REFERENCES cms1_page (pageID) ON DELETE CASCADE;
ALTER TABLE cms1_page_revision ADD FOREIGN KEY (userID) REFERENCES wcf1_user (userID) ON DELETE SET NULL;

ALTER TABLE cms1_stylesheet_to_page ADD FOREIGN KEY (stylesheetID) REFERENCES cms1_stylesheet (stylesheetID) ON DELETE CASCADE;
ALTER TABLE cms1_stylesheet_to_page ADD FOREIGN KEY (pageID) REFERENCES cms1_page (pageID) ON DELETE CASCADE;

-- since 2.2.0 Beta 1
ALTER TABLE cms1_content_to_dashboardbox ADD FOREIGN KEY (contentID) REFERENCES cms1_content (contentID) ON DELETE CASCADE;
#ALTER TABLE cms1_content_to_dashboardbox ADD FOREIGN KEY (boxID) REFERENCES wcf1_dashboard_box (boxID) ON DELETE CASCADE;
