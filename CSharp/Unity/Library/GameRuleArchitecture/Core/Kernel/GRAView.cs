/*
	Info:
        - Game Rule Architecture kernel.
        - GRAView inheritance PureMVC.Core.View.
        - View will register window and section, that is help for display system.
		
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

namespace GameRuleArchitecture.Core
{
    public class GRAView : PureMVC.Core.View
    {
        #region Accessors

        /**
        * Singleton GRAView Factory Method
        */
        public static GRAView getInstance()
        {
            if (m_instance == null)
            {
                lock (m_staticSyncRoot)
                {
                    if (m_instance == null)
                        m_instance = new GRAView();
                }
            }
            return m_instance as GRAView;
        }

        #endregion

        #region Protected & Internal Methods
        /**
		 * Initialize the Singleton View instance.
		 * 
		 * <P>
		 * Called automatically by the constructor, this
		 * is your opportunity to initialize the Singleton
		 * instance in your subclass without overriding the
		 * constructor.</P>
		 * 
		 * @return void
		 */
        protected override void InitializeView()
        {
            // initial parent view
            base.InitializeView();

            // initial variable
        }
        
        #endregion
    }
}
