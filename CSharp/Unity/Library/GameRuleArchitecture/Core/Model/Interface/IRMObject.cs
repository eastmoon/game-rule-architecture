/*
	Info:
        - Game Rule Architecture model object interface.
        - RMObject is the base object in Rule Model.
		
	Date:
		- 2016.07.05
		
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

namespace GameRuleArchitecture.Interfaces
{
    public interface IRMObject
    {
        #region Public Method
        /**
     	 * <P>Set a name and <code>RMModule</code> who is this object register in.</p>
      	 */
        void RegisterInfo(string _name = "", IRMModule _module = null);
        #endregion

        #region Accessors
        /**
         * <P>[Read-Only] Get the object name.</P>
         */
        string Name { get; }

        /**
         * <P>[Read-Only]Get <code>RMModule</code> who is this object register in.</P>
         */
        IRMModule Module { get; }
        #endregion
    }
}
