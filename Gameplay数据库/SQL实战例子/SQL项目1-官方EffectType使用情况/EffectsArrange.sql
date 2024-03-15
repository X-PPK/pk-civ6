-- Author: 帅气的凯(皮皮凯PiPiKai)
-- DateCreated: 3/12/2024 18:24:39 PM
CREATE TABLE EffectsArrange (
    EffectType              TEXT,
    CollectionType          TEXT,
    ModifierType            TEXT,
    RunOnce                 BOOLEAN CHECK (RunOnce IN (0, 1) ) 
                                    DEFAULT 0,
    NewOnly                 BOOLEAN CHECK (NewOnly IN (0, 1) ) 
                                    DEFAULT 0,
    Permanent               BOOLEAN CHECK (Permanent IN (0, 1) ) 
                                    DEFAULT 0,
    Repeatable              BOOLEAN CHECK (Repeatable IN (0, 1) ) 
                                    DEFAULT 0,
    OwnerRequirementSetId   TEXT,
    SubjectRequirementSetId TEXT,
    ModifierId              TEXT,
    Name                    TEXT    DEFAULT NULL,
    Value                   TEXT    DEFAULT NULL,
    Type                    TEXT    DEFAULT NULL,
    TableName               TEXT    DEFAULT NULL,
    LOCType                 TEXT    DEFAULT NULL,
    LOCName                 TEXT,
    LOCDesc                 TEXT    DEFAULT NULL,
    LOCDesc2                TEXT    DEFAULT NULL,
    LOCStandby              TEXT,
    Repeat                  INTEGER DEFAULT (0),
    PRIMARY KEY (
        ModifierId,
        Name
    )
);

-- 补齐没有ModifierArguments参数的 ModifierId 到 EffectsArrange 
INSERT INTO EffectsArrange (ModifierId, Name, Value, Type)
SELECT DISTINCT MA.ModifierId, MA.Name, MA.Value, MA.Type
FROM ModifierArguments MA
UNION ALL
SELECT DISTINCT M.ModifierId, "NoName", NULL, NULL
FROM Modifiers M
WHERE NOT EXISTS (
    SELECT 1
    FROM ModifierArguments MA
    WHERE MA.ModifierId = M.ModifierId
);


-- 更新 EffectsArrange 表与 Modifiers 表的匹配数据
-- 更新 EffectsArrange 表与 DynamicModifiers 表的匹配数据
-- 更新 ModifierStrings 表与 DynamicModifiers 表的匹配数据
UPDATE EffectsArrange
SET ModifierType = M.ModifierType,
    RunOnce = M.RunOnce,
    NewOnly = M.NewOnly,
    Permanent = M.Permanent,
    Repeatable = M.Repeatable,
    OwnerRequirementSetId = M.OwnerRequirementSetId,
    SubjectRequirementSetId = M.SubjectRequirementSetId
FROM Modifiers M
WHERE EffectsArrange.ModifierId = M.ModifierId;

UPDATE EffectsArrange
SET LOCDesc2 = MS.Text 
FROM ModifierStrings MS
WHERE EffectsArrange.ModifierId = MS.ModifierId;

UPDATE EffectsArrange
SET EffectType = DM.EffectType,
    CollectionType = DM.CollectionType
FROM DynamicModifiers DM
WHERE EffectsArrange.ModifierType = DM.ModifierType;
-- 更新 EffectsArrange 表与 相关ModifierId为纽带 表的匹配数据
-- 下面这段代码将在TableName不为NULL的情况下，每次覆盖修改时将Repeat值加1。
-- Repeat = CASE WHEN TableName IS NOT NULL THEN Repeat + 1 ELSE Repeat END
-- [10:04:40] 在数据库“DebugGameplay”执行 SQL 查询时发生错误：ambiguous column name: TableName,TableName不明确的列名所有改为 EffectsArrange.TableName
-- Repeat = CASE WHEN EffectsArrange.TableName IS NOT NULL THEN Repeat + 1 ELSE Repeat END
WITH ModifierData AS (
    SELECT DISTINCT "Beliefs信条" AS TableName, BeliefType AS LOCType, BeliefModifiers.ModifierId
    FROM BeliefModifiers
    UNION ALL
    SELECT DISTINCT "Alliances联盟", AllianceType, AllianceEffects.ModifierId
    FROM AllianceEffects
    UNION ALL
    SELECT DISTINCT "Buildings建筑/奇观", BuildingType, BuildingModifiers.ModifierId
    FROM BuildingModifiers
    UNION ALL
    SELECT DISTINCT "Civics市政", CivicType, CivicModifiers.ModifierId
    FROM CivicModifiers
    UNION ALL
    SELECT DISTINCT "CommemorationTypes时代着力点", CommemorationType, CommemorationModifiers.ModifierId
    FROM CommemorationModifiers
    UNION ALL
    SELECT DISTINCT "Districts区域", DistrictType, DistrictModifiers.ModifierId
    FROM DistrictModifiers
    UNION ALL
    SELECT DISTINCT "Technologys科技", TechnologyType, TechnologyModifiers.ModifierId
    FROM TechnologyModifiers
    UNION ALL
    SELECT DISTINCT "Traits特性", TraitType, TraitModifiers.ModifierId
    FROM TraitModifiers
    UNION ALL
    SELECT DISTINCT "Governments政体", GovernmentType, GovernmentModifiers.ModifierId
    FROM GovernmentModifiers
    UNION ALL
    SELECT DISTINCT "GreatPersonIndividualBirth将修改器与伟人绑定", GreatPersonIndividualType, GreatPersonIndividualBirthModifiers.ModifierId
    FROM GreatPersonIndividualBirthModifiers
    UNION ALL
    SELECT DISTINCT "GreatWork著作/遗物", GreatWorkType, GreatWorkModifiers.ModifierId
    FROM GreatWorkModifiers
    UNION ALL
    SELECT DISTINCT "Governor总督", GovernorType, GovernorModifiers.ModifierId
    FROM GovernorModifiers
    UNION ALL
    SELECT DISTINCT "GovernorPromotion总督晋升", GovernorPromotionType, GovernorPromotionModifiers.ModifierId
    FROM GovernorPromotionModifiers
    UNION ALL
    SELECT DISTINCT "Improvement改良", ImprovementType, ImprovementModifiers.ModifierId
    FROM ImprovementModifiers
    UNION ALL
    SELECT DISTINCT "Policies政策", PolicyType, PolicyModifiers.ModifierId
    FROM PolicyModifiers
    UNION ALL
    SELECT DISTINCT "Projects项目", ProjectType, ProjectCompletionModifiers.ModifierId
    FROM ProjectCompletionModifiers
    UNION ALL
    SELECT DISTINCT "UnitAbility单位能力", UnitAbilityType, UnitAbilityModifiers.ModifierId
    FROM UnitAbilityModifiers
    UNION ALL
    SELECT DISTINCT "UnitPromotion单位晋升能力", UnitPromotionType, UnitPromotionModifiers.ModifierId
    FROM UnitPromotionModifiers
    UNION ALL
    SELECT DISTINCT "Game游戏全局", NULL, GameModifiers.ModifierId
    FROM GameModifiers
)
UPDATE EffectsArrange
SET TableName = md.TableName,
    LOCType = md.LOCType,
    Repeat = CASE WHEN EffectsArrange.TableName IS NOT NULL THEN Repeat + 1 ELSE Repeat END
FROM ModifierData md
WHERE EffectsArrange.ModifierId = md.ModifierId;

WITH ModifierData2 AS (
    SELECT DISTINCT "Emergencys紧急活动Buff" AS TableName, EmergencyType AS LOCType, Description AS LOCDesc, EmergencyBuffs.ModifierId
    FROM EmergencyBuffs
    UNION ALL
    SELECT DISTINCT "Emergencys紧急活动奖励！!", EmergencyType, Description, EmergencyRewards.ModifierId
    FROM EmergencyRewards
    UNION ALL
    SELECT DISTINCT "GoodyHutSubTypes定义村庄效果类型的表", SubTypeGoodyHut, Description, GoodyHutSubTypes.ModifierId
    FROM GoodyHutSubTypes
    UNION ALL
    SELECT DISTINCT "GreatPersonIndividualAction将修改器与伟人激活能力绑定", GreatPersonIndividualType, NULL, GreatPersonIndividualActionModifiers.ModifierId
    FROM GreatPersonIndividualActionModifiers
)
UPDATE EffectsArrange
SET TableName = md.TableName,
    LOCType = md.LOCType,
    LOCDesc = md.LOCDesc,
    Repeat = CASE WHEN EffectsArrange.TableName IS NOT NULL THEN Repeat + 1 ELSE Repeat END
FROM ModifierData2 md
WHERE EffectsArrange.ModifierId = md.ModifierId AND md.TableName IS NOT NULL;

UPDATE EffectsArrange
SET LOCStandby = GM.AttachmentTargetType
FROM GreatPersonIndividualActionModifiers GM
WHERE EffectsArrange.ModifierId = GM.ModifierId;
--补上未被使用没有和ModifierId绑定的ModifierType，现在所有EffectType均已入表，但无法排除情景模式的使用情况以及官方dll有但所开放xml文件中未利用的
INSERT INTO EffectsArrange (ModifierId, EffectType, CollectionType)
SELECT DISTINCT "NoModifierId_" || DM.ModifierType, DM.EffectType, DM.CollectionType
FROM DynamicModifiers DM
WHERE NOT EXISTS (
    SELECT 1
    FROM Modifiers M
    WHERE M.ModifierType = DM.ModifierType
);
----------------------------------------------------------------------
-- 2024/3/15
-- 继续推进该工程，我需要直接把对应文本变量LOCDesc补上，并给予对应文本
----------------------------------------------------------------------
-- 完成大部分描述文本变量
WITH ModifierData3 AS (
    SELECT DISTINCT "Alliances联盟" AS TableName, Name AS LOCName,  Description AS LOCDesc, NULL AS LOCDesc2, AllianceType AS LOCType
    FROM Alliances
    UNION ALL
    SELECT DISTINCT "Beliefs信条", Name, Description, NULL, BeliefType
    FROM Beliefs
    UNION ALL
    SELECT DISTINCT "Buildings建筑/奇观", Name, Description, NULL, BuildingType
    FROM Buildings
    UNION ALL
    SELECT DISTINCT "Civics市政", Name, Description, NULL, CivicType
    FROM Civics
    UNION ALL
    SELECT DISTINCT "Districts区域", Name, Description, NULL, DistrictType
    FROM Districts
    UNION ALL
    SELECT DISTINCT "Technologys科技", Name, Description, NULL, TechnologyType
    FROM Technologies
    UNION ALL
    SELECT DISTINCT "Traits特性", Name, Description, NULL, TraitType
    FROM Traits
    UNION ALL
    SELECT DISTINCT "Governor总督", Name, Description, NULL, GovernorType
    FROM Governors
    UNION ALL
    SELECT DISTINCT "GovernorPromotion总督晋升", Name, Description, NULL, GovernorPromotionType
    FROM GovernorPromotions
    UNION ALL
    SELECT DISTINCT "Improvement改良", Name, Description, NULL, ImprovementType
    FROM Improvements
    UNION ALL
    SELECT DISTINCT "Policies政策", Name, Description, NULL, PolicyType
    FROM Policies
    UNION ALL
    SELECT DISTINCT "Projects项目", Name, Description, NULL, ProjectType
    FROM Projects
    UNION ALL
    SELECT DISTINCT "UnitAbilitys单位能力", Name, Description, NULL, UnitAbilityType
    FROM UnitAbilities
    UNION ALL
    SELECT DISTINCT "UnitPromotions单位晋升能力", Name, Description, NULL, UnitPromotionType
    FROM UnitPromotions
    UNION ALL
    SELECT DISTINCT "Governments政体", Name, InherentBonusDesc, AccumulatedBonusShortDesc, GovernmentType
    FROM Governments
    UNION ALL
    SELECT DISTINCT "GreatPersonIndividualAction将修改器与伟人激活能力绑定", Name, NULL, NULL, GreatPersonIndividualType
    FROM GreatPersonIndividuals
    UNION ALL
    SELECT DISTINCT "GreatPersonIndividualBirth将修改器与伟人绑定", Name, NULL, NULL, GreatPersonIndividualType
    FROM GreatPersonIndividuals
    UNION ALL
    SELECT DISTINCT "GreatWork著作/遗物", Name, NULL, NULL, GreatWorkType
    FROM GreatWorks
    UNION ALL
    SELECT DISTINCT "Emergencys紧急活动Buff", Name, NULL, NULL, EmergencyType
    FROM EmergencyAlliances
    UNION ALL
    SELECT DISTINCT "Emergencys紧急活动奖励！!", Name, NULL, NULL, EmergencyType
    FROM EmergencyAlliances
)
UPDATE EffectsArrange
SET LOCName = md.LOCName,
    LOCDesc = CASE WHEN EffectsArrange.LOCDesc IS NOT NULL THEN md.LOCDesc ELSE EffectsArrange.LOCDesc END,
    LOCDesc2 = CASE WHEN EffectsArrange.LOCDesc2 IS NOT NULL THEN md.LOCDesc2 ELSE EffectsArrange.LOCDesc2 END,
    Repeat = CASE WHEN (EffectsArrange.LOCDesc2 IS NOT NULL AND md.LOCDesc2 IS NOT NULL) THEN Repeat + 10000 ELSE Repeat END
FROM ModifierData3 md
WHERE EffectsArrange.TableName = md.TableName AND EffectsArrange.LOCType = md.LOCType;

UPDATE EffectsArrange
SET LOCName = CT.CategoryDescription,
    LOCDesc = CT.GoldenAgeBonusDescription,
    LOCDesc2 = CT.NormalAgeBonusDescription,
    LOCStandby = CT.DarkAgeBonusDescription
FROM GreatPersonIndividuals GI
WHERE EffectsArrange.LOCType = GI.CommemorationType;
----------------------------------------------------------------------
-- 文本变量都已经收录
-- 是时候把文本表导入库中并给予EffectsArrange对应文本
----------------------------------------------------------------------
-- 首先在DebugLocalization库构建中文表打包，复制到DebugGameplay库以便和EffectsArrange表结合
-- （推荐SQLiteStudio鼠标点击拖动复制，你难道非要导入导出？
-- 如果你希望游戏运行时自动生成表，要注意官方这里三个表是分开加载生成的，我不确定是否可选，总之到这里为止前面的内容在modinfo UpdateDatabase可以运行生成
-- 构建打包表LocalizedTextCN,
CREATE TABLE LocalizedTextCN (
    Tag       TEXT NOT NULL,
    Text      TEXT,
    PRIMARY KEY (Tag)
);
INSERT INTO LocalizedTextCN (Tag, Text)
SELECT LT.Tag, LT.Text
FROM LocalizedText LT
WHERE LT.Language = "zh_Hans_CN";

-- 现在DebugGameplay库有了LocalizedTextCN
/*--经典的错误
UPDATE EffectsArrange
SET LOCName = (SELECT Text FROM LocalizedTextCN WHERE EffectsArrange.LOCName = LocalizedTextCN.Tag),
    LOCDesc = (SELECT Text FROM LocalizedTextCN WHERE EffectsArrange.LOCDesc = LocalizedTextCN.Tag),
    LOCDesc2 = (SELECT Text FROM LocalizedTextCN WHERE EffectsArrange.LOCDesc2 = LocalizedTextCN.Tag),
    LOCStandby = (SELECT Text FROM LocalizedTextCN WHERE (EffectsArrange.LOCStandby = LocalizedTextCN.Tag AND EffectsArrange.TableName = "CommemorationTypes时代着力点"));
-- 这段代码使用了子查询来更新EffectsArrange表中的LOCName、LOCDesc、LOCDesc2和LOCStandby字段。
-- 如果WHERE子句没有找到符合条件的记录，那么查询结果将为空，但是仍然会执行UPDATE语句，导致所有行的这些字段都被设置为NULL。

-- 为了避免这种情况，可以使用IFNULL函数来解决这个问题。
-- IFNULL函数会检查第一个参数是否为NULL，如果是，则返回第二个参数，否则返回第一个参数。
-- 这样，如果子查询没有找到匹配的记录，IFNULL函数将返回当前行的原始值，而不是NULL。
*/
UPDATE EffectsArrange
SET LOCName = IFNULL((SELECT Text FROM LocalizedTextCN WHERE EffectsArrange.LOCName = LocalizedTextCN.Tag), LOCName),
    LOCDesc = IFNULL((SELECT Text FROM LocalizedTextCN WHERE EffectsArrange.LOCDesc = LocalizedTextCN.Tag), LOCDesc),
    LOCDesc2 = IFNULL((SELECT Text FROM LocalizedTextCN WHERE EffectsArrange.LOCDesc2 = LocalizedTextCN.Tag), LOCDesc2),
    LOCStandby = IFNULL((SELECT Text FROM LocalizedTextCN WHERE (EffectsArrange.LOCStandby = LocalizedTextCN.Tag AND EffectsArrange.TableName = "CommemorationTypes时代着力点")), LOCStandby);


-- 导出EffectsArrange表，剩下的就是excel操作了，进一步整理，就不去讲了，如果后续整理好这里应该会上传的


-- 最后删除没有用的表，LocalizedTextCN别忘记把DebugLocalization库里的也删除
-- 也可以SQLiteStudio鼠标点击表右键删除
DROP TABLE LocalizedTextCN
DROP TABLE EffectsArrange
-- 实际更快方法直接删除这几个库文件，反正游戏每次新对局都会重新生成
