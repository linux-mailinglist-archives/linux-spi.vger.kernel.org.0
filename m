Return-Path: <linux-spi+bounces-11313-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 681FFC6EAA3
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 14:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0BAA83A6B2A
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 12:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03974355039;
	Wed, 19 Nov 2025 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="IAwlnLmQ";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="swfYg07O"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D906235B13C;
	Wed, 19 Nov 2025 12:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763556827; cv=fail; b=Y54iPqmWjo2SJHzDxj8/Gbaxjm8wakx4B2OEz89FjzaqQOHwuQ8KWN32jFBFdM8T6PjrBDN38GTR7rGWzOlmytVo6V3IwSpF0fDC3lo+daxk3UcGvM3yl0V63sAh4uAbwy9vG5zhqAlmgNrt0HpzEWNcMR+CeBc8/Q1tnt3PxwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763556827; c=relaxed/simple;
	bh=ZqdCLwy8RGcJCHDC3Z/3eg0/2R0LUeAU0zBB7czuZ2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMh4sYF1Lz6A7UAm5GovOQVZTN4Hi+J1XRo8Otw6epFDFjXZayETU4FbSAIKtvlNZ0NwI3OiZIEch5FG3FTjCmShSjP+GQnDZ037czi19q3Rbw8e/LPKYEduWSeNayDQJThUTmhCfpNnZ+9jTuX2lhMVtnqozKOOLOPGFCyfHZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=IAwlnLmQ; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=swfYg07O; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ5TIoJ2134745;
	Wed, 19 Nov 2025 06:53:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=OXT+uJgZKuBKQlGu35+0yzjkgHBXOEtJHDrKoi3jMbs=; b=
	IAwlnLmQs1ILCx8CyKGtjzTkqpftkpnhwzQnqHAunKNpSEEhjFQm/jjKAjnWgAM1
	O8apgJ2D+D1hpObRORDccnCxOIuYHfr4W5TR8HZtrmJkFtXhJshGcoerdpsJs9c/
	2qnagdGSHMBZbLz/r02cbll43412UEITNskPxVtrFiI2VBLYc4IM+cgNkzsEI8I+
	gg/nXBcP7DuxAitQZ4x/TTw73cmLjHmnLBa24xcDJ7TS1o3tnHdYPg17u/uBP44T
	imshWaa+62OqHXuQanfOprEXwOB6GiPu2uaITa7A0Wfqtr9JQO0KkQrKAXwU9vvv
	Hd/n1kkvIcZmWMQ2Fa9QdQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020076.outbound.protection.outlook.com [52.101.201.76])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4ah1bm8uaw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 06:53:22 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfVRt5MpoX8kpZYm6uOxRei29uH5V4UFMdpYoaxoe5Xq9jFFSQizsl1Okv9UMkoA0qAvAM+AFB8AnkONbOW/18+2OlpQzEroav0XWKEfaH1dbKm+L8MGmdJYlxst7XOkLj5/6URDcmjp81KB21DH/RSyh3+XkuRxsLxBHYz2a2vrwTEgWqnp4wpv67kLxzLHojb2tPiIgY1qC4jfwHkRcvPUMotYUweOWbJ4zcHgJD19idU7RalHVgpc3AjlkfShznXJ849bfEzQ7GkE3x19X+bt5BHuZhoaP+TyNAJrpfvsC2JGYrznEByIlECuRWO+DbMmbizBIHWFKJ73Uquk5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXT+uJgZKuBKQlGu35+0yzjkgHBXOEtJHDrKoi3jMbs=;
 b=h5HUscRn34e4IRJlg5J2dTnT58j9FX0bc/w6AmCLA3rGBzJc5g4dZWI+AXuvF4J7LwNWlf0/z28uJ9cjjmj58h3n0ixQkturm0T23qD+wENkyZfixvzlwJoBRv48JNAiHzI4+lTzCTGJsdSxXfCeZPXFvpICeUalljStdcr2V/5WRh41aZlqzRMcEclK9IePf/Ckn3nGT88Vqqkws8bcbSp+5qsIiP2TKJDTHBtmbdrgqStnk9nE+ls+7BxlfTwQm+YeEZ9xspLoGDTcfscRkff0Ff4kXNG0emw84R2HtpQx6IBBDkWgGeJd6uRwZ+UvLXVdAn/7JNAHgkKuQTGBIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXT+uJgZKuBKQlGu35+0yzjkgHBXOEtJHDrKoi3jMbs=;
 b=swfYg07O5yRIUmCsFSbb/IpjqATFNW+26NI7Sa7iwtFCO96fnWwRHHob/tbbt/WkJs0xnspE0zoA9o2+LqayMKNU9b9JKQWdwQAez15D0+Mayc2HszhMhrobqM5Tnofi19ZvWghO/ttu+fzP/dP5+itrEceSQ4/Xw65G8U5+juc=
Received: from DSZP220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::14) by
 CH0PR19MB5313.namprd19.prod.outlook.com (2603:10b6:610:fe::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Wed, 19 Nov 2025 12:53:16 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:280:cafe::a) by DSZP220CA0006.outlook.office365.com
 (2603:10b6:5:280::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 12:53:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.9
 via Frontend Transport; Wed, 19 Nov 2025 12:53:15 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 7B79D406547;
	Wed, 19 Nov 2025 12:53:13 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 62B6C820247;
	Wed, 19 Nov 2025 12:53:13 +0000 (UTC)
Date: Wed, 19 Nov 2025 12:53:12 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Andy Shevchenko <andy@kernel.org>, linux-sound@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH RFT/RFC] mfd: cs42l43: setup true links with software
 nodes
Message-ID: <aR29uKW7yLxws9jA@opensource.cirrus.com>
References: <aR2OU4se7lxcMtGW@opensource.cirrus.com>
 <CAMRc=Mc==X3wERStdXmr5A9p0sPe7wdrPE4GZuqPLaKoBb9O9w@mail.gmail.com>
 <aR2Uo++k1NKkk2sj@opensource.cirrus.com>
 <CAMRc=MdFDAmqcJ3PMsTbeZUb9imM+fzHzQ_9mQ1T=syDoCcQJw@mail.gmail.com>
 <aR2gVzKhfN38MHAR@opensource.cirrus.com>
 <CAMRc=Mck8MiAm_nxY_L6Zw4cH-vYf24zSkPp=bhnUw68Q6FV=g@mail.gmail.com>
 <aR2i6lNNWEbQk0fx@smile.fi.intel.com>
 <CAMRc=MdYcdrQSDWKDHrx4-Y4-y92AQqr73MoRC3ws-X==SL0MA@mail.gmail.com>
 <aR2o2R30TbVOcqZe@opensource.cirrus.com>
 <CAMRc=MciO0WYejOYZduqE73U4OVTxcaMfe6Sv1VXWJWL2FFNmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MciO0WYejOYZduqE73U4OVTxcaMfe6Sv1VXWJWL2FFNmw@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|CH0PR19MB5313:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f181aac-8bec-4400-92fd-08de276a9afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0pIM3VzVFpBSlFpZGhMQVV2OGJTM2p2cEZaYXZvRjIrQ3BkN29TRnpZZ1d1?=
 =?utf-8?B?dStPamJ3dFBpdndHOUtGRGw1cERuWENTbDFZbmdyV05ZeG5kQk9lV3lpL2lL?=
 =?utf-8?B?VmpOSkhqL1V2T0ZxZ0lwS3pMVmFDamREYVhpU2w3a0xEaGVSZ1AyZ090SjRo?=
 =?utf-8?B?cTNTMGVYVWFQNGhhTDZVYWY0TEVTT0YzVzBNc0haOWxteGo1QnRUT2d1SmYv?=
 =?utf-8?B?SFJ2WUpSNHlHODUxaVN1Vy9MMERZSDdaNDZCeEFNVkpBSytJV3RvT1h3dWtW?=
 =?utf-8?B?SzJ5ZnQ3Y0NrTWpxZkdVTnl2d3dMTXFhWDZUNFU1TTJxMTNmNGdXUTBUelBY?=
 =?utf-8?B?OXd1OFV5eHZ5QTFPQjZVY01WWDREODdXSjl2eWNid2tRM202dDZ4dzlGY3lZ?=
 =?utf-8?B?UTNHZDViK09DTEllZkFOTUU5ZFVDbnkzNE9GU0paZTZha3ZMem0xd2xMQ3NS?=
 =?utf-8?B?T1ZXcXJFalkzTkhML2N5YkdnSUxpYjZpeHdEQTJ1cm80NCtEb3dZZVNrWFky?=
 =?utf-8?B?TTYwbkxsSFR2czAvR3A5bmoyNjhONE50ZnJzbXlRVHkrSSt2cEE3SDkvc1Vr?=
 =?utf-8?B?MzFzWHJZeDNTcmEwOEZnWUtPUmsvdFZOYkgza0JOcE14QTEwUzBsNnhidGMy?=
 =?utf-8?B?NFVmNHo0bUI3a0M0UVh4VGdPVXhKV3FhSE8yU01QZ0oreEdneVVkTFRMYTVE?=
 =?utf-8?B?dVNNR3FjQjg4ekY4L2Q1c2JHZldwcGNkcnZMV0ZLZ2JQWm1nQTY2SzRwMElQ?=
 =?utf-8?B?UXVyMEpLVW5JVnR6ZHJVN3NCMWt1cjZCUXp4ZTJIbUNvbFN3REpwaTdCakN4?=
 =?utf-8?B?Vi9NMVNNNnFVdHNKbkUwVm1mSFBFQ3U5NTNTNHdvcklZTlYxSTFXazlxTVpJ?=
 =?utf-8?B?NGNvNExkOGJFNU1zVDNvMHExTjFTOWRRUDYraUE2K08xVUs0WU5mK2xpbWd4?=
 =?utf-8?B?VFZ6Z1k4Rk1TOVl3QnZmVFFlek0vYXZyOFREN0NEaEtQZ2FUVkVxSWZsLzVU?=
 =?utf-8?B?RVlhOFZiVmZ1MTBXSlRVcncvaGNwWThuelVhdTBoNWcyM1RCQTBqYlJ1Tm5Y?=
 =?utf-8?B?RW54Si82QkhGTHMrRnRnbFBDcmNXWHg4SzBEUUlPNlFwVFU3TGgzbUcvMTdO?=
 =?utf-8?B?UjFyKzhDZkIrS2l1cFcxUUI5S0MwaldRYWl5VmF5QlZ3N0ltdmhCbXZpSi9D?=
 =?utf-8?B?cmlhblZiUFh4ZExZSHNhR1VsbGZlR3FPRXpTek1GTTM4K0RGYnJseWcwMVFo?=
 =?utf-8?B?WGp6RkdpNE5uREJIK1FpTkd0a3JRRm15OXRrdXU0RWVxejRrZVVQdFo1c01G?=
 =?utf-8?B?bXNHVkcyTVhlenBZNVdNN0RsYmNIL2tCTkVRN3YxT005WW5HU1U5TUg3NzBY?=
 =?utf-8?B?Tm5sU0VWd2Z1MzNGVUEwL2hFV2lDYUdBUW5lVGRGcHdZQXhiOVZEQzJlUnlm?=
 =?utf-8?B?aEtyc2w5NVZpajJoTzJubktuYzU0L21RakhXYmY1dWJwQ0JKSldiTlc3SXli?=
 =?utf-8?B?UG1tZWx2NHJGa3F0WEhyUUdUbkR0VE1Fc2x3KytLSnRGU282SUpKb2I3WFd4?=
 =?utf-8?B?Y0oxaVVKaks4b0l3UzJRbTFNcDd3dVpFZHArYjhUempJY0x3QzNUMTBPUGhI?=
 =?utf-8?B?NGg2Sy82dVNXeU43eWZCS1lTTTNJaEFSajk2RmF4amd4RHZWcXFhNXYwNFJF?=
 =?utf-8?B?N2ZOQ2xCaUpBV1hRK2V0bzBaWEJSZVJOZi9HSjVUSk5YQXoxRVJFcGZOdUUx?=
 =?utf-8?B?WmVxNWRtdURxUVJ3TWJVWVNPRURPckdWOUk3SGtXayt0c2JHbm9Sc3FFMzFw?=
 =?utf-8?B?WHJiMlJDMXVmZ0VvRVJQMi8rR1g5ZHlsYXZRamV6N1JMeDhyOVdnSVFSTXN0?=
 =?utf-8?B?aWNiaERwQ2dzQktabU9sRDBVUnJ2QlhPQk5IL2gxSlc1V3VpaXlrWVhZRmJk?=
 =?utf-8?B?ckVERVErRzFGT01qQkdvN2pvc2ZzcTNiNjd3RkNtMFhDaFNHWVlMNlpUNnFZ?=
 =?utf-8?B?OWxRZ3ZYYkxJUXpoMlBFUlZPQ3JLVTE0THUxRHhRYysrTUZjQWJuandQV1l4?=
 =?utf-8?B?alVmOUQ0ZXJIRG1ZSURFbjN2ZEtibXZTQ1AyWXFwWFVibzd4Z3I5bm5taGxF?=
 =?utf-8?Q?8WoI=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(7416014)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 12:53:15.0782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f181aac-8bec-4400-92fd-08de276a9afe
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR19MB5313
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDEwMiBTYWx0ZWRfX22W3Rx+l9qhQ
 /ziaGS7TQ0TxRYLRsHDGsZ5srDGFhEXtsaMBAbirnDTD/ClpJPj90+LZQ5DWYWQvJkcHyBkOslN
 sM0TwIkdd+YGOrl4opyoPTGcu/UK+ivaKyjUAQXkfYdZ2alqWj1uRuqLyW2xeiOYOYT1OhplYr1
 6Da9FUGT/ppovh6hL31ybetW8c0sKxuXIx+LsDIrHK+UUTGZ6yCqH8LWhiW93r/wzM0NKoS6cgv
 RunwKBfkafr/WzXwcCYTAHvtFw2bZHJ4WMuSfubzwdXBVBnbag4kIL+v6jUije49J8ZQxQ7TqGz
 sQBh7XKDcsOUbtAxiQEbMfJhXGZjKfxspqRQxTfqO/KrwjhHpUzTiCf6x9nR+MrOqAP+VUFRfju
 fheMm3lCy1jQaJHnRTk9ojRVEFgDLQ==
X-Authority-Analysis: v=2.4 cv=XcmEDY55 c=1 sm=1 tr=0 ts=691dbdc2 cx=c_pps
 a=wcWRxBclbL8OLrndhT266g==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=OItRwglS1Sd-cWJ24hIA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lCe0VILtX3yK092z3TYYQ54SRroORYyy
X-Proofpoint-ORIG-GUID: lCe0VILtX3yK092z3TYYQ54SRroORYyy
X-Proofpoint-Spam-Reason: safe

On Wed, Nov 19, 2025 at 03:58:08AM -0800, Bartosz Golaszewski wrote:
> On Wed, 19 Nov 2025 12:24:09 +0100, Charles Keepax
> <ckeepax@opensource.cirrus.com> said:
> > On Wed, Nov 19, 2025 at 12:06:57PM +0100, Bartosz Golaszewski wrote:
> >> On Wed, Nov 19, 2025 at 11:58 AM Andy Shevchenko
> > Ok I think I see what is happening now, the swnode is created on
> > the first cell (the pinctrl). Then it moves onto the second cell,
> > but mfd_acpi_add_device() copies the firmware node into both
> > devices, the device_set_node() call at the bottom. So it inherits
> > the swnode node through that primary fwnode.
> >
> 
> You probably mean this line:
> 
>      device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));

Indeed yeah that one.

> What is the actual device whose node we copy here? Would doing the following
> help?

Its the actual ACPI node for the device, the cs42l43, sorry if
that isn't what you are looking for not sure I totally follow the
question here.

> -	device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
> +	acpi_fwnode = acpi_fwnode_handle(adev ?: parent);
> +
> +	if (!is_software_node(acpi_fwnode) || !cell->swnode)
> +		device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
>  }
>  #else
>  static inline void mfd_acpi_add_device(const struct mfd_cell *cell,
> 
> > I am guessing this code has perhaps been more heavily tested on
> > device tree where it is more common to have nodes for each cell,
> > whereas ACPI is far more likely to have a single firmware node for
> > the whole device.
> >
> 
> If my logic above is right, we should not set the node here unless it's
> an actual node coming from firmware OR the cell doesn't define its own
> software node.

Will that not leave the MFD children without access to the actual ACPI
node though? (Not tested just eye-balling).

Can we tackle this the other way around? Since there is only a
single fwnode for the device, can we find a way to get away with
a single software node for the device too?

Thanks,
Charles

