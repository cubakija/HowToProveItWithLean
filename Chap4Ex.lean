import HTPILib.Chap4
namespace HTPI.Exercises

/- Section 4.2 -/
-- 1.
theorem Exercise_4_2_9a {A B C : Type} (R : Set (A × B))
    (S : Set (B × C)) : Dom (comp S R) ⊆ Dom R := by
  define
  fix a : A
  assume h1 : a ∈ Dom (comp S R)
  define at h1
  obtain (c : C) (h2 : (a, c) ∈ comp S R) from h1
  define at h2
  obtain (b : B) (h3 : (a, b) ∈ R ∧ (b, c) ∈ S) from h2
  define
  apply Exists.intro b
  exact h3.left
  done

-- 2.
theorem Exercise_4_2_9b {A B C : Type} (R : Set (A × B))
    (S : Set (B × C)) : Ran R ⊆ Dom S → Dom (comp S R) = Dom R := by
  assume h1 : Ran R ⊆ Dom S
  ext a
  apply Iff.intro
  · assume h2 : a ∈ Dom (comp S R)
    define at h2; obtain (c : C) (h3 : (a, c) ∈ comp S R) from h2
    define at h3; obtain (b : B) (h4 : (a, b) ∈ R ∧ (b, c) ∈ S) from h3
    define
    apply Exists.intro b
    exact h4.left
  · assume h2 : a ∈ Dom R
    define at h2
    obtain (b : B) (h3 : (a, b) ∈ R) from h2
    define at h1
    have h4 : b ∈ Ran R := by
      define; apply Exists.intro a; exact h3
    have h5 : b ∈ Dom S := h1 h4
    define at h5
    obtain (c : C) (h6 : (b, c) ∈ S) from h5
    define
    apply Exists.intro c
    define
    apply Exists.intro b
    exact And.intro h3 h6
  done

-- 3.
--Fill in the blank to get a correct theorem and then prove the theorem
theorem Exercise_4_2_9c {A B C : Type} (R : Set (A × B))
    (S : Set (B × C)) : Ran R = Dom S → Ran (comp S R) = Ran S := by
  assume h1 : Ran R = Dom S
  ext c
  apply Iff.intro
  · assume h2 : c ∈ Ran (comp S R)
    define at h2
    obtain (a : A) (h3 : (a, c) ∈ comp S R) from h2
    define at h3
    obtain (b : B) (h4 : (a, b) ∈ R ∧ (b, c) ∈ S) from h3
    define
    apply Exists.intro b
    exact h4.right
  · assume h2 : c ∈ Ran S
    define at h2
    obtain (b : B) (h3 : (b, c) ∈ S) from h2
    have h4 : b ∈ Dom S := by
      define; apply Exists.intro c; exact h3
    rw [← h1] at h4
    define at h4
    obtain (a : A) (h5 : (a, b) ∈ R) from h4
    define
    apply Exists.intro a
    define
    apply Exists.intro b
    exact And.intro h5 h3
  done

-- 4.
theorem Exercise_4_2_12a {A B C : Type}
    (R : Set (A × B)) (S T : Set (B × C)) :
    (comp S R) \ (comp T R) ⊆ comp (S \ T) R := by
  define; fix (a, c); assume h1 : (a, c) ∈ comp S R \ comp T R
  define at h1
  have h2 : (a, c) ∈ comp S R := h1.left
  have h3 : ¬(a, c) ∈ comp T R := h1.right
  define at h2
  obtain (b : B) (h4 : (a, b) ∈ R ∧ (b, c) ∈ S) from h2
  define at h3
  quant_neg at h3
  have h5 : ¬((a, b) ∈ R ∧ (b, c) ∈ T) := h3 b
  demorgan at h5
  disj_syll h5 h4.left
  define
  apply Exists.intro b
  exact And.intro h4.left (And.intro h4.right h5)
  done

-- 5.
--You won't be able to complete this proof
theorem Exercise_4_2_12b {A B C : Type}
    (R : Set (A × B)) (S T : Set (B × C)) :
    comp (S \ T) R ⊆ (comp S R) \ (comp T R) := by
  define
  fix (a, c)
  assume h1 : (a, c) ∈ comp (S \ T) R
  define at h1
  obtain (b : B) (h2 : (a, b) ∈ R ∧ (b, c) ∈ S \ T) from h1
  have h3 : (a, b) ∈ R := h2.left
  have h4 : (b, c) ∈ S \ T := h2.right
  have h5 : (b, c) ∈ S := h4.left
  have h6 : (a, c) ∈ comp S R := by
    define
    apply Exists.intro b; exact And.intro h3 h5
  have h7 : ¬(a, c) ∈ comp T R := by
    define
    quant_neg
    fix b'
    demorgan
    sorry
  sorry
  -- The mistake in the proof is that knowing that `(b, c) ∉ T` is not
  -- enough to show that `(a, c) ∉ T ∘ R`. There could be a different `b' : B`
  -- verifying that property.

-- 6.
-- This result is false, although one of the directions is true. We change it
-- and prove it.
theorem Exercise_4_2_14c {A B C : Type}
    (R : Set (A × B)) (S T : Set (B × C)) :
    comp (S ∩ T) R ⊆ (comp S R) ∩ (comp T R) := by
  define; fix (a, c); assume h1 : (a, c) ∈ comp (S ∩ T) R
  define at h1
  obtain (b : B) (h2 : (a, b) ∈ R ∧ (b, c) ∈ S ∩ T) from h1
  apply And.intro
  · define
    apply Exists.intro b
    exact And.intro h2.left h2.right.left
  · define
    apply Exists.intro b
    exact And.intro h2.left h2.right.right
  done
/-
To show that the other direction is false, have:
`R = {(a, b₁), (a, b₂)}`
`S = {(b₁, c)}`
`T = {(b₂,c)}`
Then `S ∩ T = ∅`, so `(S ∩ T) ∘ R = ∅`. However, `(a, c) ∈ S ∘ R` using
`b₁` as witness, and `(a, c) ∈ T ∘ R` using `b₂` as witness.
-/

-- 7.
--You might not be able to complete this proof
theorem Exercise_4_2_14d {A B C : Type}
    (R : Set (A × B)) (S T : Set (B × C)) :
    comp (S ∪ T) R = (comp S R) ∪ (comp T R) := by
  apply Set.ext; fix (a, c)
  apply Iff.intro
  · assume h1 : (a, c) ∈ comp (S ∪ T) R
    define at h1
    obtain (b : B) (h2 : (a, b) ∈ R ∧ (b, c) ∈ S ∪ T) from h1
    have h3 : (b, c) ∈ S ∪ T := h2.right
    by_cases on h3
    · have h4 : (a, c) ∈ comp S R := by
        define; apply Exists.intro b; exact And.intro h2.left h3
      left; exact h4
    · have h4 : (a, c) ∈ comp T R := by
        define; apply Exists.intro b; exact And.intro h2.left h3
      right; exact h4
  · assume h1 : (a, c) ∈ comp S R ∪ comp T R
    by_cases on h1
    · define at h1; obtain (b : B) (h2 : (a, b) ∈ R ∧ (b, c) ∈ S) from h1
      define; apply Exists.intro b
      apply And.intro h2.left; left; exact h2.right
    · define at h1; obtain (b : B) (h2 : (a, b) ∈ R ∧ (b, c) ∈ T) from h1
      define; apply Exists.intro b
      apply And.intro h2.left; right; exact h2.right
  done

/- Section 4.3 -/
-- 1.
example :
    elementhood Int 6 { n : Int | ∃ (k : Int), n = 2 * k } := by
  apply Exists.intro 3
  ring
  done

-- 2.
theorem Theorem_4_3_4_1 {A : Type} (R : BinRel A) :
    reflexive R ↔ { (x, y) : A × A | x = y } ⊆ extension R := by
  apply Iff.intro
  · assume h1 : reflexive R
    define at h1
    define
    fix (a, a'); assume h2 : (a, a') ∈ { (a, a') : A × A | a = a'}
    define at h2
    rw [← h2]
    exact h1 a
  · assume h1 : { (x, y) : A × A | x = y } ⊆ extension R
    define at h1
    define; fix a
    have h2 : (a, a) ∈ { (x, y) : A × A | x = y } := by rfl
    have h3 : (a, a) ∈ extension R := h1 h2
    exact h3
  done

-- 3.
theorem Theorem_4_3_4_3 {A : Type} (R : BinRel A) :
    transitive R ↔
      comp (extension R) (extension R) ⊆ extension R := by
  apply Iff.intro
  · assume h1 : transitive R
    define at h1
    define
    fix (a, a')
    assume h2 : (a, a') ∈ comp (extension R) (extension R)
    define at h2
    obtain (a'' : A) (h3 :  (a, a'') ∈ extension R ∧ (a'', a') ∈ extension R) from h2
    have h4 : R a a'' := h3.left
    have h5 : R a'' a' := h3.right
    exact h1 a a'' a' h4 h5
  · assume h1 : comp (extension R) (extension R) ⊆ extension R
    define
    fix x; fix y; fix z
    assume h2 : R x y
    assume h3 : R y z
    define at h1
    have h4 : (x, z) ∈ comp (extension R) (extension R) := by
      define; apply Exists.intro y
      exact And.intro h2 h3
    exact h1 h4
  done

-- 4.
theorem Exercise_4_3_12a {A : Type} (R : BinRel A) (h1 : reflexive R) :
    reflexive (RelFromExt (inv (extension R))) := by
  define; fix a
  define
  exact h1 a
  done

-- 5.
theorem Exercise_4_3_12c {A : Type} (R : BinRel A) (h1 : transitive R) :
    transitive (RelFromExt (inv (extension R))) := by
  define; fix x; fix y; fix z
  assume h2 : RelFromExt (inv (extension R)) x y; define at h2
  assume h3 : RelFromExt (inv (extension R)) y z; define at h3
  define; define at h1
  exact h1 z y x h3 h2
  done

-- 6.
theorem Exercise_4_3_18 {A : Type}
    (R S : BinRel A) (h1 : transitive R) (h2 : transitive S)
    (h3 : comp (extension S) (extension R) ⊆
      comp (extension R) (extension S)) :
    transitive (RelFromExt (comp (extension R) (extension S))) := by
  define; fix x; fix y; fix z
  assume h4 : RelFromExt (comp (extension R) (extension S)) x y; define at h4
  obtain (xy : A) (h5 : (x, xy) ∈ extension S ∧ (xy, y) ∈ extension R) from h4
  assume h6 : RelFromExt (comp (extension R) (extension S)) y z; define at h6
  obtain (yz : A) (h7 : (y, yz) ∈ extension S ∧ (yz, z) ∈ extension R) from h6
  have h8 : (xy, yz) ∈ comp (extension S) (extension R) := by
    define; apply Exists.intro y; exact And.intro h5.right h7.left
  have h9 : (xy, yz) ∈ comp (extension R) (extension S) := h3 h8
  define at h9; obtain (xyz : A) (h10 : (xy, xyz) ∈ extension S ∧ (xyz, yz) ∈ extension R) from h9
  apply Exists.intro xyz
  apply And.intro
  · exact h2 x xy xyz h5.left h10.left
  · exact h1 xyz yz z h10.right h7.right
  done

-- 7.
theorem Exercise_4_3_20 {A : Type} (R : BinRel A) (S : BinRel (Set A))
    (h : ∀ (X Y : Set A), S X Y ↔ X ≠ ∅ ∧ Y ≠ ∅ ∧
    ∀ (x y : A), x ∈ X → y ∈ Y → R x y) :
    transitive R → transitive S := by
  assume h1 : transitive R
  define; fix X; fix Y; fix Z
  assume h2 : S X Y; assume h3 : S Y Z
  rw [h] at h2
  rw [h] at h3
  have h5 : Y ≠ ∅ := h2.right.left
  rw [← Set.nonempty_iff_ne_empty] at h5
  define at h5; obtain (y : A) (h6 : y ∈ Y) from h5
  rw [h]
  apply And.intro h2.left
  apply And.intro h3.right.left
  fix x; fix z; assume h7 : x ∈ X; assume h8 : z ∈ Z
  have h9 : R x y := h2.right.right x y h7 h6
  have h10 : R y z := h3.right.right y z h6 h8
  exact h1 x y z h9 h10
  done

-- 8.
--You might not be able to complete this proof
theorem Exercise_4_3_13b {A : Type}
    (R1 R2 : BinRel A) (h1 : symmetric R1) (h2 : symmetric R2) :
    symmetric (RelFromExt ((extension R1) ∪ (extension R2))) := sorry

-- 9.
--You might not be able to complete this proof
theorem Exercise_4_3_13c {A : Type}
    (R1 R2 : BinRel A) (h1 : transitive R1) (h2 : transitive R2) :
    transitive (RelFromExt ((extension R1) ∪ (extension R2))) := sorry

-- 10.
--You might not be able to complete this proof
theorem Exercise_4_3_19 {A : Type} (R : BinRel A) (S : BinRel (Set A))
    (h : ∀ (X Y : Set A), S X Y ↔ ∃ (x y : A), x ∈ X ∧ y ∈ Y ∧ R x y) :
    transitive R → transitive S := sorry

/- Section 4.4 -/
-- 1.
theorem Example_4_4_3_1 {A : Type} : partial_order (sub A) := sorry

-- 2.
theorem Theorem_4_4_6_1 {A : Type} (R : BinRel A) (B : Set A) (b : A)
    (h1 : partial_order R) (h2 : smallestElt R b B) :
    ∀ (c : A), smallestElt R c B → b = c := sorry

-- 3.
--If F is a set of sets, then ⋃₀ F is the lub of F in the subset ordering
theorem Theorem_4_4_11 {A : Type} (F : Set (Set A)) :
    lub (sub A) (⋃₀ F) F := sorry

-- 4.
theorem Exercise_4_4_8 {A B : Type} (R : BinRel A) (S : BinRel B)
    (T : BinRel (A × B)) (h1 : partial_order R) (h2 : partial_order S)
    (h3 : ∀ (a a' : A) (b b' : B),
      T (a, b) (a', b') ↔ R a a' ∧ S b b') :
    partial_order T := sorry

-- 5.
theorem Exercise_4_4_9_part {A B : Type} (R : BinRel A) (S : BinRel B)
    (L : BinRel (A × B)) (h1 : total_order R) (h2 : total_order S)
    (h3 : ∀ (a a' : A) (b b' : B),
      L (a, b) (a', b') ↔ R a a' ∧ (a = a' → S b b')) :
    ∀ (a a' : A) (b b' : B),
      L (a, b) (a', b') ∨ L (a', b') (a, b) := sorry

-- 6.
theorem Exercise_4_4_15a {A : Type}
    (R1 R2 : BinRel A) (B : Set A) (b : A)
    (h1 : partial_order R1) (h2 : partial_order R2)
    (h3 : extension R1 ⊆ extension R2) :
    smallestElt R1 b B → smallestElt R2 b B := sorry

-- 7.
theorem Exercise_4_4_15b {A : Type}
    (R1 R2 : BinRel A) (B : Set A) (b : A)
    (h1 : partial_order R1) (h2 : partial_order R2)
    (h3 : extension R1 ⊆ extension R2) :
    minimalElt R2 b B → minimalElt R1 b B := sorry

-- 8.
theorem Exercise_4_4_18a {A : Type}
    (R : BinRel A) (B1 B2 : Set A) (h1 : partial_order R)
    (h2 : ∀ x ∈ B1, ∃ y ∈ B2, R x y) (h3 : ∀ x ∈ B2, ∃ y ∈ B1, R x y) :
    ∀ (x : A), upperBd R x B1 ↔ upperBd R x B2 := sorry

-- 9.
theorem Exercise_4_4_22 {A : Type}
    (R : BinRel A) (B1 B2 : Set A) (x1 x2 : A)
    (h1 : partial_order R) (h2 : lub R x1 B1) (h3 : lub R x2 B2) :
    B1 ⊆ B2 → R x1 x2 := sorry

-- 10.
theorem Exercise_4_4_24 {A : Type} (R : Set (A × A)) :
    smallestElt (sub (A × A)) (R ∪ (inv R))
    { T : Set (A × A) | R ⊆ T ∧ symmetric (RelFromExt T) } := sorry

/- Section 4.5 -/
-- 1.
lemma overlap_implies_equal {A : Type}
    (F : Set (Set A)) (h : partition F) :
    ∀ X ∈ F, ∀ Y ∈ F, ∀ (x : A), x ∈ X → x ∈ Y → X = Y := sorry

-- 2.
lemma Lemma_4_5_7_ref {A : Type} (F : Set (Set A)) (h : partition F) :
    reflexive (EqRelFromPart F) := sorry

-- 3.
lemma Lemma_4_5_7_symm {A : Type} (F : Set (Set A)) (h : partition F) :
    symmetric (EqRelFromPart F) := sorry

-- 4.
lemma Lemma_4_5_7_trans {A : Type} (F : Set (Set A)) (h : partition F) :
    transitive (EqRelFromPart F) := sorry

-- 5.
lemma Lemma_4_5_8 {A : Type} (F : Set (Set A)) (h : partition F) :
    ∀ X ∈ F, ∀ x ∈ X, equivClass (EqRelFromPart F) x = X := sorry

-- 6.
lemma elt_mod_equiv_class_of_elt
    {A : Type} (R : BinRel A) (h : equiv_rel R) :
    ∀ X ∈ mod A R, ∀ x ∈ X, equivClass R x = X := sorry

-- Definitions for next three exercises:
def dot {A : Type} (F G : Set (Set A)) : Set (Set A) :=
    { Z : Set A | ¬empty Z ∧ ∃ X ∈ F, ∃ Y ∈ G, Z = X ∩ Y }

def conj {A : Type} (R S : BinRel A) (x y : A) : Prop :=
    R x y ∧ S x y

-- 7.
theorem Exercise_4_5_20a {A : Type} (R S : BinRel A)
    (h1 : equiv_rel R) (h2 : equiv_rel S) :
    equiv_rel (conj R S) := sorry

-- 8.
theorem Exercise_4_5_20b {A : Type} (R S : BinRel A)
    (h1 : equiv_rel R) (h2 : equiv_rel S) :
    ∀ (x : A), equivClass (conj R S) x =
      equivClass R x ∩ equivClass S x := sorry

-- 9.
theorem Exercise_4_5_20c {A : Type} (R S : BinRel A)
    (h1 : equiv_rel R) (h2 : equiv_rel S) :
    mod A (conj R S) = dot (mod A R) (mod A S) := sorry

-- 10.
def equiv_mod (m x y : Int) : Prop := m ∣ (x - y)

theorem Theorem_4_5_10 : ∀ (m : Int), equiv_rel (equiv_mod m) := sorry
