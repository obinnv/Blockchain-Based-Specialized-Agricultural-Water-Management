;; farm-registry.clar
;; Contract for registering farms in the agricultural water management system

(define-data-var last-farm-id uint u0)

;; Farm data structure
(define-map farms
  { farm-id: uint }
  {
    owner: principal,
    name: (string-utf8 100),
    location: (string-utf8 100),
    size: uint,
    crop-type: (string-utf8 50),
    registration-date: uint
  }
)

;; Register a new farm
(define-public (register-farm (name (string-utf8 100)) (location (string-utf8 100)) (size uint) (crop-type (string-utf8 50)))
  (let
    (
      (farm-id (+ (var-get last-farm-id) u1))
    )
    (var-set last-farm-id farm-id)
    (map-set farms
      { farm-id: farm-id }
      {
        owner: tx-sender,
        name: name,
        location: location,
        size: size,
        crop-type: crop-type,
        registration-date: block-height
      }
    )
    (ok farm-id)
  )
)

;; Get farm details
(define-read-only (get-farm (farm-id uint))
  (map-get? farms { farm-id: farm-id })
)

;; Check if caller owns the farm
(define-read-only (is-farm-owner (farm-id uint) (owner principal))
  (match (map-get? farms { farm-id: farm-id })
    farm (is-eq (get owner farm) owner)
    false
  )
)

;; Update farm details
(define-public (update-farm (farm-id uint) (name (string-utf8 100)) (location (string-utf8 100)) (size uint) (crop-type (string-utf8 50)))
  (if (is-farm-owner farm-id tx-sender)
    (match (map-get? farms { farm-id: farm-id })
      farm (begin
        (map-set farms
          { farm-id: farm-id }
          {
            owner: tx-sender,
            name: name,
            location: location,
            size: size,
            crop-type: crop-type,
            registration-date: (get registration-date farm)
          }
        )
        (ok true)
      )
      (err u1) ;; Farm not found
    )
    (err u2) ;; Not the farm owner
  )
)
