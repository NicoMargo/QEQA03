using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QEQ.Models
{
    public class Cat
    {
        private int _id;
        private string _nombre;

        public Cat(int _id, string _nombre)
        {
            this._id = _id;
            this._nombre = _nombre;
        }
        public Cat()
        { }

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
    }
}