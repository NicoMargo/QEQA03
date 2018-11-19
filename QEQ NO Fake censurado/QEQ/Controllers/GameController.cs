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
        public bool AskForOne(int idPer, int idPreg)
        {
            bool found = false;
            int i = 0;
            while (i < BD.Respuestas.Count() && !found)
            {
                if (BD.Respuestas[i].IdPersona == idPer && BD.Respuestas[i].IdPregunta == idPreg)
                {
                    found = true;
                    BD.Respuestas.RemoveAt(i);
                }
                else { i++; }
            }
            return found;
        }

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

        public Partida AskForAll(Partida lapartida, int idPreg) {
            bool rtaElPersonaje = AskForOne(lapartida.Personaje1.Id,idPreg);
            for (int i = 0; i < BD.Personajes.Count(); i++) {
                if (rtaElPersonaje != AskForOne(BD.Personajes[i].Id, idPreg)) {
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
        public ActionResult JuegoPrincipalS(int idpreg)
        {
            bool result = false;
            int X = 0, While = -1;
            if (BD.laPartida.Puntos > 500)
            {
                while (While == -1)
                {
                    if (BD.Preguntas[X].Id == idpreg)
                    {
                        result = AskS(idpreg);
                        if (!result)
                        {
                            BD.Estado = 1;
                        }
                        BD.Preguntas.RemoveAt(X);
                        X--;
                        While = 1;
                    }
                    X++;
                }
                bool CorrectPer = false;
                foreach (Rta resp in BD.Respuestas)
                {
                    if (resp.IdPersona == BD.laPartida.Personaje1.Id && idpreg == resp.IdPregunta)
                    {
                        CorrectPer = true;
                    }
                }
                for (int i = 0; i < BD.Personajes.Count; i++)
                {
                    int Z = 0;
                    bool correct = false;
                    while (Z < BD.Respuestas.Count)
                    {
                        if (BD.Personajes[i].Id == BD.Respuestas[Z].IdPersona && BD.Respuestas[Z].IdPregunta == idpreg)
                        {
                            correct = true;
                        }
                        Z++;
                    }
                    if ((correct == false && CorrectPer == true) || (correct == true && CorrectPer == false))
                    {

                        BD.Personajes.Remove(BD.Personajes[i]);
                        i--;
                    }
                }
                
            }                      
            return RedirectToAction("JuegoPrincipalS", "Game");
        }

        public static bool AskS(int idPreg) {
           // BD.laPartida = AskForAll(BD.laPartida, idPreg);
            BD.laPartida.CantPreguntas++;
            int puntos = BD.BuscarPregunta(idPreg).Puntos;
            BD.laPartida.Puntos -= puntos;
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
        public ActionResult RiskS(int id)
        {
            if (BD.laPartida.Personaje1.Id == id || BD.laPartida.Puntos<iRiskPenalty) {
                BD.laPartida.Finalizar(!(BD.laPartida.Puntos < iRiskPenalty));
                return RedirectToAction("FinalizarS", "Game");
            }
            else
            {
                BD.laPartida.Puntos -= iRiskPenalty;
                BD.Personajes.RemoveAt(BuscarPersonaje(id));
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