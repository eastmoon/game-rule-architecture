/*
	Info:
        - Game Rule Architecture model object.
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

using GameRuleArchitecture.Core.Model.Interface;

namespace GameRuleArchitecture.Core.Model.Object
{
    public class RMObject : System.Object, IRMObject
    {
        #region Variable member
        private string mName;
        private IRMModule mModule;
        #endregion

        #region Constructor
        public RMObject(string _name = "", IRMModule _module = null)
        {
            this.RegisterInfo(_name, _module);
        }
        #endregion

        #region Public Method
        /**
     	 * <P>Set a name and <code>RMModule</code> who is this object register in.</p>
      	 */
        public void RegisterInfo(string _name = "", IRMModule _module = null)
        {
            this.Name = _name;
            this.Module = _module;
        }
        #endregion

        #region Accessors
        /**
         * <P>[Read-Only] Get the object name.</P>
         */
        public string Name {
            protected set
            {
                this.mName = value;
            }
            get
            {
                return this.mName;
            }
        }

        /**
         * <P>[Read-Only]Get <code>RMModule</code> who is this object register in.</P>
         */
        public IRMModule Module
        {
            protected set
            {
                this.mModule = value;
            }
            get
            {
                return this.mModule;
            }
        }
        #endregion
    }
}
