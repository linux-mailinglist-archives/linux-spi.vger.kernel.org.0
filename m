Return-Path: <linux-spi+bounces-11816-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EE4CAC590
	for <lists+linux-spi@lfdr.de>; Mon, 08 Dec 2025 08:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2127A30480A7
	for <lists+linux-spi@lfdr.de>; Mon,  8 Dec 2025 07:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAFE283C83;
	Mon,  8 Dec 2025 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="GCQFIdP9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795CF2522B6;
	Mon,  8 Dec 2025 07:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765179000; cv=fail; b=WiP4Z4EaVFE17+sg8FvdXORDEOWp8k+6KN8FIGr20fGjZYre98HELxTaXzcKXz6Eszr9ZY7i4QerswT/2tIKzfBVs3YYxDPGmyrSWaHgXkQVmPYNavrZFvwenPja7tiiV8Hk+qPMIu4iPeblmnTTImpI9uVqzDSaLcSBYxajw4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765179000; c=relaxed/simple;
	bh=JTHC4Vw2LcFWfwD6Uki0JMnmf+zbeWhCAfnk2DPaeZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Agt+vXRbLMBl2JHBTrJn6SpCmPNZj76D4N53J9x+nsS3m3c0JRjVkhj0wWTNO/F8sJh/xdFS6I2KrSXsoRXm5jhQ5OcAcesqwbPu/WIB+uGVT9XgC++f67bOfHefqMX2S0AlP5KsVd5dcYOMHqgYKliTm6JQiDuTBw2A98gFfgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=GCQFIdP9; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B87KxJs708938;
	Mon, 8 Dec 2025 08:29:28 +0100
Received: from am0pr83cu005.outbound.protection.outlook.com (mail-westeuropeazon11010043.outbound.protection.outlook.com [52.101.69.43])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4avcq2w157-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 08:29:27 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DD+uhKvhC9B8BFJg5hP1b5OYPLTNl1oNlB+8ej02Sycqv5pNWHNAkBPQcUpCJeBv5DiP5+1q1wWOMo3qfvoMXNFXAXoJmaqNxu5VvenKQt/2gHtgB1DAsLY50P/nUG7PWFKgdHOT6nmZm/m/bKD309RCRyKl/xbdRsaic49w7a8iUUB8tWHn4VuBPVDbKvb/LTizib2v3v9IovySp86NuzByg+lH0a6CNtFP5vPhA1lhx/61ukRXqbI9CiCRF06SG20zfsLkd0hUELne+9eN/xHCDEAMtEPBp5kTdoIurTQ72Ec4fAa+Fu0YqLqI560OTqanTkLxm+MeiqKmubqnCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdhBenL80j2dBguqTXmCc8UJoMc6CxAzHvkJU7sqDx4=;
 b=KkFDEHfy0hjtKmAvk1zvyj2ZCsVzZHQBS3f4KY1195s1BDYLbM7UGD912RYhyhURfeXnUNyE7ZpOoLtcpwurNMCNvjIWsduIauLpmWr+q1mxbTDdDS77yX8NOb18i6BZje4l52y6AvBk9TkzuQpfAWPIC4yQTpNkgugDHrJd6ItBqFM1ud7yfSO5TUp4bNjlN1798HPWQ3FPp75AmttHAmq7jo1nFeu60QpLE7h4QgD2KrBPA90+LH3Djbcng3oQNephIspJ3pqgEeQfCTcsiu26CjukTowcA7JkJ0C9ZU6Jv/1Ds0fkWemjh5lkXKsXG2TKlbfe/HcXFT805jCLLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdhBenL80j2dBguqTXmCc8UJoMc6CxAzHvkJU7sqDx4=;
 b=GCQFIdP9gmkqPlRmtI2jKV9WRtdbX/yGbvRHY7XWHMUlsQ2raKBFdAkSZzYY4DIeNVOpCsY67UJpgnLYzU1S4oBwWB19g/6lbwFsqYx3rpsJ5PBFzPuAjMlNpb1RXFMNn5rEco2DMNOMR5s+DOWHAdUPQ9/qOM3+QdeeeTStuVKh89AegeQNbaiVMNg04gNAv7x5plfv8FzB+OhKfdEn2OhtMxpF3mx9arkdEJfLNdv+kJfz/V0GzRv9v6bscZnpY1pol8mjo8txKLMOBY6ERODehaNOXN+sldBt3+SzOnmWb/3faHiIVbvJpxZE0M3OPYyg38eFgGTZOvkydkaTkg==
Received: from AM8P191CA0024.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::29)
 by AS1PR10MB5745.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 07:29:25 +0000
Received: from AM3PEPF0000A79A.eurprd04.prod.outlook.com
 (2603:10a6:20b:21a:cafe::ef) by AM8P191CA0024.outlook.office365.com
 (2603:10a6:20b:21a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 07:29:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM3PEPF0000A79A.mail.protection.outlook.com (10.167.16.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 07:29:24 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 08:30:07 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 08:29:24 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Mon, 8 Dec 2025 08:29:13 +0100
Subject: [PATCH v2 6/8] spi: stm32-qspi: Optimize FIFO accesses using u16
 or u32
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251208-upstream_qspi_ospi_updates-v2-6-62526c9467dc@foss.st.com>
References: <20251208-upstream_qspi_ospi_updates-v2-0-62526c9467dc@foss.st.com>
In-Reply-To: <20251208-upstream_qspi_ospi_updates-v2-0-62526c9467dc@foss.st.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <linux-spi@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79A:EE_|AS1PR10MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: fa08b7a2-206a-475b-2d25-08de362b8376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmUrSSt2TkpYZWNDcXhGcGMzdk16UUNWcG9SR054N3hJc0dtTWV2T2hGSGhq?=
 =?utf-8?B?WUJXTDJ2K250ZDNQaE5WOHpHRDdIWkxyZWtRc1lMTk1VTkRGTDNDZUJzL2VH?=
 =?utf-8?B?RVErZ2NmaG5UVC9wblV2TlBQcWF4SHZHbUl2cE5yRWdpTGNNZ3hyS1Y1Ym1y?=
 =?utf-8?B?Q2tyWGdUQTB2cDhKVkFGeitEeE8rRlRqRUI0cXdSa3hTQ0E3aU9HaU9VbEdq?=
 =?utf-8?B?TVNBYTRLaktZaGRaQXpTN1RCOFlwM3FWQVZjTEExOVRGQzAzVDdtR1BpQWNN?=
 =?utf-8?B?NUt0dCtWWnBRUXFjTnZ5eElGRUVBNUIyRURjbXIrTnpoaUowbEMwL1pycDFO?=
 =?utf-8?B?M0I5UHhWK2ZZanZuc1AzNDM5akhTUFdRSVZ6TDloMllEMjJPS0VmUlVVVzdJ?=
 =?utf-8?B?UkVtMGprVzNhdVo1TmxDbnNSZ1JRQ0xNeVYzQWZrc1krVFVCT0c0cDFLVER6?=
 =?utf-8?B?Q0tYTC8yT1p4R2NyRXFpUXBFVjkvd1hQMEZ5cXlYUXdUd3NLaERrdXdXdjRI?=
 =?utf-8?B?YjdnTHpTRzh2UjlFWTQ4N3ZsMXk0VG5tQWlHMHZqVHhJUDB4ZUJmWGV2Ykh1?=
 =?utf-8?B?dFdlbFpPYUxJUlRuZmNQTDFCUWxqUzRaeXU4di9OQmU5L1ZYRktxdTVBL0M1?=
 =?utf-8?B?N05tOVltNnJvaXJiUXJWU3lEcHNZb2h2S0NFK2p1eDFjSXhocDFwKzhMRzY4?=
 =?utf-8?B?TnAyNEhmbWZ6MHVRY1RjK29Ld2tzTlpISCtrYVY4a0V6dE1TY3FkdmVXeXZU?=
 =?utf-8?B?R1Z3ZzgvNWVKR0xzMThCQUVjUVFQUmpBNmhZRURCNGVieDhXM3lWRG1PeEx3?=
 =?utf-8?B?UkF2SlNVTElzM1doQkcrVEwxYlRwdzF4TmEwT25GVC9IcVU0VEV4N3FFMG9y?=
 =?utf-8?B?VTV6TnpuZjY3QjNHamlPS01IKzNzL2Q5NEgzcXpXV05iS1JraHJwZlI4TlIr?=
 =?utf-8?B?VVRObUpacVhldTUwSUp6V3pJUC9sMERzRE5yenE5NGdTZzU0akQ2eStkdW9R?=
 =?utf-8?B?OSt1UXh4NGtDcGsxeDhWZXRlSG15TUZTWTE0YlNGczdGY3dxWFQ4U21TbElQ?=
 =?utf-8?B?UFBycWhJTmt0bmhsTm91WjM0M0VxM1VFVnY1dGMyc1VZeWJpU2Fqa1EvR3V5?=
 =?utf-8?B?TW9SR3RPYVNMOUxnUm55ZnlSYmxadm9Wb0V4SzdMdWxWL3hUUnJYTFprVHNM?=
 =?utf-8?B?WHYwUlN5aFJKSmlvdVlEUlArYUtPOElPVU5SM1pQN0Vtd0VZRmlLT3BiblFn?=
 =?utf-8?B?cnFZR2Uza3pZUlpCYm5ZR3RXVDFva2RjeUttVXlycGZqQ01hM3krZjZrdUVi?=
 =?utf-8?B?ZjZpLzVhYTdTclRFSEdSR3l4QVJiNmZlVGFLQ2RtSkF6UWZ0dlJrVHgzNnQ3?=
 =?utf-8?B?ZFpteHVvNWlTVkVWKytRTXp4ai9OakZLRy9xYWNtckZkdGVyeU5TTjRlc0pZ?=
 =?utf-8?B?Sitxc2JxSitnWDBISyt4TXYxQjNPWWs4YXBCbU1XUDE0ZGp0c05sTnFnbHJn?=
 =?utf-8?B?MlExVDdkcW9IK0VsVXFydTdUdjV2RlZhWmdOT0hBbm5mOWxJaTFMQlVIN0Qy?=
 =?utf-8?B?T2NReXNDVUlYUnhvK3hBcTZxQlBmYUVKMFBnS1o2MGhtcXNiOWoxRzRpd1l5?=
 =?utf-8?B?dlZZYWZDNmJ6cDZzOG9OUUZrQjJwSWwzTXQrRjVYQTh0WEhUODBNYzRmTTFV?=
 =?utf-8?B?UDcyNFFXOFYwU3pjZnVnQ2NlbldreXN1K2ZsdG16WXRwbFJvVnhUeWlEQzR4?=
 =?utf-8?B?UzNIdW83cFVMV1dHT3FQb0tDVlJCbjNGbTJzcmtXWHZibWpvMEIxUWpvQlVM?=
 =?utf-8?B?TTJYTnFjdmR0WnJhTEZPMEMwOXpzYkZLMFE3WTlaZE9QK3Y5bEc4OWR4M3oz?=
 =?utf-8?B?QVo3Tit6OEZwUGsxYUhndUhMRUxKbm0yQWtIZCsxbDZqS2MveWlodUxGZ1JQ?=
 =?utf-8?B?UFQ5cWE2QWJnMDZkWGRTZUx3Rm5VNTMzajJWbW1JK0o3cVJnTTllQ0VVSTJY?=
 =?utf-8?B?TytkY0ZsNUN3T0VYM1NMTFpDNWthdnVRdTF1MllxNWhWVHMyQWpYOGZUb3ky?=
 =?utf-8?B?TTk5T3pNZEswcGxsNVV5MTNVb1BwRUxnQ3JmbEFYNk9MSlgwa0hYaW1BUk9T?=
 =?utf-8?Q?lXp4=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 07:29:24.9461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa08b7a2-206a-475b-2d25-08de362b8376
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5745
X-Authority-Analysis: v=2.4 cv=fc6gCkQF c=1 sm=1 tr=0 ts=69367e57 cx=c_pps
 a=CrEM3l311luX7ryRsfSUgg==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=H034yFGYOyrU3Mls5rUA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: 1G1HPBJRu4Ye5Kk9opIhZzUvejwleSRK
X-Proofpoint-ORIG-GUID: 1G1HPBJRu4Ye5Kk9opIhZzUvejwleSRK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDA2MiBTYWx0ZWRfX4iPJoxSOuPa2
 42ZjNJCI5exvt0X76WdiZ6gYZybGb1GfeErRORxz3Df4S75zB5Z1+vHPM46Rhg0I3uF4Zs3dKU0
 Pc52DYYIUlr+YdstZ2OrVwZBBXAUj8jUJL3Uhy61Me4JRicfCkyEmq597nDkVfjOhgmyqgdUPpL
 4qiY0EMQU4uO4HQNjmLNe+lgSKbKWaBZ8DkPatdFltC0Wo9TzAIQ9jE9R/eTggEfv4Yq/7qfIKf
 7V/umhEPlJ7o4tHLCJ6Yn7lNVMbuiwzijuhqDMl3j3+zgoKMexVLk4y8P3HuvfwEvQPkVx27doK
 z2icMmk9tOVvHenFeoTP24HxuOPVLLeVlL+0wtWhztXFdml881zI7HbeGMCWsw9rRfY9EVNGmah
 lxrZ8M9nfuugI1d/vzrW8SX8wLLNtw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512080062

FIFO accesses uses u8 only for read/write.
In order to optimize throughput, add u16 or u32 read/write
accesses when possible.

Running mtd_speedtest on a 4MB sNOR partition using a
stm32mp257f-ev1 board gives the following results:

           before        after   gain
Read :  5773 KiB/s  22170 KiB/s   384%
Write:   796 KiB/s    890 KiB/s    12%

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-qspi.c | 51 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index c131441e4dd4..c7f2b435d5ee 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -153,34 +153,53 @@ static irqreturn_t stm32_qspi_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void stm32_qspi_read_fifo(u8 *val, void __iomem *addr)
+static void stm32_qspi_read_fifo(void *val, void __iomem *addr, u8 len)
 {
-	*val = readb_relaxed(addr);
+	switch (len) {
+	case sizeof(u32):
+		*((u32 *)val) = readl_relaxed(addr);
+		break;
+	case sizeof(u16):
+		*((u16 *)val) = readw_relaxed(addr);
+		break;
+	case sizeof(u8):
+		*((u8 *)val) = readb_relaxed(addr);
+	};
 }
 
-static void stm32_qspi_write_fifo(u8 *val, void __iomem *addr)
+static void stm32_qspi_write_fifo(void *val, void __iomem *addr, u8 len)
 {
-	writeb_relaxed(*val, addr);
+	switch (len) {
+	case sizeof(u32):
+		writel_relaxed(*((u32 *)val), addr);
+		break;
+	case sizeof(u16):
+		writew_relaxed(*((u16 *)val), addr);
+		break;
+	case sizeof(u8):
+		writeb_relaxed(*((u8 *)val), addr);
+	};
 }
 
 static int stm32_qspi_tx_poll(struct stm32_qspi *qspi,
 			      const struct spi_mem_op *op)
 {
-	void (*tx_fifo)(u8 *val, void __iomem *addr);
+	void (*fifo)(void *val, void __iomem *addr, u8 len);
 	u32 len = op->data.nbytes, sr;
-	u8 *buf;
+	void *buf;
 	int ret;
+	u8 step;
 
 	if (op->data.dir == SPI_MEM_DATA_IN) {
-		tx_fifo = stm32_qspi_read_fifo;
+		fifo = stm32_qspi_read_fifo;
 		buf = op->data.buf.in;
 
 	} else {
-		tx_fifo = stm32_qspi_write_fifo;
-		buf = (u8 *)op->data.buf.out;
+		fifo = stm32_qspi_write_fifo;
+		buf = (void *)op->data.buf.out;
 	}
 
-	while (len--) {
+	while (len) {
 		ret = readl_relaxed_poll_timeout_atomic(qspi->io_base + QSPI_SR,
 							sr, (sr & SR_FTF), 1,
 							STM32_FIFO_TIMEOUT_US);
@@ -189,7 +208,17 @@ static int stm32_qspi_tx_poll(struct stm32_qspi *qspi,
 				len, sr);
 			return ret;
 		}
-		tx_fifo(buf++, qspi->io_base + QSPI_DR);
+
+		if (len >= sizeof(u32))
+			step = sizeof(u32);
+		else if (len >= sizeof(u16))
+			step = sizeof(u16);
+		else
+			step = sizeof(u8);
+
+		fifo(buf, qspi->io_base + QSPI_DR, step);
+		len -= step;
+		buf += step;
 	}
 
 	return 0;

-- 
2.43.0


