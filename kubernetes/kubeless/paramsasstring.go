package kubeless

import (
	"fmt"

	"github.com/kubeless/kubeless/pkg/functions"
)

// ParamsAsString sample function
func ParamsAsString(event functions.Event, context functions.Context) (string, error) {
	dumped := fmt.Sprintf("Event:\n%+v\nContext:\n%+v", event, context)
	return dumped, nil
}

//// from https://github.com/kubeless/kubeless/blob/master/pkg/functions/params.go
//type Extension struct {
//	Request  *http.Request
//	Response http.ResponseWriter
//	Context  context.Context
//}
//
//// Event includes information about the event source
//type Event struct {
//	Data           string
//	EventID        string
//	EventType      string
//	EventTime      string
//	EventNamespace string
//	Extensions     Extension
//}
//
//// Context includes information about the function environment
//type Context struct {
//	FunctionName string
//	Timeout      string
//	Runtime      string
//	MemoryLimit  string
//}
