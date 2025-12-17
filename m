Return-Path: <linux-spi+bounces-11978-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AEACC6542
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 08:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B709D300BD8F
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 07:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0A13321CD;
	Wed, 17 Dec 2025 07:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="a70elMAc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFDC335083;
	Wed, 17 Dec 2025 07:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765954966; cv=fail; b=S7EYbnBp3TDbe4qYCy+JSDkKTjDRoZ6ZDIf+Fvv3xX/ygCya1YS9RYF47hhvTHePIwjMpv4nBKhQHDvXKHkA9EEKGocU3kHa8mhj8phxV7qrplcoRpDWLlsOqxvk0qU5S7ECcG8TdqHDRKmpqZGMPWUYDOrbN0V2kxo8OSOga3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765954966; c=relaxed/simple;
	bh=WPfZlq/ycgvcWWKwh52GsFHcfIsTdsXPg7xNCFDL5Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OplJ4tQwveSdU3PZ/7oh84uPIMYoE0ys/gYHpRImvFyVtHW5TISaQTRBP0waxc3BQzBSEeUtU87W1itE71Rv91aVXIlthfYXHDDQr7VNCz+Pep+K1W8KkyVddKqb3u3lowhtBvEXezrOb2gEnKxa147rRykE+zuXEwi8KtfBxvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=a70elMAc; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BH6iGMP2324273;
	Wed, 17 Dec 2025 08:02:09 +0100
Received: from osppr02cu001.outbound.protection.outlook.com (mail-norwayeastazon11013069.outbound.protection.outlook.com [40.107.159.69])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4b3a3wj8vg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 08:02:09 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrIeagn93o6o30REh+Ov+KNFoBP7he485HGv+rVAiNcBsiQMv3lr53IPX+isQavoqCrhu02H8eNPSKjsmoV9bUgx3CmWYRUgKhXix218n+noigXp6OppKJBB/12iW41p2/Fhjhrw2afqDvcZes3FOdr1tlI9qv3YWx4Bxjfx4hEJ5RnF+fe1fQmu1gs3LprTuYlo2k9RTS70SjyutvnnQzOIuzJsIO4AdPUThRPTJAn8/VfaHXfBAv8BZmqyqwn55DHUVD2blir9WFVjVO7Anzk+vZIUGBEETOflAsaHxAtlAK3GnoD5FdvfPr4KytqDqRmd9md78RQCfzZjJm0FGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAus/KX7LIWXT0ed1ASCK71RQXhahSrE0vIO4e/R5UA=;
 b=bIozcVSv/rLqQISeHPJ4UdUvhqKI/EiulyUKYhMDBWdq0pxfwXpWn5lCl3dyhasBJ6HHycnI6bNtL0w+rr2G4zlsdv619X21AsCPibNI6jGVCDvtRMT0cz2DMcwiMrBEx50EE//S5bx5RwLCp/3MvkgptEETRwEdsxGbkJNX25EhRiv0vtfhk0G/v52uJfj+flHpZjGqk9X+giphOOaStxEBpfkllZBgWnmHSNZaUXrd54926O67gNAUsDtpeiyla1XNG9BqkOwYKmH+lzHPXNJoGhAxzr0dpaEeAEebP9+oq1sQzgzIaCLHtp5NoVcVPNQ6VOB1RjCoR8no2OQIbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=iscas.ac.cn smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAus/KX7LIWXT0ed1ASCK71RQXhahSrE0vIO4e/R5UA=;
 b=a70elMAcPZbaqIo/VbjVmxTx76EFeUhB76rPVr5OV5cwuAge+9F9owmp6sxyoZVcPSsf65p6PC/S8lojcGgAABSpvGjOfMOi5FF5wOO4bNDv2I2h9aetpx5xiteB/6vYYGd7YqQOgWyX7vT4LjcIZ03cyMIGXy6vqW5olwYHcoD2UecLLYoT3XnsYP0RQg7MWII4eHl812hSmKOfmEBmazUsP9wFLMVACvF9h8K1iQCqWV2qcJaYgQlxgJUlFrFXbz2uIT/XxVsglEbM/TlUhy+3ZuiCF/p5d9RdaLsq3Bn820xQOk2xxgwfR9IV+FWiL16yubhU13yTcMAIAy9PXA==
Received: from DU2PR04CA0009.eurprd04.prod.outlook.com (2603:10a6:10:3b::14)
 by AS1PR10MB5602.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 07:02:07 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:3b:cafe::b7) by DU2PR04CA0009.outlook.office365.com
 (2603:10a6:10:3b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 07:02:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 17 Dec 2025 07:02:06 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 08:02:51 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 08:02:05 +0100
Message-ID: <d288742b-0f01-4871-b9c6-bc2a807be359@foss.st.com>
Date: Wed, 17 Dec 2025 08:02:04 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux-stm32] [PATCH] spi: stm32-ospi: Remove unneeded semicolon
To: Chen Ni <nichen@iscas.ac.cn>, <broonie@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>
CC: <linux-kernel@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-spi@vger.kernel.org>
References: <20251216043210.1521722-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20251216043210.1521722-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509ED:EE_|AS1PR10MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: a001fa60-f29e-478c-8caa-08de3d3a30c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3JuRVhIbTBlMFd6L0YzZncrZ0JtdVJ3L3M1VmxpcHdPWDlqTUdreW5DTjBC?=
 =?utf-8?B?MVFLZEdsTTh2dEc4Y1ZNZEVvek9CNitIaG56THdxWlFpaGt3TWdCVmRvc2Jl?=
 =?utf-8?B?dEhvRENJS3EyZVVtcUZ4bTFhT042cHVOK200RXg2UkdwUUN5akdrZnVDanl6?=
 =?utf-8?B?Ym1KQmgycUtRL2NEcHZ0dG0rNmJwM2xFQkxvYzZPbWZ6RVBiUWxZaDBMV0dP?=
 =?utf-8?B?eklIa2tnb3FvS2FMcVovZjZLQk0wS3VPSUFDUm9qZk9CeGhNc3YvTERXUmNR?=
 =?utf-8?B?ZjVhWnhYSG0xMUhjYndGRGZ2d3Avc2VsU2NPZWdVcTVzK2pZTjJtcmJTTXBk?=
 =?utf-8?B?Qk1mMEZrYnNKVi8wd0M3MmVBM2t6VFBsSnVUN0YwU3owVElnRUF2TDd0dXNo?=
 =?utf-8?B?ZmREa29BdnY0R0tNZmtHS1M0djlzMFR6WmpCU1N2KzFiL3NxWUxNMHhKb2NY?=
 =?utf-8?B?Zk8vdFZOdlNoTm9qMWtJbTh2SE9DN3ovdEU5Y0trQXNUVzVzLzV6T3ZmVS9V?=
 =?utf-8?B?REk5ZU5penphMWFzdy8vR0Vra2Y5R1hZcWUyWmxVR1ZCVDlWSEcrQ1cxU0tU?=
 =?utf-8?B?SmU0TlRhQ1VkdGtTSkZJLzh0NlQyamc3YzNVaHdNV3NqbDdubDFJSTJ0NTl5?=
 =?utf-8?B?ZEwxa1RnZ0VrWExKcE5ZTFNkMkVkbWRpSEhUUE9rdGRkSzBWdjIyU1M5ZUNN?=
 =?utf-8?B?bVNZbGluOXJjd2J5bUk2bDRVUE1EbjNxSnNCR3VrQ2FaeC9PU3Z4TTRzeVd5?=
 =?utf-8?B?dVVEaWIxU1VyYUdTbFdZTXo2Rm9McVRHVjk0alRXNG44R1UvV2NxOG5INkVu?=
 =?utf-8?B?Q04vZk1NWlByQW5GM1JWSk5NQmRuRldYZ3hjQ2l1aTJTMUpZOVZ2Z21PcUJn?=
 =?utf-8?B?cEVUaThSeEZ1eXBLZmtFRkVFMTg4Z0pkYzl2UnFTdCsxUU10T1Aza2FYWjln?=
 =?utf-8?B?ZDJDd1RUcjk4M1VHaGdKMzJ1TXVRWGI4VmdnU0RoZmRPS0wwd2hVNEtQbUNB?=
 =?utf-8?B?V2hTOGxhVWZIL3ZyOUpTMlEzNjRLQUZvVi9wSmExOHhMcmNvU2I0RlBqNnVo?=
 =?utf-8?B?dHF0OGRjWUJxeWwyZTNxdFVsVnJmTU5iZFpQVjdyWFlVS1BsV0hFS0FwSXRh?=
 =?utf-8?B?UzZEblZySXNQUHZkUmJOazVIUkVDZllZd2s1QTVnQUMwN09nSzNHcU1kcU9I?=
 =?utf-8?B?cnRtUFpudjluRWZ4RVZWN0dqWU9IQW5kN3p4SDIyVlV2MlZVeEVZNU9qMEZJ?=
 =?utf-8?B?WlVVVFJOZ1VIMGdDYkJITUVtYWdRd28rZGk0aUFjK3NOVE83eStMVTZwbWVt?=
 =?utf-8?B?S1g0MnN1NlhLN3M1RS9QSlRkeFM4Ymt5SVBZcEhuN2luL21BQmpyWjI1blRq?=
 =?utf-8?B?czNuTjlVekRlRktHU2FOWURtRkpzdnpmQkhlV29KS2FoeGgrYlhjYU1QbDdl?=
 =?utf-8?B?Y0xSSmpJa1BoSDg1c1c4dlkrYnVURW9rN3pPZU1sc3kzeWFVUEJNWVhTR2Vr?=
 =?utf-8?B?dFQyVVdLYW8vUjhaL1NQK3A3TmEyWnFLUS9PbWQ1OVhXL1Z2ZUhOMnowMFJW?=
 =?utf-8?B?ZlJXMkpvMUdlOE5Ca3JhWWxpRXQwdWZxOENmT1h6QW9KZnB3UVpLcm5JVm0y?=
 =?utf-8?B?MzhHNFo1a2V6UWRiMEJiWnZCZ0YvYjd3d015YTdZTm1OSW9QbnI4eGlvNENt?=
 =?utf-8?B?aElSSUxRYitnczNIOTBoZERyT3NDU0YvZDBDczhuTkZpS2sxMzJUdmN1bEJU?=
 =?utf-8?B?dlZydG5YRzRSYUx2L1o3ekF6OGRrYzY3UVBiZHd3UjdJMThZM0d3dUxFWEE5?=
 =?utf-8?B?L1BWTXRsdHBUa0RLRE9KcG5jL0grVXUwZllPb3NGcStHNnBDL0l6Qk5wK3JU?=
 =?utf-8?B?aHpFbWppaitxVTJmN0E0WTN2VFpPUHd6by9VTjFtSSsxQ251czU2ZEpxM1Bu?=
 =?utf-8?B?a0V4N2RWRkNWcXdZWUJvRjUwNjlCcmxVOGc3TkJqelAzdHJBT0F5YllJcjNn?=
 =?utf-8?B?ZEc2UFk0OHBqVEREOFYyOVFuQTBwVmlJemhBeW5uWUVNQ1gvaDZLNnBrS2k2?=
 =?utf-8?B?c0xqWEVzZlNKcHExR05WcjJYQ0hFZm5NVzhRN093Q1BJaEhTdFA1b1REV0hG?=
 =?utf-8?Q?rg5o=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 07:02:06.7710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a001fa60-f29e-478c-8caa-08de3d3a30c6
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5602
X-Authority-Analysis: v=2.4 cv=HLHO14tv c=1 sm=1 tr=0 ts=69425571 cx=c_pps
 a=ZAaxwGSI+5Y/EJX4KA6iqA==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=GqV-0ptb2sBNZNKjqo8A:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: gzWO5Hd8OiDHVVw-b-lq0Rl09aaqzMQy
X-Proofpoint-GUID: gzWO5Hd8OiDHVVw-b-lq0Rl09aaqzMQy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA1NSBTYWx0ZWRfXyzw/assB+sVm
 tTXiHATlonIcx5ns/VWytE8KMYJe1VJ9jy5j1g2N9MxZwDfmM4JwM+0bT3oXVVfU3YZfFbEEPOo
 ZIC5k+8pGO823MrXSVrv5Do7pVeYkwKVOvoAr0VCJHXcg1Kq3V8EE/9x5rRAbFrlvjKTogg3Y0i
 rJei9u6YePJItErjr9Qj6CPQfZE+ASObTBFpIB8/B4norQpc0+yruB+o7V2tL4ovqviaPVoLf5H
 1exvRpK3C97dEd2jpts57BHPzgsuS6K8vmMF+Egrw7wksKcdpkyEFWxUyTdkyWX4tcZqUFEyX+M
 3xNwEEAwCSP1rE8KuC3vasgFCMO0w0Evrio7BV1EUlJ7jk7a3LbWcdhLbcFhfzc8ZY6gcapR99A
 7zJ9+k8Rgj5Ie95ZTBgJo3t37A5CRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170055



On 12/16/25 05:32, Chen Ni wrote:
> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/spi/spi-stm32-ospi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
> index c36df8d3f5cb..f396439e2281 100644
> --- a/drivers/spi/spi-stm32-ospi.c
> +++ b/drivers/spi/spi-stm32-ospi.c
> @@ -150,7 +150,7 @@ static void stm32_ospi_read_fifo(void *val, void __iomem *addr, u8 len)
>  		break;
>  	case sizeof(u8):
>  		*((u8 *)val) = readb_relaxed(addr);
> -	};
> +	}
>  }
>  
>  static void stm32_ospi_write_fifo(void *val, void __iomem *addr, u8 len)
> @@ -164,7 +164,7 @@ static void stm32_ospi_write_fifo(void *val, void __iomem *addr, u8 len)
>  		break;
>  	case sizeof(u8):
>  		writeb_relaxed(*((u8 *)val), addr);
> -	};
> +	}
>  }
>  
>  static int stm32_ospi_abort(struct stm32_ospi *ospi)

Hi Chen

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

