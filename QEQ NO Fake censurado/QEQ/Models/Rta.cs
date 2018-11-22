using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QEQ.Models
{
    public class Rta
    {
        private int id;
        private int idPregunta;
        private int idPersona;
        public int Id
        {
            get
            {
                return id;
            }

            set
            {
                id = value;
            }
        }

        public int IdPregunta
        {
            get
            {
                return idPregunta;
            }

            set
            {
                idPregunta = value;
            }
        }

        public int IdPersona
        {
            get
            {
                return idPersona;
            }

            set
            {
                idPersona = value;
            }
        }

        public Rta(int id, int idPregunta, int idPersona)
        {
            this.Id = id;
            this.IdPregunta = idPregunta;
            this.IdPersona = idPersona;
        }

        /* public int Id { get => id;  }
         public int IdPregunta { get => idPregunta; }
         public int IdPersona { get => idPersona; }
         */
    }
}