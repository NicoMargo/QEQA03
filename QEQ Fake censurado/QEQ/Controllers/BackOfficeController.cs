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
        private bool BuscarCat(string Categoria, List<string> Cats) {
            bool encontrado = false;
            int i = 0;
            while (i < Cats.Count() && !encontrado)
            {
                if (Cats[i] == Categoria)
                {
                    encontrado = true;
                }
                else { i++; }
            }
            return encontrado;
        }
        // GET: BackOffice
        public ActionResult Index()
        {
            return View();
        }


        public ActionResult About()
        {
            return View();
        }

        public ActionResult Msg( string[] parametros) {
            ViewBag.Msg = parametros[0];
            ViewBag.Viu = parametros[1];
            return View();
        }


        public ActionResult LogIn()
        {
            Session["msg"] = BD.msg;
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
                    if (usu.Admin)
                    {
                        Session["Admin"] = "Admin";
                    }
                    return RedirectToAction("Index", "Home");
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
            Usu.Ip = ip[0].ToString();
            Usu.Mac = ip[3].ToString();
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

        //ABMPersonajes : Comienzo------------------------------------------------------------------------------------------------
        public ActionResult ABMPer()
        {
            BD.CargarPersonajes();
            ViewBag.Personajes = BD.Personajes;
            return View();
        }

        [HttpPost]
        public ActionResult ABMPer(string Accion, string Nombre)
        {
            return View(Accion, Nombre);
        }

      
        public ActionResult AgregarP()
        {
            BD.CargarPreguntas();
            BD.CargarCats();
            Personaje mipersonaje = new Personaje();
            //mipersonaje = buscar en la lista y traer el personaje
            //ViewBag.ListaCat = ModelBinderDictionary.TraerCategorias();
            ViewBag.ListaCat = BD.Categorias;
            ViewBag.PregsXGrupo = BD.PregsXGrupos;
            ViewBag.Grupos = BD.Grupos;
            return View(mipersonaje);
        }

        [HttpPost]
        public ActionResult AgregarPer(Personaje P)
        {
            string[] parametros = new string[2];
            parametros[1] = "ABMPer";
            parametros[0] = BD.AgregarP(P);
            return View("Msg", parametros);
        }

        /* lista falsa para probar
          List<Personaje> Personajes = new List<Personaje>();
            Personajes.Add(new Personaje(1,"1","1","1"));
            Personajes.Add(new Personaje(2, "2", "1", "1"));
            Personajes.Add(new Personaje(3, "3", "1", "1"));
            ViewBag.Personajes = Personajes;
             */
        public ActionResult BorrarP(string Nombre)
        {
            ViewBag.Nombre = Nombre;
            return View();
        }
        [HttpPost]
        public ActionResult BorrarPer(string Confirmacion,string Nombre)
        {
            string[] parametros = new string[2];
            parametros[1] = "ABMPer";
            if (Confirmacion == "Si") {
                parametros[0] = BD.BorrarP(Nombre);
            }
            else
            {
                parametros[0] = "Ha decidido no Eliminar Personajes";
                
            }
            return View("Msg",parametros);
        }

        public ActionResult ModificarP(string Nombre)
        {
            BD.CargarPreguntas();
            BD.CargarCats();
            Personaje mipersonaje = new Personaje( BD.BuscarPersonaje(Nombre).Id,Nombre,null,null);
            ViewBag.Nombre = Nombre;
            //mipersonaje = buscar en la lista y traer el personaje
            //ViewBag.ListaCat = ModelBinderDictionary.TraerCategorias();
            ViewBag.ListaCat = BD.Categorias;
            ViewBag.PregsXGrupo = BD.PregsXGrupos;
            ViewBag.Grupos = BD.Grupos;
            return View(mipersonaje);

        }

        [HttpPost]
        public ActionResult ModificarPer(string Nombre, Personaje P)
        {
            string[] parametros = new string[2];
            parametros[1] = "ABMPer";
            parametros[0] = BD.ModificarP(Nombre, P);
            return View("Msg", parametros);
        }
        //ABMPersonajes : FIn------------------------------------------------------------------------------------------------
        //ABMCategorias : Comienzo------------------------------------------------------------------------------------------------
        public ActionResult ABMCat()
        {
            BD.CargarCats();
            BD.CargarGrupos();
            ViewBag.Categorias = BD.Categorias;
            ViewBag.Grupos = BD.Grupos;
            return View();
        }

        [HttpPost]
        public ActionResult ABMCat(string Accion, string Cat)
        {
            return View(Accion, Cat);
        }


        public ActionResult AgregarCat()
        {
            BD.CargarCats();            
            return View();
        }

        [HttpPost]
        public ActionResult AgregarCat(string Cat, string tipo)
        {
            string[] parametros = new string[2];
            parametros[1] = "ABMCat";
            parametros[0] = BD.AgregarCat(Cat, Convert.ToBoolean(tipo));
            return View("Msg", parametros);
        }
        
        public ActionResult BorrarCat(string Nombre)
        {
            ViewBag.Nombre = Nombre;
            return View();
        }
        [HttpPost]
        public ActionResult BorrarCat(string Confirmacion, string Nombre)
        {
            string[] parametros = new string[2];
            parametros[1] = "ABMCat";
            if (Confirmacion == "Si")
            {
                parametros[0] = BD.BorrarCat(Nombre, BuscarCat(Nombre,BD.Categorias));
            }
            else
            {
                parametros[0] = "Ha decidido no Eliminar Personajes";

            }
            return View("Msg", parametros);
        }

        public ActionResult ModificarCat(string Cat)
        {
            BD.CargarCats();
            ViewBag.Nombre = Cat;

            return View();

        }

        [HttpPost]
        public ActionResult ModificarCate(string Cat,string NewCat, string tipo)
        {
            string[] parametros = new string[2];
            parametros[1] = "ABMCat";
            parametros[0] = BD.ModificarCat(Cat,NewCat, Convert.ToBoolean(tipo));
            return View("Msg", parametros);
        }
        //ABMCategorias : fin------------------------------------------------------------------------------------------------
        //ABMCaracteristicas o preguntas : Comienzo------------------------------------------------------------------------------------------------

        public ActionResult ABMCar()
        {
            BD.CargarPreguntas();
            ViewBag.Preguntas = BD.Preguntas;
            return View();
        }

        [HttpPost]
        public ActionResult ABMCar(string Accion, string Nombre)
        {
            return View(Accion, Nombre);
        }


        public ActionResult AgregarCar()
        {
            BD.CargarPreguntas();
            BD.CargarCats();
            Preg lapregunta = new Preg();
            ViewBag.Grupos = BD.Grupos;
            return View(lapregunta);
        }

        [HttpPost]
        public ActionResult AgregarCar(Preg preg)
        {
            string[] parametros = new string[2];
            parametros[1] = "ABMPer";
            parametros[0] = BD.AgregarCar(preg);
            return View("Msg", parametros);
        }
        
        public ActionResult BorrarCar(string Texto)
        {
            ViewBag.Texto = Texto;
            return View();
        }
        [HttpPost]
        public ActionResult BorrarCar(string Confirmacion, string Texto)
        {
            string[] parametros = new string[2];
            parametros[1] = "ABMCar";
            if (Confirmacion == "Si")
            {
                parametros[0] = BD.BorrarCar(Texto);
            }
            else
            {
                parametros[0] = "Ha decidido no Eliminar Personajes";

            }
            return View("Msg", parametros);
        }

        public ActionResult ModificarCar(string texto)
        {
            BD.CargarPreguntas();

            Preg caracteristica = new Preg(BD.BuscarPregunta(texto).Id, texto, null);
            ViewBag.Car = texto;
            return View(caracteristica);

        }

        [HttpPost]
        public ActionResult ModificarCar(string Car, Preg caracteristica)
        {
            string[] parametros = new string[2];
            parametros[1] = "ABMPer";
            parametros[0] = BD.ModificarCar(Car, caracteristica);
            return View("Msg", parametros);
        }

        //ABMCaracteristicas o preguntas : Fin------------------------------------------------------------------------------------------------
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
        
        public ActionResult MostrarLista()
        {          
            //Lista = BD.TraerPersonajes();            
            return View();
            
        }
    }
}