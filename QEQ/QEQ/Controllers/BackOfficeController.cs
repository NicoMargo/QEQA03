using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QEQ.Models;
using System.Net;

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
            return View();
        }
        [HttpPost]
        public ActionResult LogIn(string Usuario, string contraseña)
        {
            /* lo que viene es para cuendo no tenemos la base en casa
             Usuario usu = new Usuario("Anush", "Administrador", "123", 1234, "1", "asdfasz", "fasdfas");
             */

            if (contraseña != "" && Usuario != "")
            {
                Usuario usu;                
                usu =  BD.Login(Usuario, contraseña);
                if (usu.Username != "")
                {
                    Session["Usu"] = Usuario;
                    Session["msg"] = "";
                    return RedirectToAction("Index", "Home");
                }
                else
                {
                    Session["msg"] = "Usuario o contraseña incorrecto";
                }

            }
            return RedirectToAction("LogIn", "BackOffice");
        }
        public ActionResult Register()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Register(Usuario Usu)
        {
            string Host = Dns.GetHostName(), msg = "";
            IPAddress[] ip = Dns.GetHostAddresses(Host);
            Usu.Ip = ip[3].ToString();
            Usu.Mac = ip[0].ToString();
            // msg = BD.Register;
            if (msg == "")
            {
                Session["Usu"] = Usu.Username;
                return RedirectToAction("Index", "Home");
            }
            else
            {
                return RedirectToAction("Register", "BackOffice", new { id = "name" });
               
            }
        }
        public ActionResult ABMPer()
        {
            Personaje P = new Personaje();
            BD.CargarPersonajes();
            ViewBag.Personajes = BD.Personajes;
            return View(P);
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


        public ActionResult BorrarP()
        {
            return View();
        }

        public ActionResult ModificarP(Personaje P)
        {
            Personaje mipersonaje = P;
            //mipersonaje = buscar en la lista y traer el personaje
            //ViewBag.ListaCat = ModelBinderDictionary.TraerCategorias();
            List<Categoria> listaCat = new List<Categoria>();
            listaCat.Add(new Categoria(1, "profesores"));
            listaCat.Add(new Categoria(2, "Alumnos"));
            ViewBag.ListaCat = listaCat;
            ViewBag.PregsXGrupo = BD.PregsXGrupos;
            return View(mipersonaje);

        }
        [HttpPost]
        public ActionResult ModificarP(string Nombre,HttpPostedFileBase Foto, Personaje P)
        {

         string msg = BD.ModificarP(Nombre,P);
            if (msg=="")
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
        public ActionResult ModificarUsu(Usuario usu)
        {
            if (usu.Nombre != "" || usu.Pass != "" || usu.Email != "" || usu.Username != "")
            {
                //llamar bd para modificar
                return RedirectToAction("ModificarUsuOk", "BackOffice");
            }else
            {
                return RedirectToAction("Index", "BackOffice");
            }
          

           
        }
        [HttpPost]
        public ActionResult CrearP(Personaje unPersonaje)
        {
            return View();
        }

        public ActionResult MostrarLista()
        {          
            //Lista = BD.TraerPersonajes();            
            return View();
            
        }
    }
}