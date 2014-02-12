/*
 PureMVC AS3 Demo - Flex Application Skeleton 
 Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.gra
{
	// import flash library
	import flash.display.DisplayObject;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	
	// import PureMVC library
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.proxy.*;
    import org.puremvc.as3.patterns.facade.*;
	import org.puremvc.as3.patterns.observer.Notification;
	import org.puremvc.as3.core.Model;

	// import Game Rule Architecture library
	import org.gra.core.*;
	import org.gra.view.WindowSection.Interface.*;
	import org.gra.model.RuleModel.Interface.IRMNotifyDispatcher;
	import org.gra.model.RuleModel.Core.RMNotify;
	import org.gra.model.RuleModel.Core.RMNotification;
	import org.gra.model.RuleModel.Core.RMModule;
	

    /**
     * A concrete <code>Facade</code> for the <code>ApplicationSkeleton</code> application.
     * <P>
     * The main job of the <code>ApplicationFacade</code> is to act as a single 
     * place for mediators, proxies and commands to access and communicate
     * with each other without having to interact with the Model, View, and
     * Controller classes directly. All this capability it inherits from 
     * the PureMVC Facade class.</P>
     * 
     * <P>
     * This concrete Facade subclass is also a central place to define 
     * notification constants which will be shared among commands, proxies and
     * mediators, as well as initializing the controller with Command to 
     * Notification mappings.</P>
     */
    public class ApplicationFacade extends Facade
    {
        // Notification name constants
		// application
        public static const EVENT_STARTUP : String 					= "startup";
		
        /**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance() : ApplicationFacade 
		{
			
            if ( instance == null ) 
				instance = new ApplicationFacade( );
            return instance as ApplicationFacade;
        }
		
		/**
		 * Static Facade public functional
		 */
		
		// Notification
		public static function SendNotification( notificationName:String, body:Object=null, type:String=null ):void 
		{ return ApplicationFacade.getInstance().sendNotification(notificationName, body, type); };
		
		public static function NotifyObservers ( notification:INotification ):void 
		{ return ApplicationFacade.getInstance().notifyObservers(notification); };
		
 		/**
         * Register Commands with the Controller 
         */
        override protected function initializeFacade( ) : void 
        {
			//trace("Initial System Facade Class");
            //super.initializeFacade(); 
			// Can't use super.
			// Because, the controller will creater view.
			// Change the process
			
			this.initializeModel();
			this.initializeView();
			this.initializeController();
			
			// Initial timer
			this.m_fps = -1;
			this.m_timerQueueForWindow = new Array();
			this.m_timerQueueForRuleModel = new Array();
			this.setFPS( 0 );
        }
		
        /**
         * Register Commands with the Controller 
         */
        override protected function initializeController( ) : void 
        {
			trace("Initial System Command Class");
			
			// Initial GRAController 
			if( this.controller != null ) return;
			this.controller = GRAController.getInstance();
        }
		
		/**
         * Register Proxy with the Model 
         */
        override protected function initializeModel( ) : void 
        {
			trace("Initial System Proxy Class");
			
			// Initial GRAModel 
			if( this.model != null ) return;
			this.model = GRAModel.getInstance();
			
			// Setting System Proxy
        }

		/**
         * Register Mediator with the View 
         */
        override protected function initializeView( ) : void 
        {
			trace("Initial System Mediator Class");
			
			// Initial GRAView 
			if( this.view != null ) return;
			this.view = GRAView.getInstance();
			
			// Setting System Mediator
        }

		/**
		 * Start the application
		 */
		public static function Startup( a_app : DisplayObject) : void { ApplicationFacade.getInstance().Startup( a_app ); };
		private function Startup( a_app : DisplayObject ):void
		{
			sendNotification( EVENT_STARTUP, a_app );
		}
		
		/*
		 * Application timer 
		 */
		private var m_timer : int;
		private var m_fps : Number;
		private var m_timerQueueForWindow : Array;
		private var m_timerQueueForRuleModel : Array;
		public static function setFPS( a_fps : Number ) : void { ApplicationFacade.getInstance().setFPS( a_fps ); };
		private function setFPS( a_fps : Number ) : void
		{
			// FPS 不可小於 0 或大於 100
			if( a_fps < 0 )
				a_fps = 0;
			if( a_fps > 100 )
				a_fps = 100;
			
			if( this.m_fps != a_fps )
			{
				// store fps variable
				this.m_fps = a_fps;
				// clear interval
				clearInterval( this.m_timer );
				// start interval
				if( this.m_fps > 0 )
					this.m_timer = setInterval( this.onEnterInterval, Math.floor( 1000 / this.m_fps ) );					
			}
			
		}
		
		private function onEnterInterval() : void
		{
			var i : Number = 0;
			// Execute Model
			var tempRuleModel : IRMNotifyDispatcher = null;
			for( i = 0 ; i < this.m_timerQueueForRuleModel.length ; i++ )
			{
				tempRuleModel = this.m_timerQueueForRuleModel[i] as IRMNotifyDispatcher;
				if( tempRuleModel != null )
				{
					tempRuleModel.SendNotify( new RMNotification( RMNotify.UPDATE ) );
				}
			}
			// Execute Window
			var tempWindow : IWindow = null;
			for( i = 0 ; i < this.m_timerQueueForWindow.length ; i++ )
			{
				tempWindow = this.m_timerQueueForWindow[i] as IWindow;
				if( tempWindow != null )
				{
					tempWindow.onEnterFrame();
				}
			}
		}
		
		public function registerTimerToWindowView( a_window : IWindow ) : void
		{
			if( this.m_timerQueueForWindow != null && a_window != null )
			{
				//skip any dupilcates
				var isDuplicate : Boolean = false;
				
				var i : Number = 0;
				for( i = 0 ; i < this.m_timerQueueForWindow.length ; i++ )
				{
					if( ( this.m_timerQueueForWindow[i] as IWindow ) == a_window )
						isDuplicate = true;
				}
				
				//register
				if( !isDuplicate )
				{
					this.m_timerQueueForWindow.push( a_window );
				}
			}
		}
		
		public function removeTimerToWindowView( a_window : IWindow ) : void
		{
			var i : Number = 0;
			for( i = 0 ; i < this.m_timerQueueForWindow.length ; i++ )
			{
				if( ( this.m_timerQueueForWindow[i] as IWindow ) == a_window )
				{
					// clear store
					this.m_timerQueueForWindow.splice(i, 1);
				}
			}
		}
		
		public function registerTimerToRuleModel( a_dispatcher : IRMNotifyDispatcher ) : void
		{
			if( this.m_timerQueueForRuleModel != null && a_dispatcher != null )
			{
				//skip any dupilcates
				var isDuplicate : Boolean = false;
				
				var i : Number = 0;
				for( i = 0 ; i < this.m_timerQueueForRuleModel.length ; i++ )
				{
					if( ( this.m_timerQueueForRuleModel[i] as IRMNotifyDispatcher ) == a_dispatcher )
						isDuplicate = true;
				}
				
				//register
				if( !isDuplicate )
				{
					this.m_timerQueueForRuleModel.push( a_dispatcher );
				}
			}
		}
		public function removeTimerToRuleModel( a_dispatcher : IRMNotifyDispatcher ) : void
		{
			var i : Number = 0;
			for( i = 0 ; i < this.m_timerQueueForRuleModel.length ; i++ )
			{
				if( ( this.m_timerQueueForRuleModel[i] as IRMNotifyDispatcher ) == a_dispatcher )
				{
					// clear store
					this.m_timerQueueForRuleModel.splice(i, 1);
				}
			}
		}
		
		/**
		 * Facade window function
		 */
		public function registerWindow( a_window : IWindow ) : void
		{
			// register the window to application timer
			this.registerTimerToWindowView( a_window );
			// register the window to GRAView
			(this.view as GRAView).registerWindow( a_window );
		}

		public function retrieveWindow( windowName:String ) : IWindow
		{
			return (this.view as GRAView).retrieveWindow( windowName );
		}

		public function removeWindow( windowName:String ) : IWindow
		{
			// remove and retrieve the window
			var temp : IWindow = (this.view as GRAView).removeWindow( windowName );
			
			// if have retrieve than remove window from application timer
			if( temp != null )
				this.removeTimerToWindowView( temp );
				
			// return retrieve window
			return temp 
		}
		
		public function hasWindow( windowName:String ) : Boolean
		{
			return (this.view as GRAView).hasWindow( windowName );
		}
		
		/**
		 * Facade section function
		 */
		public function registerSection( a_section : ISection ) : void
		{
			(this.view as GRAView).registerSection( a_section );
		}

		public function retrieveSection( sectionName:String ) : ISection
		{
			return (this.view as GRAView).retrieveSection( sectionName );
		}

		public function removeSection( sectionName:String ) : ISection
		{
			return (this.view as GRAView).removeSection( sectionName );
		}
		
		public function hasSection( sectionName:String ) : Boolean
		{
			return (this.view as GRAView).hasSection( sectionName );
		}
		
		/**
		 * Facade module function
		 */
		public function registerModule( a_module : RMModule ) : void
		{
			// register the module to application timer
			this.registerTimerToRuleModel( a_module );
			// add notify to module
			a_module.AddNotify( RMNotify.UPDATE, a_module.Update ); 
			// register the module to GRAModel
			(this.model as GRAModel).registerModule( a_module );
		}

		public function retrieveModule( moduleName:String ) : RMModule
		{
			return (this.model as GRAModel).retrieveModule( moduleName );
		}

		public function removeModule( moduleName:String ) : RMModule
		{
			// remove and retrieve the module
			var temp : RMModule = (this.model as GRAModel).removeModule( moduleName );
			
			// if have retrieve than remove module from application timer
			if( temp != null )
			{
				// remove from application timer
				this.removeTimerToRuleModel( temp ); 
				// remove notify
				temp.RemoveNotify( RMNotify.UPDATE, temp.Update );
			}
			// return retrieve module
			return temp 
		}
		
		public function hasModule( moduleName:String ) : Boolean
		{
			return (this.model as GRAModel).hasModule( moduleName );
		}
    }
}