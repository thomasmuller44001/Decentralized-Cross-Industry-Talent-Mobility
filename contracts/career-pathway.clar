;; Career Pathway Contract
;; Maps skill transferability between sectors

(define-constant ERR-NOT-AUTHORIZED (err u300))
(define-constant ERR-PATHWAY-EXISTS (err u301))
(define-constant ERR-PATHWAY-NOT-FOUND (err u302))

;; Data maps
(define-map career-pathways
  { from-industry: (string-ascii 30), to-industry: (string-ascii 30) }
  {
    transferable-skills: (list 10 (string-ascii 50)),
    difficulty-score: uint,
    average-transition-time: uint,
    success-rate: uint,
    created-by: principal,
    creation-date: uint
  }
)

(define-map pathway-recommendations
  { user: principal, pathway-id: uint }
  {
    from-industry: (string-ascii 30),
    to-industry: (string-ascii 30),
    match-score: uint,
    recommended-date: uint,
    status: (string-ascii 20)
  }
)

(define-map recommendation-counter principal uint)
(define-map authorized-analysts principal bool)

;; Initialize contract deployer as authorized analyst
(map-set authorized-analysts tx-sender true)

;; Public functions
(define-public (add-analyst (analyst principal))
  (begin
    (asserts! (default-to false (map-get? authorized-analysts tx-sender)) ERR-NOT-AUTHORIZED)
    (ok (map-set authorized-analysts analyst true))
  )
)

(define-public (create-pathway
  (from-industry (string-ascii 30))
  (to-industry (string-ascii 30))
  (transferable-skills (list 10 (string-ascii 50)))
  (difficulty-score uint)
  (average-transition-time uint)
  (success-rate uint)
)
  (let ((pathway-key { from-industry: from-industry, to-industry: to-industry }))
    (asserts! (default-to false (map-get? authorized-analysts tx-sender)) ERR-NOT-AUTHORIZED)
    (asserts! (is-none (map-get? career-pathways pathway-key)) ERR-PATHWAY-EXISTS)
    (ok (map-set career-pathways
      pathway-key
      {
        transferable-skills: transferable-skills,
        difficulty-score: difficulty-score,
        average-transition-time: average-transition-time,
        success-rate: success-rate,
        created-by: tx-sender,
        creation-date: block-height
      }
    ))
  )
)

(define-public (recommend-pathway
  (user principal)
  (from-industry (string-ascii 30))
  (to-industry (string-ascii 30))
  (match-score uint)
)
  (let (
    (rec-count (default-to u0 (map-get? recommendation-counter user)))
    (new-rec-id (+ rec-count u1))
  )
    (asserts! (default-to false (map-get? authorized-analysts tx-sender)) ERR-NOT-AUTHORIZED)
    (map-set recommendation-counter user new-rec-id)
    (ok (map-set pathway-recommendations
      { user: user, pathway-id: new-rec-id }
      {
        from-industry: from-industry,
        to-industry: to-industry,
        match-score: match-score,
        recommended-date: block-height,
        status: "pending"
      }
    ))
  )
)

;; Read-only functions
(define-read-only (get-pathway (from-industry (string-ascii 30)) (to-industry (string-ascii 30)))
  (map-get? career-pathways { from-industry: from-industry, to-industry: to-industry })
)

(define-read-only (get-user-recommendation (user principal) (pathway-id uint))
  (map-get? pathway-recommendations { user: user, pathway-id: pathway-id })
)

(define-read-only (get-user-recommendation-count (user principal))
  (default-to u0 (map-get? recommendation-counter user))
)
