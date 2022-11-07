using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace SemesterpruefungDb
{
    public class Sempruef
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int SP_Id { get; set; }
        public int SP_Schueler { get; set; }
        [StringLength(10)]
        public string SP_Fach { get; set; } = default!;
        [StringLength(10)]
        public string SP_Lehrer { get; set; } = default!;
        public int? SP_Note { get; set; }
        public DateTime? SP_Datum { get; set; }
        [ForeignKey("SP_Fach")]
        [CsvHelper.Configuration.Attributes.Ignore]
        public virtual Fach SP_FachNavigation { get; set; } = default!;
        [ForeignKey("SP_Lehrer")]
        [CsvHelper.Configuration.Attributes.Ignore]
        public virtual Lehrer SP_LehrerNavigation { get; set; } = default!;
        [ForeignKey("SP_Schueler")]
        [CsvHelper.Configuration.Attributes.Ignore]
        public virtual Schueler SP_SchuelerNavigation { get; set; } = default!;
    }
}