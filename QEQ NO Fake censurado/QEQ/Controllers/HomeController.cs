using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QEQ.Models;

namespace QEQ.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index(string id = null)
        {
            if (id == "1")
            {
                ViewBag.estado = 1;
            }
            return View();
        }

        
        public ActionResult Logout()
        {
            Session["Usu"] = null;
            BD.msg = null;
            return RedirectToAction("Index", "Home");
        }
    }
}
                
            
           
        

    