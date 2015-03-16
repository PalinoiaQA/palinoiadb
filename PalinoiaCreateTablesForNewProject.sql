CREATE TABLE [lkup_SearchObjects] (
[ID] integer  PRIMARY KEY AUTOINCREMENT NOT NULL,
[fk_SearchTypeID] integer  NOT NULL,
[fk_SearchDataTypeID] integer  NOT NULL,
[Text] text  NOT NULL,
[SearchColumn] text  NOT NULL,
[ResultDisplayPriority] INTEGER  NULL,
[XREF_Table] text  NULL
);

CREATE TABLE [lkup_SearchTypes] (
[ID] INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
[Name] TEXT  NOT NULL
);

CREATE TABLE [lkup_SearchDataTypes] (
[ID] INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
[Name] texT  NOT NULL
);

CREATE TABLE [lkup_CSMResponseType] (
[ID] integer  PRIMARY KEY AUTOINCREMENT NOT NULL,
[Text] varchar(50)  UNIQUE NOT NULL,
[Active] BOOLEAN  NOT NULL,
[UpdatedBy] INTEGER  NOT NULL
);

CREATE TABLE [lkup_CSMType] (
[ID] INTEGER  PRIMARY KEY AUTOINCREMENT NOT NULL,
[Text] VARCHAR(50)  NOT NULL,
[Active] BOOLEAN  NOT NULL,
[UpdatedBy] INTEGER  NOT NULL
);

CREATE TABLE [lkup_ChapterType] (
[ID] INTEGER  PRIMARY KEY AUTOINCREMENT NOT NULL,
[Text] TEXT  NOT NULL,
[Active] BOOLEAN  NOT NULL,
[UpdatedBy] INTEGER  NOT NULL
);

CREATE TABLE [lkup_DefectPriority] (
[ID] INTEGER  PRIMARY KEY AUTOINCREMENT NOT NULL,
[Text] TEXT  NOT NULL,
[Active] BOOLEAN  NOT NULL,
[UpdatedBy] INTEGER  NOT NULL,
[Importance] INTEGER  NOT NULL
);

CREATE TABLE [lkup_DefectType] (
[ID] INTEGER  PRIMARY KEY AUTOINCREMENT NOT NULL,
[Text] TEXT  NOT NULL,
[Active] BOOLEAN  NOT NULL,
[UpdatedBy] INTEGER  NOT NULL
);

CREATE TABLE [lkup_DefectStatus] (
[ID] INTEGER  PRIMARY KEY AUTOINCREMENT NOT NULL,
[Text] TEXT  NOT NULL,
[Active] BOOLEAN  NOT NULL,
[UpdatedBy] INTEGER  NOT NULL
);

CREATE TABLE [lkup_DocumentType] (
[ID] INTEGER  PRIMARY KEY AUTOINCREMENT NOT NULL,
[Text] TEXT  UNIQUE NOT NULL,
[Active] BOOLEAN  NOT NULL,
[IncludeBRCSMSummaryTable] BOOLEAN  NOT NULL,
[UpdatedBy] INTEGER  NOT NULL
);

CREATE TABLE [lkup_PalinoiaFields] (
[ID] INTEGER  PRIMARY KEY AUTOINCREMENT NOT NULL,
[Name] TEXT  NOT NULL
);

CREATE TABLE [lkup_PalinoiaObjects] (
[ID] INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
[TEXT] TEXT  NULL
);

CREATE TABLE [lkup_SearchOperators] (
[ID] INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
[Text] TEXT  UNIQUE NOT NULL
);

CREATE TABLE [lkup_Sections] (
[ID] INTEGER  PRIMARY KEY AUTOINCREMENT NOT NULL,
[Text] TEXT  UNIQUE NOT NULL,
[Abbreviation] TEXT  UNIQUE NOT NULL,
[Active] BOOLEAN  NOT NULL,
[UpdatedBy] INTEGER  NOT NULL
);

CREATE TABLE [lkup_Status] (
[ID] integer  PRIMARY KEY AUTOINCREMENT NOT NULL,
[Text] varchar(50)  UNIQUE NOT NULL,
[Active] BOOLEAN  NOT NULL,
[Color] VARCHAR(10)  NOT NULL,
[DisplayInChapterSummary] BOOLEAN  NOT NULL,
[UpdatedBy] INTEGER  NOT NULL
);

CREATE TABLE [lkup_TestStatus] (
[ID] INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
[TEXT] TEXT  NOT NULL
);

CREATE TABLE [BusinessRules] (
[ID] integer  PRIMARY KEY AUTOINCREMENT NOT NULL,
[Name] varchar(100)  UNIQUE NOT NULL,
[fk_StatusID] integer  NOT NULL,
[Text] text  NOT NULL,
[Active] boolean  NOT NULL,
[fk_SectionID] integer  NOT NULL,
[UpdatedBy] INTEGER  NOT NULL
);

CREATE TABLE [CustomerServiceMessages] (
[ID] integer  PRIMARY KEY AUTOINCREMENT NOT NULL,
[Name] varchar(100)  UNIQUE NOT NULL,
[fk_StatusID] integer  NOT NULL,
[fk_CSMTypeID] integer  NOT NULL,
[fk_CSMResponseTypeID] integer  NOT NULL,
[Text] text  NOT NULL,
[fk_SectionID] integer  NOT NULL,
[Active] boolean  NOT NULL,
[UpdatedBy] INTEGER  NOT NULL
);

CREATE TABLE [Defects] (
[ID] integer  PRIMARY KEY AUTOINCREMENT NOT NULL,
[fk_DefectPriorityID] integer  NOT NULL,
[fk_DefectStatusID] integer  NOT NULL,
[fk_DefectTypeID] integer  NOT NULL,
[OwnerID] integer  NULL,
[DefectName] text  NOT NULL,
[Description] text  NOT NULL,
[DateCreated] date  NOT NULL,
[DateCompleted] date  NULL,
[Closed] boolean  NOT NULL,
[UpdatedBy] integer  NOT NULL
);

CREATE TABLE [Documents] (
[ID] integer  PRIMARY KEY AUTOINCREMENT NOT NULL,
[fk_DocumentType] integer  NOT NULL,
[Name] text  UNIQUE NOT NULL,
[Description] text  NULL,
[Active] boolean  NOT NULL,
[UpdatedBy] INTEGER  NOT NULL
);

CREATE TABLE [TestCases] (
    [ID] integer PRIMARY KEY AUTOINCREMENT NOT NULL,
    [fk_lkup_SectionID] integer,
    [Name] text NOT NULL,
    [Notes] text,
    [Active] boolean NOT NULL,
    [UpdatedBy] integer NOT NULL,
    [fk_TestStatusID] integer NOT NULL,
    CONSTRAINT [FK_TestCases_-1_-1] FOREIGN KEY ([fk_TestStatusID]) REFERENCES [lkup_TestStatus] ([ID])
);

CREATE TABLE [TestSteps] (
[ID] integer  PRIMARY KEY AUTOINCREMENT NOT NULL,
[Text] text  NOT NULL,
[Active] BOOLEAN  NOT NULL,
[UpdatedBy] INTEGER  NOT NULL
);

CREATE TABLE [TestResults] (
[ID] integer  PRIMARY KEY AUTOINCREMENT NOT NULL,
[fk_TestCaseID] integer  NOT NULL,
[fk_TestStepID] integer  NOT NULL,
[fk_TestStatusID] integer  NOT NULL,
[UserID] integer  NOT NULL,
[TestDate] timestamp  NOT NULL,
[Notes] text  NULL
);

CREATE TABLE [Chapters] (
[ID] integer  PRIMARY KEY AUTOINCREMENT NOT NULL,
[fk_ChapterTypeID] integer  NOT NULL,
[Title] text  NOT NULL,
[Text] text  NULL,
[UpdatedBy] INTEGER  NOT NULL,
[Active] BOOLEAN  NOT NULL
);

CREATE TABLE [Document_Chapters] (
[ID] integer  PRIMARY KEY AUTOINCREMENT NOT NULL,
[SeqNum] INTEGER  NOT NULL,
[fk_DocumentID] integer  NOT NULL,
[fk_ChapterID] integer  NOT NULL
);



CREATE TABLE [BusinessRules_CustomerServiceMessages] (
    [ID] integer PRIMARY KEY AUTOINCREMENT NOT NULL,
    [fk_BusinessRulesID] integer NOT NULL,
    [fk_CustomerServiceMessagesID] integer NOT NULL,
    CONSTRAINT [FK_BusinessRules_CustomerServiceMessages_fk_BusinessRulesID_BusinessRules_ID] FOREIGN KEY ([fk_BusinessRulesID]) REFERENCES

[BusinessRules] ([ID]),
    CONSTRAINT [FK_BusinessRules_CustomerServiceMessages_fk_CustomerServiceMessagesID_CustomerServiceMessages_ID] FOREIGN KEY

([fk_CustomerServiceMessagesID]) REFERENCES [CustomerServiceMessages] ([ID])
);

CREATE TABLE [CustomerServiceMessage_Sections] (
    [ID] integer PRIMARY KEY AUTOINCREMENT NOT NULL,
    [fk_CustomerServiceMessageID] integer NOT NULL,
    [fk_SectionID] integer NOT NULL,
    CONSTRAINT [FK_CustomerServiceMessage_Sections_fk_CustomerServiceMessageID_CustomerServiceMessages_ID] FOREIGN KEY

([fk_CustomerServiceMessageID]) REFERENCES [CustomerServiceMessages] ([ID]),
    CONSTRAINT [FK_CustomerServiceMessage_Sections_fk_SectionID_lkup_Sections_ID] FOREIGN KEY ([fk_SectionID]) REFERENCES [lkup_Sections] ([ID])
);

CREATE TABLE [Defect_BusinessRules] (
    [ID] integer PRIMARY KEY AUTOINCREMENT NOT NULL,
    [fk_DefectID] integer NOT NULL,
    [fk_BusinessRuleID] integer NOT NULL,
    CONSTRAINT [FK_Defect_BusinessRules_fk_DefectID_Defects_ID] FOREIGN KEY ([fk_DefectID]) REFERENCES [Defects] ([ID]),
    CONSTRAINT [FK_Defect_BusinessRules_fk_BusinessRuleID_BusinessRules_ID] FOREIGN KEY ([fk_BusinessRuleID]) REFERENCES [BusinessRules] ([ID])
);

CREATE TABLE [Defect_Comments] (
    [ID] integer PRIMARY KEY AUTOINCREMENT NOT NULL,
    [fk_DefectID] integer NOT NULL,
    [UserID] integer NOT NULL,
    [DateCreated] date NOT NULL,
    [Text] text NOT NULL,
    CONSTRAINT [FK_Defect_Comments_fk_DefectID_Defects_ID] FOREIGN KEY ([fk_DefectID]) REFERENCES [Defects] ([ID])
);

CREATE TABLE [Defect_CustomerServiceMessages] (
    [ID] integer PRIMARY KEY AUTOINCREMENT NOT NULL,
    [fk_DefectID] integer NOT NULL,
    [fk_CustomerServiceMessageID] integer NOT NULL,
    CONSTRAINT [FK_Defect_CustomerServiceMessages_fk_DefectID_Defects_ID] FOREIGN KEY ([fk_DefectID]) REFERENCES [Defects] ([ID]),
    CONSTRAINT [FK_Defect_CustomerServiceMessages_fk_CustomerServiceMessageID_CustomerServiceMessages_ID] FOREIGN KEY

([fk_CustomerServiceMessageID]) REFERENCES [CustomerServiceMessages] ([ID])
);

CREATE TABLE [Defect_TestCases] (
    [ID] integer PRIMARY KEY AUTOINCREMENT NOT NULL,
    [fk_DefectID] integer NOT NULL,
    [fk_TestCaseID] integer NOT NULL,
    CONSTRAINT [FK_Defect_TestCases_fk_DefectID_Defects_ID] FOREIGN KEY ([fk_DefectID]) REFERENCES [Defects] ([ID]),
    CONSTRAINT [FK_Defect_TestCases_fk_TestCaseID_TestCases_ID] FOREIGN KEY ([fk_TestCaseID]) REFERENCES [TestCases] ([ID])
);

CREATE TABLE [DocumentImages] (
[ID] INTEGER  PRIMARY KEY AUTOINCREMENT NOT NULL,
[FileName] TEXT  NOT NULL,
[Description] TEXT  NULL,
[UpdatedBy] INTEGER  NOT NULL
);



CREATE TABLE [History] (
[ID] integer  PRIMARY KEY AUTOINCREMENT NOT NULL,
[fk_PalinoiaObjectID] integer  NULL,
[RecordID] INTEGER  NULL,
[fk_PalinoiaFieldID] INTEGER  NULL,
[Action] VARCHAR(1)  NULL,
[OldValue] text  NULL,
[NewValue] text  NULL,
[UserID_UpdatedBy] integer  NULL,
[DateUpdated] timestamp  NULL
);

CREATE TABLE [TestCase_BusinessRules] (
    [ID] integer PRIMARY KEY AUTOINCREMENT NOT NULL,
    [fk_TestCaseID] integer NOT NULL,
    [fk_BusinessRuleID] integer NOT NULL,
    CONSTRAINT [FK_TestCase_BusinessRules_fk_TestCaseID_TestCases_ID] FOREIGN KEY ([fk_TestCaseID]) REFERENCES [TestCases] ([ID]),
    CONSTRAINT [FK_TestCase_BusinessRules_fk_BusinessRuleID_BusinessRules_ID] FOREIGN KEY ([fk_BusinessRuleID]) REFERENCES [BusinessRules]

([ID])
);

CREATE TABLE [TestCase_Documents] (
    [ID] integer PRIMARY KEY AUTOINCREMENT NOT NULL,
    [fk_TestCaseID] integer NOT NULL,
    [fk_DocumentID] integer NOT NULL,
    CONSTRAINT [FK_TestCase_Documents_fk_TestCaseID_TestCases_ID] FOREIGN KEY ([fk_TestCaseID]) REFERENCES [TestCases] ([ID]),
    CONSTRAINT [FK_TestCase_Documents_fk_DocumentID_Documents_ID] FOREIGN KEY ([fk_DocumentID]) REFERENCES [Documents] ([ID])
);

CREATE TABLE [TestCase_PreConditions] (
    [ID] integer PRIMARY KEY AUTOINCREMENT NOT NULL,
    [fk_TestCaseID] integer NOT NULL,
    [PreConditionTestCaseID] integer NOT NULL,
    [SeqNum] integer NOT NULL,
    CONSTRAINT [FK_TestCase_PreConditions_fk_TestCaseID_TestCases_ID] FOREIGN KEY ([fk_TestCaseID]) REFERENCES [TestCases] ([ID])
);

CREATE TABLE [TestCase_TestSteps] (
[ID] integer  PRIMARY KEY AUTOINCREMENT NOT NULL,
[SeqNum] INTEGER  NOT NULL,
[fk_TestCaseID] integer  NOT NULL,
[fk_TestStepID] integer  NOT NULL,
[Notes] VARCHAR(250)  NULL
);

CREATE TABLE [TestStep_BusinessRules] (
    [ID] integer PRIMARY KEY AUTOINCREMENT NOT NULL,
    [fk_TestStepID] integer NOT NULL,
    [fk_BusinessRuleID] integer NOT NULL,
    CONSTRAINT [FK_TestStep_BusinessRules_0] FOREIGN KEY ([fk_BusinessRuleID]) REFERENCES [BusinessRules] ([ID]),
    CONSTRAINT [FK_TestStep_BusinessRules_1] FOREIGN KEY ([fk_TestStepID]) REFERENCES [TestSteps] ([ID])
);

CREATE TABLE [BusinessRule_Sections] (
    [ID] integer PRIMARY KEY AUTOINCREMENT NOT NULL,
    [fk_BusinessRuleID] integer NOT NULL,
    [fk_SectionID] integer NOT NULL,
    CONSTRAINT [FK_BusinessRule_Sections_fk_BusinessRuleID_BusinessRules_ID] FOREIGN KEY ([fk_BusinessRuleID]) REFERENCES [BusinessRules]

([ID]),
    CONSTRAINT [FK_BusinessRule_Sections_fk_SectionID_lkup_Sections_ID] FOREIGN KEY ([fk_SectionID]) REFERENCES [lkup_Sections] ([ID])
);

INSERT INTO lkup_CSMResponseType (Text, Active, UpdatedBy) VALUES ("OK", 1, 0);
INSERT INTO lkup_CSMResponseType (Text, Active, UpdatedBy) VALUES ("YesNo", 1, 0);
INSERT INTO lkup_CSMResponseType (Text, Active, UpdatedBy) VALUES ("Yes", 1, 0);
INSERT INTO lkup_CSMResponseType (Text, Active, UpdatedBy) VALUES ("YesNoCancel", 1, 0);
INSERT INTO lkup_CSMType(Text, Active, UpdatedBy) VALUES ("Application", 1, 0);
INSERT INTO lkup_CSMType(Text, Active, UpdatedBy) VALUES ("Error", 1, 0);
INSERT INTO lkup_CSMType(Text, Active, UpdatedBy) VALUES ("Status", 1, 0);
INSERT INTO lkup_ChapterType (Text, Active, UpdatedBy) VALUES ("user", 1, 0);
INSERT INTO lkup_ChapterType (Text, Active, UpdatedBy) VALUES ("system", 1, 0);
INSERT INTO lkup_DefectPriority (Text, Active, UpdatedBy, Importance) VALUES ("Critical", 1, 0, 1);
INSERT INTO lkup_DefectPriority (Text, Active, UpdatedBy, Importance) VALUES ("High", 1, 0, 2);
INSERT INTO lkup_DefectPriority (Text, Active, UpdatedBy, Importance) VALUES ("Medium", 1, 0, 3);
INSERT INTO lkup_DefectPriority (Text, Active, UpdatedBy, Importance) VALUES ("Low", 1, 0, 4);
INSERT INTO lkup_DefectStatus (Text, Active, UpdatedBy) VALUES ("New", 1, 0);
INSERT INTO lkup_DefectStatus (Text, Active, UpdatedBy) VALUES ("Reviewed", 1, 0);
INSERT INTO lkup_DefectStatus (Text, Active, UpdatedBy) VALUES ("In Progress", 1, 0);
INSERT INTO lkup_DefectStatus (Text, Active, UpdatedBy) VALUES ("On Hold", 1, 0);
INSERT INTO lkup_DefectStatus (Text, Active, UpdatedBy) VALUES ("Rejected", 1, 0);
INSERT INTO lkup_DefectStatus (Text, Active, UpdatedBy) VALUES ("Completed", 1, 0);
INSERT INTO lkup_DefectStatus (Text, Active, UpdatedBy) VALUES ("Cancelled", 1, 0);
INSERT INTO lkup_DefectType (Text, Active, UpdatedBy) VALUES ("Defect", 1, 0);
INSERT INTO lkup_DefectType (Text, Active, UpdatedBy) VALUES ("Enhancement", 1, 0);
INSERT INTO lkup_DefectType (Text, Active, UpdatedBy) VALUES ("New Construction", 1, 0);
INSERT INTO lkup_SearchTypes (Name) VALUES ("BusinessRules");
INSERT INTO lkup_SearchTypes (Name) VALUES ("CustomerServiceMessages");
INSERT INTO lkup_SearchTypes (Name) VALUES ("Defects");
INSERT INTO lkup_SearchTypes (Name) VALUES ("TestCases");
INSERT INTO lkup_SearchTypes (Name) VALUES ("Documents");
INSERT INTO lkup_SearchDataTypes (Name) VALUES ("INT");
INSERT INTO lkup_SearchDataTypes (Name) VALUES ("STRING");
INSERT INTO lkup_SearchDataTypes (Name) VALUES ("DATE");
INSERT INTO lkup_SearchDataTypes (Name) VALUES ("BOOL");
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (3,0,"Defect ID","ID",1, NULL);
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES(3,1,"Status","fk_DefectStatusID",1,"lkup_DefectStatus");
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES(3,1,"Priority","fk_DefectPriorityID",1,"lkup_DefectPriority");
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES(3,1,"Type","fk_DefectTypeID",1,"lkup_DefectType");
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES(3,1,"Owner","OwnerID",1,"Users");
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES(3,2,"Name","DefectName",1,NULL);
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES(3,2,"Description","Description",2,NULL);
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES(3,3,"Date Created","DateCreated",1,NULL);
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES(3,3,"Date Completed","DateCompleted",1,NULL);
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES(1,0,"ID","ID",1,NULL);
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES(1,2,"Name","Name",1,NULL);
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES(1,1,"Status","fk_StatusID",1,"lkup_Status");
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES(1,2,"Text","Text",2,NULL);
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES(1,4,"Active","Active",1,NULL);
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES(1,1,"Section","fk_SectionID",1,"lkup_Sections");
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES(1,1,"Updated By","UpdatedBy",1,"Users");
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES(2,0,"ID","ID",1,NULL);
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES(2,2,"Name","Name",1,NULL);
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES(2,1,"Status","fk_StatusID",1,"lkup_Status");
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (2,1,"CSM Type","fk_CSM_TypeID",1,"lkup_CSMType");
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (2,1,"CSM Response Type","fk_CSMResponseTypeID",1,"lkup_CSMResponseType");
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (2,2,"Text","Text",2,NULL);
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (2,1,"Section","fk_SectionID",1,"lkup_Sections");
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (2,4,"Active","Active",1,NULL);
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (2,1,"Updated By","UpdatedBy",1,"Users");
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (4,0,"ID","ID",1,NULL);
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (4,1,"Section","fk_lkup_SectionID",1,"lkup_Sections");
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (4,2,"Name","Name",1,NULL);
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (4,2,"Notes","Notes",3,NULL);
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (4,4,"Active","Active",1,NULL);
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (4,1,"Updated By","UpdatedBy",1,"Users");
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (4,1,"Test Status","fk_TestStatusID",1,"lkup_TestStatus");
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (3,2,"Comments","Text",3,"Defect_Comments");
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (4,2,"Test Step Name","Text",2,"TestSteps");
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (4,1,"Tested By","UserID",1,"Users");
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (4,3,"Test Date","TestDate",1,"TestResults");
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (4,2,"Test Notes","Notes",2,"TestResults");
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (4,2,"Test Result Notes","Notes",3,"TestResults");
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (4,2,"Test Step Notes","Notes",3,"TestCase_TestSteps");
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (5,0,"Document ID","ID",1,NULL);
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (5,1,"Document Type","fk_DocumentType",1,"lkup_DocumentType");
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (5,2,"Document Name","Name",1,NULL);
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (5,2,"Description","Description",2,NULL);
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (5,4,"Active","Active",1,NULL);
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (5,1,"Updated By","UpdatedBy",1,"Users");
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (5,2,"Chapter Title","Title",1,NULL);
INSERT INTO lkup_SearchObjects (fk_SearchTypeID,fk_SearchDataTypeID,Text,SearchColumn,ResultDisplayPriority,XREF_Table) VALUES (5,2,"Chapter Text","Text",2,NULL);
INSERT INTO lkup_DocumentType (Text, Active, IncludeBRCSMSummaryTable, UpdatedBy) VALUES ("Functional", 1, 1, 0);
INSERT INTO lkup_DocumentType (Text, Active, IncludeBRCSMSummaryTable, UpdatedBy) VALUES ("Technical", 1, 0, 0);
INSERT INTO lkup_DocumentType (Text, Active, IncludeBRCSMSummaryTable, UpdatedBy) VALUES ("Test Case", 1, 1, 0);
INSERT INTO lkup_DocumentType (Text, Active, IncludeBRCSMSummaryTable, UpdatedBy) VALUES ("Miscellaneous", 1, 0, 0);
INSERT INTO lkup_PalinoiaFields (Name) VALUES ("Name");
INSERT INTO lkup_PalinoiaFields (Name) VALUES ("Text");
INSERT INTO lkup_PalinoiaFields (Name) VALUES ("fk_lkup_StatusID");
INSERT INTO lkup_PalinoiaFields (Name) VALUES ("fk_lkup_SectionID");
INSERT INTO lkup_PalinoiaFields (Name) VALUES ("Active");
INSERT INTO lkup_PalinoiaFields (Name) VALUES ("fk_CSMTypeID");
INSERT INTO lkup_PalinoiaFields (Name) VALUES ("fk_CSMResponseTypeID");
INSERT INTO lkup_PalinoiaFields (Name) VALUES ("fk_ChapterTypeID");
INSERT INTO lkup_PalinoiaFields (Name) VALUES ("fk_DefectPriority");
INSERT INTO lkup_PalinoiaFields (Name) VALUES ("fk_DefectStatusID");
INSERT INTO lkup_PalinoiaFields (Name) VALUES ("fk_DefectTypeID");
INSERT INTO lkup_PalinoiaFields (Name) VALUES ("OwnerID");
INSERT INTO lkup_PalinoiaFields (Name) VALUES ("DefectName");
INSERT INTO lkup_PalinoiaFields (Name) VALUES ("Description");
INSERT INTO lkup_PalinoiaFields (Name) VALUES ("DateCreated");
INSERT INTO lkup_PalinoiaFields (Name) VALUES ("DateCompleted");
INSERT INTO lkup_PalinoiaFields (Name) VALUES ("Closed");
INSERT INTO lkup_PalinoiaFields (Name) VALUES ("FileName");
INSERT INTO lkup_PalinoiaFields (Name) VALUES ("fk_DocumentType");
INSERT INTO lkup_PalinoiaFields (Name) VALUES ("Notes");
INSERT INTO lkup_PalinoiaFields (Name) VALUES ("IncludeBRCSMSummaryTable");
INSERT INTO lkup_PalinoiaFields (Name) VALUES ("Abbreviation");
INSERT INTO lkup_PalinoiaFields (Name) VALUES ("Color");
INSERT INTO lkup_PalinoiaFields (Name) VALUES ("DisplayInChapterSummary");
INSERT INTO lkup_PalinoiaFields (Name) VALUES ("Title");
INSERT INTO lkup_PalinoiaObjects (Text) VALUES ("Business Rule");
INSERT INTO lkup_PalinoiaObjects (Text) VALUES ("Customer Service Message");
INSERT INTO lkup_PalinoiaObjects (Text) VALUES ("Test Case");
INSERT INTO lkup_PalinoiaObjects (Text) VALUES ("Defect");
INSERT INTO lkup_PalinoiaObjects (Text) VALUES ("CSM Response Type");
INSERT INTO lkup_PalinoiaObjects (Text) VALUES ("CSM Type");
INSERT INTO lkup_PalinoiaObjects (Text) VALUES ("Status");
INSERT INTO lkup_PalinoiaObjects (Text) VALUES ("PreCondition");
INSERT INTO lkup_PalinoiaObjects (Text) VALUES ("Chapter");
INSERT INTO lkup_PalinoiaObjects (Text) VALUES ("DocumentImage");
INSERT INTO lkup_PalinoiaObjects (Text) VALUES ("Document");
INSERT INTO lkup_PalinoiaObjects (Text) VALUES ("TestStep");
INSERT INTO lkup_PalinoiaObjects (Text) VALUES ("ChapterType");
INSERT INTO lkup_PalinoiaObjects (Text) VALUES ("DefectPriority");
INSERT INTO lkup_PalinoiaObjects (Text) VALUES ("DefectStatus");
INSERT INTO lkup_PalinoiaObjects (Text) VALUES ("DefectType");
INSERT INTO lkup_PalinoiaObjects (Text) VALUES ("DocumentType");
INSERT INTO lkup_SearchOperators (Text) VALUES ("=");
INSERT INTO lkup_SearchOperators (Text) VALUES ("!=");
INSERT INTO lkup_SearchOperators (Text) VALUES ("<");
INSERT INTO lkup_SearchOperators (Text) VALUES (">");
INSERT INTO lkup_SearchOperators (Text) VALUES ("<=");
INSERT INTO lkup_SearchOperators (Text) VALUES (">=");
INSERT INTO lkup_SearchOperators (Text) VALUES ("contains");
INSERT INTO lkup_SearchOperators (Text) VALUES ("starts with");
INSERT INTO lkup_SearchOperators (Text) VALUES ("ends with");
INSERT INTO lkup_Sections (Text, Abbreviation, Active, UpdatedBy) VALUES ( "Administration", "ADM", 1, 0);
INSERT INTO lkup_Sections (Text, Abbreviation, Active, UpdatedBy) VALUES ( "General", "GEN", 1, 0);
INSERT INTO lkup_Status (Text, Active, Color, DisplayInChapterSummary, UpdatedBy) VALUES ("New", 1, "#66FF00", 1, 0);
INSERT INTO lkup_Status (Text, Active, Color, DisplayInChapterSummary, UpdatedBy) VALUES ("Revised", 1, "#FFFF66", 1, 0);
INSERT INTO lkup_Status (Text, Active, Color, DisplayInChapterSummary, UpdatedBy) VALUES ("Deleted", 1, "#FF0000", 1, 0);
INSERT INTO lkup_Status (Text, Active, Color, DisplayInChapterSummary, UpdatedBy) VALUES ("Approved", 1, "#FFFFFF", 0, 0);
INSERT INTO lkup_TestStatus (Text) VALUES ("Pass");
INSERT INTO lkup_TestStatus (Text) VALUES ("Fail");
INSERT INTO lkup_TestStatus (Text) VALUES ("Untested");

CREATE TRIGGER [delete_BusinessRules] 
AFTER DELETE ON [BusinessRules] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(1, OLD.ID, 'D', OLD.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [delete_Chapters] 
AFTER DELETE ON [Chapters] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(11, OLD.ID, 'D', OLD.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [delete_CustomerServiceMessages] 
AFTER DELETE ON [CustomerServiceMessages] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(2, OLD.ID, 'D', OLD.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [delete_DefectType] 
AFTER DELETE ON [lkup_DefectType] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(18, OLD.ID, 'D', OLD.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [delete_DocumentImages] 
AFTER DELETE ON [DocumentImages] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(12, OLD.ID, 'D', OLD.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [delete_Documents] 
AFTER DELETE ON [Documents] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(13, OLD.ID, 'D', OLD.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [delete_TestCases] AFTER DELETE ON [main].[TestCases] FOR EACH ROW
BEGIN
INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(3, OLD.ID, 'D', OLD.UpdatedBy, datetime('now', 'localtime'));
END;

CREATE TRIGGER [delete_TestSteps] 
AFTER DELETE ON [TestSteps] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(14, OLD.ID, 'D', OLD.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [delete_lkup_CSMResponseType] 
AFTER DELETE ON [lkup_CSMResponseType] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(6, OLD.ID, 'D', OLD.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [delete_lkup_CSMType] 
AFTER DELETE ON [lkup_CSMType] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(7, OLD.ID, 'D', OLD.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [delete_lkup_ChapterType] 
AFTER DELETE ON [lkup_ChapterType] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(15, OLD.ID, 'D', OLD.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [delete_lkup_DefectStatus] 
AFTER DELETE ON [lkup_DefectStatus] 
FOR EACH ROW 
BEGIN 

       INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(17, OLD.ID, 'D', OLD.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [delete_lkup_DocumentType] 
AFTER DELETE ON [lkup_DocumentType] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(19, OLD.ID, 'D', OLD.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [delete_lkup_Sections] 
AFTER DELETE ON [lkup_Sections] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(20, OLD.ID, 'D', OLD.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [delete_lkup_Status] 
AFTER DELETE ON [lkup_Status] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(8, OLD.ID, 'D', OLD.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [insert_BusinessRules] 
AFTER INSERT ON [BusinessRules] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(1, NEW.ID, 'I', NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(1, NEW.ID, 2, 'U', NULL, NEW.Text, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(1, NEW.ID, 5, 'U', NULL, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(1, NEW.ID, 1, 'U', NULL, NEW.Name, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(1, NEW.ID, 3, 'U', NULL, NEW.fk_StatusID, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(1, NEW.ID, 4, 'U', NULL, NEW.fk_SectionID, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [insert_Chapters] 
AFTER INSERT ON [Chapters] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(11, NEW.ID, 'I', NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(11, NEW.ID, 2, 'U', NULL, NEW.Text, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(11, NEW.ID, 5, 'U', NULL, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(11, NEW.ID, 8, 'U', NULL, NEW.fk_ChapterTypeID, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(11, NEW.ID, 25, 'U', NULL, NEW.Title, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [insert_CustomerServiceMessages] 
AFTER INSERT ON [CustomerServiceMessages] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(2, NEW.ID, 'I', NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(2, NEW.ID, 2, 'U', NULL, NEW.Text, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(2, NEW.ID, 5, 'U', NULL, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(2, NEW.ID, 3, 'U', NULL, NEW.fk_StatusID, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(2, NEW.ID, 6, 'U', NULL, NEW.fk_CSMTypeID, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(2, NEW.ID, 7, 'U', NULL, NEW.fk_CSMResponseTypeID, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(2, NEW.ID, 4, 'U', NULL, NEW.fk_SectionID, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [insert_DocumentImages] 
AFTER INSERT ON [DocumentImages] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(12, NEW.ID, 'I', NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(12, NEW.ID, 18, 'U', NULL, NEW.FileName, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(12, NEW.ID, 14, 'U', NULL, NEW.Description, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [insert_Documents] 
AFTER INSERT ON [Documents] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(13, NEW.ID, 'I', NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(13, NEW.ID, 1, 'U', NULL, NEW.Name, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(13, NEW.ID, 5, 'U', NULL, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(13, NEW.ID, 14, 'U', NULL, NEW.Description, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(13, NEW.ID, 19, 'U', NULL, NEW.fk_DocumentType, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [insert_TestCases] AFTER INSERT ON [main].[TestCases] FOR EACH ROW
BEGIN
INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(4, NEW.ID, 'I', NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(3, NEW.ID, 1, 'U', NULL, NEW.Name, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(3, NEW.ID, 5, 'U', NULL, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(3, NEW.ID, 20, 'U', NULL, NEW.Notes, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(3, NEW.ID, 4, 'U', NULL, NEW.fk_lkup_SectionID, NEW.UpdatedBy, datetime('now', 'localtime'));
END;

CREATE TRIGGER [insert_TestSteps] 
AFTER INSERT ON [TestSteps] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(14, NEW.ID, 'I', NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(14, NEW.ID, 2, 'U', NULL, NEW.Text, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(14, NEW.ID, 5, 'U', NULL, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [insert_lkup_CSMResponseType] 
AFTER INSERT ON [lkup_CSMResponseType] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(6, NEW.ID, 'I', NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(6, NEW.ID, 1, 'U', NULL, NEW.Text, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(6, NEW.ID, 5, 'U', NULL, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [insert_lkup_CSMType] 
AFTER INSERT ON [lkup_CSMType] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(7, NEW.ID, 'I', NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(7, NEW.ID, 2, 'U', NULL, NEW.Text, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(7, NEW.ID, 5, 'U', NULL, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [insert_lkup_ChapterType] 
AFTER INSERT ON [lkup_ChapterType] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(15, NEW.ID, 'I', NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(15, NEW.ID, 2, 'U', NULL, NEW.Text, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(15, NEW.ID, 5, 'U', NULL, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [insert_lkup_DefectStatus] 
AFTER INSERT ON [lkup_DefectStatus] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(17, NEW.ID, 'I', NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(17, NEW.ID, 2, 'U', NULL, NEW.Text, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(17, NEW.ID, 5, 'U', NULL, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [insert_lkup_DefectType] 
AFTER INSERT ON [lkup_DefectType] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(18, NEW.ID, 'I', NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(18, NEW.ID, 2, 'U', NULL, NEW.Text, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(18, NEW.ID, 5, 'U', NULL, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [insert_lkup_DocumentType] 
AFTER INSERT ON [lkup_DocumentType] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(19, NEW.ID, 'I', NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(19, NEW.ID, 1, 'U', NULL, NEW.Name, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(19, NEW.ID, 5, 'U', NULL, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(19, NEW.ID, 21, 'U', NULL, NEW.IncludeBRCSMSummaryTable, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [insert_lkup_Sections] 
AFTER INSERT ON [lkup_Sections] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(20, NEW.ID, 'I', NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(20, NEW.ID, 1, 'U', NULL, NEW.Name, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(20, NEW.ID, 5, 'U', NULL, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(20, NEW.ID, 22, 'U', NULL, NEW.Abbreviation, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [insert_lkup_Status] 
AFTER INSERT ON [lkup_Status] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, Action, UserID_UpdatedBy, DateUpdated)
VALUES
(8, NEW.ID, 'I', NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(8, NEW.ID, 2, 'U', NULL, NEW.Text, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(8, NEW.ID, 5, 'U', NULL, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(8, NEW.ID, 23, 'U', NULL, NEW.Color, NEW.UpdatedBy, datetime('now', 'localtime'));

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(8, NEW.ID, 24, 'U', NULL, NEW.DisplayInChapterSummary, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_BusinessRules_Active] 
AFTER UPDATE ON [BusinessRules] 
FOR EACH ROW WHEN NEW.ACTIVE <> OLD.ACTIVE 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(1, NEW.ID, 5, 'U', OLD.Active, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_BusinessRules_Name] 
AFTER UPDATE ON [BusinessRules] 
FOR EACH ROW WHEN NEW.NAME <> OLD.NAME 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(1, NEW.ID, 1, 'U', OLD.Name, NEW.Name, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_BusinessRules_SectionID] 
AFTER UPDATE ON [BusinessRules] 
FOR EACH ROW WHEN NEW.FK_SECTIONID <> OLD.FK_SECTIONID 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(1, NEW.ID, 4, 'U', OLD.fk_SectionID, NEW.fk_SectionID, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_BusinessRules_StatusID] 
AFTER UPDATE ON [BusinessRules] 
FOR EACH ROW WHEN NEW.FK_STATUSID <> OLD.FK_STATUSID 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(1, NEW.ID, 3, 'U', OLD.fk_StatusID, NEW.fk_StatusID, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_BusinessRules_Text] 
AFTER UPDATE ON [BusinessRules] 
FOR EACH ROW WHEN NEW.TEXT <> OLD.TEXT 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(1, NEW.ID, 2, 'U', OLD.Text, NEW.Text, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_Chapters_ChapterType] 
AFTER UPDATE ON [Chapters] 
FOR EACH ROW WHEN NEW.FK_CHAPTERTYPEID <> OLD.FK_CHAPTERTYPEID 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(11, NEW.ID, 8, 'U', OLD.fk_ChapterTypeID, NEW.fk_ChapterTypeID, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_Chapters_Text] 
AFTER UPDATE ON [Chapters] 
FOR EACH ROW WHEN NEW.TEXT <> OLD.TEXT AND NEW.UPDATEDBY <> 0 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(11, NEW.ID, 2, 'U', OLD.Text, NEW.Text, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_Chapters_Title] 
AFTER UPDATE ON [Chapters] 
FOR EACH ROW WHEN NEW.TITLE <> OLD.TITLE 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(11, NEW.ID, 25, 'U', OLD.Title, NEW.Title, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_CustomerServiceMessages_Active] 
AFTER UPDATE ON [CustomerServiceMessages] 
FOR EACH ROW WHEN NEW.Active <> OLD.Active 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(2, 5, 'U', OLD.Active, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_CustomerServiceMessages_CSMResponseTypeID] 
AFTER UPDATE ON [CustomerServiceMessages] 
FOR EACH ROW WHEN NEW.fk_CSMResponseTypeID <> OLD.fk_CSMResponseTypeID 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(2, 7, 'U', OLD.fk_CSMResponseTypeID, NEW.fk_CSMResponseTypeID, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_CustomerServiceMessages_CSMTypeID] 
AFTER UPDATE ON [CustomerServiceMessages] 
FOR EACH ROW WHEN NEW.fk_CSMTypeID <> OLD.fk_CSMTypeID 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(2, 6, 'U', OLD.fk_CSMTypeID, NEW.fk_CSMTypeID, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_CustomerServiceMessages_Name] 
AFTER UPDATE ON [CustomerServiceMessages] 
FOR EACH ROW WHEN NEW.Name <> OLD.Name 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(2, 1, 'U', OLD.Name, NEW.Name, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_CustomerServiceMessages_SectionID] 
AFTER UPDATE ON [CustomerServiceMessages] 
FOR EACH ROW WHEN NEW.fk_SectionID <> OLD.fk_SectionID 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(2, 4, 'U', OLD.fk_SectionID, NEW.fk_SectionID, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_CustomerServiceMessages_StatusID] 
AFTER UPDATE ON [CustomerServiceMessages] 
FOR EACH ROW WHEN NEW.fk_StatusID <> OLD.fk_StatusID 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(2, 3, 'U', OLD.fk_StatusID, NEW.fk_StatusID, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_CustomerServiceMessages_Text] 
AFTER UPDATE ON [CustomerServiceMessages] 
FOR EACH ROW WHEN NEW.Text <> OLD.Text 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(2, 2, 'U', OLD.Text, NEW.Text, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_DocumentImages_Description] 
AFTER UPDATE ON [DocumentImages] 
FOR EACH ROW 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(12, 14, 'U', OLD.Description, NEW.Description, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_DocumentImages_FileName] 
AFTER UPDATE ON [DocumentImages] 
FOR EACH ROW WHEN NEW.FILENAME <> OLD.FILENAME 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(12, 18, 'U', OLD.FileName, NEW.FileName, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_Documents_Active] 
AFTER UPDATE ON [Documents] 
FOR EACH ROW WHEN NEW.Active <> OLD.Active 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(13, 5, 'U', OLD.Active, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_Documents_Description] 
AFTER UPDATE ON [Documents] 
FOR EACH ROW WHEN NEW.Description <> OLD.Description 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(13, 14, 'U', OLD.Description, NEW.Description, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_Documents_DocumentType] 
AFTER UPDATE ON [Documents] 
FOR EACH ROW WHEN NEW.fk_DocumentType <> OLD.fk_DocumentType 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(13, 19, 'U', OLD.fk_DocumentType, NEW.fk_DocumentType, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_Documents_Name] 
AFTER UPDATE ON [Documents] 
FOR EACH ROW WHEN NEW.Name <> OLD.Name 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(13, 1, 'U', OLD.Name, NEW.Name, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_TestCases_Active] AFTER UPDATE ON [main].[TestCases] FOR EACH ROW WHEN NEW.ACTIVE <> OLD.ACTIVE
BEGIN
INSERT INTO History (fk_PalinoiaObjectID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(3, 5, 'U', OLD.Active, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));
END;

CREATE TRIGGER [update_TestCases_Name] AFTER UPDATE ON [main].[TestCases] FOR EACH ROW WHEN NEW.NAME <> OLD.NAME
BEGIN
INSERT INTO History (fk_PalinoiaObjectID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(3, 1, 'U', OLD.Name, NEW.Name, NEW.UpdatedBy, datetime('now', 'localtime'));
END;

CREATE TRIGGER [update_TestCases_Notes] AFTER UPDATE ON [main].[TestCases] FOR EACH ROW WHEN NEW.NOTES <> OLD.NOTES
BEGIN
INSERT INTO History (fk_PalinoiaObjectID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(3, 20, 'U', OLD.Notes, NEW.Notes, NEW.UpdatedBy, datetime('now', 'localtime'));
END;

CREATE TRIGGER [update_TestCases_SectionID] AFTER UPDATE ON [main].[TestCases] FOR EACH ROW WHEN NEW.FK_LKUP_SECTIONID <> OLD.FK_LKUP_SECTIONID
BEGIN
INSERT INTO History (fk_PalinoiaObjectID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(3, 4, 'U', OLD.fk_lkup_SectionID, NEW.fk_lkup_SectionID, NEW.UpdatedBy, datetime('now', 'localtime'));
END;

CREATE TRIGGER [update_TestSteps_Active] 
AFTER UPDATE ON [TestSteps] 
FOR EACH ROW WHEN NEW.Active <> OLD.Active 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(14, 5, 'U', OLD.Active, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_TestSteps_Text] 
AFTER UPDATE ON [TestSteps] 
FOR EACH ROW WHEN NEW.Text <> OLD.Text 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(14, 2, 'U', OLD.Text, NEW.Text, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_lkup_CSMResponseType_Active] 
AFTER UPDATE ON [lkup_CSMResponseType] 
FOR EACH ROW WHEN NEW.ACTIVE <>OLD.ACTIVE 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(6, NEW.ID, 5, 'U', OLD.Active, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_lkup_CSMResponseType_Text] 
AFTER UPDATE ON [lkup_CSMResponseType] 
FOR EACH ROW WHEN NEW.TEXT <> OLD.TEXT 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(6, NEW.ID, 2, 'U', OLD.Text, NEW.Text, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_lkup_CSMType_Active] 
AFTER UPDATE ON [lkup_CSMType] 
FOR EACH ROW WHEN NEW.ACTIVE <> OLD.ACTIVE 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(7, NEW.ID, 5, 'U', OLD.Active, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_lkup_CSMType_Text] 
AFTER UPDATE ON [lkup_CSMType] 
FOR EACH ROW WHEN NEW.TEXT <> OLD.TEXT 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(7, NEW.ID, 2, 'U', OLD.Text, NEW.Text, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_lkup_ChapterType_Active] 
AFTER UPDATE ON [lkup_ChapterType] 
FOR EACH ROW WHEN NEW.ACTIVE <> OLD.ACTIVE 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(15, NEW.ID, 5, 'U', OLD.Active, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_lkup_ChapterType_Text] 
AFTER UPDATE ON [lkup_ChapterType] 
FOR EACH ROW WHEN NEW.TEXT <> OLD.TEXT 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(15, NEW.ID, 2, 'U', OLD.Text, NEW.Text, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_lkup_DefectStatus_Active] 
AFTER UPDATE ON [lkup_DefectStatus] 
FOR EACH ROW WHEN NEW.Active <> OLD.Active 
BEGIN 

   INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(17, NEW.ID, 5, 'U', OLD.Active, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_lkup_DefectStatus_Text] 
AFTER UPDATE ON [lkup_DefectStatus] 
FOR EACH ROW WHEN NEW.Text <> OLD.Text 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(17, NEW.ID, 2, 'U', OLD.Text, NEW.Text, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_lkup_DefectType_Active] 
AFTER UPDATE ON [lkup_DefectType] 
FOR EACH ROW WHEN NEW.Active <> OLD.Active 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(18, NEW.ID, 5, 'U', OLD.Active, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_lkup_DefectType_Text] 
AFTER UPDATE ON [lkup_DefectType] 
FOR EACH ROW WHEN NEW.Text <> OLD.Text 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(18, NEW.ID, 2, 'U', OLD.Text, NEW.Text, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_lkup_DocumentType_Active] 
AFTER UPDATE ON [lkup_DocumentType] 
FOR EACH ROW WHEN NEW.ACTIVE <> OLD.ACTIVE 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(19, NEW.ID, 5, 'U', OLD.Active, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_lkup_DocumentType_IncludeBRCSMSummaryTable] 
AFTER UPDATE ON [lkup_DocumentType] 
FOR EACH ROW WHEN NEW.INCLUDEBRCSMSUMMARYTABLE <> OLD.INCLUDEBRCSMSUMMARYTABLE 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(19, NEW.ID, 21, 'U', OLD.IncludeBRCSMSummaryTable, NEW.IncludeBRCSMSummaryTable, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_lkup_DocumentType_Name] 
AFTER UPDATE ON [lkup_DocumentType] 
FOR EACH ROW WHEN NEW.NAME <> OLD.NAME 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(19, NEW.ID, 1, 'U', OLD.Name, NEW.Name, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_lkup_Sections_Abbreviation] 
AFTER UPDATE ON [lkup_Sections] 
FOR EACH ROW WHEN NEW.Abbreviation <> OLD.Abbreviation 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(20, NEW.ID, 22, 'U', OLD.Abbreviation, NEW.Abbreviation, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_lkup_Sections_Active] 
AFTER UPDATE ON [lkup_Sections] 
FOR EACH ROW WHEN NEW.Active <> OLD.Active 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(20, NEW.ID, 5, 'U', OLD.Active, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_lkup_Sections_Name] 
AFTER UPDATE ON [lkup_Sections] 
FOR EACH ROW WHEN NEW.NAME <> OLD.NAME 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(20, NEW.ID, 1, 'U', OLD.Name, NEW.Name, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_lkup_Status_Active] 
AFTER UPDATE ON [lkup_Status] 
FOR EACH ROW WHEN NEW.ACTIVE <> OLD.ACTIVE 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(8, NEW.ID, 5, 'U', OLD.Active, NEW.Active, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_lkup_Status_Color] 
AFTER UPDATE ON [lkup_Status] 
FOR EACH ROW WHEN NEW.COLOR <> OLD.COLOR 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(8, NEW.ID, 23, 'U', OLD.Color, NEW.Color, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_lkup_Status_DisplayInChapterSummary] 
AFTER UPDATE ON [lkup_Status] 
FOR EACH ROW WHEN NEW.DISPLAYINCHAPTERSUMMARY <> OLD.DISPLAYINCHAPTERSUMMARY 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(8, NEW.ID, 24, 'U', OLD.DisplayInChapterSummary, NEW.DisplayInChapterSummary, NEW.UpdatedBy, datetime('now', 'localtime'));

END;

CREATE TRIGGER [update_lkup_Status_Text] 
AFTER UPDATE ON [lkup_Status] 
FOR EACH ROW WHEN NEW.TEXT <> OLD.TEXT 
BEGIN 

INSERT INTO History (fk_PalinoiaObjectID, RecordID, fk_PalinoiaFieldID, Action, OldValue, NewValue, UserID_UpdatedBy, DateUpdated)
VALUES
(8, NEW.ID, 2, 'U', OLD.Text, NEW.Text, NEW.UpdatedBy, datetime('now', 'localtime'));

END;