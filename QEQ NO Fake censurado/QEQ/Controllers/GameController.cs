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
                if (BD.Respuestas[i].IdPersona == idPer && BD.Respuestas[i].IdPregunta == idPreg) { found = true; }
                else { i++; }
            }
            return found;
        }

        public Partida AskForAll(Partida lapartida, int idPreg) {
            bool rtaElPersonaje = AskForOne(lapartida.Personaje1.Id,idPreg);
            for (int i = 0; i < lapartida.Personajes.Count(); i++) {
                if (rtaElPersonaje != AskForOne(lapartida.Personajes[i].Id, idPreg)) {
                    lapartida.Personajes.RemoveAt(i);
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
            BD.CargarCats();
            ViewBag.Cats = BD.Categorias;            
            ViewBag.Cats.Add(new Cat(0,"Todos"));
            return View();
        }
       


        public ActionResult TypeGame()
        {
            
            return View();
        }

        public ActionResult JuegoPrincipalS()
        {
            BD.CargarCats();
            BD.CargarPersonajes();
            ViewBag.Personajes = BD.Personajes;
            ViewBag.Preg = BD.Preguntas;
            return View();
        }

        public ActionResult AskS(int idPreg) {
            BD.laPartida = AskForAll(BD.laPartida, idPreg);
            BD.laPartida.CantPreguntas++;
            BD.laPartida.Puntos -= BD.BuscarPregunta(idPreg).Puntos;
            return RedirectToAction("JuegoPrincipalS", "Game");
        }
        public ActionResult RiskS(int idPersonaje)
        {
            if (BD.laPartida.Personaje1.Id == idPersonaje) {
                return RedirectToAction("Finalizar", "Game");
            }
            else
            {
                BD.laPartida.Puntos -= iRiskPenalty;
                return RedirectToAction("JuegoPrincipalS", "Game");
            }
        }

        [HttpPost]
        public ActionResult Start1(int idCategoria)
        {
            BD.CargarPreguntas();
            BD.CargarPersonajes(idCategoria);
            //BD.CargarRtas(idCategoria);
            return RedirectToAction("JuegoPrincipalS", "Game");
        }
        
        [HttpPost]
        public ActionResult Start1(int idCategoria, Usuario usuario)
        {
            BD.CargarPersonajes(idCategoria);
            BD.CargarRtas(idCategoria);
            BD.laPartida = new Partida(usuario.Id, usuario.Ip,10000);
            return View("Tablero1");
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