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

        public ActionResult ABMMsg() {
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
                usu = BD.Login(Usuario, contraseña, Ip, Mac);
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
        public ActionResult Register(Usuario Usu, string Pin)
        {
            string Host = Dns.GetHostName();
            IPAddress[] ip = Dns.GetHostAddresses(Host);
            Usu.Ip = ip[0].ToString();
            Usu.Mac = ip[3].ToString();
            if (Usu.Admin && Pin != "1")
            {
                Usu.Admin = false;
            }

            int regs = BD.Register(Usu);
            Session["Usu"] = Usu.Username;
            if (Usu.Admin)
            {
                Session["Admin"] = "Admin";
            }
            return RedirectToAction("Index", "Home");
        }
        public ActionResult AD()
        {
            return View();
        }

        //ABMPersonajes : Comienzo------------------------------------------------------------------------------------------------
        public ActionResult ABMPer()
        {
            if (Session["Admin"] != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            BD.CargarPersonajes();
            ViewBag.Personajes = BD.Personajes;
            return View();
        }
        public ActionResult AgregarP()
        {
            if (Session["Admin"] != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
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
            Session["Destino"] = "ABMPer";
            Session["ABMMsg"] = BD.AgregarP(P);
            return View("ABMMsg");
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
            if (Session["Admin"] != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            Session["Nombre"] = Nombre;
            return View();
        }
        [HttpPost]
        public ActionResult BorrarPer(string Confirmacion)
        {
            if (Session["Admin"] != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            Session["Destino"] = "ABMPer";
            if (Confirmacion == "Si") {
                Session["ABMMsg"] = BD.BorrarP(Session["Nombre"].ToString());
            }
            else
            {
                Session["ABMMsg"] = "Ha decidido no Eliminar Personajes";
                
            }
            return View("ABMMsg");
        }

        public ActionResult ModificarP(string Nombre)
        {
            if (Session["Admin"] != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            BD.CargarPreguntas();
            BD.CargarCats();
            Personaje mipersonaje = new Personaje();
            Session["Nombre"] = Nombre;
            //mipersonaje = buscar en la lista y traer el personaje
            //ViewBag.ListaCat = ModelBinderDictionary.TraerCategorias();
            ViewBag.ListaCat = BD.Categorias;
            ViewBag.PregsXGrupo = BD.PregsXGrupos;
            ViewBag.Grupos = BD.Grupos;
            return View(mipersonaje);

        }

        [HttpPost]
        public ActionResult ModificarPer(Personaje P)
        {
            Session["Destino"] = "ABMPer";
            Session["ABMMsg"] = BD.ModificarP(Session["Nombre"].ToString(), P);
            return View("ABMMsg");
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
        
        public ActionResult AgregarCat()
        {
            if (Session["Admin"] != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            BD.CargarCats();            
            return View();
        }

        [HttpPost]
        public ActionResult AgregarCat(string Cat, string tipo)
        {
            Session["Destino"] = "ABMCat";
            Session["ABMMsg"] = BD.AgregarCat(Cat, Convert.ToBoolean(tipo));
            return View("ABMMsg");
        }
        
        public ActionResult BorrarCat(string Cat)
        {
            if (Session["Admin"] != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            Session["Cat"] = Cat;
            return View();
        }
        [HttpPost]
        public ActionResult BorrarCate(string Confirmacion)
        {
            Session["Destino"] = "ABMCat";
            if (Confirmacion == "Si")
            {
                Session["ABMMsg"] = BD.BorrarCat(Session["Cat"].ToString(), BuscarCat(Session["Cat"].ToString(), BD.Categorias));
            }
            else
            {
                Session["ABMMsg"] = "Ha decidido no Eliminar Personajes";

            }
            return View("ABMMsg");
        }

        public ActionResult ModificarCat(string Cat)
        {
            if (Session["Admin"] != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            Session["Cat"] = Cat;
            BD.CargarCats();
            return View();

        }

        [HttpPost]
        public ActionResult ModificarCate(string NewCat, string tipo)
        {
            Session["Destino"] = "ABMCat";
            Session["ABMMsg"] = BD.ModificarCat(Session["Cat"].ToString(),NewCat, Convert.ToBoolean(tipo));
            return View("ABMMsg");
        }
        //ABMCategorias : fin------------------------------------------------------------------------------------------------
        //ABMCaracteristicas o preguntas : Comienzo------------------------------------------------------------------------------------------------

        public ActionResult ABMCar()
        {
            if (Session["Admin"] != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            BD.CargarPreguntas();
            ViewBag.Preguntas = BD.Preguntas;
            return View();
        }
        public ActionResult AgregarCar()
        {
            if (Session["Admin"] != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            BD.CargarPreguntas();
            BD.CargarGrupos();
            Preg lapregunta = new Preg();
            ViewBag.Grupos = BD.Grupos;
            return View(lapregunta);
        }

        [HttpPost]
        public ActionResult AgregarCar(Preg preg)
        {
            Session["Destino"] = "ABMPer";
            Session["ABMMsg"] = BD.AgregarCar(preg);
            return View("ABMMsg");
        }
        
        public ActionResult BorrarCar(string Texto)
        {
            if (Session["Admin"] != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            Session["Texto"] = Texto;
            return View();
        }
        [HttpPost]
        public ActionResult BorrarCara(string Confirmacion)
        {
            Session["Destino"] = "ABMCar";
            if (Confirmacion == "Si")
            {
                Session["ABMMsg"] = BD.BorrarCar(Session["Texto"].ToString());
            }
            else
            {
                Session["ABMMsg"] = "Ha decidido no Eliminar Personajes";

            }
            return View("ABMMsg");
        }

        public ActionResult ModificarCar(string Texto)
        {
            if (Session["Admin"] != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            Session["Texto"] = Texto;
            Preg caracteristica = new Preg(BD.BuscarPregunta(ViewBag.Texto).Id, ViewBag.Texto, null);
            return View(caracteristica);

        }

        [HttpPost]
        public ActionResult ModificarCar( Preg caracteristica)
        {
            Session["Destino"] = "ABMPer";
            Session["ABMMsg"] = BD.ModificarCar(Session["Texto"].ToString(), caracteristica);
            return View("ABMMsg");
        }

        //ABMCaracteristicas o preguntas : Fin------------------------------------------------------------------------------------------------
        public ActionResult ModificarUsu(string id)
        {
            if (Session["Admin"] != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            if (id != null)
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
                string Host = Dns.GetHostName();
                IPAddress[] ip = Dns.GetHostAddresses(Host);
                usu.Ip = ip[0].ToString();
                usu.Mac = ip[3].ToString();
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
            if (Session["Admin"] != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            //Lista = BD.TraerPersonajes();            
            return View();            
        }
    }
}