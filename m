Return-Path: <linux-spi+bounces-11357-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B754BC704F2
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 18:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id AA3762E99E
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 17:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53CB2F6929;
	Wed, 19 Nov 2025 17:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="QjwlSAsx";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="IerQMnv5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C4636E54F;
	Wed, 19 Nov 2025 17:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571865; cv=fail; b=oVTPU82nfqhJ7Q0UbdRJqIqJ12rcVfiFxBke0HdaaMQypK9QJGwCxTOf+Di8v0TtfRVT01CRWI9HFqXIe0QjA6vJj9wKVXN4NPNDteo0GWvAzpxlJlX0jB6TBUKRIR/u0280asf3c2d87Vm8vMFOEdnQtc3gsFbbYiSBfmK5Lec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571865; c=relaxed/simple;
	bh=iVZjNbrQN4jEQpRT5sU9wj61HJrKWk4oM2C28fdvoCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niyuiyElXJnepVqNjIYaJasVaQ3hcxh7DaNwDMxotrpv2PiZ0Lhg94d7lEgV3woxpg1Lz3v0oBSWlJlGg9M+/N7RZaZBQ3WVTkN+7dJV5SPR/yS3YjrhOPIYJarGnI8OGuhUDdMYXqoC7zWNHcxCpcf1/s+gN4GE+ftrBf9DM1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=QjwlSAsx; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=IerQMnv5; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ5ekKS2326160;
	Wed, 19 Nov 2025 11:04:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=S83t1ysTg1+Eh9b/HeLcYbb5MmYGr0qsuCDupvwEW8s=; b=
	QjwlSAsxTQnTOkJE8EV7WD6wKTHmH3uRrqzACfsXixnpnbqPoLdmidxC/3KK/WA+
	JPoPFHmU17X6FI8wKyKXqNQE/kLbPCiQKFNODnZYaAfcHIugMp/Bf6999k3+xYTt
	gLGnjAS46O7AKtENFLPYLrMTbokwEK/raD2oTRDdAm/AxgvryMiAq2WtBcp5DXvh
	AswO6xKy3Eq2UvJOf02dzMNwdTg208WyJr6La49Hs+Iy0KhniZwngO14PlbASBOt
	CYOq1WSWwExLU6eW6GgaYkHp47m86xXdES1XFtSde0LGiQFufnOX5efYjGNCDXrz
	TJD9U7+NlZgTgAUR2U+W5Q==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11021087.outbound.protection.outlook.com [52.101.62.87])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4aeqt1d9wp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 11:04:13 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utfv3PQooUdGqJ1dKpQg/hm2Kph0tqX6ABvOMnQdZlIZLJRxWmyh6OcD3Mqknl0LC54VVUNB/0U2GznzjdNMyO/lFYLcX96cXbDNynsiIuX/ZnRnPK8XFa2aNFRtboBiJLuKAQwzoa2dJC6x0VNca0rflJ8fkfHCTBviAcNwfRUU4kXoWPkKpalT9L53naxp+uWJDprB7PL6IpmKrdRKA3/3npbBscWo2MmvddkStmQzZqtNHQwYb4a5PLcbTZTtVtiF7ZYYRvK6NdKnMADexn9IqJfwMPzpQz0qqS38fSep87GwVMAIdjGmKbcpG1e8FBt1/Y0rM9JMnBjhSdNhHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S83t1ysTg1+Eh9b/HeLcYbb5MmYGr0qsuCDupvwEW8s=;
 b=D1CMe3Qdp+abcHs+cHlOXY/Pk7nzUcHXJzLPg/8LF+PJT5Wfo1DRBxFjCTwViVZ08mz2aMKd7EuzKe/aG6ItvO0hn9eZU5wqBbpaYzaDvyW7Jno9W/XACwJRWDeQ5jP/ZoggzpEkGv8M7tRAYEJP2/6VuMm7Iymg6f4xXC7HFbXRM5tUSbF6X8wPpsZ4fSVBeUpeninvScxkVj00VM2fnktdUxbTR/V+h9rTvLAnhsliZ8z0qQoAvRgGQPXwebtlpAvZBCQvJLTDAhX0pVm8BS3HfiZGZ2cqsaBYqeU+oaWt7WQT6pqv9ZLqkD2VVhv1urUBTnGoNjLNlukyzEJiXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S83t1ysTg1+Eh9b/HeLcYbb5MmYGr0qsuCDupvwEW8s=;
 b=IerQMnv5xugl5y9O1SB3IXbHAJBWnJ5Q0Ky2c/pqzBq01KNb3oa3lyZkc8SCRwmcvxoUfMRZiUUxhjtOPc36/nfuKQrdCflxdjNrTfW4jJW59+QjhWsCyo9cBntgBJH3N7lMGcPENghBF++DgzAt94VvQmlY4VvXn5xs/+7bU/I=
Received: from BL1PR13CA0272.namprd13.prod.outlook.com (2603:10b6:208:2bc::7)
 by DS3PR19MB9199.namprd19.prod.outlook.com (2603:10b6:8:2e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 17:04:10 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:2bc:cafe::ef) by BL1PR13CA0272.outlook.office365.com
 (2603:10b6:208:2bc::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 17:04:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.1
 via Frontend Transport; Wed, 19 Nov 2025 17:04:09 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 4B27E406547;
	Wed, 19 Nov 2025 17:04:08 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 26AB1820257;
	Wed, 19 Nov 2025 17:04:08 +0000 (UTC)
Date: Wed, 19 Nov 2025 17:04:07 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: broonie@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        andy@kernel.org, p.zabel@pengutronix.de, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, bartosz.golaszewski@linaro.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] spi: cs42l43: Use actual ACPI firmware node for chip
 selects
Message-ID: <aR34h1H+isZQLEdk@opensource.cirrus.com>
References: <20251119164017.1115791-1-ckeepax@opensource.cirrus.com>
 <CAHp75VcjhdBXps+VmPNNUucA4LQwiZnReDMbQVpxHROcVsMurw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcjhdBXps+VmPNNUucA4LQwiZnReDMbQVpxHROcVsMurw@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|DS3PR19MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c334e60-6719-4df8-043c-08de278da840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|376014|36860700013|7416014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHpuTUlRVHJKdFdBd2s0bXlkU3RkaWZsOTRUb2V3dnEzZTlsVlBsYW5IdkF3?=
 =?utf-8?B?bGNmaE1qR2p2ZG9wNS91TzdZNmwrZjlQNDg3OUM2MkQ1aTJMcFJtajYwbFZ1?=
 =?utf-8?B?WEZZZHd4RzVpV0IvN2tBbUZvTitFZnA1KzBZU1IwWjZmbkMrM2RhaEdmYjBE?=
 =?utf-8?B?N2tEOHFXckE5TW5WR280Z3hWOVhvemVMekU1UzRnSVc3N3pYSnFmMlY5UGV5?=
 =?utf-8?B?UkhmN3dWTlJuTzBpZ0R5S0VCSXFJdEJFeVM2SlJvNlB0V0h1cXZtbTV0SDg0?=
 =?utf-8?B?YTRjK3QzZGJtRXZudFFTak9uN3djY3BGVVJ2d3pwYUFKdDZ1UEhDWW5OWDZn?=
 =?utf-8?B?dHo0NllkN3J6NTliOTBDbzlPY1Zyb3dtRlh0Yk1VUHJjdTN6SkdpT2R6MGFz?=
 =?utf-8?B?bU05N2hqK1hJbmV5S2dRbkU4M3NUNTRCOUplZ1NrSzZhUXpaY0IwdlZRaU5X?=
 =?utf-8?B?YysxVW05WnR0dWZoMGZ1RHpON2ovNXRlNmkrVTEvWlZURGFmUGZibmFCNERX?=
 =?utf-8?B?Z1EvSVlVL29QZkJnZGRqN250WEdBYndrcW1iY2JqR1FEa0hyWWhydHU4Um4w?=
 =?utf-8?B?cWVEVi9rZVlMb1JNU01KK2JVcDhCMk5Ya2hXSzBEVk1uUHljTWdKL2tmSFhT?=
 =?utf-8?B?OGYvOFJvTXp0RGxlOXF1U3dZc0lZSHVIa1VZWEp0MklnMWVYMm96T2NGMlAx?=
 =?utf-8?B?TlI0K2h4V05yQ0hObFRVZ05EMnZwd3ZkazB5TFM5WlVBazc1bmR0djdQTUtM?=
 =?utf-8?B?ZzR6LzEwQzk1N1FoQ3dxTld0QXRURnJRU0Q4d01iSDczbW9wQkp6ZWtJWkhu?=
 =?utf-8?B?QjIxNW1wN0ZKbnV0Q3UzS2RCMDQ5UTF6MWNUYnBzNHJ4RDkvbU5BZVBPV2Nl?=
 =?utf-8?B?a3FMd3BUUjdJRjA4NmF0RGhZVnEwMEtKY1RxMkVXM25DRTJYTEhQamsyRSta?=
 =?utf-8?B?cHlrMGFmcnZVN3Q0Wm9aMVp5ek1VSG1JUzg4bFAyaGN6b2w1Z2tCaEF3aFk0?=
 =?utf-8?B?QjdvRjhSdHhDSGJleWVybWZ3Q3hqbDlJVFFvL0VtRXQ3VkU2dlFpUUs2VjlV?=
 =?utf-8?B?YmFkVGxDRFhXa2h3U0R6OEZkdHRCMXNuZmx3c1BYekVLRHoxaGxSOHpjbE5l?=
 =?utf-8?B?eGV5TVljK2RiclVDdUJDMVRRakE3VnRwcnFiQm9WQUg4ZU1aRVl0TzkzakpM?=
 =?utf-8?B?MXIzMEtueStCYjBIYVN1NzEzbkdQYXd5cmRkckY5V2QvRWpIam1VMTY3am9I?=
 =?utf-8?B?djJsZSs1SkZzVWt0Y0J4WWh3cVRDZ2Z1U1hKamJ3NW4vTW50UjFaSEloL21K?=
 =?utf-8?B?Mmx3VHFOdzhUaUdHU0F5YVd6c1pMY21rTWVvb04rU1ZDaWhXbXFqdzMvWTIv?=
 =?utf-8?B?QnJtWFhuUWp5bXBLNFdqUW1KOWdzZk9nbzM5elR0cDk2dVNJdmZjb09TK004?=
 =?utf-8?B?N2xYRWpRRG44STE0QitzN3k2VTZZL3dYTjBOOStuclFBL3NkaUJLMGtkMlpz?=
 =?utf-8?B?QzAwTnBxaE0vUjBOY1VoNlZjUnFKN3pobXlSRzBpSWFWZnpRTUVMUWZhSXZj?=
 =?utf-8?B?NFFDQTIzN21PYjlRZU9QNW9NVTBWSUVnNjU0d0szT0lSaE4wanBYcU9nVzB5?=
 =?utf-8?B?RHErRjNUU2tpdGRJeVR4UzJYbGMrS2VrMkszUlFUTm5IZFlBdXVvcW0vT1pY?=
 =?utf-8?B?Nm1OYVZlby9HV2tQQmdnNWh1T3dFRnUzNlI0bWdrUzY1eWxkRExkdmhHNUUv?=
 =?utf-8?B?YU9RUHBDYlVFN1JNMTV1ZnJpdmI5Wlh3dFpNYXJGcGVqNHYxb3Uwb2J4VkVJ?=
 =?utf-8?B?QlVxdHZNVFliL0xLbU1MZmxmcGhZVklmS28vZjJWZzY5TE9iWWhQRG1nV0to?=
 =?utf-8?B?cmVlS0o4WDlPd01JR3F4UmhjZHNsOHBKbmZJaVFMSkFWajgvL01abXJmU3Uw?=
 =?utf-8?B?aHNJTjdGdVdRTkVyTHdKbFk2MXo0L0FZbzdSOU9oK0RVNHNkb2k1ODdMbGZ4?=
 =?utf-8?B?SkxsTGJjZHdPR21hWlorZWpOekdEeHM1WTBaZU9OS3VIcDBaVDl5c3NtM1Fk?=
 =?utf-8?Q?YCgx9A?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(376014)(36860700013)(7416014)(82310400026)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 17:04:09.7638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c334e60-6719-4df8-043c-08de278da840
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR19MB9199
X-Authority-Analysis: v=2.4 cv=OOEqHCaB c=1 sm=1 tr=0 ts=691df88d cx=c_pps
 a=xGSA6ZD39cz8HQxtwlne6A==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=w1d2syhTAAAA:8
 a=ayh5vgwumz68smdYdcsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: or9cM0XE83gMwulqu1tvaMWhEMkPWdPW
X-Proofpoint-ORIG-GUID: or9cM0XE83gMwulqu1tvaMWhEMkPWdPW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDEzNSBTYWx0ZWRfX5qz53Ejmfz0X
 YzxjPx2koEowQUvRipAPU8OK47zJK85AB28yrmAKtOpMa9BW6K+9/8lVyllNtS1DJXvAO4SRL7X
 cUX/2qlcNCUAhS0+vCywX+f50AkPKC1N7fqIkO9fBVQGZ9JwrCkTSvHAxqef2c864sZl0RGUGMR
 rM4BqzAfCqEW0tBt6J+C54iQJoc1eldpZ/K0PyL+r3JTiHv4RL7tbmpfqRghbdJ0bjxZ0x67oxz
 oGbGk/fsO2jmHWjIx8BECjXwfCneyrslWZuvv70Jy87/a829fR4RsRGrcOjEmpy13pLsd3w0Ukz
 zj9oZwOagGKQvbVCWyHjvgluk21X7HeY1tNk07xG4pALh5OEk4m39nOm63V70bjjvylYLLohNIE
 bWw4Gfl8qL2zHtvEEX4zEKUX3SMEgA==
X-Proofpoint-Spam-Reason: safe

On Wed, Nov 19, 2025 at 06:49:57PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 19, 2025 at 6:40 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> >
> > On some systems the cs42l43 has amplifiers attached to its SPI
> > controller that are not properly defined in ACPI. Currently software
> > nodes are added to support this case, however, the chip selects
> > for these devices are specified using a bit of a hack. A software
> > node is added with the same name as the pinctrl driver, as the look
> > up was name based this caused the GPIO looks to return the pinctrl
> > driver even though the swnode is not associated with the pinctrl
> > driver. This was necessary as the swnodes did not support directly
> > linking to real firmware nodes.
> >
> > Since commit e5d527be7e69 ("gpio: swnode: don't use the
> > swnode's name as the key for GPIO lookup") changed the lookup to
> > be fwnode based this hack will no longer find the pinctrl driver,
> > resulting in the driver not probing. But other patches also add support
> > for linking a swnode to a real fwnode node [1]. As such switch over to
> > just passing the real fwnode for the pinctrl property to avoid any
> > issues.
> 
> > [1] https://lore.kernel.org/linux-gpio/20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org/
> >
> 
> This can be
> 
> Link: ... [1]
> 
> actually.

Thanks will fixup for v2.

> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> >
> > Ok here is what I would propose to fix this one, IMPORTANT NOTE: this
> > does depend on the first four patches of the linked chain which I don't
> > think are merged yet. But I would argue if we are removing the name
> > based look up, we should add support for fwnodes at the same time.
> 
> You mean it has functional dependency and not a compile-time one?

Apologies that wasn't clear, both.

> > +               args[0].fwnode = fwnode;
> 
> You can assign entries directly here as
> 
>   args = devm_kmalloc_array(...);
>   ...
>   args[0] = SOFTWARE_NODE_REFERENCE(...);
>   args[1] = SOFTWARE_NODE_REFERENCE(&swnode_gpio_undefined),

Yes thank you I will fix that up for v2 as well, I was a little
rushing this one out.

Thanks,
Charles

