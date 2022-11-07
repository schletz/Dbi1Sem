using SemesterpruefungDb;
using System;

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
        var options = MultiDbContext.GetConnectionInteractive(dbms: args[0].ToLower(), database: "SempruefDb");
        if (options is null) { return; }
        var db = new SempruefDbContext(options);
        db.Database.EnsureDeleted();
        db.Database.EnsureCreated();
        db.Seed();
    }
}

