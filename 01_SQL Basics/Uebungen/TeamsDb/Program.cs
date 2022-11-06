// See https://aka.ms/new-console-template for more information
using Bogus;
using Bogus.Extensions;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;

if (args.Length < 1)
{
    Console.Error.WriteLine("Missing args.");
    Console.Error.WriteLine("Usage: dotnet run -- (sqlserver|oracle|sqlite)");
    return;
}
var options = MultiDbContext.GetConnectionInteractive(dbms: args[0].ToLower(), database: "TeamsDb");
if (options is null) { return; }
using var db = new TeamsContext(options);
db.Database.EnsureDeleted();
db.Database.EnsureCreated();

Randomizer.Seed = new Random(1624);
var departments = new string[] { "KIF", "AIF" };
var subjects = new string[] { "POS", "DBI", "AM" };

int rownr = 1;
int rownr2 = 1;
var teams = new Faker<Team>("de").CustomInstantiator(f =>
{
    var klasse = $"{f.Random.Int(0, 2) * 2 + 1}{f.Random.String2(1, "ABC")}{f.Random.ListItem(departments)}";
    return new Team
    {
        Id = rownr++,
        Name = $"SJ21/22_{klasse}",
        Klasse = klasse,
        Students = new Faker<Student>("de").CustomInstantiator(f =>
        {
            var gender = f.Random.Enum<Gender>();
            return new Student
            {
                Id = rownr2++,
                Vorname = f.Name.FirstName(gender == Gender.M ? Bogus.DataSets.Name.Gender.Male : Bogus.DataSets.Name.Gender.Female),
                Nachname = f.Name.LastName(gender == Gender.M ? Bogus.DataSets.Name.Gender.Male : Bogus.DataSets.Name.Gender.Female),
                Gender = gender
            };
        })
        .Generate(f.Random.Int(10, 20))
        .ToList()
    };
})
.Generate(5)
.ToList();
db.Teams.AddRange(teams);
db.SaveChanges();

rownr = 1;
var aufgaben = new Faker<Aufgabe>("de").CustomInstantiator(f =>
{
    return new Aufgabe
    {
        Id = rownr++,
        Subject = f.Random.ListItem(subjects),
        Name = f.Commerce.ProductDescription(),
        Team = f.Random.ListItem(teams),
        MaxPunkte = f.Random.Int(16, 48)
    };
})
.Generate(10)
.ToList();
db.Aufgaben.AddRange(aufgaben);
db.SaveChanges();

var aufgabenAbgegeben = aufgaben.Take(aufgaben.Count - 2).ToList();
var abgaben = new Faker<Abgabe>("de").CustomInstantiator(f =>
{
    var aufgabe = f.Random.ListItem(aufgabenAbgegeben);
    var korrektur = new DateTime(2021, 10, 1).AddSeconds(f.Random.Int(0, 30 * 86400)).OrNull(f, 0.5f);
    return new Abgabe
    {
        Aufgabe = aufgabe,
        Student = f.Random.ListItem(aufgabe.Team.Students),
        KorrigiertAm = korrektur,
        Punkte = korrektur.HasValue ? f.Random.Int(0, aufgabe.MaxPunkte) : null
    };
})
.Generate(150)
.GroupBy(a => new { a.Aufgabe, a.Student })
.Select(g => g.First())
.ToList();
db.Abgaben.AddRange(abgaben);
db.SaveChanges();


public class TeamsContext : MultiDbContext
{
    public TeamsContext(DbContextOptions opt) : base(opt)
    {

    }

    protected override void OnModelCreating(ModelBuilder mb)
    {
        base.OnModelCreating(mb);
        mb.Entity<Abgabe>().HasKey(a => new { a.AufgabeId, a.StudentId });
        mb.Entity<Abgabe>().HasOne(a => a.Student).WithMany().OnDelete(DeleteBehavior.Restrict);
    }

    public DbSet<Team> Teams => Set<Team>();
    public DbSet<Aufgabe> Aufgaben => Set<Aufgabe>();
    public DbSet<Abgabe> Abgaben => Set<Abgabe>();
    public DbSet<Student> Studenten => Set<Student>();

}

[Table("Team")]

public class Team
{
    [DatabaseGenerated(DatabaseGeneratedOption.None)]
    public int Id { get; set; }
    public string Name { get; set; } = default!;
    public string Klasse { get; set; } = default!;
    public List<Student> Students { get; set; } = default!;
}



[Table("Aufgabe")]

public class Aufgabe
{
    [DatabaseGenerated(DatabaseGeneratedOption.None)]
    public int Id { get; set; }
    public int TeamId { get; set; }
    public string Subject { get; set; } = default!;
    public string Name { get; set; } = default!;
    public Team Team { get; set; } = default!;
    public int MaxPunkte { get; set; }

}
[Table("Abgabe")]

public class Abgabe
{
    public int AufgabeId { get; set; }
    public Aufgabe Aufgabe { get; set; } = default!;
    public int StudentId { get; set; }
    public Student Student { get; set; } = default!;
    public DateTime? KorrigiertAm { get; set; }
    public int? Punkte { get; set; }
}

[Table("Student")]

public class Student
{
    [DatabaseGenerated(DatabaseGeneratedOption.None)]
    public int Id { get; set; }
    public string Vorname { get; set; } = default!;
    public string Nachname { get; set; } = default!;
    public Gender Gender { get; set; }
    public int TeamId { get; set; }
    public Team Team { get; set; } = default!;
}

public enum Gender { F = 1, M }