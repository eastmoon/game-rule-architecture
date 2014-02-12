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
	public interface IRMSpaceVar extends IRMNotifyDispatcher
	{		
		/**public function：對外公開函數*/
		/**public event function：公開事件函數*/
		/**public get/set function：變數存取介面*/
		/**write only：唯寫*/
		/**read only：唯讀*/
		/**
    	 * <P>Take back <code>RMSpace</code> object point.</P>
     	*/
		function getSpace() : IRMSpace
		/**read/write：讀寫*/
		/**
    	 * <P>Set and Get ths location.x .</P>
     	 */
		function setX( a_value : Number ) : void
		function getX() : Number
		/**
    	 * <P>Set and Get ths location.y .</P>
     	 */
		function setY( a_value : Number ) : void
		function getY() : Number
		/**
    	 * <P>Set and Get ths location.z .</P>
     	 */
		function setZ( a_value : Number ) : void
		function getZ() : Number
		/**
    	 * <P>Set and Get ths Size.width .</P>
     	 */
		function setWidth( a_value : Number ) : void
		function getWidth() : Number
		/**
    	 * <P>Set and Get ths Size.height .</P>
     	 */
		function setHeight( a_value : Number ) : void
		function getHeight() : Number
		/**
    	 * <P>Set and Get ths Size.depth .</P>
     	 */
		function setDepth( a_value : Number ) : void
		function getDepth() : Number
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		/**javascript const variable：JavaScript 常數變數*/
	}
}