/*
	Info:
		- Base view behaviour in Unity system.
        - BaseViewBehaviour is inheritance MonoBehaviour, Make object could insert in Unity.GameObject.
        - BaseViewBehaviour is implement PureMVC.mediator interface, Make object could put into PureMVC architecture.
	
    Date:
		- 2016.07.25
		
	Author:
		- Name : Jacky Chen 
		- Nickname : EastMoon
		- Email : jacky_eastmoon@hotmail.com
		
 	Copyright (c) 2016 Jacky Chen
 	Your reuse is governed by the Creative Commons Attribution 3.0 License
*/

using UnityEngine;

using System;
using System.Collections;
using System.Collections.Generic;

using PureMVC.Interfaces;
using PureMVC.Patterns;
using GameRuleArchitecture.Interfaces;
using GameRuleArchitecture.Patterns;

public class BaseViewBehaviour : MonoBehaviour, ISubjectMediator
{
    #region Const variable
    public const string INITIAL = "BaseViewBehaviour.Initial";
    #endregion

    #region Member variable
    private ISubjectMediator mMediator;
    #endregion

    #region Constructor
    public BaseViewBehaviour(string _name = "")
    {
        // 1. Initial PureMVC.Mediator
        this.mMediator = new SubjectMediator(_name, this);
        // 2. Initial Notification
        this.InitialNotification();
        // 3. Register Mediator
        this.Facade.RegisterMediator(this);
    }
    #endregion

    #region IMediator

    #region Accessors
    /// <summary>
    /// Tthe <c>IMediator</c> instance name
    /// </summary>
    public string MediatorName {
        get { return this.mMediator.MediatorName;  }
    }

    /// <summary>
    /// The <c>IMediator</c>'s view component
    /// </summary>
    public object ViewComponent {
        get { return this.mMediator.ViewComponent;  }
        set { this.mMediator.ViewComponent = value; }
    }
    #endregion

    #region Public method
    /// <summary>
    /// List <c>INotification interests</c>
    /// </summary>
    /// <returns>An <c>IList</c> of the <c>INotification</c> names this <c>IMediator</c> has an interest in</returns>
    public IList<string> ListNotificationInterests()
    {
        // Execute mediator function ListNotificationInterests.
        return this.mMediator.ListNotificationInterests();
    }

    /// <summary>
    /// Handle an <c>INotification</c>
    /// </summary>
    /// <param name="notification">The <c>INotification</c> to be handled</param>
    public void HandleNotification(INotification _notification)
    {
        // Execute mediator function HandleNotification.
        this.mMediator.HandleNotification(_notification);
    }

    /// <summary>
    /// Called by the View when the Mediator is registered
    /// </summary>
    public virtual void OnRegister()
    {
        // Execute mediator function OnRegister.
        this.mMediator.OnRegister();
    }

    /// <summary>
    /// Called by the View when the Mediator is removed
    /// </summary>
    public virtual void OnRemove()
    {
        // Execute mediator function OnRemove.
        this.mMediator.OnRemove();
    }
    #endregion

    #endregion

    #region ISubjectMediator

    /// <summary>
    /// <P>[Read-only] Get subject container.</P>
    /// </summary>
    public ISubjectContainer Container { get { return this.mMediator.Container; } }

    #region Public method

    /// <summary>
    /// Register Subject in container.
    /// </summary>
    public bool RegisterSubject(string _name, Action<INotification> _method)
    {
        return this.mMediator.RegisterSubject(_name, _method);
    }

    /// <summary>
    /// Remove Subject in container.
    /// </summary>
    public bool RemoveSubject(string _name)
    {
        return this.mMediator.RemoveSubject(_name);
    }

    #endregion

    #endregion

    #region Public method
    public virtual void InitialNotification()
    {

    }
    #endregion

    #region Accessors
    /// <summary>
    /// <P>[Read-only] Get Mediator.</P>
    /// </summary>
    public ISubjectMediator Mediator { get { return this.mMediator; } }

    /// <summary>
    /// <P>[Read-only] Get Mediator.</P>
    /// </summary>
    public Facade Facade { get { return GameRuleArchitecture.ApplicationFacade.getInstance(); } }
    #endregion

    #region Unity Behaviour
    #endregion
}
