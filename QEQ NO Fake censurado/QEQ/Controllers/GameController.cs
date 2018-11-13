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
        Partida laPartida;
        // GET: Game
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Start1()
        {
            BD.CargarCats();
            BD.CargarPreguntas();
            ViewBag.Cats = BD.Categorias;
            ViewBag.Cats.Add(new Cat(0,"Todos"));
            return View();
        }

        [HttpPost]
        public ActionResult Start1(int idCategoria, Usuario usuario)
        {
            BD.CargarPersonajes(idCategoria);
            BD.CargarRtas(idCategoria);
            laPartida = new Partida(usuario.Id, usuario.Ip,false);
            Session["Game"] = laPartida;
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