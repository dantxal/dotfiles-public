return {
  -- This is 3-in-1 plugin
  --
  -- Abolish
  -- The following one command produces 48 abbreviations including all of the above.
  -- :Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}
  --
  -- Subvert
  -- Substitutes all word variants...
  -- :%s/facilities/buildings/g
  -- :%s/Facilities/Buildings/g
  -- :%s/FACILITIES/BUILDINGS/g
  -- ...with only one command, singular and plural, all cases accounted for:
  -- :%Subvert/facilit{y,ies}/building{,s}/g
  --
  -- Coercion
  -- Convert word to a different case
  -- crs - snake_case
  -- crm - MixedCase
  -- crc - camelCase
  -- cru - UPPER_CASE
  -- cr- - dash-case
  -- cr. - dot.case
  "tpope/vim-abolish",
}
