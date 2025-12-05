Return-Path: <linux-spi+bounces-11783-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC42CA6D19
	for <lists+linux-spi@lfdr.de>; Fri, 05 Dec 2025 10:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D132304DFE5
	for <lists+linux-spi@lfdr.de>; Fri,  5 Dec 2025 09:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11B03191C6;
	Fri,  5 Dec 2025 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VkzRu0RG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A42196C7C;
	Fri,  5 Dec 2025 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764925544; cv=fail; b=KuX7GKaVCf6QahuGuJkzkJIjQdt6hQQ9t3+kaw06shRczkyDDxG7f69CVJE33YOF6VdM1A3ZZ6Bll8N8C8/oEE5Y4FyKnaWBtpTttZZWCG5jobc3E3IJ5F4SozWksc24i7g8rh9S6rYsMXi9JdcjKZ9ExURN8wKfrdLJQo6Y6gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764925544; c=relaxed/simple;
	bh=wzCkZzPbWhj39oG9eKu97XakUMXNooBsQoajHNemf1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YG//rxOIKFjnlpzjG+2uLn38yIGG4gQlwe8LHHIKZgnKGwUXVSrvvJKiSxVh3GhaXRPA/w478KNt/6MYJFi5OSL60dTiKTxguLfqT6hryR7rEPk/VoVHK18vlTVTsk+hY5ME3l1D/AazHUXh9/VrqQJYSFCRhK0U9hf9kF7Jbts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VkzRu0RG; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B593s242054553;
	Fri, 5 Dec 2025 10:05:09 +0100
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4aub8nb59u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 10:05:09 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGlH2HqMf8n2YzProh7OaU55edPvRkHjHunZU3M7T1xiLDQS4UQHTOwh43sqSWqpLupEYotSzQaVqZO7S58j+NaVkI5eAMq/u3UChowOXjA1PhdgyutvJbPkpLNbArfMK3bHBFKxL2JY93REIzwkqyNXZVcm5rygUkl+074Q85oQjD1f6qjMFHaIpaoXjIhL1hGBt+QRC2rqhK1H3XurYuYvPVLIefPo9b87BT/oRwxtZE8LagTq7fz4vQej08CEFd9LmBpbQujNX37Q2ZneFdoTp9iI/jc0hYTbzPBIyXDut3rANjoH9Oa0nB/QgalNNjV7SCc6RZvy0Z5v+8JDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFifFDVVPlmakVLPtIWQFBDHLcEXcpKDiqB76TIJ8pg=;
 b=arFCsu1vartFhSn8tRAxlnnqtHe2VharU6bqnir3NwHbAv+yFJTrUXYq8SL9x8btF62zXgoSsu6Lac57Eg/cGSYqvsf2jq1Owcl9sqvIRXQx0p08k57VlLKRgfJWO2F2lj8noIs3XciFIbhGV5i7OWBRiNwB9E3jgZVW12aDzLOmHtJcOGnCePGKJEMGFHov/UZlt8n/uWVERtuqIyuQglAvdBL7pgkma22Lm/+WSoCcm9Pda5NRrFZja2xwVKod5BLV5ZOLYmONjv3WGUYAn21Bzai4s9DsvJi4s4nkPFekSOx0qTN8sHXL4tSjve5Q2bibaSoP//bfA/hoR0scyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFifFDVVPlmakVLPtIWQFBDHLcEXcpKDiqB76TIJ8pg=;
 b=VkzRu0RGSEqM0gitiUBYa+mc0PUwwQ69nfYWsQKKKE5D2SDDj4fIZpvqTfI+41dTyeIgEPBxodDnbzzIQb5P5hctJSe67SOb3dWXte7RPP8k8kZshFQ+lnpMcPNjwX1c7XHDa7Xjf9PWu2M9Hft/fZAyjv5MtzkrQWx0uvXFpADWwYtobe6F05NEHI8SRXndaDnYqZNxEdmOsSFzjajMDU4Vwx5f3bYD6chIwYgV4RKM6YBtZFrhPb0NN177Q3sV3hcOgREVO7usFDDt45NIxYNWfT7R9ENzjHVsv0VGgav3nSErJM55cjVaTLtJxMs+boGKHLXj6Vr80hRT4PF1sg==
Received: from AM0PR02CA0119.eurprd02.prod.outlook.com (2603:10a6:20b:28c::16)
 by AS8PR10MB7451.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ab::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 09:05:07 +0000
Received: from AMS1EPF00000049.eurprd04.prod.outlook.com
 (2603:10a6:20b:28c:cafe::5c) by AM0PR02CA0119.outlook.office365.com
 (2603:10a6:20b:28c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Fri,
 5 Dec 2025 09:05:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF00000049.mail.protection.outlook.com (10.167.16.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 09:05:07 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 10:05:44 +0100
Received: from localhost (10.252.31.202) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 10:05:06 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 5 Dec 2025 10:04:51 +0100
Subject: [PATCH 1/8] spi: stm32-ospi: Set DMA maxburst dynamically
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251205-upstream_qspi_ospi_updates-v1-1-7e6c8b9f5141@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000049:EE_|AS8PR10MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: c981fb4d-5fc0-4dfb-d750-08de33dd62f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmZkb0RIdzJnUWhpZ3dVOGMzQ3BjWkwybUdHN21xWGxFdEdGNWMvSzUrSEtu?=
 =?utf-8?B?T2FRSllpSDRyeUk4T1NzU2JZM3NGT3pJRjBzL3p0WkFzT3NQMXhPODlrSWhO?=
 =?utf-8?B?K1FMWlEydjRQbTNXVVFQT1JOWE5DNHU5dUhQQ0VRd0tuN01Cdmtlb3JLdXlH?=
 =?utf-8?B?YXRsQVhVZ2FDQ2xUYWRaVXBHWGQwNlpqOW5reDg1MzNWY3pNVkl2R2ZjYngr?=
 =?utf-8?B?ZnFEbFY0SWdDbDlCVzNKR2VFMVlCdUZuSmZEb2o5NVdubUZENmlkeWkxNFh5?=
 =?utf-8?B?U3pGVzZhNmQ4M3RuUGdtMW1jN0dBckx3Z3BULy9aajE1aG5DWjBrM3IwYldI?=
 =?utf-8?B?WTJCNTNIOUlheDFod0oveGtwRUJrWm1INmFSc3pFRy82UE92TEtkNzNBbDE0?=
 =?utf-8?B?TDI3UEZQbTRKNzVsc2tFVzFMR2U0TVQwcldsVmlqdTBpd1YvNmU2VkpDeEV6?=
 =?utf-8?B?NWlUSWJrUncwMjNnV1BYLzBMaSsyam1FT1pIeGRGQm0ydG1ORk95WmpUMlR2?=
 =?utf-8?B?WUg4MlBFNWh0QWZSVFdFVkpFRDZhQmwvbnZtMUQ1dXVhcTNrTWYvZ0YxUGJ1?=
 =?utf-8?B?TCthL3FlZTJaZzRxTFh0b0cvQTE4TU9VNm1oRGtHeDlnQ09pSzNFMW8ybngx?=
 =?utf-8?B?ZDkwQXBJbzZMdjFaMElpWFRGc3p4aVlubDhJVHNBcTcvYWpIeStZYjA4cm5L?=
 =?utf-8?B?akJlWE52ZXRkcWFxcThybVpLWTdjSCtuTU8rejlOMmhOM3JoYkUvdXV0L3gz?=
 =?utf-8?B?Um9Cd0ZBWFBpU205WEx5N1BGZ1V3NXlwUXFhMTE4b1BmTi9UYWl3UE5SUW9R?=
 =?utf-8?B?WU92QVRGMWNDeTRFWnAxenBpOTk3V2JaaFdLRGF2eU1mMWxUd0dBaVZidVlk?=
 =?utf-8?B?Z1prc1dCLzBWbk5MZmp5TjNJRDZUUlo2d2Zxbk1JbWdVR252YWFvWExPaUty?=
 =?utf-8?B?YWNIMGpMMnBYQUJQUVRRMGxTaUtTTzlGWmpTaFBha1pUQUFpU21ra2JCQ2RM?=
 =?utf-8?B?UEV3RFd6Tmorck81a1dTN0ZOZWhZN0dJNk52amRidkFYQnZNQ1lscWtoMUhI?=
 =?utf-8?B?ellNb3FKOW5UUkMwajcxQ0VRMlBTTEtQY2Z0cDlSZEcvdHphWUNXamw5NGQ4?=
 =?utf-8?B?YWptaDdnazdXLzkxSEZTSm1wYnlxTEVQUmZEOVBUaVZWTmMwaU4zdWJ3SWtl?=
 =?utf-8?B?UVBIZk81RkNUQUtVTE5SNG9JT3VVSG1RMkJidXRSUVZRNDRNT0tPMkw0VWJx?=
 =?utf-8?B?b0xGcXlNSmdRZS9iYTUweEQ2VC90bHdzTW5kb3ovclA5NUZlbGlLamtSdXVN?=
 =?utf-8?B?b3BiNEVyTHE0aWVzNjFTQzNaV1VKMHVWQURtdUdZRWVnY0g4SVk2WEc1clQ4?=
 =?utf-8?B?S2xlNXBCeHloL2ZLNHpxOFFUZDJnaGFLTC80c0NHaUI1SEVmbGdDQkZLTDJo?=
 =?utf-8?B?WGVwWVZhb2JFeldwbTBWWnVtMUlpZ01JaEZOVXFYTWVpclZJN0JxcmhNYy9z?=
 =?utf-8?B?VTRKSFlQQTBsSC9UNjJpaDV0NWtZTUl6SFlkblBiczhXWUs0alZMTXBRQkd5?=
 =?utf-8?B?a1BVZ1VhS1JEd1NYSEhBVjBiRldTQ0ZrTCtiSWQ2Y2Q2UnBOREV4WWhOSjgy?=
 =?utf-8?B?WnI0amJMemVIQTNaajZjZThzRjZNNStCY3dpZTUxT0YwZldSVDNncWRaS0hR?=
 =?utf-8?B?V0tHdXMwbDBOQjB3dlY2TklTN2xac1hQU2Yzc0NNREkrU2M2TEtjVnVnaGlr?=
 =?utf-8?B?RnB5OUgwU20razVXSS9qN2RLMWQ0bUZNWmsyU2tBWDF2UEd5UTRYencxQmwv?=
 =?utf-8?B?YUEybjJ2NUpTMFpoOElCNk83Mnp1OU9kQUpEUzgvNVh0SWYyYmkxV2JiaUlk?=
 =?utf-8?B?Uzd0MVI0am5hNTZmWGRkS3lHYW0yVHpxSy93TXZFWlArRkQ5U0d1RjZUT0Iw?=
 =?utf-8?B?c3ZuSUpkVUtRYUx2bmxhWUEvdUtqMXJBT0RCc3JCYkRLaXU5dGNybk1Bbjdv?=
 =?utf-8?B?QlhZOUNmUkJRd1FBOWVRNm1td1B0ZGFHYjZEUWV6ckdYSE1rNnZXK2MyYXFz?=
 =?utf-8?B?U0tRTnNQdXhDeHY0UzVtc1NEOUZKbkRQZ3ZGaW9EQkFZTlRNUHJDOFRKcXk1?=
 =?utf-8?Q?4mFM=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 09:05:07.3667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c981fb4d-5fc0-4dfb-d750-08de33dd62f8
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000049.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7451
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDA2NCBTYWx0ZWRfX+PrmxCXoLnhJ
 HV227ar3E7VWE5qD9N7bJKYdj9z90cRtnCx04VKL7O+CZkcAg01HTrroRDk7OwHNr3uCrylcWRs
 a5lzMC5bpP6/WxX5pV6pj64ZrbdWXFpRMMpMGooZh0BBLQCtotKyX3imNkvkEm5Qd5d0vNRW/BX
 GUSYtxYqEBXbsR73wxy/YmhbPegSAEowdo2BO6Svkntqfc2Qkm1JNDxPr5+zoRgrIl5Ql8AzCBa
 FxayvZBSGcYLXE2QkgBQh2GFWYdzkzVWjg2h/OL03LvOtEAFKW+8xftLXaY608RFAdBXFOo98L9
 i/9PSrVtIjWMKeJz6CxfGr5Ewon4OpMWGbWz/fN2CzFUyXAGLuqITD60IxOwkDHdq+hfNgneQF3
 oDbR08fkdSJ1hU9s/RxMTnKjXSpcKg==
X-Proofpoint-GUID: s1_y8IfCxYMHFR_DWyxu3rvho_XoxwYe
X-Authority-Analysis: v=2.4 cv=X99f6WTe c=1 sm=1 tr=0 ts=6932a045 cx=c_pps
 a=zZ2aAuEz6FT5R9GdLdvfGA==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Uo5EeBN78AAA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=WbBYHnI1PNLwm2dNkN4A:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: s1_y8IfCxYMHFR_DWyxu3rvho_XoxwYe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_03,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1011 bulkscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050064

Set src_maxburst and dst_maxburst dynamically from DMA
capabilities.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-ospi.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index f36fd36da269..d733e37f0435 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -278,10 +278,19 @@ static irqreturn_t stm32_ospi_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void stm32_ospi_dma_setup(struct stm32_ospi *ospi,
-			 struct dma_slave_config *dma_cfg)
+static int stm32_ospi_dma_setup(struct stm32_ospi *ospi,
+				struct dma_slave_config *dma_cfg)
 {
+	struct dma_slave_caps caps;
+	int ret = 0;
+
 	if (dma_cfg && ospi->dma_chrx) {
+		ret = dma_get_slave_caps(ospi->dma_chrx, &caps);
+		if (ret)
+			return ret;
+
+		dma_cfg->src_maxburst = caps.max_burst / dma_cfg->src_addr_width;
+
 		if (dmaengine_slave_config(ospi->dma_chrx, dma_cfg)) {
 			dev_err(ospi->dev, "dma rx config failed\n");
 			dma_release_channel(ospi->dma_chrx);
@@ -290,6 +299,12 @@ static void stm32_ospi_dma_setup(struct stm32_ospi *ospi,
 	}
 
 	if (dma_cfg && ospi->dma_chtx) {
+		ret = dma_get_slave_caps(ospi->dma_chtx, &caps);
+		if (ret)
+			return ret;
+
+		dma_cfg->dst_maxburst = caps.max_burst / dma_cfg->dst_addr_width;
+
 		if (dmaengine_slave_config(ospi->dma_chtx, dma_cfg)) {
 			dev_err(ospi->dev, "dma tx config failed\n");
 			dma_release_channel(ospi->dma_chtx);
@@ -298,6 +313,8 @@ static void stm32_ospi_dma_setup(struct stm32_ospi *ospi,
 	}
 
 	init_completion(&ospi->dma_completion);
+
+	return ret;
 }
 
 static int stm32_ospi_tx_mm(struct stm32_ospi *ospi,
@@ -899,9 +916,9 @@ static int stm32_ospi_probe(struct platform_device *pdev)
 	dma_cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
 	dma_cfg.src_addr = ospi->regs_phys_base + OSPI_DR;
 	dma_cfg.dst_addr = ospi->regs_phys_base + OSPI_DR;
-	dma_cfg.src_maxburst = 4;
-	dma_cfg.dst_maxburst = 4;
-	stm32_ospi_dma_setup(ospi, &dma_cfg);
+	ret = stm32_ospi_dma_setup(ospi, &dma_cfg);
+	if (ret)
+		return ret;
 
 	mutex_init(&ospi->lock);
 

-- 
2.43.0


