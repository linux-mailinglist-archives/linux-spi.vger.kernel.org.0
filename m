Return-Path: <linux-spi+bounces-11815-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB54ACAC58A
	for <lists+linux-spi@lfdr.de>; Mon, 08 Dec 2025 08:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4139A303FA55
	for <lists+linux-spi@lfdr.de>; Mon,  8 Dec 2025 07:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95D72797BE;
	Mon,  8 Dec 2025 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="C0YvCSk6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5932623EA86;
	Mon,  8 Dec 2025 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765178999; cv=fail; b=aktrRccax7DN+uBSqhkrSxROFuX4K5V5zqCIVIpos0Pbbaqe87qnt+3KD/ISt87fsdT1L+2eQRWi/DgE0nuUp7sdGkmlu/WV7jF9/78gV3LdiP3I6QSV99TuY378fqfjnLkAKx9mt3a7mmbg/KQOlCRM/5VqoN/P+WIdhHFLOuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765178999; c=relaxed/simple;
	bh=pWArF7Rl6DABaLrLmNIRTns3uzgvldlqMLrrGoV5CbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PTg45F4DMRo8cVHwX2Gf6VRGywx8+R8vDB0YO71ZAyUVEkenxzMXq5dp0d/601SWqNMx763HNrbcll8hWHsXRbnTLMsfUsg4uXWmAsHapVdFA4Fzqd3j75BxtUc+Fv0DUpwqGNqPtT+uDd4XHFHdF6DKQ1VIg9U9hu5PYBF0cLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=C0YvCSk6; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B86pvmn833981;
	Mon, 8 Dec 2025 08:29:31 +0100
Received: from as8pr04cu009.outbound.protection.outlook.com (mail-westeuropeazon11011050.outbound.protection.outlook.com [52.101.70.50])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4aw0aqapp1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 08:29:31 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EuB57MyjnVgIqI73Y9O5ipSu6JmYJBKfaGHV1uSKdONCGsEif2maFYowcd7wfGm00K8i6Jmti5uyeEPr0FTMlkiUNCsaewCLBzsoLSt6wLhPP4fStw6QUmjZZaGLIszgI7GA+PkETtpoB7AKw2ZOx3Mbu6gA1+sH4nSESNsLWbLLFOTDmvzUVx5PJT+BylNLEfdC0BmAIacRb7IcuYmpJYfWPkFEMNRkHv8ON8MtJCB0DNGV7kJmpf4NzVDwq+isVPmRJwMQEcfVsT5WHnNK9m6vdOpyWn8K9wacRLfR5rsl0vTud2U5Jkg/nQPbjDDAa3V9IR3iOyT8akBESESZOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u35wuCE7vol6K/ekR+LGiXYA9EvNk8QvRyP5wyyfImM=;
 b=jyOilSWFJM/Gd8e9dSWG+vdW/vbDZ7AzJTz5bS+ozn+w75uiYvcoF2QDrzpoTTp700TtI4nSJUHq+MTzyRs5lCe83u9mlP/HdsIpxnludKVcgP/NI9UEGgPfRBInhS9AmLENcHh2QzucHs3dQA9qYvcEiqqHRKNdMwI/627MauVibCF4sDkqaNYqeVjLUg64JoVJ6ISUVWWk21hJTudMiIPjc3vVZMhBNayfSY2tqQgRbZHhpky703Qc3CsN2m62DNF3QoeRVuc6KwOmibt58hRLZJdPNTQGgO8Tsj9qTH0S7RW/MRqgaloDXo0eoGrTMfhlLzIv/e2bsMGvfmezfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u35wuCE7vol6K/ekR+LGiXYA9EvNk8QvRyP5wyyfImM=;
 b=C0YvCSk6zkHj40MgLiCDm56C8ux5CI1AeNMMCIkWDn12RGPjC1HttRVf7qGJ3jm0r2TdwaCw/07WoY5jZm7CbpVAVA8cUhH5Q4jbtbMqv0Evj9DvCWMCMQHBFS97iBRZLmC/yu77iwWk2INf2NIdwsQO8LaDKsJLPD7HW1t7SEy9Ro1ixVRRJ4XHrW6nETBVR/U2k0WQK4Ys1YfW/ZIuEJoBgh6gyCcVGBJ789OW0y5ApvQbmtq5A0dgzMGRiHyII4sJ/NQ+GN+635HFiA2sNV+hIJEpqcLcJb6hrI9GTc9AX9Ei0jqsiisLPTHWewCU1DKDu3bqouAqWauGTIYYNA==
Received: from CWLP265CA0291.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5d::15)
 by GV2PR10MB6959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 07:29:26 +0000
Received: from AM3PEPF0000A795.eurprd04.prod.outlook.com
 (2603:10a6:401:5d:cafe::b6) by CWLP265CA0291.outlook.office365.com
 (2603:10a6:401:5d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 07:29:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM3PEPF0000A795.mail.protection.outlook.com (10.167.16.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 07:29:26 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 08:30:08 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 08:29:25 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Mon, 8 Dec 2025 08:29:15 +0100
Subject: [PATCH v2 8/8] spi: stm32-qspi: Simplify SMIE interrupt test
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251208-upstream_qspi_ospi_updates-v2-8-62526c9467dc@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A795:EE_|GV2PR10MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d5c5541-ff6e-462f-9177-08de362b845c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3VmWWVLem9tUThnRHo4NWtiRzJTZ2tRZmY0RzdURHZIdkNCdjNoT3RBcENz?=
 =?utf-8?B?TGRpL0NoRFlLYk8wWmRrYk5xQW8xbFB1cDdoMzVHUnZ1aGFqNmJYOENjTHdG?=
 =?utf-8?B?Zm11NHBDZmNwUFJMZHlxVzl2ZkJSR0VhdTJCU2F0SDl1WllwalQrZDBYbTRU?=
 =?utf-8?B?aEIwM2Q4Zm1qdUt2dVdTOG1nTHF4UnFwN1N2OHdrSk5ScnM4WUlTeFY1ekxY?=
 =?utf-8?B?VFgwY2JqcTNQZXhDdW03SFJuUzYyZjAybTdISEFSZ2tDbFdzRXVuM3dmMk11?=
 =?utf-8?B?Mm8wOC9jQkJoY0VtRkFJTTV6RnIvSUdUem9vVDFFcFhCZUo5Z1hBLyt2TVFn?=
 =?utf-8?B?cUFSSDNmb3I5RXptUTUreGVpTS9wUVF0Z21ZWUw3d0FpbnNneTFXbDlIdEY1?=
 =?utf-8?B?ZWIxN3k5NXlXc3VZN2M3dVhWUkZjT3V0eHJwMkFQUGwvYm9lZmRFeWR0ZmNa?=
 =?utf-8?B?VkljcFBYWXJ3d2ZSdmtZRUN2L1k4UVJxOVlQYktWVUFyemFJN040b1JMQU5v?=
 =?utf-8?B?NkpGblBiUDNsa2Qxa0R3N2JQWW5PSlViMUlFSGpIc1c4QSt5aHBybUtIcnp6?=
 =?utf-8?B?bHpoYjRJdHl5dUNObk5DTkVWN0ZKNkhjQUt5RnlpOTZGUmZQMDhSQWNPbnNB?=
 =?utf-8?B?THhZZkRsSlloR1pDQkdxN05KRzQvQjMwQkx6UTNxdWUyYVVkcjV1VUtQNy9l?=
 =?utf-8?B?SGxWYXJZOUROU0xlb2s0c2YwWmQrOE02QTluVW9yQmgxTUVNRXpWVjRadGU4?=
 =?utf-8?B?QlJDcUlWM1dURktDODliKzJrcm1vNWpaWnNVMndJN0NVMzdSUmVIekZibnZD?=
 =?utf-8?B?bkZBcDBxWWlpOWJWa2JqYzNpN1Z5aFRVeDZiWU1URndROXJSSGlId0NYME41?=
 =?utf-8?B?WjZhNjFzK3lMTENhTEswSmMxQU43SWZJTHVKTmlkT0JJUW9jQlJBZUx4SDZN?=
 =?utf-8?B?NVpkQnRraW0rZDRabHlOM0U4cUNlelF4Wk91M0NUOTMyZ01OT082OElXZVBs?=
 =?utf-8?B?VUdWSURiNDQxY0dPUzRZRnhNSzhUR3RqY0RES2QwVU8wNllpb0ZMK3EvZExU?=
 =?utf-8?B?M0RseklIOGtWQ1EzQVIwKzhNdm5XbVRRakNrTVYxUVd6a21DcC9tQUU4M00w?=
 =?utf-8?B?RUt4VHFoNzBTaG83MFRjT2FBLytGNlNnN1hyVkdtak44MllkdVpjZTZwWCt3?=
 =?utf-8?B?V0k1VisyUklIL3NZMlpaeDMzN2NlRmljMFNOMS9FNTlSejB0THhYVndoTzdW?=
 =?utf-8?B?K0NKeWk4MjFyZ3BxVityZGRQWEQzdTJ1SS9Nbm1mWHV1UGE5TzdXTy9KOHBK?=
 =?utf-8?B?N2RLc0x0dWVVUHQ1dmtod1V6eC9sMVVRWGs3TGgwdG92SjJFcTZJczNaZmky?=
 =?utf-8?B?RFNIdnozalNzWjJ3T3VCNFJtcDRaQVp1SktNTHJTV2lXNUxLYmZBdEVuUXUv?=
 =?utf-8?B?dUdpRzEzQ0QxY2w1UUROOXRoOU94bERYd2F4TWx4VFRuSnNNRnc0bXVNSktv?=
 =?utf-8?B?bEdFbVFKUVpvZ3Jkd0hualB5MllaYXFrbnBvZE5Nd3FOak13Q1RBeHZYQXVr?=
 =?utf-8?B?ZDREVnN2Rmc4RUExVU4wQ0Zmc0l1Skxva04wWU9FYXozcUtSb1dMbjdrc2ha?=
 =?utf-8?B?Rlp0anBpRjZyQ05aamJyY3VUYmRVKy81NzVGN0pvbm9LN0VGYW9LaXVlcVJw?=
 =?utf-8?B?SjRqRm1PV3NWRFBhclQ2dFZ3Qmx2dHBSMU1IZHN0SDQrRVc3ZnlwTUZySWND?=
 =?utf-8?B?Z3ZyMGh4UEt6TzQvVHh0SlRSRzZxS0xpRzhkbjBIWjUrSTY2Skt6eHJibllG?=
 =?utf-8?B?aDVmWVlVN0VhZ2czaTFlcFl1cEg4VmFuMzBQNkpUcGRsNHZ6SkRtYStkM3lS?=
 =?utf-8?B?KzJIUjREL1lUbnNiS3BYS1Q5THBKK0dtdXZQblVrUzM1ZE1SWStuT2Y4Nkt6?=
 =?utf-8?B?bzF5Y0VJT1NRRkxuTDJNaGRocHh5eDhKVU9ROXU2dWdKYjlvc2phb3ArVkFP?=
 =?utf-8?B?ZzJlUi9EcloxVGlTTHMyMEJIT09oVEdNOElodzN5Rzh5ditjNERub0RxR0Vh?=
 =?utf-8?B?cEJDNTZmaTRXRXc4VVNmN1lCbEdXSUlnZkxMUXBEdEFOYUdyZjF4cXNyN01T?=
 =?utf-8?Q?l5Qg=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 07:29:26.4470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5c5541-ff6e-462f-9177-08de362b845c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6959
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDA2MiBTYWx0ZWRfX/rcZY1J7M0gD
 CtDeZf6n66IMUiEjECgpq3iVZaQuUctRMR9naJwq/vjp+nNaFvxhg0l3ZXXnr3X5Xz/cxoY8rRl
 JZM74Xmweu6N8iUxx3W9GIO8eUy0F2RizOgZe5Q1qZXfxPFYNmsKIVBTO/gH625+Jshm+FuzVt0
 vtDhm2kDkhDv4u8/teXoV9VPLRDmkNJrJGJo8doMglV1ZfsieqMZBTq2KPoPWxCq96ta+u3pw/c
 isHZW5pO4wC7bVChYDcYyWQacpHCxa2qNEJQH3b52MPbVpfrMgQLJbrKlIyTXSPT9h8eXdQmzUv
 JcBaCsY6l3l27wx7tyatddTRDZ/+RRj0rLvZ0cBxA1xXEC/gCBZW9je9sgVSQ/0hxUS2ImFmHKA
 Z66vD8ZsM9wyzFHn7K8gr3Jv3fpDzw==
X-Proofpoint-GUID: xccogfr95m2zof4mOxUhvowkX-LUq2Dn
X-Proofpoint-ORIG-GUID: xccogfr95m2zof4mOxUhvowkX-LUq2Dn
X-Authority-Analysis: v=2.4 cv=R/oO2NRX c=1 sm=1 tr=0 ts=69367e5b cx=c_pps
 a=KHLnCchuSInU2gMlOa4qhA==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=F6HTmrlUwN8psNLP8S8A:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512080062

SR_SMF status bit can only be set if CR_SMIE was previously set,
keep status bit check only.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index d6f6f9d4e5be..2a0ee96786fa 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -132,7 +132,7 @@ static irqreturn_t stm32_qspi_irq(int irq, void *dev_id)
 	cr = readl_relaxed(qspi->io_base + QSPI_CR);
 	sr = readl_relaxed(qspi->io_base + QSPI_SR);
 
-	if (cr & CR_SMIE && sr & SR_SMF) {
+	if (sr & SR_SMF) {
 		/* disable irq */
 		cr &= ~CR_SMIE;
 		writel_relaxed(cr, qspi->io_base + QSPI_CR);

-- 
2.43.0


