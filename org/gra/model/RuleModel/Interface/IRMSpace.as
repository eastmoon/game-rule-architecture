/*
	Info:
		- Game Rule Architecture kernel code.
		
	Date:
		- 2014.02.20
		
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
	public interface IRMSpace extends IRMNotifyDispatcher
	{		
		/**public function：對外公開函數*/
		/**
     	 * <P>Add <code>IRMActor</code> in RMSpace.</P>
      	 */
		function AddActor( a_actor : IRMActor, a_var : IRMSpaceVar = null ) : void
		
		/**
     	 * <P>Remove <code>IRMActor</code> from RMSpace.</P>
      	 */
		function RemoveActor( a_actor : IRMActor ) : void
		
		/**
     	 * <P>Transform global coordinate to the RMSpace coordinate.</P>
      	 */
		function TransformCoordinate( a_spaceVar : IRMSpaceVar ) : IRMSpaceVar
		
		/**
     	 * <P>Retrieve all object ( <code>IRMActor</code> or <code>IRMSpace</code> ) in the RMSpace.</P>
      	 */
		function RetrieveObject( a_spaceVar : IRMSpaceVar ) : Array
		/**public event function：公開事件函數*/
		/**public get/set function：變數存取介面*/
		/**write only：唯寫*/
		/**read only：唯讀*/
		/**
     	 * <P>[Read-only]Get <code>IRMActor</code> container.</P>
      	 */
		function getActors() : Array
		/**read/write：讀寫*/
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		/**javascript const variable：JavaScript 常數變數*/
	}
}