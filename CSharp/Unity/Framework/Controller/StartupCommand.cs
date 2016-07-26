using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using UnityEngine;

using PureMVC.Interfaces;
using GameRuleArchitecture.TestCase;

namespace Game.Framework.Controller
{
    class StartupCommand : ICommand
    {
        public void Execute(INotification _notification)
        {
            // Framework startup.
            // Focus setting framework command, basic module.
            Debug.Log("Framework : Startup command.");

            // Test Case : Observer
            //new Test_Pattern_Observer();

            // Test Case : Progress
            new Test_Pattern_Progress();

            // Test Case : Core controller
            new Test_Core_Controller_filter();
        }
    }
}
