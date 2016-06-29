using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using UnityEngine;

namespace Game.Framework.View.Utility
{
    class SpriteUtility
    {
        // Retrieve sprite pixels size.
        // Reference : http://answers.unity3d.com/questions/1042119/getting-a-sprites-size-in-pixels.html
        public static Vector2 GetPixelsSize(SpriteRenderer _spriteRenderer)
        {
            // 0. Initial variable 
            Vector3 pixelsSize;

            // 
            if (_spriteRenderer.sprite != null)
            {
                // 1. Retrieve sprite size and transform to world size.
                //     a. The sprite size is image, make pixel transform to unit.
                //     b. Consider scale make sprite change size. 

                Vector2 originSize = _spriteRenderer.sprite.rect.size;
                Vector2 localSize = originSize / _spriteRenderer.sprite.pixelsPerUnit;
                Vector3 worldSize = localSize;
                worldSize.x *= _spriteRenderer.gameObject.transform.localScale.x;
                worldSize.y *= _spriteRenderer.gameObject.transform.localScale.y;

                // 2. Convert to screen space size.
                //     a. orthorraphicSize is 1/2 screen height.
                Vector3 screenSize = 0.5f * worldSize / Camera.main.orthographicSize;
                screenSize.y *= Camera.main.aspect;

                // 3. Size in pixels
                pixelsSize = new Vector3(screenSize.x * Camera.main.pixelWidth, screenSize.y * Camera.main.pixelHeight, 0) * 0.5f;

                //Debug.Log(string.Format("World size: {0}, Screen size: {1}, Pixel size: {2}", worldSize, screenSize, pixelsSize));
            }
            else
            { 
                // No sprite in renderer. 
                pixelsSize = new Vector3();
            }
            return pixelsSize;
        }
    }
}
