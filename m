Return-Path: <linux-spi+bounces-12221-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C14CD0487A
	for <lists+linux-spi@lfdr.de>; Thu, 08 Jan 2026 17:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5DA730F1181
	for <lists+linux-spi@lfdr.de>; Thu,  8 Jan 2026 16:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A8A2D73AD;
	Thu,  8 Jan 2026 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="MZYGEDj7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F152D7392;
	Thu,  8 Jan 2026 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767890102; cv=fail; b=rnG6De/vMp3KWeiJzAc6jx55xkO7dpM4HhJ1M+MaLxg7fQBWwPi5tKBcu4NY8UJBLBym9T3grhTVcZdszVX+lvACkhDmU2jvPA7YWTk87MC5oM9P/UQSW7kg7gspd26t+INoDzkOEpkQeKRGqfLb49YY8sqekgplEwoSfr4SqBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767890102; c=relaxed/simple;
	bh=RZlfV5rCYT6kCLo8/nzfB7mrc2CD/s4SQxYe5KmZUZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZPhts88rkOOjjseiOEyhH+eEzEnL/kSlA0upa/VK6ogOGeZf1FX304BGJiyH1WiaCDm0wIlocHBkUZus41nF9VyK8w1naWYMH2SbzxQkUc0PFTaXbM/GftgBe5Byy5D5O6xRYAtMuobn0Gr2TQ/QNU2dPQJNr7rvglXUOadFjdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=MZYGEDj7; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608GK6741762265;
	Thu, 8 Jan 2026 17:34:47 +0100
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4bhcy8ysfy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 17:34:46 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8IP+gfn/QLLKY1CgDzwozVBr+KTtYe9+qBQ0Ko1irIVoyrg2Ek8knYO4WKUgbwXhdHuGL9EWuDjrQB0eYQ1Y7+U8KlSvZRF+EXvq+R8iII3AvX+/7ff5W5o0ZN8RkWSb0TjREKN5iVZxrleiu6YOyuKEIbPM9gUFYLiq4tTWGOErZtkX1/73dakCMOIw3HPheO1ndEO3SWPqvCmKi7WiXPzeVge6lXYHpLklaaVApapPrl9VdGRgpNE9jM3QdQ4qLd39kJVgcNXFsqNgEmTgGaFalsE+MD0E8EwlRgaE7YbLaa+GmY99KQuQfVE0eoaxRI7bPkE3e/pD8HaA6QKNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tozgEZIXTAuNpEUUXp9V/5ixysVC9/isZGcHVF8UqjI=;
 b=V71LNHa2OYkXL9roUEunaCWfO3z4kYX39eCf21reQsss19UwyqJugusHq5DrmIOCu0J7ytKzdwlvkqUIBKOw8FqQLVCVzMUQKKvrqo9s2264tfqkqNio38YAqrJxMJAVlr4qOij06/JTxk2fAL/L2nEoz22gEnerd3XYw5ENvsp1isMLkKrqq/ujkNl6FiZuv6pyUpOxq0japN5nFMuRGv60h1tRYOtRTswT67tKCYucssQdAF3cwoUVxG37+IOTo1u6ACwwrFnqOXmWfyfEZbi2dvDgaB/Ey5MVWsJOPOqytAWOz5ZHGGhYzAb6eRQj3XlsUqGpNZIyZu1Eo3hfCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tozgEZIXTAuNpEUUXp9V/5ixysVC9/isZGcHVF8UqjI=;
 b=MZYGEDj77jC2Sgxi50PRUEPWvlfoNC+fe51VFo3+wh/lh0vwaFSi+caaGKVPAsNNsfJSBPNS6Lb0TQFlMBEucgaHKnwVFvGxu1iHHyiJM7LBfRFWsJpM0Q6lFNmyR3/nfH6QDWbWQn2mMeNZ3WiK1l+2cNBqRStG9wUVeSVSv8sxbVrot7Z33/qZMbrUMKCRBvZC8uCzEWL7QI+ZB6PpV6PdfZ4tdc4wrAKdLTcPVcw732tQehDfXvXUx79bPLNe2N3jHzm5l4bn+O8bj2VYduW2xHsZbrf6ohyEzZVDnk0/4x/e6gMaCMS3nzxim9q66pHpYbHLbykvJJwSRuu0Lg==
Received: from AM0PR02CA0180.eurprd02.prod.outlook.com (2603:10a6:20b:28e::17)
 by DU0PR10MB6297.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 16:34:43 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:20b:28e:cafe::9c) by AM0PR02CA0180.outlook.office365.com
 (2603:10a6:20b:28e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Thu, 8
 Jan 2026 16:34:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 16:34:43 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 17:35:59 +0100
Received: from [10.48.86.79] (10.48.86.79) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 17:34:42 +0100
Message-ID: <db08f1ad-da64-4282-bb4b-002ab1e13a70@foss.st.com>
Date: Thu, 8 Jan 2026 17:34:41 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] spi: st: add power-domains on stm32mp2x
To: Alain Volmat <alain.volmat@foss.st.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Erwan Leray <erwan.leray@foss.st.com>,
        "Fabrice
 Gasnier" <fabrice.gasnier@foss.st.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20251215-stm32-spi-mp2x-dt-updates-v1-0-464a5fd20f13@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20251215-stm32-spi-mp2x-dt-updates-v1-0-464a5fd20f13@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|DU0PR10MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: d0e9a283-5be4-49bd-c4bc-08de4ed3d3d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THFRTzFmZWRRUzVIaVRmV2hqV2lzTlorSFFaMVJCWndGYmV4NDVyclNpSFhH?=
 =?utf-8?B?a3NxWWwrOWRXdWpVemhwci9RZ3E3UlU4SGlrYlR4VWxLRVNRWVI2OHBPTEdX?=
 =?utf-8?B?WnFWcjFzSFRicEhEZG53WVdzM21hZ3l5QlZWeUZpL2NUaWJwMVhuWWlsVHZI?=
 =?utf-8?B?cTdDZmJoM3h0RGNscU1Obm0wV2tyUmtBWkxaYkhOTFE4b2p3bHU3RzhqeGYv?=
 =?utf-8?B?NnRidWVLRXRmK1JSYnhZRDcvQnNtdlJVTlF0eXJIU2t5YWpETGhEdmliRFVy?=
 =?utf-8?B?emNBWDNKUTNtVGdpZktvSnRaZmVubHF2T1AweDkzR2hVaTJTeXJBUk04aUlt?=
 =?utf-8?B?OSttbGNNNFg0WXp6ZEhVeWNnSE1HdzJvWTdEMWVBTW1DTnNMZ0ZOaFUwS0pC?=
 =?utf-8?B?VTZlaHpNS3l1RVR5Yk56bWl4Rk9RV09ROVBGWGJvOHlua3VaQ1d4L2tQb0Nn?=
 =?utf-8?B?amQvUlIvRExmSjJwR0xHR1lvRVNFV1RaaFFtbnBkMEN2V280L1Y0N2xoOFFk?=
 =?utf-8?B?RHUyWUJDQmVhQ0E2aUdlMEx0Mldvd1J6Mmp2UVhjQ3lFcXovSjFqRFZ1NmQ5?=
 =?utf-8?B?anVmNmZHSEEyWVN3RGRGSm9RUVNnMEVwTDNUSWtpVmJwWEJXT3dXekl1UWtr?=
 =?utf-8?B?NlJuZ084WTc2STNhR0J4K29CRlFRekJwV2tlaVNMWGllVFR1RGNsWENvc0Zy?=
 =?utf-8?B?Yk9NWmJBMEhVd1BJYUdWQU8vc29nV01xbmZ4ci9jajdvMGJlNmRDRzZiUDU0?=
 =?utf-8?B?aTRuRmt2SDI0OU1iQzJ2WjdZK0F4YS84SWIwVmxiWXFlbXpua3RpOWhLUkxD?=
 =?utf-8?B?RTNJN0pPQ2FCTWtCRzBzb2VlNElTZ1dxelNwd3JLZVZnRlJIU3M2OEpza215?=
 =?utf-8?B?R0Rna3d1ZGU2SVVZcy9XVDJSUmgyRTBoNnRScFlaSVp1SlFzTDVsR1VjYWFv?=
 =?utf-8?B?QW8zTENuSkZyY1ZzcTdLRy9DblBXMVRwK0ZrWEo0V0NHbTA0VlBBZnZtTnZs?=
 =?utf-8?B?S0czMm5XUk5BYlh5bFpNdlpuQ21OVzJDdDRRbDBZWE12NDRZaWFxWUJjMExB?=
 =?utf-8?B?RldtL0cxbFVzelVFSHlOMkZuMnVnaDB1S1dUUnEvKzE3SnhocmNrVnhPUEsw?=
 =?utf-8?B?andhRVFKSFc0K0toWTExWUEvSnhmbldvQy9URjF1RkpXc3h1Vkw3UE4zWU9Q?=
 =?utf-8?B?U0NpNlNHVm9WMHhUL1c2UFh6blNJRjErS082c3JwODRuZk0rNmwybkN3VEU4?=
 =?utf-8?B?b2RMVWFBcEtBMDRnMDlUcVFwSTdyS1I4SHZvaG1WS0FKRDRaN0tFRWUyZXpy?=
 =?utf-8?B?dVlPT20zMnVEZ09xczIyZnJZVWZRR3lOZWVCRXRIblZmeFI3Wm9rdUxLV0lE?=
 =?utf-8?B?RDMwN29oZXNOVHFrWFFCOGtaNVZQK2ZUVUtlTDF5RTBVcWN0aVBHS0U1cEp2?=
 =?utf-8?B?MDBJQlN2ellOa3c2WXJHMHZZb2pnc2d6MkxjL24rQUEyR0hxWVZsUC9Henhz?=
 =?utf-8?B?bGxvanoyTmc3eGI3ekJmZmNMenRrb0V6bTc1V3VpMUdieDVlc3cycUIvOTJq?=
 =?utf-8?B?QzdpWnQwTTFNZENVQkxacGxmcitiL1J0dWZ1bDh3MnVTeVYzNVc5OEpFdy9k?=
 =?utf-8?B?eDI4aGpzUldkRDQ5ZmIyZFlKNmdoQzJUa3pDYmZFZktmQnJIc3YwMU8yQm1w?=
 =?utf-8?B?dTFmV0Z4NGJrMitDVmFxQ3JPR2trY2x1RFo4bTNmSnE1Y0c2UGx6cWxuakFy?=
 =?utf-8?B?OUU5aXpCbjlvb1BDTW9PRmdKeEl3MTZsL1l5bmN0aVFINWlwQ2huU1BzbWZa?=
 =?utf-8?B?dkJ4VWlPcTg1R2xKYjRzT1BnamtFakU2TU9hanUyMThoRnB3RGNXemtOcDFV?=
 =?utf-8?B?MjZreXBFWEZzV0doWW81RGczSDZ6cC9USHI1Q0N0RmVGdnhSMVpFVnRFT25X?=
 =?utf-8?B?emdNVHVXNUZNMkE5Y044aWFHWThNMEZZdXZDSG1TVjBQTm5UbEZKWDRSZ3JU?=
 =?utf-8?B?Wm5aRzNhUlhMYUxBSi9XZEd0bG4wcldWYUZueXBGQTg5T1dvemNsWHc0emc3?=
 =?utf-8?B?UlV1T0xHenN2K3RRNy9VTUMvbzh2SDI4dytoWEI5NlBhbEpFbE14TDF2Z3N2?=
 =?utf-8?Q?3esk=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 16:34:43.1580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e9a283-5be4-49bd-c4bc-08de4ed3d3d8
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6297
X-Authority-Analysis: v=2.4 cv=ePkeTXp1 c=1 sm=1 tr=0 ts=695fdca6 cx=c_pps
 a=DFPAdTC33zSWEXKFYuCncA==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=TP8aPCUxYTYA:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=OTFuUWum6JI64Ysw4HoA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: 0T-RtY_7pcBH7AOZk1HIhDbZv_o6IPS_
X-Proofpoint-ORIG-GUID: 0T-RtY_7pcBH7AOZk1HIhDbZv_o6IPS_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDEyMSBTYWx0ZWRfX3B+0mAZWj93f
 RxLga1wSrAurKa78G6xWjtzGaQ9hoKNQk+mPCsXloWLHg1G3KLjFcGlDzL8SLI07NHAJvEuKMiK
 zELtmuqIF6mD1VHLAlDEk+RJPIkTgS8RKZnUtbQLZ+WjnHDf+ocFZQeKkHrfYirjWRrbb/tq4Lb
 FRnc8V8JN0tV4aZgsoALsycle7T3yHffAKrSwCzniE6wauUHC9b0kHoALyCdn6nnv7xvVT5gw5u
 /LhvU+2PrPUO8b4iuObs/kucC+ZheDYRFZVy1f/4oUNe6KAcEXKPW/IvCzARFGvgZKBiFLfZ3bO
 m440Wxja7v02vHzIQIxP1ZhrGY+xBTcQex8Tti76N8lIvgQ7QjYtCtzkR1dSrmxTcTEn8ty/rat
 Ce791qqzzC0UvlfOkxLkSjoKZfUSfGPWFi7E1Smh4aERRvicsVKkC/jEWgUbrhqMvudpSLPNH1Y
 C7fwGajjwq48jFIjF1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_03,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080121

Hi Alain

On 12/15/25 13:26, Alain Volmat wrote:
> This series add the possibility to indicate a power-domains for an spi
> instance and set the related property for all spi instances on
> stm32mp2x.
> 
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> ---
> Alain Volmat (3):
>        dt-bindings: spi: st,stm32-spi: add 'power-domains' property
>        arm64: dts: st: add power-domains in all spi of stm32mp251.dtsi
>        arm64: dts: st: add power-domains in all spi of stm32mp231.dtsi
> 
>   Documentation/devicetree/bindings/spi/st,stm32-spi.yaml | 3 +++
>   arch/arm64/boot/dts/st/stm32mp231.dtsi                  | 5 +++++
>   arch/arm64/boot/dts/st/stm32mp251.dtsi                  | 8 ++++++++
>   3 files changed, 16 insertions(+)
> ---
> base-commit: a6961e2ced5190c68acd78a7e372de07f565fcd6
> change-id: 20251214-stm32-spi-mp2x-dt-updates-048068b7f05e
> 
> Best regards,

DT patches [2][3] applied on stm32-next.

Regards
Alex

