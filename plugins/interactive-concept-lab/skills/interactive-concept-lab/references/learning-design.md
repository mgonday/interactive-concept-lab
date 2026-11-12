# Learning design

The learner learns by tweaking, trying, and testing, not by answering questions. The lab has no quizzes, no multiple choice, no right or wrong answers, no score, and no gates. Instead, a guide suggests experiments, and the lab explains what happened after each one.

## Progression

1. **Hook**: open on a live scene that is already doing something interesting, plus one line on what to look at ("watch the copy reappear when you release"). Two sentences at most.
2. **First tweak**: the smallest scene that shows the mechanism, with one control and a "try this" prompt for it.
3. **Guided experiments**: a short sequence of steps. Each step names one control, suggests what to do with it ("drag the offset past the lane edge"), highlights the part of the view that responds, and explains the result using the live state once the learner has tried it. Each step introduces one more control.
4. **Free play**: all controls unlocked, plus presets and the knockout switches. The guide stays available as a side panel but never blocks anything.
5. **Push it**: an open "can you make it…?" goal ("can you make two ghosts overlap?"). The model detects when the learner gets there and explains how it happened. There is no failure state, only the live explanation of what the learner did instead.

The learner can skip the guide, jump to any step, or leave it at any time. Every step is optional.

## Principles, and what each looks like in the lab

| Principle | In the lab |
|---|---|
| Cognitive load | One new control per guided step. Hide the rest until free play |
| Learning by doing | Every explanation follows an action the learner took, never precedes it |
| Immediate, specific feedback | The view responds at once to every change, and the explanation names the variable that caused it |
| Contrast | Compare mode: a ghost of the previous run, a before/after split, or two configurations side by side |
| Dual coding | The sentence and the highlighted visual element change together |
| Breaking misconceptions | A preset or guided step that sets up the case where the misconception fails, so the learner sees it fail |
| Safe failure | Undo, reset, and replay or step through time are always one click away, so breaking things costs nothing |
| Curiosity | "Noticed" callouts: when the learner reaches a notable state on their own, the lab points it out and explains it |

## Guided step design

- A step has: the control it introduces, a "try this" prompt, the view element to highlight, and an explanation template filled from the live model state.
- Steps describe actions, not questions. Write "Drag the offset to 3 and watch lane 2", not "What happens to lane 2 at offset 3?"
- A step counts as done when the learner has used its control, not when they get something right. Mark it done quietly and offer the next step.
- Generate every explanation from the model, never as static prose, so the explanation and the simulation cannot disagree.

## Notable states

- List in `CONCEPT.md` the states worth pointing out (edge cases, thresholds, the moment a misconception breaks).
- Each one has a model predicate that detects it and a callout that explains it using the live state.
- Show each callout the first time it happens, keep it in a "discoveries" log the learner can reread, and never interrupt an interaction in progress to show it.
