using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QEQ.Models;

namespace QEQ.Controllers
{
    public class GameController : Controller
    {
        //Funciones para el game single
        const int iRiskPenalty = 500;
        
        //Se ingresa un id, se devuelve la posicion en en la lista de la persona con esa id
        public static int BuscarPersonaje(int id)
        {
            bool found = false;
            int i = 0;
            while (i < BD.Personajes.Count() && !found)
            {
                if (BD.Personajes[i].Id == id)
                {
                    found = true;
                }
                else
                {
                    i++;
                }
            }
            return i;
        }
        //Se ingresa un id, se devuleve la posicion en la lista de la pregunta con esa id
        public static int BuscarPregunta(int id)
        {
            Preg pregunta = null;
            int i = 0;
            while (i < BD.Preguntas.Count() && pregunta == null)
            {
                if (BD.Preguntas[i].Id == id)
                {
                    pregunta = BD.Preguntas[i];
                }
                else
                {
                    i++;
                }
            }
            return i;
        }
        //Se ingresa un id de persona y un id de pregunta, devuelve true si existe una respuesta con esas dos id
        public bool AskForOne(int idPer, int idPreg, bool Borrar)
        {
            bool found = false;
            int i = 0;
            while (i < BD.Respuestas.Count() && !found)
            {
                if (BD.Respuestas[i].IdPersona == idPer && BD.Respuestas[i].IdPregunta == idPreg)
                {
                    found = true;
                    if(Borrar) BD.Respuestas.RemoveAt(i);
                }
                else { i++; }
            }
            return found;
        }
        public Partida AskForAll(Partida lapartida, int idPreg) {
            bool rtaElPersonaje = AskForOne(lapartida.Personaje1.Id,idPreg,false);
            for (int i = 0; i < BD.Personajes.Count(); i++) {
                if (rtaElPersonaje != AskForOne(BD.Personajes[i].Id, idPreg,true)) {
                    BD.Personajes.RemoveAt(i);
                }
            }
            return lapartida;
        }
            

        public ActionResult Start1()
        {
            BD.CargarCats();
            ViewBag.Cats = BD.Categorias;
            return View();
        }       


        public ActionResult TypeGame()
        {            
            BD.CargarPreguntas();
            return View();
        }
        [HttpPost]
        public ActionResult Start1(int idCategoria, Usuario usuario)
        {
            BD.CargarPersonajes(idCategoria);
            BD.CargarRtas(idCategoria);
           
            BD.laPartida = new Partida(usuario.Id, usuario.Ip, 10000);
            if (BD.laPartida.Personaje1 == null)
            {
                return RedirectToAction("Index", "Home");
            }
            return RedirectToAction("JuegoPrincipalS", "Game");           
        }

        public ActionResult JuegoPrincipalS()
        {
            if (BD.Estado == 1)
            {
                ViewBag.Estado = 1;
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
                /*
                bool result = false;
                result = AskOne(idpreg);*/
                Session["Estado"] = (BD.laPartida.Puntos <= iRiskPenalty);
                bool CorrectPer = AskForOne(BD.laPartida.Personaje1.Id, idpreg,false);
                /*
                foreach (Rta resp in BD.Respuestas)
                {
                    if (resp.IdPersona == BD.laPartida.Personaje1.Id && idpreg == resp.IdPregunta)
                    {
                        CorrectPer = true;
                    }
                }
                */
                for (int i = 0; i < BD.Personajes.Count; i++)
                {
                    /*
                    bool correct = AskForOne(BD.Personajes[i].Id,idpreg);
                    int Z = 0;
                    while (Z < BD.Respuestas.Count)
                    {
                        if (BD.Personajes[i].Id == BD.Respuestas[Z].IdPersona && BD.Respuestas[Z].IdPregunta == idpreg)
                        {
                            correct = true;
                        }
                        Z++;
                    }*/
                    if (AskForOne(BD.Personajes[i].Id, idpreg,true) != CorrectPer)
                    {
                        //BD.Personajes.Remove(BD.Personajes[i]);
                        BD.Personajes.RemoveAt(BuscarPersonaje(BD.Personajes[i].Id));
                        i--;
                    }
                }//Fin For que recorre los personajes
                BD.laPartida.CantPreguntas++;
                BD.laPartida.Puntos -= BD.BuscarPregunta(idpreg).Puntos;
                BD.Preguntas.RemoveAt(BuscarPregunta(idpreg));
            }//fin del if puntos < iRiskPenalty
            return RedirectToAction("JuegoPrincipalS", "Game");
        }
        /*
        public static bool AskOne(int idPreg) {
            BD.laPartida.CantPreguntas++;
            BD.laPartida.Puntos -= BD.BuscarPregunta(idPreg).Puntos;
            if (BD.laPartida.Puntos <= iRiskPenalty)
            {
                BD.laPartida.Finalizar(false);
                return false;
            }
            else
            {
                return true;
            }
        }
        */
        public ActionResult RiskS(int idPersonaje)
        {
            if (BD.laPartida.Personaje1.Id == idPersonaje || BD.laPartida.Puntos<iRiskPenalty) {
                BD.laPartida.Finalizar(BD.laPartida.Personaje1.Id == idPersonaje);
                return RedirectToAction("FinalizarS", "Game");
            }
            else
            {
                BD.laPartida.Puntos -= iRiskPenalty;
                BD.Personajes.RemoveAt(BuscarPersonaje(idPersonaje));
                return RedirectToAction("JuegoPrincipalS", "Game");
            }
        }

        public ActionResult FinalizarS()
        {
            return View();
        }

            public ActionResult Finalizar()
        {
            if (BD.laPartida.Ganador)
            {
                //los mensajes de victoria: estadisticas, cantidad de preguntas etc
            }
            else {
                //mensajes de derrota: "xd" cantidad de preguntas etc...
            }
            return View();
        }

        public ActionResult Tablero1()
        {
            return View();
        }
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