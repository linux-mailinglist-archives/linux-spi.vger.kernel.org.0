Return-Path: <linux-spi+bounces-12184-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D20CF840F
	for <lists+linux-spi@lfdr.de>; Tue, 06 Jan 2026 13:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA264300EE70
	for <lists+linux-spi@lfdr.de>; Tue,  6 Jan 2026 12:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344CB32ABC7;
	Tue,  6 Jan 2026 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="cK1W7OC/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2E5322C88;
	Tue,  6 Jan 2026 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767701704; cv=fail; b=cvWobdPZY/15Zq+NdOXN81+gZqj2YbBqKBRhPVTe3WL4T+77q7ham/uzBQLw3KeM6gkoItrdsBnlJuZ2ldv5ewc0NqQV5hJPwjew1VzEDgBccEHKR259DHXDNtfbYl2hHDD6wMDD+yCCPSpSIfd/XZweq1jSU3T8IGuyNLp9Rno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767701704; c=relaxed/simple;
	bh=t/EbAE/UW6tPRRQyHgivyZB7R1loHOMWlSvKlkVF1CU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=O+umNoHHGRRGTrAHC3iy8DQlCro+nTROMDZuSXpSjqvbneEo6+diA154q+TqqB1U+lxp050eX2CCqbFkFQDW/u5eRzZfkKfTzYXmcA9K2siClTXU6XpBWLwugf3ErPnk9KotnLmdW+yK2lJqJc7dd8bU/95YlwM56ofYhuXBgEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=cK1W7OC/; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606BufmH972739;
	Tue, 6 Jan 2026 13:14:52 +0100
Received: from pa4pr04cu001.outbound.protection.outlook.com (mail-francecentralazon11013054.outbound.protection.outlook.com [40.107.162.54])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4bes49h18g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 13:14:52 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMaZdemkjHUvJdo+FJODTGaifjjN94tJlg1Q3EmJ9HBtNUJIAXcBaEJEgh4FPKf+oMNe+du6l6QraRyPBAhJDe3tiLXDm0e/orVONjS389b2uJUZZ1xh3UfWz62FQR9LONmLmIpeRI4Nt3sMkPUX2mVFH5mCAjBU2IKQPGUvovUk1YYEieCinFICki6fT/oKdXKkHfpa7j83GT6V1zwgYPBxPoUex6gqWDNRdR4EpxNa4n2tdghcf90CgoGWyjPFvvv4ZLtdGeQeZVQ59NEYItQkzDFfNTD6ZkOZChLjMAqXXYIjxkc2LfEjbxPt+NCUtytM+sTLNXiZQ6vm8QUPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TByLxIaCKVWvK1xAs/wwRizS67S68bJ2alZxnMmmUk=;
 b=nGJ6+q5OcBsjMtekhkgv3YnhCEjNnKWqozhqgfrHI80qq4qlp07Zkgddl3A6KcaDPO6yto0REXQwA6IOh5Sst3MS1IOTvnnS+Cr2k1ZfBgS+cRvMnQcEplAzlg12hVV8whtA8rBNjexdSwXq4yPXOpINwhu/hHsaFRCnmFaWkU+mb9gtSXgaKzNJiO6y0PtszTeZ3vvOtDrKj6nFRR82iCQLKTjkP1T/ZR4XyFBzXWhjp9clfPTxoGIXOKfFtS4Ajf1LODQ/2E33IfF5RP5f7CPs43eNfPe8saZRapL8qSwOV1icfRKORi+AI+i09nTHqOxN5QIi4e/ioOm5FMR6rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TByLxIaCKVWvK1xAs/wwRizS67S68bJ2alZxnMmmUk=;
 b=cK1W7OC/iwLJb0nu+wkWyvy1qpnUo+cM0lZ0MQ5hfIMVUu9V+7exjIngikw6xNt8+OjPkH99FX5zS5V+D4NEs4Fswau+CFyQ9QQW7YirHiEGPnpeSMwCtT9Giw+n6BnQMM/DKHiQgAmKJFH8AwBSyuYufVnK8u8mro9NiIuu6rvnFxjBn7ab70+9XMvYOYWRtYAwI/of7gqLNqPURsCmYBN7ffzY2r+8ODiOwMrY01nVx30W/fMfkw/FNnC7hGEbd3phZiiB9eL9i3cLX2j+IQ+e43fWdnE9AEOaYe31nhvakDt6rkhOp8bcWSmu3zAI0C55Hs3ZW1HQ25zr3NXpVg==
Received: from DUZPR01CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::8) by AS8PR10MB7586.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:53c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 12:14:50 +0000
Received: from DU6PEPF0000A7E4.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::46) by DUZPR01CA0002.outlook.office365.com
 (2603:10a6:10:3c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Tue, 6
 Jan 2026 12:15:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU6PEPF0000A7E4.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 12:14:50 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 13:16:04 +0100
Received: from localhost (10.130.74.193) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 13:14:49 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
Date: Tue, 6 Jan 2026 13:14:18 +0100
Subject: [PATCH 2/4] drivers: spi: stm32-ospi: avoid __maybe_unused and use
 pm_ptr
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260106-spi_st_maybe_unused_removal-v1-2-8f5ca7136e96@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E4:EE_|AS8PR10MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e80f1a-5bc6-4aea-627f-08de4d1d3110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFZCMkhIZUhmdkFXMDVudzJVS1RXeUU5aHg4YlR0dVdSckppQXhLRnhhcEJt?=
 =?utf-8?B?bjJrdlpkdTgzT2RnWTQxU093ZzdPT084a1pQN3lwNnYyTWpnMWFDQmU2T1Jo?=
 =?utf-8?B?K3ZDQ0F0RXkybk9PZ0QzQlgyVDVHUGxsa05JMW1IZFhCWUV4RjJzZXN0T1lv?=
 =?utf-8?B?OEl4aklQNWdiaTZmbENNZm5YTWVWUlJrNmUwUndpbGxlb1RWaDJidUFSbVBa?=
 =?utf-8?B?L1FzaXpYNHUxSlJ5NEw0ZW9LQ1A5UkNTVFdOY3BFVVlQNmhSVlJEVUhGb2x6?=
 =?utf-8?B?L3dJNWxFa1E3MmdWS2Jsb0libXFIVEJkM1JDOW51UVBab0lxbXAwdGkwWUVt?=
 =?utf-8?B?d3k1cDJGT2t4VUh4ZDgzSkhGWjJhb1RWMFQralRFcVpwQzRKZVF4OXJrcWtT?=
 =?utf-8?B?RmYyUWFsWmJBaEpOSjdJeWVYVk1HRzdXT0wvbWZMcjltK1E2Z3RldkUxTndL?=
 =?utf-8?B?S3UxYSt0N21nb2djSWhxYlo3SWh4UVM4MXpycmVDODBzVEozT1hmUk0zdTR6?=
 =?utf-8?B?ZjBwM0puZUNyZ0YxcTZ6cnVGV0p0aDhSTmZTZE5KQ1poZFg2RjdTN2t2Rjly?=
 =?utf-8?B?bFJvaGZ0K0piNFZoYUdEUkprTklnRGdPRVVMUXRWRmZwczdZMXVYSEt3N2Fp?=
 =?utf-8?B?WHVxZUJhbFBzQnZQRjJSNk1ZMDB2dyszZG1wd21lbnJpVVRZY3JXaExDNEk1?=
 =?utf-8?B?SjBpNmRGNXRVbzBtL0pzSkMzMEZ0aWdWVGRXN1B0cThCcUJBZ3NFL0RvUUV0?=
 =?utf-8?B?ZFYvRWlZb0phcUo3R1V4Zi9POFNnKzFPWE1JZ3hTODRTREFQM0NxaUc0cGIw?=
 =?utf-8?B?UTFiV2lCTGFQL0FQQmh3cnczTjJvQ2ZPOWNxd2U0VXhjUWU4T0JCS1BzNFVn?=
 =?utf-8?B?QTMxRytaOU5nSkpOZHdRQmt1MlNlVHFJRndFMVFzVlRIeFFPYWYxanJNV0Zw?=
 =?utf-8?B?WU1LMnZHRGpMTGVYMU80Vkw4emgzOG5ONFZPTzh6azB4TmFzVkViMkl2TWZv?=
 =?utf-8?B?V2x1VHpUS3JScTlJTWFLV3F5WWkvSWV6ekc4dHk0ZWtvTjdGcS8rdXhkSHpS?=
 =?utf-8?B?NEQwV0JOSjVNRG1rK2krT2hHK205UGFOWmNCbGJpVlQvWEJ3QWFoeGM2QkJz?=
 =?utf-8?B?ZHNvRmdSdEVFeHVrb2xQTXBwWEQ1VlNMTUdoMXJoK095QkRyRnlMWEFRMUhE?=
 =?utf-8?B?cVhaakVWRVhvS2Q2QW0wd0pPREhXRm84YVhWa2tvQzVCMEV1czdVUTJ0R0Nz?=
 =?utf-8?B?VzB3bDZCQVdPMit1ZitwZ1ZtWTFIdmtHNUQ0WkJlV0p0T1ZtS09TOWI3T3dt?=
 =?utf-8?B?RkZiakQzQ3lTREh1S2hFbmMzdDR2TEtkUnhiTlIxd3NmMVJDMDhiYXRlOEty?=
 =?utf-8?B?ZHBvdC9VMGV6eDA0Q09vNjBSQ3pUeGRWM0REOExTVmpSZVZQSkxrNVh2NUxs?=
 =?utf-8?B?U05Gdi80N25XaDlSTXp5ZEhocWNTcnJJcHlLL3lKQVU4cm5YQXNUNHRmREpF?=
 =?utf-8?B?SWxYaGFWSVUzTXBNcXVIY0JQRGlONE83WkNXT2xSNGY4SG5tQ3JNZ2xiU2lw?=
 =?utf-8?B?NFlTMnhWRnRCYXJVWDFYcmFCbWlEV0tXWG8xSUk1Rm5ueU1qZTEvdkVmaGZ4?=
 =?utf-8?B?bUQrUzJwazR2ZlZaUTlPcDdJOHZoNWtwYTBNeEozZU0xQjhaN2tmZVptTWxq?=
 =?utf-8?B?SnB3Tytzd3RHSGYxa3BKL1NCMzVnQml3R0xoY2NjaFUxRDlLK1dGWHJ6WjQ3?=
 =?utf-8?B?VGR4L2l0dXNFalcybkYvNEZJUG5xR1NPR0xGaGZuc2NINFpDeCtPNUNTK05I?=
 =?utf-8?B?eVlpTGg5VXliRUZjTDhBYW1VbkVhbVRZeEZiamo1OVhyNU9CMmU2WEpjQktH?=
 =?utf-8?B?bzZXRHdmdmc3YjUwS0ZjQk1hang0OVA0QzYyTkcxNmtmcjZtM1VBQ0FFd3BX?=
 =?utf-8?B?L1hFTWtqei9vVEREUVRlK1dSb1dLRFRKZHlzN0J1Y0hmZ3h6NEh2TTE0Sklz?=
 =?utf-8?B?Z0twQ1hhU2RXUEtoZnE3TXlwQzk2d3dJQmJTT1VaNTZvbjVoOU5peVJMT1pz?=
 =?utf-8?B?bWZYdFBRaG9RRkpnRWEwY0JIQU03QThXQmp0WnFoejhjSHJwVlNzZk1tMytv?=
 =?utf-8?Q?BXNE=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 12:14:50.4602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e80f1a-5bc6-4aea-627f-08de4d1d3110
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7586
X-Proofpoint-ORIG-GUID: 14qz2LDk3mo1jfYKrGGvopWvdnjJ4Zsf
X-Authority-Analysis: v=2.4 cv=SvWdKfO0 c=1 sm=1 tr=0 ts=695cfcbc cx=c_pps
 a=+ohsn0u86qlID4FyhhUwTg==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wL9PcE0S0AMA:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=7wyQpQe0EkofVtEA0L4A:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEwNiBTYWx0ZWRfX9Nfu4v37TqkB
 +KL7tp5K4fiVKZv/EzFp4Qpl0Zx9GSsgv42imnjnK27iaWsNv/vOZLcZOIbNEO/ZCQJqNmIy/O2
 HSvQb+6JQ8DCv0fLWsCzi6VbnoJdTDGrx9xeY4lcERruUC7Fqr45OwhsuFL+Xg3Ow+nD1P/jqTq
 Ey3xbpXvj8puPeJ315OYuX0Px6BLv+yyq8W9cbFoDse/56h1giRkcJG0Knn/3Z94G7YnVdQaA98
 uBua3eK+bKMMo7ycpBJOersDv/V3pneTb/oSGe38guq60PrChP5vy794DThwGMPXW25hZ/wnbL5
 GRw2ERpaqnD14ZYupQhJa+7Ret+1a49R4oct2kzNgVqQMhtKWRPSPyK/fOAj2QUU2stfodCODYi
 u1YZQvuq2b7wysUM9/VO+hY2hakK/OXnS+QTIX5U+Q+huK1fk0CtF21656nRnV9RBMbZUBcGpTp
 eB2dkiksVadIQJuy63A==
X-Proofpoint-GUID: 14qz2LDk3mo1jfYKrGGvopWvdnjJ4Zsf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060106

Switch to usage of pm_ptr / SYSTEM_SLEEP_PM_OPS / RUNTIME_PM_OPS
in order to avoid having to mark the pm related functions as
__maybe_unused.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/spi/spi-stm32-ospi.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index f396439e2281..58d8cec74c7b 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -1012,7 +1012,7 @@ static void stm32_ospi_remove(struct platform_device *pdev)
 	pm_runtime_force_suspend(ospi->dev);
 }
 
-static int __maybe_unused stm32_ospi_suspend(struct device *dev)
+static int stm32_ospi_suspend(struct device *dev)
 {
 	struct stm32_ospi *ospi = dev_get_drvdata(dev);
 
@@ -1023,7 +1023,7 @@ static int __maybe_unused stm32_ospi_suspend(struct device *dev)
 	return pm_runtime_force_suspend(ospi->dev);
 }
 
-static int __maybe_unused stm32_ospi_resume(struct device *dev)
+static int stm32_ospi_resume(struct device *dev)
 {
 	struct stm32_ospi *ospi = dev_get_drvdata(dev);
 	void __iomem *regs_base = ospi->regs_base;
@@ -1052,7 +1052,7 @@ static int __maybe_unused stm32_ospi_resume(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused stm32_ospi_runtime_suspend(struct device *dev)
+static int stm32_ospi_runtime_suspend(struct device *dev)
 {
 	struct stm32_ospi *ospi = dev_get_drvdata(dev);
 
@@ -1061,7 +1061,7 @@ static int __maybe_unused stm32_ospi_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused stm32_ospi_runtime_resume(struct device *dev)
+static int stm32_ospi_runtime_resume(struct device *dev)
 {
 	struct stm32_ospi *ospi = dev_get_drvdata(dev);
 
@@ -1069,9 +1069,8 @@ static int __maybe_unused stm32_ospi_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops stm32_ospi_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(stm32_ospi_suspend, stm32_ospi_resume)
-	SET_RUNTIME_PM_OPS(stm32_ospi_runtime_suspend,
-			   stm32_ospi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(stm32_ospi_suspend, stm32_ospi_resume)
+	RUNTIME_PM_OPS(stm32_ospi_runtime_suspend, stm32_ospi_runtime_resume, NULL)
 };
 
 static const struct of_device_id stm32_ospi_of_match[] = {
@@ -1085,7 +1084,7 @@ static struct platform_driver stm32_ospi_driver = {
 	.remove	= stm32_ospi_remove,
 	.driver	= {
 		.name = "stm32-ospi",
-		.pm = &stm32_ospi_pm_ops,
+		.pm = pm_ptr(&stm32_ospi_pm_ops),
 		.of_match_table = stm32_ospi_of_match,
 	},
 };

-- 
2.34.1


