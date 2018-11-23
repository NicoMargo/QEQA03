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
        //Borra todas las respuestas y preguntas de la misma categoria de preguntas de la pregunta preguntada :v
        public void EliminarporGrupo(int idPreg) {
            int idGrupete = BD.BuscarPregunta(idPreg).idGrupo;
            for (int i = 0; i < BD.Preguntas.Count(); i++) {
                if (BD.Preguntas[i].idGrupo == idGrupete)
                {
                    for (int j = 0; j < BD.Respuestas.Count(); j++)
                    {
                        if (BD.Respuestas[j].IdPregunta == BD.Preguntas[i].Id) {
                            BD.Respuestas.RemoveAt(j);
                            j--;
                        }
                    }
                    BD.Preguntas.RemoveAt(i);
                    i--;
                }
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

        public ActionResult JuegoPrincipalS()
        {
            ViewBag.Estado = (Convert.ToBoolean(Session["Estado"]));           
            ViewBag.Personajes = BD.Personajes;
            ViewBag.Preg = BD.Preguntas;
            return View();
        }

        [HttpPost]
        public ActionResult AskS(int idpreg)
        {
            int cantDescartados = 0;
            if (BD.laPartida.Puntos > iRiskPenalty)
            {
               
                bool CorrectPer = AskForOne(BD.laPartida.Personaje1.Id, idpreg, false);
                for (int i = 0; i < BD.Personajes.Count; i++)
                {
                    if (AskForOne(BD.Personajes[i].Id, idpreg, true) != CorrectPer)
                    {
                        cantDescartados++;
                        BD.Personajes.RemoveAt(BuscarPersonaje(BD.Personajes[i].Id));
                        i--;
                    }
                }//Fin For que recorre los personajes
                BD.laPartida.CantPreguntas++;
                BD.laPartida.Puntos -= BD.BuscarPregunta(idpreg).Puntos;

                if (CorrectPer) { EliminarporGrupo(idpreg); }
                else {
                    
                    BD.Preguntas.RemoveAt(BuscarPregunta(idpreg)); }
                BD.laPartida.Historial.Add(idpreg, cantDescartados); 
            }//fin del if puntos < iRiskPenalty
            else
            {
                Session["Estado"] = true;
            }
            return RedirectToAction("JuegoPrincipalS", "Game");
        }
        
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
            BD.CargarUsuarios();
            BD.CargarPreguntas();
            if (BD.laPartida.Ganador)
            {
                ViewBag.Msg = "Usted ha Ganado con un puntaje de" + BD.laPartida.Puntos;
                //los mensajes de victoria: estadisticas, cantidad de preguntas etc

            }
            else {
                ViewBag.Msg = "Usted ha Perdido";
                //mensajes de derrota: "xd" cantidad de preguntas etc...
            }
            BD.GuardarPartida1(BD.laPartida);
            BD.Rank();
            return View();
        }

        //Game 2 =============================================================================================================
        public ActionResult BuscarPartidasM() {
            BD.CargarUsuarios();
            BD.CargarPartidas();
            ViewBag.Partidas = BD.Partidas;
            return View();
        }

        public ActionResult StartM()
        {
            BD.CargarPreguntas();
            BD.CargarCats();
            ViewBag.Cats = BD.Categorias;
            ViewBag.Cats.Add(new Cat(0, "Todos"));
            return View();
        }


        [HttpPost]
        public ActionResult StartM(int idCategoria)
        {
            BD.CargarPersonajes(idCategoria);
            BD.CargarRtas(idCategoria);
            BD.laPartida = new Partida(0,BD.usuario.Id, BD.usuario.Ip,idCategoria);
            BD.CrearPartida(BD.laPartida);
            return RedirectToAction("WaitingRoomM", "Game");
        }

        [HttpPost]
        public ActionResult Unirse(int idPartida) {
            
            return RedirectToAction("PickCharM", "Game");
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