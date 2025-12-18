Return-Path: <linux-spi+bounces-12017-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8E6CCB801
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 11:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BBC0309AF21
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 10:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE01322DC0;
	Thu, 18 Dec 2025 10:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Qft3dtD6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650CA32F74A;
	Thu, 18 Dec 2025 10:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766054951; cv=fail; b=qUZk6h8y/bpHlAx2eEyRrAm5ef40jzUCQbmNPHCuKE9YuC83YhDAClJu3Zq69Nz9UAKxgUuxayuo0l1iYgl6qrdY10ezOS1UNYgMCebh2sXQT4fVugKxJrDOGhDsT+Ci4cHggeVPXv7DAXsv84Yq713Ca4CBYqtawFmnDN4XAWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766054951; c=relaxed/simple;
	bh=1cDzkghdYvYMGOBhWf9DbxZ6s5J0VKakHUIRgQuz65Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Ec+CWlMa6n2IvBhKu9lpxOzBBNBmpNtIGbeEWR6PYiuDD3pYkigX0K2rOE/Cd3FYSpjHrOEEzI21WxQOVIeBVvXK39zRKlEatI0KQDKl6fKvbjKG+8/Odk4ejxRYEq/kBF9Gn5lT83rYF+hBLDoROhdZiNcL5dvKwogpEbbf5OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Qft3dtD6; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BIAWQPG2519515;
	Thu, 18 Dec 2025 11:48:54 +0100
Received: from gvxpr05cu001.outbound.protection.outlook.com (mail-swedencentralazon11013019.outbound.protection.outlook.com [52.101.83.19])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4b3de1qe4r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 11:48:54 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCJ9ehZdAfEo1VZqzNCp+hTAQVKF7vCnc03Bra/Npikcu63TE6hfXnZ4UYkOg9lNf3W0JPOYCSHZG3WzK+kQ0hasQ+77oNrvQL4BQXCKRbopLH8y8EBfjM/YtSn3dNy83kw1/sZBzgckdkuPjl6u5YSANDn4rW+FZ08OEDAobfsi3opmwlBO9evT1A5oGObZUhGC8MuxTVurV0jxK00JaQfP1boJRCmF/J9im1H94jncmGQdlq+MqNf2e506rPoHAs28Jx4m+4hKuJRo5+HDaKF29KZcVaFlwMm2MEz0NncexF7nUkge2BjSk9V/ujOOGkQteCDjJySETT49kvFrhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dv25XXedadBoBoiURd8dfLWQQ6X2CA9xxAEi/0bH9TQ=;
 b=ndcqYhypkpecxFYuKO6HGAZCs69z49KAjQkLHdyDu13zu3QXLH0PAnmx/k6m+EyZ0mBTijvwVxgd7/D+pey1wQ1Ht2C5/1Nh77s5rKf8c7Vsbw0mt+dlz4T9T/bLenhcM04IrysOtt1yCjgLGnvJilUtucschxUV4fPFAvksoPAHKfOPAsv22mXA4cxYvlxjUx/RWHucjgSAuDNN7pEcMBB34i1b8WmurCOjrTY1hhEv9e4x1u+Ta3eqhFgagH0HHFbxo1LyBWwf4dPQmfy5LNk8DcYB0B2lTBNWu6quwdKqfvgUX0Ok/Ub+MNORapjLu+biVSC4GregqBihr9hQow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dv25XXedadBoBoiURd8dfLWQQ6X2CA9xxAEi/0bH9TQ=;
 b=Qft3dtD6K8RRHY4fiwV69tAAv8rAHag4diKHvke8X7oNjLciGQwabYo6iyYH+8WxzTvhMnAs5u3z4SO1RxLn6Sl6isoMHSsByGYFRCEpV/lwWPas7BFWsn7CjRiPaGRjW5g4Re+zTpg+3YWoXgMld7++ZKYYDi4+65ub2ksxVNg1wnp5DE4N2oBbMxZgrh/bkgf8w1MM9v/VqNf/AVcjE4/QT2LalyBwdpBOHrep4rYRMWWjJId92zRJPTmTz2etdFA5GIcK/0VQov5cggRVP9F6+JSgemFj2XqHGoXfKMLBaPo7PSW7IY2IYxmmhSaez9fjeovsEB4eyBkuZuC5wg==
Received: from DB8P191CA0025.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::35)
 by VE1PR10MB3855.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 10:48:46 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::f2) by DB8P191CA0025.outlook.office365.com
 (2603:10a6:10:130::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Thu,
 18 Dec 2025 10:48:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 10:48:46 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 11:49:34 +0100
Received: from localhost (10.252.25.7) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 11:48:45 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
Date: Thu, 18 Dec 2025 11:48:29 +0100
Subject: [PATCH v2 3/4] spi: stm32: perform small transfer in polling mode
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251218-stm32-spi-enhancements-v2-3-3b69901ca9fe@foss.st.com>
References: <20251218-stm32-spi-enhancements-v2-0-3b69901ca9fe@foss.st.com>
In-Reply-To: <20251218-stm32-spi-enhancements-v2-0-3b69901ca9fe@foss.st.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Alain Volmat <alain.volmat@foss.st.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F7:EE_|VE1PR10MB3855:EE_
X-MS-Office365-Filtering-Correlation-Id: d856a747-50a3-404f-4315-08de3e230510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHBTeXJuRU5JcWhFamZ3dC9RZmhscFhEa0hyWHROWjFtc2U2aVptUnlTWUFP?=
 =?utf-8?B?bmpEbXBOUFBRY0dSU1lPR0kzMHJmc3Z4ZUk1ZWFYeHdhRFN2dTcxU0ZxaUJS?=
 =?utf-8?B?RjR6WVpsNTE0dTZWTkRtQUh0RG1QaEFSMThxampNZUhHMnlUbGE0YVdmdytL?=
 =?utf-8?B?b3ZxQkZ4TGhhUDVrdjREN1Q4emZaZHYxc0ZXZE5OOWxmcW45R0kxU0ROc3Y1?=
 =?utf-8?B?eG0ycFlTWkZEVllPdlBQRm9OMlkxS1puYS93YUFLNFVQeUIrZWV2KzNvenp5?=
 =?utf-8?B?Mlp4TXdYR3JVUGRuUzFvRUQ3VnNGZDVkcmcwdUIwL1lDblloUWRZbnZlU0tJ?=
 =?utf-8?B?OS81aGJyVHdCRVBjTWEvZFZZMjZMQnB2SVkxSE1xTHpSQ2VaU0hTQUFRdkVM?=
 =?utf-8?B?NTU0Z001U1g3d1I4d3FMM0ZHSnVWRTdsT3dKcnljNXdxeVFrTk80U0VGc2M1?=
 =?utf-8?B?OWY0S24yaXVDMXNZbi9TemVMRmhqMEE4am1MN2FUUFlUQTZOYUFGL3RmOVpy?=
 =?utf-8?B?Tkh6NmpQVXVVb0tYT1UzVmI3OU9qbVQwVUVJYTFQbHFIM1FGc2RaSUVycEU1?=
 =?utf-8?B?WWJBL2Fuc2ZPM2NXcjJFSkNMVzVmSTU4dXhTMlNzdzRzaW1meDVRajVNbzVK?=
 =?utf-8?B?Rkh5ckV1d0ZmbUVNbkYvSCt3YUFha21mWnpZSEpyRUs0aTYwNThXSXM3aDc0?=
 =?utf-8?B?VGNTblkwekwzSStQNllDby8zdENrL1V0QXNSOExiWEkyZGRzbGdONGRLVlVz?=
 =?utf-8?B?eEc3WHMyeThxNWhGZmZjY0JuTWg2K3lZQ0FmYUhhSXNUdlZjcVNkT1kvQVpo?=
 =?utf-8?B?cCtCOGRVL1RGVHQzRm5nWnh6KzFwZnJsNnVjT1lwQ3JEa3g2MUN3MnVVQWlQ?=
 =?utf-8?B?UisxUWZ5L2djRVJHLzFFVE5GSmNLUHlBUzNSaEJzUzFBTlM1aWF4cXJBQlRX?=
 =?utf-8?B?ZlZqMDJ0bEIyczZzdytvdDVKd3FtUFU4QWpCZit5SXpHSG4yclZiTFhqSHVp?=
 =?utf-8?B?SHhqZkFCZjcrZ0lMRVFHN2I5ZmVOY0VVQ2hiQjVrSG8xSnVDTXpPU2p0YU5G?=
 =?utf-8?B?QWpDQWlzZW01Y1EyUkgwYXI1Z0FIVTduckdLZGhoeVRLMjJlN2s2cFFmZU11?=
 =?utf-8?B?dys1ZXV1aittNlkwK2FzbUxGRDVvTmExR3M4MDFrY1puenNXeW5qcitsNHhT?=
 =?utf-8?B?WHU3cjBJeERCRit0emxPK1BQc2R5RzZMV0FxZWZUNnVXUzQzR3AwY29FQ3JT?=
 =?utf-8?B?L1lxTWs3azdwNDFEQ0RreVovVHllVlE5cU9RdjYxR0w3RDNaTGkyUit0Sk02?=
 =?utf-8?B?TDRKT1BoQ0FTdTRKT1owUWxwSmtMbEttcUM2cTJ0a1BPNS8ycFVCSGIyWEow?=
 =?utf-8?B?bDkvVVZLcEJ5L0cxZGcyL1p2QVkvb0xxKzF5aFBtaGgwRFhveXVobTdwWGJt?=
 =?utf-8?B?MVRHRUpuVVowWVhqZ1hmeEpoUHNOZEdjZG5ESzlmd0xvemRCdE9DdWtaNThq?=
 =?utf-8?B?Yk02cDRybnpKT255NVVmQlhRVnBlVkZscERZeGlBU3c5THFtYWJRdlFQMEdB?=
 =?utf-8?B?OXkreWJNajhOSkR2ZjFoa3AyMkFzM0Q3eFNjNWMzWjRNNDlBbDNha3NqZWdB?=
 =?utf-8?B?Q1VqdTMvT09sdzFhUGZCU0FLdDh5WVdrcFl6Rm8xUWhTUGY1MUJlckE0WXgz?=
 =?utf-8?B?QmJLd3EvZXliaDd6VkJKb01hMFNKekVDZGVKZE1zY1pNeE9yWFIzZXg1MnVW?=
 =?utf-8?B?V1VHR2p3MXN5VHhxcUdLdGJiZm1sRDg2S2U3MUpCQWY4SlVxdEEzNHRpZ05t?=
 =?utf-8?B?MGN0V04xSmtKRnRQUEtHbVNhOXV6R1NUS2pKa2taMlB0TEthY3lKT1ZsWGtn?=
 =?utf-8?B?K0FKQjV1RHUycTZzaWx1Q0J2Y2lDOGNndjRnY2lOM00wdkZNZFo5SmFuT2No?=
 =?utf-8?B?OGNKdHMxSXh4c0pYRGVXenJ3YktsTjlaVExkRytpQ3dpb2kxNEJTT0cxTDhT?=
 =?utf-8?B?a2xpMmN1dlg5RmROdnFxRTRKbXhtSXFyajBCNUR6UXZJVUJabnAzbmpsWHBZ?=
 =?utf-8?B?a3pqV2NkQURjaVgrd3g1K3lZaVREdTlaa3Rzdzh5OGxwL0xnWEY1SXNqdGxn?=
 =?utf-8?Q?5Fsc=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 10:48:46.1813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d856a747-50a3-404f-4315-08de3e230510
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3855
X-Authority-Analysis: v=2.4 cv=JeOxbEKV c=1 sm=1 tr=0 ts=6943dc16 cx=c_pps
 a=yGpyVr8xkxB+PwK9r0fouA==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=HjypFGx7bZcA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=PamUOCDZJ7i4i8YjnSMA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: Fx-DTzfYwAxCNwfMNjkF4WbHtLpoIcdW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA4OCBTYWx0ZWRfXzt5EZPRj/IOy
 FDbNYoGDSljPEW0nCxvpmGD5Yl81OAY1JZ/kVZSLTsbYGCbjeil9mYsTCK7zEhU2tre4ffRW4HW
 yUcvjbBk2vcLV26Qt0Kgu+qZusvOO/IgSrnuCCmxGFWw+iMlxWLxmF5BKIv9T42TW3jpuJFajQt
 NP2vDaYDIbFXztC/H92f29jOQiOlIGc5U2G6o6n46E5ZBeVQIHoKodAYXKa22AyjWbrKceSCgsU
 rb8sLwPiX4w3/AkWtNEfIIk0o6Xz7CUWXsYRlsU6dWhh9aWpBR/wYaMkQsoWSqM0RZ2jy1qH9p4
 1OcbH3pk+XEVVR6i2OQXFuOwE9tfktEVtSakts+JMmQ1S2yu6sURLAeQY+as2ifwwVWG+LMyYoL
 oqpkH8xaWFyjfcux1jOdLraFa68k+w==
X-Proofpoint-ORIG-GUID: Fx-DTzfYwAxCNwfMNjkF4WbHtLpoIcdW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180088

In case of interrupt based transfer, when the transfer is very
small, relying on interrupts leads to lower performances than if
the transfer were done using polling on the registers.

Add a module parameter "polling_limit_us" to indicate the threshold
in us from which a transfer would be done polling the registers rather
than relying on interrupts.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/spi/spi-stm32.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index ced6d7b215b9..8f8968383ad0 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -202,6 +202,10 @@
 #define STM32_SPI_HOST_MODE(stm32_spi) (!(stm32_spi)->device_mode)
 #define STM32_SPI_DEVICE_MODE(stm32_spi) ((stm32_spi)->device_mode)
 
+static unsigned int polling_limit_us = 30;
+module_param(polling_limit_us, uint, 0664);
+MODULE_PARM_DESC(polling_limit_us, "maximum time in us to run a transfer in polling mode\n");
+
 /**
  * struct stm32_spi_reg - stm32 SPI register & bitfield desc
  * @reg:		register offset
@@ -266,6 +270,7 @@ struct stm32_spi;
  * @dma_rx_cb: routine to call after DMA RX channel operation is complete
  * @dma_tx_cb: routine to call after DMA TX channel operation is complete
  * @transfer_one_irq: routine to configure interrupts for driver
+ * @transfer_one_poll: routine to perform a transfer via register polling
  * @irq_handler_event: Interrupt handler for SPI controller events
  * @irq_handler_thread: thread of interrupt handler for SPI controller
  * @baud_rate_div_min: minimum baud rate divisor
@@ -291,6 +296,7 @@ struct stm32_spi_cfg {
 	void (*dma_rx_cb)(void *data);
 	void (*dma_tx_cb)(void *data);
 	int (*transfer_one_irq)(struct stm32_spi *spi);
+	int (*transfer_one_poll)(struct stm32_spi *spi);
 	irqreturn_t (*irq_handler_event)(int irq, void *dev_id);
 	irqreturn_t (*irq_handler_thread)(int irq, void *dev_id);
 	unsigned int baud_rate_div_min;
@@ -1355,6 +1361,55 @@ static int stm32fx_spi_transfer_one_irq(struct stm32_spi *spi)
 	return 1;
 }
 
+/**
+ * stm32h7_spi_transfer_one_poll - transfer a single spi_transfer by direct
+ *				   register access without interrupt usage
+ * @spi: pointer to the spi controller data structure
+ *
+ * It must returns 0 if the transfer is finished or 1 if the transfer is still
+ * in progress.
+ */
+static int stm32h7_spi_transfer_one_poll(struct stm32_spi *spi)
+{
+	unsigned long flags;
+	u32 sr;
+
+	spin_lock_irqsave(&spi->lock, flags);
+
+	stm32_spi_enable(spi);
+
+	/* Be sure to have data in fifo before starting data transfer */
+	if (spi->tx_buf)
+		stm32h7_spi_write_txfifo(spi);
+
+	if (STM32_SPI_HOST_MODE(spi))
+		stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_CSTART);
+
+	sr = readl_relaxed(spi->base + STM32H7_SPI_SR);
+	/* Keep writing / reading while waiting for the end of transfer */
+	while (spi->tx_len || spi->rx_len || !(sr & STM32H7_SPI_SR_EOT)) {
+		if (spi->rx_len && (sr & (STM32H7_SPI_SR_RXP | STM32H7_SPI_SR_RXWNE |
+					  STM32H7_SPI_SR_RXPLVL)))
+			stm32h7_spi_read_rxfifo(spi);
+
+		if (spi->tx_len && (sr & STM32H7_SPI_SR_TXP))
+			stm32h7_spi_write_txfifo(spi);
+
+		sr = readl_relaxed(spi->base + STM32H7_SPI_SR);
+
+		/* Clear suspension bit if necessary */
+		if (sr & STM32H7_SPI_SR_SUSP)
+			writel_relaxed(sr & STM32H7_SPI_SR_SUSP, spi->base + STM32H7_SPI_IFCR);
+	}
+
+	spin_unlock_irqrestore(&spi->lock, flags);
+
+	stm32h7_spi_disable(spi);
+	spi_finalize_current_transfer(spi->ctrl);
+
+	return 0;
+}
+
 /**
  * stm32h7_spi_transfer_one_irq - transfer a single spi_transfer using
  *				  interrupts
@@ -2026,6 +2081,24 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 	return ret;
 }
 
+/**
+ * stm32_spi_can_poll - detect if poll based transfer is appropriate
+ * @spi: pointer to the spi controller data structure
+ *
+ * Returns true is poll is more appropriate, false otherwise.
+ */
+static bool stm32_spi_can_poll(struct stm32_spi *spi)
+{
+	unsigned long hz_per_byte, byte_limit;
+
+	/* Evaluate the transfer time and use polling if applicable */
+	hz_per_byte = polling_limit_us ?
+		      DIV_ROUND_UP(8 * USEC_PER_SEC, polling_limit_us) : 0;
+	byte_limit = hz_per_byte ? spi->cur_speed / hz_per_byte : 1;
+
+	return (spi->cur_xferlen < byte_limit) ? true : false;
+}
+
 /**
  * stm32_spi_transfer_one - transfer a single spi_transfer
  * @ctrl: controller interface
@@ -2058,6 +2131,8 @@ static int stm32_spi_transfer_one(struct spi_controller *ctrl,
 
 	if (spi->cur_usedma)
 		return stm32_spi_transfer_one_dma(spi, transfer);
+	else if (spi->cfg->transfer_one_poll && stm32_spi_can_poll(spi))
+		return spi->cfg->transfer_one_poll(spi);
 	else
 		return spi->cfg->transfer_one_irq(spi);
 }
@@ -2216,6 +2291,7 @@ static const struct stm32_spi_cfg stm32h7_spi_cfg = {
 	 * SPI access hence handling is performed within the SPI interrupt
 	 */
 	.transfer_one_irq = stm32h7_spi_transfer_one_irq,
+	.transfer_one_poll = stm32h7_spi_transfer_one_poll,
 	.irq_handler_thread = stm32h7_spi_irq_thread,
 	.baud_rate_div_min = STM32H7_SPI_MBR_DIV_MIN,
 	.baud_rate_div_max = STM32H7_SPI_MBR_DIV_MAX,
@@ -2245,6 +2321,7 @@ static const struct stm32_spi_cfg stm32mp25_spi_cfg = {
 	 * SPI access hence handling is performed within the SPI interrupt
 	 */
 	.transfer_one_irq = stm32h7_spi_transfer_one_irq,
+	.transfer_one_poll = stm32h7_spi_transfer_one_poll,
 	.irq_handler_thread = stm32h7_spi_irq_thread,
 	.baud_rate_div_min = STM32H7_SPI_MBR_DIV_MIN,
 	.baud_rate_div_max = STM32H7_SPI_MBR_DIV_MAX,

-- 
2.34.1


