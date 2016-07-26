using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using PureMVC.Interfaces;
using PureMVC.Patterns;
using GameRuleArchitecture.Interfaces;
using GameRuleArchitecture.Patterns;

namespace GameRuleArchitecture.Core.Controller.Filters
{
    class ObserverFilter : Filter
    {
        #region Member variable
        private IObserver mObserver;
        #endregion

        #region Constructor
        public ObserverFilter(string _name, Action<INotification> _action) : base(_name)
        {
            this.mObserver = new CommonObserver(_action.Method.Name, _action.Target);
        }
        #endregion

        #region Public Methods

        #region ICommand Members

        /// <summary>
        /// Execute this <c>ObserverFilter</c>
        /// </summary>
        public override void Execute(INotification _notification)
        {
            this.mObserver.NotifyObserver(_notification);
        }

        #endregion

        #endregion
    }
}
