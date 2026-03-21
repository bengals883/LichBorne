-- LibDataBroker-1.1
assert(LibStub, "LibDataBroker-1.1 requires LibStub")

local lib, oldminor = LibStub:NewLibrary("LibDataBroker-1.1", 4)
if not lib then return end
oldminor = oldminor or 0

lib.callbacks = lib.callbacks or LibStub:GetLibrary("CallbackHandler-1.0", true)
lib.domt = lib.domt or {
	__metatable = false,
	__index = function(dataobj, key) return lib.attributestorage[dataobj] and lib.attributestorage[dataobj][key] end,
	__newindex = function(dataobj, key, value)
		if not lib.attributestorage[dataobj] then lib.attributestorage[dataobj] = {} end
		if lib.attributestorage[dataobj][key] == value then return end
		lib.attributestorage[dataobj][key] = value
		local name = lib.donames[dataobj]
		if lib.callbacks then
			lib.callbacks:Fire("LibDataBroker_AttributeChanged", name, key, value, dataobj)
			lib.callbacks:Fire("LibDataBroker_AttributeChanged_"..name, name, key, value, dataobj)
			lib.callbacks:Fire("LibDataBroker_AttributeChanged__"..key, name, key, value, dataobj)
			lib.callbacks:Fire("LibDataBroker_AttributeChanged_"..name.."_"..key, name, key, value, dataobj)
		end
	end,
}

lib.attributestorage = lib.attributestorage or {}
lib.donames = lib.donames or {}
lib.dobjs = lib.dobjs or {}

function lib:NewDataObject(name, dataobj)
	if self.dobjs[name] then return nil end

	dataobj = dataobj or {}
	assert(type(dataobj) == "table", "Invalid dataobj, must be nil or a table")
	self.attributestorage[dataobj] = {}
	for i,v in pairs(dataobj) do
		self.attributestorage[dataobj][i] = v
		dataobj[i] = nil
	end
	setmetatable(dataobj, self.domt)
	self.donames[dataobj] = name
	self.dobjs[name] = dataobj
	if lib.callbacks then
		lib.callbacks:Fire("LibDataBroker_DataObjectCreated", name, dataobj)
	end
	return dataobj
end

function lib:DataObjectIterator()
	return pairs(self.dobjs)
end

function lib:GetDataObjectByName(dataobjectname)
	return self.dobjs[dataobjectname]
end

function lib:GetNameByDataObject(dataobj)
	return self.donames[dataobj]
end
