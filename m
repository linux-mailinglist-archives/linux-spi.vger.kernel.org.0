Return-Path: <linux-spi+bounces-12014-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A6ECCB7F5
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 11:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54F05304D55A
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 10:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8A331283B;
	Thu, 18 Dec 2025 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Dr9hZ/Qh"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E887F1F3FEC;
	Thu, 18 Dec 2025 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766054939; cv=fail; b=nC5k06H5ICwiFt0EfrXmju4PsVekZh2XdmfdYdbmnosJIhdOAnmhw90wy8CZrZojD0fKFoaOR7ZqQP+Jxcwl6iAKQY+/og5Nqekcg8IWXNIxchLiDzIKpW85UXmEDjKYMBmmWJyjPW5M1YGFHFrRKwq/W/ezR17ZMA7mN7Ae2VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766054939; c=relaxed/simple;
	bh=Mw4mPYDZE0+4iokq8C1uPij3gX5zRgcQjerSdWGRZjQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=C6DnQ4oLqeMDkuBOwqUYNQZfn7TPZpepefprMTLGPZht3Q2HcykWvkCekJsxSCVB7Mojod3jZMg+YfNC+L6CkAUBonDh/52z5w78OjxC1W42NPpNKGlhWlUCkWpIWdRN1F1Ztfad4xoX38GUj6cUcbDbpJ401tkOHKHtC+9Ku5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Dr9hZ/Qh; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BIAifY32126923;
	Thu, 18 Dec 2025 11:48:46 +0100
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012000.outbound.protection.outlook.com [52.101.66.0])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4b3xb73yef-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 11:48:46 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MaNzNKwJUUSENz2YESsdX8ss8HB9sbwAta3RUMtmsZjgWvO+sv9On/8sP+PMLd6glaVSMUVBHHPh4vLmWftJ76npoNSClbrtIkxk5P+xIb+sReJeYLeygXArcP3byXgjTL58Dr1TRfcYgKMiiZWfRtnixx/urvw7rI77DWAuZ9PuYy6h2tv8tk65PLeDiYsavVJpWm4mDrfEzUyTIt+ynxxpxCf094rqEJ/MEf9JShJ2uAQYpdgwCzOJJdMfhbya1tFZX5BPXcnwh65mxQkidA4lO638+FVapex5eyR2mvZgZBiOABL8gKAbpdQyrjzZ6lrsqej673W+qFHvfgZBnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8Q0WgAkOTTDGKY+X0OrFH3Qptbae+uFtrTuOzYFMqQ=;
 b=qkf0UZzBbf6tz5yb+vsBBph8GZx8W8Oy7RmJT29bVdaNbMxxh23g4CuMyxzgSG/kLgAYXhrO8p3Exh1UevsKqAvTeKm2MEt09bAMi9WVruX+YuTLxitD01YULw+odBLrpr+cknyS+xpM+HAR+7qwXNaVNOxKKtFaz2K9KeaAUMp+kCVfX/56nNDQS0IXPgRFvaKDgOzSTi/KZ699lfSf7QWWZoWQDQXKNJ2J1kJBo9IBHBuoLDvS0GIXK6gmwJg96MAVoDRMp3/QeMrdOv67gw6qmasFrxZUg9sI7jJpzf2cET/IoVc2pTBEgeKivIDk/yDugUxXikdaKqq0qtBo+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8Q0WgAkOTTDGKY+X0OrFH3Qptbae+uFtrTuOzYFMqQ=;
 b=Dr9hZ/QhZt82KjM6CUuWwk69kPoA2TVrGpUi2Ogk9tWUQxGv14pjFhR7d/FVgCvo5rs4PUZbSNRDXqNromWTFtg/OiG1zfQ0aEk+aS51rXeaUtM0Fm2iNl035rs3sllTe5RNvezgT0IW1/mfjqg+vzM+Gu5CuWnMfX/SG9kiZsPYzQkZJwqgeiXBqsdzdBTXBeMdaq6pu4T/KZMKMO0flkEaQEDl2nWJgBvSf8Wn4yZRk0lTzGEt802k32scOieLx7WbZMjNqpPO9RH9N/7samctLugb4cW7OqXDH57YTRHhdSG9nhUDZqpuR/SaFSP9YCRySGgHODpRKlsUhCsNRg==
Received: from DU2P250CA0016.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::21)
 by PA4PR10MB5683.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:265::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 10:48:44 +0000
Received: from DU2PEPF00028CFE.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::7b) by DU2P250CA0016.outlook.office365.com
 (2603:10a6:10:231::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Thu,
 18 Dec 2025 10:48:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028CFE.mail.protection.outlook.com (10.167.242.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 10:48:43 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 11:49:28 +0100
Received: from localhost (10.252.25.7) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 11:48:42 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
Subject: [PATCH v2 0/4] spi: stm32: stability & performance enhancements
Date: Thu, 18 Dec 2025 11:48:26 +0100
Message-ID: <20251218-stm32-spi-enhancements-v2-0-3b69901ca9fe@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPrbQ2kC/3WNwQ6CMBBEf4X07BK6RaSc/A/DAcpWeqAl3YZoC
 P9uJfHo8U1m3uyCKTpi0RW7iLQ5dsFnwEshzDz4J4GbMgus8CpRKuC0KAReHZDPBUML+cSAehr
 0aFBLpUQer5Gse53iR595dpxCfJ8/m/ymP+Xtn3KTUIGularbsbW2ae42MJecShMW0R/H8QFB3
 9/bvgAAAA==
X-Change-ID: 20251213-stm32-spi-enhancements-29da9bc29133
To: Mark Brown <broonie@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Alain Volmat <alain.volmat@foss.st.com>,
        Deepak
 Kumar <deepak.kumar01@st.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFE:EE_|PA4PR10MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: 883b0bb0-515c-4822-4020-08de3e230346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1U5b3pkVnJSVmtyV1hlcGZYYUc0eTkzai9HSWNXbVhrWlBRUGtVN3FQb2s0?=
 =?utf-8?B?RXFTWTk4QnN2bnRMaDlyZDlweThmMDgzNytFeHpTQU9Qb0ZGVnE2MUwrb2Zn?=
 =?utf-8?B?T2d4Z0pSRjVpWURtZmpZdllKL2syVFpXUVRMcDAzb2lKNlFzb3JxdnlmM1F4?=
 =?utf-8?B?dWZTRnVYeHdqYWNuSUd6MHJ3bW9Rcy96ZUdVMWllZGt6RWUrTFE1RXlXN1dy?=
 =?utf-8?B?VVV0NTdQdWQvSXVwcU92MldWb1ZKc2VKUTBhMHBtRmZ4Sk44MjVDdEpVdUI0?=
 =?utf-8?B?T2UrdXRJd3VMdTlXaHF3RkhyS2I1OWk2eWRkL1FYVDk3OFBvNWZzTXNpRTBv?=
 =?utf-8?B?YVk4KzRnK3lOTHZPZGRaOTJsck9yOFQzbDNJZW9ha1ZSeVczSWJURmtFbEdT?=
 =?utf-8?B?VkVlVDIyR21kM2MyY3ZUdE5PWlozZXhtdm1CTWRDUWV3czkxMVVJUFR3eXpi?=
 =?utf-8?B?c0R1KzhQNFc4c0xRd1FITjlzQWpSQlJmTDU4SHZYakRXNTUvM0Rzd2NKSkVJ?=
 =?utf-8?B?NEtxeXRMak8yS3IrWkpXamRzL25ZeUVZUzROY1VWVzNEY29kT2N6RGw2eWc0?=
 =?utf-8?B?SlJkdjZvdVlxT01iMVhCUmRGVzgvQk5qZHZmRXlWWEZtMmtuS0ZlcHphNlJ4?=
 =?utf-8?B?ZXZaOFk3eFZFRmJyeUF0dnF6TE5MUi9zK05sc2lwL2ZaMFNBNk05WGdmNGRq?=
 =?utf-8?B?TnBGdHdmQlBNS3dSdzJNMkd3NGVlTzN4MEl4aUhTalZ0eVkyZkZJOGx2dHQ2?=
 =?utf-8?B?ZE5Pc3FKNlRlOVNjT0tYYTFGYjROMHQvQnA0azRHbW5Vc29yUDIraVJNMExQ?=
 =?utf-8?B?Uk4wczJDRW01ajExVFZ1RHBjL3daODJhajJVYzh2U3c4N0pHcjQwWWlUVGl0?=
 =?utf-8?B?NnZpZ0VsY2daaVFiN2FqZWh2NzF0QWhYNkIraTJRa21maVYzZGFyd1IxNHk0?=
 =?utf-8?B?TWxLK2NaSm1mZ08zOEhiY0MwVHdSRDRHQWVmTnhCODFCR2hMa0tFazNCbmoy?=
 =?utf-8?B?NC9KOTZzNmpnaFRGZnNCdStaMm8rV2IrS3kzNXF1amdKaUR4MVJqQi9peUVF?=
 =?utf-8?B?VnF4REgwdzNBaVc5WnF0T3pjY0RaWUNMRXdQaElJZmMwT0ErQWV0dXF4Q1p4?=
 =?utf-8?B?MU9Qd1B2dDhJNVhUbDE3NFlhKzQxajF0NkE4WkpSYWZOZE1XN20wMUJYRWM1?=
 =?utf-8?B?aDQ2QTVIL0JjQzRMWHZobTZVZWxCTTV5bFBKdlFoRlJON0NYZHRHYy9wOWp2?=
 =?utf-8?B?RmwxWW5mRDF2cHZtazA5SVU1WEg1VmVzdjluUEplZU9MT0pRaWZobFZVSmJP?=
 =?utf-8?B?R0JyVkUvSHZSazAyMjNaVXhaSHJEdDZPYStKK1hnQW1Md0tDYzhoTXR1TUFz?=
 =?utf-8?B?cEF2dzF3Sk1jTE9ZZTN0UzBrYnBQWWRiT0lVNWpyZlV1N3hGNDhlWmFRMlJn?=
 =?utf-8?B?bnpzbGJYMHk3ZTc5VU8zWTExODduSGg3V09xbldpaVFJWmd3blkvdTlTR0E1?=
 =?utf-8?B?aTJNZGYrbGRGeHNrQUM3eGR3M1NpY3pxUHYzem9MZERWMkQ5TFhONWxqOXV5?=
 =?utf-8?B?cWxuSW9qUU84VWZMZU1aRTY3QmhzQk1NZWJ0MmE0YjFORU9XOUVUcGpDNkoy?=
 =?utf-8?B?TUpRVXlZVjVaUlhQQ0trZm1Ud0ZEWkFVMTZDVyt1WkMydXdBUHgxRlBySjBM?=
 =?utf-8?B?N0lJUlJLbzJYcDVEZDJTbUtWMnJVc0UvazA4RTZaQ1owUDZjUjhvNWhVdzlw?=
 =?utf-8?B?a21QckxGc2xIRlk0SXB5R2ZWRFNMY09BeDNmajlHRFJPMlYrTTM0QU93NUlw?=
 =?utf-8?B?N24wUUdPUGMrNk0xV0M0bEVwcTB1aUNFZCtZSllJTHFCZ0NueG94VHFsQlJJ?=
 =?utf-8?B?RHFlaEN1aFRERFVlN3pqU3lvVmNyaUlVeWgxQTZDbktFeDB5QXdIMVBMdlV4?=
 =?utf-8?B?UVFpSGZDZUxUL0RPNGMyVlZqdFplSkpPTnJqelBlNVN5UW00azBCNXdCUUV4?=
 =?utf-8?B?alZ3K3pNZE8xcXZRVHpQb3kzOGkwbVd5Wkp0ZVFQVzlPWm82OVFFVVlyak41?=
 =?utf-8?B?RU9nbUNjb2hhN3BnSFhHR1p0am5DdUFncFdEam1yUG1sbmR2VVFWZVhtYkFD?=
 =?utf-8?Q?XmJE=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 10:48:43.1821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 883b0bb0-515c-4822-4020-08de3e230346
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5683
X-Proofpoint-GUID: cCj7jK4ZyX46jNCkI6LBny-WSppaddlH
X-Proofpoint-ORIG-GUID: cCj7jK4ZyX46jNCkI6LBny-WSppaddlH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA4OCBTYWx0ZWRfXxF+7NHfcQkVJ
 T4wZE16zxJP+ms9rp6MlMv18K9kWuTdBDF3Y66nDLm04B+++0yG99nLYjTfLcic4GaWRC4shpYg
 T6ZOKWryXoXnJiKk6OJ2N3gCy1d6aEKQLFeRN3lfiFSpwYb3Qy+bjd53RluShvYp5U3GyRESKGb
 UOV80mQ95QfsOw/cvdGiju3PsJ+THsMtmgWxNufu79Q13DyJtyBMBzLh9o9XbAH7ebjbdfMHCkC
 LUHSalNIXZjN4y8e4qAowQRdHmlfucGt9GoCKWmJJ6BVpMKnBeTyXteXyOZYtOtoM9uLrwUIoy3
 T3MgvXrUiu5ktXqpQ/ZcHbZdlzJpDJZzTEua7IqEKmX1AMZdstv3YLGlYl7Me5cgaY1zk3XUcLR
 UqNWq9WOwF966djXmVK6dUh9rsDcsA==
X-Authority-Analysis: v=2.4 cv=NZfrFmD4 c=1 sm=1 tr=0 ts=6943dc0e cx=c_pps
 a=r2xCUacPW6+0uY4RK98evw==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=HjypFGx7bZcA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8
 a=mIaYqXcFVyjgMn7lzCEA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2510240001 definitions=main-2512180088

The series fixes a stability issue when dealing with <8bpw
transfers, as well as enforce an error if the DMA information
provided within the DT are incorrect.

Performance enhancement is also provided by allowing a polling
mode which is triggered when the transfer is so short that
polling mode transfer would lead to faster transfer than
if it was done in a interrupt driven manner.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
Changes in v2:
- reordered commits, putting fix commits first in the series.
- no changes done in commits.
- Link to v1: https://lore.kernel.org/r/20251217-stm32-spi-enhancements-v1-0-943348b8ff66@foss.st.com

---
Alain Volmat (3):
      spi: stm32: properly fail on dma_request_chan error
      spi: stm32: perform small transfer in polling mode
      ARM: dts: stm32: add spi1 sleep state pinctrl on stm32mp157c-ev1

Deepak Kumar (1):
      spi: stm32: fix Overrun issue at < 8bpw

 arch/arm/boot/dts/st/stm32mp157c-ev1.dts |   3 +-
 drivers/spi/spi-stm32.c                  | 106 +++++++++++++++++++++++++++----
 2 files changed, 96 insertions(+), 13 deletions(-)
---
base-commit: 865a1f17d5e41c0b34929afcab0afa6bdb90d33e
change-id: 20251213-stm32-spi-enhancements-29da9bc29133

Best regards,
-- 
Alain Volmat <alain.volmat@foss.st.com>


