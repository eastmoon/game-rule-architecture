/*
	Info:
		- Game Rule Architecture kernel code.
		- 
		
	Date:
		- 2013.05.15
		
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
     * <P>The base object in Rule Model.</P>
     */
    public class RMDataSet extends RMNotifyDispatcher implements IRMDataSet
    {
        /**static const variable : 靜態常數變數*/
		/**const variable：常數變數*/
		/**function variable：函數變數*/
		/**member variable：物件內部操作變數*/
		private var m_dataTables : IRMDataObject;
		/**display object variable：顯示物件變數，如MovieClip等*/
		
		/**constructor：建構值*/
        public function RMDataSet()
		{
			this.m_dataTables = new RMDataObject();
        }
		/**public function：對外公開函數*/
		/**
     	 * <P>Register <code>IRMDataTable</code> in IRMDataSet</P>
      	 */
		public function RegisterDataTable( a_name : String, a_table : IRMDataTable ) : void
		{
			// 1. check name isn't duplicate
			if( this.m_dataTables.getValue( a_name ) == null && a_table != null )
			{
				// 2. new data store IRMDataObject
				this.m_dataTables.RegisterAttribute( new RMData( a_name, a_table ) );
			}
		}
		/**
     	 * <P>Remove <code>IRMDataTable</code> from IRMDataSet</P>
      	 */
		public function RemoveDataTable( a_name : String ) : IRMDataTable
		{
			return this.m_dataTables.RemoveAttribute( a_name ) as IRMDataTable;
		}
		/**
     	 * <P>Has <code>IRMDataTable</code> in IRMDataSet ?</P>
      	 */
		public function HasDataTable( a_name : String ) : Boolean
		{
			if( this.m_dataTables.getValue( a_name ) != null )
				return true;
			return false;
		}
		/**
     	 * <P>Retrieve <code>IRMDataTable</code> from IRMDataSet</P>
      	 */
		public function RetrieveDataTable( a_name : String ) : IRMDataTable
		{
			return this.m_dataTables.getValue(a_name) as IRMDataTable;
		}
		/**
     	 * <P>Retrieve all <code>IRMDataTable</code> name registry in IRMDataSet</P>
      	 */
		public function RetrieveNameRegistryOfDataTable() : Array
		{
			var list : Array = this.m_dataTables.getAttributeIndex();
			var info : IRMData = null;
			var registry : Array = new Array();
			
			for( var i = 0 ; list != null && i < list.length ; i++ )
			{
				info = list[i];
				if( info != null )
					registry.push( info.getName() );
			}
			return registry;
		}
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