

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace SemesterpruefungDb
{
    public class Lehrer
    {
        [Key]
        [StringLength(10)]
        public string L_Nr { get; set; } = default!;
        [StringLength(255)]
        public string L_Zuname { get; set; } = default!;
        [StringLength(255)]
        public string L_Vorname { get; set; } = default!;
        public virtual ICollection<Klasse> Klasse { get; set; } = default!;
        public virtual ICollection<Sempruef> Sempruef { get; set; } = default!;
    }
}