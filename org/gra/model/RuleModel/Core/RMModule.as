/*
 Game Rule Architure Demo - Flex Application Skeleton 
 Copyright (c) 2013 EastMoon<jacky_eastmoon@hotmail.com>
 Your reuse is governed by the Creative Commons Attribution 3.0 License

	Info:
		- RMActor, RMSpace, RMEvent object management.
		
	Useage:
		- FunctionName1 : function describe
		
	Date:
		- 2013.04.10
		
	Author:
		- Name : EastMoon
		- Email : jacky_eastmoon@hotmail.com
*/
package org.gra.model.RuleModel.Core
{	
	/*import：Flash內建元件庫*/
	/*external import：外部元件庫、開發人員自定元件庫*/
	import org.puremvc.as3.patterns.observer.Notification;
	import org.puremvc.as3.interfaces.IProxy;
	import org.gra.model.RuleModel.Interface.*;
	
	/**
     * <P>RMModule is a class who management RMEActor, RMSpace, RMEvent object store and execute.</P>
     */
	public class RMModule extends RMNotifyDispatcher implements IProxy, IRMModule
    {
        /**static const variable : 靜態常數變數*/
		/**const variable：常數變數*/
		/**function variable：函數變數*/
		/**member variable：物件內部操作變數*/
		private var m_events : Object;
		private var m_actors : Object;
		private var m_spaces : Object;
		/**display object variable：顯示物件變數，如MovieClip等*/
		
		/**constructor：建構值*/
        public function RMModule( a_name : String = "" ) : void
		{
			// 初始化
			this.m_actors = new Object();
			this.m_events = new Object();
			this.m_spaces = new Object();
			// 
			super( a_name );
        }
		/**public function：對外公開函數*/
		// 系統命令
		/**
     	 * <P>Initial all <code>RMSpace</code> in <code>RMModule</code>.</P>
      	 */
		public function Initial( a_params : Object = null ) : void
		{
			this.NotifyTo(RMNotify.INITIAL, this.m_spaces, "", a_params);
		}
		/**
     	 * <P>Initial a <code>RMActor</code> in <code>RMModule</code>.</P>
      	 */
		public function InitialActorByName( a_targetName : String, a_params : Object = null ) : void
		{
			this.NotifyTo(RMNotify.INITIAL, this.m_actors, a_targetName, a_params);
		}
		/**
     	 * <P>Initial a <code>RMSpace</code> in <code>RMModule</code>.</P>
      	 */
		public function InitialSpaceByName( a_targetName : String, a_params : Object = null ) : void
		{
			this.NotifyTo(RMNotify.INITIAL, this.m_spaces, a_targetName, a_params);
		}
		/**
     	 * <P>Update all <code>RMSpace</code> in <code>RMModule</code>.</P>
      	 */
		public function Update( a_params : Object = null, a_targetName : String = "" ) : void
		{
			if( a_params is RMNotification )
			{
				this.NotifyTo(RMNotify.UPDATE, this.m_spaces, a_targetName, (a_params as RMNotification).getBody());
			}
			else
			{
				this.NotifyTo(RMNotify.UPDATE, this.m_spaces, a_targetName, a_params);
			}
		}
		/**
     	 * <P>Draw all <code>RMSpace</code> in <code>RMModule</code>.</P>
      	 */
		public function Draw( a_params : Object = null, a_targetName : String = "" ) : void
		{
			this.NotifyTo(RMNotify.DRAW, this.m_spaces, a_targetName, a_params);
		}
		/**
     	 * <P>Enabled all <code>RMSpace</code> in <code>RMModule</code>.</P>
      	 */
		public function Enabled( a_isEnabled : Boolean = true, a_targetName : String = "" ) : void
		{
			if( a_targetName != "" )
			{
				if( this.m_spaces[a_targetName] != undefined && this.m_spaces[a_targetName] != null && this.m_spaces[a_targetName] is RMNotifyDispatcher )
					(this.m_spaces[a_targetName] as RMNotifyDispatcher).setEnabledNotify( a_isEnabled );
			}
			else
			{
				for( var tempName in this.m_spaces )
				{
					if( this.m_spaces[tempName] != undefined && this.m_spaces[tempName] != null && this.m_spaces[tempName] is RMNotifyDispatcher )
						(this.m_spaces[tempName] as RMNotifyDispatcher).setEnabledNotify( a_isEnabled );
				}
			}
		}
		// Actor管理
		/**
     	 * <P>Register <code>RMActor</code> in RMModule</P>
      	 */
		public function RegisterActor( a_name : String, a_actor : IRMActor ) : void
		{
			if( this.m_actors[a_name] == undefined )
			{
				this.m_actors[a_name] = a_actor;
				a_actor.RegisterInfo(a_name, this);
			}
		}
		/**
     	 * <P>Remove <code>RMActor</code> from RMModule</P>
      	 */
		public function RemoveActor( a_name : String ) : IRMActor
		{
			var temp : IRMActor = null;
			if( this.m_actors[a_name] != undefined )
			{
				temp = this.m_actors[a_name];
				this.m_actors[a_name] = undefined;
			}
			return temp;
		}
		/**
     	 * <P>Has <code>RMActor</code> in RMModule</P>
      	 */
		public function HasActor( a_name : String ) : Boolean
		{
			if( this.m_actors[a_name] != undefined )
				return true;
			return false;
		}
		/**
     	 * <P>Retrieve <code>RMActor</code> from RMModule</P>
      	 */
		public function RetrieveActor( a_name : String ) : IRMActor
		{
			if( this.m_actors[a_name] != undefined )
				return this.m_actors[a_name];
			return null;
		}
		// Space管理
		/**
     	 * <P>Register <code>RMSpace</code> in RMModule</P>
      	 */
		public function RegisterSpace( a_name : String, a_space : IRMSpace ) : void
		{
			if( this.m_spaces[a_name] == undefined )
			{
				this.m_spaces[a_name] = a_space;
				a_space.RegisterInfo(a_name, this);
			}
		}
		/**
     	 * <P>Remove <code>RMSpace</code> from RMModule</P>
      	 */
		public function RemoveSpace( a_name : String) : IRMSpace
		{
			var temp : IRMSpace = null;
			if( this.m_spaces[a_name] != undefined )
			{
				temp = this.m_spaces[a_name];
				this.m_spaces[a_name] = undefined;
			}
			return temp;
		}
		/**
     	 * <P>Has <code>RMSpace</code> in RMModule</P>
      	 */
		public function HasSpace( a_name : String) : Boolean
		{
			if( this.m_spaces[a_name] != undefined )
				return true;
			return false;
		}
		/**
     	 * <P>Retrieve <code>RMSpace</code> from RMModule</P>
      	 */
		public function RetrieveSpace( a_name : String) : IRMSpace
		{
			if( this.m_spaces[a_name] != undefined )
				return this.m_spaces[a_name];
			return null;
		}
		// Event管理
		/**
     	 * <P>Register <code>RMEvent</code> in RMModule</P>
      	 */
		public function RegisterEvent( a_name : String, a_event : IRMEvent ) : void
		{
			if( this.m_events[a_name] == undefined )
			{
				this.m_events[a_name] = a_event;
				a_event.RegisterInfo(a_name, this);
			}
		}
		/**
     	 * <P>Remove <code>RMEvent</code> from RMModule</P>
      	 */
		public function RemoveEvent( a_name : String) : IRMEvent
		{
			var temp : IRMEvent = null;
			if( this.m_events[a_name] != undefined )
			{
				temp = this.m_events[a_name];
				this.m_events[a_name] = undefined;
			}
			return temp;
		}
		/**
     	 * <P>Has <code>RMEvent</code> in RMModule</P>
      	 */
		public function HasEvent( a_name : String) : Boolean
		{
			if( this.m_events[a_name] != undefined )
				return true;
			return false;
		}
		/**
     	 * <P>Execute <code>RMEvent</code> from RMModule</P>
      	 */
		public function ExecuteEvent( a_vars : IRMEventVar ) : void
		{
			if( this.m_events[a_vars.getName()] != undefined )
				this.m_events[a_vars.getName()].Execute(a_vars);
		}
		/*
		* IProxy interface implement.
		*/
		/**
		 * Get the Proxy name
		 * 
		 * @return the Proxy instance name
		 */
		public function getProxyName() : String
		{
			return this.getName();
		}
		
		/**
		 * Set the data object
		 * 
		 * @param data the data object
		 */
		public function setData( data : Object ) : void
		{
			
		}
		
		/**
		 * Get the data object
		 * 
		 * @return the data as type Object
		 */
		public function getData() : Object
		{
			return null;
		}
		
		/**
		 * Called by the Model when the Proxy is registered
		 */ 
		public function onRegister( ) : void
		{
			
		}

		/**
		 * Called by the Model when the Proxy is removed
		 */ 
		public function onRemove( ) : void
		{
			
		}
		/**public get/set function：變數存取介面*/
		/**write only：唯寫*/
		/**read only：唯讀*/
		/**read/write：讀寫*/
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		/**
     	 * <P>Notify a SIGNAL to one or all <code>RMNotifyDispatcher</code> in target object</P>
      	 */
		protected function NotifyTo( a_notifyName : String, a_target : Object, a_targetName : String = "", a_params : Object = null) : void
		{
			
			if( a_targetName != "" )
			{
				if( a_target[a_targetName] != undefined && a_target[a_targetName] != null && a_target[a_targetName] is RMNotifyDispatcher )
					(a_target[a_targetName] as RMNotifyDispatcher).SendNotify(new RMNotification( a_notifyName, a_params ));
					
			}
			else
			{
				for( var tempName in a_target )
				{
					if( a_target[tempName] != undefined && a_target[tempName] != null && a_target[tempName] is RMNotifyDispatcher )
						(a_target[tempName] as RMNotifyDispatcher).SendNotify(new RMNotification( a_notifyName, a_params ));
				}
			}
		}
		/**javascript const variable：JavaScript 常數變數*/
    }
}