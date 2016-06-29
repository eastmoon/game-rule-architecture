/*
	Info:
		- Game Rule Architecture kernel code.
		- broadcast nofity to all observers with custom functions
		- ref : http://en.wikipedia.org/wiki/Observer_pattern
	
	Usage:
		- AddSubscriber : Add subscriber and check it is not duplicate.
		- RemoveSubscriber : Remove subscriber , if input class exist in observers.
		- Notify : Execute subscriber function .
		
	Date:
		- 2013.08.29

	Author:
		- Name : Jacky Chen 
		- Nickname : EastMoon
		- Email : jacky_eastmoon@hotmail.com
		
 	Copyright (c) 2013 Jacky Chen
 	Your reuse is governed by the Creative Commons Attribution 3.0 License
*/

package org.gra.model.RuleModel.Pattern.Observer
{
	/*import：Flash內建元件庫*/
	/*external import：外部元件庫、開發人員自定元件庫*/
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.observer.Observer;
	 
    /**
     * <P>broadcast nofity to all observers with custom functions.</P>
     */
	public class ObserverManager
	{
		/**static const variable : 靜態常數變數*/
		/**const variable：常數變數*/
		/**function variable：函數變數*/
		/**member variable：物件內部操作變數*/
		private var m_name : String;
		private var m_subscribers : Array;
		
		/**constructor：建構值*/
		public function ObserverManager( a_name : String )
		{
			this.m_name = a_name;
			this.m_subscribers = new Array();
		}
		
		/**public function：對外公開函數*/
		/**
     	 * <P>Add Subscriber in Observer</P>
      	 */
		public function AddSubscriber( a_function : Function, a_context : Object ) : Boolean
		{
			//skip any dupilcates
			var isDuplicate : Boolean = false;
			
			var i : Number = 0;
			for( i = 0 ; i < this.m_subscribers.length ; i++ )
			{
				if( this.m_subscribers[i].method != undefined && this.m_subscribers[i].method == a_function)
					isDuplicate = true;
			}
			
			//register
			if( !isDuplicate )
			{
				this.m_subscribers.push({ observer : new Observer( a_function, a_context ), method : a_function });
			}
			
			return !isDuplicate;
		}
		
		/**
     	 * <P>Remove Subscriber in Observer</P>
      	 */
		public function RemoveSubscriber( a_function : Function ) : Boolean
		{
			var i : Number = 0;
			for( i = 0 ; i < this.m_subscribers.length ; i++ )
			{
				// find subscriber
				if( this.m_subscribers[i].method != undefined && this.m_subscribers[i].method == a_function)
				{
					// clear observer info
					var temp = this.m_subscribers[i];
					temp.method = null;
					temp.observer = null;
					// clear store
					this.m_subscribers.splice(i, 1);
					return true;
				}
			}
			return false;
		}
		
		/**
     	 * <P>Notify Subscriber from Observer</P>
      	 */
		public function Notify( a_notification : INotification = null )
		{
			var i : Number = 0;
			for( i = 0 ; i < this.m_subscribers.length ; i++ )
			{
				(this.m_subscribers[i].observer as Observer).notifyObserver(a_notification);
			}
		}
		
		/**public get/set function：變數存取介面*/
		/**write only：唯寫*/
		/**read only：唯讀*/
		/**
     	 * <P>[Read-only]Get observer name.</P>
      	 */
		public function getName() : String
		{
			return this.m_name;
		}
		/**
     	 * <P>[Read-only]Get the number of subscribers in observer.</P>
      	 */
		public function getLength() : Number
		{
			return this.m_subscribers.length;
		}
		/**read/write：讀寫*/
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		/**javascript const variable：JavaScript 常數變數*/
	}
}