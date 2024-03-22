import * as React from 'react'
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert"


export default () => {
  return  (
    <Alert>
      <AlertTitle>Hello, ShadcnUI</AlertTitle>
      <AlertDescription>
        You can add components and dependencies to your app using the cli.
      </AlertDescription>
    </Alert>
  )
}
