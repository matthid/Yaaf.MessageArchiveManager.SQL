set @columnType := (select case lower(IS_NULLABLE) when 'no' then CONCAT(column_type, ' not null ')  when 'yes' then column_type end FROM information_schema.columns  WHERE table_schema = SCHEMA() AND table_name = 'ChatCol' and column_name = 'ArchivingUserId');
set @sqlstmt := (select concat('alter table `ChatCol` change `ArchivingUserId` `UID` ' , @columnType));
prepare stmt from @sqlstmt;
execute stmt;
deallocate prepare stmt;
set @columnType := (select case lower(IS_NULLABLE) when 'no' then CONCAT(column_type, ' not null ')  when 'yes' then column_type end FROM information_schema.columns  WHERE table_schema = SCHEMA() AND table_name = 'ChatCol' and column_name = 'StartDate');
set @sqlstmt := (select concat('alter table `ChatCol` change `StartDate` `Start` ' , @columnType));
prepare stmt from @sqlstmt;
execute stmt;
deallocate prepare stmt;
set @columnType := (select case lower(IS_NULLABLE) when 'no' then CONCAT(column_type, ' not null ')  when 'yes' then column_type end FROM information_schema.columns  WHERE table_schema = SCHEMA() AND table_name = 'ChatCol' and column_name = 'WithJid');
set @sqlstmt := (select concat('alter table `ChatCol` change `WithJid` `WJid` ' , @columnType));
prepare stmt from @sqlstmt;
execute stmt;
deallocate prepare stmt;
set @columnType := (select case lower(IS_NULLABLE) when 'no' then CONCAT(column_type, ' not null ')  when 'yes' then column_type end FROM information_schema.columns  WHERE table_schema = SCHEMA() AND table_name = 'ChatCol' and column_name = 'NextStartDate');
set @sqlstmt := (select concat('alter table `ChatCol` change `NextStartDate` `NStart` ' , @columnType));
prepare stmt from @sqlstmt;
execute stmt;
deallocate prepare stmt;
set @columnType := (select case lower(IS_NULLABLE) when 'no' then CONCAT(column_type, ' not null ')  when 'yes' then column_type end FROM information_schema.columns  WHERE table_schema = SCHEMA() AND table_name = 'ChatCol' and column_name = 'NextWithJid');
set @sqlstmt := (select concat('alter table `ChatCol` change `NextWithJid` `NWJid` ' , @columnType));
prepare stmt from @sqlstmt;
execute stmt;
deallocate prepare stmt;
set @columnType := (select case lower(IS_NULLABLE) when 'no' then CONCAT(column_type, ' not null ')  when 'yes' then column_type end FROM information_schema.columns  WHERE table_schema = SCHEMA() AND table_name = 'ChatCol' and column_name = 'PreviousStartDate');
set @sqlstmt := (select concat('alter table `ChatCol` change `PreviousStartDate` `PStart` ' , @columnType));
prepare stmt from @sqlstmt;
execute stmt;
deallocate prepare stmt;
set @columnType := (select case lower(IS_NULLABLE) when 'no' then CONCAT(column_type, ' not null ')  when 'yes' then column_type end FROM information_schema.columns  WHERE table_schema = SCHEMA() AND table_name = 'ChatCol' and column_name = 'PreviousWithJid');
set @sqlstmt := (select concat('alter table `ChatCol` change `PreviousWithJid` `PWJid` ' , @columnType));
prepare stmt from @sqlstmt;
execute stmt;
deallocate prepare stmt;
set @columnType := (select case lower(IS_NULLABLE) when 'no' then CONCAT(column_type, ' not null ')  when 'yes' then column_type end FROM information_schema.columns  WHERE table_schema = SCHEMA() AND table_name = 'ItemPref' and column_name = 'ArchivingUserId');
set @sqlstmt := (select concat('alter table `ItemPref` change `ArchivingUserId` `UID` ' , @columnType));
prepare stmt from @sqlstmt;
execute stmt;
deallocate prepare stmt;
set @columnType := (select case lower(IS_NULLABLE) when 'no' then CONCAT(column_type, ' not null ')  when 'yes' then column_type end FROM information_schema.columns  WHERE table_schema = SCHEMA() AND table_name = 'ChMsg' and column_name = 'CollectionArchivingUserId');
set @sqlstmt := (select concat('alter table `ChMsg` change `CollectionArchivingUserId` `UID` ' , @columnType));
prepare stmt from @sqlstmt;
execute stmt;
deallocate prepare stmt;
set @columnType := (select case lower(IS_NULLABLE) when 'no' then CONCAT(column_type, ' not null ')  when 'yes' then column_type end FROM information_schema.columns  WHERE table_schema = SCHEMA() AND table_name = 'ChMsg' and column_name = 'CollectionStartDate');
set @sqlstmt := (select concat('alter table `ChMsg` change `CollectionStartDate` `Start` ' , @columnType));
prepare stmt from @sqlstmt;
execute stmt;
deallocate prepare stmt;
set @columnType := (select case lower(IS_NULLABLE) when 'no' then CONCAT(column_type, ' not null ')  when 'yes' then column_type end FROM information_schema.columns  WHERE table_schema = SCHEMA() AND table_name = 'ChMsg' and column_name = 'CollectionWithJid');
set @sqlstmt := (select concat('alter table `ChMsg` change `CollectionWithJid` `WJid` ' , @columnType));
prepare stmt from @sqlstmt;
execute stmt;
deallocate prepare stmt;
alter table `ChatCol` add column `LastChanged` datetime not null;
UPDATE `ChatCol` SET `LastChanged` = '2015-03-11 16:47:41' WHERE `LastChanged` = '0000-00-00 00:00:00';
CREATE index  `IX_UID_NStart_NWJid` on `ChatCol` (`UID` DESC,`NStart` DESC,`NWJid` DESC) using HASH;
CREATE index  `IX_UID_PStart_PWJid` on `ChatCol` (`UID` DESC,`PStart` DESC,`PWJid` DESC) using HASH;
alter table `ChatCol` add constraint `FK_ChatCol_ChatCol_UID_NStart_NWJid`  foreign key (`UID`,`NStart`,`NWJid`) references `ChatCol` ( `UID`,`Start`,`WJid`);
alter table `ChatCol` add constraint `FK_ChatCol_ChatCol_UID_PStart_PWJid`  foreign key (`UID`,`PStart`,`PWJid`) references `ChatCol` ( `UID`,`Start`,`WJid`);
alter table `ChMsg` drop column `MessageState`;
INSERT INTO `__MigrationHistory`(
`MigrationId`, 
`ContextKey`, 
`Model`, 
`ProductVersion`) VALUES (
'201503111457204_0_0_1', 
'Yaaf.Xmpp.MessageArchiveManager.Sql.MySql.Migrations.Configuration', 
0x1F8B0800000000000400ED5D596F24B7117E0F90FFD0E8C7009ED6AE13C35E8C6CC8D2CA50BC3AA0D1DACED382D3CD1975DC57BA3982F4DBFC909F94BF10F6CDFB9A9E43BB7E59486CF26355B18A2C16ABB4FFFBE3BFF31F9ED3C47B826515E7D9A9FF6676E27B300BF328CED6A7FE06ADBEFAD6FFE1FBBFFE65FE3E4A9FBD5FFA7E5FD7FDF0C8AC3AF51F112ADE0541153EC21454B3340ECBBCCA576816E66900A23C787B72F25DF0E64D0031848FB13C6F7EBFC9509CC2E617FCEB799E85B0401B905CE7114CAAAE1D7F5934A8DE0D48615580109EFAFF026035FB2D2D8AD935AC2AB0866765F8183FC16B90E15FCAD9E23FC9ECFA05FFEB7B67490C30810B98AC7C0F64598E00C2E4BFFB58C1052AF36CBD287003481E5E0A88FBAD4052C18EAD776377530E4FDED61C06E3402709F903EF98FBF7584AE8A526AF91C0A97FB13C7F04E83C4F1218365310BD71FF9FE10BD5809BEECABC80257AB987AB0EA395175E5F2C86F22AF2BD403F668140892E008246BD7F8DD1E33F630E791EB0F40D6365A4D5ACD7B397B8CDF7AEC1F30798ADD12356D4B7DFFADE65FC0CA3BEA55BBD8F598CB5170F42E506FF7AB34912B04CE0F03D501240F0D94E5DFFFC8035D51A6990C1DE59D82CFF8D95433131FED16862F53C0F8F25042AFEA699A6DB72FA79AE32F4F55B6B997C0015C28693AD61B4F5C25E551730816844FA31CF1308326BA01BF88C14FAA61F3C9D8AA9E7BA2BE1539C6F2A67627B807D11FC1B260C4CAF9937E0295E373BBB6ADBF2BD7B9834BDAAC7B8684F9F19BB6F7F62865C96797A9F27821D9EEEF969916FCAB05E80DCA8FB0328D7109973528375C76AA560A4EBF289398C3836C4FD06AA6826249D7B8E4D59A82D83A4C96435D8318AE5A0BBEAD783E96FBB20BDE9D872241AA7E08AEFAEE74C3046C4DD3C18BD188D6F431B85836B23F668F47EC7A1DC8DB30DCA53BC96E1C03977A8A801B0CC30045E89152CB1DB0EB73B262F961FF21024D3C1619F7C3325DE02603F1F8B7B5B9C5B546E0FF3FEB9884B12E39BBFDB6DB4A3E1A8F6DA090E0DF17EAB3D634C79B942301DD758C64B6363544F153FBADE029EB443447C59EC4E3CFEBE6E5FAFF32E7590DBCFE7B44798B895135B157FE81B1BA2A355119E9F8B3975435D0E7D62A87A8989C8D102E525FC0966B0C4579FE80E2004CB0C8F8C60C3994E1DC62DF7E0D63992325DCC63C43C58F403FB1CEDB2D6136F67BB1DD0288D2DA583753DCF105694ED49EB80761E7C19A4897504D9D26CE8FBECEE9A29BEC168EEA426DBD85955E561DCD0ACF00E3EA9AE33EFB3C8B3DF95DBD596EDFC580136098A8B240E31D1A7FEDFB825B19A75F0B0C85999C3859EF08DCF6ED8B7591B2CF3CEC236947E0EAA1044BCB260494774CB7D4B561D9FC7EA5EA112C419E20F84380BE30224D66C314816D7C99ADA615EF6CB052C60569F06D6AB6B4290DE790C060218F9EAC4390F08ADD629BBF25E225739B3C816A96EACE5DB28B8D995C842B9D9C91C35D484AEBD69A7C992BC36CD941C1B6A4DD19D21AC56F63EABB54AEA62A2E6EA7F0CDBAD9EA349B4C7F651D2E659D2C162D4CA62428BE22660C48BD07DB71CA990C7214E1126086FBCB1CB22F23B3A4724017D8BE94E66B35D1D2662E23E4713D42AC0EE98661E6E8DC71C99BD099E888C8D40F55EB423BB533C371D87EDC909FCCCED4FAE0CBB635C909360356E9FB6D80611EA980D1E01CB3EBC54E7A8D1B96B5D84E819718658032C20923D1E8D610AA91970864643D6C21703319722031CEE3D48802A8A5E68A0E9DC0409CB835BCE80114B33229A84CF8981E6417756A79CA23D03FF12A9729AEB14DD6166E17029ADC6DD8CC4AA7EB71489D43CA2E012532098E46C472946A318C2CE44288B7FCA046872F1B5BFFA32C21B4D502B39CD55D77C55A6504236C7C7400B553712A73BC9547A28B983EC57A0A2142303A1EADC4E67C7732AE12A1CCD4904DCBF2A0C0EC1F06D1EB4E9EE5DC33C90E4C5CFAF4151E05D88C893EF5ABC459B247FFED5C23EFB3C6D3182B01224A10FD40E33A1BCC4C6CD7CADE30B11BC8CCBAAF6CAC012D40F43E751CA7573717FFAA9C55E10BFC4BD87D08FAB7F6EC71A1711F09E14EF6576F097581C69ED26378FC484AAE821BCBAD00124A0D4E57060904D9A75AED6D585C8E99561119E3289D234DBE00C9E3389F2ABD0975610D327A953A4F48DE6387D123A09D3B799A30C39E624CCD0688E43A5999358D407733C22D59C44239ACDB198A005897763AD0354348382B25504C13D8EC4BBB3268DBBE05170B6E47599E42446D724B86D06CC46C0DD2CB91D890BCAD31B9DD136D8BA9CBBDAFC948EB8D1DEA74190495EB8E3492304D20D5490604B228ABE9BA3F3D9B72436FFD50699CBC4A5A1B9CF36D87C5A2E0DCE7FB7411F13F068D4B1DD066D48C3A3C1866673AC3E178F04EADB8ECA9AD99BFEAE6C5B97D0DA4CA6377013987D3838DC6E6FB9D7FFA9B9F4774BCDA56203BBF4C585D9A2CD2C668EB874BC4CFC44A228B902D2D4531596E2DD770BD517BE066FE5E50B5E89B7F1F799B44CE6B8213F996372F99982C5915528AA69A5F234695AA94F36E2EC123649B4A1D1418E5D42A65090DDB73DEF0C5C5883ED32CC3E84379830C6BC0B29E8FF0600176368BBF81E16D7531C0DF18559FDBDDD3CCE93B89175DF03EF2EF10A56E821FF1D66A7FE3F66DF307F2FC0A1763FA8AA28D97D01BF7073903D0E1AF51499B341D55C4D47FB02933D01BC9D81924FF17629C0EF5123ACC7A8B15EEC5B8471FBA7274EEC4BF1894CF4E908A5CBEC931C43D5A12B02C7BE8ADE158529928F33B47D59FB32CF13FB9A76CBF53361EEC676FD8C6ADA7740E8DD2E08A56AD95DF543F0F70F9C6CEBF5D5F24E66EFF2525DD650CC0A2BC475BB2E962BADDA750393D5ECBAA1B1D5786E284C2D9E0B085D89B78CD70C08BF6A7B2F0D353DD78FE6B0DEC5B9FAA5A8CC11D53D366C692B1B2D85F7453B87C22A44171594D4204EC4BBB022D1854CA61ED1D54D11971BEA09DA539D1E93C674A0BA387596D70445828ED9B0BA97A2BD95D799CD2D3C6B8FBA7A6E0BF5334FB3DE327FFB75E98E36B3E3F8F4C6A9B6CD717977B66D5189BAEE957593A4EDBBAFBA4DCCCD38EAE6A0C1F2F7904333F28AAAC8B62F229163B7F1E443ECAB9F9BAA33329D961F791A94A8F331E9FC16955C7FEAFD17AFF7F21C3B51E7BDE9BDB86A8ACF2E66B5912E1AE255CEA056AA7D4DC4D7EC658EF5B7BD76767DB4554A9C2FAE2FA9124D87BB7CE493CAF9C944173CC3722BD1B47D1F839929574D578D2596E875C5A5DB1D51A196701D85498DB6A5580C98412DDC9117614D252AB1AD8A93E85F599195235BAA9B9334B3E995574F6D2B20D603D987161DB82EEA38456651E9C4A7FE60D781F84F42B06354C5EB11A2FE2F43B296A011B4EF7395ADF2DE756128EABB7071760422EC519C95285E8110E1CF2136A6E695F717906CEAD7A07409A3ABEC76838A0DC22CC37499507FF0B1F68154F337E55C34CDF3DBA2A95D9A82054C665CBF0BDC663F6EE2241AE8BE14C4CB2510B573D53D0135A984F553D0FA6540BAC93343A04E7C834FF800D322C160D56D56BFEEC969D3CB9096D8FC2206EB12A45587318EC7BF62F58BD2E7EFFF0F41AD254FE6660000, 
'6.0.2-21211');