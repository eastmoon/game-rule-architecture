using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using UnityEngine;

namespace Game.Framework.View.Builder
{
    interface IViewComponentsBuilder
    {
        // Get method
        String GetComponentID();
        // Setting builder method
        IViewComponentsBuilder SetBuilder(IViewComponentsBuilder _builder);
        IViewComponentsBuilder SetStage(GameObject _stage);
        IViewComponentsBuilder SetTarget(GameObject _target);

        // Build component
        GameObject Build(params object[] _args);
        GameObject Build(String _componentID, params object[] _args);
        GameObject Build(String _componentID, GameObject _stage, params object[] _args);
    }
}
