/*
	Info:
		- Game Rule Architecture kernel code.
		- 
		
	Date:
		- 2013.05.11
		
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
	import org.gra.model.RuleModel.Core.RMData;
	import org.gra.model.RuleModel.Interface.IRMData;
	import org.gra.model.RuleModel.Interface.IRMObject;
	import org.gra.model.RuleModel.Interface.Data.IRMNode;
	import org.gra.model.RuleModel.Interface.Data.IRMSearcher;
	 
    /**
     * <P>The base object in Rule Model.</P>
     */
    public class RMSearcher extends RMData implements IRMSearcher
    {
        /**static const variable : 靜態常數變數*/
		/**const variable：常數變數*/
		/**function variable：函數變數*/
		/**member variable：物件內部操作變數*/
		private var m_dataList : Array;
		private var m_root : IRMData;
		private var m_nodeType : IRMNode;
		/**display object variable：顯示物件變數，如MovieClip等*/
		
		/**constructor：建構值*/
        public function RMSearcher( a_name : String = "", a_value : Object = null )
		{
			this.setData( a_name, a_value );
			this.m_dataList = new Array();
        }
		/**public function：對外公開函數*/
		/*
		 * 插入數值，依據演算規則從填入適當的結構。
		 * Insert data to searcher.
		 */
		public function Insert( a_keyValue : Object, a_referenceData : IRMObject ) : IRMNode
		{
			var i : Number = 0, j : Number = 0, k : Number = 0;
			var index : Number = this.RetrieveIndexByCompare( a_keyValue, RMCompare.LESS );
			var node : IRMNode = null;
			var target : IRMNode = null;
			
			// index is Less input value, and index + 1 will be Equal or Large
			i = index + 1;
			if( i < this.m_dataList.length )
			{
				node = this.m_dataList[i];
				if( node.Compare( a_keyValue ) != RMCompare.EQUAL )
					node = null;
			}
			
			// case 1. value isn't exist in searcher.
			if( node == null && this.getNodeType() != null )
			{
				// Create new node.
				node = this.getNodeType().Clone();
				// Setting value.
				node.setMaxSize( this.getNodeType().getMaxSize() );
				node.setValue( a_keyValue );
				node.Store( a_referenceData );
				// Store in array.
				this.m_dataList.push( node );
				// Sorting
				if( this.m_dataList.length > 1 )
				{
					for( i = this.m_dataList.length - 1 ; i > (index + 1) ; i-- )
					{						
						node = this.m_dataList[i] as IRMNode;
						this.m_dataList[i] = this.m_dataList[i -1];
						this.m_dataList[i - 1] = node;
					}
				}
			}
			// case 2. value is exist in searcher, and reference data isn't exist in node.
			else if( node != null && !node.Has( a_referenceData ) )
			{
				// Store data in node.
				node.Store( a_referenceData );
			}
			
			return node;
		}
		/*
		 * 移除數值，依據演算規則從結構挑選目標刪除，並保持結構完整。
		 * Remove data at searcher.
		 */
		public function Remove( a_keyValue : Object, a_referenceData : IRMObject = null ) : IRMNode
		{
			var i : Number = 0, j : Number = 0, k : Number = 0;
			var index : Number = this.RetrieveIndexByCompare( a_keyValue );
			var node : IRMNode = null;
			
			// value is exist
			if( index >= 0 && index < this.m_dataList.length )
			{
				// take node.
				node = this.m_dataList[index] as IRMNode;
				// case 1. input reference isn't null.
				if( a_referenceData != null )
				{
					// case 1.1 remove reference data
					node.Delete( a_referenceData );
					// case 1.2 if node size is 0, than remove node
					if( node.getReference().length == 0 )
					{
						this.m_dataList.splice( index, 1 );
					}
				}
				// case 2. input reference is null
				else
				{
					// remove node.
					this.m_dataList.splice( index, 1 );
				}
			}
			return node;
		}
		/*
		 * 存在數值。
		 * Has data in searcher.
		 */
		public function Has( a_keyValue : Object, a_referenceData : IRMObject = null ) : Boolean
		{
			var node : IRMNode = this.Retrieve( a_keyValue, true ) as IRMNode;
			if( node != null )
				return node.Has( a_referenceData );
			return false;
		}
		/*
		 * 取回數值。
		 * Retrieve node from searcher.
		 * @Param : a_returnNode, a flag that function will return node or reference of node. default is false, return reference of node.
		 */
		public function Retrieve( a_keyValue : Object, a_returnNode : Boolean = false ) : Object
		{
			var i : Number = 0, j : Number = 0, k : Number = 0;
			// check have value
			var index : Number = RetrieveIndexByCompare( a_keyValue );
			var node : IRMNode = null;
			if( index >= 0 && index < this.m_dataList.length )
			{
				// value is exist in searcher
				node = this.m_dataList[index];
				// case 1. if reference data is null, and returnNode is false, return reference of node.
				if( node != null && !a_returnNode )
					return node.getReference();
				
				return node;
			}
			return null;
		}
		/*
		 * 取回數值。
		 * Use different compare type to retrieve data from searcher.
		 * @Param : a_returnNode, a flag that function will return node or reference of node. default is false, return reference of node.
		 */
		public function RetrieveByCompare( a_keyValue : Object, a_compareType : Number = 0, a_returnNode : Boolean = false ) : Array
		{
			var result : Array = new Array();
			var i : Number = 0, j : Number = 0, k : Number = 0;
			var index : Number = this.RetrieveIndexByCompare( a_keyValue, a_compareType );
			var node : IRMNode = null;
			//trace( index, this.m_dataList.length );
			if( index >= 0 && index < this.m_dataList.length )
			{
				switch( a_compareType )
				{
					case RMCompare.EQUAL :
					{
						node = this.m_dataList[index] as IRMNode;
						if( node != null )
						{
							if( a_returnNode )
								result.push( node );
							else
								node.toArray( result );
						}							
					}
					break;
					case RMCompare.LARGE :
					{
						for( i = index ; i < this.m_dataList.length ; i++ )
						{
							node = this.m_dataList[i];
							if( node != null )
							{
								if( a_returnNode )
									result.push( node );
								else
									node.toArray( result );
							}		
						}
					}
					break;
					case RMCompare.LESS :
					{
						for( i = 0 ; i <= index ; i++ )
						{
							node = this.m_dataList[i];
							if( node != null )
							{
								if( a_returnNode )
									result.push( node );
								else
									node.toArray( result );
							}		
						}
					}
					break;
				}
			}
			return result;
		}
		/*
		 * 取回數值。
		 * Retrieve a range data from searcher.
		 * @Param : a_returnNode, a flag that function will return node or reference of node. default is false, return reference of node.
		 */
		public function RetrieveByRange( a_minimum : Object, a_maximum : Object, a_returnNode : Boolean = false ) : Array
		{
			var result : Array = new Array();
			var i : Number = 0, j : Number = 0, k : Number = 0;
			var node : IRMNode = null;
			var minIndex : Number = this.RetrieveIndexByCompare( a_minimum, RMCompare.LESS ) + 1;
			var maxIndex : Number = this.RetrieveIndexByCompare( a_maximum, RMCompare.LARGE ) - 1;
				
			for( i = minIndex ; i <= maxIndex ; i++ )
			{
				node = this.m_dataList[i];
				if( node != null )
				{
					if( a_returnNode )
						result.push( node );
					else
						node.toArray( result );
				}	
			}
			
			return result;
		}
		/*
		 * 取回索引。
		 * Use compare type to retrieve index number.
		 */
		private function RetrieveIndexByCompare( a_keyValue : Object, a_compareType : Number = 0 ) : Number
		{
			var i : Number = 0, j : Number = 0, k : Number = 0;
			var startFlag : Number = 0, midFlag : Number = 0, endFlag : Number = 0;
			var resultFlag : Number = -1;
			var compareType : Number = -1;
			var node : IRMNode = null;
			
			// Initial flag
			startFlag = 0;
			endFlag = this.m_dataList.length - 1;
			while( startFlag <= endFlag )
			{
				// 1. Calculate middle flag
				midFlag = Math.floor( ( endFlag - startFlag ) / 2 ) + startFlag;
				// 2. Take a node.
				node = this.m_dataList[midFlag] as IRMNode;
				// 3. Calculate compare result.
				compareType = node.Compare( a_keyValue );
				// 4. Calculate result.
				resultFlag = midFlag;
				// case 4.1 if input type is equal, compare is not equal, than result is not find.
				if( a_compareType == RMCompare.EQUAL && compareType != RMCompare.EQUAL )
					resultFlag = -1;
				// case 4.2 if input type is large and compare is equal or less, result is large than current.
				else if( a_compareType == RMCompare.LARGE && compareType != RMCompare.LARGE)
					resultFlag += 1;
				// case 4.3 if input type is less, result is less than current.
				else if( a_compareType == RMCompare.LESS && compareType != RMCompare.LESS )
					resultFlag -= 1;
				// 5. Bisection method
				if( compareType == RMCompare.LESS )
				{
					startFlag = midFlag + 1;
				}
				else if( compareType == RMCompare.LARGE  )
				{
					endFlag = midFlag - 1;
				}
				else if( compareType == RMCompare.EQUAL )
				{
					break;
				}
			}
			
			// if result large than list size, it mean not find.
			//if( resultFlag >= this.m_dataList.length )
				//resultFlag = -1;
				
			return resultFlag;
		}
		/*
		 * 內容列表，以矩陣輸出。
		 * Output data list in searcher.
		 */
		public function toArray() : Array
		{
			var output : Array = new Array();
			var node : IRMNode = null;
			for( var i = 0 ; i < this.m_dataList.length ; i++ )
			{
				node = this.m_dataList[i] as IRMNode;
				if( node != null )
					node.toArray( output );
			}
			return output;
		}
		/**public event function：公開事件函數*/
		/**public get/set function：變數存取介面*/
		/**write only：唯寫*/
		/*read only：唯讀*/
		/*read/write：讀寫*/
		
		/*
		 * [讀寫]，設定節點物件
		 * Get / Set root data in searcher.
		 */
		public function getNodeType() : IRMNode
		{
			return this.m_nodeType;
		}
		public function setNodeType( a_node : IRMNode ) : void
		{
			this.m_nodeType = a_node;
		}
		/*
		 * [讀寫]，存取根節點
		 * Get / Set root data in searcher.
		 */
		public function getRoot() : IRMNode
		{
			return this.getValue() as IRMNode;
		}
		public function setRoot( a_node : IRMNode ) : void
		{
			this.setValue( a_node );
		}
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		/**javascript const variable：JavaScript 常數變數*/
    }
}