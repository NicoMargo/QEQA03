using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QEQ.Models
{
    public class Preg
    {
        private int _id;
        private string _texto;
        private string _grupo;

        public int Id
        {
            get
            {
                return _id;
            }

            set
            {
                _id = value;
            }
        }

        public string Texto
        {
            get
            {
                return _texto;
            }

            set
            {
                _texto = value;
            }
        }

        public string Grupo
        {
            get
            {
                return _grupo;
            }

            set
            {
                _grupo = value;
            }
        }
    
        public Preg(int _id, string _texto, string _grupo)
        {
            this.Id = _id;
            this.Texto = _texto;
            this.Grupo = _grupo;
        }
    }
}