Return-Path: <linux-spi+bounces-12186-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81422CF8421
	for <lists+linux-spi@lfdr.de>; Tue, 06 Jan 2026 13:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D1E1302523C
	for <lists+linux-spi@lfdr.de>; Tue,  6 Jan 2026 12:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F8E33123E;
	Tue,  6 Jan 2026 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="hLAF6njm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5D63314A8;
	Tue,  6 Jan 2026 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767701707; cv=fail; b=GDtCsFRYQLKVKayHY6fpQQjTOOcfk0XgnELlyo303Pf3S0QSDcO8lwVkcsf6rsmmM2Hok7KWJvutGlPssQXC2UrhzrGQbAWG4OSXb0bXWRMkAVO87aQkjuSuMU1HxHlK0BrH+TGtjNpfHHeO8VtEBCyEPlhoegd/FFmzGG6Oyxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767701707; c=relaxed/simple;
	bh=KswOafBNh3KGYGVhq9IJYXBg/YYzt41Scg2MYkWstjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SqK4pAmOBZ7ZrbZ0JA0AMVaTn8YmWWq9mjUuSaZ4MCO8shS4J1YLI8+LBcHA1TRDeJ1tA+/2kxFVqtSuVwAqBSuetuKEKxqj8rXPoJ8+2eCWp8jtrsEBFPZXXwyfFbzMCoENtPCAlwc1P6d8Vrhk+4fxhQQ6psR7IbUUreneRP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=hLAF6njm; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606C1Oco4151969;
	Tue, 6 Jan 2026 13:14:53 +0100
Received: from am0pr83cu005.outbound.protection.outlook.com (mail-westeuropeazon11010020.outbound.protection.outlook.com [52.101.69.20])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4bfdj5fjfc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 13:14:53 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEa20S0dtEuhMGOyPyn3bWkKmufNlXBRFHsdL/CTA/S6F9dY8htmL1UmjRRCgK6UxasaViR7wxpwHTQlDgf9KgJLi2gTcl3LGD1iqUbMKkcHCUoezVwexSKf3iMGyanovYO8I6u3TIKn/x/ttc8BHUopDS9iW0ki+VR5S0Jwfjruj9tw2wcsAZY4bEuEki7lPgUHdfCkF38L+DWdLmx+nci/PwR1jUh5O/87ShZsqyCc/0zh25oC0p/kjTcFImVkFN5jRxjL5P78TLK51D2exqG0jY9pw8KIv2g545WHw5x+JHs1IiXFVtc7/BA/eHQ37ayhVqsA/LXp15AGCag5fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+zVhj7RYXo671vhsrylDRFAuTvwY2Trp+iVjnmcs2s=;
 b=MjfY88tDvgvGFWXzUnx1RGt+kXyTcONvyBfoEdFchrLpDjgWdvbA/aL4VjrB+bunkn3pRwxtKM3zfk9loz7tYUdD7wwdPKickc3iWhs0NAb6q5360qbzqCOCoHWttNr6CIWnZ38sdMMG9RhfdqEqSqPY70rYh0vHVaeXYY3dVIehGywtuxoSUnRE0FyCewM2XkIKbGD5xbcN+te60ylIlm8Wj3oGbKYLePZh0u5ccsrV+jWF1zvuLmL4cljxzlxUJF6zpBDWiuHs/RBQMdmGQZ8PgtKgomMhh/aoFW+PZ/Ntd+xnzk/bMKIa6MDE7e6D9ki//KhhA7VKTDrS+QB+Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+zVhj7RYXo671vhsrylDRFAuTvwY2Trp+iVjnmcs2s=;
 b=hLAF6njmGMpDx2j9T2kxiO5goJOFsmo1exFwk0wcquNiiDBtBwfluEF79AmBZmaoItJ5s5uS0saMXUNofenNQlnImy8UDEvmY6m61AhJC29bB0h7nzC9+N+rwkU6q416CJjErvBKlJBnSEsrV3wTpJQM4j35oakL59tiY9012mlxWrh+ci2hWstR+px8sC+QHM0CZ3HupmzMHJxsoKbWpqdeCmvcAjRGjVJjix0z7gUmg3oAFNEuzjY73cSGy8gMmHEwCA8s0+mBLNMM5+eXS2wdHPHKN95jTplp/eH47XwVK0uM3p24MnEeczWpd1yqjKTa0I5ra6fdK2J1XMQEbA==
Received: from AM0PR02CA0121.eurprd02.prod.outlook.com (2603:10a6:20b:28c::18)
 by AMBPR10MB9706.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:769::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 12:14:50 +0000
Received: from AMS1EPF0000004B.eurprd04.prod.outlook.com
 (2603:10a6:20b:28c:cafe::21) by AM0PR02CA0121.outlook.office365.com
 (2603:10a6:20b:28c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 12:14:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF0000004B.mail.protection.outlook.com (10.167.16.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 12:14:49 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 6 Jan
 2026 13:16:02 +0100
Received: from localhost (10.130.74.193) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 13:14:49 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
Date: Tue, 6 Jan 2026 13:14:17 +0100
Subject: [PATCH 1/4] drivers: spi: st: remove __maybe_unused for
 suspend/resume
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260106-spi_st_maybe_unused_removal-v1-1-8f5ca7136e96@foss.st.com>
References: <20260106-spi_st_maybe_unused_removal-v1-0-8f5ca7136e96@foss.st.com>
In-Reply-To: <20260106-spi_st_maybe_unused_removal-v1-0-8f5ca7136e96@foss.st.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Alain Volmat
	<alain.volmat@foss.st.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004B:EE_|AMBPR10MB9706:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c23a018-d6f2-412c-1dc1-08de4d1d30a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTByb0lQNURHRll0NDFjT05kYlJ0by82RjJjQ1BDR2NEMkxMRDllSWtxZ1JJ?=
 =?utf-8?B?OWNXSkN5MnFIaFJsLzRuc2c3dVlnNTRPZER6ZjBTRWJkQldIYUt4QzU2YWhi?=
 =?utf-8?B?YUduR3hDMVljVGpMdEJEQVc1MmR6RXQwWnQ4cjBKOTRJNitCYnZValJLK2VK?=
 =?utf-8?B?MU5Ha25RaThsbUx5ZDlFVkNtaUNFb0pzbkdNZnZnWjhwM3M5dUxwaXlUTzdC?=
 =?utf-8?B?Q3hWRHNFNjhTeklPYXhLLzhaWGpHUHZzWUlkQ2c2MlB4UFRWS1JKSC9Ba05z?=
 =?utf-8?B?MWlhWDhkcDRhNVUyL0tKK0VKd0RUbnVrTmhuL3R4bll5RlUvM2R5MTVGQmRa?=
 =?utf-8?B?RWEvOXR1UHNCMVI3Zlo5SHNRSkJkeHBDVTZreE5vTWVCWFZic01YZFYyNCtn?=
 =?utf-8?B?WU9UQ2ZpM2l1MHJaODNabVUxbVByVHVVZE43RlJQMCt6SFdOZElnNktVV0xH?=
 =?utf-8?B?Wmk5bWRzbjJ1MjNDNmVFZXhzcGNONVhUZS9GYkFTYUljemhkKzdxUkp5Rzlv?=
 =?utf-8?B?cmgvdnhJV0hDM242Q3hsSmhvUUdCSTEvNXlUUlNqR2xjTzhZdVRaUkgvK2hI?=
 =?utf-8?B?WDkySndLOXV3NlF1TEpXbVhveXp4andpZkU0QTQ5SFhCRkhTQUhRN3RHNmhp?=
 =?utf-8?B?eXN1ZFpDdFZ5NVhsZWhveTZiNUpFcGlWMWF4U1YweGM5K0VKblJlU2M5R1ls?=
 =?utf-8?B?Q2h0aW5qZU1YdlZOcWVmYnZLV3FxeHVNb2ZNRUliQzcrTlEzd1JYeDkxa3cz?=
 =?utf-8?B?NXc2VGlTVzErNjhncmZIRzFOZ1lhVUJnZ0Q5UkMzbDM5MXIrSElzZ1RUYkIx?=
 =?utf-8?B?OUhNaWR2eUp5TkVzam1UL3BTMmRrZHVIc3U3NE1IK1VvTmJmV0ZSaUZhemhn?=
 =?utf-8?B?bnRFU1NPTjdrNG5QZ3RSV1BMSml2NkdrVXgxWFh3aUE2aElIdTFVcWQ5dkxi?=
 =?utf-8?B?YmlhMllaVVdSOFFUQis0VWZ3bUlDazhDTTBhSjVMck4vYStLY0dMbldzVGc4?=
 =?utf-8?B?S3c5dUcxS3BMS01lbGVoSERQK3cxMFNLSDk4bWRFSVZ4bU5zSXVmQVJvNzUr?=
 =?utf-8?B?Qys0dm1MMlpmUVNXSXdIOWhhUUk3YWJESm5zRTB6VXpQak5jTVdjbW93Q0hR?=
 =?utf-8?B?T1Z4L3VURjJrU29rZDRBK1hRZkF3L0d4NnEzSzdGWXdlS0s4VnJZd3FaOEFl?=
 =?utf-8?B?NzVvNEUyZWpBUThkWDRaUzhIbjBjU1JJMENpWjVqMG1vRXFRUG5SeXdEKzFr?=
 =?utf-8?B?OE9xb1FPdUFDUWRqbnhDTmdMNHFXZk5tNTVqUXJ5N1FWa1JFRi9POUp3WVZs?=
 =?utf-8?B?bWxPMEJFZ3llanBNZlFFZE42VDQ5czF3VDV5RW9wSE1TSXJVSmk4a3phTTdk?=
 =?utf-8?B?V00zMGRDTUx3NHlkeFliQTAzbjRaR1A0MHBrRVlmR2Nhb0w0R3VFK0NnRW9m?=
 =?utf-8?B?YSt4ajgyNUVDa2c4eUFVVmc5MHBRQlpEeDJLc0lNbVJGSEkyM211ZWxrNEJU?=
 =?utf-8?B?WklMTXU3N1NLcEJHczJmQmdBMmwrTjV0REJqWjREOWd4S0hyOE1XdVJSeDdK?=
 =?utf-8?B?VlVoeFNpVG1zdXdBQm9Cb0VBbW1vQU9wcmErdUtkNXFLSWtmSEh6c2kxZEJt?=
 =?utf-8?B?OUUrY0duQ2ZrUytRZ1NJRVZFa1NrbGJqa09ycm9ETnltZ0NTVU05dmpEa283?=
 =?utf-8?B?NDFqTkd2bnpXSUNFL0lJaXM1L2JkRTRJRld5VCtHcmU4ZWlka3B1MW1XeWJ2?=
 =?utf-8?B?ZzFWRU5JTkVBUktuRnFMVVNzc2o3NE8vd1c4MHV3eWVRUmFXaURxK3p5b2Z2?=
 =?utf-8?B?WFhZeXZaQlF6NlRXSk9uWDEvK1RnOWNpMHMyajFsU0RRMitDanRvdFlhME82?=
 =?utf-8?B?NHRLaHdZdWlwNnFuc3B6b3lrTjA2SU5hZFRNaWhNYmMvVVZCd2VObU1jSG1J?=
 =?utf-8?B?QUZUc3VQTHBVdkpZRmxYbWhVUXEyb2VKcWFaTGVvZlY2amdqdSt5YzNZWDJT?=
 =?utf-8?B?RlArYlhjanBEbXlDN3AwWEN6cWFNOWY0VXRuZUwxdHdBQkw5OU4weXlHbXJq?=
 =?utf-8?B?NGc3RVRCRHFQZ3dSUlhpYy9EWEVLeHZSdmlZVlh4K1owdXEvRzB6dnNpeUFM?=
 =?utf-8?Q?7BJs=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 12:14:49.7764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c23a018-d6f2-412c-1dc1-08de4d1d30a4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9706
X-Proofpoint-ORIG-GUID: VqD4cIL0FOEhL5pUiECRyV2UJMzh09R8
X-Proofpoint-GUID: VqD4cIL0FOEhL5pUiECRyV2UJMzh09R8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEwNiBTYWx0ZWRfX32znUKQDJjBU
 DHY97uoTGDsM9t2X3N42TFeTsNisEQz2NVrJRveppjtrMxqvYtnFVVtTzrqVKNnAQ971VYJpDEl
 7xaQkxEu9Qllh/5VELUVwiSYDywxZ2C/fcCPwFYSxqSB62aZw9QeXrx5NfmVbgnb7Uvk5OEnWZq
 SF2CJK/ffZVksfb9DTwcBELgzUUiNimbNyzypTkwMhdBG/KNFjx/ZJYjH8SwI824gp7JuQcdG0t
 69NNUIW0yaDO3lfEFF0u9NkK5z7Akh3qRcWA1qzZHzqdpVIMA87FyiB/GJKfR7kGd2Q/1twoetO
 ZyuHSXIP43+cxN2UWmpduyxWyj/Amahuvw1SY2qtQsxdtvuljImC750e7MCyuvm9pOMwgeq0rke
 n/9SuDOOU11AW4/inPKwB1+LnLqBwKvIGKnhpZHmDWEE/JCAcEO6efK5HUKx01m8aMFEEP9eeeJ
 6JbbWLL5sHyeuo7lugA==
X-Authority-Analysis: v=2.4 cv=SMBPlevH c=1 sm=1 tr=0 ts=695cfcbd cx=c_pps
 a=dZNRamlC49a2syOZXmJYPQ==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wL9PcE0S0AMA:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=5GynrCW7sPYdyOdSDIsA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060106

Remove useless __maybe_unused statements for suspend and resume
functions since this is now used via pm_ptr.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/spi/spi-st-ssc4.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index c07c61dc4938..b173ef70d77e 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -403,7 +403,7 @@ static int spi_st_runtime_resume(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused spi_st_suspend(struct device *dev)
+static int spi_st_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	int ret;
@@ -415,7 +415,7 @@ static int __maybe_unused spi_st_suspend(struct device *dev)
 	return pm_runtime_force_suspend(dev);
 }
 
-static int __maybe_unused spi_st_resume(struct device *dev)
+static int spi_st_resume(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	int ret;

-- 
2.34.1


