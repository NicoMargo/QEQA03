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
        private int _idgrupo;

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

        public int Idgrupo
        {
            get
            {
                return _idgrupo;
            }

            set
            {
                _idgrupo = value;
            }
        }

        public Preg(int _id, string _texto, int _idgrupo)
        {
            this.Id = _id;
            this.Texto = _texto;
            this.Idgrupo = _idgrupo;
        }
    }
}