/*
	Info:
		- The observer pattern test case.

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
    public class Test_Pattern_Observer : TestCase
    {

        #region Constructor
        public Test_Pattern_Observer()
        {
            this.TestPureMVCObserver();
            this.TestSubject();
            this.TestSubjectContainer();
        }
        #endregion

        #region Public Method : TestMethod
        public void TestPureMVCObserver()
        {
            this.Result = "Test PureMVC.Observer and GRA.CommonObserver : \n";
            Action<PureMVC.Interfaces.INotification> fun1 = this.onPublicMethod;
            Action<PureMVC.Interfaces.INotification> fun2 = this.onPrivateMethod;

            // PureMVC observer is only can call public method in instance object.
            PureMVC.Patterns.Observer observer_puremvc = new PureMVC.Patterns.Observer(fun1.Method.Name, fun1.Target);
            observer_puremvc.NotifyObserver(null);

            // GameRuleArchitecture observer could define calling method type in instance object. Default is all type, which is public, protected, private.
            GameRuleArchitecture.Patterns.CommonObserver observer_gra = new GameRuleArchitecture.Patterns.CommonObserver(fun2.Method.Name, fun2.Target);
            observer_gra.NotifyObserver(null);
            Debug.Log(this.Result);
        }
        public void TestSubject()
        {
            this.Result = "Test Subject : \n";

            // Create
            Interfaces.ISubject sub = new Patterns.Subject("TestSubject");
            PureMVC.Patterns.Notification note = new PureMVC.Patterns.Notification(sub.NotificaionName);
            this.Result += "Total observer : " + sub.Count + " \n";

            // Register
            this.Result += "Register : \n";
            sub.Register(this.onPublicMethod);
            sub.Register(this.onProtectedMethod);
            sub.Register(this.onPrivateMethod);
            this.Result += "Total observer : " + sub.Count + " \n";
            sub.NotifyObserver(note);

            // Remove
            this.Result += "\nRemove protected method observer : \n";
            sub.Remove(this.onProtectedMethod);
            this.Result += "Total observer : " + sub.Count + " \n";
            sub.NotifyObserver(note);

            // Has
            this.Result += "\nHas private method observer : " + sub.Has(this.onPrivateMethod) + " \n";

            // Retrieve
            this.Result += "\nRetrieve public method observer : \n";
            PureMVC.Interfaces.IObserver observer1 = sub.Retrieve(this.onPublicMethod);
            observer1.NotifyObserver(null);
            this.Result += "\nRetrieve private method observer : \n";
            PureMVC.Interfaces.IObserver observer2 = sub.Retrieve(this.onPrivateMethod);
            observer2.NotifyObserver(null);

            Debug.Log(this.Result);
        }
        public void TestSubjectContainer()
        {
            this.Result = "Test SubjectContainer : \n";
            Interfaces.ISubjectContainer container = new Patterns.SubjectContainer();
            this.Result += "Total subject : " + container.Count + " \n";

            // Create subject
            Interfaces.ISubject sub1 = new Patterns.Subject("PublicMethod");
            Interfaces.ISubject sub2 = new Patterns.Subject("ProtectedMethod");
            Interfaces.ISubject sub3 = new Patterns.Subject("PrivateMethod");

            // Register method
            sub1.Register(this.onPublicMethod);
            sub2.Register(this.onProtectedMethod);
            sub3.Register(this.onPrivateMethod);

            // Register subject
            this.Result += "\nRegister : \n";
            container.Register(sub1);
            container.Register(sub2);
            container.Register(sub3);
            IList<string> list = container.ListSubjectInterests;
            for(int i = 0; i < list.Count; i++)
            {
                this.Result += "Subject name : " + list[i] + " \n";
            }
            this.Result += "Total subject : " + container.Count + " \n";

            // Remove subject
            this.Result += "\nRemove : \n";
            container.Remove(sub1.NotificaionName);
            this.Result += "Total subject : " + container.Count + " \n";

            // Has subject
            this.Result += "\nHas private method subject : " + container.Has(sub3.NotificaionName) + " \n";

            // Retrieve subject
            this.Result += "\nRetrieve pritected method : \n";
            Interfaces.ISubject sub = container.Retrieve(sub2.NotificaionName);
            sub.NotifyObserver(new PureMVC.Patterns.Notification(sub2.NotificaionName));

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
        #endregion
    }
}
