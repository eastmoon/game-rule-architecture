/*
 PureMVC AS3 Demo - Flex Application Skeleton 
 Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package org.gra.core
{
	import org.puremvc.as3.core.Model;
	import org.gra.model.RuleModel.Interface.IRMModule;
	import org.gra.model.RuleModel.Core.RMModule;
	import org.puremvc.as3.interfaces.IProxy;

    /**
     * Create and register <code>Proxy</code>s with the <code>Model</code>.
     */
    public class GRAModel extends Model
    {
        public static function getInstance() : GRAModel 
		{
            if ( instance == null ) 
				instance = new GRAModel();
            return instance as GRAModel;
        }
		
		// RMModule manage functional
		/**
		 * Register an <code>IRMModule</code> instance with the <code>GRAModel</code>.
		 * Input module must implements IRMModule and IProxy.
		 * 
		 * <P>
		 * Call Proxy functional from Model, but need check it isn't Proxy.
		 * 
		 * @param module a reference to the <code>RMModule</code> instance
		 */
		public function registerModule( a_module : IRMModule ) : void
		{
			this.registerProxy( a_module as IProxy );
		}

		/**
		 * Retrieve an <code>IRMModule</code> from the <code>GRAModel</code>.
		 * 
		 * @param moduleName the name of the <code>RMModule</code> instance to retrieve.
		 * @return the <code>RMModule</code> instance previously registered with the given <code>moduleName</code>.
		 */
		public function retrieveModule( a_moduleName:String ) : IRMModule
		{
			return this.retrieveProxy( a_moduleName ) as IRMModule;
		}
		
		/**
		 * Retrieve all <code>IRMModule</code> name registry in <code>GRAModel</code>.
		 * 
		 * @return the name list.
		 */
		public function retrieveNameRegistryOfModule() : Array
		{
			var registry : Array = new Array();
			var target : IRMModule = null;
			var nameString : String = "";
			
			for( nameString in this.proxyMap )
			{
				target = this.proxyMap[ nameString ] as IRMModule;
				if( target != null )
					registry.push( target.getName() );
			}
			
			return registry;
		}
		
		/**
		 * Remove an <code>IRMModule</code> from the <code>GRAModel</code>.
		 *
		 * PS. use remove proxy function can remove module, but use remove module function can't remove proxy.
		 *
		 * @param moduleName the name of the <code>IRMModule</code> instance to retrieve.
		 * @return the <code>IRMModule</code> that was removed from the <code>GRAModel</code>
		 */
		public function removeModule( a_moduleName:String ) : IRMModule
		{
			if( this.hasModule( a_moduleName ) )
				return this.removeProxy( a_moduleName ) as IRMModule;
			return null;
		}
		
		/**
		 * Check if a module is registered or not
		 * 
		 * @param moduleName
		 * @return whether a module is registered with the given <code>moduleName</code>.
		 */
		public function hasModule( a_moduleName:String ) : Boolean
		{
			if( this.retrieveModule( a_moduleName ) != null && this.hasProxy( a_moduleName ) )
				return true;
			return false;
		}
		/**
		 * Static Facade public functional
		 */
		/*
		// Proxy
		public static function RegisterProxy ( proxy:IProxy ):void	
		{ ApplicationFacade.getInstance().registerProxy(proxy); };
				
		public static function RetrieveProxy ( proxyName:String ):IProxy 
		{ return ApplicationFacade.getInstance().retrieveProxy(proxyName); };

		public static function RemoveProxy ( proxyName:String ):IProxy 
		{ return ApplicationFacade.getInstance().removeProxy(proxyName); };

		public static function HasProxy( proxyName:String ) : Boolean
		{ return ApplicationFacade.getInstance().hasProxy(proxyName); };
		*/
    }
}