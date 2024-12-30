/*
    The purpose of this intermediate model is to track contributions to Congressional candidates from Committee-filers only.
*/

with candidates as (
    /* grab all Congressional candidates only */

    select * from {{ ref('stg_candidate_master') }} where cand_office in ('H', 'S')

)

, contributions as (

    select * from {{ ref('stg_contributions_from_committees_to_candidates') }}

)

, committees as (

    select * from {{ ref('stg_committee_master') }}

)

, combined as (

    select
        candidates.cand_id,
        candidates.cand_name,
        candidates.cand_pty_affiliation,
        candidates.cand_election_yr,
        candidates.cand_office_st,
        candidates.cand_office,
        candidates.cand_office_district,
        contributions.cmte_id,
        committees.cmte_nm,
        committees.cmte_pty_affiliation,
        contributions.tran_id,
        contributions.transaction_tp,
        contributions.state as contributor_state,
        contributions.transaction_amt

    from candidates
    left join contributions on candidates.cand_id = contributions.cand_id
    left join committees on contributions.cmte_id = committees.cmte_id

)

select * from combined

