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
        private int _puntos;

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

        public int idGrupo
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

        public int Puntos { get { return _puntos; } set { _puntos = value; } }

        public Preg(int _id, string _texto, int _grupo, int puntos)
        {
            this._id= _id;
            this._texto = _texto;
            this._idgrupo = _grupo;
            this._puntos = puntos;
        }
        public Preg()
        {

        }
    }
}