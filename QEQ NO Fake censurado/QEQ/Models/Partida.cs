using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using QEQ.Models;

namespace QEQ.Models
{
    public class Partida
    {
        private int _nroUsuario;//1 o 0
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
        private int _ganador;
        private DateTime _fecha;
        private int _idcat;
        private bool _turno;


        public int Id { get { return _id; } set { _id = value; } }
        public int Usuario1 { get { return _usuario1; } set { _usuario1 = value; } }
        public int Usuario2 { get { return _usuario2; } set { _usuario2 = value; } }
        public string Ip1 { get { return _ip1; } set { _ip1 = value; } }
        public string Ip2 { get { return _ip2; } set { _ip2 = value; } }
        public int CantPreguntas { get { return _cantPreguntas; } set { _cantPreguntas = value; } }
        public bool Multijugador { get { return _multijugador; } set { _multijugador = value; } }
        public int Ganador { get { return _ganador; } set { _ganador = value; } }
        public DateTime Fecha { get { return _fecha; } set { _fecha = value; } }

        public Personaje Personaje1 { get { return _personaje1; } set { _personaje1 = value; } }
        public Personaje Personaje2 { get { return _personaje2; } set { _personaje2 = value; } }
        public int Puntos { get { return _puntos; } set { _puntos = value; } }
        public int NroUsuario { get { return _nroUsuario; } set { _nroUsuario = value; } }
        public int IdCat { get { return _idcat; } set { _idcat = value; } }


        public bool Turno { get { return _turno; } set { _turno = value; } }

        public Dictionary<int, int> Historial;

        public Partida() {}
        //Constructor Ranking
        public Partida(int id, int usuario1, string ip1, int idPersonaje,int puntos, int cantPreguntas, int ganador, DateTime fecha)
        {
            _id = id;
            _usuario1 = usuario1;
            _ip1 = ip1;
            BD.CargarPersonajes();
            _personaje1 = BD.BuscarPersonaje(idPersonaje);
            _puntos = puntos;
            _cantPreguntas = cantPreguntas;
            _ganador = ganador;
            _fecha = fecha;
        }
        //Constructor singleplayer
        public Partida(int idUsuario, string ip, int ipuntos)
        {
            _usuario1 = idUsuario;
            _ip1 = ip;
            _fecha = DateTime.Now;
            _cantPreguntas = 0;
            _multijugador = false;
            Random random = new Random();
            if (BD.Personajes.Count != 0)
            {
                _personaje1 = BD.Personajes[random.Next(0, BD.Personajes.Count - 1)];
            }else
            {
                _personaje1 = null;
            }
           
            _puntos = ipuntos;
            Historial = new Dictionary<int, int>();
        }

        //constructores multiplayer
        public Partida(int idPartida, int Host, string ipH, int idcat)
        {
            _nroUsuario = 0;
            _id = idPartida;
            _usuario1 = Host;
            _ip1 = ipH;
            _fecha = DateTime.Now;
            _cantPreguntas = 0;
            _multijugador = true;
            _idcat = idcat;
            _ganador = -1;
            Historial = new Dictionary<int, int>();
        }

        public Partida(int idPartida,int Host, string ipH,int idcat, int idPer)
        {
            _nroUsuario = 0;
            _id = idPartida;
            _usuario1 = Host;
            _ip1 = ipH;
            _fecha = DateTime.Now;
            _cantPreguntas = 0;
            _multijugador = true;
            _ganador = -1;
            _idcat = idcat;
            Historial = new Dictionary<int, int>();
            _personaje2 = BD.BuscarPersonaje(idPer);
        }

        public void Unirse(int Guest, string ipG,int idPer)
        {
            _nroUsuario = 1;
            _usuario2 = Guest;
            _ip2 = ipG;
            Historial = new Dictionary<int, int>();
            _personaje1 = BD.BuscarPersonaje(idPer);
            _ganador = -1;
            _fecha = DateTime.Now;
        }
        public void Finalizar(int Ganador) {
            Historial = new Dictionary<int, int>();
            _ganador = Ganador;
        }

    }
}
