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
            Session["Msg"] = "";
            return View();
        }


        public ActionResult About()
        {
            return View();
        }

        public ActionResult ABMMsg()
        {
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
            string Host = Dns.GetHostName(), Ip ;
            IPAddress[] ip = Dns.GetHostAddresses(Host);
            Ip = ip[0].ToString();
            
            if (Ip == "")
            {
                Ip = "NoIp";
            
            }
            if (contraseña != "" && Usuario != "")
            {
                Usuario usu;
                usu = BD.Login(Usuario, contraseña, Ip);
                if (usu.Username != "")
                {
                    Session["Usu"] = Usuario;
                    BD.usuario = usu;
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
        public ActionResult OlvidoPass()
        {
            return View();
        }
        [HttpPost]
        public ActionResult OlvidoPass(string Usuario, string Contraseña)
        {
            if (Usuario != "" && Contraseña != "")
            {
                //Usuario usu;
               // usu = BD.spOlvidoPass(Usuario, Contraseña);
            }
            return RedirectToAction("OlvidoPass", "BackOfice");
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
         
            if (Usu.Admin && Pin != "1")
            {
                Usu.Admin = false;
            }

            int regs = BD.Register(Usu);
            Session["Usu"] = Usu.Username;
            BD.usuario = Usu;
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
                    BD.usuario = usu;
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
            try
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

                    Session["Msg"] = BD.AgregarP(P);
                    return RedirectToAction("ABMPer", "BackOffice");
                }
            }
            catch (NullReferenceException)
            {
                return RedirectToAction("AD", "BackOffice");
            }
        }
   
        public ActionResult BorrarP(int id)
        {
            try
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
            catch (NullReferenceException)
            {
                return RedirectToAction("AD", "BackOffice");
            }
        }
        [HttpPost]
        public ActionResult BorrarPer(string Confirmacion, int id)
        {
            try
            {
                if (Session["Admin"].ToString() != "Admin")
                {
                    return RedirectToAction("AD", "BackOffice");
                }
                else
                {
                    if (Confirmacion == "Si")
                    {
                        Session["Msg"] = BD.BorrarP(id);
                    }
                    else
                    {
                        Session["Msg"] = "Ha decidido no Eliminar Personajes";

                    }
                    return RedirectToAction("ABMPer", "BackOffice");
                }
            }
            catch (NullReferenceException)
            {
                return RedirectToAction("AD", "BackOffice");
            }
        }

        public ActionResult ModificarP(int id)
        {
            try
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
            catch (NullReferenceException)
            {
                return RedirectToAction("AD", "BackOffice");
            }
        }

        [HttpPost]
        public ActionResult ModificarP(Personaje P)
        {
            try
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
                    Session["Msg"] = BD.ModificarP(P);
                    return RedirectToAction("ABMPer", "BackOffice");
                }
            }
            catch (NullReferenceException)
            {
                return RedirectToAction("AD", "BackOffice");
            }
        }
        //ABMPersonajes : FIn------------------------------------------------------------------------------------------------
        //ABMCategorias : Comienzo------------------------------------------------------------------------------------------------
        public ActionResult ABMCat()
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
                    BD.CargarGrupos();
                    ViewBag.Categorias = BD.Categorias;
                    ViewBag.Grupos = BD.Grupos;
                    return View();
                }
            }
            catch (NullReferenceException)
            {
                return RedirectToAction("AD", "BackOffice");
            }
        }

        public ActionResult AgregarCat()
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
                    return View();
                }
            }
            catch (NullReferenceException)
            {
                return RedirectToAction("AD", "BackOffice");
            }
        }

        [HttpPost]
        public ActionResult AgregarCat(string Cat, string tipo)
        {
            try
            {
                if (Session["Admin"].ToString() != "Admin")
                {
                    return RedirectToAction("AD", "BackOffice");
                }
                else
                {
                    Session["Msg"] = BD.AgregarCat(Cat, Convert.ToBoolean(tipo));
                    return RedirectToAction("ABMCat", "BackOffice");
                }
            }
            catch (NullReferenceException)
            {
                return RedirectToAction("AD", "BackOffice");
            }
        }

        public ActionResult BorrarCat(int id, bool tipo)
        {
            try
            {
                if (Session["Admin"].ToString() != "Admin")
                {
                    return RedirectToAction("AD", "BackOffice");
                }
                else
                {
                    ViewBag.Id = id;
                    ViewBag.tipo = tipo.ToString();
                    return View();
                }
            }
            catch (NullReferenceException)
            {
                return RedirectToAction("AD", "BackOffice");
            }
        }
        [HttpPost]
        public ActionResult BorrarCat(string Confirmacion, int id, string tipo)
        {
            try
            {
                if (Session["Admin"].ToString() != "Admin")
                {
                    return RedirectToAction("AD", "BackOffice");
                }
                else
                {
                    bool Tipo = Convert.ToBoolean(tipo);
                    List<Cat> lista;

                    if (Confirmacion == "Si")
                    {
                        if (Tipo) { lista = BD.Categorias; }
                        else { lista = BD.Grupos; }
                        Session["Msg"] = BD.BorrarCat(BD.BuscarCat(id, lista), Tipo);
                    }
                    else
                    {
                        Session["Msg"] = "Ha decidido no Eliminar Personajes";

                    }
                    return RedirectToAction("ABMCat", "BackOffice");
                }
            }
            catch (NullReferenceException)
            {
                return RedirectToAction("AD", "BackOffice");
            }
        }

        public ActionResult ModificarCat(int id, bool tipo)
        {
            try
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
                    ViewBag.Id = id;
                    ViewBag.tipo = tipo.ToString();
                    Cat cat;
                    if (tipo)
                    {
                        cat = BD.BuscarCat(id, BD.Categorias);
                        BD.CargarCats();
                    }
                    else
                    {
                        cat = BD.BuscarCat(id, BD.Grupos);
                        BD.CargarGrupos();
                    }
                    return View(cat);
                }
            }
            catch (NullReferenceException)
            {
                return RedirectToAction("AD", "BackOffice");
            }
        }

        [HttpPost]
        public ActionResult ModificarCat(Cat cat, string tipo)
        {
            try
            {
                if (Session["Admin"].ToString() != "Admin")
                {
                    return RedirectToAction("AD", "BackOffice");
                }
                else
                {
                    Session["Msg"] = BD.ModificarCat(cat, Convert.ToBoolean(tipo));
                    return RedirectToAction("ABMCat", "BackOffice");
                }
            }
            catch (NullReferenceException)
            {
                return RedirectToAction("AD", "BackOffice");
            }
        }
        //ABMCategorias : fin------------------------------------------------------------------------------------------------
        //ABMCaracteristicas o preguntas : Comienzo------------------------------------------------------------------------------------------------

        public ActionResult ABMCar()
        {
            try
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
            catch (NullReferenceException)
            {
                return RedirectToAction("AD", "BackOffice");
            }
        }
        public ActionResult AgregarCar()
        {
            try
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
            catch (NullReferenceException)
            {
                return RedirectToAction("AD", "BackOffice");
            }
        }

        [HttpPost]
        public ActionResult AgregarCar(Preg preg)
        {
            try
            {
                if (Session["Admin"].ToString() != "Admin")
                {
                    return RedirectToAction("AD", "BackOffice");
                }
                else
                {
                    Session["Msg"] = BD.AgregarCar(preg);
                    return RedirectToAction("ABMCar", "BackOffice");
                }
            }
            catch (NullReferenceException)
            {
                return RedirectToAction("AD", "BackOffice");
            }
        }
        public ActionResult BorrarCar(int id)
        {
            try
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
            catch (NullReferenceException)
            {
                return RedirectToAction("AD", "BackOffice");
            }
        }
        [HttpPost]
        public ActionResult BorrarCar(string Confirmacion, int id)
        {
            try
            {
                if (Session["Admin"].ToString() != "Admin")
                {
                    return RedirectToAction("AD", "BackOffice");
                }
                else
                {
                    if (Confirmacion == "Si")
                    {
                        Session["Msg"] = BD.BorrarCar(BD.BuscarPregunta(id));
                    }
                    else
                    {
                        Session["Msg"] = "Ha decidido no Eliminar Personajes";

                    }
                    return RedirectToAction("ABMCar", "BackOffice");
                }
            }

            catch (NullReferenceException)
            {
                return RedirectToAction("AD", "BackOffice");
            }
        }

        public ActionResult ModificarCar(int id)
        {
            try
            {
                if (Session["Admin"].ToString() != "Admin")
                {
                    return RedirectToAction("AD", "BackOffice");
                }
                else
                {
                    ViewBag.Id = id;
                    ViewBag.Grupos = BD.Grupos;
                    Preg caracteristica = BD.BuscarPregunta(id);
                    return View(caracteristica);
                }
            }
            catch (NullReferenceException)
            {
                return RedirectToAction("AD", "BackOffice");
            }
        }


        [HttpPost]
        public ActionResult ModificarCar(Preg caracteristica)
        {
            try
            {
                if (Session["Admin"].ToString() != "Admin")
                {
                    return RedirectToAction("AD", "BackOffice");
                }
                else
                {
                    Session["Msg"] = BD.ModificarCar(caracteristica);
                    return RedirectToAction("ABMCar", "BackOffice");
                }
            }
            catch (NullReferenceException)
            {
                return RedirectToAction("AD", "BackOffice");
            }
        }
        //ABMCaracteristicas o preguntas : Fin------------------------------------------------------------------------------------------------
        //Area 51----------------------Area 51----------------------Area 51----------------------Area 51----------------------Area 51----------------------

        public ActionResult MostrarLista()
        {
            try
            {
                if (Session["Admin"].ToString() != "Admin")
                {
                    return RedirectToAction("AD", "BackOffice");
                }
                //Lista = BD.TraerPersonajes();            
                return View();
            }
            catch (NullReferenceException)
            {
                return RedirectToAction("AD", "BackOffice");
            }
        }
    }
}
    