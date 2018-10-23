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
            BD.msg = "";
            return View();
        }
        [HttpPost]
        public ActionResult LogIn(string Usuario, string contraseña)
        {

            string Host = Dns.GetHostName(), Ip, Mac;
            IPAddress[] ip = Dns.GetHostAddresses(Host);
            Ip = ip[0].ToString();
            Mac = ip[3].ToString();
            if (contraseña != "" && Usuario != "")
            {                
                Usuario usu;                
                usu =  BD.Login(Usuario, contraseña, Ip, Mac);
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
            string msg = "";          
            // msg = BD.Register;
            if (msg == "")
            {
                Session["Usu"] = Usu.Username;
                return RedirectToAction("Index", "Home");
            }
            else
            {
                return RedirectToAction("Register", "BackOffice");
               
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
            if (P.Nombre == "" )
            {
                return RedirectToAction("AgregarPFail", "BackOffice");
            }
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
            BD.CargarGrupos();
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
        public ActionResult ModificarUsu(string id)
        {           if (id != null)
            {
                ViewBag.Estado = id;
            }
            return View();
        }
        [HttpPost]
        public ActionResult ModificarUsu(Usuario usu, string PassVieja)
        {

            if (usu.Nombre != null || usu.Pass != null || usu.Email != null || usu.Username != null)
            {
                if (usu.Pass == null)
                {
                    return Modificarusuaux(usu, PassVieja);
                     
                }

                if (usu.Pass.Length > 5)
                {
                    return Modificarusuaux(usu, PassVieja);
                }
                else
                {
                    return RedirectToAction("ModificarUsu", "BackOffice", new { id = "La contraseña debe tener 6 digitos o mas" });
                }
            }
              return RedirectToAction("Index", "BackOffice");           
        }


        public ActionResult Modificarusuaux(Usuario usu, string PassVieja)
        {
            int regs = BD.ModificarUsu(usu, Session["Usu"].ToString(), PassVieja);
            if (regs > 0)
            {
                if (usu.Username != null)
                {
                    Session["Usu"] = usu.Username;
                }                           
                return RedirectToAction("Index", "Home", new { id = "1" });
            }
            else if (regs == -2)
            {
                return RedirectToAction("ModificarUsu", "BackOffice", new { id = "Contraseña Incorrecta" });
            }
            else
            {
                return RedirectToAction("ModificarUsu", "BackOffice", new { id = "Ya existe ese nombre de usuario" });
            }        
        }
        public ActionResult MostrarLista()
        {          
            //Lista = BD.TraerPersonajes();            
            return View();            
        }
    }
}