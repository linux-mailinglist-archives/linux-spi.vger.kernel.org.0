Return-Path: <linux-spi+bounces-11410-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C6BC74421
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 14:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 89C8830279
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 13:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EC733E350;
	Thu, 20 Nov 2025 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="l4/znfyz";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="dm898Gfc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB64E33C527;
	Thu, 20 Nov 2025 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645233; cv=fail; b=ZGG0meyniz7qNR0U+zUZP3seftS3uPiHxzMz+mzC351Dj/tI8aIJMlIny7rV2vcg4G1qBhCO9Xbs6Cya0YCmz/995zm/ah8PxeJfIwIIajQh9aaMbUscW/Y/c5FGJ/087HJwx8+mdPaKjVxpCwDIX42yWtGakfW5zilyC2bdEmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645233; c=relaxed/simple;
	bh=+kI/tmIS9FDE5MDIV8uYV8DUHQKHZsl8O0WJ2cUM8zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhCpvRa3YpSdMAuYGoHFo+ZC1Ce/r6on3QEt0SPNgh4KunsZ0sisSOCbv36ZjNPt6GntcMUQhrQHuQJ3QbD7IEobLwJAB+bgQFReIX2PYy4UCr9pNkUYfobSNKFZEBO4Vov1aR06dOnKqKoAMsJVu9D3NIF6M1UWsb5FpJKqD9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=l4/znfyz; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=dm898Gfc; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AK5Kma4311678;
	Thu, 20 Nov 2025 07:27:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=7eCtHM0zS+iobS5rU9
	bEo068+RuMjWOMc554PhJUXxU=; b=l4/znfyzcQ80IxWiyUibn12aNw5Rn/NopN
	4cwWsJUBaYnNOgTJApXBe3nxi0FcatFrmzPVBfrr0F9N6MwdyqZwCHMjNhOaZrz+
	+EomSIOewF7hEAEj9Th+T9RcbiXv3DQ361BdTPCTKJPWy3vgg+DnZF5IQhfuJaRi
	qlRuLnH2gAz9QB6GdAEm+S4JwtZ2VJiinQwmn87dSHu+X5qIMxYdh56me6C5OGfU
	8pgEypg1ReOI0tA0U51AaRlji9p910yU3tYjac3K1t/o7KuSzobmHi/nhtAOJ3uB
	UutYARflxSQLnqOnCRJ+GLR1GUobzlH+cp96rqxnR1r8kycYwEhg==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11022137.outbound.protection.outlook.com [52.101.43.137])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4ah1bmaebn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 07:27:00 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWnVumB6jCrFtQjvZoh7fGYZuHWI0R1WaC27x8xPZ++DPjkc25j/Glb/WI1i6ZAAG71iAEHPupKlTJg13pLo9AhQtsQR4wTuyLkgMzy+5LZ+kxAPHvkAES34l2NXVjCSIvAZUSFvSVmLSvxrC0IoprYG1FOqTAfSHYkrvEnkGkukk6WxzUcTzycVGK5Pvi7zo6vtl6zmw2amh3LgpEvqxd+nUz1lUTFGhIh6jAGhU8EF7NhrzJzzWG9LzP/1M23bR1flt86SriQN7QRg1SOqVOYD8pkf2TZaUuKxYpoXEFeohlQyoIm/mu1cviaTGXb3h5elF9Swl8x5qVlP5jxxag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eCtHM0zS+iobS5rU9bEo068+RuMjWOMc554PhJUXxU=;
 b=RTGpIq6B7rlPt1A7D3e1YfKQ5yl0fprLcKR5TDysf+WC6PTbx9PcDVYADVAvVPX48AmJlRWjhBZI+j1FH/UCNWzi0opLWwb2spkjMWF8P2yqPC5b6JpGRQRs/ykVf15cDF/xTIGBHcdb11I046DiPs+PomyyTnKYDpGcsEfWCNHI3By4gZ8yqXnXIs5oRtI3UTbeqlVDvHWO1PK6JUdA3s7ph43gw3uqWQhsUmcTqiUNEDwlZ+6jdYABcgpKr+87PCsusU9oeZy0M8pNIrvs8MvuGoPf4H7ahN1CzX4JVm/IB19aAbQByEp30+euyIUaCNTs8zsv6lmo9If162AF9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eCtHM0zS+iobS5rU9bEo068+RuMjWOMc554PhJUXxU=;
 b=dm898GfcbQNPEtLCi0lk53BDMouYMrcGwyNyCPRkBlblsS81b6k0oN1cFcaiHTtnRoV1PDj1HPljMlc5S7KUs/cDVVCiK/g8wPR8AGBvQ3ahWSWLhG9jHh/Y9Y70xeHulmIwxeC6zpbsV6gSCQjXkdDoJwz+/FU//hjIN8CoX9M=
Received: from CH0PR03CA0330.namprd03.prod.outlook.com (2603:10b6:610:118::22)
 by CY8PR19MB7666.namprd19.prod.outlook.com (2603:10b6:930:76::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:26:57 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::d2) by CH0PR03CA0330.outlook.office365.com
 (2603:10b6:610:118::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 13:26:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.9
 via Frontend Transport; Thu, 20 Nov 2025 13:26:55 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 2E682406547;
	Thu, 20 Nov 2025 13:26:54 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 1BB56820247;
	Thu, 20 Nov 2025 13:26:54 +0000 (UTC)
Date: Thu, 20 Nov 2025 13:26:53 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
        linux-spi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v7 1/9] software node: read the reference args via the
 fwnode API
Message-ID: <aR8XHW5YvwSh/9Jd@opensource.cirrus.com>
References: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
 <20251120-reset-gpios-swnodes-v7-1-a100493a0f4b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120-reset-gpios-swnodes-v7-1-a100493a0f4b@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|CY8PR19MB7666:EE_
X-MS-Office365-Filtering-Correlation-Id: 1adb210a-8f76-4e48-803c-08de2838799c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JD2uuqmS5xjstdiwWyDBFup9k2zVMBjdV5Sa2i2dSGolr4PN3F68DfFpwf0f?=
 =?us-ascii?Q?XS3VTUSf/PMB/hKNqF6KQDjeyywL7hPvcmAFoJVrDXg0BRT030RvJQxbez7Q?=
 =?us-ascii?Q?3hF2T8sFRUH1bqZQmKTRzFBkEfjj6JPUszKR2kgeqpjmS1AAwA0WjVXScgAi?=
 =?us-ascii?Q?nT7AVRtfOnbBAZUCOajqbwwjNjVZmorpLC/vYxXa6loz6TVyCf3/oXIAqZXz?=
 =?us-ascii?Q?d+6YdbW+4gnDvkJH/WaXvsFgCbVVgWUtdKJ6GJGxX+gLEXzYCNZRiu/aOEpO?=
 =?us-ascii?Q?lKu+uAaCreGoYvM+0xfa1p9wgUpMW6oR9g1rtd3CNoSIkbNuFIg79CI/6dTO?=
 =?us-ascii?Q?NNLC4KUKkch4ECx88fl6IinEojbIDbRnFbztoPWgGR6bn0xqQcY+5EzF2OeI?=
 =?us-ascii?Q?7J7VxLQ9j9CNKrE2AQVbt9KEH6tIZkq8TneveUKCDE81wBvjDPOfGLzVz6ic?=
 =?us-ascii?Q?gdPwDnOKg5nuC73R5790KQ23u5OTN4c+E4tfZE6p0WFy54yz+1FuldgRRiQp?=
 =?us-ascii?Q?Y92Ny/3zjgR1yR8hbEnLs7nnEwyMPHdInjMhXHz/1ODIC/ET0rbi/8QdF5CP?=
 =?us-ascii?Q?+I3eiUNz51aaHZSxZeXtmFO4J6MppDtKXdpworphxS9AEy0+0MT2HG89uoQG?=
 =?us-ascii?Q?OyY53gj3NNDVxMH8AingqL4Zu8pYZiTPQ16I4C9j+MFgmAkFeCN+j3YP1qqO?=
 =?us-ascii?Q?cS8gBN/5kjQWlYG8FL3f+WWAtWBI1z3aNRM+s8enrQWLZYHIBZicsk3XJU6G?=
 =?us-ascii?Q?zcx2pFrDRFUluQyNnl4v+JSHoVol6wpfcY1gU9Pi09oQwGeO+aQAV32YE+rX?=
 =?us-ascii?Q?WEbphA12UcZbuaNPW9OSWV11fJiH47eUH8eYfWmcypvMBwQqXi8UbRc0UY4B?=
 =?us-ascii?Q?9lVYWeDXPDXxsP8d43kUX8NljU3oaTsYLNFXL9xFJN2A9GHA8XrKsKP7bAuy?=
 =?us-ascii?Q?ya/2Y8rC1uhXDqW/S5buDp54kf7FsN/MdRu8ONQcJcuX5UBIBp0Q+H2lwcxg?=
 =?us-ascii?Q?diRLs47rgKRX8Nr3pGmD7xCt+kfX7dMvPhZmVGD/3IeN3S/8DgRfgxe7sFvE?=
 =?us-ascii?Q?Tro4LhDzFDzHv/Qry7ikPVBeExudD4niP2XauHMcwV9Z4JAhAihMQWMF2P2T?=
 =?us-ascii?Q?QxGD5lcnGiekIn+4vQPl41bw2C8osrXWi4zfIUws1pG0vxH2+r0hF1Q3qkEx?=
 =?us-ascii?Q?9zi2EpZV+R9qyLVBsjjTVZm+ntU5qbZ4QDl5xHFebWbbAx2a2y20Jf8jSeOr?=
 =?us-ascii?Q?GvmOfctn31T/JMpIsJ4GiiIenCtHdatev3HFcBKttHHRfFV9XV54dMlxteS5?=
 =?us-ascii?Q?Cs5lgTLuqgjHgdiaHdMVjuns/yKqIztBVghqQ+hIhP0ZhE8yeGg/CeA4Ukqk?=
 =?us-ascii?Q?c2Frdgf6NGluwqnraANVmlS+qFbzYfrcefXMvr0Mxw4rGk+SXnjVQjISCUQN?=
 =?us-ascii?Q?bccIjMreyt5wWZCIxH+ECjvvq4T6XYIHbyDsdH/hKOBA1Ry9tDTKsA89PEE/?=
 =?us-ascii?Q?q70zFWCiCvFEeN3Q/Vfc3gQagxn3Bb5/DXBZjdlyPhfrg3U6bpS63DNXb5/q?=
 =?us-ascii?Q?Eok5DgivR/GwwlTM7JE=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:26:55.4386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adb210a-8f76-4e48-803c-08de2838799c
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB7666
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDA4NiBTYWx0ZWRfX8ricELHp0yAF
 mOJlHbSjEgUvgBpmarp//9Ix5OBVyoV8WGkOcx1twxeIWBMKtVc7dS4DG1PdRl+UxWTlQF7ak/o
 rFhNtxTu+NuUeo8oTfvPiMn71e3MwaWpm01bGC6StL9H6F/D4UyLnTrvVXeKcsZ3SrGKBZ0+XG9
 R61nk+PJ/d0Shot4MmFLSuoj3GQqo+KMAy8rN5sMnJHWTqXrurwcb7vXbbklgGrRwF6INrLvQC6
 GagiUVmEjxn33+AUZdBIG7oxM5ssZzUB2IcK51dU634itJd2qB3xXICSYrPW/R+yYy1TJtRsfFS
 BNIPBZxMIcpom0Myp/GABbh1fAwqF6pdTU3qEObPF3eYXlTAFW6z24RWIUV4eWhUaThcW6bUNN7
 c3R97FYd/o0dpfj0lAcJoG+p9MgU9g==
X-Authority-Analysis: v=2.4 cv=XcmEDY55 c=1 sm=1 tr=0 ts=691f1725 cx=c_pps
 a=KrBlo5eklov38meissWYIg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8
 a=w1d2syhTAAAA:8 a=g-cmFo-BY5rwPZxGFUUA:9 a=CjuIK1q_8ugA:10
 a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: ce0P8xr2hXYPNpzdI8bJCrw0NqNE-AV8
X-Proofpoint-ORIG-GUID: ce0P8xr2hXYPNpzdI8bJCrw0NqNE-AV8
X-Proofpoint-Spam-Reason: safe

On Thu, Nov 20, 2025 at 02:23:56PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Once we allow software nodes to reference all kinds of firmware nodes,
> the refnode here will no longer necessarily be a software node so read
> its proprties going through its fwnode implementation.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Sorry, forgot:

Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

