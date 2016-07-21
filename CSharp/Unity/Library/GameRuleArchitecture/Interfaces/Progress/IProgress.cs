/*
	Info:
        - Game Rule Architecture progress controller interface.
        - Pipe and Filter is an architecture, that is use on step by step to execute, and Progress is a controller to control pipe execute state.
        - Progress is a sequence controller, control what filter will execute.
		
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
using System.Collections.Generic;
using System.Linq;
using System.Text;

using PureMVC.Interfaces;

namespace GameRuleArchitecture.Interfaces
{
    public interface IProgress : INotification
    {
        #region Public Method
        /// <summary>
        /// Goto next step in pipe routes.
        /// </summary>
        void Next();
        /// <summary>
        /// Goto assign step, if step in pipe.
        /// </summary>
        void Goto(string _filterName);
        /// <summary>
        /// Set complete state, auto-goto pipe ending process.
        /// </summary>
        void Complete();
        /// <summary>
        /// Set error state, auto-goto pipe error process.
        /// </summary>
        void Error(string _message);
        #endregion

        #region Accessors
        /// <summary>
        /// [Read-Write] Piep setting, that is progress current control pipe.
        /// </summary>
        IPipe Pipe { get; set; }
        /// <summary>
        /// [Read-Only] Current routes index.
        /// </summary>
        int Index { get; }
        /// <summary>
        /// [Read-Only] Error message, when Error state happen.
        /// </summary>
        string ErrorMessage { get; }
        #endregion
    }
}
