Return-Path: <linux-spi+bounces-11814-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1839CAC587
	for <lists+linux-spi@lfdr.de>; Mon, 08 Dec 2025 08:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DECA8303788C
	for <lists+linux-spi@lfdr.de>; Mon,  8 Dec 2025 07:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E728272816;
	Mon,  8 Dec 2025 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="OJIuklPv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59396248896;
	Mon,  8 Dec 2025 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765178999; cv=fail; b=ATeECCKu9dedorthQ5WY04NBDuVy0Bp6hjPl1cpgj3/V9jKM3DVMxYLRC8ORDSYPzt5txWFcMh5jxjNLSsBjJp9emJBdmO7l33Y2k3QhSg3X5J/A14VtFkbKHKE0Lrx0LpdFJZyE0zdXn3Uy1g8U1pB4qPRcGU0x1FPaI/WPJ0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765178999; c=relaxed/simple;
	bh=jh/Kl71/4pyDNnQDfqD0tiXbdyDUyb4PxqDLjy0ycns=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=m3WdwLDyOrQV8J/UJLrMd82Awgtfp7hbXkXcDILmuMefujPGlHEVY0AjxCWYcEZXpYMD4aRulAHlKsyPDqREH9zd4vYuTEtCYrcEAMrUt9VOMdholS5kL7M6YWM2Qho6mJicNZdLKjw/rNQTAGhHD/tA9xL2Rw9O/urnUCWRAxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=OJIuklPv; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B87NfvM893385;
	Mon, 8 Dec 2025 08:29:25 +0100
Received: from du2pr03cu002.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4aw0aqapnp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 08:29:25 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q48j1n8OwGLa8EPjSwKFKYMxjj/MdYyOAzx4i84r9Fup6LLy4PmHb3BdVp+2mK/ONO0LMWjkUoxxG84vFTlAko6Bowev0r02jZGEyN7wZ8XoGokD+Ouzjn0WrkYkXm+YM/71we1G6UbfjRMjIpz2rAG/8mvTGhZ6DxvBHkbJgvCLMfWl32/b4T0zFcQS1/Rwmip3v8uetttDJ8GlQxthbo8a2ptnKHmk4hSgv2+oLp0dlUq86UYue8j9A6AhdLImv95U9+SLv1AEibm+hTlASzgQF5UhmQKRjkmzhJUg+ijz3ktumdZoeN/uSSVBA/+ounCnaglk2Wbnr11nhxqP2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNtd0DAptsM0a40t27wJ7R7qdiWfV65XRwhdNlqSwHA=;
 b=g/nbBjV1AWzvUOskj0EmcG5YPZSCmlJ2maaenh6X8qud2aFDZZSz0Amdhucao1MPo8waCkg33W6MZA1jueA362CY1CPdxrMHCtJc1AYI+NALO2QPk6VbB1owPU/wKFzHbJpEVUbuQ3R43togLM4B0mp+Pwm1WmovPHXTZ+1eV5vyEyPzsBvxOr+naMRQtH5oAO04yDH5K/rAO2TOwyhjvuixcwRWvWKNn+l1KDP2N0pzWlU6s7sVqBX4SkLj4D18Fp08vlN7sKtvaqcdtAx/IZzEDKxmU+rp4Xm+mUG5oILqdvNFrze/qs4XZxEqKKtOHmmTont0F8bStYrr9rqsGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNtd0DAptsM0a40t27wJ7R7qdiWfV65XRwhdNlqSwHA=;
 b=OJIuklPvtRfZ8SA7OCR8CT7UfU1F8v5x138V525inC4/lDV4Hwrc0k77HZkLsRJPpxpbg9VaxWIr0BySYuGAg3DbP2Y5aqXQzMIs3jrlGeZeU/eDzosUfUMo4IiWidTzghjX2+VkyflwrZ3xe58Ld2yREQ3kZKSaQHNEcM0ZpGAXKnTLdHPjtFDgXZ1TOdSereJhUxZTfrcsCouL5h3m1yIcDM8UCC2PdI7JtS3ldo9B5QRhiaDDcDJr8MYBjVxesvxX9HX9fzqCcvzo+K/f8WVpbF0CQdecMmNkBqZ2Ujd8+adGnN/EenS0Vxl9Syc9g9QkZOmulN3hgCm1ytpg3Q==
Received: from CWLP265CA0304.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5d::28)
 by AM9PR10MB4038.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 07:29:21 +0000
Received: from AM3PEPF0000A795.eurprd04.prod.outlook.com
 (2603:10a6:401:5d:cafe::5a) by CWLP265CA0304.outlook.office365.com
 (2603:10a6:401:5d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 07:29:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM3PEPF0000A795.mail.protection.outlook.com (10.167.16.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 07:29:20 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 08:30:02 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 08:29:20 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v2 0/8] spi: stm32: Update for OSPI and QSPI drivers
Date: Mon, 8 Dec 2025 08:29:07 +0100
Message-ID: <20251208-upstream_qspi_ospi_updates-v2-0-62526c9467dc@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEN+NmkC/42NQQ6DIBBFr2JmXQxQrdpV79EYgzhUFgpl0LQx3
 r3oCbr5yfuL9zYgDBYJ7tkGAVdL1s0J5CUDPar5hcwOiUFyWQrJS7Z4igHV1L3J284ds/hBRSR
 WGGUqde15U2tIAh/Q2M8pf7aJR0vRhe/ZWsXx/qVdBeOswpuu+8aUohAP44hyirl2E7T7vv8A+
 qSuRcYAAAA=
X-Change-ID: 20251205-upstream_qspi_ospi_updates-4faf7a3b098c
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A795:EE_|AM9PR10MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: c1abe666-a4cd-43fb-ebad-08de362b80f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TThhZm11Q2orNVYxRlNvbmt1UStIcVR4bEVYR1NRYlF2MTdHV3orRCttb3Bl?=
 =?utf-8?B?blZJRjh5RTNRcGp5bjZJank0RW5UNUlhTk5ISHZQb3RJM25LRmtoV3ZQUHZG?=
 =?utf-8?B?czRaT3ZBWjhoK1NCeVRDRi94T0RMVkszSGhESnYzV29yTnlmcjV3a0lJVFI4?=
 =?utf-8?B?ZHg4aVYybEk1eDZBSVhZQ09td3U3YTdEZHBWMGFWc201aTVlWjVyWHVZZ0Rn?=
 =?utf-8?B?NjBSbDdFc2d5Unh4UC94NHovNUJWSUV6Z3daRWdHWFdCRzZjQmdsK1VPYlla?=
 =?utf-8?B?NWVPRmhSUTJkYTZyNDRyVG83VnVlTm4rSFZxRU90dDRpR0RLRnlSTW1tT1VR?=
 =?utf-8?B?N2J5anNlRTNFMjNJemZvNXBMc3htaHIzODdobWxvTUVDU1F1QnFleWN0bTht?=
 =?utf-8?B?NGxMRHkyM0w1OVNHajBjc0Rnc0JlWDNOcjl5SmVEcnI0NEFTVStZMHE5SmxW?=
 =?utf-8?B?VEpmbFFTS0JlWWI0MmhVR1hhTWQxVDlCK3lNSFVNRkRFb0lpc0M4SURJSzI0?=
 =?utf-8?B?M3ZvUWxzY3J2TjZhVXI1T241Wk5JR2drY1YyZWE4SU9NWlNMam9ENmVwVHBu?=
 =?utf-8?B?MDdybUxvanVhaGVBbnZCQm9YTW5kSnYrYzZJM0JzWFV4TU5KOXFIZnRIQ0ZV?=
 =?utf-8?B?MlgzT283NHRodVplN3FLTkdoSVI3VHZCUlQ3bXJ4cnZBdFJ5Ly9kdE51bDRy?=
 =?utf-8?B?cGluTTlwaGJYa04yUUhZejFPTjd5NXFtZHBUQjNGU1dkaHNtWTRkU1A2NlBG?=
 =?utf-8?B?WDhWdDg2NEUzV21sWUROdFh5RHZoYjNMcHJBNVU0U1BNemsxYzBIUnRkb3hT?=
 =?utf-8?B?bDFiU0ZnREpXZFhER1RjbU13eWJFZ1F0ZkZqNVozYzdLczMzWmNkUzNHcTlj?=
 =?utf-8?B?OHVqdEx6YVJwN2FHaGRHeTY4OXprY0dxb2lVRUZySm9jayszNWNYK2ZsK0Y0?=
 =?utf-8?B?VTdBdmVoVkdySlBRNTZUbTBXUXovNGJIaDNTRmNoTnNKL0NobGU5a09oVitF?=
 =?utf-8?B?ZjI2QllIR3BhZ1g0T3BCWXFqMVBSMURCajc2OG44YWZUY3FWZHBobWNjQlIv?=
 =?utf-8?B?MEFqbGlRamJhaHBrM3J2WHZIRSs2NFZhYlJVZkVrMEYwNUk2RUhISnYxK1pU?=
 =?utf-8?B?NjdGMjg0dkllU25jRTRrRi9mSU9Ccldvdk1CSnZCd2lkdzlGSWFwK0FmdStG?=
 =?utf-8?B?TSsvTkJiQjVUYVhpK3RXdU4vZVplTU0yMzhKT1Z2d0haSHA1YlJleHkyRFNl?=
 =?utf-8?B?TzNJL3RTV3FJWmVuY1RHdjFTa3kweGJMa1BZcHNYSERGSit5ek8xbmlFRVpj?=
 =?utf-8?B?SUlBbWFrekxkTThMQkJQTWROY3Z5bldsZ3NFWTBjSW50UGxVaHNmcWVvOVp6?=
 =?utf-8?B?VVpGZnlzUkFkTHB3ejZWeTdEQVl5NVB0ZS9QWksvRmdFOFNMeDdweVpKSlJJ?=
 =?utf-8?B?dTRtNnBucXhrdUFZa3RNN3pwZ3hFbmgrM1YxT3FKS1RLZStCN2x2VTI5ZnVE?=
 =?utf-8?B?clZDMWdyQlRHNFNvQldBSXE4VVQySHNNWjJNQUhCLzBEL2dwK0tGdDJjZ0RY?=
 =?utf-8?B?OHYwajRXVG9pS0IvYUh6MHpPcVUwVHF3VVNPS3BlRU8rVnIwVkMrc0lkMXQ4?=
 =?utf-8?B?VGJCR1Ziem9BcDFzVk9HK2gzSk9BVzBnNGhFeDRJVVFVWVp1c3ZWSEFIU2xZ?=
 =?utf-8?B?S1RXR3E0ajNTT3RyTVI0aUJOVk1rb3lQM3M1amFwZW10M2E3b1J5Z21YOWdO?=
 =?utf-8?B?Z2lsaEdOZUE0YTFuTklTNUJLdkxFN0JWSjlMY2xZSzRKeU54TmhmSUFiNVhz?=
 =?utf-8?B?U1JVbEEva0lnSk1UOHh1RWJuYVdUZWhaTjZzaDFVT0VCTEdEa0c3THBBQzN3?=
 =?utf-8?B?WHB3NUluK3hPTEI2M3haZWVLczNXS09xMUxSTE1IYmNqRUMxWWJzNzVkNzRZ?=
 =?utf-8?B?ZnZ0SjhXa3U5TlFGVzgyODJVQXN4b29HV1llTUJjU2tFUEo0QnlEd0hDT3VL?=
 =?utf-8?B?VjIyZW9mVDhqekNVRHRESnZUTlA0TFIxbmRFNGdzVHJZUzc1akI4K1RtWm9I?=
 =?utf-8?B?SVlIMUk4c3FwY2g5T1hROHlMM3hpTFR5aGtNWHNsaE8ycWQxelFIRzh3cVdJ?=
 =?utf-8?Q?8fzE=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 07:29:20.7729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1abe666-a4cd-43fb-ebad-08de362b80f8
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4038
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDA2MiBTYWx0ZWRfX+uitIgCAEGFK
 ocqxqS7xWvgUHRx9NFDiI3XMSUhik3smTO02vflCBPK8eXkw5z5pkcT2C+Y3xfHnNsIccadgwn1
 /eRFNdrk3vIj/rY+I+MUkqDgsdp1eDgv5xj/FR9FlFwR3p5sQWtR9qa+U8s8VH1lXb4kccNScgH
 gYO2fvS93OQ1KdDQw+IdSFNqJBwgt1hy6lWbQNyvFZuSHygDZUVGVdKjB4P5hv7BUlIb06czuSC
 W/v8dEABCSBhEX197PXGRF5cK2GadNGPIzfHZ6p4vOC7PTlnKkx7OVVLxtW8k4dfDJPi0zVjkOh
 Ar0jBL0P5G9F8C5hu3opDcrQfgIh64pQn/psLgvVooF/pGBCpGWV2AcizzAJy1D8EFwe5F1UDLO
 Xn2Tul3lD49IrIhp8e/fhbZkf2J/Jw==
X-Proofpoint-GUID: SsOZVGI-7bxfkHhA7_FWjZzrH9-swNJR
X-Proofpoint-ORIG-GUID: SsOZVGI-7bxfkHhA7_FWjZzrH9-swNJR
X-Authority-Analysis: v=2.4 cv=R/oO2NRX c=1 sm=1 tr=0 ts=69367e55 cx=c_pps
 a=xPTPNCFoQ/vz1rhJs1FJ/g==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8
 a=A9BJ_P7MhkSIbhnakx4A:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512080062

This serie applies the following updates on the spi-stm32-ospi and
spi-stm32-qspi dirvers :

  _ Update FIFO accesses using u16 and u32 when possible instead of u8
    only to optimize throughput.
  _ Replace Transmit Complete and Transmit Error interrupt management by
    usage of read_poll_timeout_atomic() to optimize throughtput.
  _ Simplify Status Match interrupt check.
  _ Set DMA burst configuration dynamically.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Changes in v2:
- Fix compilation error in stm32_ospi_wait_cmd()
- Link to v1: https://lore.kernel.org/r/20251205-upstream_qspi_ospi_updates-v1-0-7e6c8b9f5141@foss.st.com

---
Patrice Chotard (8):
      spi: stm32-ospi: Set DMA maxburst dynamically
      spi: stm32-ospi: Optimize FIFO accesses using u16 or u32
      spi: stm32-ospi: Remove CR_TCIE and CR_TEIE irq usage
      spi: stm32-ospi: Simplify SMIE interrupt test
      spi: stm32-qspi: Set DMA maxburst dynamically
      spi: stm32-qspi: Optimize FIFO accesses using u16 or u32
      spi: stm32-qspi: Remove CR_TCIE and CR_TEIE irq usage
      spi: stm32-qspi: Simplify SMIE interrupt test

 drivers/spi/spi-stm32-ospi.c | 107 +++++++++++++++++++++++++----------------
 drivers/spi/spi-stm32-qspi.c | 111 +++++++++++++++++++++++++------------------
 2 files changed, 132 insertions(+), 86 deletions(-)
---
base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
change-id: 20251205-upstream_qspi_ospi_updates-4faf7a3b098c

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>


