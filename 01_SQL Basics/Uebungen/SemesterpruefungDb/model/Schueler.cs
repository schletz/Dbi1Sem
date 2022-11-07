using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace SemesterpruefungDb
{
    [Index("S_Klasse", Name = "KlasseSchueler")]
    public class Schueler
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int S_Id { get; set; }
        [StringLength(255)]
        public string S_Zuname { get; set; } = default!;
        [StringLength(255)]
        public string S_Vorname { get; set; } = default!;
        [StringLength(1)]
        public string? S_Geschl { get; set; }
        [StringLength(10)]
        public string S_Klasse { get; set; } = default!;
        [ForeignKey("S_Klasse")]
        [CsvHelper.Configuration.Attributes.Ignore]
        public virtual Klasse S_KlasseNavigation { get; set; } = default!;
        public virtual ICollection<Sempruef> Sempruef { get; set; } = default!;
    }
}