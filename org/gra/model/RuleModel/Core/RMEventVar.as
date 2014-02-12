/*
	Info:
		- Game Rule Architecture kernel code.
		
	Date:
		- 2013.09.04
		
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
	 
    /**
     * <P>The variable for <code>RMEvent</code>.</P>
     */
	public class RMEventVar extends RMNotifyDispatcher implements IRMEventVar
	{
		/**static const variable : 靜態常數變數*/
		/**const variable：常數變數*/
		/**function variable：函數變數*/
		/**member variable：物件內部操作變數*/
		/**constructor：建構值*/
		public function RMEventVar( a_name : String = "", a_module : IRMModule = null )
		{
			// 儲存事件(Event)名稱與模組(Module)資料
			this.RegisterInfo( a_name, a_module );
		}
		
		/**public function：對外公開函數*/
		/**read/write：讀寫*/
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		/**javascript const variable：JavaScript 常數變數*/
	}
}