// See https://aka.ms/new-console-template for more information
using Bogus;
using Bogus.Extensions;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

Randomizer.Seed = new Random(1624);

var opt = new DbContextOptionsBuilder()
    .UseSqlite("Data Source=Teams.db")
    .Options;

using var db = new FilialContext(opt);
db.Database.EnsureDeleted();
db.Database.EnsureCreated();

var departments = new string[] { "KIF", "AIF" };
var subjects = new string[] { "POS", "DBI", "AM" };


var teams = new Faker<Team>("de").CustomInstantiator(f =>
{
    var klasse = $"{f.Random.Int(0, 2) * 2 + 1}{f.Random.String2(1, "ABC")}{f.Random.ListItem(departments)}";
    return new Team
    {
        Name = $"SJ21/22_{klasse}",
        Klasse = klasse,
        Students = new Faker<Student>("de").CustomInstantiator(f =>
        {
            var gender = f.Random.Enum<Gender>();
            return new Student
            {
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


var aufgaben = new Faker<Aufgabe>("de").CustomInstantiator(f =>
{
    return new Aufgabe
    {
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


public class FilialContext : DbContext
{
    public FilialContext(DbContextOptions opt) : base(opt)
    {

    }

    protected override void OnModelCreating(ModelBuilder mb)
    {
        mb.Entity<Abgabe>().HasKey(a => new { a.AufgabeId, a.StudentId });
    }

    public DbSet<Team> Teams => Set<Team>();
    public DbSet<Aufgabe> Aufgaben => Set<Aufgabe>();
    public DbSet<Abgabe> Abgaben => Set<Abgabe>();
    public DbSet<Student> Studenten => Set<Student>();

}

[Table("Team")]

public class Team
{
    public int Id { get; set; }
    public string Name { get; set; }
    public string Klasse { get; set; }
    public List<Student> Students { get; set; }
}



[Table("Aufgabe")]

public class Aufgabe
{
    public int Id { get; set; }
    public int TeamId { get; set; }
    public string Subject { get; set; }
    public string Name { get; set; }
    public Team Team { get; set; }
    public int MaxPunkte { get; set; }

}
[Table("Abgabe")]

public class Abgabe
{
    public int AufgabeId { get; set; }
    public Aufgabe Aufgabe { get; set; }
    public int StudentId { get; set; }
    public Student Student { get; set; }
    public DateTime? KorrigiertAm { get; set; }
    public int? Punkte { get; set; }
}

[Table("Student")]

public class Student
{
    public int Id { get; set; }
    public string Vorname { get; set; }
    public string Nachname { get; set; }
    public Gender Gender { get; set; }
    public int TeamId { get; set; }
    public Team Team { get; set; }
}

public enum Gender { F = 1, M }