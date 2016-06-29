using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using UnityEngine;
using UnityEngine.UI;

namespace Game.Framework.View.Utility
{
    class CanvasUtility
    {
        // Retrieve sprite pixels size.
        // Reference : http://k79k06k02k.com/blog/24/unity/unity-ugui-%E5%8E%9F%E7%90%86%E7%AF%87%E4%BA%8C%EF%BC%9Acanvas-scaler-%E7%B8%AE%E6%94%BE%E6%A0%B8%E5%BF%83
        public static Vector2 GetCanvasScalerResolution(CanvasScaler _canvasScaler)
        {
            // 0. Initial variable 
            Vector2 screenSize = Camera.main.pixelRect.size;
            Vector2 referenceResolution = _canvasScaler.referenceResolution;

            // 1. Calculate scale factor
            float logWidth = Mathf.Log(screenSize.x / referenceResolution.x, 2);
            float logHeight = Mathf.Log(screenSize.y / referenceResolution.y, 2);
            float logWeightedAverage = Mathf.Lerp(logWidth, logHeight, _canvasScaler.matchWidthOrHeight);
            float scaleFactor = Mathf.Pow(2, logWeightedAverage);

            // 2. Canvas resolution is scale-down screen resolution.
            Vector2 resolution = screenSize / scaleFactor;

            // 3. Return resolution
            return resolution;
        }
    }
}
