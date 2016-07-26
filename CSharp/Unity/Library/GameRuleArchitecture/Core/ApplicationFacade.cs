/*
	Info:
		- Game Rule Architecture, application facade.
        - Use it to start application and access object in framework.

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

using PureMVC.Patterns;
using GameRuleArchitecture.Core;

namespace GameRuleArchitecture
{
    public class ApplicationFacade : Facade
    {

        #region Accessors

        /**
        * Singleton ApplicationFacade Factory Method
        */
        public static ApplicationFacade getInstance()
        {

            if (m_instance == null)
            {
                lock (m_staticSyncRoot)
                {
                    if (m_instance == null)
                        m_instance = new ApplicationFacade();
                }
            }
            return m_instance as ApplicationFacade;
        }

        #endregion

        #region Notification
        // Notification name constants
        public const String EVENT_STARTUP = "startup";

        /**
		 * Start the Application
		 */
        public void Startup(System.Object _app)
        {
            this.SendNotification(EVENT_STARTUP, _app);
        }

        #endregion

        #region Protected & Internal Methods
        /**
         * Register Commands with the Controller 
         */
        protected override void InitializeFacade()
        {
            // Can't use super.initializeFacade().
            // Because, the controller will creater view.
            // Change the process
            this.InitializeModel();
			this.InitializeView();
			this.InitializeController();
        }

        /**
         * Register Commands with the Controller 
         */
        protected override void InitializeController()
        {
            // Initial GRAController 
            if ( this.m_controller != null ) return;
			this.m_controller = GRAController.getInstance();
        }

        /**
         * Register Proxy with the Model 
         */
        protected override void InitializeModel()
        {
            // Initial GRAModel 
            if ( this.m_model != null ) return;
            this.m_model = GRAModel.getInstance();
            
            // Setting System Proxy
        }

        /**
         * Register Mediator with the View 
         */
        protected override void InitializeView()
        {
            // Initial GRAView 
            if ( this.m_view != null ) return;
			this.m_view = GRAView.getInstance();

            // Setting System Mediator
        }
        #endregion

        #region Wimdow

        #endregion

        #region Section

        #endregion

        #region Module

        #endregion
    }
}
