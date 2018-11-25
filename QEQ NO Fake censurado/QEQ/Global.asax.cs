using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using System.Configuration;
using System.Data.SqlClient;

namespace QEQ
{
    public class MvcApplication : System.Web.HttpApplication
    {
        string connectionString = @"Server=DESKTOP-5P28OS5;Database=QEQA03;Trusted_Connection=True;"; //Anush
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            SqlDependency.Start(connectionString);
        }

        protected void Application_End()
        {
            SqlDependency.Stop(connectionString);
        }
    }
}
