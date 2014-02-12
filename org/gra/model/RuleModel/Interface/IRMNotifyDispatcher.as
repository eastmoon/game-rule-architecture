/*
	Info:
		- Game Rule Architecture kernel code.
		
	Date:
		- 2014.02.12
		
	Author:
		- Name : Jacky Chen 
		- Nickname : EastMoon
		- Email : jacky_eastmoon@hotmail.com
		
 	Copyright (c) 2013 Jacky Chen
 	Your reuse is governed by the Creative Commons Attribution 3.0 License
*/


package org.gra.model.RuleModel.Interface
{	
	/*import：Flash內建元件庫*/
	/*external import：外部元件庫、開發人員自定元件庫*/

	public interface IRMNotifyDispatcher extends IRMObject
	{		
		/*public function：對外公開函數*/		
		/**
     	 * <P>Add Notify in RMNotifyDispatcher.</P>
      	 */
		function AddNotify( a_notifyName : String, a_function : Function, a_context : Object = null ) : void
		/**
     	 * <P>Remove Notify in RMNotifyDispatcher.</P>
      	 */
		function RemoveNotify( a_notifyName : String, a_function : Function ) : void
		/**
     	 * <P>Has Notify in RMNotifyDispatcher.</P>
      	 */
		function HasNofity( a_notifyName : String ) : Boolean
		/**
     	 * <P>Send Notify in RMNotifyDispatcher.</P>
      	 */
		function SendNotify( a_notification : IRMNotification = null) : void
		/**
     	 * <P>Set a name and <code>RMModule</code> who is this object register in.</p>
      	 */
		function RegisterInfo( a_name : String = "" , a_module : IRMModule = null) : void
		/**public get/set function：變數存取介面*/
		/**write only：唯寫*/
		/**read only：唯讀*/
		/**
     	 * <P>[Read-Only]Get the object name.</P>
      	 */
		function getName() : String
		/**
     	 * <P>[Read-Only]Get <code>RMModule</code> who is this object register in.</P>
      	 */
		function getModule() : IRMModule
		/**read/write：讀寫*/
		/**
     	 * <P>[Read-Write]get <code>RMNotifyDispatcher</code> notify Enabled or Disabled state.</P>
      	 */
		function setEnabledNotify( a_isEnabled : Boolean ) : void
		function getEnabledNotify() : Boolean
	}
}