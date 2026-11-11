# Learning design

## Progression

1. **Engage**: open on a question or a surprising result the learner cannot yet explain ("why does the copy reappear when you release?"). Two sentences at most.
2. **Build intuition**: the smallest scene that shows the mechanism, with most controls hidden.
3. **Explore**: unlock the controls. Each one changes a named model variable, and the effect is visible at once.
4. **Predict**: before selected experiments, the learner commits to a prediction (multiple choice, or placing a marker in the view). Then the lab runs the experiment and shows prediction and outcome together.
5. **Explain**: tie what happened to the mechanism, quoting the live state. Address the misconception the wrong answers point to.
6. **Apply**: a transfer task in a scenario the lab has not shown, checked by the model.

Unlock stages progressively. Let the learner jump back to any earlier stage.

## Principles, and what each looks like in the lab

| Principle | In the lab |
|---|---|
| Cognitive load | One new idea per stage. Hide controls until they are needed |
| Prediction | Commit before reveal, every time the outcome is not obvious |
| Immediate, specific feedback | Explain *why* each wrong option is wrong, using the model |
| Retrieval | Later challenges ask about earlier stages without showing their answer |
| Dual coding | The sentence and the highlighted visual element change together |
| Scaffolding | Early challenges give hints; later ones give none |
| Metacognition | After each stage: "what would you check in the code to confirm this?" |
| Transfer | At least one challenge outside the lab's examples |

## Challenge design

- Generate the correct answer from the model, never hard-code it, so answers and simulation cannot disagree.
- Wrong options are real misconceptions from `CONCEPT.md`, not filler.
- Optional gate: a later section (a findings page, an advanced mode) unlocks only once the challenges are all correct. Use it when the user asks to prove their understanding.
