local leveldb = require 'leveldb'

opt = leveldb.options()
opt.createIfMissing = true
opt.errorIfExists = false

local test_key = 'key1'
local test_val = 'value1'

-- first run
print ('opening test.db')

testdb = leveldb.open(opt, 'test.db')

assert(leveldb.check(testdb), "inconsistent db")

assert(testdb:put(test_key, test_val), "cannot put k/v record")

local res_val = testdb:get("key1");

assert(res_val == test_val, "value inconsistent, found: " .. type(res_val) .. " " .. res_val)

leveldb.close(testdb)

-- reopening
print ('reopening test.db')

testdb = leveldb.open(opt, 'test.db')

assert(testdb:put('key2', 123456), "cannot put second k/v record")

local return_val = testdb:get('key2')

assert(return_val == 123456, "second value is inconsistent, expecting number, found: " .. type(return_val) .. " " .. return_val)

leveldb.close(testdb)

print("basic test successful!")