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
	public interface IRMModule extends IRMNotifyDispatcher
	{		
		/**public function：對外公開函數*/
		// 系統命令
		/**
     	 * <P>Initial all <code>RMSpace</code> in <code>RMModule</code>.</P>
      	 */
		function Initial( a_params : Object = null ) : void
		/**
     	 * <P>Initial a <code>RMActor</code> in <code>RMModule</code>.</P>
      	 */
		function InitialActorByName( a_targetName : String, a_params : Object = null ) : void
		/**
     	 * <P>Initial a <code>RMSpace</code> in <code>RMModule</code>.</P>
      	 */
		function InitialSpaceByName( a_targetName : String, a_params : Object = null ) : void
		/**
     	 * <P>Update all <code>RMSpace</code> in <code>RMModule</code>.</P>
      	 */
		function Update( a_params : Object = null, a_targetName : String = "" ) : void
		/**
     	 * <P>Draw all <code>RMSpace</code> in <code>RMModule</code>.</P>
      	 */
		function Draw( a_params : Object = null, a_targetName : String = "" ) : void
		/**
     	 * <P>Enabled all <code>RMSpace</code> in <code>RMModule</code>.</P>
      	 */
		function Enabled( a_isEnabled : Boolean = true, a_targetName : String = "" ) : void
		// Actor管理
		/**
     	 * <P>Register <code>RMActor</code> in RMModule</P>
      	 */
		function RegisterActor( a_name : String, a_actor : IRMActor ) : void
		/**
     	 * <P>Remove <code>RMActor</code> from RMModule</P>
      	 */
		function RemoveActor( a_name : String ) : IRMActor
		/**
     	 * <P>Has <code>RMActor</code> in RMModule</P>
      	 */
		function HasActor( a_name : String ) : Boolean
		/**
     	 * <P>Retrieve <code>RMActor</code> from RMModule</P>
      	 */
		function RetrieveActor( a_name : String ) : IRMActor
		// Space管理
		/**
     	 * <P>Register <code>RMSpace</code> in RMModule</P>
      	 */
		function RegisterSpace( a_name : String, a_space : IRMSpace ) : void
		/**
     	 * <P>Remove <code>RMSpace</code> from RMModule</P>
      	 */
		function RemoveSpace( a_name : String) : IRMSpace
		/**
     	 * <P>Has <code>RMSpace</code> in RMModule</P>
      	 */
		function HasSpace( a_name : String) : Boolean
		/**
     	 * <P>Retrieve <code>RMSpace</code> from RMModule</P>
      	 */
		function RetrieveSpace( a_name : String) : IRMSpace
		// Event管理
		/**
     	 * <P>Register <code>RMEvent</code> in RMModule</P>
      	 */
		function RegisterEvent( a_name : String, a_event : IRMEvent ) : void
		/**
     	 * <P>Remove <code>RMEvent</code> from RMModule</P>
      	 */
		function RemoveEvent( a_name : String) : IRMEvent
		/**
     	 * <P>Has <code>RMEvent</code> in RMModule</P>
      	 */
		function HasEvent( a_name : String) : Boolean
		/**
     	 * <P>Execute <code>RMEvent</code> from RMModule</P>
      	 */
		function ExecuteEvent( a_vars : IRMEventVar ) : void
		/**public event function：公開事件函數*/
		/**public get/set function：變數存取介面*/
		/**write only：唯寫*/
		/**read only：唯讀*/
		/**read/write：讀寫*/
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		/**javascript const variable：JavaScript 常數變數*/
	}
}