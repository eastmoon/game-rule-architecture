using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GameRuleArchitecture.Interfaces
{
    public interface IRMModule
    {
        #region Public Method

        #region System command
        /**
     	 * <P>Initial all <code>IRMSpace</code> in <code>IRMModule</code>.</P>
      	 */
        void Initial(object _params = null);
        /**
         * <P>Update all <code>IRMSpace</code> in <code>IRMModule</code>.</P>
         */
        void Update(string _targetName = "", object _params = null);
        /**
         * <P>Draw all <code>IRMSpace</code> in <code>IRMModule</code>.</P>
         */
        void Draw(string _targetName = "", object _params = null);
        /**
         * <P>Enabled all <code>IRMSpace</code> in <code>IRMModule</code>.</P>
         */
        void Enabled(string _targetName = "", bool _isEnabled = true);
        #endregion

        #endregion
    }
}
