﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace SchneeDbGenerator
{
    [Index("S_Bundesland", Name = "Bundeslandskigebiete")]
    public class Skigebiet
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int S_ID { get; set; }
        [StringLength(5)]
        public string S_Bundesland { get; set; } = default!;
        [StringLength(255)]
        public string S_Name { get; set; } = default!;
        [StringLength(255)]
        public string OrteimGebiet { get; set; } = default!;
        [StringLength(255)]
        public string Tourismusregion { get; set; } = default!;
        [StringLength(255)]
        public string Schiverbund { get; set; } = default!;
        public int? seehoehevon { get; set; }
        public int? seehoehebis { get; set; }
        [Column(TypeName = "decimal(18, 4)")]
        public decimal? Pistenkm { get; set; }
        public int? S_gondeln { get; set; }
        public int? S_sessel { get; set; }
        public int? S_schlepp { get; set; }

        [ForeignKey("S_Bundesland")]
        [InverseProperty("Skigebiete")]
        [CsvHelper.Configuration.Attributes.Ignore]
        public virtual Bundesland S_BundeslandNavigation { get; set; }
        [InverseProperty("M_SkigebietNavigation")]
        public virtual ICollection<Messstelle> Messstellen { get; set; }
    }
}