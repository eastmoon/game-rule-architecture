/*
	Info:
		- Game Rule Architecture kernel code.
		- 
		
	Date:
		- 2013.04.19
		
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
	import org.gra.model.RuleModel.Interface.IRMData;
	 
    /**
     * <P>The base object in Rule Model.</P>
     */
    public class RMData extends RMObject implements IRMData
    {
        /**static const variable : 靜態常數變數*/
		/**const variable：常數變數*/
		/**function variable：函數變數*/
		/**member variable：物件內部操作變數*/
		protected var m_name : String;
		protected var m_value : Object;
		/**display object variable：顯示物件變數，如MovieClip等*/
		
		/**constructor：建構值*/
        public function RMData( a_name : String = "", a_value : Object = null )
		{
			this.setData( a_name, a_value );
        }
		/**public function：對外公開函數*/
		/**public event function：公開事件函數*/
		/**public get/set function：變數存取介面*/
		/**write only：唯寫*/
		/**
     	 * <P>Setting data information.</P>
      	 */
		public function setData( a_name : String, a_value : Object ) : void
		{
			this.m_name = a_name;
			this.setValue( a_value );
		}
		/**read only：唯讀*/
		/**
     	 * <P>Get data name.</P>
      	 */
		public function getName() : String
		{
			return this.m_name;
		}
		/**read/write：讀寫*/
		/**
     	 * <P>Set data value.</P>
      	 */
		public function setValue( a_value : Object ) : void
		{
			this.m_value = a_value;
		}
		/**
     	 * <P>Get data value.</P>
      	 */
		public function getValue() : Object
		{
			return this.m_value;
		}
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		/**javascript const variable：JavaScript 常數變數*/
    }
}