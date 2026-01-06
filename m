Return-Path: <linux-spi+bounces-12183-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B5886CF8415
	for <lists+linux-spi@lfdr.de>; Tue, 06 Jan 2026 13:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5FA85301514A
	for <lists+linux-spi@lfdr.de>; Tue,  6 Jan 2026 12:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A31326D73;
	Tue,  6 Jan 2026 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="evPqkXQH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B4830DEC4;
	Tue,  6 Jan 2026 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767701704; cv=fail; b=n818d95v6fT7wV35ZqVq12VFJPLlTijAOZdPSBtyjnWPQeNedVHWmnoHq1swGASSbO42sjJhwHgwIUVAdT0gY5dgvrLIDCUJMoa9BEXBiIoI0ZjXubW08+sRxcdNx/hRzWmVRHYm07HKnf1/iF4X2EMPHCIF7oknfh45ly2R/ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767701704; c=relaxed/simple;
	bh=0c9j6zVTwXvYeh8bpWsm8iA/0KB0989FCnyl1vOcGeY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=eO9nrGxIehSukOXI60EvtQfzhfefmsVhhrHWkgrX/5f/ZaHh/bnaXYaOsos+5G35RiVt8e35qtQRtY847n1l0B79HE+esBOOpumNisjVDS/JipKM/4gYFb3GzLgQhI9xzqeWmrpd23hde1Q0RyOxtB2LyKywjrwvhvkG91teH3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=evPqkXQH; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606BxsT0375227;
	Tue, 6 Jan 2026 13:14:52 +0100
Received: from gvxpr05cu001.outbound.protection.outlook.com (mail-swedencentralazon11013060.outbound.protection.outlook.com [52.101.83.60])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4bfexpq8gp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 13:14:52 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuCMYFcli54vdHl3WYeTG6iSENKQ31urNCjHEQrqLH+VyAEaZ66CLkppIH7uxOtqZjQ+ZqN9S1mOfR4a19ZAjRlhcZ8+VUgQdxeOqeBY81Q39Dwem8kdqU0vxAgYFuFiHefGbqIeOR+IcsNueGyDWAzgYCNYQz5XuwV5MafIMc29xkRLtf59PlUAUVUZ1v3P4YUPUg5cNJwJwm2z0bS3aSC13v8eoGm47YIgrcFRqUsGpQCKDSMeSswJfZk9xnurFS2+zW/z+LCO6CxVjQP12lJTBgcYyPxYtcrLpUWNoD+W0wWMFKnxZH8DnFsNyckCT1Ni64nYBc+DAMSfobXqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onpVN18Hvvzjfx/ZTgMd0NGLHpHo7QxNFgWhEKzsoQg=;
 b=hgDjilqyayuY1FnvbqrMsXI4MI2D1vyA1GKk1sBfwgBHdLzMS/sYrxgsWSbeEPGgKuww285cde9BtjhNNryrjCdc5QqKBBjDLpPjbvNa91ksK3StfKp+K+/Bw2kuakj5ona1UnTTe1NbUPcz4Za4n4QFmxAYxBf/HK9AoCfuVZcmLy5ndlEgtaoHmcjH0e8imtasbRX7Quh/cVIFj5bqqYJLdmSDuHuzPTSAHg2e7Qb9P3TODCwoPmAEoZvMx58YKcRRYKXd03L9rw/00iTNbjdeGfsl5ctGFYL1X922nMdusIVYP1bRtEehkznytK61CnMJhOFXqVvxkEYcOlbo8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onpVN18Hvvzjfx/ZTgMd0NGLHpHo7QxNFgWhEKzsoQg=;
 b=evPqkXQHZ4ErE7XwEou70eAWmGQEbt0H0F0PxueWvDmEDdRc0uMTLEZspgAjFKUuRKBahv559+DpCoImChnJZjakzmS1Z9hWTWFsyTxUKffkhz5IvKopWcRS+VfPwxCKa3scH3kSuuP7pP3xA85ZUwoixpiJhHt8lLQ0+1WKwv8v7EMeJpXT8dTQ18GmwQgBIqNeQVdK9po1SaHxGV0ZQLwvlBNoP+ikXBWieLUdpkJJTaF7Ga8HMjVr+eXWqlCbhxWHY+KOMIdyD+b06w7zKbKd7KGm5eDZpCdkpzc+Rf4qn3X6gpQl2EydoKxeU9OEwRnq7s1JidIr6HDbaIMQYg==
Received: from DB3PR08CA0003.eurprd08.prod.outlook.com (2603:10a6:8::16) by
 DU0PR10MB7591.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:401::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4; Tue, 6 Jan 2026 12:14:49 +0000
Received: from DU6PEPF0000A7E3.eurprd02.prod.outlook.com
 (2603:10a6:8:0:cafe::f7) by DB3PR08CA0003.outlook.office365.com
 (2603:10a6:8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Tue, 6
 Jan 2026 12:14:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU6PEPF0000A7E3.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 12:14:49 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 13:16:03 +0100
Received: from localhost (10.130.74.193) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 13:14:48 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
Subject: [PATCH 0/4] drivers: spi: st: use pm_ptr and remove __maybe_unused
Date: Tue, 6 Jan 2026 13:14:16 +0100
Message-ID: <20260106-spi_st_maybe_unused_removal-v1-0-8f5ca7136e96@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJj8XGkC/x3MQQqEMAwAwK9IzhZqsQp+RaTENusG1iqNiiL+3
 bLHucwNQolJoCtuSHSw8BIzqrIA/8U4keKQDUabRlfaKlnZyeZmvEZye9yFgks0Lwf+VBtaa4w
 dPdYIeVgTffj87/3wPC8TNF99bQAAAA==
X-Change-ID: 20260105-spi_st_maybe_unused_removal-7d75225bca4a
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E3:EE_|DU0PR10MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: 5383a8ec-d633-47f1-fcbf-08de4d1d305b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWpaRURTa05tSWNnNTNBY0NtNExaeGxLZmZMdythNWE5dWExUkVZb0VxMmE4?=
 =?utf-8?B?V2VUTnQ2ODJ0SWZOL1AyZWQrRUd3VTBTUFlzNDBwSkJxamlMVWRWdDRsR0Qz?=
 =?utf-8?B?WE95STdNYzVKNjlLK25uMUNEdGRaQ04yWi82Q2kvVzd4eS9PYzJtd21FdVFk?=
 =?utf-8?B?Z2N1dTJsR1B0VkZVNCs4ZUVGaXJ4ZFAwQVpycEZ6dzdCODdzbXJkRFcyU1lP?=
 =?utf-8?B?SVRQZkdpWlVGYUczR1ZpcmZ0aDdFcjFtVzFHM0VOTnJuQldXb0dUZThHOG4r?=
 =?utf-8?B?SlBWMXREbEg1TkttSXR5Y0FzMHFrNVBodWxlYjdob1F6a1Joei82R0NKSTRP?=
 =?utf-8?B?clFod1lmZE1WZjNpTDV5VWdzbXJueS9BNjE3SmZEYnNJMlNhdzh6QnZiTkJr?=
 =?utf-8?B?U3ZQbzZhdFFXZzNhSWFHaURJV0ZrSHhVTlRtdWpCem95QW1oUjNSYnJKVWYx?=
 =?utf-8?B?RkZFUEFvTWlEdVF4aE1wWE5VZ3BuMWZocjNOK3BHNWpNNnAwUU1yVlQ1Q2s0?=
 =?utf-8?B?NTJkemFGd2FYSWFOdktXMDBvYWRYa3R2WVRwT2JtVlNGak9HdHNXVjk5MTVV?=
 =?utf-8?B?dFhlN2JqWTZWSEhod2VueENhdFBnVzI2S3QyNUJjOVhlSEUycTk5TlZXdFpX?=
 =?utf-8?B?L2drTWF4RUdzT2NJVkoyNEpNakkvY0Zkd0tDY3JnNE5QRU5EdFk2ZFg2MTJV?=
 =?utf-8?B?N0xaalc4M3Z5OE8rMTlQSDhiMk81VnlaSFJrNVpodkFWSW5ucmlaMnF0WUhm?=
 =?utf-8?B?RzNDZWtkMTNKN2Y2bzBhQWxLeVBJQ0p6N3lMTUVDUHhEZFpkM1JXTndkSzlG?=
 =?utf-8?B?V2c1UE8zSjlOMTlXOWV6LzVaNXhqZS9MbGZrU05STjRCdHRGZWFIclN6SnNR?=
 =?utf-8?B?QXVkQUU0Z0xnRUg3cjBEaFRlR3dDNmdRSFpFNTFTVWlvdFAvaXgxaE1FdkpC?=
 =?utf-8?B?NjkvU2dWaTlUdWdGN1V6RkpuREdQcHRNUXBYVnlsR3ZtMXcwYWEybTVyZ2Yr?=
 =?utf-8?B?amVkYU1uT1E1bmpobTMzZUhQM2k1cG9pV054YVpHcnI5NCsxZjNldCswYjFR?=
 =?utf-8?B?eWpReDZIalp6TlVIRE04MlJkWW5NcXRyWlQxblpNeVl5SHI0SWkzUjVKeW43?=
 =?utf-8?B?UWpBWkRKeHRHTUx1UXJZckc3eGEzRmZtaWJvM0dDVStOMnZpSXBvRzF3b0FS?=
 =?utf-8?B?WlkrblJ6VWREMzYwdEc5SVlWdTR2aEt6V3BqdVBBbzRyUlJuV25PNGFlY2lY?=
 =?utf-8?B?R1c4M3ZrZXZpVmRpcTZFNTRRRUJxTUczRktFcXRWbXM3VG1TN25LdUhYbXpM?=
 =?utf-8?B?NmcxOVFoTEkvSTJUMnN0RXZFdjBBSkQ1ZWxZWUhoY3JCK0ozRjE2Yk1DOU9s?=
 =?utf-8?B?cTVhTWFQelhDbkxnSWZLVmcxL0pKK01Dc25qYWZ4TnhPMWlXVGFiVlZ2V3ZN?=
 =?utf-8?B?WTkvbFdvb1pHNnpYckNjNHBPQmVWV2pSUVFjV0hmcEhMNUh4NC9FYlNRZFc1?=
 =?utf-8?B?UDhOQUR5bDBVWGp2dDZLNXRRNUpZQmhHVkZ0VURoMzc0a3NDeVFYVGQ2K3E3?=
 =?utf-8?B?dTNPU1dGdTJwVUttR3lsMUdGaGxKcjBIVEQrU3NSMEtkVmVRQThFUTNMQlVT?=
 =?utf-8?B?WTdiMDVVeE10ZWQ3akVCN1RKMEsvYy91NVdxS2pBS09MbnQyZXh2YmZvc3VH?=
 =?utf-8?B?TGVSMmVYM25BRDBNTitYYnY1OStTS2pDTUtKRXBYdXdpY093bFVqbUxaYkdD?=
 =?utf-8?B?MjMzdmljSlpPdEV5U1dCZTU1T2pjWkk0UEFCd09RTW1KZjJ4T0EzSGRWeU1H?=
 =?utf-8?B?bWIrNFZjdHhhZEZoVW1Nbm5OM2VuaWFkMDBLZ2ZwbFV2dFAwUUNsKzZFek83?=
 =?utf-8?B?MVdLcm0zekI5cDQ3UWdKaDl0cHlHQkJXbnVsYjhhOU9wa3dxTXVtTDVmckdp?=
 =?utf-8?B?Q3BZYmdIZG9PRk9ub0hETStlbjBYUHdhUHZuYlFWaGY1bzdBcnJoYjRYWlMz?=
 =?utf-8?B?MlpUeGIzWU9tYnQwQWVsM1pBd0NyNm5SQ3NjbklJaU9IM0dubFlZZXdIMnZJ?=
 =?utf-8?B?Q0lVR2g0REw0MzRScnNEVWVOMmVxL0NwR3ZSSHczNEE4ODJQRVgvUTJRYmI5?=
 =?utf-8?Q?acmE=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 12:14:49.2684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5383a8ec-d633-47f1-fcbf-08de4d1d305b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7591
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEwNiBTYWx0ZWRfX33rac1jP81ya
 00GrTh95gR+6G/PT+BWV4Z4dn7vdJnFPgvpdRcvx7p11k2fHUaJeZvspvwQXJySBvIpP8jQkYCc
 IGkMeSg4K2kDc+8KB2nTT/AeCPy5v6K2JSp5nMBy4H2B/3RyeHVndsUpOvsytlUUvT2zB6uz5cz
 6/rYhYtTtCXniJS1fSTSjkLHXPNzchoAz91YwlXI60gpaJ0mrXdcHDF8CphQL7TG+FXAjnOvAId
 7i89PoKnvKD8jBYvcTuStFB48VmHyT8rw7Q1dcp54nve+eiX96ZpvurNjlAttKpRmpdv/RrRkT4
 99nV9+RBUa4o7x4dGXDN24I9EGq9gZ5iMhp49mPPWY4dqrFIvlMln2n9fvaRx5UFPDu/g1ZHc/V
 ys/e7xo77zwG4+zAjJCQkuqb/YHOc9TUFK4koLq2hlRxghDlg2zP60DxXZxlybVZMiR8k2bmhk2
 E09i8pAXIwynzt68+Cw==
X-Proofpoint-GUID: nZtLw7HZMKdgqUISuvoBdQioQQ8WGTD1
X-Proofpoint-ORIG-GUID: nZtLw7HZMKdgqUISuvoBdQioQQ8WGTD1
X-Authority-Analysis: v=2.4 cv=UrFu9uwB c=1 sm=1 tr=0 ts=695cfcbc cx=c_pps
 a=1PHydY8sO1AsXBlMK61GcQ==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wL9PcE0S0AMA:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=bJMWH_skVZTfTQlM8IYA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060106

Update ST related SPI drivers in order to remove the __maybe_unused
statements on pm related functions thanks to the usage of pm_ptr.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
Alain Volmat (4):
      drivers: spi: st: remove __maybe_unused for suspend/resume
      drivers: spi: stm32-ospi: avoid __maybe_unused and use pm_ptr
      drivers: spi: stm32-qspi: avoid __maybe_unused and use pm_ptr
      drivers: spi: stm32: avoid __maybe_unused and use pm_ptr

 drivers/spi/spi-st-ssc4.c    |  4 ++--
 drivers/spi/spi-stm32-ospi.c | 15 +++++++--------
 drivers/spi/spi-stm32-qspi.c | 15 +++++++--------
 drivers/spi/spi-stm32.c      | 15 +++++++--------
 4 files changed, 23 insertions(+), 26 deletions(-)
---
base-commit: 167a75dbc73d41199d0782e629adc1ff2acacdef
change-id: 20260105-spi_st_maybe_unused_removal-7d75225bca4a

Best regards,
-- 
Alain Volmat <alain.volmat@foss.st.com>


