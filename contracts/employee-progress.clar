;; Employee Progress Contract
;; Tracks employee training progress and completion

;; Constants
(define-constant err-not-enrolled (err u300))
(define-constant err-already-enrolled (err u301))
(define-constant err-invalid-progress (err u302))
(define-constant err-course-not-found (err u303))

;; Data Variables
(define-data-var next-enrollment-id uint u1)

;; Data Maps
(define-map enrollments
  { enrollment-id: uint }
  {
    employee: principal,
    curriculum-id: uint,
    enrolled-block: uint,
    status: (string-ascii 20),
    progress-percentage: uint,
    completed-block: (optional uint)
  }
)

(define-map employee-enrollments
  { employee: principal, curriculum-id: uint }
  { enrollment-id: uint }
)

(define-map course-progress
  { enrollment-id: uint, course-id: uint }
  {
    started-block: (optional uint),
    completed-block: (optional uint),
    progress-percentage: uint,
    time-spent-minutes: uint
  }
)

;; Public Functions

;; Enroll employee in curriculum
(define-public (enroll-employee (employee principal) (curriculum-id uint))
  (let
    (
      (enrollment-id (var-get next-enrollment-id))
    )
    (asserts! (is-none (map-get? employee-enrollments { employee: employee, curriculum-id: curriculum-id })) err-already-enrolled)

    (map-set enrollments
      { enrollment-id: enrollment-id }
      {
        employee: employee,
        curriculum-id: curriculum-id,
        enrolled-block: block-height,
        status: "enrolled",
        progress-percentage: u0,
        completed-block: none
      }
    )

    (map-set employee-enrollments
      { employee: employee, curriculum-id: curriculum-id }
      { enrollment-id: enrollment-id }
    )

    (var-set next-enrollment-id (+ enrollment-id u1))
    (ok enrollment-id)
  )
)

;; Update course progress
(define-public (update-course-progress
  (enrollment-id uint)
  (course-id uint)
  (progress-percentage uint)
  (time-spent-minutes uint)
)
  (begin
    (asserts! (<= progress-percentage u100) err-invalid-progress)
    (asserts! (is-some (map-get? enrollments { enrollment-id: enrollment-id })) err-not-enrolled)

    (let
      (
        (current-progress (default-to
          { started-block: none, completed-block: none, progress-percentage: u0, time-spent-minutes: u0 }
          (map-get? course-progress { enrollment-id: enrollment-id, course-id: course-id })
        ))
        (started-block (if (is-none (get started-block current-progress)) (some block-height) (get started-block current-progress)))
        (completed-block (if (is-eq progress-percentage u100) (some block-height) none))
      )

      (map-set course-progress
        { enrollment-id: enrollment-id, course-id: course-id }
        {
          started-block: started-block,
          completed-block: completed-block,
          progress-percentage: progress-percentage,
          time-spent-minutes: (+ (get time-spent-minutes current-progress) time-spent-minutes)
        }
      )

      (ok true)
    )
  )
)

;; Complete enrollment
(define-public (complete-enrollment (enrollment-id uint))
  (match (map-get? enrollments { enrollment-id: enrollment-id })
    enrollment-data
    (begin
      (map-set enrollments
        { enrollment-id: enrollment-id }
        (merge enrollment-data {
          status: "completed",
          progress-percentage: u100,
          completed-block: (some block-height)
        })
      )
      (ok true)
    )
    err-not-enrolled
  )
)

;; Read-only Functions

;; Get enrollment details
(define-read-only (get-enrollment (enrollment-id uint))
  (map-get? enrollments { enrollment-id: enrollment-id })
)

;; Get employee enrollment for curriculum
(define-read-only (get-employee-enrollment (employee principal) (curriculum-id uint))
  (map-get? employee-enrollments { employee: employee, curriculum-id: curriculum-id })
)

;; Get course progress
(define-read-only (get-course-progress (enrollment-id uint) (course-id uint))
  (map-get? course-progress { enrollment-id: enrollment-id, course-id: course-id })
)
