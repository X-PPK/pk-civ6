
# Hall of Fame (Front-End)

# Objects vs Types
Before diving in, I’d like to explain object references and type references. There are plenty of times when data needs to be associated with more than just a game or even a player. Sometimes it needs to be associated with a city, or religion, or some arbitrary game concept. These are ‘objects’. Objects are a chunk of meta-data that additional data points and data sets can reference. Objects contain information such as name, description, owning player, plot index, type, iconage, etc. We can then reference this object using a simple integer and associate data with it. For example, if we wanted to track the number of units trained by a player, we would pass in something like “PlayerUnitsTrained”, an object id (let’s say ‘5’), and the number of units trained (let’s say ‘100’).

However, there are some cases where objects just aren’t as abstract as we’d like. For example, if we’re tracking the number of units trained by a player for each unit type. In that case we need both the player’s object id as well as a specific unit type such as UNIT_WARRIOR. We could make an additional object that represents this, or we could just specify both the player object and an additional ‘Type’ field, which simplifies things quite a bit. So, for example, our “PlayerUnitsTrainedByType” would then have the object id of the player (5) along with the type (UNIT_WARRIOR).

# Hall of Fame (Front-End)
The front-end is where all of the presentation of the data happens.  Because the data is loosely coupled, it can be visualized in many different ways and those ways can be extended/tweaked by modders.

## Configuration Database
The front-end details of the hall of fame are stored in the configuration database rather than the hall of fame database.  This is to further enforce loose coupling between the data and visualization as well as allow modders easy access to changing around visualization details without having it burned into the more persistent hall of fame database.

Relevant files:
|Name|Location|
|---|---|
|Schema|<GameDir>\Base\Assets\Configuration\Data\Schema\HallofFame.sql|
|Data|<GameDir>\Base\Assets\Configuration\Data\HallofFame.xml|

### Overriding ruleset type references
Sometimes data points may reference ruleset types that do not exist in the persistent data.  Other times, the data may need to be adjusted.  In the configuration database, there is a table called RulesetTypes.  Any information in this table, will override the information in the hall of fame database.  This is useful for providing extra localization or icon references that may not have been written out.

## Statistics
Statistics are categorized values that present data points.  Statistics typically have a caption along with an optional icon.  How they display the value varies based on the data shown and can also be tweaked using "hints" which will be described later.

### Database details
Statistics are specified in the database under the table 'Statistics' with the following columns:
|Name|Description|
|---|---|
|DataPoint|The data point to use for the statistic.
|Name|The localized name of the statistic (do not include a trailing ':').
|Icon|The icon to show along side the name of the statistic.|
|ValueIconDefault|The default icon to show along side the value of the statistic.|
|ValueIconOverride|The icon to always show, even if the value is an object or type.|
|Annotation|A localized annotation to display additional details of the statistic.|
|Direction|An integer between -1 and 1 that represents whether greater or lesser values are 'better'.  1 for greater, 0 for indifferent, -1 for lesser.|
|Category|The category id that the statistic belongs in.|
|Importance|An integer value representing how important the statistic is.  This is used for both sorting as well as picking out "highlights".|

Categories are specified by the table 'StatisticCategories' with the following columns:
|Name|Description|
|---|---|
|Category|The id of the category.|
|Name|The localized name of the category.|
|IsHidden|Whether or not the category is shown.|
|SortOrder|How the categories are sorted (lower values are shown first, equal values are sorted by Name).|

### Presentation Logic
The following logic is used by default to display the value of the data point:
Does the data point reference a type? Show the type name
Does the data point reference an object?  Show the object name.
Does the data point reference a string? Show the string.
Otherwise, show the numeric value.

The following hierarchy is used to determine which icon to use for the data point:
* ValueIconOverride
* Object Icon
* Type Icon
* ValueIconDefault

When displaying an icon, the hall of fame will attempt to use any overriding icon specified by the value and then fall-back to using the "ValueIcon" property of the statistic.

An annotation localized string key can also be provided.  This string will receive named arguments ("Name" and "Value") and will be shown in addition to showing the value.

For example:
```
Favorite Unit: [ICON_WARRIOR] Warrior (Trained 50 units.);
```
The annotation here is "Trained {Value} units.".

As mentioned earlier, statistics are partitioned by categories and within each category sorted first by their importance and second by their name.  

## Reports
Reports also make use of data points but rather than show single values, they show a spreadsheet view of values.  An example report would be showing all religions in the game with columns specifying their holy city, number of followers, etc.



### Database details
Reports are specified using up to 3 tables; Reports, ReportColumns, and ReportQueries.  In many cases, ReportQueries is not needed as a pre-defined query is good enough.

Here are the details of each table:

#### Reports
|Name|Description|
|---|---|
|Report|A string identifier for the report.|
|Scope|The 'scope' of the report.  For a description of how scopes work, see below.|
|Name|The localized name of the report.|
|Description|An optional localized description of the report.|
|InitialColumnName|The localized name of the initial column.|
|InitialColumnDescription|An optional localized description shown when mousing over the initial column.|
|InitialColumnUxHint|A hint to the UI to tune/tweak how the initial column is presented.|
|InitialColumnValueIconDefault|The default icon to show for the initial column.|
|InitialColumnValueIconOverride|The icon to always show for the initial column.|
|ShowEmptyRows|A boolean field describing whether or not to show rows where none of the major columns have values.|	
|Query|The query to use to determine the set of objects that will represent rows in the column.|
|ExtraData|Extra data provided to the query.|
|Importance|An integer value representing the importance of the report.  This is typically used to adjust sort order.|

#### ReportColumns
|Name|Description|
|---|---|
|Report|The report this is a column of.|
|Name|The localized name of the column.|
|Description|An optional localized description shown when mousing over.|
|SortOrder|The sort order of the column in the report left-to-right is lower-to-higher.|
|DataPoint|The data point identifier to visualize.|
|UxHint|A hint to the UI to tune/tweak how the data is presented.|
|Minor|A boolean field describing whether the column is 'minor'. Rows in reports are only shown if there are non-minor columns that actually have values.|
|AlwaysShow|A boolean field describing whether or not to show the column even if none of the rows actually have values.|
|ValueIconDefault|The default icon to show if the value of the cell does not contain any icons.|
|ValueIconOverride|The icon to always show.|

#### ReportQueries
|Name|Description|
|---|---|
|Query|The identifier of the query used by ReportColumns.Query|
|SQL|The actual SQL of the query.|

There are quite a few pre-defined queries that cover most bases.

Queries are SQL statements that execute against the hall of fame database and require knowledge of hall of fame schema.

The following return columns are expected from the query:
|Name|Description|
|---|---|
|ObjectId|The object id to use for a row. Can be optional so long as Type is specified.|
|Type|The ruleset type to use for a row.  Can be optional so long as ObjectId is specified.|

The following arguments are fed into the query:
|Name|Description|
|---|---|
|@ObjectId|The object id (often a player object)|
|@GameId|The game id.|
|@Ruleset|The ruleset.|
|@ExtraData| An extra field specified by 'Reports.ExtraData'.|


### Scope
Scope details what sort of coverage the report has and how its data will be queried.  Scopes are usually one of 3 values; "Ruleset", "Game" or "Player".  "Player" scoped reports will go through each player in a game and generate a report.  Queries will have the player's object id as the @ObjectId specified.  Meanwhile, "Game" scoped reports will be generated once for each game with "@GameId" being the game's id but "@ObjectId" will be null.

An example "Player" report would be "Player Cities" that list all cities for a given player.  Meanwhile a "Game" report would be "Religions" that show all religions in the game.

## Graphs

Graphs are the primary way of visualizing data sets in the hall of fame.  As of this writing, there is only 1 type of graph; a basic line graph.  However, in the future, additional styles of graphs may become available.

Graphs are similar to reports in that they use queries to enumerate sets of objects and scope to further dictate how those queries are called.

## Database Details
Graphs are specified using up to 2 tables; Graphs and GraphQueries.  In many cases, GraphQueries is not needed as a pre-defined query is good enough.

Here are the details of each table:

#### Graphs
|Name|Description|
|---|---|
|Graph|The identifier of the graph.|
|Scope|The 'scope' of the graph.  For a description of how scopes work, see below.|
|Name|A localized name for the graph.|
|Description|An optional localized description of the graph.|
|Direction|An integer value representing whether lower or higher is better.  -1 for lower, 0 for indifferent, and 1 for higher.|
|XLabel|An optional localized string for the X-Axis label.|
|YLabel|An optional localized string for the Y-Axis label.|
|Query|The query to use to determine what data sets to show.|
|DataSet|A variable passed into the query representing the desired data set identifier.|
|ExtraData|An extra data variable that can be passed into the query.
|Importance|A integer value representing how important the graph is.  Typically used for sorting.|
|UxHint|A presently unused value that hints to the UI as to how the graph should be visualized.|


#### GraphQueries
|Name|Description|
|---|---|
|Query|The identifier of the query used by Graphs.Query|
|SQL|The actual SQL of the query.|

There are quite a few pre-defined queries that cover most bases.

Queries are SQL statements that execute against the hall of fame database and require knowledge of hall of fame schema.

The following return columns are expected from the query:
|Name|Description|
|---|---|
|ObjectId|An object id reference. Can be optional if type is specified.|
|Type|The ruleset type. Can be optional if ObjectId is specified.|
|DataSetId|A reference to DataSets.DataSetId.|

The following arguments are fed into the query:
|Name|Description|
|---|---|
|@ObjectId|The object id (often a player object)|
|@GameId|The game id.|
|@Ruleset|The ruleset.|
|@DataSet|A field specified by 'Graphs.DataSet'.|
|@ExtraData| An extra field specified by 'Graphs.ExtraData'.|

## Aggregate Updates
There are times when the data recorded on the back-end simply isn't enough or cannot be properly calculated at the time of recording.  A good example of this is when trying to compute averages for various statistics, such as average city population.  This is where aggregate updates come into play.  Aggregate updates are used to perform processing on the back-end database so that additional data can be derived.  This data is recorded into the database but is typically refreshed whenever the hall of fame Ux is visible.

Aggregate updates work by using a query to enumerate a set of data points for a given scope and then execute the specified operation (such as Sum, Min, Max, Count, etc).

### Database Details
There are 4 tables used for aggregate updates, two for data points, and two for data sets.

#### DataPointAggregateUpdates
|Name|Description|
|---|---|
|AggregateDataPoint|The identifier of the data point to be written.|
|Scope|The scope of the process.|
|Operation|The operation to use. See below for details on what operations are available.|
|Query|The query to use.|
|DataPoint|The source data point, also a variable fed into the query.|
|ExtraData|An extra data value fed into the query.|
|SortIndex|The sort index that specifies the order the processes get executed.|

#### DataPointAggregateQueries
|Name|Description|
|---|---|
|Query|The identifier of the query used by DataPointAggregateUpdates.Query.|
|SQL|The actual SQL of the query.|

The following return columns are expected from the query:
|Name|Description|
|---|---|


The following arguments are fed into the query:
|Name|Description|
|---|---|
|@ObjectId|The object id (often a player object)|
|@GameId|The game id.|
|@Ruleset|The ruleset.|
|@DataPoint|A field specified by 'DataPointAggregateQueries.DataPoint'.|
|@ExtraData| An extra field specified by 'DataPointAggregateQueries.ExtraData'.|

#### DatasetAggregateUpdates
|Name|Description|
|---|---|
|AggregateDataPoint|The identifier of the data point to be written.|
|Scope|The scope of the process.|
|Operation|The operation to use. See below for details on what operations are available.|
|Query|The query to use.|
|Dataset|The source dataset, also a variable fed into the query.|
|ExtraData|An extra data value fed into the query.|
|SortIndex|The sort index that specifies the order the processes get executed.|

#### DatasetAggregateQueries
|Name|Description|
|---|---|
|Query|The identifier of the query used by DatasetAggregateUpdates.Query.|
|SQL|The actual SQL of the query.|

The following return columns are expected from the query:
|Name|Description|
|---|---|


The following arguments are fed into the query:
|Name|Description|
|---|---|
|@ObjectId|The object id (often a player object)|
|@GameId|The game id.|
|@Ruleset|The ruleset.|
|@Dataset|A field specified by 'DatasetAggregateUpdates.Dataset'.|
|@ExtraData| An extra field specified by 'DatasetAggregateUpdates.ExtraData'.|

### Work flow

Aggregate updates are executed in a well defined order so that values calculated from aggregates can be used in later ones.

Data set aggregate updates happen first.  This is because they don't rely on any existing data points and only on the data-sets which at present cannot be updated via aggregates.

Data set aggregate updates follow the same scope order as everything else, that is player then game then ruleset.  

Afterwards, Data point aggregate updates are processed using the same scope order.

### Operations

The following operations can be used:

|Name|Description|
|---|---|
|Sum|Accumulates all numeric values and returns the total.|
|Min|Finds the row with the minimal value and returns the object id and/or type along with that value.|
|MinSum|Finds the object id and/or type with an accumulated minimal value.|
|Max|Finds the row with the maximum value and returns the object id/and or type along with that value.|
|MaxSum|Finds the object id and/or type with an accumulated maximum value.|
|First|Writes the values of the first row.|
|Last|Writes the values of the last row.|
|Count|Count the number of rows.|
|Average|Average the numeric value of each row.|
|Median|Find the median of each row.|

