/*
	Info:
		- The progress command and basic filters test case.

	Date:
		- 2016.07.20
		
	Author:
		- Name : Jacky Chen 
		- Nickname : EastMoon
		- Email : jacky_eastmoon@hotmail.com
		
 	Copyright (c) 2016 Jacky Chen
 	Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using UnityEngine;

namespace GameRuleArchitecture.TestCase
{
    public class Test_Core_Controller_filter : TestCase
    {
        #region Constructor
        public Test_Core_Controller_filter()
        {
            this.TestObserverFilter();
            this.TestSubjectFilter();
            this.TestProgressCommand();
        }
        #endregion

        #region Public Method : TestMethod
        public void TestObserverFilter()
        {
            this.Result = "Test Observer filter : \n";
            // Create Filter
            Core.Controller.Filters.ObserverFilter of1 = new Core.Controller.Filters.ObserverFilter("TestObserverFilter", this.onProtectedMethod);
            // Execute
            of1.Execute(new PureMVC.Patterns.Notification("TestNotification", this));

            // Create Filter
            Core.Controller.Filters.ObserverFilter of2 = new Core.Controller.Filters.ObserverFilter("TestObserverFilter", this.onPrivateMethod);
            // Execute
            of2.Execute(new Patterns.Progress("TestProgress", this));

            Debug.Log(this.Result);
        }
        public void TestSubjectFilter()
        {
            this.Result = "Test Subject filter : \n";

            // Create Filter
            Core.Controller.Filters.SubjectFilter sf = new Core.Controller.Filters.SubjectFilter("TestSubjectFilter")
                .AddObserver(this.onPublicMethod)
                .AddObserver(this.onProtectedMethod)
                .AddObserver(this.onPrivateMethod);
            // Execute
            this.Result += "\nSend notification : \n";
            sf.Execute(new PureMVC.Patterns.Notification("TestNotification", this));
            this.Result += "\nSend progress : \n";
            sf.Execute(new Patterns.Progress("TestProgress", this));

            Debug.Log(this.Result);
        }
        public void TestProgressCommand()
        {
            this.Result = "Test Progress command : \n";

            // Create Filter
            Interfaces.IFilter f1 = new Core.Controller.Filters.ObserverFilter("TestObserverFilter1", this.onProgressMethod);
            Interfaces.IFilter f2 = new Filter1();
            Interfaces.IFilter f3 = new Filter2();

            // Create command
            Core.Controller.ProgressCommand pc = new Core.Controller.ProgressCommand();
            pc.AddFilter(f1).AddFilter(f2).AddFilter(f3);

            // Execute
            this.Result += "\nSend notification : \n";
            pc.Execute(new PureMVC.Patterns.Notification("TestNotification", this));
            this.Result += "\nSend progress : \n";
            pc.Execute(new Patterns.Progress("TestProgress", this));

            Debug.Log(this.Result);
        }
        #endregion

        #region Method
        public void onPublicMethod(PureMVC.Interfaces.INotification _notification)
        {
            this.Result += "Event : onPublicMethod \n";
        }
        protected void onProtectedMethod(PureMVC.Interfaces.INotification _notification)
        {
            this.Result += "Event : onProtectedMethod \n";
        }
        protected void onPrivateMethod(PureMVC.Interfaces.INotification _notification)
        {
            this.Result += "Event : onPrivateMethod \n";
        }
        protected void onProgressMethod(PureMVC.Interfaces.INotification _notification)
        {
            Interfaces.IProgress progress = _notification as Interfaces.IProgress;
            if(progress != null)
            { 
                this.Result += "Event : onProgressMethod \n";
                progress.Next();
            }
        }
        #endregion

        #region Class
        public class Filter1 : Patterns.Filter
        {
            public Filter1() : base("TestFilter1") { }

            public override void Execute(Interfaces.IProgress _progress)
            {
                base.Execute(_progress);
                (_progress.Body as TestCase).Result += this.Name + " : Execute \n";
                _progress.Next();
            }
        }
        public class Filter2 : Patterns.Filter
        {
            public Filter2() : base("TestFilter2") { }

            public override void Execute(Interfaces.IProgress _progress)
            {
                base.Execute(_progress);
                (_progress.Body as TestCase).Result += this.Name + " : Execute \n";
                _progress.Next();
            }
        }
        #endregion
    }
}
