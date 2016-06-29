/*
	Info:
		- Game Rule Architecture kernel code.
		- 
		
	Date:
		- 2013.05.07
		
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
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	/*external import：外部元件庫、開發人員自定元件庫*/
	import org.gra.model.RuleModel.Interface.*;
	import org.gra.model.RuleModel.Interface.Data.IRMNode;
	import org.gra.model.RuleModel.Interface.Data.IRMSearcher;
	import org.gra.model.RuleModel.Core.Data.RMSearcher;
	import org.gra.model.RuleModel.Core.Data.RMNode;
	import org.gra.model.RuleModel.Core.Data.RMCompare;
	 
    /**
     * <P>The base object in Rule Model.</P>
     */
    public class RMDataObject extends RMObject implements IRMDataObject
    {
        /**static const variable : 靜態常數變數*/
		/**const variable：常數變數*/
		/**function variable：函數變數*/
		/**member variable：物件內部操作變數*/
		private var m_attributes : IRMSearcher;
		/**display object variable：顯示物件變數，如MovieClip等*/
		/**constructor：建構值*/
        public function RMDataObject()
		{
			this.m_attributes = new RMSearcher();
			this.m_attributes.setNodeType( new RMNode( null, 1 ) );
        }
		/**public function：對外公開函數*/
		/**
     	 * <P>Clone IRMDataObject itself, reference prototype pattern.</P>
      	 */
		public function Clone() : IRMDataObject
		{
			var classType : Class = getDefinitionByName( getQualifiedClassName( this ) ) as Class;
			return new classType();
		}
		/**
     	 * <P>Parse input object and create <code>IRMData</code>. It should be overridden when the class inherit RMDataObject.</P>
      	 */
		public function Parse( a_object : Object  ) : void
		{
			var attrName : String = "";
			var dataInfo : IRMData = null;
			for( attrName in a_object )
			{
				dataInfo = new RMData( attrName, a_object[attrName] );
				this.RegisterAttribute( dataInfo );
			}
		}
		/**
     	 * <P>Check attributes and values is equal or not.</P>
      	 */
		public function Equal( a_attributeName : String, a_values : Array ) : Boolean
		{
			// 1. find attribure.
			var reference : Array = this.m_attributes.Retrieve( a_attributeName ) as Array;
			var target : IRMData =  ( reference != null && reference.length > 0 ) ? reference[0] as IRMData : null;
			
			if( target != null )
			{
				// 2. check the value is equal.
				for( var i = 0 ; a_values != null && i < a_values.length ; i++ )
				{
					if( target.getValue() == a_values[i] )
						return true;
				}
			}
			return false;
		}
		/**
     	 * <P>Check attributes and values is what compare type.</P>
      	 */
		public function Compare( a_attributeName : String, a_value : Object ) : Number
		{			
			// 1. find attribure.
			var reference : Array = this.m_attributes.Retrieve( a_attributeName ) as Array;
			var target : IRMData =  ( reference != null && reference.length > 0 ) ? reference[0] as IRMData : null;
			
			if( target != null )
			{
				// 2. compare value
				if( target.getValue() == a_value )
					return RMCompare.EQUAL;
				else if( target.getValue() > a_value )
					return RMCompare.LARGE;
				else if( target.getValue() < a_value )
					return RMCompare.LESS;
			}
			
			return RMCompare.UNKNOWEN;
		}
		/**
     	 * <P>Register a <code>IRMData</code> in IRMDataObject. The <code>IRMData</code> register will change attributes index.</P>
      	 */
		public function RegisterAttribute( a_type : IRMData ) : void
		{
			// 相同attribute，後者優於前者
			//this.m_attributes.push( a_type );
			this.m_attributes.Insert( a_type.getName(), a_type );
		}
		/**
     	 * <P>Remove a <code>IRMData</code> in IRMDataObject. The <code>IRMData</code> register will change attributes index.</P>
      	 */
		public function RemoveAttribute( a_name : String ) : IRMData
		{
			var node : IRMNode = this.m_attributes.Remove( a_name );
			var target : IRMData = ( node != null ) ? (node.getReference()[0] as IRMData) : null;
			return target;
		}
		/**public event function：公開事件函數*/
		/**public get/set function：變數存取介面*/
		/**write only：唯寫*/
		/**read only：唯讀*/
		/**
     	 * <P>Get IRMDataObject attribute array that <code>IRMDataTable</code> could make filter index.</P>
      	 */
		public function getAttributeIndex() : Array
		{
			return this.m_attributes.toArray();
		}
		
		/**
     	 * <P>Get attribute value by input attribute name.</P>
      	 */
		public function getValue( a_name : String ) : Object
		{
			var reference : Array = this.m_attributes.Retrieve( a_name ) as Array;
			var target : IRMData =  ( reference != null && reference.length > 0 ) ? reference[0] as IRMData : null;
			if( target != null )
				return target.getValue();
			return null;
		}
		/**read/write：讀寫*/
		/**private function：私用函數*/
		/**private event function：私用事件函數*/
		/**javascript const variable：JavaScript 常數變數*/
    }
}