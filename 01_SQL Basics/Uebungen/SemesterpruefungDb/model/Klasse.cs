

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace SemesterpruefungDb
{
    public class Klasse
    {
        [Key]
        [StringLength(10)]
        public string K_Nr { get; set; } = default!;
        [Required]
        [StringLength(10)]
        public string K_KV { get; set; } = default!;

        [ForeignKey("K_KV")]
        [CsvHelper.Configuration.Attributes.Ignore]
        public virtual Lehrer K_KVNavigation { get; set; } = default!;
        public virtual ICollection<Schueler> Schueler { get; set; } = default!;
    }
}