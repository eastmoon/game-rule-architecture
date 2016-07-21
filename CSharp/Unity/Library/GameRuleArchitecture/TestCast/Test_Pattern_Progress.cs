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
            IProgress progress = new Progress("Progress1", this);
            filter.Execute(progress);

            Debug.Log(this.Result);
        }

        public void TestPipe()
        {
            // Create progress
            IProgress progress = new Progress("Progress1", this);
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
            /*
            GameRuleArchitecture.Interfaces.IPipe p = new GameRuleArchitecture.Patterns.Pipe();
            p.Execute(new GameRuleArchitecture.Patterns.Progress("XXX"));
            p.Execute(new GameRuleArchitecture.Patterns.Progress("YYY"), GameRuleArchitecture.Patterns.Pipe.STEP_COMPLETE); 
            */
            Debug.Log(this.Result);
        }

        #endregion

        #region Method
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
        #endregion
    }
}
