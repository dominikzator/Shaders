using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VerticalCube : MonoBehaviour
{
    private MeshRenderer meshRenderer;

    private void Awake()
    {
        meshRenderer = GetComponent<MeshRenderer>();
        meshRenderer.material.SetFloat("_Scale", gameObject.transform.localScale.x);
    }

    private void Start()
    {
        //material.SetFloat("_Scale", gameObject.transform.localScale.x);
    }

    private void Update()
    {
        //meshRenderer.material.SetFloat("_Scale", gameObject.transform.localScale.x);
    }
}
