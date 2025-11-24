Return-Path: <linux-spi+bounces-11486-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F30DC81BE2
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 17:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1815E3446F6
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 16:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC403168E9;
	Mon, 24 Nov 2025 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="mG6K1Yzb";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="a6UVNJNC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EE03168EC;
	Mon, 24 Nov 2025 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003518; cv=fail; b=mhyI+qsYOj6xA6JXBo38nsllx3edUj6YU3M82MmfqTwtUREYMbfuiLbqvlFAPnsKK9fHXp5Knr4Zi8GSY+PNyAvipI7oeus5J5NX/GuKrODbhve58RYqMJFDRDzGEWgdj35dME04mIiAcQNr1HcOx01b0+o4c1J30ePGqdPAHT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003518; c=relaxed/simple;
	bh=1rNgRPtdOl1WXdIEwVayHI3Q4I+WgM79uMFLMO4JFjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdQTmsqbeSrzAl85vyaFOnGMWye2KOyTmQH7l4chRppDyLuno77WbJv1W2y7KVD+HiLMtRAw7GKaTMKizRKD56UBAQoFwu9nnvIYVHwKRIgj1AIrIp+XhfEjIBEnNjkuzl1RnYM/rjgsOICnK6HHqIKIqt9qSp7ysGMMxM4RliQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=mG6K1Yzb; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=a6UVNJNC; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AO5uS1D1165755;
	Mon, 24 Nov 2025 10:58:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=A1z/DUE34g1RNTEZqm
	JtiNZZIDM3C2iCBzbnr+9ZeFQ=; b=mG6K1YzbrT4JDsZlXrsbX5NLVfOOVB1ax3
	56W8Udv25nPtXZh4as09E6gpTNh2NXY08klvFLxMd1nL32i7sHBWd5gZCDezQhPu
	JEbt1F6GJJLtRpxVBKhjmQuo0kAKDNLFN5jMGrq6l1Vn9IR92zuo4RIJvN/GCgrC
	sF0Gt51jTE+T8ZXvLC0BAj7gcXZM8MBYNXXxri958wirDCipXmPM10CZvXkIllhN
	ybzDe7iXPVxj4QXeHvPSpT9h2247rGdaCC3a5GzmthCk5q+Pgi0Qo6Dv21XP0M4F
	nEaL0nKWBAXfuoKZZA57jMFZfEfjij5lfMpeG41GZARp2OqI6lOg==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020130.outbound.protection.outlook.com [52.101.46.130])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4akbf19ym3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 10:58:22 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxjTt44nMb7HG4Q77kTU6yYkti25SunSK8r7ZSD5rIS9fBLtuwuAgKHwcdEVCngiysV7nvi4mbjJzTWruxju5TXlpSlZ1NYOaKzIGP5OJyidAIZFlq0l/9O42BSrlmVFC/ROzzWIa1ejr+pU5TMVM5Oex7Xdi2eFRHcAmmTyLOxR6u9j+vbwCWAqdI67hxEV+xA7IN2weCUm6d5AtYoLfp4kjoZmRPN5Hb8SuGnPpLxRHIwMshdvAHMyNWDEVyuJWI0YqVrcBowSdVqoD9TqA5ZDmBYMHKozCdYua81qRvo1Zx+hBwObjCaAV15CP/I21WUeqtvKrK2ivpJ9A4J5vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1z/DUE34g1RNTEZqmJtiNZZIDM3C2iCBzbnr+9ZeFQ=;
 b=eiEj1oUkdZqJGZz6Pi3l42+QzlzMfFR4kCc3eoitUUo50Fg0SHSWNaxiY/fQvXe99CGY4Tn43Kzkc98LIUZKrIbFPOXqxSRmOKiKPvo8wt1b/ZylVmlq7riNA/nA8XFwqyG+wp/rUHUM31rJswFC2YA8v1OHq8ARyHaE2QDq6CLVFB0pkkALhbW35zpGkGqCCwoEysBrGnNLSG6k9jEZubKBl3u2OYl7XYJNoUYFC8RpDvzd39VJEMOsREstQy+N8Nw70yanGwfVqllT/3b3uHc8B+OJMH7eEieixw7ylYpcO//8Ms0onsl3wHze4Ybo3atdPsFxlTMOZobz04mDUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1z/DUE34g1RNTEZqmJtiNZZIDM3C2iCBzbnr+9ZeFQ=;
 b=a6UVNJNCxJBkZebhCQ37aNl2c3E+T6nZcnl/rWkQ6pPlLn8IWZRdnxjVhsn8HCs23andISfxr2jrHMLESR6jOjbpvvaprniqKXXuV8zXd1+gS4S8ib0xUaBxWxILHzcwh9aTQH08vyQkcmVqRZ7CfDfDoSz7v1uGGvVAHg1PIak=
Received: from MN2PR15CA0011.namprd15.prod.outlook.com (2603:10b6:208:1b4::24)
 by DM3PPF0280EF5B8.namprd19.prod.outlook.com (2603:10b6:f:fc00::704) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 16:58:17 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::2a) by MN2PR15CA0011.outlook.office365.com
 (2603:10b6:208:1b4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 16:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.7
 via Frontend Transport; Mon, 24 Nov 2025 16:58:13 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id C4A0B406540;
	Mon, 24 Nov 2025 16:58:12 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id B6218820247;
	Mon, 24 Nov 2025 16:58:12 +0000 (UTC)
Date: Mon, 24 Nov 2025 16:58:11 +0000
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
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        stable+noautosel@kernel.org
Subject: Re: [PATCH v7 4/9] spi: cs42l43: Use actual ACPI firmware node for
 chip selects
Message-ID: <aSSOo4q0sLDHqe1h@opensource.cirrus.com>
References: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
 <20251120-reset-gpios-swnodes-v7-4-a100493a0f4b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120-reset-gpios-swnodes-v7-4-a100493a0f4b@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|DM3PPF0280EF5B8:EE_
X-MS-Office365-Filtering-Correlation-Id: 13180fb7-1a5d-4517-5d4f-08de2b7aa82c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qOQM77I+11wXCLKZVBIh5gTmbeyfT6YSpoZSOWCYv2WnqhmM2tTZXFcf9A49?=
 =?us-ascii?Q?5BsLrqDyZ4T+h7eAB0CN/n9/Viv819ezaouFPMpeoo8YJ6OF0h1Khx5p8EXN?=
 =?us-ascii?Q?aeVg2+CIo+w2hzZa9KYvV3VPZiLbCUIG4QwcoEdCHpR5d7P/e6ClqMax0NqH?=
 =?us-ascii?Q?jDzIgVTKuzYfv97zdel+vlOKqvjhTxH3moIf5ZEDrNPoPFLZoX+/2BIPckkW?=
 =?us-ascii?Q?wI/LJoKrtg45ZTd3nq4xfPzU8zHyXzolhUH0mtdaZIUOvkBF15FbgGjFlIEp?=
 =?us-ascii?Q?joa1auge57crGk+jaL8xb79ns6XtJXvvdhjLFKj2Ltb16uePxCUk0c1JXHUy?=
 =?us-ascii?Q?Zo8I3eoL0f1+iuVb/o2io0dO5tSilus3Lf+1UD19uuT6HysSdqBce9cpuyJV?=
 =?us-ascii?Q?JVAw8DjJJAvH1nKrUJtWq/50wqqhKQNyzCYO50WymgdDhfHh45Mz+0Qa4Rpn?=
 =?us-ascii?Q?30LRMauMTXVzcqriUmukGCdD7X2gListz8gctEkW5oqY8clwyccwkTe6107/?=
 =?us-ascii?Q?cgpRxdXfVsO4bUFQqbfIcyGsxUoXjzwNO14ISGKkxbpgKt6F65zbAduDq5/j?=
 =?us-ascii?Q?Mnyt6YhJACrfLKD1KjZRC5Pum6xDC/fA0kyK2+jjxJ7i/PfsZjCvvZucE7we?=
 =?us-ascii?Q?fae67cEtf/nvvbyNGVCjlyZLU1c14K79KphmqIjpPwYk3/7874zfx3ihd0D2?=
 =?us-ascii?Q?7w5BXWfSaXlj69O+xsWiGT4sf8AK95f4kNo6azFFs+hDmXaeTuIQ30PVgl/d?=
 =?us-ascii?Q?NIj4ieDsOrCIHrNSwvj2I2SbYMgPrGMm8AuyzJ2UsjDzoRvMCuQ1fvp3mMU9?=
 =?us-ascii?Q?qwujSUFb5rbpYVsmrvs1toeTx18mldJBsBxHycJKCNfqZpgWvnBWrT9cJVb7?=
 =?us-ascii?Q?eitILQ7Kxa8JOK8f3uwSQ9yzjW4q6DV/APOrQcT7XXmlJ5dxjyka5Np/gvXn?=
 =?us-ascii?Q?Jv4ijfj6WPAuIhsgySzm6CCaFMjYbRsjnfTJ7483/+jAlwk2V2A4Bc2MdYIo?=
 =?us-ascii?Q?ys2QDZKrL2tzEaRf9mlo0n0nX6G4A9GkK9skiVoa3dL/PVQlso9dLC7PR/oi?=
 =?us-ascii?Q?+pRBlQAkT/sk3UrVeG86T4EFmWbZMJWh53okTqEfJ75LgjR6rzN67qM6ooNX?=
 =?us-ascii?Q?g5ZchxCLfI7BkXcD0E9j/cTUxV8hpCrOkUD/QkkI+pbi20ZkSMIGZtSyL68A?=
 =?us-ascii?Q?hEbeiWkI5/iD5Uw8HkuBN9l7fCbPOi2nBLB5BSNElymoaFdvOLCohLUYsCdK?=
 =?us-ascii?Q?YttyhbiMKOM3Zec7RzMg94+/wDmKd9Rjs4RB8+7zHZ09Uaq4Vst53xY/zhaM?=
 =?us-ascii?Q?c0PkBqJ1TQ68nf2rSfly76azAG9O3TDwqiAtWeUlVuhAi/C1BWEsxv41BKiJ?=
 =?us-ascii?Q?kXpF30yaZtsxxAzUYBCzD52oZ53NLu5gHrvyP/34Hqq0TgREakFPhZl+Q0xS?=
 =?us-ascii?Q?eF4eGqn3TS9+1Up+ErPGUUJ9z3SvGcZwKG67pQssFq/TtIxjyCwkNzjYydKz?=
 =?us-ascii?Q?IxS7hCErqdNciLmAE6AcJTz+gIIC1M8AgEvqPGS1jdSzUsgAzJT7xPQINVGC?=
 =?us-ascii?Q?zT3lQ+gcyh7Ab8VpJH4=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 16:58:13.8555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13180fb7-1a5d-4517-5d4f-08de2b7aa82c
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF0280EF5B8
X-Authority-Analysis: v=2.4 cv=caHfb3DM c=1 sm=1 tr=0 ts=69248eae cx=c_pps
 a=9hhwatWKa7/vLw/BZzsOGQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=NEAV23lmAAAA:8
 a=w1d2syhTAAAA:8 a=StvSk5rmRmK8WZg8cjIA:9 a=CjuIK1q_8ugA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDE0NyBTYWx0ZWRfX/E8ZlDKroH9R
 /sIGoV+dVGr3ECvBHd2GYqbngJS1APEo8wQu5T2aSGgvqRTjG+/XpwM9m9tUoFOpUtZS0862Q04
 2l+xTBWeVJLIJBSCVNgEX62ozMmo6jAVlp2aKOxD98nyT5jSlh80Jfs3FQJhFaZr3XwgRPaFlFx
 2DScL8XvZTFEg1Wp0RUpmrGq7wpiUk2AIQWV5I4XG4kSKAuUZM47qFTQUSTOTUDiAT3k4Z/KxGR
 6YZq64DNuEGr2Qk05HmqzP9gcfsKi12eFOm1B4rI3thmu5lKOCvI4obzXd+R7P+3rHP3RsjRDcm
 E9YUGc5ECLFIIx57ophI3rrl9p49BufmnRUwP2+lL2grSrB9zBDNNUD4SqgUnfL/0SpgswJU+km
 TJAuTI4csoeJCYHnTe6FICpZl8CPIw==
X-Proofpoint-GUID: U_x21kfSVC_E6eTJpoC0tyA2W-zYvOFa
X-Proofpoint-ORIG-GUID: U_x21kfSVC_E6eTJpoC0tyA2W-zYvOFa
X-Proofpoint-Spam-Reason: safe

On Thu, Nov 20, 2025 at 02:23:59PM +0100, Bartosz Golaszewski wrote:
> From: Charles Keepax <ckeepax@opensource.cirrus.com>
> 
> On some systems the cs42l43 has amplifiers attached to its SPI
> controller that are not properly defined in ACPI. Currently
> software nodes are added to support this case, however, the chip
> selects for these devices are specified using a hack. A software
> node is added with the same name as the pinctrl driver, as the
> look up was name based, this allowed the GPIO look up to return
> the pinctrl driver even though the swnode was not owned by it.
> This was necessary as the swnodes did not support directly
> linking to real firmware nodes.
> 
> Since commit e5d527be7e69 ("gpio: swnode: don't use the swnode's
> name as the key for GPIO lookup") changed the lookup to be
> fwnode based this hack will no longer find the pinctrl driver,
> resulting in the driver not probing. There is no pinctrl driver
> attached to the swnode itself. But other patches did add support
> for linking a swnode to a real fwnode node [1]. As such the hack
> is no longer needed, so switch over to just passing the real
> fwnode for the pinctrl property to avoid any issues.
> 
> Link: https://lore.kernel.org/linux-gpio/20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org/ [1]
> Fixes: 439fbc97502a ("spi: cs42l43: Add bridged cs35l56 amplifiers")
> Cc: stable+noautosel@kernel.org # Don't backport, previous approach works, fix relies on swnode changes

Just wanted to check what the thinking is on backports here. I
see we have marked this as do not backport. Which I think is
sensible the changes in the preceeding patches are a bit much for
a backport. However, the patch has caused the regression has gone
to a few stable branches (v6.17, v6.12):

commit e5d527be7e69 ("gpio: swnode: don't use the swnode's name as the key for GPIO lookup")

Are you guys ok if I send a revert for that patch to the stable
branches it has gone to? It doesn't actually fix any bugs on
those kernels, and we are starting to see issues coming in that I
think are related to this:

https://github.com/thesofproject/linux/issues/5599

Thanks,
Charles

