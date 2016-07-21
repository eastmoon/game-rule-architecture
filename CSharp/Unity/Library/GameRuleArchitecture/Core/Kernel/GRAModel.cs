/*
	Info:
        - Game Rule Architecture kernel.
        - GRAModel inheritance PureMVC.Core.Model.
        - Model will register module and setting relationship.
		
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
    class GRAModel : Model
    {
        #region Accessors

        /**
        * Singleton GRAModel Factory Method
        */
        public static GRAModel getInstance()
        {
            if (m_instance == null)
            {
                lock (m_staticSyncRoot)
                {
                    if (m_instance == null)
                        m_instance = new GRAModel();
                }
            }
            return m_instance as GRAModel;
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
        protected override void InitializeModel()
        {
            // Setting System Command       
            base.InitializeModel();

            // initial variable
        }

        #endregion
    }
}
