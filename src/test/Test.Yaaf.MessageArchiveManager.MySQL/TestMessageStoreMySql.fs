﻿// ----------------------------------------------------------------------------
// This file is subject to the terms and conditions defined in
// file 'LICENSE.txt', which is part of this source code package.
// ----------------------------------------------------------------------------
namespace Test.Yaaf.MessageArchiveManager.MySQL

open Yaaf.Xmpp
open FsUnit
open NUnit.Framework
open Yaaf.Helper
open Yaaf.TestHelper
open Yaaf.Database
open Yaaf.Xmpp.IM.Server
open MySql.Data.Entity
open System.Data.Entity
open Yaaf.Xmpp.MessageArchiveManager.Sql
open Test.Yaaf.MessageArchiveManager
open Yaaf.Xmpp.MessageArchiving
open Yaaf.Xmpp.MessageArchiveManager.Sql.MySql

[<DbConfigurationType (typeof<MySqlEFConfiguration>)>]
type ApplicationDbTestContext() as x = 
    inherit MySqlArchiveManagerDbContext(
      (let env = System.Environment.GetEnvironmentVariable ("connection_mysql")
       if System.String.IsNullOrWhiteSpace env then "ArchiveDb_MySQL" else env), false)
    do ()
      //System.Data.Entity.Database.SetInitializer(new NUnitInitializer<ApplicationDbTestContext>())
      //x.Database.Initialize(false)

[<Ignore>]     
[<TestFixture>]
[<Category("MYSQL")>]
type ``Test-Yaaf-MessageArchiveManager-MySQL: Check that Sql backend is ok``() = 
    inherit MessageArchivingStoreTest()
    
    override x.Setup() =
        // Fix for some bug, see http://stackoverflow.com/questions/15693262/serialization-exception-in-net-4-5
        System.Configuration.ConfigurationManager.GetSection("dummy") |> ignore
        base.Setup()

    override x.CreateArchivingStore(jid) = 
        System.Data.Entity.Database.SetInitializer<ApplicationDbTestContext>(null)
        use context = new ApplicationDbTestContext() :> AbstractMessageArchivingDbContext
        context.Database.Delete() |> ignore
        context.SaveChanges() |> ignore
        context.Upgrade()
        let store = MessageArchivingStore(fun () -> new ApplicationDbTestContext() :> AbstractMessageArchivingDbContext) :> IMessageArchivingStore
        store.GetArchiveStore (jid) |> waitTask

[<TestFixture>]
[<Category("MYSQL")>]
type ``Test-Yaaf-MessageArchiveManager-MySQL: Test preference store MySQL backend``() = 
    inherit PreferenceStoreTests()
    
    override x.Setup() =
        // Fix for some bug, see http://stackoverflow.com/questions/15693262/serialization-exception-in-net-4-5
        System.Configuration.ConfigurationManager.GetSection("dummy") |> ignore
        base.Setup()

    override x.CreatePreferenceStore(jid) = 
        System.Data.Entity.Database.SetInitializer<ApplicationDbTestContext>(null)

        use context = new ApplicationDbTestContext() :> AbstractMessageArchivingDbContext
        context.Database.Delete() |> ignore
        context.SaveChanges() |> ignore
        context.Upgrade()
                
        let store = MessageArchivingStore(fun () -> new ApplicationDbTestContext() :> AbstractMessageArchivingDbContext) :> IMessageArchivingStore
        store.GetPreferenceStore (jid) |> waitTask
