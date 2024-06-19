Return-Path: <linux-spi+bounces-3455-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C88A390E72F
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 11:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBEF91F2219F
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789878063C;
	Wed, 19 Jun 2024 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b="ZpieGOat"
X-Original-To: linux-spi@vger.kernel.org
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2120.outbound.protection.outlook.com [40.107.135.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992FF81211;
	Wed, 19 Jun 2024 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.135.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718790011; cv=fail; b=YjCNfOUhBY1FZo38Oo/1Gee7PizSNSwR/4IqXpltjmfeG0kfcSV5riNqxBNpuj40e3ARGYpi3IcqwuwJXdMHhW2prbTVIjrZ9+HHWg6RTkp5nMKBX5DXbTwWbxpC5s0aGzGJJknX8jPRvx1jLms2dHJ4Fvhd3YbyCE9wQ2ywknU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718790011; c=relaxed/simple;
	bh=f2gRY0/UdksRIB8Z1UTouI4ehxSAiJOpgNkMtWnvfe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lpDDpgVM/Vbs2JQ0OF4LWFGbEhnc0yiKDfOicNB+cYKG59AEMlF27hiqBca4XS78pcd/R/J1+0OMwT7i0YKAVQ7zDaZStVVS14GNA2SWOu5JibruyK9/1z7XtGJuKxVwsKutiC3vyLFAimTGIAyEB2m3MX/YIqgrinLDobXRmiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de; spf=pass smtp.mailfrom=eckelmann.de; dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b=ZpieGOat; arc=fail smtp.client-ip=40.107.135.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eckelmann.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjM8R/wMB80fTzKEE5ZDZvB3KNCzRXXb+1RvQGP8fM3ODduxpGfI7SZPfhi2iegHk3evo1yJ05duibeiaNbt1KQohWKwen7N11PYLK+FKoCDrMqOl7M+cVKQynZVY2DfGawWaidOwo8X/Mo8bpfT+HGpmm336Mu4wwFyyJ6AeWeRHZsg3B1j649H7+LWjJLQ3bMDTrlGIrQKyNTk5skGlr5/GpstUHJgMePqsDRuBCrG6Lx6KimjOukLRtPLrw95VnkHPnPEIpOm396FNC/d4XDc4uS9tQ6uJOQy2cr2oTIpDptI1tfNU3rCYTFShG+3/mMsJ5BPYoPiX0X1q5zaeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJjKGpsHdvmbRG11BSodqV8A9jGnrsZfzHQMeS+irH4=;
 b=I5vedmv2I06/VtjnyrshXEoZDdmEQfl5YRp90iVBscJU+IMt3Ox2MqoZ+MFra+t7IHJfvp/a9IQlw4QWmV0ABnatdxwBkzbzcBJ+aDrB82IMkUUu8DaYJK5ByrAJehgWI7Eb5ekZAxgIQCmCpNKrXb96lyNOySPrLh/JllcKEl2TsYbqyGxGFJ/oKntuxrIUzda0ghsNrPHBs+GnQuLf4tAjTJLihTT3/LzRlXai6s0OAL94kPWBy/CbzIWokglDNeNn2cqrYE9EMjCdM2H5HFNtQD646cRJSqcTeHvstCaQCoC1dadll5NKhHaIDOvE2QuaLkQO2xeeze6MN6kyPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eckelmann.de; dmarc=pass action=none header.from=eckelmann.de;
 dkim=pass header.d=eckelmann.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eckelmann.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJjKGpsHdvmbRG11BSodqV8A9jGnrsZfzHQMeS+irH4=;
 b=ZpieGOatcJr/LSo3DiCTHimcrDTFYWooodROXVP2Q4iDdg9Xp7CChywIJjR7cjVDg72Ul03cRXto3/ojMGykPZuKf+lekKpuCeJqSIFU5UsXUNOhLWpSwWyTXedxlLTQQlY2EEacDUuxi/a5yCQbqKz/92xQJWoHo+MnZMqtq40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eckelmann.de;
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:da::13)
 by FR0P281MB2832.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:23::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 09:40:05 +0000
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3927:fe99:bb4:1aa7]) by FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3927:fe99:bb4:1aa7%3]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 09:40:05 +0000
Date: Wed, 19 Jun 2024 11:40:04 +0200
From: Thorsten Scherer <T.Scherer@eckelmann.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Stefan Moring <stefan.moring@technolution.nl>, 
	Benjamin Bigler <benjamin@bigler.one>, Carlos Song <carlos.song@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, Adam Butcher <adam@jessamine.co.uk>, linux-spi@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Stefan Bigler <linux@bigler.io>, 
	Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] spi: spi-imx: imx51: revert burst length calculation
 back to bits_per_word
Message-ID: <n5ih5hs2nq2q5lp23lcncuxguvcafy344b3ifwfrkowbx6sxyx@hurmlrr7co5g>
References: <20240618-spi-imx-fix-bustlength-v1-1-2053dd5fdf87@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618-spi-imx-fix-bustlength-v1-1-2053dd5fdf87@pengutronix.de>
X-ClientProxiedBy: FR0P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::18) To FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:da::13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR4P281MB3510:EE_|FR0P281MB2832:EE_
X-MS-Office365-Filtering-Correlation-Id: c48170d2-ad97-449c-4009-08dc9043cc8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A/nER0tL2DXtmNY9r4/+D9Q3UpYpRqdO/7qW/nbi4ZsnVeZYM6/5/d9+OBZY?=
 =?us-ascii?Q?qkDAYDmWLRemFFPQfX86LPxtEVVrE6QYV4BKJr/L4aU8KmWIr/pljWFlbQdH?=
 =?us-ascii?Q?M2KvQSjcwkiqO4JthRI/Cteodk2xfWZZDUB1ZwnPObimvlf0Wm4pX9LOC6p/?=
 =?us-ascii?Q?9gZJ8VJ3d2t7YV2VzAwL4ngrOw3zlhy+ebE3zMMnGlv8Fft9TmgwVIsG68ub?=
 =?us-ascii?Q?QU3aFwMFAbrxQKPcMbH54qqfHs0OfqHHR9ez4iG78ky25B14hFOvuTSQS7vm?=
 =?us-ascii?Q?+6cCawERpvFcId+LuQ0YeILZARVebkSAxk/J3rq/+6HQWncFoPeF1BphA7iN?=
 =?us-ascii?Q?psvw9Pogyv3oa+l5Zf+DCYJ/Kb+IH70t9kTqE+dbktl/E0/qXgWHUgosUwPt?=
 =?us-ascii?Q?nY/MX3jqAKSk1ybKUBSSZ8A7Ay5DMCJ1FvQ6xb5Rhlxae9oclODS/OtEKskx?=
 =?us-ascii?Q?AVvtrzlOIh1OZlJG9TQbqroi/GkGVNx53c+ce+BkPLwhWVVMDlcIGpU0pZMw?=
 =?us-ascii?Q?AoLSuevSWqFFkM+5Pz2aYYp2tHL9YyFFdm/xwKJ8jAcqCxuPdGoU8X5RDiRb?=
 =?us-ascii?Q?zmSb9PtDvg1A69ku5dRjfvwoYm9NkmbhQdFVZJtR8QvBOGiVJoVOOrz7fxqB?=
 =?us-ascii?Q?qgy0zz7sP4/0gUwTuCMzGvKBuRERZy8o66AlZ+FxU2NgMa74GcdDwt7dXzXA?=
 =?us-ascii?Q?pOMaswaHu+/zfOdDyU71TxJCfekmUh/1MusHtJma35VCz1NVYtDByiQbzSk3?=
 =?us-ascii?Q?Bv0Y07/OSIfipcjXmWyFdrknLRY1BtP2FJZbyQ55k2HwPfkRw9dxCwW5S0Qo?=
 =?us-ascii?Q?QteQ+sAeORrupi9guZD3tLZsk0MXA0+ZrlpblgTT6mRlmnynoUdZVu7qtItf?=
 =?us-ascii?Q?tYarW2DeELflBpvjvu80yONlfePlCvAkAGwrBUf0D6stHYoc9NDwvbphZMPj?=
 =?us-ascii?Q?V8ZPuxFGeU7+ZDEcdpFI+I8lvKdCDmRu1O8VsFveGz6I6rgYmfm9eku/aABd?=
 =?us-ascii?Q?0mx2INrmKaUZdPgFa+jgWkHTF/TFQGOvAozahVj6VLXsp4OrKvX62qFBE9J3?=
 =?us-ascii?Q?Nm7xr7deagjQeDNZ1nw67CQK6ZWJsoKi0XARV1+L0TVA8VSM5163pDbBVKZ5?=
 =?us-ascii?Q?ccNdobdDIbT5KKjzM088ltqJJ9DwBdtq1wfl5CP/wDbcjxiMPITlBtxvtqW8?=
 =?us-ascii?Q?ve+AB/HbcbodpV4FcZofk3w08VHKHaXrGyhMNvWh8/QSO4dgcrS/QZd9krYO?=
 =?us-ascii?Q?zoYR4osl0kfoi+ooQnmG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2kiXgETKkbazPj8H5bpqjOdgpCOApaXUPgQmmdawkDaR1h4WdIaz91EcCR5S?=
 =?us-ascii?Q?6ae638Jx6n6jNi3Niw2mV5ZTPG3cPiOaJzHEgiCHyeWWCMxahtsmNa/Wzmc8?=
 =?us-ascii?Q?thm74gjalSchqBjhJRKYc8Pii/F+/xS47m3OM9WLOw/K3aHhyGlWe18xqFfI?=
 =?us-ascii?Q?dpAfTkSW0XMR0duFJ/dTjoptwtcP734hkqYjuP3DXgK4FrW5aUcF269vD+5u?=
 =?us-ascii?Q?gttqPT+e1w5nzpfWqUZRuMtQj47Z8gp+qkC1ez0s1suedBiFllB5XyAxKPSc?=
 =?us-ascii?Q?pCWedC7ImZqceX1rGmTQsgvr3NMTKH5MnmgxAtiIDBhGbqkgbXqgXoUu0g/U?=
 =?us-ascii?Q?Am9OBlXN2IzL+KKHeI2XgVmfSiqfsDBaMZ18lVAeCn9TUBQ3v8Fo5Z3NMu3a?=
 =?us-ascii?Q?979zVcf9DERYPDm+112pXGA7S9bmS4lzhAIXtsMZaCLHZOt+ul12sgiUYllF?=
 =?us-ascii?Q?Ejt7IQV8zy2/r4uX3lHAyhIdnYtkXIrdO79pqjen+e2SY6C9eatRLg8/8YuQ?=
 =?us-ascii?Q?4I0NOHGqzapSj5dNXN4IlJn0D3FwQg545fCH24uK/zANpLmbukofV36i2VOv?=
 =?us-ascii?Q?wgBsl4YwbN/srARX+IN8BcAJgXwRpU4/xBCGQ3eEkEg/ebR8TWtkKnPOdwqf?=
 =?us-ascii?Q?KGyu+B7ItRqyjPAqADHPmjjFiftmb3CnX7DZOOks7Z9JYu96sUvyPLUpk2ip?=
 =?us-ascii?Q?bCt6Fux1d9VzRnJEHIrZbb5jRQDpbPPQNNEhfw1j0wSIknhJBUTdNWsixOI7?=
 =?us-ascii?Q?v0vRB1JWztwfP0yBt9nJmQARdGkUD/GZJetLYxH4EhiVzPCAv3ICBG552OAl?=
 =?us-ascii?Q?GjXRuoNSaWL8wsTrrLh0WewxCL4EWvVcJThkfGtJRwYrRR5LL4xYAM7bzA7y?=
 =?us-ascii?Q?clfJXVXMUD5ND+G4uS3+wXeRroiOAhPHIdImnfR7+gMjqofkYiIo/WLO/qFK?=
 =?us-ascii?Q?VlfLdh5H/23P0lqLkfPklpe6Ncyk8y4plCi/cHx6wTTRwie/DywFsJM7+Iwm?=
 =?us-ascii?Q?6cCEh6wRYVh2tB42bm35k06V6EWnFsCVGfWNYtu6Vduh3UkguSHd/acefwts?=
 =?us-ascii?Q?o2Fh7NzTHSCU1i3NwbqhFy6SaORMoO4WRt61AayeSeWn5zU+wQekOMkaHoxl?=
 =?us-ascii?Q?Wzbgv2Oiz3Y31m8/DJ2/+oyX3Nuam8khXbK7zDek3XlzoZ+l1QqY/ZzTI5rt?=
 =?us-ascii?Q?QfBFoQVwgE458nCbI/sTxrOp9Z1F5Sl1oYOtVdhWVZojn3NI6mX/k7TZVuRE?=
 =?us-ascii?Q?qZGVr/cUPm6q2zIdGeS9SkS1K/0tB/vlmuLe98Ynkz3xNBkuvCUxCX4OI1xD?=
 =?us-ascii?Q?+I36TklMMKeY7xPkXqJLOCx4hlhZU4sIejrgzXYTsUGKFgD11bvc15b/JHFx?=
 =?us-ascii?Q?AMZS8OVEGvlcKMq77x9aNnX2gsMHlK4rXjZ/PmUysmkpwmNkMHxuXJZdTn5d?=
 =?us-ascii?Q?9wARcQdFuUKhNTXqLb4zcSun4uG+MjmQ/dpCq9YL1q4K1jDkNE0twsaeFzm6?=
 =?us-ascii?Q?ej41qKSNK2pS1Pf29uYpfsxBzB9czlpvP5QspvswpyO9SWrinLXO2tLgVAC+?=
 =?us-ascii?Q?PBaoMnxzjbAtivvd+LHfUbzhy+Pjjx8OZmt+1LJG?=
X-OriginatorOrg: eckelmann.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c48170d2-ad97-449c-4009-08dc9043cc8f
X-MS-Exchange-CrossTenant-AuthSource: FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 09:40:05.0348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 62e24f58-823c-4d73-8ff2-db0a5f20156c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIpSrdnFgRmNg8DuL3C4K9mwiiSk7Uiy4ZUy/U8j2Qj9jN5zc2mwjIqxTxet0KIRQ/RTIttt+FsEiQR68LmdjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB2832

Hello,

On Tue, Jun 18, 2024 at 07:34:18PM +0200, Marc Kleine-Budde wrote:
> The patch 15a6af94a277 ("spi: Increase imx51 ecspi burst length based
> on transfer length") increased the burst length calculation in
> mx51_ecspi_prepare_transfer() to be based on the transfer length.
> 
> This breaks HW CS + SPI_CS_WORD support which was added in
> 6e95b23a5b2d ("spi: imx: Implement support for CS_WORD") and transfers
> with bits-per-word != 8, 16, 32.
> 
> SPI_CS_WORD means the CS should be toggled after each word. The
> implementation in the imx-spi driver relies on the fact that the HW CS
> is toggled automatically by the controller after each burst length
> number of bits. Setting the burst length to the number of bits of the
> _whole_ message breaks this use case.
> 
> Further the patch 15a6af94a277 ("spi: Increase imx51 ecspi burst
> length based on transfer length") claims to optimize the transfers.
> But even without this patch, on modern spi-imx controllers with
> "dynamic_burst = true" (imx51, imx6 and newer), the transfers are
> already optimized, i.e. the burst length is dynamically adjusted in
> spi_imx_push() to avoid the pause between the SPI bursts. This has
> been confirmed by a scope measurement on an imx6d.
> 
> Subsequent Patches tried to fix these and other problems:
> 
> - 5f66db08cbd3 ("spi: imx: Take in account bits per word instead of assuming 8-bits")
> - e9b220aeacf1 ("spi: spi-imx: correctly configure burst length when using dma")
> - c712c05e46c8 ("spi: imx: fix the burst length at DMA mode and CPU mode")
> - cf6d79a0f576 ("spi: spi-imx: fix off-by-one in mx51 CPU mode burst length")
> 
> but the HW CS + SPI_CS_WORD use case is still broken.
> 
> To fix the problems revert the burst size calculation in
> mx51_ecspi_prepare_transfer() back to the original form, before
> 15a6af94a277 ("spi: Increase imx51 ecspi burst length based on
> transfer length") was applied.
> 
> Cc: Stefan Moring <stefan.moring@technolution.nl>
> Cc: Stefan Bigler <linux@bigler.io>
> Cc: Clark Wang <xiaoning.wang@nxp.com>
> Cc: Carlos Song <carlos.song@nxp.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Thorsten Scherer <T.Scherer@eckelmann.de>
> Fixes: 15a6af94a277 ("spi: Increase imx51 ecspi burst length based on transfer length")
> Fixes: 5f66db08cbd3 ("spi: imx: Take in account bits per word instead of assuming 8-bits")
> Fixes: e9b220aeacf1 ("spi: spi-imx: correctly configure burst length when using dma")
> Fixes: c712c05e46c8 ("spi: imx: fix the burst length at DMA mode and CPU mode")
> Fixes: cf6d79a0f576 ("spi: spi-imx: fix off-by-one in mx51 CPU mode burst length")
> Link: https://lore.kernel.org/all/20240618-oxpecker-of-ideal-mastery-db59f8-mkl@pengutronix.de
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

This patch fixes an issue on our i.MX8MP board (test based on v6.9 +
small-custom-patchstack + this-patch) where querying a ti,ads7953
(spi->mode |= SPI_CS_WORD) returned either 0 or 4095 .

Tested-by: Thorsten Scherer <t.scherer@eckelmann.de>

Thank you, Marc.

> ---
>  drivers/spi/spi-imx.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index f4006c82f867..33164ebdb583 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -660,18 +660,8 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
>  		ctrl |= (spi_imx->target_burst * 8 - 1)
>  			<< MX51_ECSPI_CTRL_BL_OFFSET;
>  	else {
> -		if (spi_imx->usedma) {
> -			ctrl |= (spi_imx->bits_per_word - 1)
> -				<< MX51_ECSPI_CTRL_BL_OFFSET;
> -		} else {
> -			if (spi_imx->count >= MX51_ECSPI_CTRL_MAX_BURST)
> -				ctrl |= (MX51_ECSPI_CTRL_MAX_BURST * BITS_PER_BYTE - 1)
> -						<< MX51_ECSPI_CTRL_BL_OFFSET;
> -			else
> -				ctrl |= (spi_imx->count / DIV_ROUND_UP(spi_imx->bits_per_word,
> -						BITS_PER_BYTE) * spi_imx->bits_per_word - 1)
> -						<< MX51_ECSPI_CTRL_BL_OFFSET;
> -		}
> +		ctrl |= (spi_imx->bits_per_word - 1)
> +			<< MX51_ECSPI_CTRL_BL_OFFSET;
>  	}
>  
>  	/* set clock speed */
> 
> ---
> base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
> change-id: 20240618-spi-imx-fix-bustlength-9704b2fd9095
> 
> Best regards,
> -- 
> Marc Kleine-Budde <mkl@pengutronix.de>
> 
> 

Best regards
Thorsten

