﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SchneeDbGenerator
{
    public class Bundesland
    {
        [Key]
        [StringLength(5)]
        public string B_Nr { get; set; } = default!;
        [StringLength(255)]
        public string B_Name { get; set; } = default!;

        [InverseProperty("S_BundeslandNavigation")]
        public virtual ICollection<Skigebiet> Skigebiete { get; set; }
    }
}