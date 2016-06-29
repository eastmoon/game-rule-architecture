/*
 PureMVC AS3 Demo - Flex Application Skeleton 
 Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.gra.core
{
    import org.puremvc.as3.core.Controller;
    import org.gra.controller.*;
	import org.gra.controller.WSProgressFlow.WSProgressFlow;

    /**
     * Create and register <code>Proxy</code>s with the <code>Model</code>.
     */
    public class GRAController extends Controller
    {				
        public static function getInstance() : GRAController 
		{
            if ( instance == null ) 
				instance = new GRAController();
            return instance as GRAController;
        }
		
		public function GRAController() : void
		{
			// Setting System Command
			this.registerCommand( WSProgressFlow.EVENT_PROGRESS_FLOW, WSProgressFlow );
		}
		
		/**
		 * Static Facade public functional
		 */
		/*
		// Command
		public static function RegisterCommand( notificationName:String, commandClassRef:Class ):void 
		{ ApplicationFacade.getInstance().registerCommand(notificationName, commandClassRef); };
		
		public static function RemoveCommand( notificationName:String ):void 
		{ ApplicationFacade.getInstance().removeCommand(notificationName); };

		public static function HasCommand( notificationName:String ) : Boolean
		{ return ApplicationFacade.getInstance().hasCommand(notificationName); };
		*/
    }
}