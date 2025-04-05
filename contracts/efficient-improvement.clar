;; efficiency-improvement.clar
;; Contract for managing implementation of water-saving techniques

(define-data-var last-improvement-id uint u0)

;; Improvement technique data structure
(define-map improvement-techniques
  { technique-id: uint }
  {
    name: (string-utf8 100),
    description: (string-utf8 500),
    water-saving-potential: uint,  ;; percentage * 100 (e.g., 2500 = 25%)
    implementation-cost: uint
  }
)

;; Farm improvements data structure
(define-map farm-improvements
  { farm-id: uint, technique-id: uint }
  {
    implementation-date: uint,
    status: (string-utf8 50),  ;; "planned", "in-progress", "completed"
    actual-savings: uint,      ;; percentage * 100
    notes: (string-utf8 500)
  }
)

;; Register a new improvement technique
(define-public (register-technique
    (name (string-utf8 100))
    (description (string-utf8 500))
    (water-saving-potential uint)
    (implementation-cost uint))
  (let
    (
      (technique-id (+ (var-get last-improvement-id) u1))
    )
    ;; In a real implementation, we would check if tx-sender is authorized
    (var-set last-improvement-id technique-id)
    (map-set improvement-techniques
      { technique-id: technique-id }
      {
        name: name,
        description: description,
        water-saving-potential: water-saving-potential,
        implementation-cost: implementation-cost
      }
    )
    (ok technique-id)
  )
)

;; Implement an improvement on a farm
(define-public (implement-improvement
    (farm-id uint)
    (technique-id uint)
    (status (string-utf8 50))
    (notes (string-utf8 500)))
  (begin
    ;; Check if caller owns the farm (would need contract call in practice)
    ;; For simplicity, we're not doing the actual contract call here

    ;; Record the implementation
    (map-set farm-improvements
      { farm-id: farm-id, technique-id: technique-id }
      {
        implementation-date: block-height,
        status: status,
        actual-savings: u0,  ;; Initial savings is 0
        notes: notes
      }
    )
    (ok true)
  )
)

;; Update improvement status
(define-public (update-improvement-status
    (farm-id uint)
    (technique-id uint)
    (status (string-utf8 50))
    (actual-savings uint)
    (notes (string-utf8 500)))
  (begin
    ;; Check if caller owns the farm (would need contract call in practice)
    ;; Check if improvement exists
    (match (map-get? farm-improvements { farm-id: farm-id, technique-id: technique-id })
      improvement (begin
        (map-set farm-improvements
          { farm-id: farm-id, technique-id: technique-id }
          {
            implementation-date: (get implementation-date improvement),
            status: status,
            actual-savings: actual-savings,
            notes: notes
          }
        )
        (ok true)
      )
      (err u1) ;; Improvement not found
    )
  )
)

;; Get technique details
(define-read-only (get-technique (technique-id uint))
  (map-get? improvement-techniques { technique-id: technique-id })
)

;; Get farm improvement details
(define-read-only (get-farm-improvement (farm-id uint) (technique-id uint))
  (map-get? farm-improvements { farm-id: farm-id, technique-id: technique-id })
)
