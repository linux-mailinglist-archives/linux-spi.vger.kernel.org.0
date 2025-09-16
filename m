Return-Path: <linux-spi+bounces-10055-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D866FB59C48
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 17:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4673A1884153
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 15:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDA135AAA5;
	Tue, 16 Sep 2025 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X7sjRtEk"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013061.outbound.protection.outlook.com [40.107.159.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC7E340D90;
	Tue, 16 Sep 2025 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037210; cv=fail; b=UT6yxhS5SA60z2xSvNEHaT+H/M7Z10a0GLkI5JM9LDOYi8Yj93O7FATPJ5pbAxMV7IXW88R0x2dLyT1uAoOLIg+q/7DmqP3tYmyqzqAiGx0J73qIqTxvN8bwBuXINjiKIkorSi9jsAZ3tGC+QwRuNkzYvHRyfLStPhqjqP3Rp6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037210; c=relaxed/simple;
	bh=+MV4C3XPblvGAGSh7kDUA9CoN2+42aUqQ/Hc16La4bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sFAZQTi7/RaJGYU3kZi7bNS+lfPXSHy54K4fIg4V7kBLBAFLkpNhhAfTDe5Pl9TuRml/OG6BDXgxJ++EmBvWMziSYGBcBGXNij9wlI+nteZSnwWs8/Z4XvcLIIWbUBAzu0YpMCpsGYNsTQskcMzegcQA/L0LnRdyGjRUYhHMabE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X7sjRtEk; arc=fail smtp.client-ip=40.107.159.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQjr3Vcpl8BjbtLAdUVEsb71/gBB/IR0i0VdMCzkeRSiUsvPl020rtKK7mFv5spX7qUVnOgexAaLCaJDPlVBNzb99znRTcwL6+D/Dsm/OnsPCihaehPnWYJc0vYwzf3oj+LgCwX7+roZtF3brfVCS5o80otFO53LMCsUJlk2WmAhFMoO31lqYktIpe+WxZewlJo98UBwx+k6P6Wv2kPeqOL+czfwriuw55X4SOecwXBG3rbKXknjzd0KCb2clVCdHnKswJfu3sOM0qqWxfxBis4aMGfFHAeHN4b54/MszUC3V4G3R1DV9f/niNnILSy4VmdlGd6xgS/XoSMJEjzGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2jITEtOH6K5iOwvpN6t1U/SVB2GY1ocR9GEF6hQHIw=;
 b=PZZzyiOZTq2Z3jZ8ZO04jMv09SP9FVis41dIsNTXFzfbB/ZeWSrqsRQnrbdR2+0vC7DMprf4/kHEGKJ9naZhWM7ktKiTBUX1hbAGvfeVYRfYCz7oBD8C9+9kaZJ6VTYeuV1jekX/dw8y1QbR/gq9PHivRSaovi6XR0vtZotPkRzIzoibEUM8gaH4WGCLntNtX3mtvgXxHblg5x343IK9+qgokai13WQiXWukwmw7phybjMf/XaswmHzcx4lxNcUw6iZswQRvKqF93NzCxze26OBc6iP4h2dU+UU9iybcrIILtoKjR+musBMLaVp2UmReaOknJPWYxgQ1UNh+MiwegQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2jITEtOH6K5iOwvpN6t1U/SVB2GY1ocR9GEF6hQHIw=;
 b=X7sjRtEkDi2cE4F/We8kd0cQ/QS2D4ZMryvcAqDmjInRhE6/M+BJfzUPHwnI2QUUR2IMbXm2/lcHf/MBDinWwKybjj/FWEAueJLJ3+Vxr5YYN4F6cdD7hzZ2l6sP4MDjKa7GHqXnYN3IgumuskYr42asCY5dTE4qO6VD5rgXjVZdYb5DDYps46L1Vz+BSlugHBIyxhipbmq21zIo2ga5cH4LceOjLEk0cB7ThOsU+y9Wgha/0ayshFJGElqk4WcaOeq7yggRqzDBjDSLpOvbgQwxJXqWqNAz9eUhPz0BhHqJA290FTOi5TKjLG9qdmh+9QjISf/EwQHjtK9Nplo5zQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by PA4PR04MB7568.eurprd04.prod.outlook.com (2603:10a6:102:f1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Tue, 16 Sep
 2025 15:40:04 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9137.010; Tue, 16 Sep 2025
 15:40:04 +0000
Date: Tue, 16 Sep 2025 11:39:57 -0400
From: Frank Li <Frank.li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] spi: spi-nxp-fspi: correct the clock rate for DTR
 mode
Message-ID: <aMmEzZAT5JLOKDJL@lizhi-Precision-Tower-5810>
References: <20250916-flexspi-ddr-v1-0-69358b5dc862@nxp.com>
 <20250916-flexspi-ddr-v1-4-69358b5dc862@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-flexspi-ddr-v1-4-69358b5dc862@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::23) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|PA4PR04MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b2b0a4e-1771-4da3-f744-08ddf5374e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SRgSz9k6lKqDnSfAXR3xqoCnYAx+FZpkTWU91R1fsMcRoMGnCk4OKVp6FoEP?=
 =?us-ascii?Q?KLIudFSsun8oJNPh6xPFAyanwD/KqnwfgGGAx+Dkkurgt+ElUdkcXWJED9gV?=
 =?us-ascii?Q?PoHieI/7o/VYnUPGl/roNvKbfZlIAF9BZjM0KwW4w0dMrN+3uobrkQVbVGtL?=
 =?us-ascii?Q?DrmHo0hTjKZJmS0BdZUi7JX5oZitt55z2fAoLrNdWevSn7KaPBSnnev7Pipx?=
 =?us-ascii?Q?/OCInDC/ude1/VB6PsVS05jCYYP3/B6TQrxsQS0nK341/9Mb1M8/7AMUXjX2?=
 =?us-ascii?Q?oYobKtOefUP1K2DaU6gA3eGEQE7wWA1diPnP+gZnFBaybNpvB+86nSmyAUKs?=
 =?us-ascii?Q?dPhQPwp6Y9J1a54d+oOSzqBizOwZ0QDPYoh4redf0YusqYvMGV1tbR90BTme?=
 =?us-ascii?Q?Bn3qXJIXrF0gTrvofQ2FdEqRcqUl6PcCfvcSU0ufZC2MUX/RQjLDdqRKoixW?=
 =?us-ascii?Q?m8Sn2Hq7bP9TgEO+dcEdpzVZax9Fm7Ggy4GBhNgqpguQMIhYUouW5ywzaxXl?=
 =?us-ascii?Q?xQJitODzol7/CxxDApAjRp8WPmCYUwgZ6E2LAurBSLHlKVKRrGOxdfLQEWFy?=
 =?us-ascii?Q?Y8l87u+RjhZ8Km8F3RZocn8/IQDIuEY5y6S4jv9wgmtl+3Ix7HvhK1E1KNes?=
 =?us-ascii?Q?rgiDUA3GvnW+29Qw/Ds5FH6HgkV+xP+WX0iUnIhxsCMr4elFrsv++a8vKNOX?=
 =?us-ascii?Q?quyL6YMLcCOjiaHUAMh7+qar+3vtTJAmGzshXcMvyaZq/LzYuxjkihDfdUpV?=
 =?us-ascii?Q?t4E4IAeD0fY2ZGgjQGFT809vbbaOHjj6UbTvV2ieN+syEiQ6AMtUMEbtlHWL?=
 =?us-ascii?Q?acyiJ6KcGbkEFdqgulw2SnzNRhJftDu5Tk1rRQD7OsGnNxVE2wY/u7P0UR6H?=
 =?us-ascii?Q?8ops0Zlm7x6BMBAMwgOYZsr+rQ+0ei46mmxlyyZLsHXzpfzk/GaAg1utjjA/?=
 =?us-ascii?Q?b4S3oCJ+5oI5xM6boZLfx10c4hs6NgGMWpaXQdOdm2Gx8r11jn8kM/Hp7yqA?=
 =?us-ascii?Q?uUm96GAuExPuv7DPzyexsvSFJJejhrXFGcteumGRAzK80pajlCIC4gg3bi/j?=
 =?us-ascii?Q?f2nW+Ej3SQ+y0g7n5rmKYVRLtb9H86ynK5ooYcYMbdXWtHpkwSoqsjh8B2KJ?=
 =?us-ascii?Q?hIY391ryXUfoXVNte8v8tPDGIcEuuDrGglR3OFMXlEA2/KDmNZS0f9zVP/Ls?=
 =?us-ascii?Q?ffYNr1jEr62BXjzTXowWk7hxDgA3G8a/lAkMwG5btYXRvpE1azBBJDF0R117?=
 =?us-ascii?Q?gWYda2k7AIou/aGIAdW2LvqoEGrzr2/xB7gUm5hcBmnVTt9zwGq3qpIVP6PC?=
 =?us-ascii?Q?lzD9aMFZ0m7AsVDlOFBtN4o7zObelXjYJIu9eh+KTgnokce5dLUEsx/YXKkr?=
 =?us-ascii?Q?8H+BrCaU+2WQxdFBpdJD2+UPxgsRMxiilTkbTbJqmhhG7bHGA78iSphleaio?=
 =?us-ascii?Q?iJeso87Rmc4kIAROUQ+8Knmvs2fp8Jx5nSX98bam/f/HvLNaw+/Eiw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GMAnDFG+fDQOgqGtgjPDqwa3QU0+MJvLW//qMnKO5mFG4vpEZvXRdmtx+tuE?=
 =?us-ascii?Q?qzwMh8UbQx4V0c9P6Vg8G3iLoB3pvMNaKpxOYSC33st4yARZ4rs4zPPYF1Ih?=
 =?us-ascii?Q?C1PMZ/NPf5v6K19KXmBv+06vXLY0fDFlOiXfyjR36p2hBmQSgLwVm1OymAW0?=
 =?us-ascii?Q?a7swdDkaGXz+oCkhc2CoI0The0Fw1Ka4TwqvcTUg2Z/+GI4g3UPjtMza6R3L?=
 =?us-ascii?Q?TAugfFgcWenEdXerAebbY6ZVhJTLnebHd8/GrOhQGa12k/rHUVOC4SBKXUUz?=
 =?us-ascii?Q?h1qxkm1tFYZWWOL9z6CehNc2a0BYb/9/SOSVc1kGEpUebZsiAmBqku+tUbhY?=
 =?us-ascii?Q?3ijVxy5GswjqKRnPUxJw2eAGLVBTpipQYWg0WMe7Q/hchkSimbHi4WD9hboE?=
 =?us-ascii?Q?XJQ0YlZYK5ltuF3xZfDLm+929Zyh5Yx55JUvZpqDAGB1W2d4dbhSHFKw4b89?=
 =?us-ascii?Q?h84zX4dhalt0qv0flsr7/DcPZArHN7QGkgbuudh63ypJcGFYeR0YUKhUGd0f?=
 =?us-ascii?Q?29gw/Ve6sh0Vgj9Dj5rUeJHK6KUJ3NOH+w4jjhK9trkZ1oTEDCMb9oWnAgVg?=
 =?us-ascii?Q?whRuneIobW5r9k8b9dyMy0lNl4PpxXtZbygwBC8kDfwcNcpyShwU3GOo+Ao+?=
 =?us-ascii?Q?oYcuDPnYawsphUTtsOhbxDrrb0VELv7TWUBEpS///xvx49cUopXqQU+m6NZT?=
 =?us-ascii?Q?EJhAT0q8BaS0ENsxkT7/bHdG34pr8pHSKpu4q0iQ/Ew0xpEtGDyNGs+xnye4?=
 =?us-ascii?Q?qh2taMd1Md0nuetuDnkrhPxb6Gzoj0YeTvw9xV2k9IBaDFmTZHpRLDsF8f4e?=
 =?us-ascii?Q?Kk5a/chdq7T0blzXrFbXDkiajiypCieyxDeFf5WVVODi37k8o1haC1y03sKY?=
 =?us-ascii?Q?5l1kjWTCROusohewg8NQwUichBjhMNgMVJQM7PU3w1xtSt1LGD8owmw3pCpM?=
 =?us-ascii?Q?A/ccis7cKMEp/C4v3jg29sXtIo+8xecH++eR008Nq42dr1yo5EZHO3NQ+85Z?=
 =?us-ascii?Q?AQt1PqVjC564VTs3bmsQuMv5GegYLJoSS7U8xq7+/Xm/vYicvgoAFHlndUvj?=
 =?us-ascii?Q?7vThVGQWx2qL5tTkkP3VdDVHK2DNq21wWa32UqChbTjpfbgvd9xu2mhpa3WB?=
 =?us-ascii?Q?BXIvWuDaVLOXIMGqC1Z70ZYjGZHp2hqIZXf2xnze5Rh1neQqfntBGtjfZDnv?=
 =?us-ascii?Q?6rkaDDe6cPnF1x7megYMqjCX7wwaxkVAcp06Fca0lFsKcErzviJ41FExoxOp?=
 =?us-ascii?Q?uz8tvEBUEEjkhyrrlHS6PsR9muQVUOC2a7gyC4Cwup6q8mOJXsRCPMe0u8lB?=
 =?us-ascii?Q?gtGrhtAddZe/xsJX35VuQZd7lKOd12CsLN9w2i+xxrRb/3nYkRaFwZCfL2Z6?=
 =?us-ascii?Q?zIrOgCZ+PFaFi05/LI7OwYwbpBb870NSWcJlIRAJeffRm3I6eVedgzN1cDfl?=
 =?us-ascii?Q?TMOsBxMeujWlr5EC8MmHwO10ZGaFxeMzVj6EGI2PgQETsG7GLnyw+OY46vTc?=
 =?us-ascii?Q?TvsOpr5I8pGJnovgcT+DYNCvQQ2JvREtO2wgQdhT9ejvTLDKrmXhYvAUVVMr?=
 =?us-ascii?Q?23sTtDt62mFWWOEiJ7AebfD9NPV06ibvuSNqNGG9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2b0a4e-1771-4da3-f744-08ddf5374e8a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 15:40:04.7889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1la/24oMWb++4yKCktPGNDElHuuj3K32nkkoDSyF0WhWIKdZFYjnsr+bUuN4CmcUAZZggr6m+Kv73dbXHmnHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7568

On Tue, Sep 16, 2025 at 03:56:43PM +0800, Haibo Chen wrote:
> For DTR mode, flexspi will automatically div 2 of the root clock
> and output to device. the formula is:
> device_clock = root_clock / (is_dtr ? 2 : 1);
>
> So correct the clock rate setting for DTR mode to get the max
> performance.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

You can squash this to previous patch

This belong to add DTR support part.

Frank
> ---
>  drivers/spi/spi-nxp-fspi.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index be1e56072b94f38af934556055e321d9834bb07b..15b094e8e892f0b61c1f320bba897fa1f588be91 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -806,10 +806,15 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
>
>  	nxp_fspi_select_rx_sample_clk_source(f, op_is_dtr);
>
> -	if (op_is_dtr)
> +	if (op_is_dtr) {
>  		f->flags |= FSPI_DTR_MODE;
> -	else
> +		/* For DTR mode, flexspi will default div 2 and output to device.
> +		 * so here to config the root clock to 2 * device rate.
> +		 */
> +		rate = rate * 2;
> +	} else {
>  		f->flags &= ~FSPI_DTR_MODE;
> +	}
>
>  	nxp_fspi_clk_disable_unprep(f);
>
>
> --
> 2.34.1
>

