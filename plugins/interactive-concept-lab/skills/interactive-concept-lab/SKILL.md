---
name: interactive-concept-lab
description: Builds a runnable React + WebGL app that teaches one concept through experiments the learner runs. Use when the user asks for an interactive app, simulation, explorer, or playground to understand a concept, either a mechanism in the codebase they are working in or a general topic.
---

# Interactive Concept Lab

The deliverable is a **lab**, not a page: a small app where the learner tweaks the inputs to a faithful model of the concept, tries things, and watches what happens, with a guide suggesting experiments and explaining each result. It works like a PhET simulation (experiments first, visuals serving them), not like a museum installation or a quiz. The lab asks no questions and has no right or wrong answers. Every control, view, and animation earns its place by serving a learning objective.

A lab has three separate parts:

1. **Model**: plain TypeScript with no React or WebGL imports. Deterministic, resettable, testable headless. It is the single source of truth for behaviour.
2. **Views**: render the model's state. WebGL wherever it carries information (many objects, space, time, fields). Ordinary DOM for text and controls.
3. **Learning layer**: objectives, guided "try this" experiments, presets, explanations tied to what is on screen, and callouts for notable states the learner reaches on their own.

## Steps

### 1. Pin down the concept

If the concept lives in the current codebase, read [references/codebase-concepts.md](references/codebase-concepts.md) now and follow it. The model then comes from the real source, not from memory.

Write `CONCEPT.md` in the new project with:

- 3–5 learning objectives, each phrased as something the learner can *do* in the lab ("make a ghosted snippet land in another lane with a copy-drag").
- The misconceptions the lab must break, and the experiment or preset that breaks each one.
- The notable states worth pointing out when the learner reaches them (edge cases, thresholds), each with how the model detects it.
- The variables the learner can change, and the observables they will watch.
- Every simplification of the model, each with one line on why it does not mislead.

**Done when** each objective names the guided experiment that exercises it.

### 2. Design the experiments and the views

Read [references/visualization-patterns.md](references/visualization-patterns.md) and pick the representation from the concept's structure. Read [references/learning-design.md](references/learning-design.md) and lay out the progression: hook → first tweak → guided experiments → free play → push it.

Sketch the screen in `CONCEPT.md`: the main view, the controls, the guide panel, the presets, and the explanation panel.

**Done when** every control maps to a named model variable and every objective has at least one guided experiment.

### 3. Build the model and prove it

Scaffold a sibling project: `~/GitProjects/<slug>-explorer/` by default, never inside the repo being explained. Use Vite + React + TypeScript and give the dev server a fixed port with `strictPort: true`. The user runs it with `npm install && npm run dev`, so a bare `index.html` is not a deliverable.

Write the model in `src/model/` and its tests (Vitest) before any view. The tests pin the behaviour the guide and callouts will point out: if a guided step says "the snippet snaps back", a test asserts it, and every notable-state predicate has a test that reaches it.

**Done when** `npm test` is green and every result the guide explains is asserted by a test.

### 4. Build the views and the learning layer

Default stack:

- WebGL: Three.js through React Three Fiber + Drei for 3D or spatial scenes; raw WebGL2 with instancing for dense 2D (timelines, grids, thousands of elements), as `ghosting-explorer/src/gl.ts` does.
- State: Zustand (or a small store) holding the model instance. Views subscribe and never mutate the model directly.
- Styling: plain CSS or Tailwind, whichever is quicker.

Add a dependency only when it removes real work. Give each view a WebGL-unavailable fallback message, keyboard-reachable controls with labels, and `prefers-reduced-motion` support.

Explanations quote the live state ("lane 2 now has 3 ghost snippets because…"), not static prose.

**Done when** every objective from step 1 can be exercised in the running app.

### 5. Verify

Run `scripts/validate-project.sh <project-dir>` from this skill's folder. It installs, type-checks, tests, and builds.

Then smoke-test the dev server. A Vite server started from a background shell exits when stdin closes, so start it as `tail -f /dev/null | npx vite`. Confirm the page returns 200 and the main modules load.

**Done when** the script passes and the dev server serves the app. Report any failure with its output.

### 6. Hand over

Write a short `README.md`: what the lab models (with source links when it comes from code), how to run it, the file map, and the simplifications. Tell the user the URL, the objectives, and one experiment to try first.
