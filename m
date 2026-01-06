Return-Path: <linux-spi+bounces-12187-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4324CF8424
	for <lists+linux-spi@lfdr.de>; Tue, 06 Jan 2026 13:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 989363047125
	for <lists+linux-spi@lfdr.de>; Tue,  6 Jan 2026 12:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8227920102B;
	Tue,  6 Jan 2026 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="hgIbNMvN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4B923EA86;
	Tue,  6 Jan 2026 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767701709; cv=fail; b=SHwZ1TNovR8G5pl13n0W4UDN0yZWKC1vNf/88Lv7RwWIpwb4iARJ+pvh92wxBaGNOa40Bd6XXdEvjzqWPREx72iIWeP9avBAIgIvR+jBwGtECkqDZ3OJHRfrRsmWKwxfXeS4EtmA3na1juk/r0zlLvG6kkkgUrNYyO0d0lFchJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767701709; c=relaxed/simple;
	bh=4u65NyMxx03GU6TRkeqT0ylROxDZQH2CfTdrkserBSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NX1SsqnNBeAYIiCzzcvIOyfXXeYu4u3nC6vumiv9AQtc7wgJp0tqnk143D6b0sJLuUZbHonOtrK9ZShYQ+7TM+UXrtC/v+Trmb3IpRbTCYxTBf+gNZ0zev4SstjF/8pSADz15hU20AXeYqKQgMTuQWpZQ0Pmpys7A9Yn3A4LlV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=hgIbNMvN; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606C7hjr1375371;
	Tue, 6 Jan 2026 13:14:55 +0100
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012048.outbound.protection.outlook.com [52.101.66.48])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4besdkse71-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 13:14:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/94DOs+AKzintzMA9zdKftkkhIi9tg36pPtwzJ1fnAv3S98bWYpUAxwm1h4eb2dmUTQersrkg0aZ3iDQSo/u8+s9cBX+6igFqRgxQa49Wh5GGguCJdTEmywAWA10Jw2BekYCde+KXJs0jmi02cYgNjzmaG3PU/riObr0xNDiaEV2hX4jw9r9/kXFY8CuN9P6JlzPdnVepI/T4BO1d83rMrjo6WsBlzakEP7mqApGZnOxMm5KraLJymU5Y+3ocHq/+Pu8e5SdRdin97tu+iRjMns+NOeMxDS3DCcaO6XX7dFzh1ZKu4SBmgYJnMqLyMK4WJsCteq1psKS0UmXz6E5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NnnKNwnyP2x439F1aNH1wfglgdNvOkBMAUaEC6sb9s=;
 b=dSJKNbX7chfbGxS2gSNsH9PAoToRT2Zry5T0WwfRYphky/NxsrvBtNGS0i709PYjT/VbSxKlDQ2+un2SI/LOrtglM4Aay7VkSUqyZKSZrzRCP50hSl8KVCKDAxd6HzSoHoSuYzhMckBRD5CnPTjOH0EoUW4RBoC3J87NRLA59lucoZmgIKeaagKBfnilT/w9NALilToQVjQil6kC5oqy6DjcIZDBLLH9usiaCYhtXvd16I78dd43+X8UPTZOoHIymaWArEDq7hfUeIJ0KFKodbLN1XPF4QCEdtGuewwNTV7n5ImeWuHVrcygSNc6JUHyOUdyIWpzbF/IsMBlvxXbDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NnnKNwnyP2x439F1aNH1wfglgdNvOkBMAUaEC6sb9s=;
 b=hgIbNMvNiHgMkZJ/Q+TzSN1X7Hdnmk+2+1woOSb2miCmBDHXE/ab1LT9KH17pE+fs95qEtbO+Q409BhZAu8a7XYuXpoCXBsyWZOvcr9ii3Ye4R/iAyPKoAR/BjRcP2FslrYk4zBHWpivnYa4u/1wUiYp2h2XAhRNycssyshl7xDO5D3G3KC+d9pd6zP5bES5vdMFpgdx6x8vS2CXXYJJ0nJu5fulT/yGneMz1OfAIlhRjyVQoVQAq/vRnsORUAgHvTo5rdXius+IPvMkjeu+k/RY2dHiRhoAevwUZ3WX2FkRvi0k6X7pkplPTQ53acekS0PfbihzrnpZ4eS7gadSwA==
Received: from AM0P190CA0015.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::25)
 by VI1PR10MB3629.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Tue, 6 Jan
 2026 12:14:52 +0000
Received: from AMS1EPF0000004D.eurprd04.prod.outlook.com
 (2603:10a6:208:190:cafe::57) by AM0P190CA0015.outlook.office365.com
 (2603:10a6:208:190::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 12:14:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF0000004D.mail.protection.outlook.com (10.167.16.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 12:14:50 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 6 Jan
 2026 13:16:04 +0100
Received: from localhost (10.130.74.193) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 13:14:50 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
Date: Tue, 6 Jan 2026 13:14:19 +0100
Subject: [PATCH 3/4] drivers: spi: stm32-qspi: avoid __maybe_unused and use
 pm_ptr
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260106-spi_st_maybe_unused_removal-v1-3-8f5ca7136e96@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004D:EE_|VI1PR10MB3629:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd16e8a-f472-46ee-2bfe-08de4d1d314f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVFoSm83K1U1OEo5ZTk4YUNvR21GMjB4Q05DN0VkeC9wMnhyVUdCbHFNa0Va?=
 =?utf-8?B?ZUZ5ckxZWmRIK2pFbU5KZ2lCM2Z3SzZuWTdyRGd0RWl5aWpQdXpGdXhPeE5z?=
 =?utf-8?B?RmcxZlg4QWl6aVIwc0FDTHVzY24rM1pXa1hjZ21UNnpMcXF3YTJnditZbndG?=
 =?utf-8?B?NktpUHNPa2J1bUd5M0V6a2Q1RG9JdjNSUVp0WlRuMnR2ODNvMFIrcXRjSk1V?=
 =?utf-8?B?NU9ISG8yb3hZZFpmNUF3SDZhR0k4UXIvS01hd09QdC9TMmduQ21JaHNDVlRS?=
 =?utf-8?B?cVEya1MrZXl4YTVCamZpZnZkZE14VGprOEF3TkxtRHgwb2hoaENsNGNvSDRF?=
 =?utf-8?B?YUo1b2tEWmRVN3g5YUVxeE9xTkZGODhlT0FoSC9ld2dDUEV5VHJ1MDNBa0dl?=
 =?utf-8?B?aitxUmU0STlsUXBibmtnSFE3RHZjeDNXTWU1U0xIL2JwakNFSDhnWWY3aXdy?=
 =?utf-8?B?WlkyQit5K1ZSblFhdFRwQjBJN082WWt6RCtyUXJiSXJ0c0V2ZElKNVA1d1Qw?=
 =?utf-8?B?SDhLSUh6K1dMSUljN2dDMFFBc0JXdG1lYXNmdVdrSTFxVzRFbmlNaGJ4RExI?=
 =?utf-8?B?LzFSbUdEdzhXUllZN2V6V0dvT2lKYittRnQ2aWdYSVRRMFAxaW9VdjhGNkk3?=
 =?utf-8?B?V1RsQTE3aTNhRGtlY1U2ODlpNnpsVGsvY2xCMitCWkZNaXBqRnhCK2hpN1ZP?=
 =?utf-8?B?K01XeE5BVlI2MU9XdG0xOHJsUTBWbngrblFtMUtpMC9UMW1Xb1FWYnNCbkJL?=
 =?utf-8?B?eUdkQW5FZFFkaGE5SUVLQVhMQ3NLR1ZyMHJvVEQyU0lsYWNLRklYcjFRRzhN?=
 =?utf-8?B?aTUzdTZNR0ZFSWZnOVBhUTYxQWc0TVYyYzJqaDlQSi9NQzFtWk1oeGRKY3E0?=
 =?utf-8?B?UlFCUjlNRmlndlIwMGNqM215VHcvdDFvY0dzRENWZzVtWFo4QTFydnVWVjhN?=
 =?utf-8?B?UkJ4Y1RFZFpyK01ST21Mb3FSMWxMd0tyV0lZWkVyUGExY0NiTkVsZlFpMW5a?=
 =?utf-8?B?eE1FdnJPTVVNMW00dmVobCtBZlZ4S3NVcGoyK1Y2ZnpRaDg0U2R5RmEzWDEr?=
 =?utf-8?B?RXpYVitDV1A4dUtZek1JQnJsVE5xU3JSaGpFa0ovZnF6S01vYmpVWmltdDFp?=
 =?utf-8?B?dXQyRmNZUU8zY1F2cUJ2V1cwakxBTEtwbmNYWUJOajRkZXBjRUxyQVdlRW9K?=
 =?utf-8?B?aklJVTJ5Q3VHNHloU0Z1YzZYMmtJbGwraUhZK3FWc1dCRVpIbWVFTjYwQ1VU?=
 =?utf-8?B?TFJRMGFNTWdPdXlHQ3hhSHJWWGtWbUlwV25QV1pPU2t6YzhKejlkWkV4TTN5?=
 =?utf-8?B?eVlXelZmNXZjclIwY0luUjVtUUMyZzVVNkMrWk5TNC9GZG11bnltOEZIWEpI?=
 =?utf-8?B?M1dCbVlscDcyd3ArazVxU3pMTU9vMXVGYVJhYyt5THBRT2xhRFdYUnd3ZWF0?=
 =?utf-8?B?d2RTUEQ5WGlTSER4OE81eW1LVTBja1ZqS1pqQzRSbXlKWTYvbEFUOUE5Q2Qv?=
 =?utf-8?B?cTdTVUNnK295MEV3RUtoN3crWnd0SThzMlZHUVJGNGpZNlgwcEpDVG9PN2Zx?=
 =?utf-8?B?UzFXWVBFTXlZY0FqcW1GUlVuZFFHS3NoaUNHZXkxSm9IU0VMSzA1SHZCeDZ4?=
 =?utf-8?B?NXZuN3g1UERuMnhQUktpU29GTDRRNExtc2dXMU9aUC90TGp1WXZyQlFjdTBE?=
 =?utf-8?B?NHNUUVhvc2dwZy9mMTQ3anRMd3MvVFF4VmNVcjVrTDdpTWhtb2luVkhqcUVY?=
 =?utf-8?B?Q3hqc2NTVVNGSlVyNE5TQ1NkVVlyaGhHR1VTak5aUFZxUTMyTS9xcXN5SHpJ?=
 =?utf-8?B?N21kV24rQk9iRkhnaGlrY2t2V2hTNDRGZnV0YTNOQko0R3BXWWNWaUpXRXBS?=
 =?utf-8?B?TjRCUGRWdHZ0VHNqS2xqRkFoM21rTVRlOW5BU2VKSU9XK0R6M2IzVGFHRmFv?=
 =?utf-8?B?bVJ2SW1nd1dNMWs5cWhMcytwejkwWnpIb1JvR2JyeW1pNDFwNzdJODFSV1FJ?=
 =?utf-8?B?NStrUndudXZ1UFpLeldIZVJNR0hBK0pITTlsTmJndmRwVTRDajNHbFFLbSs4?=
 =?utf-8?B?UHMzWlRUZXBISkxOT1hLd0VBSzFPd0FaWGVyRG44N2xjc25WcFVEblgyZ1V4?=
 =?utf-8?Q?V/QM=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 12:14:50.8965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd16e8a-f472-46ee-2bfe-08de4d1d314f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3629
X-Proofpoint-GUID: -Xe2e2Rt2WBaMZ-I6cUuUrA7_D9Wv6Ju
X-Authority-Analysis: v=2.4 cv=Vskuwu2n c=1 sm=1 tr=0 ts=695cfcbf cx=c_pps
 a=ylwhU6uZkk4GPunyVPrrDw==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wL9PcE0S0AMA:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=7wyQpQe0EkofVtEA0L4A:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: -Xe2e2Rt2WBaMZ-I6cUuUrA7_D9Wv6Ju
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEwNiBTYWx0ZWRfX0RtVIKQ2V86v
 cPIh4ZVtk8J+YfVUGvLyZVDkQ269n82LOTw6q6Q9rRIRwJSMzcXU0yBWcpUK9nbYjAN7ymFL46v
 mxK2xeTgcDbfZfFuKzt6MkrT5A5E/Suu/VKfSByGPUrZwbNxcEe3gN9fNI3F0nVLCwd/t7Rdb+e
 W/5xPsutK7vmbvpK31nzSdu+th5syUiZ2PvFNkHgg1d44JhZhCPYoAu4DNcQ+Izve+yPeji1Ans
 ec3MIg6abeSSNiO+lhF4haPgJSSL85cFDY9Hhm8xa7+thjbCoxttXifW2ebwTLTssYjPvZU+KCv
 /8M6qsUyjHtT7Qtnvxwu9OeWQi71tKjAkY4HeltCFWPMWGBNlhquqay2mypWjre++SeEqAhXwvz
 AjymrbXWxn7igLXF9JIkK5d1wUOT+GJNWrR+8cODJGH6ZCA+I5JBB2M2k55FhT/2yMHbAlvt12c
 ttT/s1xl5FF/nGryLLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060106

Switch to usage of pm_ptr / SYSTEM_SLEEP_PM_OPS / RUNTIME_PM_OPS
in order to avoid having to mark the pm related functions as
__maybe_unused.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/spi/spi-stm32-qspi.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index d1df66875809..5354faef936a 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -910,7 +910,7 @@ static void stm32_qspi_remove(struct platform_device *pdev)
 	clk_disable_unprepare(qspi->clk);
 }
 
-static int __maybe_unused stm32_qspi_runtime_suspend(struct device *dev)
+static int stm32_qspi_runtime_suspend(struct device *dev)
 {
 	struct stm32_qspi *qspi = dev_get_drvdata(dev);
 
@@ -919,21 +919,21 @@ static int __maybe_unused stm32_qspi_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused stm32_qspi_runtime_resume(struct device *dev)
+static int stm32_qspi_runtime_resume(struct device *dev)
 {
 	struct stm32_qspi *qspi = dev_get_drvdata(dev);
 
 	return clk_prepare_enable(qspi->clk);
 }
 
-static int __maybe_unused stm32_qspi_suspend(struct device *dev)
+static int stm32_qspi_suspend(struct device *dev)
 {
 	pinctrl_pm_select_sleep_state(dev);
 
 	return pm_runtime_force_suspend(dev);
 }
 
-static int __maybe_unused stm32_qspi_resume(struct device *dev)
+static int stm32_qspi_resume(struct device *dev)
 {
 	struct stm32_qspi *qspi = dev_get_drvdata(dev);
 	int ret;
@@ -957,9 +957,8 @@ static int __maybe_unused stm32_qspi_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops stm32_qspi_pm_ops = {
-	SET_RUNTIME_PM_OPS(stm32_qspi_runtime_suspend,
-			   stm32_qspi_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(stm32_qspi_suspend, stm32_qspi_resume)
+	RUNTIME_PM_OPS(stm32_qspi_runtime_suspend, stm32_qspi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(stm32_qspi_suspend, stm32_qspi_resume)
 };
 
 static const struct of_device_id stm32_qspi_match[] = {
@@ -974,7 +973,7 @@ static struct platform_driver stm32_qspi_driver = {
 	.driver	= {
 		.name = "stm32-qspi",
 		.of_match_table = stm32_qspi_match,
-		.pm = &stm32_qspi_pm_ops,
+		.pm = pm_ptr(&stm32_qspi_pm_ops),
 	},
 };
 module_platform_driver(stm32_qspi_driver);

-- 
2.34.1


