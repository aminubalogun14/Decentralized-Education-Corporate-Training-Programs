;; Curriculum Management Contract
;; Manages training curricula and courses

;; Constants
(define-constant err-unauthorized (err u200))
(define-constant err-not-found (err u201))
(define-constant err-invalid-duration (err u202))

;; Data Variables
(define-data-var next-curriculum-id uint u1)
(define-data-var next-course-id uint u1)

;; Data Maps
(define-map curricula
  { curriculum-id: uint }
  {
    provider-id: uint,
    title: (string-ascii 200),
    description: (string-ascii 1000),
    category: (string-ascii 50),
    difficulty-level: uint,
    estimated-duration: uint,
    created-block: uint,
    active: bool
  }
)

(define-map courses
  { course-id: uint }
  {
    curriculum-id: uint,
    title: (string-ascii 200),
    description: (string-ascii 1000),
    order-index: uint,
    duration-hours: uint,
    required: bool
  }
)

(define-map curriculum-courses
  { curriculum-id: uint, course-id: uint }
  { exists: bool }
)

;; Public Functions

;; Create a new curriculum
(define-public (create-curriculum
  (provider-id uint)
  (title (string-ascii 200))
  (description (string-ascii 1000))
  (category (string-ascii 50))
  (difficulty-level uint)
  (estimated-duration uint)
)
  (let
    (
      (curriculum-id (var-get next-curriculum-id))
    )
    (asserts! (> estimated-duration u0) err-invalid-duration)

    (map-set curricula
      { curriculum-id: curriculum-id }
      {
        provider-id: provider-id,
        title: title,
        description: description,
        category: category,
        difficulty-level: difficulty-level,
        estimated-duration: estimated-duration,
        created-block: block-height,
        active: true
      }
    )

    (var-set next-curriculum-id (+ curriculum-id u1))
    (ok curriculum-id)
  )
)

;; Add a course to curriculum
(define-public (add-course
  (curriculum-id uint)
  (title (string-ascii 200))
  (description (string-ascii 1000))
  (order-index uint)
  (duration-hours uint)
  (required bool)
)
  (let
    (
      (course-id (var-get next-course-id))
    )
    (asserts! (is-some (map-get? curricula { curriculum-id: curriculum-id })) err-not-found)

    (map-set courses
      { course-id: course-id }
      {
        curriculum-id: curriculum-id,
        title: title,
        description: description,
        order-index: order-index,
        duration-hours: duration-hours,
        required: required
      }
    )

    (map-set curriculum-courses
      { curriculum-id: curriculum-id, course-id: course-id }
      { exists: true }
    )

    (var-set next-course-id (+ course-id u1))
    (ok course-id)
  )
)

;; Deactivate curriculum
(define-public (deactivate-curriculum (curriculum-id uint))
  (match (map-get? curricula { curriculum-id: curriculum-id })
    curriculum-data
    (begin
      (map-set curricula
        { curriculum-id: curriculum-id }
        (merge curriculum-data { active: false })
      )
      (ok true)
    )
    err-not-found
  )
)

;; Read-only Functions

;; Get curriculum details
(define-read-only (get-curriculum (curriculum-id uint))
  (map-get? curricula { curriculum-id: curriculum-id })
)

;; Get course details
(define-read-only (get-course (course-id uint))
  (map-get? courses { course-id: course-id })
)

;; Check if course belongs to curriculum
(define-read-only (is-course-in-curriculum (curriculum-id uint) (course-id uint))
  (is-some (map-get? curriculum-courses { curriculum-id: curriculum-id, course-id: course-id }))
)
