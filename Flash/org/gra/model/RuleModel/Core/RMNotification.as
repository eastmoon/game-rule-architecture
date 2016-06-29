/*
	Info:
		- Game Rule Architecture kernel code.
		
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
	import org.puremvc.as3.patterns.observer.Notification;
	 
    /**
     * <P>broadcast nofity to all observers with custom functions.</P>
     */
	public class RMNotification extends Notification implements IRMNotification
	{
		/**static const variable : 靜態常數變數*/
		/**const variable：常數變數*/
		/**function variable：函數變數*/
		/**member variable：物件內部操作變數*/
		private var m_notifier : IRMNotifyDispatcher;
		/**constructor：建構值*/
		public function RMNotification( a_name : String, a_body : Object = null , a_notifier : IRMNotifyDispatcher = null )
		{
			// 執行父物件建構元
			super( a_name, a_body );
			// 儲存來源目標
			this.m_notifier = a_notifier;
		}
		
		/**public function：對外公開函數*/
		
		/**
		 * Get the string representation of the <code>RMNotification</code> instance.
		 * 
		 * @return the string representation of the <code>RMNotification</code> instance.
		 */
		public override function toString():String
		{
			var msg:String = "Notification Name: "+this.getName();
			msg += "\nBody:"+(( this.getBody() == null )?"null":this.getBody().toString());
			msg += "\nType:"+(( this.getType() == null )?"null":this.getType());
			msg += "\nFrom:"+(( this.m_notifier == null )?"null":this.m_notifier);
			return msg;
		}
		/**read/write：讀寫*/
		/**
		 * Set notifier who send the <code>RMNotification</code> instance.
		 */
		public function setNotifier( a_notifier : IRMNotifyDispatcher ):void
		{
			this.m_notifier = a_notifier;
		}
		/**
		 * Get notifier who send the <code>RMNotification</code> instance.
		 * 
		 * @return the notifier object. 
		 */
		public function getNotifier() : IRMNotifyDispatcher
		{
			return this.m_notifier;
		}
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		/**javascript const variable：JavaScript 常數變數*/
	}
}