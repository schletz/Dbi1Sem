using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace HaendlerDb
{
    public class Artikel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int EAN { get; set; }
        [MaxLength(200)]
        public string Name { get; set; } = default!;
        [MaxLength(200)]
        public string Kategorie { get; set; } = default!;

        [InverseProperty("ArtikelNavigation")]
        public virtual ICollection<Angebot> Angebot { get; set; } = default!;
    }
}