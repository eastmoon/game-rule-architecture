/*
	Info:
		- Game Rule Architecture kernel code.
		
	Date:
		- 2014.04.17
		
	Author:
		- Name : Jacky Chen 
		- Nickname : EastMoon
		- Email : jacky_eastmoon@hotmail.com
		
 	Copyright (c) 2013 Jacky Chen
 	Your reuse is governed by the Creative Commons Attribution 3.0 License
*/

package org.gra.model.RuleModel.Interface
{	
	import org.gra.model.RuleModel.Interface.Data.IRMSearcher;
	
	/*import：Flash內建元件庫*/
	/*external import：外部元件庫、開發人員自定元件庫*/
	
	public interface IRMDataTable extends IRMObject
	{		
		/**public function：對外公開函數*/
		// DataObject 管理
		/**
     	 * <P>Register <code>IRMDataObject</code> in IRMDataTable</P>
      	 */
		function RegisterDataObject( a_name : String, a_table : IRMDataObject ) : void
		/**
     	 * <P>Remove <code>IRMDataObject</code> from IRMDataTable</P>
      	 */
		function RemoveDataObject( a_name : String ) : IRMDataObject
		/**
     	 * <P>Has <code>IRMDataObject</code> in IRMDataTable ?</P>
      	 */
		function HasDataObject( a_name : String) : Boolean
		/**
     	 * <P>Retrieve <code>IRMDataObject</code> from IRMDataTable</P>
      	 */
		function RetrieveDataObject( a_name : String ) : IRMDataObject
		/**
     	 * <P>Retrieve all <code>IRMDataObject</code> name registry in IRMDataTable</P>
      	 */
		function RetrieveNameRegistryOfDataObject() : Array
		/**
     	 * <P>Addation <code>IRMDataObject</code> clone in IRMDataTable, use filter to take back.</P>
      	 */
		function AddationData( a_dataObjectName : String, a_params : Object ) : void
		/**
     	 * <P>Delete <code>IRMDataObject</code> clone in IRMDataTable, use filter to take back.</P>
      	 */
		function DeleteData( a_dataObject : IRMDataObject ) : void
		// 過濾，取得特定的DataObject
		/**
     	 * <P>Retrieve <code>IRMDataObject</code> index list from IRMDataTable.</P>
      	 */
		function Filter( a_attributeName : String = "" ) : IRMSearcher
		/**
     	 * <P>Retrieve <code>IRMDataObject</code> list from IRMDataTable where <code>IRMDataObject</code> have attribute and equal values.</P>
      	 */
		function FilterByValues( a_attributeName : String = "", a_equalValues : Array = null ) : Array
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