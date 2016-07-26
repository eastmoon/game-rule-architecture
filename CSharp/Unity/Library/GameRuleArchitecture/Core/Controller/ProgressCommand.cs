using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using PureMVC.Interfaces;
using PureMVC.Patterns;
using GameRuleArchitecture.Interfaces;
using GameRuleArchitecture.Patterns;

namespace GameRuleArchitecture.Core.Controller
{
    public class ProgressCommand : SimpleCommand
    {
        #region Member variable
        private IPipe mPipe;
        #endregion

        #region Constructor
        public ProgressCommand()
        {
            this.mPipe = new Pipe();
            this.InitializeProgressCommand();
        }
        #endregion

        #region Public Methods

        #region ICommand Members

        /// <summary>
        /// Execute this <c>ProgressCommand</c>'s <i>Filter</i>
        /// </summary>
        /// <param name="notification">The <c>INotification</c> object to be passsed to each <i>Filter</i></param>
        /// <remarks>
        ///     <para>The <i>Filter</i> will be called in First In/First Out (FIFO) order</para>
        /// </remarks>
        public override void Execute(INotification _notification)
        {
            // 1. Check notification have IProgress interface
            IProgress progress = _notification as IProgress;
            if(progress == null)
            {
                // 2. Notification didn't have IProgress interface, create new progress.
                progress = new Progress(_notification.Name, _notification.Body);
            }
            // 3. Execute pipe by progress.
            this.mPipe.Execute(progress);
        }

        #endregion

        #region Progress Command
        /// <summary>
        /// Add a <i>Filter</i>
        /// </summary>
        /// <param name="commandType">A a reference to the <c>Type</c> of the <c>IFilter</c></param>
        /// <remarks>
        ///     <para>The <i>SubCommands</i> will be called in First In/First Out (FIFO) order</para>
        /// </remarks>
        public ProgressCommand AddFilter(IFilter _filter)
        {
            this.mPipe.Register(_filter);
            return this;
        }
        #endregion

        #endregion

        #region Protected & Internal Methods

        /// <summary>
        /// Initialize the <c>ProgressCommand</c>
        /// </summary>
        /// <remarks>
        ///     <para>In your subclass, override this method to initialize the <c>ProgressoCommand</c>'s <i>Filter</i> list with <c>IFilter</c> class references like this:</para>
        ///     <example>
        ///         <code>
        ///             // Initialize MyMacroCommand
        ///             protected override InitializeProgressCommand( )
        ///             {
        ///                 AddFilter( com.me.myapp.controller.filters.FirstFilter );
        ///                 AddFilter( com.me.myapp.controller.filters.SecondFilter );
        ///                 AddFilter( com.me.myapp.controller.filters.ThirdFilter );
        ///             }
        ///         </code>
        ///     </example>
        ///     <para>Note that <i>Filter</i>s may be any <c>IFilter</c> implementor.</para>
        /// </remarks>
        protected virtual void InitializeProgressCommand()
        {
        }

        #endregion
    }
}
