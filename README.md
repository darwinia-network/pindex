# README

## Configuration

1. config/pindex.yml
2. Procfile.pindex



## API

1. **List messages by timespent and status**

   - Get all messages that are great than 30 minutes and have status accepted or root_ready

     ``` 
     /messages/timespent/gt/30/minutes?status=accepted,root_ready
     ```

   - Get all messages in the same conditions but in json format

     ``` 
     /messages/timespent/gt/30/minutes.json?status=accepted,root_ready
     ```

   > Pattern:
   >
   > ​     /messages/timespent/{op}/{number}/{unit}{.json}?status={status}
   >
   > op: gt|lt
   >
   > unit: seconds|minutes|hours|days
   >
   > status: accepted,root_ready,dispatch_success,dispatch_failed

   

2. **List messages** 

   - all, status is an optional filter, same for all other lists

     ``` 
     /messages?status=accepted
     ```

   - all, from crab(source chain)

     ``` 
     /messages/crab 
     ```

   - all, to crab(target chain)

     ``` 
     /messages/_/crab  
     ```

   - all, from arb_sep(source chain) to crab(target chain)

     ``` 
     /messages/arb_sep/crab 
     ```

   

3. **Show single message**

   - the index 1 message from crab to arb_sep

     ```
     /messages/crab/arb_sep/1 
     ```

   - by msg hash

     ```
     /messages/0x139501988f5142b5f12d9df60e75df625a4a0476c273b4539a1770185d92bd46 
     ```

   - by transaction hash

     ```
     /messages/0x830962b211927e61720770bad65a8be0d56263fe33dc77b04229834a462b2f83 
     ```
