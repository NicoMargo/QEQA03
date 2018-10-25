using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(QEQ.Startup))]
namespace QEQ
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
