using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace HaendlerDb
{
    public class Haendler
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int U_ID { get; set; }
        [Required]
        [MaxLength(200)]
        public string Name { get; set; } = default!;
        [MaxLength(5)]
        public string Land { get; set; } = default!;
        [MaxLength(200)]
        public string? URL { get; set; } = default!;

        [InverseProperty("HaendlerNavigation")]
        public virtual ICollection<Angebot> Angebot { get; set; } = default!;
    }
}