Return-Path: <linux-spi+bounces-11819-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF884CAC5A8
	for <lists+linux-spi@lfdr.de>; Mon, 08 Dec 2025 08:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30B93304EDAC
	for <lists+linux-spi@lfdr.de>; Mon,  8 Dec 2025 07:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEF728DB49;
	Mon,  8 Dec 2025 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="XsABhI7j"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592A523B62A;
	Mon,  8 Dec 2025 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765179000; cv=fail; b=NLl55ywxn3nogv3oeBtHTcG/5rv965oh4lbUUjoZaqJHhpgNEAudQ/sFIHBdnKec53sFPoQpf5q4GcB8u6T/+GMMl+zKk1WsFY7BbIkOydz6A2QxO5cDfjjoqoHKD9Mb8ASbJ0A+84o/zpcogq2Wc9IpoUf2F8fG3+fqsqA9gIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765179000; c=relaxed/simple;
	bh=ep3js4OiaotQ4ox5Rrl+kNuqCwYWyycqnEP2thZTTis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FPWazzW6zWwA1EdpLeNhYp8zfkgYv9JU3GL7S/YhwgeZLwRBaFS/BOcp82fp1xdXggdy5YMP3G4kJKPQworJw/53KF5ALYpyn+6Spy7Lox3pCypItcFfjAtO3+MHc6ZIvDGhpZZx1ipExs+TryAtLDp2kfVUUCUA6Q3Ul8HrIFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=XsABhI7j; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B879FYh744500;
	Mon, 8 Dec 2025 08:29:26 +0100
Received: from du2pr03cu002.outbound.protection.outlook.com (mail-northeuropeazon11011050.outbound.protection.outlook.com [52.101.65.50])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4avc8h4u35-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 08:29:26 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f12OfUSZ2XJj0TlMx741lRN5a8KvAY6GNI2O0InNiFVV8bmpYb886+YtUIV2+m146KCUo8U6dVZr9OKQRTBtW58PVYhFD46c3vPPJDqAWOjibc+GOUj4OUi88mAXVEjebK5VXPxxTBAAlLlpdPiMmD1LhZql06PlBAurSwqWbUu1V1TsJOPQox1U58R7lPkVEtNCc9N0cZDN/onRJQr6mfCMwIpLWztEiU85R/G0ybJn/Gt97R1y+gYt5ObxiYJlwe+NSJhKSMRnbDWXn31Dsd4TYk1gl1QcRn+u1dE/rDDNE832AMkKK46raW0UqZnYPdxfzKItOqQfyjq8U67PnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzaeKJv5cANruTig0GzxEtqLPYtRnt4s5JNAJTzPQNY=;
 b=FyygFA1II+2i7aWKMV5zHA82GpcjDCk94qLBnu88rx6Flp3LHgDW29hy4KKD9r19zTkhpJWTUYvpY6cj9O8FvjXXccqGs2+L9iz/F4iHhs0JY0QQ4WgvYI8HC6kRXvfV0yBRWQbwS4IEVnmR80p6y6vhsgdD2pB2pedpPjj9yYOFKaHJ6vQ9oWeUaQtERYW+ucUjWwZegqZwFftdrfxiy+g3UE1MoZ7qqmm7Y+XuKt6cjyDZ+jtdTKPDXL458s5+WY5pCqUZ9Cg28hlH0YoshUAcf4zepqV/zpZpuF52ezYM1Oyu3xeqn3XmJjbATLYopS337zATux6g0G4ppojupA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzaeKJv5cANruTig0GzxEtqLPYtRnt4s5JNAJTzPQNY=;
 b=XsABhI7jTih73Upjt6aKSV9tgVJHYL67FDpHCKB7knox2S/Jwdu4WTb5wfFh1VnAFzP4cB/VWzL/RnqX59BGbPrgwkDCXhhdzaUH7IbSL9pBqDtAtz3P2W0tYn43X5MGCMhQceoOG1Fug+qgh5g/jmx3c/+Fo0g1MTFiSm7BEamY7c8uPP8S1n9yYm5XDnMEJjsi27SXmvVnNo7vCmcDhVhT7hXwqPz3yANSObDSbCB6LPBOWwrSAzX3lweqnpyB4acV+E8UKmyCtLvxyFOCF79zbQhGrlT/OVjYdzZGtYrv1TzmHmc2Wufx69B7RYO/HH8KZDtrWuGBTn1aJzx5Gw==
Received: from AS4P191CA0002.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d5::6)
 by AS4PR10MB5223.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 07:29:22 +0000
Received: from AM3PEPF0000A799.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d5:cafe::23) by AS4P191CA0002.outlook.office365.com
 (2603:10a6:20b:5d5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 07:29:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM3PEPF0000A799.mail.protection.outlook.com (10.167.16.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 07:29:22 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 08:30:04 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 08:29:21 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Mon, 8 Dec 2025 08:29:09 +0100
Subject: [PATCH v2 2/8] spi: stm32-ospi: Optimize FIFO accesses using u16
 or u32
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251208-upstream_qspi_ospi_updates-v2-2-62526c9467dc@foss.st.com>
References: <20251208-upstream_qspi_ospi_updates-v2-0-62526c9467dc@foss.st.com>
In-Reply-To: <20251208-upstream_qspi_ospi_updates-v2-0-62526c9467dc@foss.st.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <linux-spi@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A799:EE_|AS4PR10MB5223:EE_
X-MS-Office365-Filtering-Correlation-Id: 6902f404-05ce-4324-2eaf-08de362b81ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmFjaUg1eTJxV2pxdHJFQzlRZkEvbTI0cEJZODI1cVVZQkRSRXA1Yy8wY0dK?=
 =?utf-8?B?WUlUNFI2K0RaM1FwZmowRUp6cU9DK2ZUM0NnbitRYVFkb2hnOW1tQ0FNSUVk?=
 =?utf-8?B?TnpxbXNzZlM4dkFqdFIwWkszSlhPd0dWV00xU3BVdjU2aGMzc0Z5UEl0OXpJ?=
 =?utf-8?B?Z0p1cG5IUkVtdWIyQUhJbHYwRFNMMSszRmMrN3g5VktHUjlsdktsM21TRFZl?=
 =?utf-8?B?ZVl0VjF6NmZibXgxSTRBTkI5RzRub1JBNG9SaVBlNVRCMGNmUm10VG9aOW1L?=
 =?utf-8?B?UzZQcisxUVF4eGlOQlRlUnQwWEEvOVcyTE5CREgwNXFGOXBVZ1FhbUtXZ3pi?=
 =?utf-8?B?S2pMNVVDRW93ZWFkZC8xT0N3TE5tZ0xqNkdXUkVlWjJtZjlKQUhad3MyNjlZ?=
 =?utf-8?B?Wm1pM09GeG1mNmZ5RkJjT2RlcUNBSnJqdFJvQ0Y1RWk3eDBoODh6Sk1XVGdW?=
 =?utf-8?B?WXZvYk00aDNZSTB0TWpvZE9WelZITjFyNExRaTlzT2RtM3c0Q1F2Q0svajhV?=
 =?utf-8?B?UEhwcDBkQjR0RGV3NVk4OEZtaVlyUnU2a1U2LzE0UHdmSFBucGQwdC9SU0Vu?=
 =?utf-8?B?bUEyOUZmdElLMHF2c1ZraTlqQTJmUzVmcW9JcWhBc1BHSFZleXZBWGwvV2N4?=
 =?utf-8?B?RTlVRXNrS0dBZ0NTMDJibnA1TDFZV3hOQ1ZGYzkrdE5PS2k3d2l4a1lmRStI?=
 =?utf-8?B?bDZCY3NIeXdOYlpoeWdSb1dKSjJLMlpmc2kvb25iN0FDR1cwekNWQjUrNjIw?=
 =?utf-8?B?YVE1Z2xIK2ZMbmd3RFVEOCtBM29xSy9HbFJxWHVGTVlXbTJxWnEzYnB3TGZH?=
 =?utf-8?B?ZUt6RU1HN21MUVlCMWQ2WWh2Mi9xL1QraFNMNE9lc3k0WHdyaldqY1QybUgy?=
 =?utf-8?B?ODBDRi8rVDZiVGFxVVRpTk1adkFrNm9mcFV4cU16dFVuZjFQQUE0cXpNQThZ?=
 =?utf-8?B?dVJOZlVsZ1dTZVN1UEJTY3lLNzhKMXEvK0RxNkxtZFlaa1FadVNxRHNTQTIx?=
 =?utf-8?B?SkZtanZMTTNyb2kwZm8weFIvV1MvM2M2d3lVUDJITlQ3TEs5QTlxRGQ1WU1U?=
 =?utf-8?B?U2F4Ky9ydDlPQi9HL0JYZVhiNFhyY2lSTVRKT0VpK3JQc3FrWjRqdWF1NmpS?=
 =?utf-8?B?SVVxMk0wRS9SV3pVR1doQllVcklsWmtGUkV0UmRFOGtaMW9YVHRRQWlHUHJt?=
 =?utf-8?B?d09FeURxeXFsdGhRcU15LzJmRXlqTUdCVjVycExtNGtpVWhnT1lQQmtUYjA2?=
 =?utf-8?B?L0NzKy9INm5RNUVMY1lVTlMrcnNHWGJubkdyZUtmWm03U2dXSEpkUXRydXBw?=
 =?utf-8?B?NVkrdDRuM3paQ2VTWWdhaXVSZWljdGxxMVVNb3Y4d05UYlEybC91OCtHUGdO?=
 =?utf-8?B?MnBFbTNVaHpRSE5QbWl0ZHpzSTBCMzkra25yN05tdDhnb1doMExxQWJZa0s2?=
 =?utf-8?B?VjBRVTYrdzJJa2liRlJrcnYxVm9SN2tQRFJKaE9xWHNkR2liOXJldFRnaHZi?=
 =?utf-8?B?RWVTbDlZMnNheUM0OS9BdTFZdkM3SVZJd3dGYmJET3RxejViVENCOVZzS2xX?=
 =?utf-8?B?ZTQ3M2YxZmFla29ZdWtZZ2lDKzV2RHR2TWlMY04zeituekNFM0wwWGgvWXNL?=
 =?utf-8?B?T09CNXMrTkhrR3pHVzFIUlZlVGJsRUYrYTBtWVlQUm5Ubjl3TWtGV0YzakJ4?=
 =?utf-8?B?bW1VRERzdFIvOHJRMml6M2EwWW5ldG5XT0N4UjJQT0cxaFYza1dIaGdNNk8z?=
 =?utf-8?B?dnFwSWQrS2M2NWowb0I4UGtaSFNPQzN4b3RsUXRXWGxzWllQS0dWNFYyQU16?=
 =?utf-8?B?eFB3VWFFQ0hzVEY1WWNKRFV3WEFCOEgyZjdmS0VRbGYvRHJrZ2lBam5xSkJ5?=
 =?utf-8?B?dStrei83Nm1YUmovWkh0VmpZdVYybzhoLzNUY0FwMGdkaXplUEx2alNpeDQv?=
 =?utf-8?B?RXA5eFJ1SGU4N2U4d255U1prdW81V0o3L29wUXpzK1VMdmZGZFdHS29DRUNw?=
 =?utf-8?B?SjR4QkIwTUtTQnlCc2oyNTR6Q2lvL0hiclBDOXpVbG85WTlGWlNaU2pDL3N5?=
 =?utf-8?B?VTNIUzNvRG1ySFZDUFBFL1JWS0NZY1FCWjhCN2JudlJGSmN5byt2MTFjR0k3?=
 =?utf-8?Q?xKUo=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 07:29:22.1571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6902f404-05ce-4324-2eaf-08de362b81ce
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5223
X-Proofpoint-ORIG-GUID: 5OIS9waD2wmc3yXyiS43KMCUPbvplYLj
X-Authority-Analysis: v=2.4 cv=JKk2csKb c=1 sm=1 tr=0 ts=69367e56 cx=c_pps
 a=YWPBmyF2ww8/fKl6NjReww==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=dgGDXPkSZnP7Mkk4B0AA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDA2MiBTYWx0ZWRfX7AzE2ol7acCy
 Yila/VWbBSjGvy7GR+r2t/tssJ93qgaSnOikSFIUjYBOhiDOJ3gSoRIo5oPEL8uG7DZP2ZRCdjP
 XIsjauXRDPG4rnRETZW2g1Kt8yhHDx/t/CTlgbW5/xlxKBtXOBecYCFYZtUBCHwlrpdqaKr/xa7
 lsj/F4de80fagiFzZ6s0mu156F+f7tlqmrhPwIwTPsK9/OpbD+fu5bwp4lYU8a6LWHP8sUv04UU
 E/Ybu3oXKjO6CpvN/2WEuuyqdtdzRLKs+EwG6T0VoCGm5AkCcEOyyhkUt6vvtGZk5OM+gaWAN3m
 Kr0zRquzCuYQOREU4sEctwVHvMS3NA+XH+rmT/tBGpJCyuIT8irIzU1q3P4JxzqahneqVopBsJd
 9R32myVS3OabF9jIUsxKbAN2oGEALw==
X-Proofpoint-GUID: 5OIS9waD2wmc3yXyiS43KMCUPbvplYLj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512080062

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


