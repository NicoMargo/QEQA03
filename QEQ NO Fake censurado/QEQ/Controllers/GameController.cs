﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QEQ.Models;
using System.Net;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Timers;

namespace QEQ.Controllers
{
    public class GameController : Controller
    {
        //Funciones para el game 
        const int iRiskPenalty = 1500;

        //funciones del timer
        public Timer timer;
        private void AfkTester() {
            timer = new System.Timers.Timer(2000); 
            //timer.Elapsed += OnTimedEvent;
            timer.AutoReset = false;
            timer.Enabled = true;
        }
        //Se ingresa un id, se devuelve la posicion en en la lista de la persona con esa id
        //Single player multiplayer, host guest, esta funcio devuelve true si el juego es single o sos host, si sos guest devuelve false
        public bool SMHG() {
            bool smhg;
            if ((!BD.laPartida.Multijugador)) { smhg = true; }
            else { smhg = Convert.ToBoolean(Session["Host"]); }
            return smhg;
        }

        public int BuscarPersonaje(int id)
        {
            List<Personaje> personajxs;
            if (SMHG()) { personajxs = BD.Personajes; }
            else { personajxs = BD.Personajes2; }
            bool found = false;
            int i = 0;
            if (Convert.ToBoolean(Session["Host"]))
            {
                while (i < personajxs.Count && !found)
                {
                    if (personajxs[i].Id == id)
                    {
                        found = true;
                    }
                    else
                    {
                        i++;
                    }
                }
            }
            return i;
        }
        //Se ingresa un id, se devuleve la posicion en la lista de la pregunta con esa id
        public int BuscarPregunta(int id)
        {
            List<Preg> preguntxs;
            if (SMHG()) { preguntxs = BD.Preguntas; }
            else { preguntxs = BD.Preguntas2; }
            Preg pregunta = null;
            int i = 0;
            if (Convert.ToBoolean(Session["Host"]))
            {
                while (i < preguntxs.Count && pregunta == null)
                {
                    if (preguntxs[i].Id == id)
                    {
                        pregunta = preguntxs[i];
                    }
                    else
                    {
                        i++;
                    }
                }
            }
            return i;
        }
        //Se ingresa un id de persona y un id de pregunta, devuelve true si existe una respuesta con esas dos id
        public bool AskForOne(int idPer, int idPreg, bool BorrarDef = false)
        {
            List<Personaje> personajxs;
            if (SMHG()) { personajxs = BD.Personajes; }
            else { personajxs = BD.Personajes2; }
            bool found = false;
            int i = 0;
            while (i < BD.Respuestas.Count && !found)
            {
                if (BD.Respuestas[i].IdPersona == idPer && BD.Respuestas[i].IdPregunta == idPreg)
                {
                    found = true;
                    if (BorrarDef) { personajxs.RemoveAt(BuscarPersonaje(idPer)); }
                }
                else { i++; }
            }
            return found;
        }
        //Borra todas las respuestas y preguntas de la misma categoria de preguntas de la pregunta preguntada :v
        public void EliminarporGrupo(int idPreg) {
            List<Personaje> Personajes;
            List<Preg> Preguntas;
            if ((!BD.laPartida.Multijugador) || Convert.ToBoolean(Session["Host"])){
                Personajes = BD.Personajes;
                Preguntas = BD.Preguntas;
            }
            else {
                Personajes = BD.Personajes2;
                Preguntas = BD.Preguntas2;
            }
            //Busqueda
            int idGrupete = BD.BuscarPregunta(idPreg).idGrupo;
            for (int i = 0; i < Preguntas.Count; i++) {
                if (Preguntas[i].idGrupo == idGrupete)
                {
                    for (int j = 0; j < BD.Respuestas.Count; j++)
                    {
                        if (BD.Respuestas[j].IdPregunta == Preguntas[i].Id) {
                            if (!BD.laPartida.Multijugador) { BD.Respuestas.RemoveAt(j); }
                            j--;
                        }
                    }
                    Preguntas.RemoveAt(i);
                    i--;
                }
            }
            //Reasignacion
            if ((!BD.laPartida.Multijugador) || Convert.ToBoolean(Session["Host"])){
                BD.Personajes= Personajes;
                BD.Preguntas = Preguntas;
            }
            else
            {
                BD.Personajes2 = Personajes;
                BD.Preguntas2 = Preguntas;
            }
        }

        public ActionResult TypeGame()
        {
            return View();
        }

        public ActionResult StartS()
        {
            BD.CargarPreguntas();
            BD.CargarCats();
            ViewBag.Cats = BD.Categorias;
            ViewBag.Cats.Add(new Cat(0, "Todos"));
            Session["Estado"] = false;
            return View();
        }


        [HttpPost]
        public ActionResult StartS(int idCategoria)
        {
            Usuario usuario = BD.usuario;
            BD.CargarPersonajes(idCategoria);
            BD.CargarRtas(idCategoria);
           
            BD.laPartida = new Partida(usuario.Id, usuario.Ip, 10000);
            if (BD.laPartida.Personaje1 == null)
            {
                return RedirectToAction("Index", "Home");
            }
            return RedirectToAction("JuegoPrincipalS", "Game");           
        }

        public ActionResult JuegoPrincipalS(int idpreg = -1)
        {                        
             if ((Convert.ToBoolean(Session["Estado"])))
            {
                ViewBag.msgalert = "No tienes mas puntos para preguntar, solo podes arriesgar una vez mas";
            }else if ( idpreg == -1)
            {
                ViewBag.msgalert = "Bienvenido Al Juego";
            }
            else if (AskForOne(BD.laPartida.Personaje1.Id, idpreg, true))
            {
                ViewBag.msgalert = "El personaje SI " + BD.BuscarPregunta(idpreg).Texto;
               EliminarporGrupo(idpreg);            
            } else
            {
                ViewBag.msgalert = "El personaje NO " + BD.BuscarPregunta(idpreg).Texto;
                BD.Preguntas.RemoveAt(BuscarPregunta(idpreg));
            }
            
                      
            ViewBag.Personajes = BD.Personajes;
            ViewBag.Preg = BD.Preguntas;
            return View();
        }

        [HttpPost]
        public ActionResult AskS(int idpreg)
        {            
            if (BD.laPartida.Puntos > iRiskPenalty)
            {
                AskForAll(idpreg);
                return RedirectToAction("JuegoPrincipalS", "Game", new { idpreg });
            }//fin del if puntos < iRiskPenalty
            else 
            {
                Session["Estado"] = true;
                return RedirectToAction("JuegoPrincipalS", "Game", new { idpreg });
            }        
            
        }
        public void AskForAll(int idpreg)
        {
            int cantDescartados = 0;
            if (!BD.laPartida.Multijugador || Convert.ToBoolean(Session["Host"]))
            {
                bool CorrectPer = AskForOne(BD.laPartida.Personaje1.Id, idpreg);
                for (int i = 0; i < BD.Personajes.Count; i++)
                {
                    if (AskForOne(BD.Personajes[i].Id, idpreg) != CorrectPer)
                    {
                        cantDescartados++;
                        BD.Personajes.RemoveAt(BuscarPersonaje(BD.Personajes[i].Id));
                        i--;
                    }
                }//Fin For que recorre los personajes
                BD.laPartida.CantPreguntas++;            
               
            }else
            {
                bool CorrectPer = AskForOne(BD.laPartida.Personaje2.Id, idpreg);
                for (int i = 0; i < BD.Personajes2.Count; i++)
                {
                    if (AskForOne(BD.Personajes2[i].Id, idpreg) != CorrectPer)
                    {
                        cantDescartados++;
                        BD.Personajes2.RemoveAt(BuscarPersonaje(BD.Personajes2[i].Id));
                        i--;
                    }
                }//Fin For que recorre los personajes
                BD.laPartida.CantPreguntas++;                
            }
            BD.laPartida.Puntos -= BD.BuscarPregunta(idpreg).Puntos;
            BD.laPartida.Historial.Add(idpreg, cantDescartados);
        }
        
        public ActionResult RiskS(int idPersonaje)
        {
           
            if (BD.laPartida.Multijugador)            {
                
                if (Convert.ToBoolean(Session["Host"]))
                {
                    if (BD.laPartida.Personaje1.Id == idPersonaje)
                    {
                        BD.laPartida.Finalizar(BD.laPartida.Usuario1);
                        BD.CambiarTurnos();
                        BD.Ganador();
                        return RedirectToAction("FinalizarM", "Game", new { G = true });
                    }
                    else
                    {                        
                        BD.Personajes.RemoveAt(BuscarPersonaje(idPersonaje));
                        BD.CambiarTurnos();
                        return RedirectToAction("JuegoPrincipalM", "Game");
                    }
                }else
                {
                    if (BD.laPartida.Personaje2.Id == idPersonaje )
                    {
                        BD.laPartida.Finalizar(BD.laPartida.Usuario2);
                        BD.CambiarTurnos();
                        BD.Ganador();
                        return RedirectToAction("FinalizarM", "Game", new { G = true });
                    }
                    else
                    {                      
                        BD.Personajes.RemoveAt(BuscarPersonaje(idPersonaje));
                        BD.CambiarTurnos();
                        return RedirectToAction("JuegoPrincipalM", "Game");
                    }
                }
            }
            else
            {
                if (BD.laPartida.Personaje1.Id == idPersonaje || BD.laPartida.Puntos < iRiskPenalty)
                {
                    BD.laPartida.Finalizar(BD.laPartida.Usuario1);
                    bool ganador = false;
                    if (BD.laPartida.Personaje1.Id == idPersonaje)
                    {
                        ganador = true;
                    }                   
                        return RedirectToAction("FinalizarS", "Game", new { ganador});
                }
                else
                {
                    BD.laPartida.Puntos -= iRiskPenalty;
                    BD.Personajes.RemoveAt(BuscarPersonaje(idPersonaje));
                    return RedirectToAction("JuegoPrincipalS", "Game");
                }
            }
        }

        public ActionResult FinalizarS(bool Ganador)
        {
            BD.CargarUsuarios();
            BD.CargarPreguntas();
            if (Ganador)
            {
                ViewBag.Msg = "Usted ha Ganado con un puntaje de " + BD.laPartida.Puntos;            
            }
            else {
                ViewBag.Msg = "Usted ha Perdido";
            }
            BD.GuardarPartida1(BD.laPartida);            
            return View();
        }
        //Game 2 =============================================================================================================
        public ActionResult NucleoGameM(int idpreg)//AskM con nombre exotico xd
        {
            AskForAll(idpreg);
            BD.CambiarTurnos();               
            return RedirectToAction("JuegoPrincipalM", "game", new { idpreg });
        }

        public ActionResult JuegoPrincipalM(int idpreg = -1)
        {
            if (BD.laPartida.Ganador == -1)
            {
                if ((idpreg == -1 && !Convert.ToBoolean(Session["Host"])))
                {
                    ViewBag.msgalert = "Bienvenido Al Juego, Espera a tu turno para jugar";
                }
                else if (Convert.ToBoolean(Session["Host"]))
                {
                    if (AskForOne(BD.laPartida.Personaje1.Id, idpreg, true))
                    {
                        ViewBag.msgalert = "El personaje SI " + BD.BuscarPregunta(idpreg).Texto;
                        EliminarporGrupo(idpreg);
                    }
                    else
                    {
                        ViewBag.msgalert = "El personaje NO " + BD.BuscarPregunta(idpreg).Texto;
                        BD.Preguntas.RemoveAt(BuscarPregunta(idpreg));
                    }
                }
                else
                {
                    if (AskForOne(BD.laPartida.Personaje2.Id, idpreg, true))
                    {
                        ViewBag.msgalert = "El personaje SI " + BD.BuscarPregunta(idpreg, Convert.ToBoolean(Session["Host"])).Texto;
                        EliminarporGrupo(idpreg);
                    }
                    else
                    {
                        ViewBag.msgalert = "El personaje NO " + BD.BuscarPregunta(idpreg, Convert.ToBoolean(Session["Host"])).Texto;
                        BD.Preguntas2.RemoveAt(BuscarPregunta(idpreg));
                    }
                }
                if (Convert.ToBoolean(Session["Host"]))
                {
                    ViewBag.Preg = BD.Preguntas;
                    ViewBag.Per = BD.Personajes;
                }
                else
                {
                    ViewBag.Preg = BD.Preguntas2;
                    ViewBag.Per = BD.Personajes2;
                }
                ViewBag.Turno = BD.laPartida.Turno;
                ViewBag.Host = Convert.ToBoolean(Session["Host"]);
                return View();
            }
            else
            {
               return RedirectToAction("FinalizarM", "Game");
            }              
        }

        public ActionResult UnirJ(int idPersonaje, int idpart = -1)
        {
            bool exito = false;
            if (!Convert.ToBoolean(Session["Host"]))
            {
                string Host = Dns.GetHostName();
                IPAddress[] ip = Dns.GetHostAddresses(Host);
                if (ip[0].ToString() != "")
                {
                    BD.laPartida.Ip2 = ip[0].ToString();
                }
                else
                {
                    BD.laPartida.Ip2 = "No IP";
                }
                BD.laPartida.Usuario2 = BD.usuario.Id;
                BD.laPartida.Turno = true;
                //elije el presonaje del rival
                BD.laPartida.Personaje1 = BD.Personajes[BuscarPersonaje(idPersonaje)];                
                if (BD.laPartida.Ip1 == BD.laPartida.Ip2)
                {
                    //return RedirectToAction("BuscarPartidasM", "game",new { error = true } );
                }
                exito =BD.Unirse();
                if (exito) { BD.CargarPreguntas(); }
            }
            else
            {
                string Host = Dns.GetHostName();
                IPAddress[] ip = Dns.GetHostAddresses(Host);
                if (ip[0].ToString() != "")
                {
                    BD.laPartida.Ip1 = ip[0].ToString();
                }
                else
                {
                    BD.laPartida.Ip1 = "No IP";
                }
                BD.laPartida.Usuario1 = BD.usuario.Id;
                //elije el personaje del rival
                BD.laPartida.Personaje2 = BD.Personajes[BuscarPersonaje(idPersonaje)];
                BD.laPartida.Turno = false;
                BD.laPartida.Id = idpart;
                BD.CrearPartida(BD.laPartida);
                return RedirectToAction("WaitingRoom", "Game");              
            }
            if (exito)
            {
                BD.laPartida.Ganador = -1;
                return RedirectToAction("JuegoPrincipalM", "Game");
            }
            else { return RedirectToAction("BuscarPartidasM", "Game"); }
        }
       
        public ActionResult WaitingRoom()
        {
            return View();
        }
        public ActionResult Turnos()
        {
            while (BD.laPartida.Turno != Convert.ToBoolean(Session["Host"]))
            {
                BD.Turnos();
            }
            return RedirectToAction("JuegoPrincipalM", "Game");
        }
        public ActionResult BuscarPartidasM(bool error = false)
        {
            BD.CargarPartidas();
            BD.CargarUsuarios();
            ViewBag.Partidas = BD.Partidas;
            ViewBag.error = error;
            return View();
        }

        public ActionResult StartM()
        {
            BD.CargarCats();
            ViewBag.Cats = BD.Categorias;
            ViewBag.Cats.Add(new Cat(-1, "Todos"));
            Session["Estado"] = false;
            return View();
        }
        [HttpPost]
        public ActionResult StartM(int idCategoria)
        {
            Session["Host"] = true;
            BD.CargarPersonajes(idCategoria);
            BD.CargarPreguntas();
            BD.CargarRtas(idCategoria);
            BD.laPartida.IdCat = idCategoria;
            return RedirectToAction("PickCharM", "Game");
        }
        public ActionResult Unirse(int id, int idcat)
        {
            Session["Host"] = false;
            int cat = -1, i = 0;
            while (cat == -1)
            {
                if (BD.Partidas[i].Id == id)
                {
                    cat = BD.Partidas[i].IdCat;
                    i--;
                }
                i++;
            }
            BD.laPartida.Id = id;
            BD.laPartida.Multijugador = true;
            BD.CargarPersonajes(idcat);            
            return RedirectToAction("PickCharM", "Game");
        }
        public ActionResult PickCharM()
        {
            ViewBag.Personajes = BD.Personajes;
            return View();
        }
        public ActionResult FinalizarM(bool G =false)
        {
            BD.CargarPreguntas();
            if (G)
            {
                ViewBag.Ganador = "Eres el ganador de la partida!!!";
            }else
            {
                ViewBag.Ganador = "Eres el PERDEDOR de la partida XDDDD";
            }
            BD.Rank();
            return View();
        }
        //esto deberia estar en el home controller wtf
        public ActionResult Desarrolladores()
        {
            return View();
        }
        public ActionResult About()
        {
            return View();
        }        
    }
}