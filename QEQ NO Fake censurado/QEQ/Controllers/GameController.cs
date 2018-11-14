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
            ViewBag.Preg = BD.Preguntas;
            return View();
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
        public ActionResult Index(string hola)
        {
            return RedirectToAction("LogIn", "BackOffice");
            
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