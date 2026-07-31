package cbopenif

import "controlbuilder"
import "type"
import "component"

DataType   :: type.DataType
Components :: component.Components
Component  :: component.Component

connect :: proc {
    controlbuilder.connect,
}

connected :: proc {
    controlbuilder.connected,
}

disconnect :: proc {
    controlbuilder.disconnect,
}

online :: proc {
    controlbuilder.online
}

offline :: proc {
    controlbuilder.offline
}

get_setting :: proc {
    controlbuilder.get_setting
}

component_new :: proc {
    component.component_new,
}

name :: proc {
    type.datatype_name_get,
    type.datatype_name_set,
    component.component_name_get,
    component.component_name_set,
}

description :: proc {
    type.datatype_description_get,
    type.datatype_description_set,
    component.component_description_get,
    component.component_description_set,
}

type_name :: proc {
    component.component_type_name_get,
    component.component_type_name_set,
}

add :: proc {
    component.components_add_,
    component.components_add_at_index,
}

count :: proc {
    component.components_count,
}

by_name :: proc {
    component.components_component_by_name,
}

by_index :: proc {
    component.components_component_by_index,
}

serialize :: proc {
    type.datatype_serialize,
}