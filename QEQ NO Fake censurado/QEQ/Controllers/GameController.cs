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
        
        // GET: Game
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Start1()
        {            
            ViewBag.Cats = BD.Categorias;
            bool bul = true; int X = 0;
            while (bul)
            {
                if (BD.Categorias[X].Nombre != "Todos")
                {
                    ViewBag.Cats.Add(new Cat(0, "Todos"));
                    bul = false;
                }
                X += 1;
            }
            
            return View();
        }
       


        public ActionResult TypeGame()
        {
            BD.CargarCats();
            BD.CargarPreguntas();
            return View();
        }
        [HttpPost]
        public ActionResult Start1(int idCategoria, Usuario usuario)
        {
            BD.CargarPersonajes(idCategoria);
            BD.CargarRtas(idCategoria);
            BD.laPartida = new Partida(usuario.Id, usuario.Ip, 10000);
            return RedirectToAction("JuegoPrincipalS", "Game");
            return View("Tablero1");
        }

        public ActionResult JuegoPrincipalS()
        {           
            
            ViewBag.Personajes = BD.Personajes;
            ViewBag.Preg = BD.Preguntas;
            return View();
        }
        [HttpPost]
        public ActionResult JuegoPrincipalS(int idpreg)
        {
            List<Preg> PregAux = new List<Preg>();
            int X = 0, While = -1; ;

            while (While == -1)
            {
                if (BD.Preguntas[X].Id == idpreg)
                {
                    Preg unPreg;
                    int Grupo = BD.Preguntas[X].idGrupo;
                    While = 1;
                    int ContPreg = BD.Preguntas.Count();
                    /* foreach (Preg unPreg in BD.Preguntas)
                     {
                         if (unPreg.idGrupo == Grupo)
                         {
                             BD.Preguntas.Remove(unPreg);
                             X =- 1;
                         }
                     }       */
                    for (int Y = 0; Y < ContPreg; Y++)
                    {
                        unPreg = BD.Preguntas[Y];
                        if (unPreg.idGrupo == Grupo)
                        {
                            BD.Preguntas.Remove(unPreg);
                            Y = -1;
                            ContPreg -= 1;                            
                        }
                    }
                    While = 1;                    
                }
                X++;
            }
            return RedirectToAction("JuegoPrincipalS", "Game");
        }

        public ActionResult AskS(int idPreg) {
            BD.laPartida = AskForAll(BD.laPartida, idPreg);
            BD.laPartida.CantPreguntas++;
            BD.laPartida.Puntos -= BD.BuscarPregunta(idPreg).Puntos;
            BD.Preguntas.RemoveAt(BuscarPregunta(idPreg));
            if (BD.laPartida.Puntos < iRiskPenalty)
            {
                BD.laPartida.Finalizar(false);
                return RedirectToAction("Finalizar", "Game");
            }
            else
            {
                return RedirectToAction("JuegoPrincipalS", "Game");
            }
        }
        public ActionResult RiskS(int idPersonaje)
        {
            if (BD.laPartida.Personaje1.Id == idPersonaje||BD.laPartida.Puntos<iRiskPenalty) {
                BD.laPartida.Finalizar(!(BD.laPartida.Puntos < iRiskPenalty));
                return RedirectToAction("Finalizar", "Game");
            }
            else
            {
                BD.laPartida.Puntos -= iRiskPenalty;
                BD.Personajes.RemoveAt(BuscarPersonaje(idPersonaje));
                return RedirectToAction("JuegoPrincipalS", "Game");
            }
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