using CsvHelper.Configuration;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.RegularExpressions;

namespace HaendlerDb
{
    public class Angebot
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ID { get; set; }
        public int Artikel { get; set; }
        public int Haendler { get; set; }
        public DateTime Tag { get; set; }
        [Column(TypeName = "DECIMAL(9,4)")]
        public decimal? Preis { get; set; }
        public int? AnzVerkaeufe { get; set; }
        [MaxLength(200)]
        public string? URL { get; set; } = default!;

        [ForeignKey("Artikel")]
        [InverseProperty("Angebot")]
        [CsvHelper.Configuration.Attributes.Ignore]
        public virtual Artikel ArtikelNavigation { get; set; } = default!;
        [ForeignKey("Haendler")]
        [InverseProperty("Angebot")]
        [CsvHelper.Configuration.Attributes.Ignore]
        public virtual Haendler HaendlerNavigation { get; set; } = default!;
    }
    public sealed class AngebotMap : ClassMap<Angebot>
    {
        public AngebotMap()
        {
            Map(s => s.ID).Name("ID");
            Map(s => s.Artikel).Name("Artikel");
            Map(s => s.Haendler).Name("Haendler");
            Map(s => s.Tag).Convert(args =>
                DateTime.TryParseExact(args.Row["Tag"], "yyyy-MM-dd", default, default, out var result) 
                ? result 
                : throw new Exception($"Invalid DateTime: {args.Row["Tag"]}"));
            Map(s => s.Preis).Name("Preis");
            Map(s => s.AnzVerkaeufe).Name("AnzVerkaeufe");
            Map(s => s.URL).Name("URL");
        }
    }

}