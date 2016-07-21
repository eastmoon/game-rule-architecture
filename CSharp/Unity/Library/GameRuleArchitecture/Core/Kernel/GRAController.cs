/*
	Info:
        - Game Rule Architecture kernel.
        - GRACotroller inheritance PureMVC.Core.Controller.
        - Controller will register common command in application system.
		
	Date:
		- 2016.06.29
		
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

using PureMVC.Core;

namespace GameRuleArchitecture.Core.Kernel
{
    class GRAController : Controller
    {
        #region Accessors

        /**
        * Singleton GRAController Factory Method
        */
        public static GRAController getInstance()
        {
            if (m_instance == null)
            {
                lock (m_staticSyncRoot)
                {
                    if (m_instance == null)
                        m_instance = new GRAController();
                }
            }
            return m_instance as GRAController;
        }

        #endregion

        #region Protected & Internal Methods
        /**
		 * Initialize the Singleton Constroller instance.
		 * 
		 * <P>
		 * Called automatically by the constructor, this
		 * is your opportunity to initialize the Singleton
		 * instance in your subclass without overriding the
		 * constructor.</P>
		 * 
		 * @return void
		 */
        protected override void InitializeController()
        {
            // Setting System Command       
            base.InitializeController();

            // initial variable
        }

        #endregion
}
}
