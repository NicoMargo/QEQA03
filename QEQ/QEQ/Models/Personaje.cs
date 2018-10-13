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
        private string _categoria;

        public Personaje(int _id, string _nombre, string _foto, string _categoria)
        {
            this._id = _id;
            this._nombre = _nombre;
            this._foto = _foto;
            this._categoria = _categoria;
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

        public string Categoria
        {
            get
            {
                return _categoria;
            }

            set
            {
                _categoria = value;
            }
        }
    }
}