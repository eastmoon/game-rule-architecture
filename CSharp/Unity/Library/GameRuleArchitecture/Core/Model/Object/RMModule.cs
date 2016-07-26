using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using GameRuleArchitecture.Interfaces;

namespace GameRuleArchitecture.Core.Model
{
    public class RMModule : RMNofityDispatcher, IRMModule
    {
        #region Member variable
        #endregion

        #region Constructor
        public RMModule(string _name = "", IRMModule _module = null)
        {
            this.RegisterInfo(_name, _module);
        }
        #endregion
        #region Public Method

        #region System command
        /**
     	 * <P>Initial all <code>IRMSpace</code> in <code>IRMModule</code>.</P>
      	 */
        public virtual void Initial(object _params = null)
        {

        }
        /**
         * <P>Update all <code>IRMSpace</code> in <code>IRMModule</code>.</P>
         */
        public virtual void Update(string _targetName = "", object _params = null)
        {

        }
        /**
         * <P>Draw all <code>IRMSpace</code> in <code>IRMModule</code>.</P>
         */
        public virtual void Draw(string _targetName = "", object _params = null)
        {

        }
        /**
         * <P>Enabled all <code>IRMSpace</code> in <code>IRMModule</code>.</P>
         */
        public virtual void Enabled(string _targetName = "", bool _isEnabled = true)
        {

        }
        #endregion

        #endregion
    }
}
