Return-Path: <linux-spi+bounces-11884-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 479E0CBDD2F
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 13:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CA283050340
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 12:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2592F83B5;
	Mon, 15 Dec 2025 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="MqKL6c1+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AF1314D0E;
	Mon, 15 Dec 2025 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765801623; cv=fail; b=NdDxdjyDf0+ZhyBj3nQ8O8NCqrctu1Kq+jqv7dVuR0ydugEDUsKgTzQMOWa4dcMutZ/muVUOErfqvddT58PNzUsg7XdUS8NdH/kLGgUVE+gTGYcMJ+LUfQhtijY3KRJpwOm3btLZtrb5l5w+vdqAO9DEr3J1KkzlZTVJP/+RIUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765801623; c=relaxed/simple;
	bh=lFWleF2ipAyGHkKU5hIfYvll7I1f9vpCZuCLF+otjtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OszWnP8jPb2zzVnvmoifbEW/tG9hT16QuAIShonZCY2HN2LyUK6/iAMPINZpXaOxDVtWS4uNr6uDn1dDoGuhlICGN0RR2U9bi6BNPwfYXbH4v+g0VTliEYEpYCK247j5m9T5ZH3nPV3gfwWYEm0bxFzxiPwFvkqaMOa4ey9R+6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=MqKL6c1+; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFCELlT2976764;
	Mon, 15 Dec 2025 13:26:47 +0100
Received: from du2pr03cu002.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4b11dx624t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 15 Dec 2025 13:26:47 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hiicPzzoL6j28wNR/CNaXZwY6Ljg/XgkVI2+V1+xWWuMdu4UkkG4UFYqRR70rEZKZBouSlk4GsLcRwnjz6oZSUmAzyOkEtj2PtElG35XCssx6W7a+T/2AgCihnwCE2XLxDkL433ytAC7qa7iDHaV6bu37zYADD+uxAXBLo/idK7ZYm7AohxylrdMcb42i/416jZhPWBydQykDv1OkV6ft306EXqKVEzRr/6iGduZt6F/mBMU0JL84EvSf7P1PnR3tUdTVmHpZ90OqRpFhen/RnJQmx4trIgJHpQhHQ4cw1cK6Hk/dRR57FLHtYKKtt1aFkLr6tulaXFON0KATyVDhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHPDVBh0BJqkM/MdCN2rYN4jsHWOJAuDmo86LIKpybE=;
 b=f7za1x/1ovd/GPzJyQ6ds1lATmVpHi3fuUw5KxRynsFeJscJtn9Bagzp3NnzY3vMltSbeohvJcm3mug2aV0yHXM5h6Fd4Jsfka7/wn0WtlIP77iMHbg2B5i4D9MKna7UvYn1HuMQ1GtckMQjFdPnB9Pj0cz7jL0YjlRuQYWXLv3edZNN5wrrWvFWvhnB8/Gc/xHxpHmpkemZYpOW6xAIHgdBI0Gt0aBCeimSgwsEIwa0xDK8maOlgfcdcWv+b48AdzNK8joq8cqzm6QLvLaTXCM3qKScc06CvRuBAMmyX2Lhs8SSt+dP3ZV35HlcE+3uDRpASjjTnymfsdPlTiCTSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHPDVBh0BJqkM/MdCN2rYN4jsHWOJAuDmo86LIKpybE=;
 b=MqKL6c1+KGQUVuuEWgKaCLIvwlBhNgUeUgLWWLJLd+6XfFy7sev+IjvZOYcfyz5nneELArNVLBkn7HS89qgTWpYeXxvKGx0m0A2EQjLtHxPULgFN10AwiZnhcMZXQx6eKecjByt/Qc/EW6Fu+pbI08Ohhuj+xZEcngJY3PgTfNz7DDlxOA+t5O5BK1qlYGh4XH2FkRsi6CMwa5roVuYE6qA/PIqswK2doYmAet37xX2ChcBshwVQi9PPscV1F+qCiYNIw313+Msa0DF9aS5GjOf7UkzdyQ8TCRP1/2/D/CnZ6/Urq1IK43Y7dMr/wOIjWnWeOC1WNONHMGDCSFUEWQ==
Received: from DUZP191CA0052.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::15)
 by AS4PR10MB6110.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:582::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 12:26:43 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:4fa:cafe::d6) by DUZP191CA0052.outlook.office365.com
 (2603:10a6:10:4fa::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 12:26:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 12:26:43 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 13:27:27 +0100
Received: from localhost (10.130.74.193) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 13:26:42 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
Date: Mon, 15 Dec 2025 13:26:20 +0100
Subject: [PATCH 1/3] dt-bindings: spi: st,stm32-spi: add 'power-domains'
 property
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251215-stm32-spi-mp2x-dt-updates-v1-1-464a5fd20f13@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A00:EE_|AS4PR10MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: e6091c91-80d0-42ab-b64b-08de3bd534f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1NiRmJJQzhPU3ZtR1I4NWVRUnJrYUNCOG52N1ZmdVBPSW9uY21nODlmeWo3?=
 =?utf-8?B?WmI5ZjMrYktKdFhCTmFYTDNyV2NPSzdNdVVLdS9SRFBVaURKVGFtd3kyUjBG?=
 =?utf-8?B?MUxRNUtLQ1QwMDk5d0tKeTB6MG8yV08xbEhWSW40SFJwVHlzTFV4R2EySkpZ?=
 =?utf-8?B?WjFZNk9PMWFucGhXQUpBNEx5a2M1NldoTGZ1N21WOElvekpXeHJYVzl5Mzhx?=
 =?utf-8?B?dG1iM2lHS2ZtLzdLeHM2c3RxSHdEd3gwUmlIRDIvQmYzQUNLZnNJVXZ6NHBl?=
 =?utf-8?B?NTl5a0RDdGxFdUdxNWVHM01CRmhnSzBnUkdtL3Jaelc0RnJBL280M29yY3Fm?=
 =?utf-8?B?OGFWb3JFR2psQzN0RjdIQ2x0UDhsanV2Zk14Uk96UmlMUmlqcUZvdzY3blpF?=
 =?utf-8?B?V2Y3dlo1RGd5blFMa3NrN0E2eWFBRVBpM1UrYjlEWUFFQU1KQkNJMjZHaEdY?=
 =?utf-8?B?WjNKTXN5azZIbmpsT2VtMWFBWE0yVzdMKzkxU3ZUMkJqYkhIb2ErSzJHcjhM?=
 =?utf-8?B?K2tqUVkzUDhVU0Z6Z3JPNzRRMUQyYlRHMVphZW9tRW9UTGZKRVpSeDk0UlZZ?=
 =?utf-8?B?cTVzdHl0NXZkTUV4SU0rRmp6L0hBRzBTY2hrT1FzQnc1bHR5cTN6ZVkyZ21X?=
 =?utf-8?B?SUMyZ2VCd2M0bHhXekRicDExTktPbVhJcjBEd1ZhTEdDaGswYlZ5bE5uNE5K?=
 =?utf-8?B?WHQxUTNnTGREOFIwWldsOVNSdTNMd1V0TDI5ZmtTWVJacG43M0xjbS9aNFF3?=
 =?utf-8?B?YzZiVkJsdGt6K2lCRWZGK3RzSDVTQ3pDWmg2TTFGcFVSQUk3N2VTcTZ5OW9F?=
 =?utf-8?B?ZzZES3B0YUN6ZHBXdGNVU2FiS2ppNG9DNzV3WnRqOTExZkV4RUxaSXg3eS9y?=
 =?utf-8?B?cEZtb29rSzZrbFNiL3I4cnArOFZWd2R5OVNUMWtQWEc5N2Y3NitWcmNHTHVo?=
 =?utf-8?B?cjdwQU00Z2VFVmR1cCtJaTlnajYwdE5ZblRLdVJvUDV2WlZGK2RRc0RFZmk1?=
 =?utf-8?B?dTlPbGJTZ25lUnVyUEZYcG5oTlJ3L0tkTElLSFh2c25LN2JsenNKMzMzWGkw?=
 =?utf-8?B?emRqTzUzNEV1a2hWa2g5Tk9iczZrcFZMSDFmV3JkNUMrVndQVklhNzhGem5T?=
 =?utf-8?B?UlhHY2lhV2JWY1BCeHcyRkJSdEQ3MXNsdjY1eERRdWhhZGZvQ1dBRUVmSjdr?=
 =?utf-8?B?UEJxZDRhdURFRjlMdTQvZkFhZFF5b0NlVkFteHJseFNQZC9LSm45aFpBbVM2?=
 =?utf-8?B?bDV5WFV1czkwV2JZQ3JEL2QrOS9aTnFwakVBNmh3Sno0cTFSRUlZTm51SmhH?=
 =?utf-8?B?MkR1bTJ0aVFPY1RTMEEwbk1wb1FGV3AzY3gzRDgyUmlBbUsyMG5Mck1ZWWZh?=
 =?utf-8?B?MUxnNW5OeVVoc2F1K0YzSSt6TmRLZ2dOZ1VsU3dybzdUVXdCN05yb2pURHJL?=
 =?utf-8?B?TXBSMDJyWHZjTHJjVkM1NUt1QjZsb2JacWtKNFFtOTlxanZpRzJ6N0hOQVBu?=
 =?utf-8?B?RHdBUC9TUEF1UWZIMS9tK1E0azF3eGQxNUp3cXYrVGxlRThuWVcxL09GYVFo?=
 =?utf-8?B?SGJVMndySWw2aFliQ0JJeVFDUlI0bnVsQWs4dlZvaTYvVjVhUkdvSldIdHM5?=
 =?utf-8?B?WXpxSncxQUU1SEY4V2M0Ymp3aHdGeHJMWWw2cnU3c0M5L0k2RjQvTHJOL1dz?=
 =?utf-8?B?ZERicmxGVzMyMGNwcmRrUXZoOXN5VWRJQ1RKSjA4UXBqWFhsK0pWd2VEL1dQ?=
 =?utf-8?B?V3ZudHYyZUtkVVU4eURlMmVOT3RhUUVNV0FUNlE4V0ZBS2pmT1BJOFVBTTVo?=
 =?utf-8?B?cXlRMUl5SHhDbGJzRE9Da0hrK2k5b1lzOXprZllzN0pjUHV6Z1BZaHluRnpi?=
 =?utf-8?B?Z2d2UW1YS2c3Und0NHhBZ2p0RGNaZXJFWkdyb1k1OTNrbENXbEFFREhNeExW?=
 =?utf-8?B?b1ZSdnBNSy96eUJqMU9tWE5lR1JPdktWK0xqMjR0eTh4OFh3VkhrWVExcVdL?=
 =?utf-8?B?WlpXWGZ1OEU2MnY0aVJNL0VYNjZ3UThUNVI4SG9mbld4WDk5cHR1enhnQTJa?=
 =?utf-8?B?WEc2VnNmWlA2em5uVXN5VWJOc2VFN1pUeHh0YUlrbzZ3TXFzUjNQb2VCVi9E?=
 =?utf-8?Q?GxKM=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 12:26:43.4722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6091c91-80d0-42ab-b64b-08de3bd534f5
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6110
X-Authority-Analysis: v=2.4 cv=PLsCOPqC c=1 sm=1 tr=0 ts=693ffe87 cx=c_pps
 a=GWnjdLoi7hWW8E7zIUJB4w==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wL9PcE0S0AMA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=jVnx1S62xqOjl58bLOQA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: Qyyo-TnTq4KDfc3Dh2yxhltclC1GpuiP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDEwNyBTYWx0ZWRfXw0vZZJ1YZrgq
 pA3bh/oskH4Z+c0JzmO8LOz1Svaptt40Fv0P/Z+9tSyvjLLkV/L96RVmVJEufS2/TU36jiGncJk
 XQ9DF3IwxBxdrJUvS2pOYL0RASv/4aAxrS9Aqcn2i6LDrvH3+Hj9pibmCt0k69MWVIVqXFiNBYv
 cbRCVqVOSRjfvZaDi/si0aTG4YrG5zFoPSOICBnTRJzyM7YE5qilQjg3H6n6EaCKFK5OmA1bWXt
 EMvm/7xC0vpFXNNTpDJK0qKKBQOBC67ItBOyz9uZU/KGLDcWy2JsrjBU/TPLjX0r6fzJ70+87MW
 CFKWLlTyT48wuP4hs4Gwc1soU0rDXx4OdGuStlzDTmQ+cGV5Bg29JKRysvTzwp1bccIUkNJp3HF
 odrC1XuywS4vwdlM+E+D6XC66Mmobg==
X-Proofpoint-ORIG-GUID: Qyyo-TnTq4KDfc3Dh2yxhltclC1GpuiP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_02,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512150107

STM32 SPI may be in a power domain which is the case for the STM32MP2x
based boards. Allow a single 'power-domains' entry for STM32 SPI.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 Documentation/devicetree/bindings/spi/st,stm32-spi.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
index ca880a226afa..472e92974714 100644
--- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
@@ -96,6 +96,9 @@ properties:
       The region should be defined as child node of the AHB SRAM node
       as per the generic bindings in Documentation/devicetree/bindings/sram/sram.yaml
 
+  power-domains:
+    maxItems: 1
+
   access-controllers:
     minItems: 1
     maxItems: 2

-- 
2.34.1


