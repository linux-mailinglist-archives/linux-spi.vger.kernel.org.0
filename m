Return-Path: <linux-spi+bounces-11994-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FC6CC9A48
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 22:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF1B1304C1F1
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 21:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B6B310625;
	Wed, 17 Dec 2025 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="gQHrqovs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE59430FF04;
	Wed, 17 Dec 2025 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766008377; cv=fail; b=Pg/W2SkPiBsqoT1/MTc9CJUWbMPvUwTCua6Z8JXLIeTyGgQB4hBSTZ1i55LH0L9Ok/STfaordl2aaKBYNiq03PSFlpKXnqFFuuUzlSPpYAczUQN2rtj5irn1c2NeSnj67gbOhvbJovezcsD815LZwAUByOVMO002pZxFUr4N6Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766008377; c=relaxed/simple;
	bh=WLJ4U7X+t2NjoKk7W1/S4D/d3hver4K6CDSK06rDFBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BUQXpY6w2NFAax7x5jWIypphuP8wz3AS6gH0qMUjVn9PkfiX3DOpOgX0zBfM0L6PkD4zsV6xAXOnbanspS15m5ebZXwnIiN9BDcWWp27VtRqmgnqMCnEdH3nnm80UHMXKDBEL+TwRNPvsM/iO74v+eL3/VtVsBX9Wmcoo6Su740=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=gQHrqovs; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHL3NLh664755;
	Wed, 17 Dec 2025 22:52:45 +0100
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11013065.outbound.protection.outlook.com [52.101.72.65])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4b3xb71kfg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 22:52:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/jKN9GLcDmcPm4Ugjp++7nAxgs+gVqs50rJ3R14VonStRx0xrAO9Ny3qcxWwQAwpQRK1nmpVF/y0Psd6O2ccX87SgIKDnBXrYcV7TEBtqSnnSHD0aNHl4sNy48ped43oRCzWum+31oHi9FH8kfo7ABJ2FSKBQylajtFrtmyiQgp9wGJM9PstdrObGL/OOBcFV6XgTN/XGphNMBMKXeqM+4n++bwmlTCDRausvUeWlqHMVr5NTuNMYFqWfZghN/AIaCT1EslhT6Oixru8oiO7x4aAoMBnMSV2xIIQ+NcFHMxmMbU4WI/Wlyb7S+OEXNcCKUeVIM6C5mskLGXab4URA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTdOjoUTe+POBvl854/wkgwu/9d7NJKuLPeBBZkOHOc=;
 b=bWOkE0IQbeJQkzkgqy7niMiHuz17d17zQgFsQ7PXLVa8yoYl5+Wf9nbC9HpRppl09jCy5b8Sqbe2NS2XjBevUa1e0FXfwBrjj7EauO0u1UWI/mK9WLniqwziOCgupdT/h4ESB8KkWRF0g9CoR0C1L1rjlmagCvNnTv32I+H0z0/g+bYy93GC1+sOssSDXKGyqA8Dn2NLm41MEhbh0MVhewNNDuPkBHjQdtxnZsC0D3NJaFQjiz2/GUA2UBfiNjXf/k4nS5/nTnEyfMmJizUNns7Q+d+O4pxnCFlFdtfJJQHxQ7WwGlqHBtD3heyhHUfjyUDVBF3d99cFt1UWdG1MPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTdOjoUTe+POBvl854/wkgwu/9d7NJKuLPeBBZkOHOc=;
 b=gQHrqovsaRPsJJFERxNrXR4QdxWTTt0tbW/ARRN6AtbQZvleSt9sHCq4ekIUQpMTBTcPeNssQID2AFDYEwxNovRkq5P0O0M+pnKJrrKpEIb8t6xkUhC++LtnUadF9Pzn/aVBTuGh++FLx6SRIUveG3wI3McMnvmT+Shzd9DU9xVfGJpqLWQyDWfFnzZovs5RwOubghPGR7ji/96HDev5lKYaW8BkSQ28SCjk5hbDFEIIqRkhIuIccLIF0drBoCrsgWKvTr4T3TzxgH4z6qhEwQPq/JSwJ9hNIJ1j8dJkZi+W5GGg6IrnRHx0hxuUbv560BWVKwCMOw2y5eYhTu6BwQ==
Received: from DUZPR01CA0034.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::10) by PAWPR10MB7867.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:35d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 21:52:42 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:468:cafe::27) by DUZPR01CA0034.outlook.office365.com
 (2603:10a6:10:468::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 21:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509E5.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 17 Dec 2025 21:52:41 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 22:53:26 +0100
Received: from localhost (10.252.10.67) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 22:52:41 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
Date: Wed, 17 Dec 2025 22:51:34 +0100
Subject: [PATCH 4/4] ARM: dts: stm32: add spi1 sleep state pinctrl on
 stm32mp157c-ev1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251217-stm32-spi-enhancements-v1-4-943348b8ff66@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E5:EE_|PAWPR10MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: 975fc203-df03-4ad9-17aa-08de3db69aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWJSQUZWYTBaWUVIK1FuaVlyZE1zUjBwbktsaE9Za2hZVEtGRkl3QUY2dnJv?=
 =?utf-8?B?MGJZSWtHWUJOai9PSisxeDVhM1haT0pPbERQWW9wbEF5UUZBTFEvV3Y3NDRj?=
 =?utf-8?B?dkF2aFIzeDZjRUIwN0pNNmVjdkVkZ0hldFozdTVjZHhlZ1g5UnQvRlB3RDY5?=
 =?utf-8?B?TGdaVnk2Q2NLMTlUVitqNmFoNWl5SW1iM1U3dnk5Szl2bTBKejRHWjVFSWZl?=
 =?utf-8?B?aTRqVVpWTFlURGZCd0RFZmY5WlJkWnZKdXdwT1YwVVQ5YmR0NkxseFBJMWpl?=
 =?utf-8?B?U25wQjRzKzhEZjlTS0E4aVhRYmF2ekh6TklXTE5kd2RVeFAxcXBoZXdPaFBn?=
 =?utf-8?B?Sis4d0s5Q0NYaDJxVytPOTRhc2VQdG5IamZJRXh6U3hCZzFnMkpldFVER1dE?=
 =?utf-8?B?TVg2QW1OZVdzeFVmOHA5bTlaMWRNaEp1Y0JxU0JwdG9QMjFjS2JnOWZmSEVL?=
 =?utf-8?B?c0xyeTVSTk9ZOEpHMkR5a2ZZemVkanhTOU9Ec3dxOXZKVzc0VFJsOHZKaTRp?=
 =?utf-8?B?NmxiRHBqc1pNcDRCRGh4a0NWemJiaDZvZ3FOd3gxdHBnSjNEWTRqUC9temgx?=
 =?utf-8?B?bGRwT1F0MHc2YUU1OFVqR2lDRFowVTZjd1FrTlJPbDhHSlROOFNGaUxBRFVW?=
 =?utf-8?B?SE45RlM3TU5QY29uODI4eGZoQXVmK1VzNTAwRDEwQzhGY0Rtc0l2T0hjMkor?=
 =?utf-8?B?OGYyc2szSDcyOU1ibzBvYVBDNFpXNDNqU0JZaFVBak5KK0dsbjBLNWVOVkw1?=
 =?utf-8?B?ZHI3bnhqZEFWN2l1c3NUNy9Sa21GcExYY0Q1Sk5NdHY5MkE2RGx2M0dFS3Vr?=
 =?utf-8?B?aU1BR3lVL2RFRDhUTUdEMkdBUlJkNVkzei95Y1Nsb2gvU1ZXbXI5U2swQVBZ?=
 =?utf-8?B?NlVuT0FJVXhRNFNCUWZuS0daM1ArOGZiM0xnRnRFUlZlWGgxZTlYQjhNdGZM?=
 =?utf-8?B?Ukliby9QdURRNzlHdnJpOTlYMnNvS0VSOVV6WlFhTzVJNDUwSjhaZXYzU091?=
 =?utf-8?B?dEtnNGl3RnVQVk9GMjErTXo5dW5zYW92a0lYOTAxcTNZVE5tbFB2anJNZGR3?=
 =?utf-8?B?RXZ0OVd2S2NSM3JManU0eU5yZHVLc2I4b2pxRjI2dkVTMGlrOFR4Vkx1NWNy?=
 =?utf-8?B?Si9La1RrR2VXVklkZnYyYktOM0Z3L2VBdWNVU2c4VWw4U0hhZlZZTFlvVWpF?=
 =?utf-8?B?QmUvTnVEdWFNSXM3QmRoR25Pb3J5aW1wVldMMUFoRHg0NkVPOEwrZFV0Zmdn?=
 =?utf-8?B?OVJNSXFYV2Y3OHNEN2Zhby9Rdi8wVFhlZmpIcEZvYTVPYXIvMFdnU3doVFhn?=
 =?utf-8?B?THVRVUdKN1RSNDlnOWU3V00wSHQyd2tPYlN2MU1YU2NwLzRaS1MxVnpCZmF2?=
 =?utf-8?B?cGlQT2dQbEhsdXI3TlRLakZienpLb25NU000RlI3dEJOQzlQREppVU1janFl?=
 =?utf-8?B?WHIwQUh2ZUlKVGI4QW00L2lHRnh1SDVSQU1RUVY1RDR3WU9oMDNwc0V5QXNR?=
 =?utf-8?B?V0s0dVNzaFdIYm1MSFg0UmJxUHQ3emVQa0h2UVdHVGtPSHE0WldDanZEY09Y?=
 =?utf-8?B?K3l6K3lqL1hGMFJSUlY3YnplVWJ6U1RwUEIvWW5JZ1lZM1VjOUo1NXNvaG5S?=
 =?utf-8?B?VkVxdkRQVWlWT0MyaGcxLzRxQkVpWUROQXp6QS9zYUx4MUpGL3JYVFo0M01Z?=
 =?utf-8?B?b3FvaEY2UzBNVk5IUzlXYVNKSm5jL0Z2TXZwcS9xYkZBQTJOSS94WnZqeW4x?=
 =?utf-8?B?NzRlUFExODAremRBbHZxRDJHWGhaSjltZG05MnpxYVB4R0U3M0pSa09MN1pj?=
 =?utf-8?B?YnB6U2NiS1NxVktwVmNPc1hoRTNGU2t4VEkrMHBLTktzY3dza2owWjA3azVS?=
 =?utf-8?B?UFhTVzBqMUZPaWtueDVKTWR1Umladnk1bnZKaDRNdHRDWHBrb3NBU3RWdUFa?=
 =?utf-8?B?TDkyaFlCRTdqS3diV2FZR0lpWFF5cFZTRVN6cFZQK1Jsc3BSNUR3OFducmll?=
 =?utf-8?B?UitGTkszL3FTelRPaHpVV25XcS9GcVlaWmtlYWdrbXhHY3ZiUkRMdDBSMlU1?=
 =?utf-8?B?U28ydDZiczZJUFV3NUExK0hnYm13TzJHUEppYmhwSzBlL1ZVMnZ6NVBNR1BM?=
 =?utf-8?Q?FBVA=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 21:52:41.9868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 975fc203-df03-4ad9-17aa-08de3db69aa4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7867
X-Proofpoint-GUID: 2Nh0JfcFvGecuzPg0uJaO-UnpjGn9nIK
X-Proofpoint-ORIG-GUID: 2Nh0JfcFvGecuzPg0uJaO-UnpjGn9nIK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDE3NSBTYWx0ZWRfX+NliNzpWDIkx
 iWbHjqZOSaBT3p20c+ItSZm0E6/qTLDduHBR5ofeLpEXonGiQzc9oDoQvFOIMnU26lVZ0GdXHeY
 sQ0iOmpg6dJqgsi24uD3/SAB8Zg4N0oTqjgTnyP/gkWH3TloLHsDRdtPFsthSn9lJd45Nu0Jrro
 0h2AzjNZHu+l+iz9SqKnKQI5nGfd1Alg+k93k+httyPMP3xwZWWJ8dRArh49t43dSHdxwcRaGSh
 5Z/xRTigblwBqwFCXQmCUXdX0R9v+qCmTTFV6Yajvy390GINlsiBbZE39IlINg1lCYdpsqX0u18
 F2ikJeyI4aYU8egKq7UUd0UJRv2GlJM2fFKXOn62MRTW0SiksyZqB5vY8IcLUAVutwtDqgzb3mW
 ZaBhiWTXO4+f6jyCid6mWCyK8fyv7Q==
X-Authority-Analysis: v=2.4 cv=NZfrFmD4 c=1 sm=1 tr=0 ts=6943262d cx=c_pps
 a=92vhbJtyMJZJ2atsj87Pvw==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=tougUffuSCAA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=LcYmuGOQLzMn2Ft58YMA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2510240001 definitions=main-2512170175

Add the sleep state of the spi1 instance on stm32mp157c-ev1.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp157c-ev1.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32mp157c-ev1.dts b/arch/arm/boot/dts/st/stm32mp157c-ev1.dts
index 8f99c30f1af1..4e46d58bf61f 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-ev1.dts
@@ -296,8 +296,9 @@ &sdmmc3 {
 };
 
 &spi1 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&spi1_pins_a>;
+	pinctrl-1 = <&spi1_sleep_pins_a>;
 	status = "disabled";
 };
 

-- 
2.34.1


