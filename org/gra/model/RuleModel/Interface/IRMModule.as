/*
	Info:
		- Game Rule Architecture kernel code.
		
	Date:
		- 2014.05.15
		
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
     	 * <P>Initial all <code>IRMSpace</code> in <code>IRMModule</code>.</P>
      	 */
		function Initial( a_params : Object = null ) : void
		/**
     	 * <P>Initial a <code>IRMActor</code> in <code>IRMModule</code>.</P>
      	 */
		function InitialActorByName( a_targetName : String, a_params : Object = null ) : void
		/**
     	 * <P>Initial a <code>IRMSpace</code> in <code>IRMModule</code>.</P>
      	 */
		function InitialSpaceByName( a_targetName : String, a_params : Object = null ) : void
		/**
     	 * <P>Update all <code>IRMSpace</code> in <code>IRMModule</code>.</P>
      	 */
		function Update( a_params : Object = null, a_targetName : String = "" ) : void
		/**
     	 * <P>Draw all <code>IRMSpace</code> in <code>IRMModule</code>.</P>
      	 */
		function Draw( a_params : Object = null, a_targetName : String = "" ) : void
		/**
     	 * <P>Enabled all <code>IRMSpace</code> in <code>IRMModule</code>.</P>
      	 */
		function Enabled( a_isEnabled : Boolean = true, a_targetName : String = "" ) : void
		// Actor管理
		/**
     	 * <P>Register <code>IRMActor</code> in IRMModule</P>
      	 */
		function RegisterActor( a_name : String, a_actor : IRMActor ) : void
		/**
     	 * <P>Remove <code>IRMActor</code> from IRMModule</P>
      	 */
		function RemoveActor( a_name : String ) : IRMActor
		/**
     	 * <P>Has <code>IRMActor</code> in IRMModule</P>
      	 */
		function HasActor( a_name : String ) : Boolean
		/**
     	 * <P>Retrieve <code>IRMActor</code> from IRMModule</P>
      	 */
		function RetrieveActor( a_name : String ) : IRMActor
		/**
     	 * <P>Retrieve all <code>IRMActor</code> name registry in IRMModule</P>
      	 */
		function RetrieveNameRegistryOfActor() : Array
		// Space管理
		/**
     	 * <P>Register <code>IRMSpace</code> in IRMModule</P>
      	 */
		function RegisterSpace( a_name : String, a_space : IRMSpace ) : void
		/**
     	 * <P>Remove <code>IRMSpace</code> from IRMModule</P>
      	 */
		function RemoveSpace( a_name : String ) : IRMSpace
		/**
     	 * <P>Has <code>IRMSpace</code> in IRMModule</P>
      	 */
		function HasSpace( a_name : String ) : Boolean
		/**
     	 * <P>Retrieve <code>IRMSpace</code> from IRMModule</P>
      	 */
		function RetrieveSpace( a_name : String ) : IRMSpace
		/**
     	 * <P>Retrieve all <code>IRMSpace</code> name registry in IRMModule</P>
      	 */
		function RetrieveNameRegistryOfSpace() : Array
		// Event管理
		/**
     	 * <P>Register <code>IRMEvent</code> in IRMModule</P>
      	 */
		function RegisterEvent( a_name : String, a_event : IRMEvent ) : void
		/**
     	 * <P>Remove <code>IRMEvent</code> from IRMModule</P>
      	 */
		function RemoveEvent( a_name : String ) : IRMEvent
		/**
     	 * <P>Has <code>IRMEvent</code> in IRMModule</P>
      	 */
		function HasEvent( a_name : String ) : Boolean
		/**
     	 * <P>Execute <code>IRMEvent</code> from IRMModule</P>
      	 */
		function ExecuteEvent( a_vars : IRMEventVar ) : void
		/**
     	 * <P>Retrieve all <code>IRMEvent</code> name registry in IRMModule</P>
      	 */
		function RetrieveNameRegistryOfEvent() : Array
		// DataSet管理
		/**
     	 * <P>Register <code>IRMDataSet</code> in IRMModule</P>
      	 */
		function RegisterDataSet( a_name : String, a_dataSet : IRMDataSet ) : void
		/**
     	 * <P>Remove <code>IRMDataSet</code> from IRMModule</P>
      	 */
		function RemoveDataSet( a_name : String ) : IRMDataSet
		/**
     	 * <P>Has <code>IRMDataSet</code> in IRMModule</P>
      	 */
		function HasDataSet( a_name : String ) : Boolean
		/**
     	 * <P>Execute <code>IRMDataSet</code> from IRMModule</P>
      	 */
		function RetrieveDataSet( a_name : String ) : IRMDataSet
		/**
     	 * <P>Retrieve all <code>IRMDataSet</code> name registry in IRMModule</P>
      	 */
		function RetrieveNameRegistryOfDataSet() : Array
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