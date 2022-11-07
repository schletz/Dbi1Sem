

using System;
using System.Collections.Generic;
using CsvHelper;
using System.Globalization;
using System.IO;
using System.Reflection.Metadata;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using System.Linq;

namespace SemesterpruefungDb
{
    public class SempruefDbContext : MultiDbContext
    {
        public SempruefDbContext(DbContextOptions options)
            : base(options)
        {
        }

        public virtual DbSet<Fach> Fach { get; set; } = default!;
        public virtual DbSet<Klasse> Klasse { get; set; } = default!;
        public virtual DbSet<Lehrer> Lehrer { get; set; } = default!;
        public virtual DbSet<Schueler> Schueler { get; set; } = default!;
        public virtual DbSet<Sempruef> Sempruef { get; set; } = default!;

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.Entity<Sempruef>().HasOne(s => s.SP_SchuelerNavigation)
                .WithMany(s => s.Sempruef)
                .OnDelete(DeleteBehavior.Restrict);
        }

        public void Seed()
        {
            var faecher = ReadCsv<Fach>("Fach.csv");
            Fach.AddRange(faecher);
            SaveChanges();
            var lehrer = ReadCsv<Lehrer>("Lehrer.csv");
            Lehrer.AddRange(lehrer);
            SaveChanges();
            var klassen = ReadCsv<Klasse>("Klasse.csv");
            Klasse.AddRange(klassen);
            SaveChanges();
            var schueler = ReadCsv<Schueler>("Schueler.csv");
            Schueler.AddRange(schueler);
            SaveChanges();
            var sempruef = ReadCsv<Sempruef>("Sempruef.csv");
            Sempruef.AddRange(sempruef);
            SaveChanges();
        }
        private IList<T> ReadCsv<T>(string filename)
        {
            using var reader = new StreamReader(path: Path.Combine("csv", filename), encoding: new System.Text.UTF8Encoding(false));
            using var csv = new CsvReader(reader, CultureInfo.InvariantCulture);
            //csv.Context.RegisterClassMap<AngebotMap>();
            return csv.GetRecords<T>().ToList();
        }
    }
}