describe port(80) do
  it { should be_listening }
end

describe command('curl http://localhost') do
  its('stdout') { should match /Welcome to WordPress/ }
end

describe service('mysql') do
  it { should be_running }
end

describe port(3306) do
  it { should be_listening }
end

describe command('mysql -uroot -ptestpassword -e "show databases;"') do
  its('stdout') { should match /mysql/ }
end