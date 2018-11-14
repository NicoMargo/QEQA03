using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QEQ.Models
{
    public class Usuario
    {
        private int _id;
        private string _nombre;
        private string _username;
        private string _pass;
        private int _puntos;
        private string _ip;
        private string _email;
        private string _mac;
        private bool _admin;

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
        public bool Admin
        {
            get
            {
                return _admin;
            }

            set
            {
                _admin = value;
            }
        }
        public string Username
        {
            get
            {
                return _username;
            }

            set
            {
                _username = value;
            }
        }
        public string Pass
        {
            get
            {
                return _pass;
            }

            set
            {
                _pass = value;
            }
        }
        public int Puntos
        {
            get
            {
                return _puntos;
            }

            set
            {
                _puntos = value;
            }
        }
        public string Email
        {
            get
            {
                return _email;
            }

            set
            {
                _email = value;
            }
        }
        public string Mac
        {
            get
            {
                return _mac;
            }

            set
            {
                _mac = value;
            }
        }
        public string Ip
        {
            get
            {
                return _ip;
            }

            set
            {
                _ip = value;
            }
        }

        public int Id
        {
            get { return _id; }
            set { _id = value; }
        }

        public Usuario(int id,string nombre, string username, string pass, int puntos, string ip, string email, string mac, bool admin)
        {
            _id = id;
            Nombre = nombre;
            Username = username;
            Pass = pass;    
            Puntos = puntos;
            Ip = ip;
            Email = email;
            Mac = mac;
            Admin = admin;
        }

        public Usuario(bool aux)
        {
            _id = 0;
            Nombre = "Invitado";
            Username = "Guest";
            Admin = false;
        }

        public Usuario()
        {
           
        }

    }
}