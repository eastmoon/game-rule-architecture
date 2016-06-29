using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using UnityEngine;

using PureMVC.Interfaces;

namespace Game.Framework.Controller
{
    class StartupCommand : ICommand
    {
        public void Execute(INotification notification)
        {
            Debug.Log("Framework : Startup command.");
        }
    }
}
