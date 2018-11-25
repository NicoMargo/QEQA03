using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QEQ.Models;
using System.Net;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


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
            while (i < BD.Personajes.Count && !found)
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
            while (i < BD.Preguntas.Count && pregunta == null)
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
        public bool AskForOne(int idPer, int idPreg, bool BorrarDef = false)
        {
            bool found = false;
            int i = 0;
            while (i < BD.Respuestas.Count && !found)
            {
                if (BD.Respuestas[i].IdPersona == idPer && BD.Respuestas[i].IdPregunta == idPreg)
                {
                    found = true;
                    if(BorrarDef) BD.Respuestas.RemoveAt(i);
                }
                else { i++; }
            }
            return found;
        }
        //Borra todas las respuestas y preguntas de la misma categoria de preguntas de la pregunta preguntada :v
        public void EliminarporGrupo(int idPreg) {
            int idGrupete = BD.BuscarPregunta(idPreg).idGrupo;
            for (int i = 0; i < BD.Preguntas.Count; i++) {
                if (BD.Preguntas[i].idGrupo == idGrupete)
                {
                    for (int j = 0; j < BD.Respuestas.Count; j++)
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
            
            if (BD.laPartida.Puntos > iRiskPenalty && BD.laPartida.Multijugador == false)
            {
                AskSAux(idpreg);
                return RedirectToAction("JuegoPrincipalS", "Game", new { idpreg });
            }//fin del if puntos < iRiskPenalty
            else if (BD.laPartida.Multijugador == false)
            {
                Session["Estado"] = true;
                return RedirectToAction("JuegoPrincipalS", "Game", new { idpreg });
            }
            else
            {
                AskSAux(idpreg);
                BD.CambiarTurnos();
                return RedirectToAction("WaitingRoomM", "Game");
            }
            
        }
        public void AskSAux(int idpreg)
        {
            int cantDescartados = 0;
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
            BD.laPartida.Puntos -= BD.BuscarPregunta(idpreg).Puntos;
            //BD.laPartida.Historial.Add(idpreg, cantDescartados);
        }
        
        public ActionResult RiskS(int idPersonaje)
        {
            if (BD.laPartida.Multijugador)
            {
                if (Convert.ToBoolean(Session["Host"]))
                {
                    if (BD.laPartida.Personaje1.Id == idPersonaje || BD.laPartida.Puntos < iRiskPenalty)
                    {
                        BD.laPartida.Finalizar(BD.laPartida.Personaje1.Id == idPersonaje);
                        BD.CambiarTurnos();
                        return RedirectToAction("FinalizarM", "Game");
                    }
                    else
                    {
                        BD.laPartida.Puntos -= iRiskPenalty;
                        BD.Personajes.RemoveAt(BuscarPersonaje(idPersonaje));
                        BD.CambiarTurnos();
                        return RedirectToAction("JuegoPrincipalM", "Game");
                    }
                }else
                {
                    if (BD.laPartida.Personaje2.Id == idPersonaje || BD.laPartida.Puntos < iRiskPenalty)
                    {
                        BD.laPartida.Finalizar(BD.laPartida.Personaje1.Id == idPersonaje);
                        BD.CambiarTurnos();
                        return RedirectToAction("FinalizarM", "Game");
                    }
                    else
                    {
                        BD.laPartida.Puntos -= iRiskPenalty;
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
            BD.CargarPartidas();
            BD.CargarUsuarios();
            ViewBag.Partidas = BD.Partidas;
            return View();
        }

        public ActionResult StartM()
        {            
            BD.CargarCats(); 
            ViewBag.Cats = BD.Categorias;
            ViewBag.Cats.Add(new Cat(0, "Todos"));
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
        public ActionResult Unirse(int id) {
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
            BD.CargarPersonajes(cat);            
            return RedirectToAction("PickCharM", "Game");
        }
        public ActionResult PickCharM()
        {
            ViewBag.Personajes = BD.Personajes;
            return View();
        }
    
    
        public ActionResult UnirJ(int idPersonaje, int idpart = -1)
        {            
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
                BD.laPartida.Personaje1 = BD.Personajes[BuscarPersonaje(idPersonaje)];
                BD.laPartida.Multijugador = true;
                BD.Unirse();               
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
                BD.laPartida.Personaje2 = BD.Personajes[BuscarPersonaje(idPersonaje)];
                BD.laPartida.Turno = false;
                BD.laPartida.Id = idpart;
                BD.CrearPartida(BD.laPartida);                
                return RedirectToAction("WaitingRoomM", "Game");
            }            
            return RedirectToAction("WaitingRoomM", "Game");
        }
        public ActionResult WaitingRoomM()
        {
            return View();
        }
        public ActionResult JuegoPrincipalM(int idpreg = -1)
        {
            if ((Convert.ToBoolean(Session["Estado"])))
            {
                ViewBag.msgalert = "No tienes mas puntos para preguntar, solo podes arriesgar una vez mas";
            }
            else if (idpreg == -1)
            {
                ViewBag.msgalert = "Bienvenido Al Juego";
            }
            else if (AskForOne(BD.laPartida.Personaje1.Id, idpreg, true))
            {
                ViewBag.msgalert = "El personaje SI " + BD.BuscarPregunta(idpreg).Texto;
                EliminarporGrupo(idpreg);
            }
            else
            {
                ViewBag.msgalert = "El personaje NO " + BD.BuscarPregunta(idpreg).Texto;
                BD.Preguntas.RemoveAt(BuscarPregunta(idpreg));
            }
            ViewBag.Personajes = BD.Personajes;
            ViewBag.Preg = BD.Preguntas;
            return View();
        }
        
        public ActionResult Turnos()
        {            
            bool bturno = BD.Turnos();
            BD.CambiarTurnos();
            return RedirectToAction("JuegoPrincipalM", "Game");
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