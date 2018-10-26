using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QEQ.Models
{
    public class Personaje
    {
        private int _id;
        private string _nombre;
        private string _foto;
        private int _idcategoria;
        private List<Preg> _preguntas;

        public Personaje()
        { }

        public Personaje(int _id, string _nombre, string _foto, int _categoria)
        {
            this._id = _id;
            this._nombre = _nombre;
            this._foto = _foto;
            this._idcategoria = _categoria;
        }

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

        public string Nombre
        {
            get
            {
                return _nombre;
            }

            set
            {
                _nombre = value;
            }
        }

        public string Foto
        {
            get
            {
                return _foto;
            }

            set
            {
                _foto = value;
            }
        }

        public int idCategoria
        {
            get
            {
                return _idcategoria;
            }

            set
            {
                _idcategoria = value;
            }
        }
        public List<Preg> Preguntas
        {
            get
            {
                return _preguntas;
            }

            set
            {
                _preguntas = value;
            }
        }
    }
}