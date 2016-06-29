/*
	Info:
		- Game Rule Architecture kernel code.
		
	Date:
		- 2014.05.09
		
	Author:
		- Name : Jacky Chen 
		- Nickname : EastMoon
		- Email : jacky_eastmoon@hotmail.com
		
 	Copyright (c) 2013 Jacky Chen
 	Your reuse is governed by the Creative Commons Attribution 3.0 License
*/

package org.gra.model.RuleModel.Interface.Data
{

	/*import：Flash內建元件庫*/		
	/*external import：外部元件庫、開發人員自定元件庫*/
	import org.gra.model.RuleModel.Interface.IRMData;
	import org.gra.model.RuleModel.Interface.IRMObject;
		
	public interface IRMSearcher extends IRMData
	{
		/*static const variable : 靜態常數變數*/
		/*const variable：常數變數*/
		/*function variable：函數變數*/
		/*member variable：物件內部操作變數*/
		
		/*display object variable：顯示物件變數，如MovieClip等*/
		/*constructor：建構值*/
		/*public function：對外公開函數*/
		/*
		 * 插入數值。
		 * Insert data to searcher.
		 */
		function Insert( a_keyValue : Object, a_referenceData : IRMObject ) : IRMNode
		/*
		 * 移除數值。
		 * Remove data at searcher.
		 */
		function Remove( a_keyValue : Object, a_referenceData : IRMObject = null ) : IRMNode
		/*
		 * 存在數值。
		 * Has data in searcher.
		 */
		function Has( a_keyValue : Object, a_referenceData : IRMObject = null ) : Boolean
		/*
		 * 取回數值。
		 * Retrieve data from searcher.
		 * @Param : a_returnNode, a flag that function will return node or reference of node. default is false, return reference of node.
		 */
		function Retrieve( a_keyValue : Object, a_returnNode : Boolean = false ) : Object
		/*
		 * 取回數值。
		 * Use different compare type to retrieve data from searcher.
		 * @Param : a_returnNode, a flag that function will return node or reference of node. default is false, return reference of node.
		 */
		function RetrieveByCompare( a_keyValue : Object, a_compareType : Number = 0, a_returnNode : Boolean = false ) : Array
		/*
		 * 取回數值。
		 * Retrieve a range data from searcher.
		 * @Param : a_returnNode, a flag that function will return node or reference of node. default is false, return reference of node.
		 */
		function RetrieveByRange( a_minimum : Object, a_maximum : Object, a_returnNode : Boolean = false ) : Array
		/*
		 * 內容列表，以矩陣輸出。
		 * Output data list in searcher.
		 */
		function toArray() : Array
		/*public get/set function：變數存取介面*/
		/*write only：唯寫*/
		/*read only：唯讀*/
		/*read/write：讀寫*/
		/*
		 * [讀寫]，設定節點物件
		 * Get / Set root data in searcher.
		 */
		function getNodeType() : IRMNode
		function setNodeType( a_node : IRMNode ) : void
		/*
		 * [讀寫]，存取根節點
		 * Get / Set root data in searcher.
		 */
		function getRoot() : IRMNode
		function setRoot( a_node : IRMNode ) : void
		/*private event function：私用事件函數*/
		/*private function：私用函數*/
		
	}
}