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
        public ActionResult Index()
        {
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
                
            
           
        

    