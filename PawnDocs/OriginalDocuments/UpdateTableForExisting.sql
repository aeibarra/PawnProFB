ALTER TABLE ExportLogFileDetail ADD InvItemNo INTEGER, 
                                ADD  ItemSeq INTEGER ;

ALTER TABLE Store ADD LeadsStoreId varchar(20),
                  ADD LeadsOnlineFTPAddress VARCHAR(50),
                  ADD LeadsOnlineUserName VARCHAR(50),
                  ADD LeadsOnlinePassword VARCHAR (50);
