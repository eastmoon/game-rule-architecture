/*
	Info:
		- Game Rule Architecture kernel code.
		
	Date:
		- 2014.04.19
		
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
	
	public interface IRMData extends IRMObject
	{		
		/**public function：對外公開函數*/
		/**public event function：公開事件函數*/
		/**public get/set function：變數存取介面*/
		/**write only：唯寫*/
		/**
     	 * <P>Setting data information.</P>
      	 */
		function setData( a_name : String, a_value : Object ) : void
		/**read only：唯讀*/
		/**
     	 * <P>Get data name.</P>
      	 */
		function getName() : String
		
		/**read/write：讀寫*/
		/**
     	 * <P>Set data value.</P>
      	 */
		function setValue( a_value : Object ) : void
		
		/**
     	 * <P>Get data value.</P>
      	 */
		function getValue() : Object
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		/**javascript const variable：JavaScript 常數變數*/
	}
} 