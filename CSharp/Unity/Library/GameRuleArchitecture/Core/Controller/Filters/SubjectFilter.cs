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
    class SubjectFilter : Filter
    {
        #region Member variable
        private ISubject mSubject;
        #endregion

        #region Constructor
        public SubjectFilter(string _name) : base(_name)
        {
            this.mSubject = new Subject(_name);
        }
        #endregion

        #region Public Methods

        #region ICommand Members

        /// <summary>
        /// Execute this <c>ObserverFilter</c>
        /// </summary>
        public override void Execute(INotification _notification)
        {
            this.mSubject.NotifyObserver(_notification);
        }

        #endregion

        #region Subject Filter
        /// <summary>
        /// Add observer
        /// </summary>
        public SubjectFilter AddObserver(Action<INotification> _action)
        {
            this.mSubject.Register(_action);
            return this;
        }
        public SubjectFilter AddObserver(string _method, object _context)
        {
            this.mSubject.Register(_method, _context);
            return this;
        }
        #endregion

        #endregion
    }
}
