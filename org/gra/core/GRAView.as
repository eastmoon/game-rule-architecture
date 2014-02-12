/*
 PureMVC AS3 Demo - Flex Application Skeleton 
 Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.gra.core
{
	import org.puremvc.as3.core.View;
	import org.gra.view.WindowSection.Interface.IWindow;
	import org.gra.view.WindowSection.Interface.ISection;
	import org.gra.ApplicationFacade;

    /**
     * Create and register <code>Proxy</code>s with the <code>Model</code>.
     */
    public class GRAView extends View
    {
		//
		protected var m_windowMap : Object;
		
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
		protected override function initializeView(  ) : void 
		{
			// initial parent view
			super.initializeView();
			
			// initial variable
			this.m_windowMap = new Object();
		}
		/**
		 * GRAView Singleton Factory method.
		 * 
		 * @return the Singleton instance of <code>GRAView</code>
		 */ 
        public static function getInstance() : GRAView 
		{
            if ( instance == null ) 
				instance = new GRAView();
            return instance as GRAView;
        }
		
		// Window manage functional
		/**
		 * Register an <code>IWindow</code> instance with the <code>GRAView</code>.
		 * 
		 * <P>
		 * Registers the <code>IWindow</code> so that it can be retrieved by name.
		 * 
		 * @param window a reference to the <code>IWindow</code> instance
		 */
		public function registerWindow( a_window : IWindow ) : void
		{
			// do not allow re-registration (you must to removeMediator fist)
			if ( this.m_windowMap[ a_window.getName() ] != null ) return;
			
			// Register the window for retrieval by name
			this.m_windowMap[ a_window.getName() ] = a_window;
						
			// alert the window that it has been registered
			a_window.onRegister();
		}

		/**
		 * Retrieve an <code>IWindow</code> from the <code>GRAView</code>.
		 * 
		 * @param windowName the name of the <code>IWindow</code> instance to retrieve.
		 * @return the <code>IWindow</code> instance previously registered with the given <code>windowName</code>.
		 */
		public function retrieveWindow( a_windowName:String ) : IWindow
		{
			return this.m_windowMap[ a_windowName ];
		}

		/**
		 * Remove an <code>IWindow</code> from the <code>GRAView</code>.
		 * 
		 * @param windowName name of the <code>IWindow</code> instance to be removed.
		 * @return the <code>IWindow</code> that was removed from the <code>GRAView</code>
		 */
		public function removeWindow( a_windowName:String ) : IWindow
		{
			// Retrieve the named window
			var window:IWindow = this.m_windowMap[ a_windowName ] as IWindow;
			
			if ( window != null ) 
			{
				// remove the window from the map		
				delete this.m_windowMap[ a_windowName ];
	
				// alert the window that it has been removed
				window.onRemove();
			}
			
			return window;
		}
		
		/**
		 * Check if a Window is registered or not
		 * 
		 * @param windowName
		 * @return whether a Window is registered with the given <code>windowName</code>.
		 */
		public function hasWindow( a_windowName:String ) : Boolean
		{
			return this.m_windowMap[ a_windowName ] != null;
		}
		
		// Section manage functional
		/**
		 * Register an <code>ISection</code> instance with the <code>GRAView</code>.
		 * 
		 * <P>
		 * Call Mediator functional from View, but need check it isn't Mediator.
		 * 
		 * @param window a reference to the <code>ISection</code> instance
		 */
		public function registerSection( a_section : ISection ) : void
		{
			this.registerMediator( a_section );
		}

		/**
		 * Retrieve an <code>ISection</code> from the <code>GRAView</code>.
		 * 
		 * @param sectionName the name of the <code>ISection</code> instance to retrieve.
		 * @return the <code>ISection</code> instance previously registered with the given <code>sectionName</code>.
		 */
		public function retrieveSection( a_sectionName:String ) : ISection
		{
			return this.retrieveMediator( a_sectionName ) as ISection;
		}

		/**
		 * Remove an <code>ISection</code> from the <code>GRAView</code>.
		 *
		 * PS. use remove mediator function can remove section, but use remove section function can't remove mediator.
		 *
		 * @param sectionName name of the <code>ISection</code> instance to be removed.
		 * @return the <code>ISection</code> that was removed from the <code>GRAView</code>
		 */
		public function removeSection( a_sectionName:String ) : ISection
		{
			if( this.hasSection( a_sectionName ) )
				return this.removeMediator( a_sectionName ) as ISection;
			return null;
		}
		
		/**
		 * Check if a Section is registered or not
		 * 
		 * @param sectionName
		 * @return whether a Section is registered with the given <code>sectionName</code>.
		 */
		public function hasSection( a_sectionName:String ) : Boolean
		{
			if( this.retrieveSection( a_sectionName ) != null && this.hasMediator( a_sectionName ) )
				return true;
			return false;
		}
		
		/**
		 * Static Facade public functional
		 */
		/*
		// Mediator
		public static function RegisterMediator( mediator:IMediator ):void 
		{ ApplicationFacade.getInstance().registerMediator(mediator); };
		
		public static function RetrieveMediator( mediatorName:String ):IMediator 
		{ return ApplicationFacade.getInstance().retrieveMediator(mediatorName); };
		
		public static function RemoveMediator( mediatorName:String ) : IMediator 
		{ return ApplicationFacade.getInstance().removeMediator(mediatorName); };
		
		public static function HasMediator( mediatorName:String ) : Boolean
		{ return ApplicationFacade.getInstance().hasMediator(mediatorName); };
		*/
    }
}