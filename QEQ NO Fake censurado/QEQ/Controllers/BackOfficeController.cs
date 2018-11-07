using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Drawing;
using QEQ.Models;
using System.Net;


namespace QEQ.Controllers
{
    public class BackOfficeController : Controller
    {
        // GET: BackOffice
        public ActionResult Index()
        {
            Session["Admin"] = "Admin";
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
            Mac = ip[0].ToString();
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
            Usu.Mac = ip[0].ToString();
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
        public ActionResult ModificarUsu(string id)
           {      
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
                usu.Mac = ip[0].ToString();
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
        //Area 51----------------------Area 51----------------------Area 51----------------------Area 51----------------------Area 51----------------------
        //ABMPersonajes : Comienzo------------------------------------------------------------------------------------------------
        public ActionResult ABMPer()
        {          
            try
            {
                if (Session["Admin"].ToString() != "Admin")
                {
                    return RedirectToAction("AD", "BackOffice");
                }
                else
                {
                    BD.CargarCats();
                    BD.CargarPersonajes();
                    ViewBag.Personajes = BD.Personajes;
                    return View();
                }
            }
            catch (NullReferenceException)
            {
                return RedirectToAction("AD", "BackOffice");
            }
        }
        public ActionResult AgregarP()
        {
            Session["Admin"] = "Admin";
            try
            {
                if (Session["Admin"].ToString() != "Admin")
                {
                    return RedirectToAction("AD", "BackOffice");
                }
                else
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
            }
            catch (NullReferenceException)
            {
                return RedirectToAction("AD", "BackOffice");
            }
        }
        [HttpPost]
        public ActionResult AgregarPer(Personaje P)
        {
            
            if (Session["Admin"].ToString() != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            else
            {
                int tamaño = P.Foto.ContentLength;
                byte[] ImagenOriginal = new byte[tamaño];
                P.Foto.InputStream.Read(ImagenOriginal, 0, tamaño);
                P.FotoByte = ImagenOriginal;
                
                Session["Destino"] = "ABMPer";
                Session["ABMMsg"] = BD.AgregarP(P);
                return View("ABMMsg");
            }
        }

        /* lista falsa para probar
          List<Personaje> Personajes = new List<Personaje>();
            Personajes.Add(new Personaje(1,"1","1","1"));
            Personajes.Add(new Personaje(2, "2", "1", "1"));
            Personajes.Add(new Personaje(3, "3", "1", "1"));
            ViewBag.Personajes = Personajes;
             */
        public ActionResult BorrarP(int id)
        {
            if (Session["Admin"].ToString() != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            else
            {
                ViewBag.Id = id;
                return View();
            }
        }
        [HttpPost]
        public ActionResult BorrarPer(string Confirmacion, int id)
        {
            if (Session["Admin"].ToString() != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            else
            {
                Session["Destino"] = "ABMPer";
                if (Confirmacion == "Si")
                {
                    Session["ABMMsg"] = BD.BorrarP(id);
                }
                else
                {
                    Session["ABMMsg"] = "Ha decidido no Eliminar Personajes";

                }
                return View("ABMMsg");
            }
        }

        public ActionResult ModificarP(int id)
        {
            if (Session["Admin"].ToString() != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            else
            {
                Personaje elpersonaje = BD.BuscarPersonaje(id);
                BD.CargarPreguntas();
                BD.CargarCats();
                //  Personaje mipersonaje = new Personaje(id, null, null,null, 0);
                ViewBag.Nombre = BD.BuscarPersonaje(id).Nombre;
                //mipersonaje = buscar en la lista y traer el personaje
                //ViewBag.ListaCat = ModelBinderDictionary.TraerCategorias();
                ViewBag.ListaCat = BD.Categorias;
                ViewBag.PregsXGrupo = BD.PregsXGrupos;
                ViewBag.Grupos = BD.Grupos;
                ViewBag.RtaXPer = BD.CargarRxP(id);
                return View(elpersonaje);
            }
        }

        [HttpPost]
        public ActionResult ModificarP(Personaje P)
        {
            if (Session["Admin"].ToString() != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            else
            {
                int tamaño = P.Foto.ContentLength;
                byte[] ImagenOriginal = new byte[tamaño];
                P.Foto.InputStream.Read(ImagenOriginal, 0, tamaño);
                P.FotoByte = ImagenOriginal;
                Session["Destino"] = "ABMPer";
                Session["ABMMsg"] = BD.ModificarP(P);
                return View("ABMMsg");
            }
        }
        //ABMPersonajes : FIn------------------------------------------------------------------------------------------------
        //ABMCategorias : Comienzo------------------------------------------------------------------------------------------------
        public ActionResult ABMCat()
        {
            if (Session["Admin"].ToString() != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            else
            {
                BD.CargarCats();
                BD.CargarGrupos();
                ViewBag.Categorias = BD.Categorias;
                ViewBag.Grupos = BD.Grupos;
                return View();
            }
        }
        
        public ActionResult AgregarCat()
        {
            if (Session["Admin"].ToString() != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            else
            {
                BD.CargarCats();
                return View();
            }
        }

        [HttpPost]
        public ActionResult AgregarCat(string Cat, string tipo)
        {
            if (Session["Admin"].ToString() != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            else
            {
                Session["Destino"] = "ABMCat";
                Session["ABMMsg"] = BD.AgregarCat(Cat, Convert.ToBoolean(tipo));
                return View("ABMMsg");
            }
        }
        
        public ActionResult BorrarCat(int id, bool tipo)
        {
            if (Session["Admin"].ToString() != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            else
            {
                ViewBag.Id = id;
                ViewBag.Tipo = tipo;
                return View();
            }
        }
        [HttpPost]
        public ActionResult BorrarCat(string Confirmacion, int id)
        {
            if (Session["Admin"].ToString() != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            else
            {
                Session["Destino"] = "ABMCat";
                if (Confirmacion == "Si")
                {
                    Session["ABMMsg"] = BD.BorrarCat(BD.BuscarCat(id,BD.Categorias),true);
                }
                else
                {
                    Session["ABMMsg"] = "Ha decidido no Eliminar Personajes";

                }
                return View("ABMMsg");
            }
        }

        public ActionResult ModificarCat(int id, bool tipo)
        {
            if (Session["Admin"].ToString() != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            else
            {
                if (Session["Admin"].ToString() != "Admin")
                {
                    return RedirectToAction("AD", "BackOffice");
                }
                ViewBag.Id =id;
                ViewBag.tipo = tipo.ToString();
                Cat cat = new Cat(id, null);
                BD.CargarCats();
                return View(cat);
            }
        }

        [HttpPost]
        public ActionResult ModificarCat(Cat cat, string tipo)
        {
            if (Session["Admin"].ToString() != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            else
            {
                Session["Destino"] = "ABMCat";
                Session["ABMMsg"] = BD.ModificarCat(cat, Convert.ToBoolean(tipo));
                return View("ABMMsg");
            }
        }
        //ABMCategorias : fin------------------------------------------------------------------------------------------------
        //ABMCaracteristicas o preguntas : Comienzo------------------------------------------------------------------------------------------------

        public ActionResult ABMCar()
        {
            if (Session["Admin"].ToString() != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            else
            {
                BD.CargarPreguntas();
                ViewBag.Preguntas = BD.Preguntas;
                return View();
            }
        }
        public ActionResult AgregarCar()
        {
            if (Session["Admin"].ToString() != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            else
            {
                BD.CargarPreguntas();
                BD.CargarGrupos();
                Preg lapregunta = new Preg();
                ViewBag.Grupos = BD.Grupos;
                return View(lapregunta);
            }
        }

        [HttpPost]
        public ActionResult AgregarCar(Preg preg)
        {
            if (Session["Admin"].ToString() != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            else
            {
                Session["Destino"] = "ABMCar";
                Session["ABMMsg"] = BD.AgregarCar(preg);
                return View("ABMMsg");
            }
        }
        public ActionResult BorrarCar(int id)
        {
            if (Session["Admin"].ToString() != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            else
            {
                ViewBag.Id = id;
                return View();
            }
        }
        [HttpPost]
        public ActionResult BorrarCar(string Confirmacion, int id)
        {
            if (Session["Admin"].ToString() != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            else
            {
                Session["Destino"] = "ABMCar";
                if (Confirmacion == "Si")
                {
                    Session["ABMMsg"] = BD.BorrarCar(BD.BuscarPregunta(id));
                }
                else
                {
                    Session["ABMMsg"] = "Ha decidido no Eliminar Personajes";

                }
                return View("ABMMsg");
            }
        }

        public ActionResult ModificarCar(int id)
        {
            if (Session["Admin"].ToString() != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            else
            {
                ViewBag.Id = id;
                ViewBag.Grupos = BD.Grupos;
                Preg caracteristica = new Preg(id, null, 0);
                return View(caracteristica);
            }
        }

        [HttpPost]
        public ActionResult ModificarCar(Preg caracteristica)
        {
            if (Session["Admin"].ToString() != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            else
            {
                Session["Destino"] = "ABMCar";
                Session["ABMMsg"] = BD.ModificarCar(caracteristica);
                return View("ABMMsg");
            }
        }
        //ABMCaracteristicas o preguntas : Fin------------------------------------------------------------------------------------------------
        //Area 51----------------------Area 51----------------------Area 51----------------------Area 51----------------------Area 51----------------------
        
        public ActionResult MostrarLista()
        {
            if (Session["Admin"].ToString() != "Admin")
            {
                return RedirectToAction("AD", "BackOffice");
            }
            //Lista = BD.TraerPersonajes();            
            return View();            
        }
    }
}