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
	
	public interface IRMDataSet extends IRMNotifyDispatcher
	{		
		/**public function：對外公開函數*/
		// DataTable 管理
		/**
     	 * <P>Register <code>IRMDataTable</code> in IRMDataSet</P>
      	 */
		function RegisterDataTable( a_name : String, a_table : IRMDataTable ) : void
		/**
     	 * <P>Remove <code>IRMDataTable</code> from IRMDataSet</P>
      	 */
		function RemoveDataTable( a_name : String ) : IRMDataTable
		/**
     	 * <P>Has <code>IRMDataTable</code> in IRMDataSet ?</P>
      	 */
		function HasDataTable( a_name : String ) : Boolean
		/**
     	 * <P>Retrieve <code>IRMDataTable</code> from IRMDataSet</P>
      	 */
		function RetrieveDataTable( a_name : String ) : IRMDataTable
		/**
     	 * <P>Retrieve all <code>IRMDataTable</code> name registry in IRMDataSet</P>
      	 */
		function RetrieveNameRegistryOfDataTable() : Array
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