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
		
	public interface IRMNode extends IRMData
	{
		/*static const variable : 靜態常數變數*/
		/*const variable：常數變數*/
		/*function variable：函數變數*/
		/*member variable：物件內部操作變數*/
		
		/*display object variable：顯示物件變數，如MovieClip等*/
		/*constructor：建構值*/
		/*public function：對外公開函數*/
		/*
		 * 複製物件；數據、連接點不可複製
		 * Clone object itself.
		 */
		function Clone() : IRMNode
		/*
		 * 儲存數據
		 */
		function Store( a_referenceData : IRMObject ) : void
		/*
		 * 刪除數據
		 */
		function Delete( a_referenceData : IRMObject ) : void		
		/*
		 * 存在數據
		 */
		function Has( a_referenceData : IRMObject ) : Boolean		
		/*
		 * 比較數據大小
		 */
		function Compare( a_value : Object ) : Number		
		/*
		 * 內容列表，以矩陣輸出。
		 * Output data list in searcher.
		 */
		function toArray( a_output : Array ) : void
		/*public get/set function：變數存取介面*/
		/*write only：唯寫*/
		/*read only：唯讀*/
		/*
		 * [唯讀]，取得關聯物件群
		 * Get reference data object.
		 */
		function getReference() : Array
		/*read/write：讀寫*/
		
		/*
		 * [讀寫]，設定最大儲存量
		 * max store amount of reference data.
		 */
		function getMaxSize() : Number
		function setMaxSize( a_maxSize : Number ) : void
		/*private event function：私用事件函數*/
		/*private function：私用函數*/
		
	}
}