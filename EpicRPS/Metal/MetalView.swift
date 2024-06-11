//
//  MetalView.swift
//

import SwiftUI
import MetalKit

struct MetalView: UIViewRepresentable {
    class Coordinator: NSObject, MTKViewDelegate {
        var parent: MetalView
        var device: MTLDevice!
        var commandQueue: MTLCommandQueue!
        var pipelineState: MTLRenderPipelineState!
        var startTime: CFAbsoluteTime!
        
        struct Uniforms {
            var time: Float
            var resolution: SIMD2<Float>
        }
        
        init(_ parent: MetalView) {
            self.parent = parent
            super.init()
            self.device = MTLCreateSystemDefaultDevice()
            self.commandQueue = device.makeCommandQueue()
            self.startTime = CFAbsoluteTimeGetCurrent()
            self.setupPipeline()
        }
        
        func setupPipeline() {
            guard let device = device else { return }
            let library = device.makeDefaultLibrary()
            let vertexFunction = library?.makeFunction(name: "vertex_main")
            let fragmentFunction = library?.makeFunction(name: "fragment_main")
            
            let vertexDescriptor = MTLVertexDescriptor()
            vertexDescriptor.attributes[0].format = .float4
            vertexDescriptor.attributes[0].offset = 0
            vertexDescriptor.attributes[0].bufferIndex = 0
            vertexDescriptor.attributes[1].format = .float2
            vertexDescriptor.attributes[1].offset = MemoryLayout<Float>.size * 4
            vertexDescriptor.attributes[1].bufferIndex = 0
            vertexDescriptor.layouts[0].stride = MemoryLayout<Float>.size * 6
            vertexDescriptor.layouts[0].stepFunction = .perVertex
            
            let pipelineDescriptor = MTLRenderPipelineDescriptor()
            pipelineDescriptor.vertexFunction = vertexFunction
            pipelineDescriptor.fragmentFunction = fragmentFunction
            pipelineDescriptor.vertexDescriptor = vertexDescriptor
            pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
            
            do {
                pipelineState = try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
            } catch let error {
                fatalError("Failed to create pipeline state: \(error)")
            }
        }
        
        func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        }
        
        func draw(in view: MTKView) {
            guard let drawable = view.currentDrawable,
                  let descriptor = view.currentRenderPassDescriptor else { return }
            
            let currentTime = Float(CFAbsoluteTimeGetCurrent() - startTime)
            let resolution = SIMD2<Float>(Float(view.drawableSize.width), Float(view.drawableSize.height))
            var uniforms = Uniforms(time: currentTime, resolution: resolution)
            
            let commandBuffer = commandQueue.makeCommandBuffer()!
            let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: descriptor)!
            renderEncoder.setRenderPipelineState(pipelineState)
            
            let vertexData: [Float] = [
                -1, -1, 0, 0, 1,
                1, -1, 0, 1, 1,
                -1, 1, 0, 0, 0,
                1, 1, 0, 1, 0
            ]
            
            renderEncoder.setVertexBytes(vertexData, length: vertexData.count * MemoryLayout<Float>.size, index: 0)
            renderEncoder.setFragmentBytes(&uniforms, length: MemoryLayout<Uniforms>.size, index: 1)
            renderEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 4)
            renderEncoder.endEncoding()
            
            commandBuffer.present(drawable)
            commandBuffer.commit()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MTKView {
        let mtkView = MTKView()
        mtkView.device = context.coordinator.device
        mtkView.delegate = context.coordinator
        mtkView.preferredFramesPerSecond = 60
        return mtkView
    }
    
    func updateUIView(_ uiView: MTKView, context: Context) {
    }
}
