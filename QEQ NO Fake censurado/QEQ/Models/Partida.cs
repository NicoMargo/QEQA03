using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QEQ.Models
{
    public class Partida
    {
        private int _id;
        private int _usuario1;
        private int _usuario2;
        private string _ip1;
        private string _ip2;
        private int _cantPreguntas;
        private bool _multijugador;
        private bool _ganador;
        private DateTime _fecha;

        public int Id { get => _id; set => _id = value; }
        public int Usuario1 { get => _usuario1; set => _usuario1 = value; }
        public int Usuario2 { get => _usuario2; set => _usuario2 = value; }
        public string Ip1 { get => _ip1; set => _ip1 = value; }
        public string Ip2 { get => _ip2; set => _ip2 = value; }
        public int CantPreguntas { get => _cantPreguntas; set => _cantPreguntas = value; }
        public bool Multijugador { get => _multijugador; }
        public bool Ganador { get => _ganador; }
        public DateTime Fecha { get => _fecha; set => _fecha = value; }

        public Partida() {}
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