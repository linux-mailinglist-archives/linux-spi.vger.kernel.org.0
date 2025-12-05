Return-Path: <linux-spi+bounces-11786-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3057CA6F6C
	for <lists+linux-spi@lfdr.de>; Fri, 05 Dec 2025 10:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 811C7301A70C
	for <lists+linux-spi@lfdr.de>; Fri,  5 Dec 2025 09:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C642931B118;
	Fri,  5 Dec 2025 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="fAfyxhY4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C09322A26;
	Fri,  5 Dec 2025 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764927615; cv=fail; b=dIOuSzvlrqpjpY7Rr7d+s6tBVJeNF2GrYteMLdb2ufQPj1zI7pVAUqq9W85d8JGvbK4k6nB9pE37d2AUD9bLLBCUEXHxw8jMRnNapi2ouNJgKrIpu4/hpWnoqTLRZ2DVKngqdAjZC33UJcwzn9KElJSM1J98uSXZYUXOUxd9RFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764927615; c=relaxed/simple;
	bh=ep3js4OiaotQ4ox5Rrl+kNuqCwYWyycqnEP2thZTTis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=K8V9/93zvdPexbUOvMyWadFDgHu4VIMUcUundLzaOsyamJ0uHDScgCNkbzi5Rs3Qfc3HzbXPPk9VNLafIwKgPZ0MWP7vCn+RDByTHBd2W3nhgfWU2SL3U+emx9o6ii3mzttHduzw78fT6pevhqfvGXxc5+0iBkbkECnoC9eBviQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=fAfyxhY4; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B58wgxi1827295;
	Fri, 5 Dec 2025 10:05:12 +0100
Received: from am0pr83cu005.outbound.protection.outlook.com (mail-westeuropeazon11010017.outbound.protection.outlook.com [52.101.69.17])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4au1yk6gkj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 10:05:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KN8jtjcG3jGD4HvBLE6LBQESY/REQH/I+27lS3DBtlZrOSAApPxqBTxep/zeYfYge8kgqO01Zeweq5ZiNRHtyMEzuGeU8Q2fyJdh3t3grCT/kH3ySwfny1DamiSSViT/qRdCcYG/Tq9N+hdDipaHM7xXgjv3ihiG12YifFS4yqsfj+i0rXyw6gASoJMZFx6MdYYQG+jqp1nKdM7uriWGEXD4QFLZUZ5sWgggEvMaVLeKkcN0+bkJUkC91C3LZCY2bLB1VcOJXLsLowpmLvu0GmajYj2Gpv1TY0Kwj4WbppI+ntJRDiTmxyBp6xb3DxExI0K0pY4J2DM2lFeNIaTVqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzaeKJv5cANruTig0GzxEtqLPYtRnt4s5JNAJTzPQNY=;
 b=HRX5KOyNXfOAZwbqG2eAQm67OW/oX0qShTJUDsugKSpoMYOVUHBy0oa59HuzKDoS5VorrRBB1QFKPaobT95mt5n3InrwV3fpfzxN4f7JSU/0d6Ke2GgNQ8vBDkido/khqXp/8ze3oWcXABEYKe5JRDlk7efpBUap/lfdt6oK/1odldMnY/YrixRvCzmXqoEPMmC4zhlWRsOz6nMWy3QWzSDrn+qN0CvGF232Y8GKm2SZhXKk3CmwocOx6jhvdT0MUoyVtd9933srDU7K4kw6fRJ0suwsfjIE68Oa+TkBHjeoe6kdCXbwbYPEmfMiag6/9lrPSPyHNP/sf2qMbumR8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzaeKJv5cANruTig0GzxEtqLPYtRnt4s5JNAJTzPQNY=;
 b=fAfyxhY4JDq5XiTUQ+pPQcutgR2KesCeaCnqKwcS/Th+JrEBMQlA/KMXdLq/cj7aaOEWA9e6uiswzN9khNI3IW53kbUQAave8k+eQTGGsTCCM4KfqF5++No9uVIUx8+dP11Mrru5C5B8iZaihzYYZDhWq9z5Mzdfg/UpnO5oI1pcniB82ds8NAZlI7enPNXePZiBq++6B4Y5VVCbfK26j1KGANCKLFWbHdcYpFoLYon10TYBDSGJj/hsSxjHja27Smj49xrIxyh83mg2ewHr2oLZ7e2B9Wu3olb8A4nUR3VDFsZwgbxE/P8nBOVxOq2iHJq2doZ4DOnUP0NVOkrPAg==
Received: from CWLP123CA0271.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1d5::19)
 by DU0PR10MB5387.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:329::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 09:05:09 +0000
Received: from AMS1EPF00000045.eurprd04.prod.outlook.com
 (2603:10a6:400:1d5:cafe::19) by CWLP123CA0271.outlook.office365.com
 (2603:10a6:400:1d5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 09:05:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF00000045.mail.protection.outlook.com (10.167.16.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 5 Dec 2025 09:05:09 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 10:05:47 +0100
Received: from localhost (10.252.31.202) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 10:05:07 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 5 Dec 2025 10:04:52 +0100
Subject: [PATCH 2/8] spi: stm32-ospi: Optimize FIFO accesses using u16 or
 u32
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251205-upstream_qspi_ospi_updates-v1-2-7e6c8b9f5141@foss.st.com>
References: <20251205-upstream_qspi_ospi_updates-v1-0-7e6c8b9f5141@foss.st.com>
In-Reply-To: <20251205-upstream_qspi_ospi_updates-v1-0-7e6c8b9f5141@foss.st.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <linux-spi@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000045:EE_|DU0PR10MB5387:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc6f242-6deb-4cf6-8b6c-08de33dd640f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUdYZlRRK3hhc2c3ZUUvemJGWVk5TFBYenNHZUJIbU9UZ2tyQUcwTjMzSzcw?=
 =?utf-8?B?SnNOVmtnVHJSQXhjS3dlYnUxRmFtSzRnMUxtWmpKZXNhRHYrZTAwMUZjMFVL?=
 =?utf-8?B?Q05lTXFCQXZPSXFKcDh5cEJKdWg2Qk15bVpiTXIwdUZ3VDYwMlJUbVFkdWNP?=
 =?utf-8?B?Yld3dGU3elVoeGUyWmZ5WEdFQUQyUzk4Umt5TUQ1QlFFd2k0L0RQV3hxS3Nv?=
 =?utf-8?B?TFJGTFNkQXV1ZWV4WWZRaWtVNUhZUE41c1UxcmZWM1VSeGVTUFo1di8zUWRP?=
 =?utf-8?B?U0tKM0JVbzdqQjJPWlRtQjhlenpOM1VKK3BCUVVwR0RJZ3l6QzM1S3dFVGd1?=
 =?utf-8?B?QmV1U3RhYW00ejUzRm1uR3BpbkhCNHF3QUYwMmE3SlJwWXAxWFZDaFZDSEpn?=
 =?utf-8?B?QTBCWUZabWhDOVNtSmZXTEhRd3NMSzRobkFQR24yc0wyWlhPNTdKaHlaWUVM?=
 =?utf-8?B?OTVnZ2FNaVQxOWw1Qy9wTkczbWd0Z3o5QUk5aGE0YkhOemlXd29EZWIwQXNX?=
 =?utf-8?B?b2M0WHE2U0VGMnd1NEJrM3V1dFB3bUNySFlvOHdRQXdMbytIZURsbFpoUVNy?=
 =?utf-8?B?NlhnQ3ZQeWIvMTd2NzM5b1luSE5kbElSWUxkcjUrUjNURXVzZngzaGV0Qnp5?=
 =?utf-8?B?YVp4aGhJYVZYUlRHVzN5SWxQeFdMa3pxRFdQYm5sdWttaGpwTkxHbGlXMEYz?=
 =?utf-8?B?OGZvQlltbmRDZnduRmdwUEp4blF4Q2loSVYvVU5IckVyTGR1MWdGMjdxL0ZS?=
 =?utf-8?B?VUl6WTNJVW1VZXFCSE9Ka296N2t4Q2hYRzU3dVd0cmRPU0xMM0kwbGpQeGhL?=
 =?utf-8?B?ek9DVjJiMk1mQURJN2lMYUVPQkFUTDZ1RXJLaFliTXNBU2RROWZyYTRMTnBY?=
 =?utf-8?B?ZVdyNHNOTy91SnY5dEcyVlNHMUxTZmQzNXA1RmQzY05sUzVNNHBWZlJEK0pa?=
 =?utf-8?B?L3h0ZllzMVVPazBEVUU5SnB1KzJocEhCSUVuQldta1NJei9QTUZzQ2g1RzRM?=
 =?utf-8?B?REZtZEN2SFlmTktZOGErUTVGU3dlV3RkR1lacCtiamdUN0tnOUxWOVIrZ2hH?=
 =?utf-8?B?TlFqbHh0SHB2NXU4dzVZV1B0QUxGS3dvVjdHZjlZZHB2VUEvT3pDR2ZoN2to?=
 =?utf-8?B?UjVOcXVmTkFkSGJaVDIwaXZkcHRVK1VUZkNqT2Q5Q3RIVGdHaDhTUUJNVW04?=
 =?utf-8?B?YkhLSFJsMFhUMk1SVkRJZlRvZ0JyWWRyYm5ZRE1lb2pOcmY2K013Rmx3d2N2?=
 =?utf-8?B?MldrczhGdUxzVDRsNnhPYTc0TlFnenE2N0ZFSk56MjlNbUorTW0yOEQwNFdt?=
 =?utf-8?B?TG95THYyQ3RVWUxJcjRITXUySnJkc1pBQ1dxTFJEc1ZUT1M3czUyY0hkbWtp?=
 =?utf-8?B?WUZYVlpuQ3ByZmRtMFd0UmdLcU1XRllwV0ViTWhKd2RBc0lEb2gwT1B6YnpW?=
 =?utf-8?B?R25RK0FINzNCL2lMejdxNWdMRkdhUFdyN2FzakprWEpuR3R4bmtrVGg0M0Fo?=
 =?utf-8?B?WTJZWkYvK1l3K04zTWtuN2hGK2RmaU1zUFJYYzN3ck9CSktHaTRsYm5FY2Y3?=
 =?utf-8?B?N1Bzc2wydmJRT1hpUVZiTEFNK0ZmcDc2SitwWE9mbE5YNmNtMDdCQmoxdlE4?=
 =?utf-8?B?UFBnL3kydk5HZ0JjMzdZcmkxZFB0S0NuZXhvWDRaeGppZTlKOFlKaTVISWpZ?=
 =?utf-8?B?aGIrdFM2bk12czFyemVJUjRUSGRLd3VVUzJqWTBqUjlqOCszdlNaUGtNaTA0?=
 =?utf-8?B?ckpIWEo2OGd3TVVBMnZRbU5wM2RoRHJySFc3c2xhZzk5ZVc2aTVHdUNZRkJ1?=
 =?utf-8?B?cUlSM1RHQTNKZlBEZWpwMVFUMFRTUndRaGZnZVBRSEE2bEtCcUw3WjZvWVBQ?=
 =?utf-8?B?KzBBakFNcXh2dUgwUDNUNy9PUVp0TDIwR2NYY2dJc1BJRk95NVJNb2lkYjVv?=
 =?utf-8?B?c3hyOHRMSzdSYU1pc0g4MFhoZzB1R3VuL0pkOUV1VlQ3Q0t1MmdVa0VXd3FT?=
 =?utf-8?B?V1dBV2xWa3RHNmZiZlB6RjAzQkdvWHVPWCs1dDlwRGV1Qk1zSHhRbWlSNVFh?=
 =?utf-8?B?bGZvS3p5SUIwVXF3Yk9SeFpod0NtL1BGK0orNVJtT3Yxa1JyZ0UwZ2diQWtF?=
 =?utf-8?Q?Afuc=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 09:05:09.1901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc6f242-6deb-4cf6-8b6c-08de33dd640f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5387
X-Proofpoint-GUID: FtXUnQgIL1RYz_jJuP5xLxKKHWIx0hUi
X-Proofpoint-ORIG-GUID: FtXUnQgIL1RYz_jJuP5xLxKKHWIx0hUi
X-Authority-Analysis: v=2.4 cv=eobSD4pX c=1 sm=1 tr=0 ts=6932a048 cx=c_pps
 a=67JRAVsqNSV96jld/LUi8w==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Uo5EeBN78AAA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=dgGDXPkSZnP7Mkk4B0AA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDA2NCBTYWx0ZWRfX9i9iiFuHvluU
 piZ2MeXg4Wsh5qyKXm9YKzEM+XmXPcneSYsLFBvAKb+SB7p7+L1UyAz06waZsq0/HTncq0J+FqG
 LAzzBU9BaFVQmPsvfzSFVrjt+U0ZpKg1p+zj54rjx9IVxwyidanPyOPS0bBvq5NuBGRdlOb+0Sd
 wSwzDeNa0RnCJH4Kzly46ECl913UNrP04wmNgV6AGVQgVufRlwzSl+npJv9V0CRJkPbcGdPbJmu
 ZvhzAMLMGzV+2y8oShLM9y9BLO3BSmfc2i4b0j9s4BCGmhbepFIF7e2pdzERJi/s77ka3/1JPZ/
 A6ZqbSlegPj2RlLXekSiRCpuhBvJ/j0PQKk4FQkQ5tmLMoI/Qyc6Q/YeFkvb8OibwzKIVe5PIry
 pvbV3xgm5G0iTY7tFK6PnMYxP2vm0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_03,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050064

FIFO accesses uses u8 only for read/write.
In order to optimize throughput, add u16 or u32 read/write
accesses when possible.

Running mtd_speedtest on a 4MB sNOR partition using a
stm32mp257f-ev1 board gives the following results:

           before        after   gain
Read :  5693 KiB/s  21139 KiB/s   371%
Write:   765 KiB/s    910 KiB/s    19%

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-ospi.c | 47 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index d733e37f0435..a6f53f06200e 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -142,14 +142,32 @@ struct stm32_ospi {
 	struct mutex lock;
 };
 
-static void stm32_ospi_read_fifo(u8 *val, void __iomem *addr)
+static void stm32_ospi_read_fifo(void *val, void __iomem *addr, u8 len)
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
 
-static void stm32_ospi_write_fifo(u8 *val, void __iomem *addr)
+static void stm32_ospi_write_fifo(void *val, void __iomem *addr, u8 len)
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
 
 static int stm32_ospi_abort(struct stm32_ospi *ospi)
@@ -172,19 +190,20 @@ static int stm32_ospi_abort(struct stm32_ospi *ospi)
 	return timeout;
 }
 
-static int stm32_ospi_poll(struct stm32_ospi *ospi, u8 *buf, u32 len, bool read)
+static int stm32_ospi_poll(struct stm32_ospi *ospi, void *buf, u32 len, bool read)
 {
 	void __iomem *regs_base = ospi->regs_base;
-	void (*fifo)(u8 *val, void __iomem *addr);
+	void (*fifo)(void *val, void __iomem *addr, u8 len);
 	u32 sr;
 	int ret;
+	u8 step;
 
 	if (read)
 		fifo = stm32_ospi_read_fifo;
 	else
 		fifo = stm32_ospi_write_fifo;
 
-	while (len--) {
+	while (len) {
 		ret = readl_relaxed_poll_timeout_atomic(regs_base + OSPI_SR,
 							sr, sr & SR_FTF, 1,
 							STM32_FIFO_TIMEOUT_US);
@@ -193,7 +212,17 @@ static int stm32_ospi_poll(struct stm32_ospi *ospi, u8 *buf, u32 len, bool read)
 				len, sr);
 			return ret;
 		}
-		fifo(buf++, regs_base + OSPI_DR);
+
+		if (len >= sizeof(u32))
+			step = sizeof(u32);
+		else if (len >= sizeof(u16))
+			step = sizeof(u16);
+		else
+			step = sizeof(u8);
+
+		fifo(buf, regs_base + OSPI_DR, step);
+		len -= step;
+		buf += step;
 	}
 
 	return 0;
@@ -408,7 +437,7 @@ static int stm32_ospi_xfer(struct stm32_ospi *ospi, const struct spi_mem_op *op)
 	if (op->data.dir == SPI_MEM_DATA_IN)
 		buf = op->data.buf.in;
 	else
-		buf = (u8 *)op->data.buf.out;
+		buf = (void *)op->data.buf.out;
 
 	return stm32_ospi_poll(ospi, buf, op->data.nbytes,
 			       op->data.dir == SPI_MEM_DATA_IN);

-- 
2.43.0


