[
  { name: '0-01', floor: 0 },
  { name: '0-02', floor: 0 },
  { name: '0-03', floor: 0 },
  { name: '0-04', floor: 0 },
  { name: '0-05', floor: 0 },
  { name: '0-06', floor: 0 },
  { name: '0-07', floor: 0 },
  { name: '0-08', floor: 0 },
  { name: '0-09', floor: 0 },
  { name: '0-10', floor: 0 },
  { name: '1-01', floor: 1 },
  { name: '1-02', floor: 1 },
  { name: '1-03', floor: 1 },
  { name: '1-04', floor: 1 },
  { name: '1-05', floor: 1 },
  { name: '1-06', floor: 1 },
  { name: '1-07', floor: 1 },
  { name: '1-08', floor: 1 },
  { name: '1-09', floor: 1 },
  { name: '1-10', floor: 1 },
].each do |cabinet|
  Cabinet.find_or_create_by(cabinet)
end