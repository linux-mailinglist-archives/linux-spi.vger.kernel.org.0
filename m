Return-Path: <linux-spi+bounces-11992-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA79CC9A42
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 22:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66FFB30456C8
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 21:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75A430FF3B;
	Wed, 17 Dec 2025 21:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="M8Mul7Pq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0747D30B52E;
	Wed, 17 Dec 2025 21:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766008376; cv=fail; b=IlKMfgKdfp8roONjo8Ms44ONoEjYxQaZMk1BCnqVkc2K3cOt7rBVISjUPp3bXnmXe345Fas/YgEnhqky7jNiCWOhB6ZvoFnXPOSCGMLFwjM6FbwXjDZRBShvjyUETSR2qWtA6Ht2hmiWj1EoTSt8m2XLfrWJHRrpmvwFz1nvlNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766008376; c=relaxed/simple;
	bh=iwsekyuCxhuAUUEi4ywIJT+XZe2+ADFbXVDbxMJ2pmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BP8qDduKdG0b5XnwiytWAvLTVXeH3of9uaSJm0p4X+DgkQGbwwt0SzRc7WC/GQzB36Ko/cUzHE/GuZqNrMgnwWQnXPGwrBExtMMI5e3bSX62yGZio2efjZd9igsA71WIur2/Y45fH9gdGEX9LKGn+6UUhnIRYEEF1nWBLm4drwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=M8Mul7Pq; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHKqKiF3919858;
	Wed, 17 Dec 2025 22:52:45 +0100
Received: from pa4pr04cu001.outbound.protection.outlook.com (mail-francecentralazon11013020.outbound.protection.outlook.com [40.107.162.20])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4b3a3wnqp9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 22:52:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1jx+wW8mgK+uyeisZDeL275ygVrtL8RiHH9Z+omgCBuvaoy0bZb583vRz9uMU/HIEXmo0JFjZV26W8ayQQiErXD/g//aa5Bv6p4AykWVN9H1hTtDcZTvyxICwlHO5J/44D6uB7yc7eRAZxrSzAU8LSZHwtlrMFO4rIkfjwyg+lsoL2pHjxMn8qLIeoAtVmGqvvzKU1jY9cZYKtLv8wYG8g6FESf7NChkBuLKzGmg3OXqg5tJVlZR8XkiCRlb6db1o0nsRVs8HFZ2LHgwJPr79ErBX4UtuaDUqcFhLnwiMskRIACsTB5rOzYvRetMbHRw4n/PyPzgp+uJq8X3e8w6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cP5IQAiPQx4GiPlg0zcP9mTsfVP9QOaAkQmdRQjzl1M=;
 b=FiZs0PcdIgWHOFLhkmh0+DXH9Q8NL6cwwGcyGCZkKTdYNe364hTVmF6QOvPUPNRQc+VOgSLNO7YPSLZogV1Kebff/OLbc8yNFx4NBru+V350k7YZmRgnP5e68P2ItxpmxGg8AexVVS1vc91oHLedrUhR8YEeVMcfnQZQQtTGXODrWW9s3zdNeW74JzMgJ3HngWmC/3ieOGxlCdOf5kwecsRSdK1DeEcAM4sn2GxmH6VLeGAHk7iHf2JKT23lz8DVkNLifdTJS+QvQ4HTj23g8PH79ys1eZzO+b/r4e4afcbGRfCT4h0q3y2V2cBECsy6Doud2Cm6AZ3TAo+B35PLyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cP5IQAiPQx4GiPlg0zcP9mTsfVP9QOaAkQmdRQjzl1M=;
 b=M8Mul7PqyMKY79vbpDf4KNL/CT/6MPcrWVIfG2xD+37eIbKJM13yAiB38QmNdwxBHl7pqfaZAW9ln+YOpNOic6C8NstRpMbjA58oL97SF+ItK2Fwuyx8Rrpprj+X8gNiKk9S1ptM/OFTcdaIdmfmgDxcUkKwFG/0yyvneTVhlQDYI7PKfOLXa9SWhyFy9y6x2kO1O8KvAwla9MpDx50v0eKYKmSXTky2x38CG1fH1cg3sTyBUkILLh6GHRmTV6YDyfqblsg+B4zf9LqVk70R1OUHVTAa3Sz7INlt3ZiADC9HGxYXfda2PGgFAde3hgcBnnhx3vDLxUbUglGP5dLVOA==
Received: from DUZPR01CA0054.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::10) by AS2PR10MB7659.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:643::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Wed, 17 Dec
 2025 21:52:40 +0000
Received: from DB1PEPF00039233.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::f8) by DUZPR01CA0054.outlook.office365.com
 (2603:10a6:10:469::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Wed,
 17 Dec 2025 21:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF00039233.mail.protection.outlook.com (10.167.8.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 17 Dec 2025 21:52:39 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 22:53:27 +0100
Received: from localhost (10.252.10.67) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 22:52:38 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
Date: Wed, 17 Dec 2025 22:51:31 +0100
Subject: [PATCH 1/4] spi: stm32: fix Overrun issue at < 8bpw
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251217-stm32-spi-enhancements-v1-1-943348b8ff66@foss.st.com>
References: <20251217-stm32-spi-enhancements-v1-0-943348b8ff66@foss.st.com>
In-Reply-To: <20251217-stm32-spi-enhancements-v1-0-943348b8ff66@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00039233:EE_|AS2PR10MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c51bd9-cc9a-47b6-4175-08de3db698dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTlZS2Q1S3NuMlRqYlZVTW8yeml4dGFvVlB1cUx4WkpJU3NiL2QzUXVqYkxu?=
 =?utf-8?B?TU5VT1BpTjhzdk9PRlYxOG50MXUweXBEVkljOFR5NzRWLzJoWEtKclJwbGQz?=
 =?utf-8?B?VzhWUFlwbk53amV1dFVqRkpZS0xMNTlsZytSVk94ME9WOUxtbjJ5WDUvWlNN?=
 =?utf-8?B?MXpGNERHVDd5WkJ5cXgyZXRNaWlYa3lBWGdpKzJjQXFvbVVON1JWOFU5L1VG?=
 =?utf-8?B?UThNV1I4YVpTZWdpdnJwaDJ0TkFkUnhGQ3k4c3ZoRHRkYUlwL0xSTklYYU52?=
 =?utf-8?B?ZmNzTGZIUlJKWjZhZzVGWjNtbEZHcCtFQlN4dkJ5UTc3WFZqTGtLSDdzRWI0?=
 =?utf-8?B?ZmljU3hiMVpQaW5XMDlqOGRoUkRleWJpTXBPYlZSS2VGRUErZ3NvS09SMWpj?=
 =?utf-8?B?M25zN25mZmtiUTZEdmRlRm5ucUQvNmJHOWdmVzJ2b01UNTM5OGdiVERUZW13?=
 =?utf-8?B?amRZOXZXR1M2SUZweXl0SUFOMTk1VU1uU0VpTGRUSHhIM1M2YjU5NU4rTDNT?=
 =?utf-8?B?YVA5cEl4YytSQ1RuVTcrK0xSNmZ6aUFjNnJ0WHVPa0VuWmhQamdVNS9YczY5?=
 =?utf-8?B?OFRkMktsSDZRZmQrNWJmY1NOSWRmdGhSRXF6MFZOeWxkY2tkMDJueStVQWEz?=
 =?utf-8?B?MkxaaVlZbU8zQUQvMDFMZHR4eW5GcnFBMHk3dDZ6K0lBZ3lKOS9PTkIzM2I2?=
 =?utf-8?B?eUFkbEJ6QTVQcWY1OHNVZ0dIYUpPSGJaSVdTczlVVDRvR0JMOGV4TDdIY3hk?=
 =?utf-8?B?QUhCbTI1QTZzYm5vWThPSXp3VmJwWGZIZ1V4c1hmNGw1RjlscEo1TjV0VEk4?=
 =?utf-8?B?ako4MVo3SGx5OUJZWCt0SmR4QjIzYTdsLzlPcVcyWnNOL0ZucDRPOXcrTTZp?=
 =?utf-8?B?NzdpcUhaclI3Q2VVL0N3aVEvSk9qQ3RrVmswbm1FbzlPeHpkWmZxdWxBUk9z?=
 =?utf-8?B?R2UvelByZGVvVUxhMHBrTFN1OFBHREx2dUxGdnlaclNoUHRUSGloeXNPZTBz?=
 =?utf-8?B?OFVoWmZMTTNGRjNwb0o1QWJCcnFFb3REVnMrREc5bHBOZ3RoUFJhUXg3V1hw?=
 =?utf-8?B?Q3N0RDA5a3d6aWVYR256bG5XTnEyL0llVDMyc1AzSGl2N1VDMjE4TWt5aEtZ?=
 =?utf-8?B?d1lYaUNtSG1DWUhxMml3TGxnTmtlUmxCay9wQ0hITHlpS2kxVklyN2YyQ2Jo?=
 =?utf-8?B?Z0V1SXQ0NnRmTk54NjY5V0dra0hsN1M5c1ZYWEUvUlNSRUVFVW51MnJxZE5D?=
 =?utf-8?B?ZnFsdHlGZUxlbXZxeVI5LzY1M1V4NUZUbUFyMXZQUFFFd0I4eW0wdVpMcVBw?=
 =?utf-8?B?aURZWjdwNklGaXVEYVV0dVhBZzBIME5tcTl2dzdVVW94TGNPQkNqUlFQRmNU?=
 =?utf-8?B?MEIvWjVLbmRKT2hHbFJlSk5sVVVvTzQ2VjZGQkkvUUVKTWozbmZhMURSUWRo?=
 =?utf-8?B?emFmYkJDbDFYVkxMUXNNL2dSK1ZFMm5IYXpTaXgwejdGQnFCSlQvUmJUZS92?=
 =?utf-8?B?eXZMUXRvSzhpM2hIbUxwb3V3U0YrbGlhYld2aFE1cVZJMHNNUS9uN1ZUSjFh?=
 =?utf-8?B?M25XWWlFVWd4MEY5ak1zZFEvUUZoMGNadXVyTWNCQWNHRzFNUGRVM2JvSjhJ?=
 =?utf-8?B?ZHRaTlpNYVVjZllCVnk1VnRHQUtObHBGZXdYZUJMRzBILzhIQkxjcERSa1Zi?=
 =?utf-8?B?T3RpSWZtV0NLZUQyOUFMSDFaTm5ncHdKVmFLMFBNMHFTL1hreVUrbFd4aWVo?=
 =?utf-8?B?VGN0TzhlU0JrWkoyNXZLSVZkNlYySUdUMjNFMCtPWFRzNEZ1RFRGZGJBYmNY?=
 =?utf-8?B?bjBxUWdXaWhEamxlbGlpUWlzR2ZOQzFxUmZBQXkySklhSFNRVWpDR1lSZTEr?=
 =?utf-8?B?ajlTMVhFTHlkVnVyOVVzbEliVVkweHlQallpM1FQUytrSUJDbXpWU1BZNlBF?=
 =?utf-8?B?b0loZjUrc2pDM1VMODBqMDQ3UDcycDJ5TjVDUzJJd1h3bjdCWG8wRFpGNSs5?=
 =?utf-8?B?dmxBZ2N4TDF4Vmg4TkpqOFgrcXIrZ2dkNzI4Z0owQWJKbjJiM3Nqemp4dTFM?=
 =?utf-8?B?QkszaDljQ0M2RGdiTDFYRkxISDRQWllpWjlIUVJIWjNyQjJoZk0wYm1kR2hs?=
 =?utf-8?Q?Lkso=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 21:52:39.0010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c51bd9-cc9a-47b6-4175-08de3db698dd
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7659
X-Authority-Analysis: v=2.4 cv=HLHO14tv c=1 sm=1 tr=0 ts=6943262c cx=c_pps
 a=KLgfLrvyo2JQOIzkxevRWw==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=tougUffuSCAA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=XWWnaGIsyUaM4A8MAfMA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: L6E8fbCZ07w2P1aH_Tcah-Hsggsa3thw
X-Proofpoint-GUID: L6E8fbCZ07w2P1aH_Tcah-Hsggsa3thw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDE3NSBTYWx0ZWRfX7B6s6Uo5L6Nq
 pvRHCf2VpSArz7R5xoK4myBDYYnsRezSoCwgqFrxjwlea8w3QtWc0btIh31BKdXBw+WvPIBZsUk
 nfDuRcRo+myQnbaP7TF6p8WDM5D+XHyed40bfjkl1S1BiPy/NBDQu5fz0wbUx8oEaqXHZYbwOyr
 CfcX+1NyPF7DB/LwL3VsrYnTcq47FtmAKhlfctwV2FZDSpnPxlyaKgT7X/eMF8CoA/ubx1Elkk/
 jb1ME4BNpkn7eZxyUEe3ozx6x+BhdeBbZ93BtM80c/+Wj/uOzwwPcCEkNoR41T8mtUSTOD2m1ja
 pN4hikzA8myeoDVWRqu0RtQU3PHCnSgA1xaYfnH9hDalx5ywSnDKD2Fpo9bTG4Pn8hsVH4UPPhx
 BZQRu4NXya37PNgx85JK/Q+qwKlViA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170175

From: Deepak Kumar <deepak.kumar01@st.com>

When SPI communication is suspended by hardware automatically, it could
happen that few bits of next frame are already clocked out due to
internal synchronization delay.

To achieve a safe suspension, we need to ensure that each word must be
at least 8 SPI clock cycles long. That's why, if bpw is less than 8
bits, we need to use midi to reach 8 SPI clock cycles at least.

This will ensure that each word achieve safe suspension and prevent
overrun condition.

Signed-off-by: Deepak Kumar <deepak.kumar01@st.com>
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/spi/spi-stm32.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 2c804c1aef98..80986bd251d2 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1906,11 +1906,12 @@ static void stm32h7_spi_data_idleness(struct stm32_spi *spi, struct spi_transfer
 	cfg2_clrb |= STM32H7_SPI_CFG2_MIDI;
 	if ((len > 1) && (spi->cur_midi > 0)) {
 		u32 sck_period_ns = DIV_ROUND_UP(NSEC_PER_SEC, spi->cur_speed);
-		u32 midi = min_t(u32,
-				 DIV_ROUND_UP(spi->cur_midi, sck_period_ns),
-				 FIELD_GET(STM32H7_SPI_CFG2_MIDI,
-				 STM32H7_SPI_CFG2_MIDI));
+		u32 midi = DIV_ROUND_UP(spi->cur_midi, sck_period_ns);
 
+		if ((spi->cur_bpw + midi) < 8)
+			midi = 8 - spi->cur_bpw;
+
+		midi = min_t(u32, midi, FIELD_MAX(STM32H7_SPI_CFG2_MIDI));
 
 		dev_dbg(spi->dev, "period=%dns, midi=%d(=%dns)\n",
 			sck_period_ns, midi, midi * sck_period_ns);

-- 
2.34.1


