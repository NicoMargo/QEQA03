using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QEQ
{
    public class MyHub1 : Hub
    {
        public void Show(bool bturno)
        {
            
                Clients.All.broadcastMessage(bturno);
        }
        

    }
}
