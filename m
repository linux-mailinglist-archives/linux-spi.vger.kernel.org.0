Return-Path: <linux-spi+bounces-11780-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC73CA6D0A
	for <lists+linux-spi@lfdr.de>; Fri, 05 Dec 2025 10:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E3EA3046B89
	for <lists+linux-spi@lfdr.de>; Fri,  5 Dec 2025 09:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F03227E82;
	Fri,  5 Dec 2025 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ZvtxcN6F"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7410C30C62F;
	Fri,  5 Dec 2025 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764925542; cv=fail; b=Aa+J73/YqrrCUKFVZrDi6U7VtC0YVBXZr+/G2g0W6XWhZF4CHQ2/MZVAGm1N+83ZRE4yVeDR0xLskqlGOzTNQF0pYAwhtdkQTHgGsD9Q8xnsvrXJalNz6alhfaa4aYjhxzpS6GXEP7ApDE2MccUspaISdYJzuMbbjClNLuUxUzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764925542; c=relaxed/simple;
	bh=U4fdL//Ro5ba5O9mohI/SeiZMv74IRBK0ONiAeKLtME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=o7niV1RR2ywx3rXVeGAC3RMmXaQmJYGkfkYQYKC4b3i4L/tuiMR2ChyO78UvMmucZtbHQEOa96mO3Y29r5xbolXjmah4B06jCbDIDCJh6Pai8Itld9QJ9ExHDDi4rs3b+GtmT2PAyNi3wZvotj8eotIre2n7IrNnWT+WG+pOOmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ZvtxcN6F; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B592Gk22157980;
	Fri, 5 Dec 2025 10:05:15 +0100
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012005.outbound.protection.outlook.com [52.101.66.5])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4autdg0m1q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 10:05:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EuIne1W3Fbj/1K2weCr2TNIITtgRq9JLNQsEblX0SNQ436mEW/5nSfWkGSJlMX1lP7nDi2Phry7TiJeqeSdQQHcK9L4tDjhXEldv47Y5jgxF+HrgjBp+GQlKHPzIKVGnTUfjYymZAYakLj8AfzwwwP18YQXsePkJSVzkrNNoIJ7ZIWUkS+cEvZ6llGJo9fI3EWk78aTTFS1xm96bQZ1wa5+jtakggEP/Izfrhwj3y6CreJaMUUR1V6/pWF5FIih49CyxZgv+tYfLrCGoBRPpIDZDeiYL+yXdYnHSLs1Kol+O3sIcXY+J27xMvuQ+N4ZINx2mLpowAVUYE0uExD3v/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7xfu084263Ypn2kZRG6hJqxbJ5zT/SCoUnS/Qv6sbQ=;
 b=dTcxFYgDtejoH+UDU+MVLM8xezVFnieIALxfZbzJBWTNKZ/5SMYNoG+rji7OsoLeZ+FCMaQnHhB6h0kzaW6mkW0PHoMxGv759ITZltDTqwyjQA2jH5lC3HsF3E8qmhCurndYsF32UStAjOg72CUIUkYUBbwiE/EjPRTilYwgPEIomYb2H+XPZdx2b3De6r6HPL5ghUCLAZtd5dtxo/b2tGxNs7yF9P4zLViFTuM3IFJrABPztomfOBrIVZK41oxDf06BNwK6E+UqWhSzYSVaRZSnTqqbf0MJaQ6n6FiCAVcpVcGsMpgF6on2nW5Bc25sdJlDg8RuEVh+j9LFrK/CHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7xfu084263Ypn2kZRG6hJqxbJ5zT/SCoUnS/Qv6sbQ=;
 b=ZvtxcN6F4IX12OdD6mZ6a4g4rC4qF3aLogPWTL+qDbbcrpQlq9CgM1xfN6OYbwqHKpeuBIxOCQ0QJD6jKogJ4xUOsyUQOV8YrU4DV29e+vFA2cIZH7UuCWovWMFkJ4iF5tXtEp5XKObp1vp55K19icGjlk0Yc6vz85YUe1jWgxo5q0D0YR+dKKCUVDEAPZc51XO1vdEgkrjf32EieGDdqMojCMcBQFrnEA4udNHGNTdeyrL3cE2JKIkaUrb6XN/0mA1oQRssce7dtCo3Gx/uq0pQ68BTLz4obf27h2rdpypP3GLVpN134bblVVHR/utZSVkPSQULMBJzd0sEFCSNxQ==
Received: from AS4P192CA0047.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:658::19)
 by AS8PR10MB7328.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:614::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 5 Dec
 2025 09:05:10 +0000
Received: from AMS1EPF0000004D.eurprd04.prod.outlook.com
 (2603:10a6:20b:658:cafe::a8) by AS4P192CA0047.outlook.office365.com
 (2603:10a6:20b:658::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 09:05:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF0000004D.mail.protection.outlook.com (10.167.16.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 09:05:08 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 10:05:46 +0100
Received: from localhost (10.252.31.202) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 10:05:07 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 5 Dec 2025 10:04:53 +0100
Subject: [PATCH 3/8] spi: stm32-ospi: Remove CR_TCIE and CR_TEIE irq usage
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251205-upstream_qspi_ospi_updates-v1-3-7e6c8b9f5141@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004D:EE_|AS8PR10MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cd0d7eb-866c-4d71-b3e7-08de33dd63d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHl0WUJqck96SGJEeDUzN2RYRmhwd2JEVGsvcy9nY3BVc1JJRkExQmIrTlIz?=
 =?utf-8?B?SU5mWFBoeHAyMjBPOGRna2VLYW5UVVovd3NENFpXTjF4M0Vvbnp3VFJ5WmJG?=
 =?utf-8?B?Mkt2am1BNG5HSlRpZEJTLzIrTm14UGwyYnhpNWFueUhXbXltSFVFV3pIYXZ3?=
 =?utf-8?B?d3BLUjlyN0pTOS9PdE1udC91WmZ3aC9nYXJvYkhyMkhHazQvajNydlYxYXk2?=
 =?utf-8?B?WEhiRWRpUUNmZmNOdVlTR2Y2NWJLSEErVkhwNDk2OW5jNEhlb1VNbWhLWjVV?=
 =?utf-8?B?MENuMmdQczVaNDRtZ3g2MS9BZ1hHdHdtcXNESE5vNWdpY0VIN3dzSUhlRlpM?=
 =?utf-8?B?WlZIWGwrL0xOdG1wK3BwQkdUbVoraUs3ZnMzSWVZTFg5dzUvQTV4MWpkZDg0?=
 =?utf-8?B?Wm5KZzFXV0M2YWFPU0JJMlkyMkI2eUlZMnF1aXJCNWVsWFNJZ0pzVHVzZGJi?=
 =?utf-8?B?TGNYYTVDMlJCeFpUTEdhcE0wOS9uTk5JNmg4UVBKVmJ3ZHJoLzd6QzhBdEp3?=
 =?utf-8?B?UGNyMkhOZXA5NFdMbzR2VlhTb0Ywd0JYV0V6R2lWRWppT29GOTYzUjhLWFpJ?=
 =?utf-8?B?Rk9vVHZJTkE5cTZSQSs4QldqNVpUZ1RkWks5cEJBcnFqOC9LbW5UOUFJY20v?=
 =?utf-8?B?cStlRzVyYkN0bkh1RElWdlFicE92SjRiWk10NjkrRndPcDVWQTh5ckpGTm93?=
 =?utf-8?B?NkJmWGhraUVEQld5YkhURkM5UkZrVGR6ZDAxNUEwY1REZDVyZlY4azNGZmM2?=
 =?utf-8?B?YUZ6L29RRDdYL1VvUlJJd3pwWkJNOGJKNkdFSjhDOFpsczVLWFkrc0RwM3RZ?=
 =?utf-8?B?VVVSNkVBOW1DcXlwV2tkcFdrZ09EZFFsQ3RYYjMrdVFlTGthS1AxQzVGZ0Ru?=
 =?utf-8?B?ekVFZ3B0cyt3azVPSmx0a0llOFhSMytjMkpLSWtkVWdLNVVVNmNIWndUTEdT?=
 =?utf-8?B?S3BaNWhoTEJzM29PeU9qNHBhWWpoQ1RoMjFoK3pGa25OMnNnUE44UnI3ZlI3?=
 =?utf-8?B?MnByV1NLY1BZWFVSMy9MUCszOTdlV21udjRKQnNwRU50dmMxNTd0ZDlPMVFV?=
 =?utf-8?B?cFB0KytnWit4VzhKZ0o0TVFpTnJBTnh1TitxUTdQY2lyUWQ5RHYvK2dWVGpK?=
 =?utf-8?B?Nk5FcFFQZVdhWlhTRkZVTjJRSW5IR3B0SEtiUEkzaHV5M1lhTEJ4bjhkYlU1?=
 =?utf-8?B?d203Vmo4VGZtVk9yZjZiRDQ4aWNSY3FFZzM5VnowN04yTS9BVlpyNzlMcXBD?=
 =?utf-8?B?YzhiZjFjbDdwaE8rTlA2QmdRQjFCemNIWGFTVDdwWTJUVmJnMXlseXFYRjAr?=
 =?utf-8?B?NC9TMHlBcGIvSlBaZkMvNm9ZZkR4M3dFWUc0N0ZoNzNJRmk2VUlid3paTXZW?=
 =?utf-8?B?d0FJaVpNTTdzSzNQc0JKYmhxMklLdldrOXU3RE5yUG51THBEaDdGYWZoZXZi?=
 =?utf-8?B?VGtZR05aZ21uTXJZaXptN1Noam1VN3hvM3luREEvQ3JjTmh4dlJaa2p4dzZy?=
 =?utf-8?B?dGR5M2p6c3pyaDlGWEdrUG5ySzBFZmpLT3ZreGxIcmVQM1JKamxJenB0QzYy?=
 =?utf-8?B?QXV0MTl2MHlMdithTXE3OU53VThZc05lVExpZm92c2Fsd0ZMR09pclJtV1Rl?=
 =?utf-8?B?TGwzMy9pWDlNbHlEZWVMeWxpNmh0ZUR6VWsweHBFRlJualU2ckVGRkdQeWxQ?=
 =?utf-8?B?a2tUcGllQUc3S2VPVWdKZlBibTRLeTU5Z2VRd1lFbjJQcVNTVHZtRERzOWNu?=
 =?utf-8?B?OC9neHFPQnBHWkN3aHRlenJzUkkwWWpEMk4vQnhVTHJnd09rdU85TlV0QlNx?=
 =?utf-8?B?WThOUmYvOHhNcTFrODNFNDNwcjRlcXhkam96NDJOYmEwZlRwaE9BcmMzVkty?=
 =?utf-8?B?Ums5L2tTN0x1dXNSUmU0NHI0cTMxVlFrcnRDcXExb2NtK0tVUlJaYTVzU0JC?=
 =?utf-8?B?K0FGY21STGNHN1hxV1ltSlhiQTFuUWNPdmRubFFicy8zMnlCL0lmbndmRm1J?=
 =?utf-8?B?UC9hb2dTM2sxRW9SZnlKTUdrNU1ER3NuLzhWd0VubEFLOEZkWkxLSUhzMEJv?=
 =?utf-8?B?UEwyN081bXBSVzhsYUdwZFhUa0lzK1hlZzNtY2cybHk2djVaT05HSjBrODBG?=
 =?utf-8?Q?cKM4=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 09:05:08.8118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd0d7eb-866c-4d71-b3e7-08de33dd63d5
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7328
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDA2NCBTYWx0ZWRfX4YRYXaOoVEnd
 30rWjvuK2tGfoKbfuxzZ5K8QNRBAOQKOYm8QGlBeAEypGVgtwdQuIndtnxXigkFP8dlFJ6O1qDi
 tXNQY4oOyH/Pd/r1f2xoPdDcaJOKWeFRLwP2BBYnyA/HFk/hqmHUOE0RgnP/oT/TEdENZvai+mU
 ZHx0xhYf/iVKKoNswXivgrAK6Iz1b8KJ2vQCNy9t7l3FGexWnIhpo1htBOFLoYGYoqyvPEK1q5s
 ATzKLbXJzVig9DdTv+NCcPn6uessrWNI0CQcOD/42uF+ttR1C9FwJDrTDNuse41s2xiyaAum90I
 ltrSRPH/5emg7bL/PSuO9CA9lOAgKSJPf9vwg5JkpBAI+u7gmdodC58hZxMtTwvdKZnb9Wz2HqK
 QwQB3knt2EDHRgLxaGKPlZiHSWYjTQ==
X-Proofpoint-GUID: 9W2QPuuPdIAK5N4EUZlZsDUJqBO8yOjy
X-Proofpoint-ORIG-GUID: 9W2QPuuPdIAK5N4EUZlZsDUJqBO8yOjy
X-Authority-Analysis: v=2.4 cv=YrEChoYX c=1 sm=1 tr=0 ts=6932a04a cx=c_pps
 a=4X+iVNKrLEFvYFcl14eRNw==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Uo5EeBN78AAA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=4C2JBV8IMr3zZ6XvoZwA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_03,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050064

Replace CR_TCIE and CR_TEIE irq usage by a read_poll_timeout_atomic() in
stm32_ospi_wait_cmd(). It will reduce the time waiting for TCF or TEF flags
to optimize throughput.

                                           before     after
average time spent in stm32_omi_wait_cmd:  5685 ns    923 ns

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-ospi.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index a6f53f06200e..d8d72e2fb4bd 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -34,8 +34,6 @@
 #define CR_ABORT		BIT(1)
 #define CR_DMAEN		BIT(2)
 #define CR_FTHRES_SHIFT		8
-#define CR_TEIE			BIT(16)
-#define CR_TCIE			BIT(17)
 #define CR_SMIE			BIT(19)
 #define CR_APMS			BIT(22)
 #define CR_CSSEL		BIT(24)
@@ -106,7 +104,7 @@
 #define STM32_ABT_TIMEOUT_US		100000
 #define STM32_COMP_TIMEOUT_MS		5000
 #define STM32_BUSY_TIMEOUT_US		100000
-
+#define STM32_WAIT_CMD_TIMEOUT_US	5000
 
 #define STM32_AUTOSUSPEND_DELAY -1
 
@@ -116,7 +114,6 @@ struct stm32_ospi {
 	struct clk *clk;
 	struct reset_control *rstc;
 
-	struct completion data_completion;
 	struct completion match_completion;
 
 	struct dma_chan *dma_chtx;
@@ -240,22 +237,16 @@ static int stm32_ospi_wait_nobusy(struct stm32_ospi *ospi)
 static int stm32_ospi_wait_cmd(struct stm32_ospi *ospi)
 {
 	void __iomem *regs_base = ospi->regs_base;
-	u32 cr, sr;
+	u32 sr;
 	int err = 0;
 
-	if ((readl_relaxed(regs_base + OSPI_SR) & SR_TCF) ||
-	    ospi->fmode == CR_FMODE_APM)
+	if (ospi->fmode == CR_FMODE_APM)
 		goto out;
 
-	reinit_completion(&ospi->data_completion);
-	cr = readl_relaxed(regs_base + OSPI_CR);
-	writel_relaxed(cr | CR_TCIE | CR_TEIE, regs_base + OSPI_CR);
-
-	if (!wait_for_completion_timeout(&ospi->data_completion,
-				msecs_to_jiffies(STM32_COMP_TIMEOUT_MS)))
-		err = -ETIMEDOUT;
+	err = readl_relaxed_poll_timeout_atomic(ospi->io_base + OSPI_SR, sr,
+						(sr & (SR_TEF | SR_TCF)), 1,
+						STM32_WAIT_CMD_TIMEOUT_US);
 
-	sr = readl_relaxed(regs_base + OSPI_SR);
 	if (sr & SR_TCF)
 		/* avoid false timeout */
 		err = 0;
@@ -293,15 +284,6 @@ static irqreturn_t stm32_ospi_irq(int irq, void *dev_id)
 		cr &= ~CR_SMIE;
 		writel_relaxed(cr, regs_base + OSPI_CR);
 		complete(&ospi->match_completion);
-
-		return IRQ_HANDLED;
-	}
-
-	if (sr & (SR_TEF | SR_TCF)) {
-		/* disable irq */
-		cr &= ~CR_TCIE & ~CR_TEIE;
-		writel_relaxed(cr, regs_base + OSPI_CR);
-		complete(&ospi->data_completion);
 	}
 
 	return IRQ_HANDLED;
@@ -884,7 +866,6 @@ static int stm32_ospi_get_resources(struct platform_device *pdev)
 		dev_info(dev, "No memory-map region found\n");
 	}
 
-	init_completion(&ospi->data_completion);
 	init_completion(&ospi->match_completion);
 
 	return 0;

-- 
2.43.0


