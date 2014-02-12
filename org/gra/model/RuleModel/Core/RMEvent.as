/*
	Info:
		- Game Rule Architecture kernel code.
		- Game Rule Architure base event object.
		
	Date:
		- 2013.03.14
		
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
     * <P>The base event object in Rule Model.</P>
     */
	 
    public class RMEvent extends RMNotifyDispatcher implements IRMEvent
    {
        /**static const variable : 靜態常數變數*/
		/**const variable：常數變數*/
		/**function variable：函數變數*/
		/**member variable：物件內部操作變數*/
		/**display object variable：顯示物件變數，如MovieClip等*/
		
		/**constructor：建構值*/
        public function RMEvent()
		{
            //trace("RMEvent");
        }
		/**public function：對外公開函數*/
		/**
     	 * <P>Execute <code>RMEvent</code> content use <code>RMEventVar</code>.</P>
      	 */
		public function Execute( a_vars : IRMEventVar ) : void    
		{
			trace( a_vars.getName(), a_vars.getModule() );
        }
		/**
     	 * <P>Override function, Set a name and <code>RMModule</code> who is this <code>RMModule</code> object already registered in.</p>
      	 */
		public override function RegisterInfo( a_name : String = "" , a_model : IRMModule = null) : void
		{
			if( a_model != null && a_model.HasEvent( a_name ) )
				super.RegisterInfo(a_name, a_model);
		}
		/**public get/set function：變數存取介面*/
		/**write only：唯寫*/
		/**read only：唯讀*/
		/**read/write：讀寫*/
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		/**javascript const variable：JavaScript 常數變數*/
    }
}