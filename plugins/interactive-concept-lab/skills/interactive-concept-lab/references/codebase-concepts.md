# Concepts from the codebase

The learner is working in this code and needs a model they can trust when it disagrees with their own mental model. So the lab's model is a **port** of the real code, not an illustration of it.

## Read the source first

- Find the entry points (class, functions, docs next to the code such as `Ghosting.md`). In a repo with a knowledge graph or wiki, go through it first as that repo's instructions say.
- Trace one complete run of the mechanism end to end: who calls it, what state it reads and writes, when it finishes, how it is undone.
- Note every branch and flag that changes the outcome. These become the lab's controls.

**Done when** you can list the mechanism's inputs, its state, its outputs, and every `file:line` the port is based on.

## Port it

- Keep the real names for classes, methods, and flags (`CGhostModifier.Modify`, `RestoreOriginals`) so the learner can jump between the lab and the code.
- Comment each ported function with the source `file:line` it mirrors.
- Simplify the surroundings (engine, document model, UI) and keep the mechanism exact. List each simplification in `CONCEPT.md`.

## Ablation switches

Give the learner a switch for each piece of the mechanism that turns it off ("no restore before re-apply", "ignore copy flag"). Turning a piece off and watching what breaks shows why the piece exists, which is usually the question the learner is really asking. Every switch has a test that asserts what breaks.

## Trace view

Show the sequence of calls and state changes for the current gesture (a log or timeline the learner can step through), with each entry linked to its source location. It answers "what happened, and in which order".

## Reference implementation

`~/GitProjects/ghosting-explorer/` is a lab of this kind: `src/ghost.ts` ports `CGhostModifier` with switches that turn off each piece, `src/sim.ts` simulates gestures and undo, `src/gl.ts` is an instanced WebGL2 renderer, and `scripts/check.ts` runs headless behaviour checks.
