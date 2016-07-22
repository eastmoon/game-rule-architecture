/*
	Info:
        - Game Rule Architecture progress controller interface.
        - Pipe and Filter is an architecture, that is use on step by step to execute, and Progress is a controller to control pipe execute state.
        - Pipe is a object to management filters and execute order.
		
	Date:
		- 2016.07.19
		
	Author:
		- Name : Jacky Chen 
		- Nickname : EastMoon
		- Email : jacky_eastmoon@hotmail.com
		
 	Copyright (c) 2016 Jacky Chen
 	Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GameRuleArchitecture.Interfaces
{
    public interface IPipe : IFilter
    {
        #region Public Method
        /// <summary>
        /// Register filter in pipe.
        /// </summary>
        bool Register(IFilter _filter);

        /// <summary>
        /// Remove filter in pipe.
        /// </summary>
        bool Remove(string _name);

        /// <summary>
        /// Check filter in pipe.
        /// </summary>
        bool Has(string _name);

        /// <summary>
        /// Retrieve filter in pipe.
        /// </summary>
        IFilter Retrieve(string _name);

        /// <summary>
        /// Retrieve IProgress by index.
        /// </summary> 
        IProgress GetProgress(int _indexID);

        /// <summary>
        /// Retrieve index by IProgress
        /// </summary> 
        int GetProgressIndex(IProgress _progress);

        /// <summary>
        /// Execute pipe and use progress to control.
        /// </summary> 
        void Execute(IProgress _progress, string _state);
        #endregion

        #region Accessors
        /// <summary>
        /// <P>[Read-only]Get the number of filter in pipe.</P>
        /// </summary>
        int Count { get; }

        /// <summary>
        /// <P>[Read-only]Get the route map in pipe, which is store filter.</P>
        /// </summary>
        ArrayList Routes { get; }

        /// <summary>
        /// <P>[Read-only]Get the state event listener object</P>
        /// </summary>
        ISubjectContainer StateEventListener { get; }
        #endregion
    }
}
