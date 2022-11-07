// See https://aka.ms/new-console-template for more information
using Bogus;
using Bogus.Extensions;
using HaendlerDb;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;

internal class Program
{
    private static void Main(string[] args)
    {
        if (args.Length < 1)
        {
            Console.Error.WriteLine("Missing args.");
            Console.Error.WriteLine("Usage: dotnet run -- (sqlserver|oracle|sqlite)");
            return;
        }
        var options = MultiDbContext.GetConnectionInteractive(dbms: args[0].ToLower(), database: "HaendlerDb");
        if (options is null) { return; }
        var db = new HaendlerDbContext(options);
        db.Database.EnsureDeleted();
        db.Database.EnsureCreated();
        db.Seed();
    }
}

