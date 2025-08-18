Return-Path: <linux-spi+bounces-9511-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BE8B2ACA2
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 17:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 980B15E36C0
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 15:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07781153BE8;
	Mon, 18 Aug 2025 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jAEn1mI+"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013031.outbound.protection.outlook.com [52.101.72.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9706A2550A4;
	Mon, 18 Aug 2025 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530381; cv=fail; b=Mh88qScox7NwFVT5R6sKbMMsWZdznCyYbgXtcc2zMfJ5vb41J61lfb1Z+U5cHjTnSZasIj40nOZIsezbLW9m7wNOqS4wBR4vakDLlvWq+UMymo95aOABo9cbm5F54qH7bYFj7fH0P8L9jgg9/YfjU15fiuXrbEvYCzjX/YcuGd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530381; c=relaxed/simple;
	bh=jRmiJvsiqTXuk2l8vzSCAxmBsBTl8DmhC6IEbUTCTo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=caLBECeM8zK8SB+RtZqkdIGmcYotFRcuIDmkRg3uGaJEckW4wNCCokQCHp8V8R9u4yO1XiADPsCGNDYNCM0S+UPW2cjgmgZNptThMLGtpxHEgu5odiIH/aG5fudEUjqQbwTgTl/XaPZkvuaFHvo1dfdRajViwi58CUzBVrqsQ6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jAEn1mI+; arc=fail smtp.client-ip=52.101.72.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WE2s/XCHl86vu+qJYQ1fptW9B4UvmZOyJyGRPjz+ERT/oZrfcPPXkhMW1xAl2uhuFz41wCcR6CBcUGTssn2aR5HkxBAaxfZoV4r3J/rKY4tXusf0z/bICPpgfF7JKBVGNGVVH+AZ+Jd0V78FVmFD0iwXRWiO7Ld8KrV5NpnOxxv998wJh01g/+R2JPhv7KwxdaspS3UDrGKwK9JdDP/Zzmt5t9co3TO9FiDglk2cxPfUOVaVX3yalXJIosf+XrzZuaTaA19HbfsbHW//EVn7hKcJ3W9sL6c7uf6yfm4OGnthZPDRYtq8eEyntnmvdd0MIslAfn473eHuDDWxSnwTUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSTDCnjA0sv9CWzVIr1kfwJ3NCy4iLWP6VoP6QV6r90=;
 b=moPHonz5+aWKlRzwUxItahgLk5Ca5TGODQpN5TbMs5aUN45jsmZs6GPcznr/9v0Lrc75+Msw6iLEyidxllEjP0B/SQSTDslESwnTJUlL+NfpJVqsBktjB60FJSeEBaIzZwUg4XNAxXnjDQAHNf3ThZOQmRyHWENyxTn07jQkOOxzIPnrcsuoj924OWHLnAvxTTqPNzOXNBXxlthsAeGav7LTpVVXriBrz03u3y0yf8CRht5czEGqgVVPqnxDeeYLN+laMvmWD4p9mpr5O9r0qkFJjegaRWL1AEhze8xS9hYhRA0wnITKTe/MNhW1T0Xo5juhDLG6op3WOfpUaKpNRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSTDCnjA0sv9CWzVIr1kfwJ3NCy4iLWP6VoP6QV6r90=;
 b=jAEn1mI+mXkqtjvPQHoaveRqrK+t4vrRETZPCcQFHwXOl0yrL97Cv6uRmZYXy1cxR6u22Cb5+0hkMUSAgYoFT/vmDxlIWA1rbHBIxJIET0ryLe9cJF7DhTUkKB9b/UeQj63rCCVlyqPTTT7FpFj0y2ex2ps8fZgUx/2R2sOPeYEVUo2F6gCe2Izxn0tWD9NOs1jyMT+FQMoq95erUthFkqi4QFtSezmpT1fgA2XVTxsEGfpMhQHV01TVUk3raTJr6QoiRcJxoponBTfoO2nTS/lcoyeOido9piqh+7QAAejnDqJ2BxyJ51plJG4zM3VRXQbJklcFQmjBcKwkyYA+Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7562.eurprd04.prod.outlook.com (2603:10a6:10:1f6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 15:19:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 15:19:36 +0000
Date: Mon, 18 Aug 2025 11:19:24 -0400
From: Frank Li <Frank.li@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
	Fugang Duan <B38611@freescale.com>, Gao Pan <pandy.gao@nxp.com>,
	Fugang Duan <fugang.duan@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 02/13] spi: spi-fsl-lpspi: Set correct chip-select
 polarity bit
Message-ID: <aKNEfJrD+pp8+0dT@lizhi-Precision-Tower-5810>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-2-9586d7815d14@linaro.org>
 <aJ4TkKdkIPiJhhF4@lizhi-Precision-Tower-5810>
 <90d40899-c9b8-4628-a0b5-06ee0aa497be@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90d40899-c9b8-4628-a0b5-06ee0aa497be@linaro.org>
X-ClientProxiedBy: PH7P221CA0043.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 14ad2efa-1cec-4ef2-40ca-08ddde6aa425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|19092799006|376014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4Ade2ImeDYEqm/n0ZmF/K7Tkdfb4/MJMOdFocLSC8iWP7cKROcavZbQWAJRx?=
 =?us-ascii?Q?91nsBZM4HpvqJsTGUZbsphLYw0nFsC9ULkU1ms2Cs2zy1OmPkQBVpVASODrM?=
 =?us-ascii?Q?MqX+XdQY9CUaDvkNeCyn9B2OOFJygiRdC8e42/BOU9R9pGrOPMRvk/BXAnL3?=
 =?us-ascii?Q?jw5k0bH2vzFZdpT9m1aRJTeOJCNSvOUrxtsvnAd0g7TLsri6/YCkjZO3d+rs?=
 =?us-ascii?Q?Wc2xcIEXjYaYiKvMRB+lZnDa0TrBnCwaJ1d4Btbb3tc5VxyPtyLDzGRY1IDV?=
 =?us-ascii?Q?qGfYRcSeh5h++6r1ULOOCL2tNp2MQXzTujKl13Rh8MqWS58B/O/12XQ8GS3k?=
 =?us-ascii?Q?uQmLQb2xhicJO3JXqA9c8q9bUoGvSmImYMpb9sGlermYp+e5+jWsFuT/HYCi?=
 =?us-ascii?Q?yIz7G9kpjoEGySZRrE8EDQiJmTi46iCwuMMQ3tIsk1J5xjdxqrCyBK37LOfw?=
 =?us-ascii?Q?PGcn9nY6o2sNinz2dUNmUXbgyPBTXtP0uNS0uA9tC+Bzyqakc9jcsy88fBmn?=
 =?us-ascii?Q?iD83Y+VpFpYHYNtwSZtjjGQeg7q34iicR3hwPP1iCrah7YNHlar5TFUWq0eZ?=
 =?us-ascii?Q?TKEHAEE/Ol+PNQgf2IXYSx11x0FtcbVBKU6J2Wbk/uobfsUa4jo0205Xwx5H?=
 =?us-ascii?Q?Nu45Divqj9x5Tt7oG/z2YVzn+be8JdxeNccrv13i6KEshXoG1YziVOFz+I5J?=
 =?us-ascii?Q?k+CF60xXQnWvvmOz94gzpTSItGkUDZ4SCoI+TzTT98oN+0aZzfdnnvTx8sbk?=
 =?us-ascii?Q?7vVAZH6uw57SO5hnnIN9pR1EuZ0B1f8/SDgC8zod+zTyo9UxWGUoYNoq/x20?=
 =?us-ascii?Q?n5cnGncDjX56IUV6MLodi+nhb7tdn97p5R1AYMzhv4CFK9IQEPSFhDVaBqwC?=
 =?us-ascii?Q?Nu4zx3HDEK5QW7U0ej+pxZqosTDbUXWbgxBj1MTAk0mPdbzdPAq5ikTtgp5/?=
 =?us-ascii?Q?J05Tn/v8u4R9uxoYxcL9Y1yuf8vIhC78Jxo5WxEaDMwxTV+p4MqEeyXFYBha?=
 =?us-ascii?Q?9c4KdiWIr1mo2TWtsMXmpaKzSd6deQ6Z9zMpsBHRL1rgebImUm6fQ2nQMxD3?=
 =?us-ascii?Q?Pu3p6uKuwvr/SXlzbdfqf19B0Abc7qt28AJs4KZYaS2fHgbvo1Je6LNjOreV?=
 =?us-ascii?Q?bPrtMx6e/MYfEjxIqlE8P67X1ka7e97hZHTWQSpvQ+FjaEUfOyKj5JiAA+nZ?=
 =?us-ascii?Q?2s6DchlnJ8aSbrxZwJpTnODP4v/uM3TvzudC6s0LJQHiIy53peKidfXG7/qF?=
 =?us-ascii?Q?+22h4rOJC4Fm3hb5SVemUOSTol/n9j0AKI5yOf48YJ8Au5X4xwhT1KUH6a1i?=
 =?us-ascii?Q?uxQ3pbV6dBlBbsketz6s+me5llodiIEQJpX9WvqGgYkIjqRB5v0hEXWw4Lti?=
 =?us-ascii?Q?C/ZyM9a91Ts/BNZpYT+8MbrBPENYxeuYJHrFgRoD+WUKHeuf4C8VjbxIad5q?=
 =?us-ascii?Q?cSvCYdiAZ5osRYtBD04UkE13Yr3PCTMCxXIqVt8OV1lCoLHPw/Y+FA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(19092799006)(376014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DCbamx21eYkT8bjatLLno29B/wrSsxBybyrGhsncCMZ/4fCpN8xaAs3sReNV?=
 =?us-ascii?Q?AcTB9x7b/2LaFgR9zRl0ZwqMvQIjv/m/wKMXCljpTpmeRmSgx2j3Sjk1hWvk?=
 =?us-ascii?Q?NY1d4VwSWNL2nJROk86z1cSrXpBEj9GkcJXiK/MXzxndMFqI1Pxvga/wu0fs?=
 =?us-ascii?Q?CV2RvnYJ7fqC5kGKk1cByKvEvvWJ3wgHI303rA+ZBvZ9cQbEtta7ZgUV+9DW?=
 =?us-ascii?Q?6GtJcFIz23vVA6h5TbmOJt0LLU1WRivK8PLhlTHt737zT99QjRDi5szVx0Dx?=
 =?us-ascii?Q?9Y/BytnheCI8s+THNObU677CIiOmGkHm9iGtjyHwUAcaicc4VRxv/K7mALro?=
 =?us-ascii?Q?w5fwE5lPIC8wHN0pHY94JgLIfUTeQ9rMB3wpJor+3DvTPAJffEWLeDYbvtDT?=
 =?us-ascii?Q?M8kHtcZ0yzmzt1IWmOSVOIzKiUwEoRVnscTaaTr4aCAGw9f2cZQfqM9fwBsG?=
 =?us-ascii?Q?xpiTzCPeBTYUr8/1B7ERLpuVdtjFCg5Q8jGBt9Kmci9kIQvWYw3fRTA2euLU?=
 =?us-ascii?Q?dzMtQHFRYErZS+I35z8ohZB4YnDOtdAPuLGEOfeMPvZZ24aqHPesMQ+CcQYe?=
 =?us-ascii?Q?SE8qlUgsJ/rrU4KtkjDQGRgYgtyZHpp8T6E8N3X4mxMJ5B3HW6cxcAfRoPkV?=
 =?us-ascii?Q?zespga2OWzUYzbnQKR+9Z5k+H/Vjow7ypTDNfVPUNzhxCyk/nfRDHqQPOZib?=
 =?us-ascii?Q?EVQE/thZtWuNvhJ3dtIZdvUYYVhoqf8PM2JS09RHDGDSgtd6B1AHuRlTBnNR?=
 =?us-ascii?Q?j7jdCzJqehDEHYQYxOg8UTTboWKDoIYFPpyZS6ri6LRuGn8ZS5vrOFdsrHGa?=
 =?us-ascii?Q?Bgnf6ALai6iWHx/5Kh+HaeOE5oybHs746ai/Wyh5+R+myqvMqdTgz1C6kZqF?=
 =?us-ascii?Q?gVSkTfHeM1FGMN/GzeNZiR0uA45MppZpYus3A1LUDULUblbJISY1yqoEqDFN?=
 =?us-ascii?Q?K79XB8nWhbd0Do6/41HxRbqWs99R26e85QjeargxBsndG4ftMmaQn1QkuYj9?=
 =?us-ascii?Q?ndT2MxsaM6bsEdcaeM2uPS/qNpYTmENBpOTpwB3oEHaUFNfKMlk+Sz0yLqwh?=
 =?us-ascii?Q?KQEu9eY0Q9cUScrJE7BAYvk3Zjo59mu4CLtXGYADt68s5SiR+jiJ8pyZlzLQ?=
 =?us-ascii?Q?hziYOHQrRo4ld0f+CLAaPKlAstaV/jWQAE/N2d7ICS0BK3qTaAu61zDG3yBk?=
 =?us-ascii?Q?TCU96AaeX4XePYDPZaQbTS1Knh8ooChxRr0XCK0a76HpkfdT84JYSuoEZh7Q?=
 =?us-ascii?Q?8jYAJFC3Rnv2Yr7rUoVIWOH6b2u7IvHacf6f5Cr3OHgxKExJ0s5m/9dfB0WR?=
 =?us-ascii?Q?ggH3ydpbN6HRjNSaTh/2JM3nyJcaU30FeONPptVRcfy4UE293XO7B3+xIHwV?=
 =?us-ascii?Q?j5gMWKtYUs8i7qmnrgdct/aPXgIGlASUNSqE/zkXGC93iRYIDAOiv7tGLJnK?=
 =?us-ascii?Q?WUx6hHX7DFEsNcLZy/XOlGbM+2EP8vSzMUP0FyTpHsmCzelV+RomVOtk4E78?=
 =?us-ascii?Q?tRl56M+8qRlE6OTKhXfFw503Qq+mi++5fDxjoXC4qJAyMl928Th3HfFwyunh?=
 =?us-ascii?Q?We1RynJO0u/6CaMbUro=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ad2efa-1cec-4ef2-40ca-08ddde6aa425
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 15:19:36.0151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlrVFM3hD+Nx+8W6igQbFhI3Ul1Q1BVZL50EbM9osMkW2t/8/BjLagxLVHe9SRglH7NbVwJNpBanXj0hgvDpNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7562

On Mon, Aug 18, 2025 at 02:05:16PM +0100, James Clark wrote:
>
>
> On 14/08/2025 5:49 pm, Frank Li wrote:
> > On Thu, Aug 14, 2025 at 05:06:42PM +0100, James Clark wrote:
> > > From: Larisa Grigore <larisa.grigore@nxp.com>
> > >
> > > The driver currently supports multiple chip-selects, but only sets the
> > > polarity for the first one (CS 0). Fix it by setting the PCSPOL bit for
> > > the desired chip-select.
> > >
> > > Fixes: 5314987de5e5 ("spi: imx: add lpspi bus driver")
> > > Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> > > Signed-off-by: James Clark <james.clark@linaro.org>
> > > ---
> > >   drivers/spi/spi-fsl-lpspi.c | 6 ++++--
> > >   1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> > > index d44a23f7d6c1..c65eb6d31ee7 100644
> > > --- a/drivers/spi/spi-fsl-lpspi.c
> > > +++ b/drivers/spi/spi-fsl-lpspi.c
> > > @@ -70,7 +70,7 @@
> > >   #define DER_TDDE	BIT(0)
> > >   #define CFGR1_PCSCFG	BIT(27)
> > >   #define CFGR1_PINCFG	(BIT(24)|BIT(25))
> > > -#define CFGR1_PCSPOL	BIT(8)
> > > +#define CFGR1_PCSPOL_MASK	GENMASK(11, 8)
> > >   #define CFGR1_NOSTALL	BIT(3)
> > >   #define CFGR1_HOST	BIT(0)
> > >   #define FSR_TXCOUNT	(0xFF)
> > > @@ -425,7 +425,9 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
> > >   	else
> > >   		temp = CFGR1_PINCFG;
> > >   	if (fsl_lpspi->config.mode & SPI_CS_HIGH)
> > > -		temp |= CFGR1_PCSPOL;
> > > +		temp |= FIELD_PREP(CFGR1_PCSPOL_MASK,
> > > +				   BIT(fsl_lpspi->config.chip_select));
> > > +
> >
> > Feel like FILED_PREP(..., BIT()) is stranged.
> >
> > I suggest #define CFGR1_PCSPOL(x) BIT((x) + 8)
> >
> > Frank
>
> It's using an existing macro that everyone knows though and I found 65
> instances of exactly this. It can be read as "set bit X and put it into the
> PCSPOL field without any further investigation.

Where have such pattern in kernel?

Frank

>
> If we make a new macro, first the reader will have to jump to it, then it
> still doesn't immediately explain what the "+ 8" part is. Using FIELD_PREP()
> also has the potential to use autogenerated field masks from a machine
> readable version of the reference manual. You can't statically check your
> macro to see if + 8 is correct or not, and it also doesn't catch overflow
> errors like FIELD_PREP() does.
>
> There might be an argument to add a new global macro like FIELD_BIT(mask,
> bit). But it's not very flexible (can't set multiple bits) and you can
> already accomplish the same thing by adding BIT() to the existing one.
>
> Thanks
> James
>
> >
> > >   	writel(temp, fsl_lpspi->base + IMX7ULP_CFGR1);
> > >
> > >   	temp = readl(fsl_lpspi->base + IMX7ULP_CR);
> > >
> > > --
> > > 2.34.1
> > >
>

