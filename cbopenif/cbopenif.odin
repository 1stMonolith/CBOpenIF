package cbopenif

import "controlbuilder"
import "component"
import "type"

// properties procedures

access_level :: proc {
    component.component_access_level_get,
    component.component_access_level_set,
}

attribute :: proc {
    component.component_attribute_get,
    component.component_attribute_set,
}

authentication_level :: proc {
    component.component_authentication_level_get,
    component.component_authentication_level_set,
}

description :: proc {
    component.component_description_get,
    component.component_description_set,
    type.datatype_description_get,
    type.datatype_description_set,
}

guid :: proc {
    type.datatype_guid_get,
    type.datatype_guid_set,
}

hidden :: proc {
    type.datatype_hidden_get,
    type.datatype_hidden_set,
}

initial_value :: proc {
    component.component_initial_value_get,
    component.component_initial_value_set,
}

isp_value :: proc {
    component.component_isp_value_get,
    component.component_isp_value_set,
}

name :: proc {
    component.component_name_get,
    component.component_name_set,
    type.datatype_name_get,
    type.datatype_name_set,
}

protected :: proc {
    type.datatype_protected_get,
    type.datatype_protected_set,
}

read_permission :: proc {
    component.component_read_permission_get,
    component.component_read_permission_set,
}

reserved_by_function :: proc {
    type.datatype_reserved_by_function_get,
    type.datatype_reserved_by_function_set,
}

safety_type :: proc {
    component.component_safety_type_get,
    component.component_safety_type_set,
}

scope :: proc {
    type.datatype_scope_get,
    type.datatype_scope_set,
}

type_guid :: proc {
    component.component_type_guid_get
}

type_name :: proc {
    component.component_type_name_get,
    component.component_type_name_set,
}

type_path :: proc {
    component.component_type_path_get
}

write_permission :: proc {
    component.component_write_permission_get,
    component.component_write_permission_set,
}

// xml deserialize and serialize procedures

deserialize :: proc {
    type.datatype_deserialize,
}

serialize :: proc {
    type.datatype_serialize,
}

// release procedures

release :: proc {
    component.components_release,
    component.component_release,
    type.datatype_release,
}

// component/components types and procedures

Component     :: component.Component
Components    :: component.Components

component_new :: component.component_new

components :: proc {
    type.datatype_components_get,
    type.datatype_components_set,
}

component_add :: proc {
    component.components_add_,
    component.components_add_at_index,
    type.datatype_components_add_,
    type.datatype_components_add_at_index,
}

component_by_name :: proc {
    component.components_component_by_name,
    type.datatype_component_by_name,
}

component_by_index :: proc {
    component.components_component_by_index,
    type.datatype_component_by_index,
}

component_index :: proc {
    component.components_component_index,
    type.datatype_component_index,
}

component_count :: proc {
    component.components_count,
    type.datatype_components_count,
}

component_remove :: proc {
    component.components_remove_by_name,
    component.components_remove_by_index,
    type.datatype_remove_by_name,
    type.datatype_remove_by_index,
}

// control builder procedures

connect     :: controlbuilder.connect
connected   :: controlbuilder.connected
disconnect  :: controlbuilder.disconnect
online      :: controlbuilder.online
offline     :: controlbuilder.offline
get_setting :: controlbuilder.get_setting

// datatype types and procedures

DataType     :: type.DataType

datatype_new :: type.datatype_new
