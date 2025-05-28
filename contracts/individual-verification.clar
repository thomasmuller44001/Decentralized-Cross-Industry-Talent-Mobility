;; Individual Verification Contract
;; Validates worker identities and maintains verification status

(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-ALREADY-VERIFIED (err u101))
(define-constant ERR-NOT-FOUND (err u102))

;; Data maps
(define-map verified-individuals
  { user: principal }
  {
    verified: bool,
    verification-date: uint,
    verifier: principal,
    identity-hash: (buff 32)
  }
)

(define-map authorized-verifiers principal bool)

;; Initialize contract deployer as authorized verifier
(map-set authorized-verifiers tx-sender true)

;; Public functions
(define-public (add-verifier (verifier principal))
  (begin
    (asserts! (default-to false (map-get? authorized-verifiers tx-sender)) ERR-NOT-AUTHORIZED)
    (ok (map-set authorized-verifiers verifier true))
  )
)

(define-public (verify-individual (user principal) (identity-hash (buff 32)))
  (let ((existing-verification (map-get? verified-individuals { user: user })))
    (asserts! (default-to false (map-get? authorized-verifiers tx-sender)) ERR-NOT-AUTHORIZED)
    (asserts! (is-none existing-verification) ERR-ALREADY-VERIFIED)
    (ok (map-set verified-individuals
      { user: user }
      {
        verified: true,
        verification-date: block-height,
        verifier: tx-sender,
        identity-hash: identity-hash
      }
    ))
  )
)

(define-public (revoke-verification (user principal))
  (begin
    (asserts! (default-to false (map-get? authorized-verifiers tx-sender)) ERR-NOT-AUTHORIZED)
    (ok (map-delete verified-individuals { user: user }))
  )
)

;; Read-only functions
(define-read-only (is-verified (user principal))
  (match (map-get? verified-individuals { user: user })
    verification (get verified verification)
    false
  )
)

(define-read-only (get-verification-details (user principal))
  (map-get? verified-individuals { user: user })
)

(define-read-only (is-authorized-verifier (verifier principal))
  (default-to false (map-get? authorized-verifiers verifier))
)
