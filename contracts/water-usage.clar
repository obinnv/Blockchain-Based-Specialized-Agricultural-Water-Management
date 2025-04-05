;; water-usage.clar
;; Contract for tracking water consumption for irrigation

(define-data-var last-usage-id uint u0)

;; Water usage data structure
(define-map water-usage
  { usage-id: uint }
  {
    farm-id: uint,
    source-id: uint,
    amount: uint,
    timestamp: uint,
    purpose: (string-utf8 100)
  }
)

;; Farm total usage tracking
(define-map farm-total-usage
  { farm-id: uint }
  { total-usage: uint }
)

;; Record water usage
(define-public (record-water-usage
    (farm-id uint)
    (source-id uint)
    (amount uint)
    (purpose (string-utf8 100)))
  (let
    (
      (usage-id (+ (var-get last-usage-id) u1))
      (current-total (default-to u0 (get total-usage (map-get? farm-total-usage { farm-id: farm-id }))))
    )
    ;; Check if caller owns the farm and source is verified (would need contract calls in practice)
    ;; For simplicity, we're not doing the actual contract calls here

    ;; Record the usage
    (var-set last-usage-id usage-id)
    (map-set water-usage
      { usage-id: usage-id }
      {
        farm-id: farm-id,
        source-id: source-id,
        amount: amount,
        timestamp: block-height,
        purpose: purpose
      }
    )

    ;; Update total usage for the farm
    (map-set farm-total-usage
      { farm-id: farm-id }
      { total-usage: (+ current-total amount) }
    )

    (ok usage-id)
  )
)

;; Get water usage details
(define-read-only (get-water-usage (usage-id uint))
  (map-get? water-usage { usage-id: usage-id })
)

;; Get total water usage for a farm
(define-read-only (get-farm-total-usage (farm-id uint))
  (default-to u0 (get total-usage (map-get? farm-total-usage { farm-id: farm-id })))
)

;; Get usage history for a farm (in a real implementation, this would need pagination)
(define-read-only (get-farm-usage-count (farm-id uint))
  (let
    ((count u0)
     (max-id (var-get last-usage-id)))
    ;; This is a simplified approach - in a real contract, we would use a better data structure
    ;; to track usage by farm
    (ok u0) ;; Placeholder - would need to implement counting logic
  )
)
