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
            BD.CargarPreguntas();
            ViewBag.Cats = BD.Categorias;
            ViewBag.Cats.Add(new Cat(0,"Todos"));
            return View();
        }

        [HttpPost]
        public ActionResult Start1(int idCategoria)
        {
            BD.CargarPersonajes(idCategoria);
            //CargarRtas(idCategoria);
            return View();
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