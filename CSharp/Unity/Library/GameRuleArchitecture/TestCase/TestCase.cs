using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GameRuleArchitecture.TestCase
{
    public class TestCase
    {
        #region Member variable
        private string mResult;
        #endregion

        #region Accessors
        public string Result
        {
            get { return this.mResult; }
            set { this.mResult = value; }
        }
        #endregion
    }
}
