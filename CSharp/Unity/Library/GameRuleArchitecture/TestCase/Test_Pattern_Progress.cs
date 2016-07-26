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

using GameRuleArchitecture.Interfaces;
using GameRuleArchitecture.Patterns;
using UnityEngine;

namespace GameRuleArchitecture.TestCase
{
    public class Test_Pattern_Progress : TestCase
    {
        #region Constructor
        public Test_Pattern_Progress()
        {
            this.TestFilter();
            this.TestPipe();
            this.TestProgress();
        }
        #endregion

        #region Public Method : TestMethod
        public void TestFilter()
        {
            this.Result = "Test Filter : \n";

            IFilter filter = new MyFilter();
            IProgress progress = new Progress("ProgressController", this);
            filter.Execute(progress);

            Debug.Log(this.Result);
        }

        public void TestPipe()
        {
            // Create progress
            IProgress progress = new Progress("ProgressController", this);
            // Create filter
            IFilter f1 = new Filter1();
            IFilter f2 = new Filter2();
            // Create pipe
            this.Result = "Test Pipe : \n";
            IPipe pipe = new Pipe("TestPipe");
            this.Result += "Total filter : " + pipe.Count + " \n";

            #region Test filter routes
           
            // Register
            this.Result += "\nRegister : \n";
            pipe.Register(f1);
            pipe.Register(f2);
            // issue : duplicate register test.
            pipe.Register(f1);
            this.Result += "Total filter : " + pipe.Count + " \n";
            pipe.Execute(progress);
            this.Result += "Progress pipe = null : " + (progress.Pipe == null) + " \n";


            // Remove
            this.Result += "\nRemove : \n";
            pipe.Remove(f1.Name);
            // issue : duplicate remove test.
            pipe.Remove(f1.Name);
            this.Result += "Total filter : " + pipe.Count + " \n";

            // Has
            this.Result += "\nHas Filter1 : " + pipe.Has(f1.Name) + " \n";
            this.Result += "\nHas Filter2 : " + pipe.Has(f2.Name) + " \n";

            // Retreive
            this.Result += "\nRetrieve Filter2 : \n";
            IFilter f = pipe.Retrieve(f2.Name) as IFilter;
            if (f != null)
                f.Execute(progress);
            #endregion

            #region Nest filter routes
            #endregion

            Debug.Log(this.Result);
        }

        public void TestProgress()
        {
            this.Result = "Test Progress Process : \n";

            // Create progress
            IProgress progress = new Progress("ProgressController", this);
            // Create filter
            IFilter f1 = new Filter1();
            IFilter f2 = new Filter2();
            IFilter fg = new FilterGoto();
            IFilter fc = new FilterComplete();
            IFilter fe = new FilterError();

            // Next
            this.Result += "\nNext (Standard) : \n";
            IPipe pn = new Pipe("TestPipe");
            pn.Register(f1);
            pn.Register(f2);
            pn.Execute(progress);

            // Goto
            this.Result += "\nGoto : \n";
            IPipe pg = new Pipe("TestPipe");
            pg.Register(fg);
            pg.Register(f1);
            pg.Register(f2);
            pg.Execute(progress);

            // Complete
            this.Result += "\nComplete : \n";
            IPipe pc = new Pipe("TestPipe");
            pc.Register(fc);
            pc.Register(f1);
            pc.StateEventListener.Retrieve(Pipe.STATE_COMPLETE).Register(this.onPipeComplete);
            pc.Execute(progress);

            // Error
            this.Result += "\nError : \n";
            IPipe pe = new Pipe("TestPipe");
            pe.Register(fe);
            pe.Register(f1);
            pe.StateEventListener.Retrieve(Pipe.STATE_ERROR).Register(this.onPipeError);
            pe.Execute(progress);
            this.Result += progress.ErrorMessage + "\n";

            /*
            progress.Goto(f1.Name);
            progress.Complete();
            // Error
            progress.Error("Error message");
            */
            Debug.Log(this.Result);
        }
        #endregion

        #region Method
        public void onPipeComplete(PureMVC.Interfaces.INotification _notification)
        {
            this.Result += "Event : onPipeComplete \n";
        }
        public void onPipeError(PureMVC.Interfaces.INotification _notification)
        {
            this.Result += "Event : onPipeError \n";
        }
        #endregion

        #region Class
        public class MyFilter : Filter
        {
            public MyFilter() : base("MyFilter") { }

            public override void Execute(IProgress _progress)
            {
                base.Execute(_progress);
                (_progress.Body as TestCase).Result += this.Name + " : Execute \n";
                (_progress.Body as TestCase).Result += this.Name + " : Facade_" + this.Facade.ToString() + " \n";
            }
        }
        public class Filter1 : Filter
        {
            public Filter1() : base("TestFilter1") { }

            public override void Execute(IProgress _progress)
            {
                base.Execute(_progress);
                (_progress.Body as TestCase).Result += this.Name + " : Execute \n";
                _progress.Next();
            }
        }
        public class Filter2 : Filter
        {
            public Filter2() : base("TestFilter2") { }

            public override void Execute(IProgress _progress)
            {
                base.Execute(_progress);
                (_progress.Body as TestCase).Result += this.Name + " : Execute \n";
                _progress.Next();
            }
        }
        public class FilterGoto : Filter
        {
            public FilterGoto() : base("TestFilterGoto") { }

            public override void Execute(IProgress _progress)
            {
                base.Execute(_progress);
                (_progress.Body as TestCase).Result += this.Name + " : Execute \n";
                _progress.Goto("TestFilter2");
            }
        }
        public class FilterComplete : Filter
        {
            public FilterComplete() : base("TestFilterComplete") { }

            public override void Execute(IProgress _progress)
            {
                base.Execute(_progress);
                (_progress.Body as TestCase).Result += this.Name + " : Execute \n";
                _progress.Complete();
            }
        }
        public class FilterError : Filter
        {
            public FilterError() : base("TestFilterError") { }

            public override void Execute(IProgress _progress)
            {
                base.Execute(_progress);
                (_progress.Body as TestCase).Result += this.Name + " : Execute \n";
                _progress.Error("Error message : abcdefghijklmnopqrstuvwxyz.");
            }
        }
        #endregion
    }
}
