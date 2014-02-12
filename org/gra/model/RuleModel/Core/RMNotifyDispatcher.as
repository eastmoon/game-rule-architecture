/*
	Info:
		- Game Rule Architecture kernel code.
		- The event dispatcher in Rule Model.
		
	Date:
		- 2013.08.29
		
	Author:
		- Name : Jacky Chen 
		- Nickname : EastMoon
		- Email : jacky_eastmoon@hotmail.com
		
 	Copyright (c) 2013 Jacky Chen
 	Your reuse is governed by the Creative Commons Attribution 3.0 License
*/

package org.gra.model.RuleModel.Core
{	
	/*import：Flash內建元件庫*/
	/*external import：外部元件庫、開發人員自定元件庫*/
	import org.gra.model.RuleModel.Interface.*;
	import org.gra.model.RuleModel.Pattern.Observer.ObserverManager;

    /**
     * <P>The event dispatcher in Rule Model.</P>
     */
    public class RMNotifyDispatcher extends RMObject implements IRMNotifyDispatcher
    {
        /**static const variable : 靜態常數變數*/
		/**const variable：常數變數*/
		/**function variable：函數變數*/
		/**member variable：物件內部操作變數*/
		private var m_isEnabled : Boolean;
		private var m_observers : Object;
		private var m_module : IRMModule;
		private var m_name : String;
		/**display object variable：顯示物件變數，如MovieClip等*/
		
		/**constructor：建構值*/
        public function RMNotifyDispatcher( a_name : String = "" )
		{
            //trace("RMEventDispatcher");
			// Initial variable
			this.m_isEnabled = true;
			this.m_observers = new Object();
			this.RegisterInfo( a_name );
			// Initial notify
			this.AddNotify(RMNotify.ENABLED, this.onNotifyEnabled, this);
        }
		
		/**public function：對外公開函數*/
		/**
     	 * <P>Add Notify in RMNotifyDispatcher.</P>
      	 */
		public function AddNotify( a_notifyName : String, a_function : Function, a_context : Object = null ) : void
		{
			// check notify name is exist or not
			if( this.m_observers[a_notifyName] == undefined )
				this.m_observers[a_notifyName] = new ObserverManager( a_notifyName );
			
			// if has context, use it. if not, use this.
			if( a_context != null )
				(this.m_observers[a_notifyName] as ObserverManager).AddSubscriber( a_function, a_context );
			else
				(this.m_observers[a_notifyName] as ObserverManager).AddSubscriber( a_function, this );
		}
		/**
     	 * <P>Retrieve a <code>RMSpace</code> that this <code>RMActor</code> addation.</p>
      	 */
		/**
     	 * <P>Add Notify that send by some notifier in RMNotifyDispatcher.</P>
      	 */
		public function AddNotifyByNotifier( a_notifierName : String, a_notifyName : String, a_function : Function, a_context : Object = null ) : void
		{
			var notifyName : String = String( a_notifyName + "_" + a_notifierName );
			// add a notify by NotifyName + SpaceName
			this.AddNotify( notifyName , a_function, a_context );
				
			// add dispatcher function that is work with notify
			this.AddNotify( a_notifyName, this.onNotifyByNotifier );
		}
		
		/**
     	 * <P>Remove Notify in RMNotifyDispatcher.</P>
      	 */
		public function RemoveNotify( a_notifyName : String, a_function : Function ) : void
		{
			if( this.m_observers[a_notifyName] != undefined )
				(this.m_observers[a_notifyName] as ObserverManager).RemoveSubscriber( a_function );
		}
		
		/**
     	 * <P>Has Notify in RMNotifyDispatcher.</P>
      	 */
		public function HasNofity( a_notifyName : String ) : Boolean
		{
			
			var hasNotify : Boolean = (this.m_observers[a_notifyName] != undefined);
			// if exist notify name, then check observer amount is big than 0.
			if( hasNotify )
				hasNotify = ((this.m_observers[a_notifyName] as ObserverManager).getLength() > 0)
			return hasNotify;
		}
		
		/**
     	 * <P>Send Notify in RMNotifyDispatcher.</P>
      	 */
		public function SendNotify( a_notification : IRMNotification = null) : void
		{
			// 若已經存在發送者，忽略此動作；若無，則儲存本身為發送者
			if( a_notification.getNotifier() == null )
				a_notification.setNotifier( this );
			// 若無存在型別，儲存名稱為事件型別
			if( a_notification.getType() == null )
				a_notification.setType( a_notification.getName() );
			// 若無禁制功能且存在發送對向，傳送通告。
			if( this.m_isEnabled && this.m_observers[a_notification.getName()] != undefined )
			{
				(this.m_observers[a_notification.getName()] as ObserverManager).Notify(a_notification);
			}
		}
		
		/**
     	 * <P>Set a name and <code>RMModule</code> who is this object register in.</p>
      	 */
		public function RegisterInfo( a_name : String = "" , a_module : IRMModule = null) : void
		{
			this.m_name = a_name;
			this.m_module = a_module;
		}
		
		/**public get/set function：變數存取介面*/
		/**write only：唯寫*/
		/**read only：唯讀*/
		/**
     	 * <P>[Read-Only]Get the object name.</P>
      	 */
		public function getName() : String
		{
			return this.m_name;
		}
		/**
     	 * <P>[Read-Only]Get <code>RMModule</code> who is this object register in.</P>
      	 */
		public function getModule() : IRMModule
		{
			return this.m_module;
		}
		/**read/write：讀寫*/
		/**
     	 * <P>[Read-Write]get <code>RMNotifyDispatcher</code> notify Enabled or Disabled state.</P>
      	 */
		public function setEnabledNotify( a_isEnabled : Boolean ) : void
		{
			// 訊號已經鎖定，先行解開在發送訊息
			if( a_isEnabled )
				this.m_isEnabled = a_isEnabled;
				
			// 使用訊號發送，即使鎖定內容，仍就可發送一次Enabled Notify
			this.SendNotify( new RMNotification( RMNotify.ENABLED, {isEnabled:a_isEnabled} ));
		} 
		public function getEnabledNotify() : Boolean
		{
			return this.m_isEnabled;
		}
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		private function onNotifyEnabled( a_notify : IRMNotification ) : void
		{
			var isEnabled : Boolean = this.m_isEnabled;
			
			// 取回資訊
			if( a_notify.getBody() != null && a_notify.getBody().isEnabled != undefined )
				isEnabled = a_notify.getBody().isEnabled;
				
			// 更換資訊
			if( this.m_isEnabled != isEnabled )
				this.m_isEnabled = isEnabled;
		}
		private function onNotifyByNotifier( a_notify : IRMNotification ) : void
		{
			var notifier : IRMNotifyDispatcher = a_notify.getNotifier();
			// 確認發送者為Space
			if( notifier != null )
			{
				var notifyName : String = String( a_notify.getName() + "_" + notifier.getName() );
				if( this.HasNofity( notifyName ) )
				{
					var notification : IRMNotification = new RMNotification( notifyName, a_notify.getBody(), a_notify.getNotifier() );
					notification.setType( a_notify.getName() );
					this.SendNotify( notification );
				}
			}
		}
		
		/**javascript const variable：JavaScript 常數變數*/
    }
}