// See https://aka.ms/new-console-template for more information
using Bogus;
using Bogus.Extensions;
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
        var options = MultiDbContext.GetConnectionInteractive(dbms: args[0].ToLower(), database: "FilialDb");
        if (options is null) { return; }
        using var db = new FilialContext(options);
        db.Database.EnsureDeleted();
        db.Database.EnsureCreated();

        Randomizer.Seed = new Random(1624);

        int rownr = 1;
        var produktkategorien = new Faker<Produktkategorie>("de").CustomInstantiator(f =>
        {
            return new Produktkategorie
            {
                Name = f.Commerce.ProductAdjective()
            };
        })
        .Generate(100)
        .GroupBy(p => p.Name).Select(g => g.First())
        .Take(10)
        .Select(p => { p.Id = rownr++; return p; })
        .ToList();
        db.Produktkategorien.AddRange(produktkategorien);
        db.SaveChanges();

        rownr = 1;
        var filialen = new Faker<Filiale>("de").CustomInstantiator(f =>
        {
            var plz = f.Random.Int(100, 299) * 10;
            return new Filiale
            {
                Id = rownr++,
                Strasse = f.Address.StreetAddress(),
                Ort = f.Address.City(),
                Plz = f.Random.Int(100, 299) * 10,
                Bundesland = plz < 2000 ? "W" : "NÖ"
            };
        })
        .Generate(10);
        db.Filialen.AddRange(filialen);
        db.SaveChanges();

        var kategorienMitProdukten = produktkategorien.Take(8).ToList();
        var produkte = new Faker<Produkt>("de").CustomInstantiator(f =>
        {
            decimal basePrice = f.Random.Int(1990, 199000) / 100M;
            return new Produkt
            {
                Ean = f.Random.Int(100000, 999999).ToString(),
                Name = f.Commerce.ProductName(),
                Basispreis = basePrice,
                Produktkategorie = f.Random.ListItem(kategorienMitProdukten).OrDefault(f, 0.2f),
                Filialpreise = new Faker<Filialpreis>("de").CustomInstantiator(f =>
                {
                    var verkaufstart = new DateTime(2020, 1, 1).AddDays(f.Random.Int(0, 365));
                    var verkaufsende = verkaufstart.AddDays(f.Random.Int(14, 365)).OrNull(f, 0.5f);
                    return new Filialpreis
                    {
                        Verkaufstart = verkaufstart,
                        Verkaufsende = verkaufsende,
                        Filiale = f.Random.ListItem(filialen),
                        Preis = Math.Round(basePrice * f.Random.Decimal(0.9M, 1.1M), 2),
                    };
                })
                .Generate(f.Random.Int(0, 3))
                .GroupBy(f => f.ProduktEan).Select(g => g.First())
                .ToList()
            };
        })
        .Generate(100)
        .ToList();
        db.Produkte.AddRange(produkte);
        db.SaveChanges();
    }
}

public class FilialContext : MultiDbContext
{
    public FilialContext(DbContextOptions opt) : base(opt)
    {

    }

    protected override void OnModelCreating(ModelBuilder mb)
    {
        base.OnModelCreating(mb);
        mb.Entity<Filialpreis>().HasKey(f => new { f.FilialeId, f.ProduktEan });
    }

    public DbSet<Filiale> Filialen => Set<Filiale>();
    public DbSet<Filialpreis> Filialpreise => Set<Filialpreis>();
    public DbSet<Produkt> Produkte => Set<Produkt>();
    public DbSet<Produktkategorie> Produktkategorien => Set<Produktkategorie>();
}
[Table("Filiale")]
public class Filiale
{
    [DatabaseGenerated(DatabaseGeneratedOption.None)]
    public int Id { get; set; }
    public string Strasse { get; set; } = default!;
    public int Plz { get; set; }
    public string Ort { get; set; } = default!;
    public string Bundesland { get; set; } = default!;
}

[Table("Filialpreis")]
public class Filialpreis
{
    public int FilialeId { get; set; }
    public Filiale Filiale { get; set; } = default!;
    public string ProduktEan { get; set; } = default!;
    public Produkt Produkt { get; set; } = default!;
    [Column(TypeName = "DECIMAL(9,4)")]
    public decimal Preis { get; set; }
    [Column(TypeName = "DATE")]
    public DateTime Verkaufstart { get; set; }
    [Column(TypeName = "DATE")]
    public DateTime? Verkaufsende { get; set; }
}

[Table("Produkt")]
public class Produkt
{
    [Key]
    public string Ean { get; set; } = default!;
    public string Name { get; set; } = default!;
    [Column(TypeName = "DECIMAL(9,4)")]
    public decimal Basispreis { get; set; }
    public int? ProduktkategorieId { get; set; }
    public Produktkategorie? Produktkategorie { get; set; } = default!;
    public ICollection<Filialpreis> Filialpreise { get; set; } = default!;
}

[Table("Produktkategorie")]
public class Produktkategorie
{
    [DatabaseGenerated(DatabaseGeneratedOption.None)]
    public int Id { get; set; }
    public string Name { get; set; } = default!;
}
