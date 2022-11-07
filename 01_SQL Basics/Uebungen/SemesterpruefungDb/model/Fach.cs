

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace SemesterpruefungDb
{
    public class Fach
    {
        [Key]
        [StringLength(10)]
        public string F_Nr { get; set; } = default!;
        [StringLength(255)]
        public string F_Name { get; set; } = default!;
        [InverseProperty("SP_FachNavigation")]
        public virtual ICollection<Sempruef> Sempruef { get; set; } = default!;
    }
}