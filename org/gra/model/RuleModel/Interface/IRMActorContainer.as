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
	public interface IRMActorContainer extends IRMActor
	{		
		/**public function：對外公開函數*/
		/**
     	 * <P>Add <code>RMActor</code> in container.</P>
      	 */
		function AddActor( a_actor : IRMActor ) : void
		/**
     	 * <P>Remove <code>RMActor</code> from container.</P>
      	 */
		function RemoveActor( a_actor : IRMActor ) : void
		/**public event function：公開事件函數*/
		/**public get/set function：變數存取介面*/
		/**write only：唯寫*/
		/**read only：唯讀*/
		/**
     	 * <P>[Read-only]Get <code>RMActor</code> container.</P>
      	 */
		function getContainer() : Array
		/**read/write：讀寫*/
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		/**javascript const variable：JavaScript 常數變數*/
	}
}