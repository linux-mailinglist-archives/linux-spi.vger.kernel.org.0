Return-Path: <linux-spi+bounces-11787-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C4BCA6FAE
	for <lists+linux-spi@lfdr.de>; Fri, 05 Dec 2025 10:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3CA1317EB62
	for <lists+linux-spi@lfdr.de>; Fri,  5 Dec 2025 09:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3648E31329B;
	Fri,  5 Dec 2025 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NoqHyBKg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678FC3195EC;
	Fri,  5 Dec 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764927905; cv=fail; b=I1rN/2ZJ1ynb0UXiS8L2xYvHRY8swOUZlOQJiMIYz5/2KoxbbGgn2dkos9xwZZF7W4dX0fPpFz4akGd7+URrrr4+6/CmBr7ITOfZx0gzNgG5vR3rPo92cl33Sh8FgY/Ljyeq2YR63ve6nD8JwwN07xIWddrs3ng8utWcgtqv+c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764927905; c=relaxed/simple;
	bh=KB8SeaJv9KC2JD4D/BJJoOV3rEmdcNd/02A/f2SpRn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=W978yQ/yRp6ptYsbHUh+wWWuvUJWp3MxWCUrBkbK7kWI/s5ppEYnEQ/7L1q1HmQx8kj7W84MzRjKb4ItCUnwxlwMe7ndNBQW/ScXeIXo5Us/Et8FAHepw5xTGAsVnZ2mq/UaRjrkQS6JQY7B1FDoA0Y/aszkXLpuvuSEdZgID7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NoqHyBKg; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B594hCh2478371;
	Fri, 5 Dec 2025 10:05:15 +0100
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012041.outbound.protection.outlook.com [52.101.66.41])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4au7s54ftb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 10:05:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=faY/XCSXWCthJf+jw2DImDkkg5aWw1IWG8kZQofZawVKiREJ5wBOd46XL5EVduIi4eS5rdJgZeF2eJGZt6Trm97yirZg0BFn+4O5rA0/epVSEUL6gaCROMmRoYVK3bHIbDb2KI0ZHd9nNTYmxEWe2sMGFDrlQ/fqshUGcbpi99Kl/T2Nh11Xdkg2YP6lf2IOP11YZ62K1Hdo9O4jfVuQCpLqLBoTV/aum3fLKWPD6AAZbVaMDLpVqqwoHwQLPrcX25TiQ/MMW5LrYE/qQxWwOVAp2akZI9bA0d16wGOvVGfYWe9SXkuVft18J/Q6RHm0n5BbZ4ZLCyZ2jUDRy1mdFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/h+ttQocpyxLUgaIlzx3iwhuSNneCP2ewSMetvTTdo=;
 b=Z9o18qf+YVBuniLlmgbuPJNuyF5GWs8uSQp2WnLuAEGMWiTyhRSatl+Ft5OQSramJ9tviCx2KKJf8a9MpbL/gc9jaCuGzDiqgZETjLkiLe9ByR2n7xS6M0CdoLp4rISgWQyx3l1UYUNkYGcNo6OKLf+L+lkm1FI89f88x0OtBE4kAwwBpVP118WSUi4hrrnz8ynAeq29jSsNkiXtl20QvOwsgl17J70PsBQvbU/PVT4R2V6NXCe9vpxYgrmGeuq2UxlVZlBIJkeXmOxnUKjg4j45O28A+3wqSXNwqMWArDlQA5Z4kcr3DZJMNVDRcZ/ILQ3VYyGhFnaWH51OlyLRTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/h+ttQocpyxLUgaIlzx3iwhuSNneCP2ewSMetvTTdo=;
 b=NoqHyBKgoK8s8sFxgVkGw0dnyULSlI1JZUT/lPeLXtnYutDFHIrORySpQgdz9VO+0f76MkDzaDjEvmKZMBODVB5jxVagoLCMmvmU1dmhFV4vcji0pxD4tH61Ql7gfz2OmX0CfGiGI1nHb2ejuhPVHcx7z7d2sHTq7tcWuSGgIy7x/7TBAS41NlpLFFC/s1aLGXMnkmPR9x7piLYlLB0gNAmcKm2OQGrSWur9QrPuJQiYzPaen/XHyYsnN+3y8FBQmKofJz3XWO5tZ+K3F12fPOI3PTSq2g7iLRjIQuZS56xBg/En1QaVAtbOKj1Z3CQVofDqus7HGjPgMau49sewPw==
Received: from AS4P192CA0040.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:658::16)
 by GV2PR10MB9631.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:303::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 5 Dec
 2025 09:05:12 +0000
Received: from AMS1EPF0000004D.eurprd04.prod.outlook.com
 (2603:10a6:20b:658:cafe::ec) by AS4P192CA0040.outlook.office365.com
 (2603:10a6:20b:658::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 09:05:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF0000004D.mail.protection.outlook.com (10.167.16.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 09:05:12 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 10:05:49 +0100
Received: from localhost (10.252.31.202) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 10:05:11 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 5 Dec 2025 10:04:57 +0100
Subject: [PATCH 7/8] spi: stm32-qspi: Remove CR_TCIE and CR_TEIE irq usage
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251205-upstream_qspi_ospi_updates-v1-7-7e6c8b9f5141@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004D:EE_|GV2PR10MB9631:EE_
X-MS-Office365-Filtering-Correlation-Id: 306acd4c-9685-4089-bc9e-08de33dd65c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmNnbXhDQUd5cnIrZVlwc04xc3cxOG1sbEYydjFzVUZhZTlaUnYyTFA1ZWh5?=
 =?utf-8?B?Q3VGVnpTUlltcS94UzdKL1VEOXNBRndWWXM0OG9BeVBkREh0akdOZm1jQ3ZL?=
 =?utf-8?B?eXB6ZTVJb0FESU9hRUE4YW5vb1BQNEoyMTNtNmRUT2xMYjFINUVPN0EyYUho?=
 =?utf-8?B?SGN4UVpONWlmYVYzckZjQnhJWi8rWExLVE05ZTZIbFpUMnN1NFNTSExtUmE0?=
 =?utf-8?B?WWxGWFR5U1l0RjVQYXFoaUt3RXRlZ1ZMMW1QT1p3RmY0SWhuaDhmSmNwQmhv?=
 =?utf-8?B?TEJrWjRrMFlQWVUxUVhnNEJiTDdJSjlnd2NRWFhUY1l5Vm9OUk1abTBpN093?=
 =?utf-8?B?S3V4Z3V6MEUwbDlKSmg4dzkwdFdhaW1xR3VCMVBUUDhBTUhXTk9VdWhJSXFy?=
 =?utf-8?B?eVNWOUc2V2lwKzNBaHc5amR2UDRnYWNuSzRkRzZadlg0RTU4RkFaRURVYnRi?=
 =?utf-8?B?eWhyc0d4RkVhWERGVDZKYzJ0aUo2cEVYSWRIMElrbWY1VXpqVG5kUnQ5WU0z?=
 =?utf-8?B?RFZVb1VqWTBjUkZ5bUN3SHBobFFjZjJSd1NUNFM2QkpMR3ZOaDliTmVuZlQ3?=
 =?utf-8?B?NDNNR0dxTVM5UCtyUndKTDBMYXBieG1jY1RWOHZiZGZ1a2lxWXRrenNBRzY2?=
 =?utf-8?B?bm9ib2JmVjdMcnBTVnlPbHl4RE9TNzFQQm4vRXZsQmdQalNTK1ZObFJiaEVp?=
 =?utf-8?B?aWM1TXI4U0QwQUtJUzZlNTA3SHFsN3ZpSmk5L2Jmam1HK2xydnNIaWNqU2U3?=
 =?utf-8?B?U2IybkpKdG1FMlc4amZwdGhKQVYwbWFxLzdyRVBYd1VnR3N3VjRKL0V0a1po?=
 =?utf-8?B?OUpDYVNiUUliaEI0bXpFZTN0RzBKMGxOU2ZhSHRtcjhjZVVIcDhyRDk4b0dP?=
 =?utf-8?B?TndTd2xONFNzMnQxUEIwUUNmV3ovOFBXcmJOaWdKRkdVSUlhenk1ZktkUHo4?=
 =?utf-8?B?eWtOdE00c0dSQ0FDNmtBWTJ5am1kNEpWNVJ5SzRCTDNoR1JiM3BkT3VIMjBq?=
 =?utf-8?B?YVV3R2RxcEo5U0VFTzFnNWUybHJxQTltdUZYUlFpcURxMktkOXo2QlZCY0Vs?=
 =?utf-8?B?cFhoVVBWK2c0b3ZFNUcvQnNFTVhPSlFvZUI1TitHc2lMc3NZekJWNFRxN1Fs?=
 =?utf-8?B?bmFyUU5RU1pBSUw2L1JhRmhGVUxXQjZYbFJvZ2hWVXVpeWlONUNJaTA2Qno5?=
 =?utf-8?B?eGNlOVIwSXJ2aytkUTVUSEZBU1hxck81T3BnZVhTbnRncURXSHhFaENmSSs2?=
 =?utf-8?B?QjJ5QlJ1cEg1dGdaNVBid0VRZUVjUkxMd2N0WEwrR2l4RmhKWEYvMnZlek42?=
 =?utf-8?B?S2Q4a0Z2cXcvT1JXN05tZW5iZW03KytpSCtLaVEvbExHaXIzd1hHbFV6OFNM?=
 =?utf-8?B?NzBDTFhUU3BOdUFZaE1qSW9rTGt6MGJrUEtDODVoSnkyS3NXM214d1RjRHdo?=
 =?utf-8?B?d0NSRWtySXJKUVZQMmtPelk5RU5BREZaUGpnZThEY2QxOG0xVDZTZzgzS2l3?=
 =?utf-8?B?RWlCSzYwZG9LTGdOcEFPVmJ0WEpsOEVXNjY5aUZIWEIzVkcwVTBtejk1RjJh?=
 =?utf-8?B?c1hYNzlFRkFaQ056eXdENU1mR3pSaVJPUXgvb1IrdnEzMDlFVjFBUWs1OENX?=
 =?utf-8?B?NGxVU053YkFjYW1XOWVyOTRXVGFVcGpGV3lPU2VHaldicXFFZzUzV09aMlNn?=
 =?utf-8?B?KzFCajFHRmo2NjN0Y1ptbjZ3K05mS0ZvbGVZTWExZUFFMmNqUk81UncwRSt1?=
 =?utf-8?B?N2hJMGxpOXpwTkdJQkV1OUZPRk8vVFpJYTJxeXhSK1gwQThNMWprUERRTUJx?=
 =?utf-8?B?cVVwaFJYdkVaWTltM1dTa1JHd3JkVXduellGTHRrTFdwVGVVVmpUb0ZzWnlh?=
 =?utf-8?B?SVNTRk8zVnVYbVZaTzk3NFhkei8rTGNIRkNyLzdYYkZ1T0pGYlR1RnA0M3dq?=
 =?utf-8?B?T0hTa1FiSFhKQXE2TTU1S3hndnJsTGhCWmZUZlJYMkpaSUhzd2JSRHIvZjR3?=
 =?utf-8?B?eDhENTBkWmt6VW5SYkdFYUFrSkdxYkNhMmVBREFUK1ZhYXI3cWJwbnJsYkEz?=
 =?utf-8?B?VWFUcjBPVDRScWd4RXJ4QnhUcGR0VmQ4SUpNQmhtS2xIS2lFZHpEZzhFSWha?=
 =?utf-8?Q?735U=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 09:05:12.0275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 306acd4c-9685-4089-bc9e-08de33dd65c0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9631
X-Proofpoint-GUID: fk3KXrWnx98vXFvBzpDjXAV7v2YodzPs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDA2NCBTYWx0ZWRfXzPUuo5P9D5Lk
 Q6Nco5CKDVD2XwvE6CXar4Qm3ioCycBBqtjO+goPLt1HvN3gQ3LutZBOLcuXEmwgwREbEr12evR
 OeZA/dUEza3k1SeBJzuF+kH0RgJPvpv1sjj0sP525Rgw1v7iEhYpJ3TNok96W+GaQl2SiuNPn0I
 gFE8daCp5QA1DfqdujF9tZenB+31CeelrpfuNHItXeCy8c39nMozE6MZ1BWfVVT9g38tpCJRTQ5
 KJPUaZAs7afgulmKCC283FZkxkPrqN5dWrjEZXFZf1Lyl0i+6aMFXKlCsYMQUCy7mtbqhErDS7h
 7WiEuEHIb/P49NYDKSRVR0Mpz41Fbg+GOkZsVaUXyjuwrtc/jNZG3oOT768dnVi0K6WB9czts7e
 0X6TzxgBQ3blN52iRrd1o7P0zuwhXg==
X-Proofpoint-ORIG-GUID: fk3KXrWnx98vXFvBzpDjXAV7v2YodzPs
X-Authority-Analysis: v=2.4 cv=C8zkCAP+ c=1 sm=1 tr=0 ts=6932a04a cx=c_pps
 a=GxenEFv9DmgebrKzBBA+LA==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Uo5EeBN78AAA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=RFtgH8DZu3AqK6r0WhsA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_03,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050064

Replace CR_TCIE and CR_TEIE irq usage by a read_poll_timeout_atomic() in
stm32_qspi_wait_cmd(). It will reduce the time waiting for TCF or TEF flags
to optimize throughput.
						before		after
average time spent in stm32_qspi_wait_cmd:	2615 ns		712 ns

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-qspi.c | 45 +++++++++++++-------------------------------
 1 file changed, 13 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index c7f2b435d5ee..d6f6f9d4e5be 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -31,8 +31,6 @@
 #define CR_DFM			BIT(6)
 #define CR_FSEL			BIT(7)
 #define CR_FTHRES_SHIFT		8
-#define CR_TEIE			BIT(16)
-#define CR_TCIE			BIT(17)
 #define CR_FTIE			BIT(18)
 #define CR_SMIE			BIT(19)
 #define CR_TOIE			BIT(20)
@@ -86,11 +84,12 @@
 #define STM32_QSPI_MAX_MMAP_SZ	SZ_256M
 #define STM32_QSPI_MAX_NORCHIP	2
 
-#define STM32_FIFO_TIMEOUT_US 30000
-#define STM32_BUSY_TIMEOUT_US 100000
-#define STM32_ABT_TIMEOUT_US 100000
-#define STM32_COMP_TIMEOUT_MS 1000
-#define STM32_AUTOSUSPEND_DELAY -1
+#define STM32_FIFO_TIMEOUT_US		30000
+#define STM32_BUSY_TIMEOUT_US		100000
+#define STM32_ABT_TIMEOUT_US		100000
+#define STM32_WAIT_CMD_TIMEOUT_US	5000
+#define STM32_COMP_TIMEOUT_MS		1000
+#define STM32_AUTOSUSPEND_DELAY		-1
 
 struct stm32_qspi_flash {
 	u32 cs;
@@ -107,7 +106,6 @@ struct stm32_qspi {
 	struct clk *clk;
 	u32 clk_rate;
 	struct stm32_qspi_flash flash[STM32_QSPI_MAX_NORCHIP];
-	struct completion data_completion;
 	struct completion match_completion;
 	u32 fmode;
 
@@ -139,15 +137,6 @@ static irqreturn_t stm32_qspi_irq(int irq, void *dev_id)
 		cr &= ~CR_SMIE;
 		writel_relaxed(cr, qspi->io_base + QSPI_CR);
 		complete(&qspi->match_completion);
-
-		return IRQ_HANDLED;
-	}
-
-	if (sr & (SR_TEF | SR_TCF)) {
-		/* disable irq */
-		cr &= ~CR_TCIE & ~CR_TEIE;
-		writel_relaxed(cr, qspi->io_base + QSPI_CR);
-		complete(&qspi->data_completion);
 	}
 
 	return IRQ_HANDLED;
@@ -330,25 +319,18 @@ static int stm32_qspi_wait_nobusy(struct stm32_qspi *qspi)
 
 static int stm32_qspi_wait_cmd(struct stm32_qspi *qspi)
 {
-	u32 cr, sr;
+	u32 sr;
 	int err = 0;
 
-	if ((readl_relaxed(qspi->io_base + QSPI_SR) & SR_TCF) ||
-	    qspi->fmode == CCR_FMODE_APM)
+	if (qspi->fmode == CCR_FMODE_APM)
 		goto out;
 
-	reinit_completion(&qspi->data_completion);
-	cr = readl_relaxed(qspi->io_base + QSPI_CR);
-	writel_relaxed(cr | CR_TCIE | CR_TEIE, qspi->io_base + QSPI_CR);
+	err = readl_relaxed_poll_timeout_atomic(qspi->io_base + QSPI_SR, sr,
+						(sr & (SR_TEF | SR_TCF)), 1,
+						STM32_WAIT_CMD_TIMEOUT_US);
 
-	if (!wait_for_completion_timeout(&qspi->data_completion,
-				msecs_to_jiffies(STM32_COMP_TIMEOUT_MS))) {
-		err = -ETIMEDOUT;
-	} else {
-		sr = readl_relaxed(qspi->io_base + QSPI_SR);
-		if (sr & SR_TEF)
-			err = -EIO;
-	}
+	if (sr & SR_TEF)
+		err = -EIO;
 
 out:
 	/* clear flags */
@@ -835,7 +817,6 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	init_completion(&qspi->data_completion);
 	init_completion(&qspi->match_completion);
 
 	qspi->clk = devm_clk_get(dev, NULL);

-- 
2.43.0


