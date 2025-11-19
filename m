Return-Path: <linux-spi+bounces-11292-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D318CC6DBAD
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 10:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 7C5682D698
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 09:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D7E2F6902;
	Wed, 19 Nov 2025 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="HzQ2WOnI";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="QcEzifKN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23313702EC;
	Wed, 19 Nov 2025 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544711; cv=fail; b=ZaNMlus362t5eUli9Pg+9kPuXOoTScOq/HXJekTXMN8kIllyKYP+aumQjB33WbvdVMWHLbVxQcs0QKmm1PzDt/EVpJfNeLEfkKAvBn+rkN9l7t0M+N9Y9LMRXgL6BCuEUa17E6pRrQZQ2IKLZMXDp5b58A/TFwNWOMnijs4qSNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544711; c=relaxed/simple;
	bh=05VqlffzkBrlBloFZ3yll71dN47vsIY4t3IZHqwojUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvOwSinpgxRx4LamptYaB+0O09+eUBFlYra4HjwsXTgXCwno1eYdfUOTv7es4aB2JRwsdRKeE1Dx8rUMQ0Fd71h3MTIIuK6pcIgOfpPpMcdGltR86jjZ85OFT33UO3InwK/CdOUpGtxr+WCHJtZsisA5s3uPVHZXDU17jWxBNhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=HzQ2WOnI; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=QcEzifKN; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ5Fg3c2111531;
	Wed, 19 Nov 2025 03:31:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=QpeIT0kv6GuVpe2dk1
	ct+i422ytVGZx97P4nVkOlkYw=; b=HzQ2WOnI7pQmHkwOU5nEYI/UKsvLwRJyQr
	q9lM/EvKdJwgjnFLHqCHoY1qz8Kshml9d4t/gXsjR6Sxgy9bCWN5gqU/qVfeTXQZ
	2e7vltFV72tcvPHtHvUmWoW/ccb7wmdkD/0h+MwbvUi7PTQZtkGfflRUSFwonj+s
	/5oAcV4O5aQoKi1AJlTx20dsvrEI+6H4qf+H8fHc9j7SRNpcZzqh1OzjcsTFoHrU
	8Q5HvkUkE2x7h6NsibUxF8iZBQtAH3BrXs52QUYW7Eq7PpiFVyY4hbNu/WpQa8nB
	CcQ++xiZp64iPoWlKH2u4XmdcI105x8S/eMQcJWWWxsvuyJBdsEA==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11021089.outbound.protection.outlook.com [40.107.208.89])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4ah1bm8n0a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 03:31:11 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQTZS+c+DYqjzuuA5YsiJf3ZsMT+wOFabFUSlQV4h1JjsSn7eeYoanPZVRlNUS/WGK2K9ML4HPBxBBwRdgfgEOo527wiWLjFIh05Bor2b3nBmihDdUXMVqaeDx15/Py01jRHwIqhYRUyVjsUOc4rKQtFAZYOoSMwH/1w2nwomnufQd8dm8Ozu+Cl9lY1z9FhVDuVdnaLkzShfYq0Kt5WhsAI5Nt1mj/DZQF4jLZ+TTcyctooETcAJBPX4UcF+5gCTWarkF8QGqo2HKbpEOBKlGl5O3xVq7h4hn6DhVJ7Al0ioWrQID6rmT3Pq+uvOvRI8pUw34QKOrwk0Xgb/gW+Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpeIT0kv6GuVpe2dk1ct+i422ytVGZx97P4nVkOlkYw=;
 b=uKPfWpYNGZi3adwgQvN+FjXfteEvUzw3wQMkAX4JZP01GHPad7SsQs1LQooWCWs33uV6ZFO2NniedwsRJ7dHew5pK6Y+SgVlwfnbJ5LWlV+gFyEoNENxVCCZlzKMMAlQ5adsAzBi6kN3obyJxhv5cQWrDnumTHtk1TC3DaHpEvV87wZLgqdBbJcVAXFfTjSkZgK4EmrImBlgh2tuoIFCAWZRaeUEDGokU5sjVQU1KmX8sQlmBHZTXmuhgDuFbWUVvMyVau2ScqRm4QORNi8CchaFCuSNDJE7QT1vVnEPYBtjFJreXo58jc94z1nkLwfjjbYUh13+LQBXvDA642f5TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpeIT0kv6GuVpe2dk1ct+i422ytVGZx97P4nVkOlkYw=;
 b=QcEzifKNeLNT+fcmorwNxzIoSttNJUH6miky70uDKYQOI3X9mNQOHkoY5oR2G4xLIe1GC32fMudFoKPIwotQepopziq6UK27wtyuUgkFNjMlN0yk7xSkX8uHPZcQ2DJAzmUZJDnFZW9dR4UFg/B3BCzM082wowM2JG6I0qxF5eE=
Received: from CH2PR20CA0005.namprd20.prod.outlook.com (2603:10b6:610:58::15)
 by DS1PR19MB8553.namprd19.prod.outlook.com (2603:10b6:8:1dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Wed, 19 Nov
 2025 09:31:06 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::6a) by CH2PR20CA0005.outlook.office365.com
 (2603:10b6:610:58::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 09:31:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.9
 via Frontend Transport; Wed, 19 Nov 2025 09:31:05 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id EE422406547;
	Wed, 19 Nov 2025 09:31:00 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id D25BE820247;
	Wed, 19 Nov 2025 09:31:00 +0000 (UTC)
Date: Wed, 19 Nov 2025 09:30:59 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Andy Shevchenko <andy@kernel.org>, linux-sound@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH RFT/RFC] mfd: cs42l43: setup true links with software
 nodes
Message-ID: <aR2OU4se7lxcMtGW@opensource.cirrus.com>
References: <20251119-cs42l43-gpio-swnodes-v1-1-25996afebd97@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-cs42l43-gpio-swnodes-v1-1-25996afebd97@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|DS1PR19MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b25c96a-53c6-4fdd-261e-08de274e5d5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|376014|7416014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H5+aFFtYDeH0ex1JqMk8y3Qmr9eg3WjxufzQl8isfGVGg+mn4czNZxtSoGQT?=
 =?us-ascii?Q?q6ZQGvNyR4pHA9h8Uuubxsv2ME41q60ibSgpguE332D06CLP420YGxMtHs7J?=
 =?us-ascii?Q?e2wRU3XwpRO4BWlhaFdRpCrPv8vT3Pag2sMe3mE4VW5ZQmcPdpdPcPC5uwJk?=
 =?us-ascii?Q?g40thPyKoQsn1UURE8YqwYRPStPKyw241HUVLx8Vmk9VI+F6bhqytfYs9iUA?=
 =?us-ascii?Q?b24fCIf4V16xP2+J0LvPTQU8eeatSqM1mTIQ+siVrxB855YglVsWMMI+WGfI?=
 =?us-ascii?Q?seZYTYVBz2j2ztxofX2sKovepbVEqqKjZ8RMMYojBiU6iuhLnAkPh/Dbfghq?=
 =?us-ascii?Q?ynUXJtQpL7yYwSGPzNUW8S9FfK7YfP1I+TkStBmHN6HVfI5aEZIkI9WGiT/x?=
 =?us-ascii?Q?Xk0zXbDtE0pJqhnhevvQqYzJNsY7sAW7LTE052PNFSKESxo98dSQ1ORCzAfx?=
 =?us-ascii?Q?xG9U/LAMmcr7b6iC+BsI090RVKOQLWmrMyHgNUGkLPo8pPUPLZd0usZEUQ3T?=
 =?us-ascii?Q?htf+5yfKr4Mj9ZTZIKgvKWfWRlxt+HwBHTbfz3e/53y3kmMFIHKctsUeE5mT?=
 =?us-ascii?Q?+0+Q3SaHDznEg6mW8/26H82vQT9dfYvmo4u6bNbJTJFLl02YLMXEbqIxUx4g?=
 =?us-ascii?Q?HrEso+i6gsXqiSRgwXfV/jaCtM8mnKx8B4ZWugmSQ8ldB9KPAyCQT3Q0mYTe?=
 =?us-ascii?Q?2LQIc7NCcdQXx4EOT1Pi61y2hbqJLKIkwZHidMCSxPOTLeXyhqwy0uYEqQt2?=
 =?us-ascii?Q?BzcLmVXFT92AReqwkG1aiPSMkqK+tvzXZ7VnQIoHnWTn4raenQibyA132+bg?=
 =?us-ascii?Q?urZyjvhQHtwnPvax4vdmKUN8oFj7pMGQr7grMhYOBZqnr8Qc8vHnfq1apsdo?=
 =?us-ascii?Q?HiiQ1Yg48qCj1qv+E13EeOg7FTLB7k13S34eoRRwLQ7uhp7zwlgEg8YRnLIF?=
 =?us-ascii?Q?l7FWhU3kjqokoa5kbMRVvUMxoyHUNIrHO7/iAGSVpK03R5/Mi2nUWLyvB4mg?=
 =?us-ascii?Q?gbbaTdlZzQUgUGfLnuXQ1VcHkJBhle46GdE+oXv7fzYByvEPYhSwymVErO4N?=
 =?us-ascii?Q?lqxsf66Yy9093Gko/xhdsDMIjAwRX9NbVlpT18IDes7UTfrSEyPysIcHuOD4?=
 =?us-ascii?Q?gf5/Ka+Msy2wEvFP+REruy9rzru8LF1gBOaZMKPZCcFaakj2of7+it4EGAhK?=
 =?us-ascii?Q?cVN6gZ3WS/nm9y+rMss6L3U7hgszr8s6UKozJb+UX0TPMX0+7ALKUfSfpc9V?=
 =?us-ascii?Q?mOassHv9mpSCsFptWBXJjefP+HkA4GbXK7V7vY9HtC6DfqJB5dOpNxSIkv6x?=
 =?us-ascii?Q?CiPy1nEn7e+OZ7M3Op6EHr+22wCrUG1doPWldFgQYIxkQTE//L8bmVNRUGYV?=
 =?us-ascii?Q?hXk0DInEBcUKYEIEfQhAEYlanipjE4men08f3gSQAu2Ung3udskurR+4C9iO?=
 =?us-ascii?Q?ND43/XDST0DBM2W+IYqwA2sOCjpCNIhLsLlVCxwabuZY2Grz8SqLdermrHDA?=
 =?us-ascii?Q?DBaPoPp++sM83E5qwGx89qVl7lFB8aJgO+ydblDaeZcnbperUGxGJmvBViFF?=
 =?us-ascii?Q?dbwXYm53rqvLtdd+l24=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(376014)(7416014)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 09:31:05.7929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b25c96a-53c6-4fdd-261e-08de274e5d5a
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR19MB8553
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDA3NCBTYWx0ZWRfXyAmb6ALRW+Mj
 Uzz6B+bZNnV50v+JXDOLKE0fiVx+iRP7QE2udqow8F35qTUNE138FyNeS2vvBo5fY8LFg3G21WB
 X27Kpb1rPNBu/Dj1LiNC5gcMDqSsuyajJmrqvEnjcyyhhe3P0H1HvasHx4VznIjZKvbl77dj2bx
 GwZUyXX/sWUeYXN1ahfkfn71vSrti6XKYJ7kq2gz8DnBJJOkk5+3fnYxlhkpSUBcAITj7DuQFHW
 AEOI1DHTH1fmna+XmngqzWlAyrz7bkvcqQCNylnPwlXL6ntBZhEx1gdMgxY76LPoSgcKJwm/g88
 TWLQVYzezwubyfUOithFdfvOJ4CDSr7EG5CTqlb1TQBj06cifXHddF7NMDM9lmnpE2rYnMhVyb0
 NqUHxuJYvoOQ2xh5oiC7OJwA1plnyw==
X-Authority-Analysis: v=2.4 cv=XcmEDY55 c=1 sm=1 tr=0 ts=691d8e5f cx=c_pps
 a=rgmdkwC1tPsVJMj+r4rvFA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=KKAkSRfTAAAA:8
 a=BjVvaOLrJRsRtVGbhIUA:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: N4ylW-hZWyMsy5KiI8LoTfYxCZZREyHX
X-Proofpoint-ORIG-GUID: N4ylW-hZWyMsy5KiI8LoTfYxCZZREyHX
X-Proofpoint-Spam-Reason: safe

On Wed, Nov 19, 2025 at 10:10:24AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Currently the SPI driver sets up a software node rerefencing the GPIO
> controller exposing the chip-select GPIO but this node never gets
> attached to the actual GPIO provider. The lookup uses the weird way GPIO
> core performs the software node lookup by the swnode's name. We want to
> switch to a true firmware node lookup so the actual link must exist.
> Move the configuration to the MFD core and connect the SPI and pinctrl
> sub-devices with software node references.
> 
> Fixes: 439fbc97502a ("spi: cs42l43: Add bridged cs35l56 amplifiers")
> Reported-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Closes: https://lore.kernel.org/all/aRyf7qDdHKABppP8@opensource.cirrus.com/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> Hi Charles!
> 
> Please give this a try. It's only build-tested so far. I hope I
> understood correctly that it's the SPI driver that needs the "cs" GPIO
> from the pinctrl.

Unfortunately it fails with an -EBUSY on adding the MFD children.
I will investigate a little more and report back.

> +static const struct software_node cs42l43_gpiochip_swnode = {
> +	.name = "cs42l43-pinctrl",
> +};
> +
> +static const struct property_entry cs42l43_cs_props[] = {
> +	PROPERTY_ENTRY_GPIO("cs-gpios", &cs42l43_gpiochip_swnode, 0, GPIO_ACTIVE_LOW),
> +	{ }
> +};

This drops the undefined node, that is important as it lets the
SPI core know that device is using an internal chip select rather
than a GPIO.

> +static const struct software_node cs42l43_spi_swnode = {
> +	.properties = cs42l43_cs_props,
> +};
> +
>  static const struct mfd_cell cs42l43_devs[] = {
> -	{ .name = "cs42l43-pinctrl", },
> -	{ .name = "cs42l43-spi", },
> +	{
> +		.name = "cs42l43-pinctrl",
> +		.swnode = &cs42l43_gpiochip_swnode,
> +	},
> +	{
> +		.name = "cs42l43-spi",
> +		.swnode = &cs42l43_spi_swnode,

I will need to think about this a little more but I suspect this
no longer being conditional on the magic ACPI properties could
cause issues if a system was to use the SPI controller more
traditionally and actually have CS GPIOs in the firmware.
Although maybe that real node would take preference over the
swnode?

Thanks,
Charles

