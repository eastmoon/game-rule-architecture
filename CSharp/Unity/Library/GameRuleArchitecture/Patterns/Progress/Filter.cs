/*
	Info:
        - Game Rule Architecture progress controller implement class.
        - Pipe and Filter is an architecture, that is use on step by step to execute, and Progress is a controller to control pipe execute state.
        - Filter is a object to execute algorithm.
		
	Date:
		- 2016.07.15
		
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

using PureMVC.Patterns;
using GameRuleArchitecture.Interfaces;

namespace GameRuleArchitecture.Patterns
{
    public class Filter : SimpleCommand, IFilter
    {
        #region Variable member
        private string mName;
        #endregion

        #region Constructor
        public Filter(string _name = "")
        {
            this.mName = _name;
        }
        #endregion

        #region Public Method
        /// <summary>
     	/// <P>Execute filter functional.</P>
        /// </summary>
        public virtual void Execute(IProgress _progress)
        {
        }
        #endregion

        #region Accessors
        /// <summary>
     	/// <P>[Read-Only] Get the filter name.</P>
        /// </summary>
        public string Name
        {
            get { return this.mName; }
        }
        #endregion 

    }
}
