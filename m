Return-Path: <linux-spi+bounces-11991-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE2ACC9A2A
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 22:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93C153018425
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 21:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D95C30FC18;
	Wed, 17 Dec 2025 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Cg5gNNtJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367C02D5410;
	Wed, 17 Dec 2025 21:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766008375; cv=fail; b=ZWOACfZy5NxpogG1GwqIMlp6XNw43q5zKT8H/7GT7izRqeK+CKH4TpggAV49Zw4dDIsj9lGVP68aHRuLS1CAYozhekVjPNDuYr/xVosaiirp8396hvs7Gkie42p/8syjZDhJE8pzZSNiFtaOtiPLZyq0LsebofRWWbjHqpFqKdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766008375; c=relaxed/simple;
	bh=SgwXWtSUrIQNNxhn+kpGAQzaM91Xm+R82WHjuqJUUOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dVuGLGMyChQIsgPsSFfePP/HqfurPMWH8IhtkNO5asJFvqp1n5g+GGRKiCXKx0RIRCWDerdrPCTqYhcoO36p22N0v3Dk7eQFxYgZMRmR4Fsu5Wr0O6Gbd4p5Txql47xWr9RHkqz11ZniLy+yxLMqDXMrOM2uSAo8M+3EmVyKiEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Cg5gNNtJ; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHLO5bD104401;
	Wed, 17 Dec 2025 22:52:45 +0100
Received: from as8pr04cu009.outbound.protection.outlook.com (mail-westeuropeazon11011018.outbound.protection.outlook.com [52.101.70.18])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4b39n9dsnn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 22:52:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dP/IfFqZK4upw/5f4INY/zOtmX1Ps1Ep8CC6RmUgavV2j2w22M5rLtMtGsS6NEF5cEc2afRuY2wxaVglVDct11a+wVfoPuqnKmOZxz0yzRp3bFFZWhfBRJtf7l5uGhf6MW+KHPdBKJDbKi8PYj9PUfyRIiKUsgSR14GiyK+H36BW+8Gi6WATdX+VooD+sM9sDuIdYP9kTeB1/+ALFzFAtbBMgnw2vvYnqEq5qporErAu3SWiKfbwYRbkt5+PaHhReLNQz8ifR/g3uYsnfe9YetgUWNSEor1iH6q8wWblwXqvFKt7TuoLBRGthya9COQ3Ud5/T0TXj0hwQcyGulMmOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8Gj37VncrG09hyhqANdMKogXJ9mUtTi7y3SOf2JQ30=;
 b=IDzXB1MDEWCemqSFJE/X5BwLRNZC7SYQ4tATuV09fw9urIUIouvvIz4TypUHe90r0Fc8QesqLOaVMiA4JvZ6Y/oVTAxCWHWcFrI/9HZckoMy/586WRuTvxWtfex9gU1tBoyoPKTUfJFpNxdSJlmMazXgzAhOYLq1war2HY47UuYyxDgxOuJgGXLrRw/haUG3NAz2utqDpErMJ28lMzocfbnnCTcARUMbtbVe0LEMhZ+T8FTfBQCPIIOAOrBc+DXjdq16/HmfLkKlTcYijdYbYT0IkKC2Oxn8jJ8HhMbEHsdsP/lOo+SVxUcvGAfaAerTGo100tIhWJjXLlRRWQF+AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8Gj37VncrG09hyhqANdMKogXJ9mUtTi7y3SOf2JQ30=;
 b=Cg5gNNtJzcShf9z/XgTzsuJRy1lAierMkkglxaO+/hOsLzTtlEay/4Vh6Z5HgI3ii90Dy5MiRybZ6EoEgXB7XTrzyJqFXADCKAoMHVkZG6SHFX6UqoMHdZDWS+YXqnmps/cvLTvxdJiaVWSeYVxCFHHgjTRzf02ozsvR2K6kRJWStUrC5RwLVYZKUKl4DeF0Bj1QfOvsirTKvl/C03giqnNqf1WvcAEQ1/42BDb22nPmVAZfB9A6jQwppssQ1H+wMrb2nr+1zpH9+k66YnU3TRa9V8Q3HXrGrTkfl6mEPFwz2ul2Ekv15a9iOaDHGL51b8VgLSZ+aJXi9FW7FHHB3Q==
Received: from DU2PR04CA0217.eurprd04.prod.outlook.com (2603:10a6:10:2b1::12)
 by AM7PR10MB3288.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 21:52:40 +0000
Received: from DB1PEPF000509E4.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::38) by DU2PR04CA0217.outlook.office365.com
 (2603:10a6:10:2b1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 21:52:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509E4.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 21:52:39 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 22:53:24 +0100
Received: from localhost (10.252.10.67) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 22:52:39 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
Date: Wed, 17 Dec 2025 22:51:32 +0100
Subject: [PATCH 2/4] spi: stm32: perform small transfer in polling mode
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251217-stm32-spi-enhancements-v1-2-943348b8ff66@foss.st.com>
References: <20251217-stm32-spi-enhancements-v1-0-943348b8ff66@foss.st.com>
In-Reply-To: <20251217-stm32-spi-enhancements-v1-0-943348b8ff66@foss.st.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Alain Volmat <alain.volmat@foss.st.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E4:EE_|AM7PR10MB3288:EE_
X-MS-Office365-Filtering-Correlation-Id: 5629a2d3-b626-4427-db5c-08de3db69970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWVzVDBid2RuWW1ITmZlYythQ2RrVWRMQjRHeDBTd2FLdkFwVGhQUWUrblVj?=
 =?utf-8?B?STBGVVlzdkN3eXRWNmd1bm45RGtZYk91QVpyVVg5M1pGWGs1UFdHa0p5OU01?=
 =?utf-8?B?WVdlMU8wOWxYcEdicXN0dEhtNUcwRWg4QUVzNVdiRlZTd0JSV2xqV3Z3dE9a?=
 =?utf-8?B?YlhnTlRnODhEZFFIVEc1SFg1anBXYXcybnVSUUFzbk1OM2gwekxJYithMTlq?=
 =?utf-8?B?VjNld0dtbjJndSsxSHUwVzNXMy9NaGowSTY3MENiNnhocTM4SFFPL2FGWHpv?=
 =?utf-8?B?SWNmY0ZXME5IZC9GT29wR0NDVE14ZG80UGtTWjVYQVpZd29UVldMamNyT1BG?=
 =?utf-8?B?QzZ4L1FCcUxjVFR1eWhqSm5VcjlBM09vOWcvQjU5a2ZxRFAydy9ubTUxSFUz?=
 =?utf-8?B?Y3huQ2Rxd2c3RElEUGRRTzdyY2lQV0ZYZWZHRnpqUU1MYkpxeEU4UXRmZ2ZZ?=
 =?utf-8?B?U3gvUXg4NERKdk5Jc2M2ZnE2UHlLVDR1ZnpxWWFjbFVzdENoRzhMbWVZNlZG?=
 =?utf-8?B?U1FwMWZneDJrLzlaKzhyZDJQa0NHaFBqd3ZPaTAzSmM2TVZTcWYybXJncGhF?=
 =?utf-8?B?cmpGTGJ1MG5tY1IzenFzRXhUcnhTSjByY1BabVRtVHl4czNJN041ejR5bCtm?=
 =?utf-8?B?MnNadTdOTjQvdk15QVUrWmVkWE1KckxHN3l2TzMvaTlIMUU5Z0ZHYkRVVC9w?=
 =?utf-8?B?WjU3OXVVOHhTMWRwdlQydHpTbG1vazY4YlRCc0JqdEo5U3Z4RURONVIvd0tt?=
 =?utf-8?B?THY1S1dESWprUzJZc3hDMmFrZjJlY1JNbVlXTlRaZFJLTmc1ZjBQWnNONUJy?=
 =?utf-8?B?TmJFa3FDcHY3NzRaYkFnV0NFbHVRNU5UVUx0NzdZWFp3R3RTZEdLZVQxb1d6?=
 =?utf-8?B?dURURGgya29zRXc4bDVydThkL2VzUVZKRXNIekM5dkQ2RTlOT2J6MXl5bUFU?=
 =?utf-8?B?c0dIL1Rjbzd1Y0E1MUF1RUZFbFpKckk3T2VoZVRkVXoyam9Ga01vMDc1OXI2?=
 =?utf-8?B?WjYzYkNWSXNKanV1b3ZEYVFvMVJnV0ppL051aEdXL0pJY0RuMlhTOHBpSk1S?=
 =?utf-8?B?OHBESFFOaEhrU0RsQjZNR3AxbjBPK2k3cFdXWVlNU0pUN2xaaldzVGROOXFa?=
 =?utf-8?B?VHhqSm1ibVRZak5MVDVLemI1RW5wbnJaMDBMZ1BtMTVPeTZjWEw1bnRiejhw?=
 =?utf-8?B?QUZHTFJURldJbDhpb1ByZ01hTm9EVmJOVlZvUmdRKzRQWnpJdFNqbG1mcGw1?=
 =?utf-8?B?SzhiTDloV3VkMzZ1RmtvRnJTS0Q5b1l5U0lzMkQ1OHd1Y3VCWWFIdWRSR0Na?=
 =?utf-8?B?VkJhZHByMDg2WlpYSU1MVllrVVVMaWFuNW5SemtTMERpOUhVdmUvam5aUEZB?=
 =?utf-8?B?MnRJREdZLytuOE5aTXppamM3QnZuV2pPOG9td2xkR3oxZGpCNUtFMFV5Qmda?=
 =?utf-8?B?MWt3SFdpVncyMnpobUpJaVc5cVBUaHd1Y1h3M0RXUDNIS2d5a3Z4YUFKZmNn?=
 =?utf-8?B?OGlpK2JKYUlDRzI2L3lvMUFmbHo1akJCdUMvcU9xMGFmc1V0Q0dOaVpGODhO?=
 =?utf-8?B?N04zUW94ZTdDSXZ1ZVJ2Q09taGh2MDA1ekVXbWdFY3NZdDJYRVRpQnkvSWNy?=
 =?utf-8?B?UXpBUXhKQVBpekZPdklZRGRyallvWTJvSEdyNVFBVmJ4d2hzU0dlaVg3dlQx?=
 =?utf-8?B?SytLM3VpbFlQd2ZWSmpBUHYwSGZVcDB0Rm45RVQxelo4cUZCWGFZV3hKUHMw?=
 =?utf-8?B?dGlzMThxT2o4aUMvRzIzTG8yd0UrcjNpczBqRzFHY3VGM1hDZzVpVi80RER1?=
 =?utf-8?B?Zjc0QUd1R0JXYlEwRjRzR2Y5L0QxOFl4NWxlektSMHJ1UzRaeVV0R2ZFR2JD?=
 =?utf-8?B?Nnk2czJTZnhmcmlDODJtYkgreVFpYnZLVkVZeFExN1AwTVFEY1p3ZEYvaWJQ?=
 =?utf-8?B?NmIzb3QrK1VMM3hCczA5S0drRXRGTTBWbFVvYVVhMU9ZZUozRkp2SGhSWlJh?=
 =?utf-8?B?YzJUc2gzSEx0dCtjOVVNTTVER0o4dFAvT2tLMDVxemhDcmZKZFFTQWo3V3Nv?=
 =?utf-8?B?SzUzMjBXeTg0bjJqOTRBak95MjNvQU1HUWt6dzJzVVJHb0h4UmxOVVQ5eUVY?=
 =?utf-8?Q?SaVw=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 21:52:39.9737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5629a2d3-b626-4427-db5c-08de3db69970
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3288
X-Authority-Analysis: v=2.4 cv=EK8LElZC c=1 sm=1 tr=0 ts=6943262c cx=c_pps
 a=RAmqSNJtJSKe9EuFyr+DeA==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=tougUffuSCAA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=PamUOCDZJ7i4i8YjnSMA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: w3xpK0SXmrcq7rA0dBQBRpUouzEUoCzn
X-Proofpoint-GUID: w3xpK0SXmrcq7rA0dBQBRpUouzEUoCzn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDE3NSBTYWx0ZWRfX7Qa3k456IiVO
 kZCs/8Oi2ePAOM7Thq9NzFMeJURjV46Ep3A37yr/PMXmQNucIg6DLTwCxic9M8oxqKt2bGKioD5
 M7/zlTAsRGyNCCf1ulro7sIKneehgjLdS2Zplc83xtuVed9hmAv5AejrXWmHmwjrM4j/7Lh41Ih
 bZS8UyPRH5bMkimnMTP8RcR4Yn77cwV04nZV4mU5zB/rLpm674Pc0DZXVQBSjoFf8LEMiOu2utQ
 Sqq6fXFOdr8o0tH9PvZHt8DQAARlekmHPjejpBbKL65/8ueidJuY2wYAHk5AXuOi6e+4e7Hnw0u
 Ys4mCIzKTdfYTmTUKBavKQVBd48svERlY33N0CfvYSd/EtpNCQ0oL2rH9rDFIUkEVMlU6cT8Bii
 csxMm4VgoMvp/xIXB3I1uds9Hy3wBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170175

In case of interrupt based transfer, when the transfer is very
small, relying on interrupts leads to lower performances than if
the transfer were done using polling on the registers.

Add a module parameter "polling_limit_us" to indicate the threshold
in us from which a transfer would be done polling the registers rather
than relying on interrupts.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/spi/spi-stm32.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 80986bd251d2..353ea5b93e0a 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -202,6 +202,10 @@
 #define STM32_SPI_HOST_MODE(stm32_spi) (!(stm32_spi)->device_mode)
 #define STM32_SPI_DEVICE_MODE(stm32_spi) ((stm32_spi)->device_mode)
 
+static unsigned int polling_limit_us = 30;
+module_param(polling_limit_us, uint, 0664);
+MODULE_PARM_DESC(polling_limit_us, "maximum time in us to run a transfer in polling mode\n");
+
 /**
  * struct stm32_spi_reg - stm32 SPI register & bitfield desc
  * @reg:		register offset
@@ -266,6 +270,7 @@ struct stm32_spi;
  * @dma_rx_cb: routine to call after DMA RX channel operation is complete
  * @dma_tx_cb: routine to call after DMA TX channel operation is complete
  * @transfer_one_irq: routine to configure interrupts for driver
+ * @transfer_one_poll: routine to perform a transfer via register polling
  * @irq_handler_event: Interrupt handler for SPI controller events
  * @irq_handler_thread: thread of interrupt handler for SPI controller
  * @baud_rate_div_min: minimum baud rate divisor
@@ -291,6 +296,7 @@ struct stm32_spi_cfg {
 	void (*dma_rx_cb)(void *data);
 	void (*dma_tx_cb)(void *data);
 	int (*transfer_one_irq)(struct stm32_spi *spi);
+	int (*transfer_one_poll)(struct stm32_spi *spi);
 	irqreturn_t (*irq_handler_event)(int irq, void *dev_id);
 	irqreturn_t (*irq_handler_thread)(int irq, void *dev_id);
 	unsigned int baud_rate_div_min;
@@ -1355,6 +1361,55 @@ static int stm32fx_spi_transfer_one_irq(struct stm32_spi *spi)
 	return 1;
 }
 
+/**
+ * stm32h7_spi_transfer_one_poll - transfer a single spi_transfer by direct
+ *				   register access without interrupt usage
+ * @spi: pointer to the spi controller data structure
+ *
+ * It must returns 0 if the transfer is finished or 1 if the transfer is still
+ * in progress.
+ */
+static int stm32h7_spi_transfer_one_poll(struct stm32_spi *spi)
+{
+	unsigned long flags;
+	u32 sr;
+
+	spin_lock_irqsave(&spi->lock, flags);
+
+	stm32_spi_enable(spi);
+
+	/* Be sure to have data in fifo before starting data transfer */
+	if (spi->tx_buf)
+		stm32h7_spi_write_txfifo(spi);
+
+	if (STM32_SPI_HOST_MODE(spi))
+		stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_CSTART);
+
+	sr = readl_relaxed(spi->base + STM32H7_SPI_SR);
+	/* Keep writing / reading while waiting for the end of transfer */
+	while (spi->tx_len || spi->rx_len || !(sr & STM32H7_SPI_SR_EOT)) {
+		if (spi->rx_len && (sr & (STM32H7_SPI_SR_RXP | STM32H7_SPI_SR_RXWNE |
+					  STM32H7_SPI_SR_RXPLVL)))
+			stm32h7_spi_read_rxfifo(spi);
+
+		if (spi->tx_len && (sr & STM32H7_SPI_SR_TXP))
+			stm32h7_spi_write_txfifo(spi);
+
+		sr = readl_relaxed(spi->base + STM32H7_SPI_SR);
+
+		/* Clear suspension bit if necessary */
+		if (sr & STM32H7_SPI_SR_SUSP)
+			writel_relaxed(sr & STM32H7_SPI_SR_SUSP, spi->base + STM32H7_SPI_IFCR);
+	}
+
+	spin_unlock_irqrestore(&spi->lock, flags);
+
+	stm32h7_spi_disable(spi);
+	spi_finalize_current_transfer(spi->ctrl);
+
+	return 0;
+}
+
 /**
  * stm32h7_spi_transfer_one_irq - transfer a single spi_transfer using
  *				  interrupts
@@ -2026,6 +2081,24 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 	return ret;
 }
 
+/**
+ * stm32_spi_can_poll - detect if poll based transfer is appropriate
+ * @spi: pointer to the spi controller data structure
+ *
+ * Returns true is poll is more appropriate, false otherwise.
+ */
+static bool stm32_spi_can_poll(struct stm32_spi *spi)
+{
+	unsigned long hz_per_byte, byte_limit;
+
+	/* Evaluate the transfer time and use polling if applicable */
+	hz_per_byte = polling_limit_us ?
+		      DIV_ROUND_UP(8 * USEC_PER_SEC, polling_limit_us) : 0;
+	byte_limit = hz_per_byte ? spi->cur_speed / hz_per_byte : 1;
+
+	return (spi->cur_xferlen < byte_limit) ? true : false;
+}
+
 /**
  * stm32_spi_transfer_one - transfer a single spi_transfer
  * @ctrl: controller interface
@@ -2058,6 +2131,8 @@ static int stm32_spi_transfer_one(struct spi_controller *ctrl,
 
 	if (spi->cur_usedma)
 		return stm32_spi_transfer_one_dma(spi, transfer);
+	else if (spi->cfg->transfer_one_poll && stm32_spi_can_poll(spi))
+		return spi->cfg->transfer_one_poll(spi);
 	else
 		return spi->cfg->transfer_one_irq(spi);
 }
@@ -2216,6 +2291,7 @@ static const struct stm32_spi_cfg stm32h7_spi_cfg = {
 	 * SPI access hence handling is performed within the SPI interrupt
 	 */
 	.transfer_one_irq = stm32h7_spi_transfer_one_irq,
+	.transfer_one_poll = stm32h7_spi_transfer_one_poll,
 	.irq_handler_thread = stm32h7_spi_irq_thread,
 	.baud_rate_div_min = STM32H7_SPI_MBR_DIV_MIN,
 	.baud_rate_div_max = STM32H7_SPI_MBR_DIV_MAX,
@@ -2245,6 +2321,7 @@ static const struct stm32_spi_cfg stm32mp25_spi_cfg = {
 	 * SPI access hence handling is performed within the SPI interrupt
 	 */
 	.transfer_one_irq = stm32h7_spi_transfer_one_irq,
+	.transfer_one_poll = stm32h7_spi_transfer_one_poll,
 	.irq_handler_thread = stm32h7_spi_irq_thread,
 	.baud_rate_div_min = STM32H7_SPI_MBR_DIV_MIN,
 	.baud_rate_div_max = STM32H7_SPI_MBR_DIV_MAX,

-- 
2.34.1


