using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using QEQ.Models;

namespace QEQ.Models
{
    public class Partida
    {
        private int _id;
        private int _usuario1;
        private int _usuario2;
        private string _ip1;
        private string _ip2;
        private Personaje _personaje1;
        private Personaje _personaje2;
        private int _puntos;
        private int _cantPreguntas;
        private bool _multijugador;
        private bool _ganador;
        private DateTime _fecha;
        private List<Personaje> _personajes;

        public int Id { get { return _id; } set { _id = value; } }
        public int Usuario1 { get { return _usuario1; } set { _usuario1 = value; } }
        public int Usuario2 { get { return _usuario2; } set { _usuario2 = value; } }
        public string Ip1 { get { return _ip1; } set { _ip1 = value; } }
        public string Ip2 { get { return _ip2; } set { _ip2 = value; } }
        public int CantPreguntas { get { return _cantPreguntas; } set { _cantPreguntas = value; } }
        public bool Multijugador { get { return _multijugador; } }
        public bool Ganador { get { return _ganador; } }
        public DateTime Fecha { get { return _fecha; } set { _fecha = value; } }

        public Personaje Personaje1 { get { return _personaje1; } set { _personaje1 = value; } }
        public Personaje Personaje2 { get { return _personaje2; } set { _personaje2 = value; } }
        public int Puntos { get { return _puntos; } set { _puntos = value; } }
        public List<Personaje> Personajes { get { return _personajes; } set { _personajes = value; } }

        public Partida() {}
        //Constructor singleplayer
        public Partida(int idUsuario, string ip, int ipuntos)
        {
            _usuario1 = idUsuario;
            _ip1 = ip;
            _fecha = DateTime.Today;
            _cantPreguntas = 0;
            _multijugador = false;
            Random random = new Random();
            _personaje1 = BD.Personajes[random.Next(0,BD.Personajes.Count()-1)];
            _puntos = ipuntos;
        }


        public Partida(int Host, string ipH, bool multi)
        {
            _usuario1 = Host;
            _ip1 = ipH;
            _fecha = DateTime.Today;
            _cantPreguntas = 0;
            _multijugador = multi;
        }
        public void Unirse(int Guest, string ipG)
        {
            _usuario1 = Guest;
            _ip1 = ipG;
        }
        public void Finalizar(bool Ganador) {
            _ganador = Ganador;
        }

    }
}