[
  { name: 'Allergy and immunology' },
  { name: 'Dermatology' },
  { name: 'Family medicine' },
  { name: 'Neurology' },
  { name: 'Gynecology' },
  { name: 'Ophthalmology' },
  { name: 'Pathology' },
  { name: 'Pediatrics' },
  { name: 'Psychiatry' },
  { name: 'Urology' },
].each do |specialty|
  Specialty.find_or_create_by(specialty)
end