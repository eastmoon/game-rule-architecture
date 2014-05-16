/*
	Info:
		- Game Rule Architecture kernel code.
		- 
		
	Date:
		- 2013.05.10
		
	Author:
		- Name : Jacky Chen 
		- Nickname : EastMoon
		- Email : jacky_eastmoon@hotmail.com
		
 	Copyright (c) 2013 Jacky Chen
 	Your reuse is governed by the Creative Commons Attribution 3.0 License
*/

package org.gra.model.RuleModel.Core.Data
{	

	/*import：Flash內建元件庫*/
	/*external import：外部元件庫、開發人員自定元件庫*/
	import org.gra.model.RuleModel.Core.RMObject;
	 
    /**
     * <P>The base object in Rule Model.</P>
     */
    public class RMCompare extends RMObject
    {
        /**static const variable : 靜態常數變數*/
		public static const UNKNOWEN : Number = -65535;
		public static const EQUAL : Number = 0;
		public static const LESS : Number = -1;
		public static const LARGE : Number = 1;
		/**const variable：常數變數*/
		/**function variable：函數變數*/
		/**member variable：物件內部操作變數*/
		/**display object variable：顯示物件變數，如MovieClip等*/
		
		/**constructor：建構值*/
        public function RMCompare()
		{
		}
		/**public function：對外公開函數*/
		/**public event function：公開事件函數*/
		/**public get/set function：變數存取介面*/
		/**write only：唯寫*/
		/*read only：唯讀*/
		/*read/write：讀寫*/
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		/**javascript const variable：JavaScript 常數變數*/
    }
}