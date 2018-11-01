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
        private HttpPostedFileBase _foto;
        private int _idcategoria;
        private Byte[] _fotoByte;
        private List<Preg> _preguntas;

        public Personaje()
        { }

        public Personaje(int id, string nombre, HttpPostedFileBase foto, int idcategoria, Byte[] fotoByte, List<Preg> preguntas)
        {
            _id = id;
            _nombre = nombre;
            _foto = foto;
            _idcategoria = idcategoria;
            _fotoByte = fotoByte;
            _preguntas = preguntas;
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

        public Byte[] FotoByte
        {
            get
            {
                return _fotoByte;
            }

            set
            {
                _fotoByte = value;
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

        public HttpPostedFileBase Foto
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