Return-Path: <linux-spi+bounces-11396-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E44CEC7406F
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 13:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F19504E8E45
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 12:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05567372AB6;
	Thu, 20 Nov 2025 12:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="EcCw9i0b";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="jYFelnJm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308032ECEAE;
	Thu, 20 Nov 2025 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763642587; cv=fail; b=QcLlQYaoA6RYSmsxQys0dlz97sx6Tu6FL01RSfsC5AQ+UHmzs5a1JWBUa+AhwzYq8SsTpGcucxmAMsVucRaxQOV38QCpJ8g33/mleOfhl/K0HaZJtrDhNqV5fuvQGUouAuYSSm3YIqgNwMETk+hVewBBfOvrfrptCTdn3Q9lnMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763642587; c=relaxed/simple;
	bh=KXMxV1dgaYUSU3/So133ZvH1IM0K07lB4J19C5JIMzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7/nnSyeMdQb1MYQHsZeyLsU9wAqWbaBbyr8YTzl0mCfSCEL1VGAUvpOfu1YnFfqjjjpPHrEDdTHd6O2gGtkOlUDzIc5MXiZ+QCoCxvSeLaoVc4VfzErmTn/4VrTy3ueH/DCdG1v/RRP1Jdv/w2NntqFaJyRdlLiG7a2UFmxfeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=EcCw9i0b; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=jYFelnJm; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AK4fZYE247388;
	Thu, 20 Nov 2025 06:42:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=9QEikkCpL9Mxmq12OM
	aGo1ISfVlW5H7gBg89M1mwqys=; b=EcCw9i0bFMAjxTXkDbf9Po9BkP/wfR3ILL
	dWX/7fjy4XRsLNJyRiO8zNxAXyb/z/nt6uEstQ81kJGbi2e4VzbNIQW1pmndMbtq
	nRMKVFwrWkBYflm+iCdPL1cFgoptG5f9ReBoZtLuLUpCjBEjR5otnNQv3VyU011p
	ypsTtTExwlWtOgrEM8vERb86heRwlLPNdiZlms3cISWJBAQM4svKBItA4xVCHqCR
	qXxiFIhy3t4TI/8FClp4bm5iD5Xqkc2FCgCpE7xPMCMJW24mjfNKTAMivYVEuIXJ
	W39pR32GBVcaTWqXdK6kmGZ8rhMeSdBITu6fvs6rYTffJZv2pgHQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11021079.outbound.protection.outlook.com [40.93.194.79])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4ah1bmacf0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 06:42:55 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wa5yDRtIhB9dMkO/tULFQu7GtVLavhb8IGaqHhUvNpkpDa6DhsaoDCuOXZyy5tJwPrfTNy2w9FHzIryZOD3CfkeAjobNzkCrdxW4p5cbDtWD3fbzXcwneTSzwOs10WiPxl165zewqsP9P2wPvmLUB+HmbR6bNYhGzGrpkfxPEbJ6r+vevK6l5WfMwxHEklyjq3SjmnbdITUwGdmqNtyHdfDM8OO2ZTeZdjwLRFP3XUBYEVaqwuJQpgtrc+S5D4VQShpMfrwHZQdC6sIYjJ6OrzJgEPURd8VHwU2Dwl5Pd4wQ/io38t7dCy8vnLglIbiz1gCz4mqryVbUNSlF5Zu9Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QEikkCpL9Mxmq12OMaGo1ISfVlW5H7gBg89M1mwqys=;
 b=oEggRsTVGhCtG1VQywuh00SqgEqR4dewK599OyUHI3EtkSmytNht+rOxXSqT1GYwMl5EoZ3Ebz/3klL2ye8lrtGFHaGlR6+XmoXRtYh+D52prQQb6+IKqYwtclpwq6cFc9t5/29Wl0wl54GGeWuknY8wqu7X4rT8bUA9PT2y48OhJEhNTlxTKXjFm5tee97KWWKlO9hz5zo2qCMUAHKJCoNLIenjMcJyA25y9PkM/syviZV6YeNpJZt+/+goH/E5zz7VMGIdY7xp7vYX3VPM1M5FXbXzKOWCuW4ZESGG9rluaAl2XJi5boWL4F+R1sLTibCWhUMdoR9gqxpshxxNfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QEikkCpL9Mxmq12OMaGo1ISfVlW5H7gBg89M1mwqys=;
 b=jYFelnJmhVVKywLWY/09DAWoAMjnzZ8674kS4s5c+pV4HeFtKua+9+97aNfP3LWai1GU9pcHd1IlMZZOnse68F0jPKStjvvJFVZYFRBcwDRR4r11S2TKD7S5h9RbkAQXzP7nPs7R4f+55cK4C/ABmO5Xq+mofut2Daz/7nmZGic=
Received: from SJ0PR03CA0377.namprd03.prod.outlook.com (2603:10b6:a03:3a1::22)
 by MN0PR19MB6238.namprd19.prod.outlook.com (2603:10b6:208:3c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 12:42:50 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::cd) by SJ0PR03CA0377.outlook.office365.com
 (2603:10b6:a03:3a1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 12:42:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.9
 via Frontend Transport; Thu, 20 Nov 2025 12:42:48 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id EBE7A406547;
	Thu, 20 Nov 2025 12:42:46 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id CACF7820247;
	Thu, 20 Nov 2025 12:42:46 +0000 (UTC)
Date: Thu, 20 Nov 2025 12:42:45 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: broonie@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        andy@kernel.org, p.zabel@pengutronix.de, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, bartosz.golaszewski@linaro.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v2] spi: cs42l43: Use actual ACPI firmware node for chip
 selects
Message-ID: <aR8MxX1g38dq62rI@opensource.cirrus.com>
References: <20251120105907.1373797-1-ckeepax@opensource.cirrus.com>
 <aR8AmhcY_y93O3GM@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR8AmhcY_y93O3GM@smile.fi.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|MN0PR19MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4ead32-b944-4bf2-03a4-08de2832502f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tr+x6I7/re9mZvfOmdvXkAphJXGE7JSGQvhvXCzULc5nCgTCuPdydW/upxph?=
 =?us-ascii?Q?vVwbr+yEbRjk2o/ZM40OZi/1ttMxeshMQAmJeWfxvCrU3Wi3NnhmiIXAkkoM?=
 =?us-ascii?Q?IcwgHlD0uu03RrGru2ycaFOZJkmKKk3nyE+xbff4vtLcasaLu/9GXQcx7ied?=
 =?us-ascii?Q?xOP2Rd9PKlI++BE3x4zEryrFDMNPey6lzgkew7B2dcEODwiBGWMpunRBL7bF?=
 =?us-ascii?Q?evES4ilcUL0ObdaagVzV+KRyOfa66KaAtyZ1/TP0llg9/U70soWbEmQEe1gI?=
 =?us-ascii?Q?XWeJvrKZdxV63pGpNm3ewQ8kRVQqveCeNbi6y4AMEX58LwBdus31qrowHjNN?=
 =?us-ascii?Q?VXRdzrI5MESHJi1b2qDEhHDWn8bYxQ9uQ0/CUlimekemT4KqorZsa4jiGjvp?=
 =?us-ascii?Q?FaDXLHZyFSu/iyhIhZO65L/v+nbYG77uRNGGlz1TMTEr3z198MU7B8yrdZzQ?=
 =?us-ascii?Q?MOYFiFVLDRFdnELzjoEn2QeDNS7/L254+c6N0O1h7BXVwvlelVkDDus99tSD?=
 =?us-ascii?Q?PY85qrkpieQEm6e3HlZBKwsOVTvolMrK1yO8YICUu4+97G5z57QYJEgizV8d?=
 =?us-ascii?Q?gkLDaUNQ+KXxyD8Jjz91eQgk/wjkfNUy8onbuXOn/PEVoZrMbI0ZWTZuVgQR?=
 =?us-ascii?Q?imKLBCox05HpUERuQL5sJA0oddcSHX5qivO8MEjdCSbhr5V9nvlfOuI/eoia?=
 =?us-ascii?Q?YC6K6A3IfxgfeuDwazn/65615wpW3xROMwus74ePNfn75j0zqWR3s0p7hkpD?=
 =?us-ascii?Q?LHmtFeALq89XkXdeWy7rzOO/vFJahPyaUW8Mkk9z016QflL/cjCfS9NucaxC?=
 =?us-ascii?Q?ekU2RyLbt3fEEGS/WbAdDQzDgsWfUQSKbWhdC8GH7i7AXaNWEaJco4zIB16+?=
 =?us-ascii?Q?74UyKgmGdKUbZie6R/9O8Do7zD/OlLA3Vv1cPTyMmR021k4P7glwQ0Qh/mAs?=
 =?us-ascii?Q?444kR0g9zVusMsCmWBhQYKFElO3yMjYzRTD7mm/vQltNYCMhhLsxYVaR/bHl?=
 =?us-ascii?Q?4UvYKXveIKu61tgjtkRQjnrE9MGpNpFqiA03DZgrJKRMBsvuVRBxTTv8aiwj?=
 =?us-ascii?Q?JSDa3Bkic7dZwEfa7SR7cspbZYttXH0KfdjELjdKXzIzkh3GxRQb7RR3s1OV?=
 =?us-ascii?Q?FZuYG6FOymXlsY4I3bWz31492KwCqzENE2LyR9NjAqljJgay1kIDiaT88pu+?=
 =?us-ascii?Q?j8fUdFrWALBvyxd/xni3jghWD49Td/oRYv+zNfyBcyc1XQkgW5Jk6kOxxR2C?=
 =?us-ascii?Q?J+es2/5x5VD/EbOPMbnAM9MWZxWbbx2m6Ai4VK2GPcgQjqWUTdFXEkm3Z/2L?=
 =?us-ascii?Q?pbCznuA8YMOXjrzzYx+tCc88eoGp44lAGNW3ptAwchn1dSWqQTt8aS0z2pv3?=
 =?us-ascii?Q?5Up9pUxWGDWY9icHYJeLqDlWw70PeeDTOPwtHdkkBJ+iT1bAf7Nb8/lTGNvm?=
 =?us-ascii?Q?Im25Z1Kyr4DHwJx3AeuKEqtJPSqoF1JwPIABsB0UGdmKiSAJsSBoYhL9cFI9?=
 =?us-ascii?Q?8wxYl2xuLwV9TdUBzeeZy27tkZCeWEVWCSZJ9gTqW6AxJP0sEfbcux2rxzUX?=
 =?us-ascii?Q?oGBYFX4BEyI5K789JLk=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 12:42:48.8518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4ead32-b944-4bf2-03a4-08de2832502f
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB6238
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDA4MCBTYWx0ZWRfX9xOQRLtCS4BJ
 xvaYeWa39rlxuapaqQF6mB9ZKNGGcWrAMEDtMUzroygVj9WsF+5xk7eUhKAeyUanEbDV3m30k0c
 AnUXcQJyOWcR+b34tooGUaYt8WIKo1zgttIqk9GakdtFGujvcMda/Ll9k7PmMd59dbDAqg5EMTN
 sntCZmZRpJgRrTnXyN5qVRyh2J7k5CC0IvCS/ZhyQWcE4RTfbgsHmCUqmVfLZqr8JxSw+9wkcEO
 jkVdEZPKGrxnCfWri1WZhnhq3UhBYtFPJnU9SAfM/i889RVZh0WuIEtPbxF0beVLa3ju2ZheGgr
 BQvrS531jFI+JLjj3D/mAKe3B1crCikwtAsQNhbhmguofkLh6kjcpzKhPL8Y2k53cAMBbl0JOWj
 b3EmYxj9zvEF1aowuyNA/DV2s+5usg==
X-Authority-Analysis: v=2.4 cv=XcmEDY55 c=1 sm=1 tr=0 ts=691f0ccf cx=c_pps
 a=ic/V0UXtXsqqvJ1es2EIKg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EM5_C3LBK5Y1hFyRYFsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: EPg2OPgsrksOFkaNHUf_nD4CY1HLCefC
X-Proofpoint-ORIG-GUID: EPg2OPgsrksOFkaNHUf_nD4CY1HLCefC
X-Proofpoint-Spam-Reason: safe

On Thu, Nov 20, 2025 at 01:50:50PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 20, 2025 at 10:59:07AM +0000, Charles Keepax wrote:
> > +		struct property_entry props[] = {
> > +			PROPERTY_ENTRY_REF_ARRAY_LEN("cs-gpios", args, ARRAY_SIZE(args)),
> 
> No need to open code PROPERTY_ENTRY_REF_ARRAY().

Sorry yes forgot to put that back when I switched back from the
dynamic allocated ones. Bart let me know if you want a v3, or
happy to let you fix this up when you pull it into your chain?

Thanks,
Charles

