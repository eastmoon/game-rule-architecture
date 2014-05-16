/*
	Info:
		- Game Rule Architecture kernel code.
		- 
		
	Date:
		- 2013.04.20
		
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
	import org.gra.model.RuleModel.Interface.Data.*;
	import org.gra.model.RuleModel.Core.Data.RMSearcher;
	import org.gra.model.RuleModel.Core.Data.RMNode;
	 
    /**
     * <P>The base object in Rule Model.</P>
     */
    public class RMDataTable extends RMObject implements IRMDataTable
    {
        /**static const variable : 靜態常數變數*/
		/**const variable：常數變數*/
		/**function variable：函數變數*/
		/**member variable：物件內部操作變數*/
		private var m_dataObjectType : IRMDataObject;
		private var m_dataFilters : IRMDataObject;
		private var m_dataObjects : Array;
		/**display object variable：顯示物件變數，如MovieClip等*/
		
		/**constructor：建構值*/
        public function RMDataTable()
		{
			this.m_dataObjects = new Array();
			this.m_dataObjectType = new RMDataObject();
			this.m_dataFilters = new RMDataObject();
        }
		/**public function：對外公開函數*/
		/**
     	 * <P>Register <code>IRMDataObject</code> in IRMDataTable</P>
      	 */
		public function RegisterDataObject( a_name : String, a_table : IRMDataObject ) : void
		{
			// 1. check name isn't duplicate
			if( this.m_dataObjectType.getValue( a_name ) == null && a_table != null )
			{
				// 2. new data store IRMDataObject
				this.m_dataObjectType.RegisterAttribute( new RMData( a_name, a_table ) );
			}
		}
		/**
     	 * <P>Remove <code>IRMDataObject</code> from IRMDataTable</P>
      	 */
		public function RemoveDataObject( a_name : String ) : IRMDataObject
		{
			return this.m_dataObjectType.RemoveAttribute( a_name ) as IRMDataObject;
		}
		/**
     	 * <P>Has <code>IRMDataObject</code> in IRMDataTable ?</P>
      	 */
		public function HasDataObject( a_name : String) : Boolean
		{
			if( this.m_dataObjectType.getValue( a_name ) != null )
				return true;
			return false;
		}
		/**
     	 * <P>Retrieve <code>IRMDataObject</code> from IRMDataTable</P>
      	 */
		public function RetrieveDataObject( a_name : String ) : IRMDataObject
		{
			return this.m_dataObjectType.getValue(a_name) as IRMDataObject;
		}
		/**
     	 * <P>Retrieve all <code>IRMDataObject</code> name registry in IRMDataTable</P>
      	 */
		public function RetrieveNameRegistryOfDataObject() : Array
		{
			var list : Array = this.m_dataObjectType.getAttributeIndex();
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
		/**
     	 * <P>Addation <code>IRMDataObject</code> clone in IRMDataTable, use filter to take back.</P>
      	 */
		public function AddationData( a_dataObjectName : String, a_params : Object ) : void
		{
			// 1. find type
			var i : Number = 0, j : Number = 0, k : Number = 0;
			var type : IRMDataObject = this.m_dataObjectType.getValue( a_dataObjectName ) as IRMDataObject;
			var filter : IRMSearcher = null;
			var attributes : Array = null;
			var data : IRMData = null;
			
			if( type != null )
			{
				// 2. clone type and parse input params.
				var dataObj : IRMDataObject = type.Clone();
				dataObj.Parse( a_params );
				this.m_dataObjects.push( dataObj );
				
				// 3. use attributes to create index.
				// 3.1 get attributes array
				attributes = dataObj.getAttributeIndex();
				// 3.2 retrieve attribute searcher
				for( i = 0 ; i < attributes.length ; i++ )
				{
					// use data.name to find attribute index is exist or not.
					data = attributes[i] as IRMData;
					filter = this.m_dataFilters.getValue( data.getName() ) as IRMSearcher;
					// 3.2.1 if retrieve is null, create new attribute
					if( filter == null )
					{
						filter = new RMSearcher();
						filter.setNodeType( new RMNode() );
						this.m_dataFilters.RegisterAttribute( new RMData( data.getName(), filter ) );
					}
					// 3.2.2 if retrieve has attribute, push value and reference
					if( filter != null )
					{
						filter.Insert( data.getValue(), dataObj );
					}
				}
			}
		}
		/**
     	 * <P>Delete <code>IRMDataObject</code> clone in IRMDataTable, use filter to take back.</P>
      	 */
		public function DeleteData( a_dataObject : IRMDataObject ) : void
		{
			var i : Number = 0, j : Number = 0, k : Number = 0;
			var dataObject : IRMDataObject = null;
			
			for( i = 0 ; i < this.m_dataObjects.length ; i++ )
			{
				if( this.m_dataObjects[i] == a_dataObject )
				{
					dataObject = a_dataObject ;
					this.m_dataObjects[i] = null;
					this.m_dataObjects.splice( i, 1 );
					break;
				}
			}
			
			if( dataObject != null )
			{
				var filter : IRMSearcher = null;
				var data : IRMData = null;
				var attributes : Array = dataObject.getAttributeIndex();
				for( i = 0 ; i < attributes.length ; i++ )
				{
					// use data.name to find attribute index is exist or not.
					data = attributes[i] as IRMData;
					filter = this.m_dataFilters.getValue( data.getName() ) as IRMSearcher;
					// 3.2.2 if retrieve has attribute, push value and reference
					if( filter != null )
					{
						filter.Remove( data.getValue(), dataObject );
					}
				}
			}
		}
		// 過濾，取得特定的DataObject
		/**
     	 * <P>Retrieve <code>IRMDataObject</code> list from IRMDataTable where <code>IRMDataObject</code>.</P>
      	 */
		public function Filter( a_attributeName : String = "" ) : IRMSearcher
		{
			// find the attribute filter.
			return  this.m_dataFilters.getValue( a_attributeName ) as IRMSearcher;
		}
		/**
     	 * <P>Retrieve <code>IRMDataObject</code> list from IRMDataTable where <code>IRMDataObject</code> have attribute and equal values.</P>
      	 */
		public function FilterByValues( a_attributeName : String = "", a_equalValues : Array = null ) : Array
		{
			// find the attribute filter.
			var filter : IRMSearcher = this.m_dataFilters.getValue( a_attributeName ) as IRMSearcher;
			var result : Array = new Array();
			var node : IRMNode = null;
			if( filter != null )
			{
				// use value and compare type to find result
				for( var i = 0 ; i < a_equalValues.length ; i++ )
				{
					node = filter.Retrieve( a_equalValues[i], true ) as IRMNode;
					if( node != null )
						node.toArray( result );
				}
			}
			return result;
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