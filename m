Return-Path: <linux-spi+bounces-11990-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 128E3CC9A27
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 22:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8F4C30076A2
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 21:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1244F30DD12;
	Wed, 17 Dec 2025 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="hme4UAja"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367312494FE;
	Wed, 17 Dec 2025 21:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766008375; cv=fail; b=F606uxgHQFq+hPHD0QmRF2OZRrLY1A4sjBLrLfByurMVTHeBA+PFCTLk45rxS3Zim7xtzzKCMTx6WcXP9tc4sxvFyd8wMzP1qtVuMEquUsf1+TAO1QToZja3f2nV/OeeybdFLhWx+fGPYCXFUPNBGlNWgTv5JsWas7RbQKH/PYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766008375; c=relaxed/simple;
	bh=zcnQzWvqAYpoOTaSwfrhPaifkze2Wf17w/YA0BHoCks=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Aa3TikincQsA1a7GFVyOQTRpNGu+8rKMu2zKRA6EvzAZTeXDtpaD914iTSE6yFgblYVgozclnWVr3LzGCeL6LxshRcJI0+WTbY2vKkwKO3pwGa1jV8GILWxUkZNo1sqGIvtaSvE6O8II9Dc9RbEc5N3kisln8HpE6hu+QL1wO4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=hme4UAja; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHL3NdE071209;
	Wed, 17 Dec 2025 22:52:41 +0100
Received: from as8pr04cu009.outbound.protection.outlook.com (mail-westeuropeazon11011062.outbound.protection.outlook.com [52.101.70.62])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4b39n9dsnm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 22:52:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLwYxgS/5FwVdA/GFtBIYgAm+/lOGmVNBMjP4v+UTXtViU48A2rxw+agwaHvzfsDuaYMjNV7VC3uLYAJMQdwgFWYSRm20fgkmdRooMAeKSsOX8c+KJirsAEFZJ6OMOVTgmhhNKPId3Lw9dcweTwCTWK0JE4xlpoKrvgc3W72XmkicEW3tPe3WxtyO91REkwW//Y5RD1oL5nEjosWv1dMXF52cEtT8zzYXqSCALCVb2FBrFZ2pFSCt/Lwmhp69NU5O6ALXF54CpsWlSl4UKq6C7fbTUQDf1ngdobHgJX/qqIqdCMx+dUOkGkUHJfE0e+1ohZUQaksTEhT1Vw0hmVdlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZUT2elJey3oXOKRkFeaneLLzcYm4UWb8JQ3a19O+40=;
 b=lY3lbou2Vv4mLOalxZgetYV3/LKnx7EmdO/TEw+3aQfCfETkAnufzorSXOOUQJoRJsAedwjhjBagV9YSbqVwK7GLZ/ikC4QN/MRBOaMrlMeS4CYiT6JzMDUcaFwqkjxDXJs4oVeoe9t3uUhoesyYDQqfIEZZRQBLvoxbeJllsNeJ1RA/uG5bqinQY/8/5PeR6W0TTFVq4fkF9wkqaNfA2QPVkEdb1WzIJKHxfM89m7sWFx48rnzz3Pkpk26pM6ZonRXnuk36phsDcEbl7H2uAF3qBnrYhH1n5bvwfC7PraNSu8XyH373NKJSRcfVEtoiP7fwLYXiqiSwG2E6IzaCBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZUT2elJey3oXOKRkFeaneLLzcYm4UWb8JQ3a19O+40=;
 b=hme4UAjavvLl1ess4AU9hb1F/UFvAsNPoo4XtZTeQzJA0Lb95Qd2gC7mHFlZUzPhaZl6670snm8k3RdtchwVaLMcr52BGYBrF652C4uvb/Tsuc0GFGqt+dabbFNPQGUUl9QoYD0A4BKEroRtXMNaN1TBVsic6nDNnHqTwWilw2b4Jy9qlG51keY4DhDHq6cEUtD9ooAqDxV2vy0uh0XmeqXtiv5rKp9mpOaKP1IbYT7KG2M2CngQXtLwyXRbwiSAF0p2P1+96FzqH4rFC6fePqLR0vCdWDmzQO+d8VcU8uyQCwrkAxy/Ub/Mms7LFjdteJLcL1p1TjQ5rgxDKw7M9w==
Received: from DUZP191CA0063.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::7) by
 PAVPR10MB7187.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:313::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 21:52:38 +0000
Received: from DB1PEPF000509E8.eurprd03.prod.outlook.com
 (2603:10a6:10:4fa:cafe::54) by DUZP191CA0063.outlook.office365.com
 (2603:10a6:10:4fa::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 21:52:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509E8.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 21:52:38 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 22:53:22 +0100
Received: from localhost (10.252.10.67) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 22:52:37 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
Subject: [PATCH 0/4] spi: stm32: stability & performance enhancements
Date: Wed, 17 Dec 2025 22:51:30 +0100
Message-ID: <20251217-stm32-spi-enhancements-v1-0-943348b8ff66@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOIlQ2kC/x2MMQqAMAwAvyKZDdgUh/oVcdAaNYO1NCJC6d8tj
 gd3l0E5CSsMTYbEj6hcoYJpG/DHHHZGWSsDddQbMhb1Pi2hRkEOVfB8crgVya2zWzw5Yy3UOCb
 e5P3H41TKB5U1dB9oAAAA
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
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E8:EE_|PAVPR10MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: 29780006-4184-4147-20ad-08de3db69846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0xWTXVkcUxFZkFJcWl0cWdwLzduckFaaEpTZHRyVXd2R3FYcTNMa3B3clc4?=
 =?utf-8?B?NWh1TDR3Qk5FaXBqNExlR1NLNVJ5VHNabHArNENiVUt1M25kblUrYTZ5UDZ6?=
 =?utf-8?B?YnRJOUdXMTF3VG1wUXBNVGNYclFlb2RMYmk2clMxYWxuVDVLNkI4c2c0VFMy?=
 =?utf-8?B?b1o5ZTZGRW1FQUQwNWJrbHZXMlptQ2RtellxK3NRL2VFaUpvdjBtVDhDdEFI?=
 =?utf-8?B?RHZwbXVOaVBBSDBpNzRHcU1xTUlwVTBaMTJpZ2ZSblI3aTlKOVQ1cFE2R0E0?=
 =?utf-8?B?ZzNBTUFaaDRrYTVIWkp5bUd5eWJ5dWllQm5HSTVFVGl1RHA4aTk3MTlnU0Ft?=
 =?utf-8?B?cWsyWWRHbnFST1VWWHE1SW10ZkcrWEZxc0JiTG0zU2ptdS9zM0gwMUhVUU1M?=
 =?utf-8?B?elV5a3BQOEZDZUp1WlBJTUhLUFcwb2hRNm96eTc2djBOaDgvRXFpczVFT0RH?=
 =?utf-8?B?QUNUdVlCRUJ6elpSeElOMFpSWU1aNDI3Nkt5MWZpRkhmM1R0UVFwMWF6OVA1?=
 =?utf-8?B?bGZ2eTNHbUJQM0d0M0hZdFdxT2diL1ovUVduUkJhWUhlRmlCZUFGMEZWR1Vl?=
 =?utf-8?B?N0R5UlNTZWxzWkNpSVh0ZjNsMmhtMHRXekFmWlJ1ZlBLcWw2ZmNubzcwdVJE?=
 =?utf-8?B?Tm9oRVJUdTJHQVUxVEdlTW9RZ2VrVzlDVE8xeGdBdkRTQlV4cFluME5wNFQ3?=
 =?utf-8?B?SkJtV04zWkZyVi9SWUpjcU1ZcmJybTJLOWZDcTJka1hmMTNrYVM2ODNBbWl5?=
 =?utf-8?B?MTUvcWJrVUlnaExmdUtTWmJBZ3RaTXg2RUkyVldMakpBUk9JczVKWW9XWDZz?=
 =?utf-8?B?Tjk4aDNPMC9vQTg1Mm9vb1lHckFQMHArUEFqS0dTeEI2MENCOXpTeThGN1p6?=
 =?utf-8?B?RnlTaDJFZG1Hc0ZRWG1TQ005Q284Q3ZVVjJzWXB3RWVxdHlsYXYvbjYyK1dC?=
 =?utf-8?B?ZStlWXpKdG5vdzhybUlTSC9MV2VsbmoxckNQTTJYQ0puMGdNN1RiTTRLdHpu?=
 =?utf-8?B?R0VjbmFiSFVSQjR5Ny9yMUc5OUNGNmpXZHdGY1FFaHUrbnl4Z09BdG93aWxu?=
 =?utf-8?B?UlZDU3FQcmVNZkJWSDRzdnZlOHpuUXc3TkdvR0xNVDAxMUZ4dktKamQ2M0Va?=
 =?utf-8?B?L2JjUXp4Z013VTdqSDJ3b3h6c3g1NStUR2N6c3FnTmxuakwxRnQzVytZb3JT?=
 =?utf-8?B?UDc0a0JXL3RGNE5aYWdwM01DcVpPWnoxeHlTWjNyQWtBNW1RVDBSTVVBTGdk?=
 =?utf-8?B?SDNBalp0VVdLeGlINWNwZWtweGgwQzFEbFF3a1hnZ2VnY1Q1aCt6cGRRQlM1?=
 =?utf-8?B?RXViOFZYaDZDdmUweTFoTWZqY2gxQ0pBTUNWTVBjRk9uRmpMYnhWMWhOVFhH?=
 =?utf-8?B?VXQyekN4dXdCYXE0Y2FnWUNBSU5WQnd0UUt2QXhUYmJwZVBrSFZJbk01ZmJV?=
 =?utf-8?B?aVhCSFJ3RDR4aWZGQmhHVEt3ZktjdWdyWXY3d0h5QVk0UU5iS2JBVnRXeTB3?=
 =?utf-8?B?WTRtUkVlOXZyYmpWeHc4WVkwQWlEVVZrcnR0V1BKOE1tSUl5SzlJQ010UGxr?=
 =?utf-8?B?U1VhYjVRR2VxdGd2ajVmaEFMZmszejFZb0QzNDYrcEswWHk1OURPM2FneER5?=
 =?utf-8?B?NVdUbFYyeElhSlJBb2phTGtoVEZuOUp1N0N2dDBHUU1kRm1ZdEVSdStIVldZ?=
 =?utf-8?B?MExlRXFSQ1BQWFFuL0g4ZTlWUHFaaFM0clFyelhMV2E4SS9lelpMTjgwNjhF?=
 =?utf-8?B?YUgzSWVZQUJiYndNYTRPQS9lK3VPVERPOS80TjV2aDd4N29scEMvQmxoem9p?=
 =?utf-8?B?UGRBVXkxeFJEd1JPSENQVGlTRXFUMzhMMFJBWmZTSzlaelMwSUxHdDl6OGtt?=
 =?utf-8?B?MXBGRXVSYzM3QVJVR1V3bzNjMFF1aU0wNHdJd0xjVUdzVjNWTXBUbWd4Z3hY?=
 =?utf-8?B?dUN1N0FnNHRpd2FiMnpXSWkrV2hHdUQ4Y3BjUmJha0d6VHdIN2tMZWVnV0ZQ?=
 =?utf-8?B?SjR0bDhQQlVseUMxdjJDZ3lTWE9VRnR3L2FXOTVyV29LZnYzK2x1VFEwQll3?=
 =?utf-8?B?dElHR3FXeXNqSnhCV250blBYelNieWNnSERSWmF6TGFzcWpVSG4rV2wwa0xx?=
 =?utf-8?Q?DTRM=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 21:52:38.0074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29780006-4184-4147-20ad-08de3db69846
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E8.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7187
X-Authority-Analysis: v=2.4 cv=EK8LElZC c=1 sm=1 tr=0 ts=69432629 cx=c_pps
 a=uRR/ghUgKoaGi0UFgWMJiQ==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=tougUffuSCAA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=mIaYqXcFVyjgMn7lzCEA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: QhYcRvqT_t9hpy9BralPJLerxYybHpAw
X-Proofpoint-GUID: QhYcRvqT_t9hpy9BralPJLerxYybHpAw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDE3NSBTYWx0ZWRfXznzEUGBQTrwQ
 oM806VC1U6LmiFnosoO52UX++qoIVW6lYfxryRwUTLNanx3xqkMCEbOaDHXtlv2qfxgyA+th/7d
 q4FqMy3X9taSq5Nvwb11m+qp6iTSpRI8cdcboRsv/F93FKgRJALgXFoiBB8siDoMhI0zP42KTL+
 2owv78q4oVWaUJHAXugNQudxXS8BF5Rb4fWZnxeiJQZHd5Zw/qPqMdAmsiGInEKEGkkxVTImaVx
 Bd0KNI/KiyUOY3ieekL4PPfWnMQS4jlGeBPCIZEI4qpMZfE3D0/OY3uSnteqBd8Jw83KK3OMAXT
 c3wsZswxPXMM0Eg17RIX0rtX/1ujLQk8WAzJ9K998Wn/ZF+s0cFdu2WfZizmBZ8qYhbcXW4p8og
 IClAgJ8n6KMZGpPke4ckzvrOCWmPJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170175

The series fixes a stability issue when dealing with <8bpw
transfers, as well as enforce an error if the DMA information
provided within the DT are incorrect.

Performance enhancement is also provided by allowing a polling
mode which is triggered when the transfer is so short that
polling mode transfer would lead to faster transfer than
if it was done in a interrupt driven manner.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
Alain Volmat (3):
      spi: stm32: perform small transfer in polling mode
      spi: stm32: properly fail on dma_request_chan error
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


