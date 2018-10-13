using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QEQ.Models;

namespace QEQ.Controllers
{
    public class BackOfficeController : Controller
    {
        // GET: BackOffice
        public ActionResult Index()
        {
            return View();
        }


        public ActionResult About()
        {
            return View();
        }
        public ActionResult LogIn(string Estado)
        {
            
            ViewBag.Estado = Estado;
            return View();
        }
        [HttpPost]
        public ActionResult LogIn(string Usuario, string contraseña)
        {                     
            Usuario usu = new Usuario("nico", "Anush", "123", 1234, "1","asdfasz", "fasdfas");
            usu.Username = "nico";
            if (contraseña != "" && Usuario != "")
            {
              //usu =  BD.Login(Usuario, contraseña);
                if (usu.Username != "")
                {
                    Session["Usu"] = Usuario;
                    return RedirectToAction("Index", "Home");
                                    }                
            }
            string Estado = "Usuario o Contraseña incorrecto";
                return RedirectToAction("LogIn","BackOffice",Estado);                
        }

        public ActionResult Register()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Register(Usuario Usu)
        {
            // string msg = BD.Register;
            return View();
        }


        /* public ActionResult CrearP()
         {
             return View();
         }
         [HttpPost]
         public ActionResult CrearPersonaje(Personaje unPersonaje)
         {
             if (!ModelState.IsValid)
             {

                 return View("CrearP", unPersonaje);
             }
             else
             {
                 if (unPersonaje.Foto != null)

                 {

                     string NuevaUbicacion = Server.MapPath("~/Content/Productos/") + unPersonaje.Foto.FileName;

                     unPersonaje.Foto.SaveAs(NuevaUbicacion);

                     unPersonaje.Imagen = unPersonaje.Foto.FileName;

                     unPersonaje.Grabar();

                 }
                 BD.CrearPersonaje(unPersonaje);
                 return View("CrearP", unPersonaje);

             }
         }*/


        public ActionResult EliminarP()
        {
            return View();
        }

        public ActionResult ModificarP(int id)
        {
            Personaje mipersonaje = new Personaje(5,"a","a","a");
            //mipersonaje = buscar en la lista y traer el personaje
            //ViewBag.ListaCat = ModelBinderDictionary.TraerCategorias();
            List<Categoria> listaCat = new List<Categoria>();
            listaCat.Add(new Categoria(1, "profesores"));
            listaCat.Add(new Categoria(2, "Alumnos"));
            ViewBag.ListaCat = listaCat;
            return View(mipersonaje);

        }
        [HttpPost]
        public ActionResult ModificarP(HttpPostedFileBase Foto, Personaje P)
        {
         bool RegAfect = BD.ModificarP(P);
            if (RegAfect)
            {
                ViewBag.Mensaje = "El personaje se actualizo correctamente";
                return View("MostrarLista");
            }
            else
            {
                return View(P);
            }
        }

        public ActionResult CrearP()
        {
            return View();
        }

        public ActionResult ModificarUsu()
        {
            return View();
        }
        [HttpPost]
        public ActionResult CrearP(Personaje unPersonaje)
        {
            return View();
        }

        public ActionResult MostrarLista()
        {
            List<Personaje> Lista = new List<Personaje>();
            Lista.Add(new Personaje(1, "Binker", "Binker.jpg", "1"));
            Lista.Add(new Personaje(2, "Binker2", "lafoto2", "1"));
            Lista.Add(new Personaje(3, "Binker3", "lafoto3", "1"));
            //Lista = BD.TraerPersonajes();
            ViewBag.Lista = Lista;
            return View();
            
        }
    }
}