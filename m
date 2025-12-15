Return-Path: <linux-spi+bounces-11882-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9E1CBDD18
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 13:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C05E302106C
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 12:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95692F83B5;
	Mon, 15 Dec 2025 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NGW4R4gE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A002C326F;
	Mon, 15 Dec 2025 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765801620; cv=fail; b=TFQxd8zU6PTINo9jPUW1YgvXTfZrv/lPnvPZZZgCK1zFBEVYCFmRuDtPgzQjL6ppJ7t1ltKaRqYQH/cQvbGa2r28WdJwzRC5c8ipcpJ++VjHHk1+KXCwlUYTaP4R/cdfpZUT0ctO2EeZTGSSYnMp/qXtQSY2qqsJd515VZg5NF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765801620; c=relaxed/simple;
	bh=XBlWtyyre7oS0N7wt93yHJ/Dp8aTXK4xTMiQl3fd+xA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=udp16cbFRevJVRvL8IObFej3bD0dHoHwePdq8QLAVzPVw1Ngr55AP4AH+DioEWaHsVykASGKoWSEWaMxsW6AsQELT94YsqBaw7B6Mklsr2Ib1UohVXDXI+xlcLusFUNy8IdD0iR+XmKA1Mdx6bKc4Wn7E4iSmYh3m2oaoeFN7rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NGW4R4gE; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFCETiB2447981;
	Mon, 15 Dec 2025 13:26:48 +0100
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012018.outbound.protection.outlook.com [52.101.66.18])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4b11gae1b2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 15 Dec 2025 13:26:48 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTwSP1TZBKrkGkkxtbj0fj0WPKjsdLnRd7bXoFvoM8SIi4nPgfGgpsVTwiyqOkHfo/+hYgEZ0HrKe2dUyxTNadsj2EHH4b3hTsXRhlv16WahFB/Q3DW2fxq5mCIhDPm+9169TYZzcZlwF02Cr0ur+LSRZGzZLXl43HYEdpKi3iBYirXZjfK3oJmGH+ShsH7nVbyyFSBUyU5VKHirLnC6pZAxRZiAnE1KOPcc/eoWrA7MiG/AMUf6fgK4v8bWZm28TJ9PuHylkCkMvIKkRUxvIHZ01EOmjOkItukQbxqJvKlrRFtsCZU4/9Ok5mnbVrHe9QnxHThirnwVJGs4a+7KqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDrpH6gOv+bP6m4hB5BYA16gWDRg/cZroTTkm26GdGo=;
 b=OlSd5chvCKa0nuZ9EbTMKDTpvx4DUQvK3DBcj5uEt92hyvzoXiVEKGRM5k83K90wD15Xaz5jDz/5oBE4BoVOcZlvbGS213Una+rb9DWEaiYe50SPSCupoD0QQ2w8kr8baAlkvZhF1RbGZdPH+Laq65yW5KPgr8s85MJ/GC3cUdtx0i/lXj4yzAWsm7YTXUgZn+70OOkMQnddhXCmzne9KleVvCzaSDdeXc2G/AA2Raaf8JL58fq39wpvh1Ctd/A/EcDjozmfgZco7RwcP0EcF7poSyRTzYV9ULDx/PWYmMX2ITSE4L+04Pl0PQ2I1z6Q2KLJEkEElMguJIJ3fPcGHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDrpH6gOv+bP6m4hB5BYA16gWDRg/cZroTTkm26GdGo=;
 b=NGW4R4gEM8NwiOH8whmR3JAjfC74+6OtK9RZRAAi3333upAhlx6Zgbf6PPqgfha9PUd20ExABtGpkXay7jd0Y1EbvfTpo1BBKkS2OAOBVNxszxZfS0jpFhf2Y6sLN2LVJrYZBUxCjtEkZWhl3cP+BDfZ8S57Lvd8W5GMEM/wMjANkbbxcNLm6y3RXVMr1glM/BYGpNZP63RozV71exsMfhvRd3GoUF3pxTRRUCsmWZSlvN6vVGUizQXukiEEJq4d046f4gxRdUcUO7jau4TjU0RJTcJTvwlPKhids6113TYAWG+FzhSwvx645rcPFhR8sn9XP7sG0cZt2CqOQ3A1qw==
Received: from DUZPR01CA0189.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::7) by AS2PR10MB6638.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:55d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 12:26:45 +0000
Received: from DB3PEPF0000885D.eurprd02.prod.outlook.com
 (2603:10a6:10:4b6:cafe::8c) by DUZPR01CA0189.outlook.office365.com
 (2603:10a6:10:4b6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 12:26:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB3PEPF0000885D.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 15 Dec 2025 12:26:44 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 13:27:30 +0100
Received: from localhost (10.130.74.193) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 13:26:43 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
Date: Mon, 15 Dec 2025 13:26:21 +0100
Subject: [PATCH 2/3] arm64: dts: st: add power-domains in all spi of
 stm32mp251.dtsi
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251215-stm32-spi-mp2x-dt-updates-v1-2-464a5fd20f13@foss.st.com>
References: <20251215-stm32-spi-mp2x-dt-updates-v1-0-464a5fd20f13@foss.st.com>
In-Reply-To: <20251215-stm32-spi-mp2x-dt-updates-v1-0-464a5fd20f13@foss.st.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Erwan Leray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Alain Volmat" <alain.volmat@foss.st.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885D:EE_|AS2PR10MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e0430a4-3d3b-409c-7fa6-08de3bd53588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEhPVStBdE5GZi9icUd3NUttUkRnclVISFNkcFpBQjJKNzJHVldRM1ZpK3JI?=
 =?utf-8?B?Zm5JY0Z2THMvR3NZSE9McmlaUHpBazlhNFRHdzRlMjFhRzdkOWt6OGp2ajFu?=
 =?utf-8?B?SitMTWNRdnFSZ2c2SmYwUXhZc1R3cUpGbDd2YUM2bGZLRmVpcGU5YjBjNlBX?=
 =?utf-8?B?M1VIOXdoeFZud090cUR6UmM3UGc3SENOVlJ1YnBHYjk0a3E4QlhZWUpxbCtk?=
 =?utf-8?B?WFRTeDRnQWN2WlFTRmJ5WmliaGJCUWNuM1Izb2xHa1dmZkQ2K1Zub3FjT3Np?=
 =?utf-8?B?L2JOQ21IS3FtMitoY3RVbXVRRUd2TktlRTRoTS9IWURmV29NK3ZlRmlaSU0w?=
 =?utf-8?B?WER6VWw0QWlTUThDek5Oc2V5UFFCTTh4YkVCN1V2bU55ZkJTc25NZXVMSTNY?=
 =?utf-8?B?RlFjZjdFVVptVmE5U2c1QktoREZhdFJXRVRFSm9iZE9BY2JUTHhPWTBOdkx6?=
 =?utf-8?B?TWVZcDN0L2pXQmVMQmhYVDNheE9jcy9zdTliUzVNQ2ZNNHA5MUVLb0RGYzMx?=
 =?utf-8?B?Zk81Szg4SmR6aEk1VTdNMHFCUWJWOXpwMDRiQldFaVliY3lMMFZDUEROM2pQ?=
 =?utf-8?B?RVFJQW9ROERoZGxxTE9DeTJhZ0szT2tZc1VoTnlsVkI4Y2NiMmdpRHFXazBw?=
 =?utf-8?B?ajJNV3pwOUdENmtWUGdkRFd0YnJsMXpyUUVheXhMaHhIZHMzUmJGWEszdW16?=
 =?utf-8?B?MGpKY1p5RFNNTzNPQ05FR08rb2ZsVVl5dVcxZllSZGU1cGdjYm1tUE1mQU9v?=
 =?utf-8?B?a0U5SUhUaHEyeWE2Nk9kK1F4NGd5eWlyYVFoeHgwVWZ3YUVMZFJ4TmVndEdi?=
 =?utf-8?B?ODFpVGFEN21sbUVLeVdyamV6citaL2N5RlBmYjFnOU0zK3cyMDhCWE5WSlMx?=
 =?utf-8?B?ZDh6MjA4WVYyNEhidEFQOGF0SlcvTUFHVDJOcTg2NDl0QXZrT1E4THRFa0lW?=
 =?utf-8?B?L2lSNEF4cVc3bXJ1amJiVzhaWmEvWkdNK1FWQ3dLb2gyU1drbnFjSUFPRDJk?=
 =?utf-8?B?bmtDbHNFVTl3OVI2TEJuajh6SWdjRUM3cWxaWHpUV3RNVFZCWEI5NXJpRnl0?=
 =?utf-8?B?R0REWkhQZUVqNm5VVmZVSTBVZFp3SS9KaW04YnJJUnRUbFdzemJjUUpCelVm?=
 =?utf-8?B?RUhudmJFcDFyRVM3enVyY1dJa2cwVnYwZlVab2VMUDhuRVVjRndhVko0VjNI?=
 =?utf-8?B?OUY0SW9aOHJ3bmlvY2M0cXZCVFc5L0pERWF2a1FrbkR5RlVOdHBkNnNocTZJ?=
 =?utf-8?B?M0JkeGdzc05qRWtTZzFQNTFjT014Q1lKZ3o4VGhlU0s1Y09NMFphbkF3UFl4?=
 =?utf-8?B?bG9rbENoNkVKZmhUMFgyc1RlSkNxRXdBWWorclU0c0VEcnUvMzhvR05rSUQ3?=
 =?utf-8?B?cmVqbk9GVDFKcS9wa1N2WXk5RUJ6NVNaSm1MaHB0S3Q5eHNUTzRSdWFDUERI?=
 =?utf-8?B?TDlIMjEyQ2I5bzQzSWNuRDNrZEVmUVk5TWtJaGFWTlQwOE1mVWQ5UWcxZVY4?=
 =?utf-8?B?ZTVjOG13OXN6WDladmJLcWp4MVQ0NmRZMVIvV3Y3VlkyQ0UvTGdhMlVpQU80?=
 =?utf-8?B?UW53djVCdXJheTdybmV6UHg3dWhOUkhDSlRFRHJYOU5lVlk1d3Rld0EwWXY3?=
 =?utf-8?B?a2ZSc0ZiaEdXRWdpcDFOb3dDU2hIS3NvTnp1ZWdwMGFVd0tiNjYwVlJaT1hz?=
 =?utf-8?B?QXJ2VndHMGpzejFTc1RwajcwSGU0d2JRZExkSENJWk8zZ281d3FvWnd1MWNv?=
 =?utf-8?B?TnJnYVc3dDVFN3k5cFBNcFBvT1EwMzBobFgrVSs5MnFiUFN6Y1BXMHVBenJy?=
 =?utf-8?B?UmtBV3Z3UW1RMXk0YUZ4TC9LVCs4T0ROY2I0Z3FJQk5RZjNXZzNlN0hGNEgx?=
 =?utf-8?B?TXhZWEg3SnI5UjFWcjFmaS8zc21vWE5XbWNCNENqUXY1MCtzK1dTMUVadk1V?=
 =?utf-8?B?aHM2RmNSMzJtNGpxU0R1eDVERGs3YkNTckpLbFhLaWVXbFpncWNFWVIxM0o1?=
 =?utf-8?B?d1d6Qyt5SXE3bFBWdTM5NkFveldwSmU3MnJ5dHlBZGlvQW9RdjBMT2k3bm9M?=
 =?utf-8?B?Y1Z2TnRQTVZydTczVlJrSE9tWW9DWWhUZzVkWUQ0bzBmZHpMNU5xYkk5Y1Fz?=
 =?utf-8?Q?j38Y=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 12:26:44.4306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0430a4-3d3b-409c-7fa6-08de3bd53588
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6638
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDEwNyBTYWx0ZWRfX7SjtpoVhVIRP
 E7u3jTwstiIACTKUmYFKV6YV8dIqOsCELkaqMi64GN6l4BQNXPjqfU5eOZymnvkmpdoMn2QSN3B
 z/T2sNTi+GtMbBb8OpzXVO5wnXYi88b1eJutXgUSHTmZYAdQA9rTMQ31Nsk194sJN+wcZDS4HPz
 0Vx8KgTWFQnRJAdS+QKYHfYZQscgFEujN22p5YwXOeaef4PKjIezougxLvK4Bj1Zv+i4nYWds6h
 bBqExWjdhqCbDCqoZMmipwK2X57QtSCHkNEKRPD1F+0+L+vN+6lWBEl23kOnk2YSYIAREV1r7ZQ
 KIMUtfTOIuxUKKd6sRl1KMk4Vou6qHVjP9zVg/tzTO4WiejRb5SHwrFNuLzLRpiAX51NjOLhB43
 FpiDodYwwiokQuxQuqQMbtYp6zCWtQ==
X-Authority-Analysis: v=2.4 cv=AtvjHe9P c=1 sm=1 tr=0 ts=693ffe88 cx=c_pps
 a=6Uyp6RSWOiYq5P6bN3pzmg==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wL9PcE0S0AMA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=mJLvvUiAAxR-HtdJyo4A:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: QT9rsT5goAdZbdxPDfaXB4shNjoJUhuk
X-Proofpoint-GUID: QT9rsT5goAdZbdxPDfaXB4shNjoJUhuk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_02,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512150107

Add the power-domains property in all spi instances available
on the stm32mp251.dtsi

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index a8e6e0f77b83..64c3487b3cda 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -672,6 +672,7 @@ spi2: spi@400b0000 {
 				       <&hpdma 52 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 23>;
+				power-domains = <&CLUSTER_PD>;
 				status = "disabled";
 			};
 
@@ -702,6 +703,7 @@ spi3: spi@400c0000 {
 				       <&hpdma 54 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 24>;
+				power-domains = <&CLUSTER_PD>;
 				status = "disabled";
 			};
 
@@ -1048,6 +1050,7 @@ spi1: spi@40230000 {
 				       <&hpdma 50 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 22>;
+				power-domains = <&CLUSTER_PD>;
 				status = "disabled";
 			};
 
@@ -1063,6 +1066,7 @@ spi4: spi@40240000 {
 				       <&hpdma 56 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 25>;
+				power-domains = <&CLUSTER_PD>;
 				status = "disabled";
 			};
 
@@ -1171,6 +1175,7 @@ spi5: spi@40280000 {
 				       <&hpdma 58 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 26>;
+				power-domains = <&CLUSTER_PD>;
 				status = "disabled";
 			};
 
@@ -1380,6 +1385,7 @@ spi6: spi@40350000 {
 				       <&hpdma 60 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 27>;
+				power-domains = <&CLUSTER_PD>;
 				status = "disabled";
 			};
 
@@ -1395,6 +1401,7 @@ spi7: spi@40360000 {
 				       <&hpdma 62 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 28>;
+				power-domains = <&CLUSTER_PD>;
 				status = "disabled";
 			};
 
@@ -1444,6 +1451,7 @@ spi8: spi@46020000 {
 				       <&hpdma 172 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 29>;
+				power-domains = <&CLUSTER_PD>;
 				status = "disabled";
 			};
 

-- 
2.34.1


