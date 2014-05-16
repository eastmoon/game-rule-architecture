/*
	Info:
		- Game Rule Architecture kernel code.
		- 
		
	Date:
		- 2013.05.09
		
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
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	/*external import：外部元件庫、開發人員自定元件庫*/
	import org.gra.model.RuleModel.Core.RMData;
	import org.gra.model.RuleModel.Interface.IRMData;
	import org.gra.model.RuleModel.Interface.IRMObject;
	import org.gra.model.RuleModel.Interface.Data.IRMNode;
	 
    /**
     * <P>The base object in Rule Model.</P>
     */
    public class RMNode extends RMData implements IRMNode
    {
        /**static const variable : 靜態常數變數*/
		/**const variable：常數變數*/
		/**function variable：函數變數*/
		/**member variable：物件內部操作變數*/
		private var m_referenceObjects : Array;
		private var m_maxSize : Number;
		/**display object variable：顯示物件變數，如MovieClip等*/
		
		/**constructor：建構值*/
        public function RMNode( a_value : Object = null, a_maxSize : Number = -1 )
		{
			this.setData( "", a_value );
			this.setMaxSize( a_maxSize);
			this.m_referenceObjects = new Array();
		}
		/**public function：對外公開函數*/
		/*
		 * 複製物件；數據、連接點不可複製
		 * Clone object itself.
		 */
		public function Clone() : IRMNode
		{
			var classType : Class = getDefinitionByName( getQualifiedClassName( this ) ) as Class;
			return new classType();
		}
		/*
		 * 儲存數據
		 */
		public function Store( a_referenceData : IRMObject ) : void
		{
			// 若最大尺寸為 -1，表示無限制
			// 若最大尺寸大於 -1，表示最大儲存不可大於此量
			if( this.m_maxSize < 0 || ( this.m_maxSize >= 0 && this.m_referenceObjects.length < this.m_maxSize ) )
				this.m_referenceObjects.push( a_referenceData );
		}
		/*
		 * 刪除數據
		 */
		public function Delete( a_referenceData : IRMObject ) : void
		{
			for( var i : Number = 0 ; i < this.m_referenceObjects.length ; i ++ )
			{
				if( this.m_referenceObjects[i] == a_referenceData )
				{
					this.m_referenceObjects.splice( i, 1 );
					break;
				}
			}
		}
		/*
		 * 比較數據大小
		 */
		public function Compare( a_value : Object ) : Number		
		{
			var compareResult : Number = RMCompare.EQUAL;
			
			// case 1. string compare
			if( this.getValue() is String && a_value is String )
			{
				compareResult = (this.getValue() as String).localeCompare( a_value )
				if( compareResult > 0 )
					compareResult = RMCompare.LARGE;
				else if( compareResult < 0 )
					compareResult = RMCompare.LESS;
			}
			// case 2 number compare
			if( this.getValue() is Number && a_value is Number )
			{
				if( this.getValue() > a_value )
					compareResult = RMCompare.LARGE;
				if( this.getValue() < a_value )
					compareResult = RMCompare.LESS;
			}
			
			return compareResult;
		}
		/*
		 * 存在數據
		 */
		public function Has( a_referenceData : IRMObject ) : Boolean	
		{
			for( var i : Number = 0 ; i < this.m_referenceObjects.length ; i ++ )
			{
				if( this.m_referenceObjects[i] == a_referenceData )
					return true;
			}
			return false;
		}
		/*
		 * 內容列表，以矩陣輸出。
		 * Output data list in searcher.
		 */
		public function toArray( a_output : Array ) : void
		{
			for( var i : Number = 0 ; i < this.m_referenceObjects.length ; i++ )
			{
				a_output.push( this.m_referenceObjects[i] );
			}
		}
		/**public event function：公開事件函數*/
		/**public get/set function：變數存取介面*/
		/**write only：唯寫*/
		/*read only：唯讀*/
		/*
		 * [唯讀]，取得關聯物件群
		 * Get reference data object.
		 */
		public function getReference() : Array
		{
			return this.m_referenceObjects;
		}
		/*read/write：讀寫*/
		/*
		 * [讀寫]，設定最大儲存量
		 * max store amount of reference data.
		 */
		public function getMaxSize() : Number
		{
			return this.m_maxSize;
		}
		public function setMaxSize( a_maxSize : Number ) : void
		{
			this.m_maxSize = a_maxSize;
		}
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		/**javascript const variable：JavaScript 常數變數*/
    }
}