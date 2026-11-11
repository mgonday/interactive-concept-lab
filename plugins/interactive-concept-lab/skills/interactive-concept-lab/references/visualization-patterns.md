# Choosing the representation

Pick the simplest representation that keeps the concept's structure visible. A dimension the concept does not have is noise: use 3D only for real space, or for a third variable the learner must see at the same time as the other two.

| Concept structure | Representation | The learner's experiment |
|---|---|---|
| Cause and effect | Live simulation | Change a cause, watch the effect |
| Spatial relations | 3D model | Rotate, inspect, move parts |
| Algorithm / state machine | Execution view with highlighted state | Step forwards and backwards, set breakpoints |
| Data on a timeline (sequencer, events, scheduling) | 2D timeline with lanes | Drag, scrub, compare before/after |
| Function of 1–2 parameters | Graph or surface | Move parameters, see the curve or surface change |
| Probability | Repeated trials and a histogram | Run N trials, compare with the prediction |
| Network / dependency graph | Node-edge view | Add or cut edges, watch the propagation |
| Concurrency (threads, queues, locks) | Swimlanes per thread with shared state between them | Change the interleaving, find the race |
| Ownership / lifetime | Object graph with references and lifetimes | Drop a reference, watch what is freed |

## Comparison views

Many concepts are understood through a difference: before vs after, on vs off, expected vs actual. Show both side by side or as an overlay, so the learner does not have to remember one state while looking at the other.

## When WebGL earns its place

- Hundreds or more elements updating per frame: instanced quads in WebGL2.
- Real 3D, fields, surfaces, particles: Three.js / React Three Fiber.
- Smooth scrubbing through time over a large state.

Text, labels, tooltips and controls stay in the DOM, layered over the canvas.

## Motion

Animate transitions between states so the learner can see what moved and where it came from. Under `prefers-reduced-motion`, switch to instant changes with a highlight on what changed.
