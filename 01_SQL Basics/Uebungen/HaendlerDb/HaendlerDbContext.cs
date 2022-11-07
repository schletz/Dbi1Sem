using System;
using System.Collections.Generic;
using System.Formats.Asn1;
using System.Globalization;
using System.IO;
using System.Linq;
using CsvHelper;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace HaendlerDb
{
    public class HaendlerDbContext : MultiDbContext
    {
        public HaendlerDbContext(DbContextOptions options) : base(options) { }

        public virtual DbSet<Angebot> Angebot { get; set; } = default!;
        public virtual DbSet<Artikel> Artikel { get; set; } = default!;
        public virtual DbSet<Haendler> Haendler { get; set; } = default!;

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
        }
        public void Seed()
        {
            var artikel = ReadCsv<Artikel>("Artikel.csv");
            Artikel.AddRange(artikel);
            SaveChanges();
            var haendler = ReadCsv<Haendler>("Haendler.csv");
            Haendler.AddRange(haendler);
            SaveChanges();
            var angebot = ReadCsv<Angebot>("Angebot.csv");
            Angebot.AddRange(angebot);
            SaveChanges();
        }
        private IList<T> ReadCsv<T>(string filename)
        {
            using var reader = new StreamReader(path: Path.Combine("csv", filename), encoding: new System.Text.UTF8Encoding(false));
            using var csv = new CsvReader(reader, CultureInfo.InvariantCulture);
            csv.Context.RegisterClassMap<AngebotMap>();
            return csv.GetRecords<T>().ToList();
        }
    }
}