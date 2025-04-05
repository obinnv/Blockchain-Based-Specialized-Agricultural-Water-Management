;; water-source.clar
;; Contract for verifying water sources and access rights

(define-data-var last-source-id uint u0)

;; Water source data structure
(define-map water-sources
  { source-id: uint }
  {
    owner: principal,
    farm-id: uint,
    source-type: (string-utf8 50),
    location: (string-utf8 100),
    max-capacity: uint,
    verified: bool,
    verification-date: uint
  }
)

;; Register a new water source
(define-public (register-water-source
    (farm-id uint)
    (source-type (string-utf8 50))
    (location (string-utf8 100))
    (max-capacity uint))
  (let
    (
      (source-id (+ (var-get last-source-id) u1))
    )
    ;; Check if caller owns the farm (would need to import farm-registry contract in practice)
    ;; For simplicity, we're not doing the actual contract call here
    (var-set last-source-id source-id)
    (map-set water-sources
      { source-id: source-id }
      {
        owner: tx-sender,
        farm-id: farm-id,
        source-type: source-type,
        location: location,
        max-capacity: max-capacity,
        verified: false,
        verification-date: u0
      }
    )
    (ok source-id)
  )
)

;; Verify a water source (would be done by an authorized verifier)
(define-public (verify-water-source (source-id uint))
  ;; In a real implementation, we would check if tx-sender is an authorized verifier
  (match (map-get? water-sources { source-id: source-id })
    source (begin
      (map-set water-sources
        { source-id: source-id }
        {
          owner: (get owner source),
          farm-id: (get farm-id source),
          source-type: (get source-type source),
          location: (get location source),
          max-capacity: (get max-capacity source),
          verified: true,
          verification-date: block-height
        }
      )
      (ok true)
    )
    (err u1) ;; Source not found
  )
)

;; Get water source details
(define-read-only (get-water-source (source-id uint))
  (map-get? water-sources { source-id: source-id })
)

;; Check if water source is verified
(define-read-only (is-source-verified (source-id uint))
  (match (map-get? water-sources { source-id: source-id })
    source (get verified source)
    false
  )
)
