using Microsoft.Owin;
using Owin;
using System.Web.Services.Description;
using System;
using Microsoft.AspNet.SignalR;

[assembly: OwinStartupAttribute(typeof(QEQ.Startup))]
namespace QEQ
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
            app.MapSignalR();
        }
        
        
      
    }
}
