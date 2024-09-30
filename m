Return-Path: <linux-spi+bounces-5051-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4680898A852
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 17:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603211C22A6F
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 15:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75294188714;
	Mon, 30 Sep 2024 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nbWNcXAA"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2DC20B0F
	for <linux-spi@vger.kernel.org>; Mon, 30 Sep 2024 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727709536; cv=fail; b=lU8Zb9iXnmqBVi8spZuiMyIppUDfCbRhnF1l3q7Jho0KORlVzJ/t1XQBOW252oz+fQuKJg/jFf9eMFqJgPQmwpb+MMxKtinmvrqZrUzv1BJWD03qBvnuT78wwBJA2dGRTP9Kf18P+ST0C6kJNH/Kw3NlYdXomqsw2HiNzihVacg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727709536; c=relaxed/simple;
	bh=ugmIi7yzBb0L+vSq/yHovAVRUCujd/PTg4Y1dfLLOFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i6VljwONDFppNzhj9StRILwP0WnE5Jiq5YUGaptcM87QKuykGD5dImVfpY40Du6I45WGvja42fXFDGKgTRxDzSuWcu99bAIGPBsIDTJK6mNRswuEJY3t+8oGZ514Z93EQT3YGRLVYJddHls7u0aT8VkH2I7TTXy64gHNgVP/xrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nbWNcXAA; arc=fail smtp.client-ip=40.107.21.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rb7jR1wjwOHzJNLbdCvlosiG9aj/i/p90Gow3/7UR0S+LejZFparVz/B7Kf/2syC/UFu4Yu04FrOSHu/VkUKLV450FGs+rbnZpOeerYTR6i7nWO6kacV8hPpy19T/BMVDyozvJM1OOIJAm8D24ZhDbEGw3GWHfT0lLg2LrjfYksBoxyUi77h1WPYDqne/yR3RuzbwrhRS38ndEXK7NFnkSdDjWQZXM9Nnct5uwexvysmMjnKYPkLvAzF/ou/Po75wRov5VqJ3SLv4DYa5UlfvCRdXl8K2oa1QN+6s0eSLR0tkU6t6w3w1NDVj+WA1FraquiGgJ2sF77rcEnMjjGITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Jd+QZ/KolQFnmWzGG2SRYQeKH2mYv6ww8f1barSs5g=;
 b=B9TTW32K0UYEj2IGWRlvD3g9PNps9yqNIFyJrli5wqQbUslqOcSF4xtrTPQ+2V0GjlavNFvjAGRVB8r8GIQDiLi2RoKlRfVp5AwTXItkDKRTAtSzX+A3O7AiHxTK5HkHMnnxuQZQ7d42a7AEi3ef66Y8+lPT72X8yfq3sUnZHW/+XHc6XiiKRDiaZxLWpCY1+sPKRnp6/agIaq4sivBK0/GYsQp7vNTN0Xij7WQ6S3ZGhFIN/5khUeqtPJrlZaIChluC2SewHd3n7JOTHbOGNbpwu5UjHMoJtkemA/wCRjOgFZYEqYV8OQ01N3Y3V72e7T2UvGlsukQfyl3xy6Ln5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Jd+QZ/KolQFnmWzGG2SRYQeKH2mYv6ww8f1barSs5g=;
 b=nbWNcXAAyneclFT9zxIU7E82p3r2aJLVJFDtxYdYW23XwM+nWYb15fHu8dcUAuImFhAy/aRS1yFXPuQvpLFNdq4qIH249XbFEtuhl46HVo27YZtIZtaRvMWdfK35MWTVT1T4DgVQdLKdEgXQVLI/1TS1YGEuU3cQhBVbAkUztJDOqyb4FAt7w1AklKiU7/DsslaVzwQN9sVq8s3rvYvfMHzdLTfzN6gohG16fQxgDDZbIvhqS+zRQCwFiS3X90nFlHIaQqaX5HOMYyVDtvT+bxQfzsYWOHWlu7ahOIK0tmbIEwHpoHBUyBkeJwkOorJ8d1Du1VJvz5/WsCtMNhQPnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8844.eurprd04.prod.outlook.com (2603:10a6:20b:40b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 30 Sep
 2024 15:18:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 15:18:51 +0000
Date: Mon, 30 Sep 2024 11:18:44 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Mark Brown <broonie@kernel.org>, Carlos Song <carlos.song@nxp.com>,
	Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	"imx @ lists . linux . dev" <imx@lists.linux.dev>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 1/3] spi: spi-fsl-lpspi: Adjust type of scldiv
Message-ID: <ZvrBVMuIDMlYiHUF@lizhi-Precision-Tower-5810>
References: <20240930093056.93418-1-wahrenst@gmx.net>
 <20240930093056.93418-2-wahrenst@gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930093056.93418-2-wahrenst@gmx.net>
X-ClientProxiedBy: BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8844:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c6a8a9-2d30-4b6f-2f83-08dce16330af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dpBRWsKoa70NBVUjZyOQM1j4lCOPQhWj8NboeL+Nogu8P40fypSP6vvePQef?=
 =?us-ascii?Q?SEX8/P0vjuYFSUx7MoMGQ3Mo1ObJsqRUmeqg5rpgE/tV8uwpfxhdCNSKervv?=
 =?us-ascii?Q?NUG6zUVzhkTheQFkaktJIsBMnqDKvyYtdVAU7oIXcGb9ja+7l6LAo4eYiXHZ?=
 =?us-ascii?Q?9/PaqlanlSqp8DN9AzOI3WQ8vofZsuR4YB2rlDcErxGoScPwn11e/9ffGJ9O?=
 =?us-ascii?Q?GdrjU5cp0SOYZ9ndMUT9S5R7bC/DdFYryD5C1M4Bje6/8gm/nBo7fLQwu0WM?=
 =?us-ascii?Q?Emt7yKm8q2G8TnNErbQ7hhdbQBlLdktcZhLNxdKflX6zKfTlQT8/QpI5jnXq?=
 =?us-ascii?Q?nFl32oddhtrnW+IcVMuETST7xIgnGZ8ISnEmQ2CEmio0H78ImMegtC+RvNEN?=
 =?us-ascii?Q?GVTpfHUsjpx9yrHUHo19KEY4PSl9DMH1TrexVpiwlkLkwM2sgxpoSBj6C669?=
 =?us-ascii?Q?7dpVTZOQ7T234aVs5Qd0Sl/mupSpjE4bcznXmh1T84S5C68TWdG5IslCGGPK?=
 =?us-ascii?Q?qDWyzb760BbG0BEN6qq8Rjv3Bz6ziKRg5IzYsGizwx0oAzmUJ+NyvhUGLX3O?=
 =?us-ascii?Q?FRzgFI2u8VE2GN3RE7QwwA3Gzsf971oOHC3/j6oPXLrKLzdVZhKnTkXktFV+?=
 =?us-ascii?Q?VIjlDUqlh+ChVlfu75eAB0f3aoeyDIcZM3cq3KuQJU6Dx41ZPdQCfYZ5R337?=
 =?us-ascii?Q?3E19oGrdxw65m3qZzHw0HAlnPb/gKFDG/PKQ4KXnsucj7i2+l3pIdQPI9Ip2?=
 =?us-ascii?Q?APIppYhWCeVLSBQ9qQCUSZGqX75WLhtg9/NNf0GE5M4qtuSFHvBD2a/n1e8D?=
 =?us-ascii?Q?CC88A2BcctCUF8TcPUi4u18tpFvpsgJpklm+IWW4zbeevmfwdpNmjsoZS2gb?=
 =?us-ascii?Q?9JzWr3VW+GNIWdZjVdi0AdgDn1DMkVPvBBU55KGqi28HwRlzUPa1zudmCSXt?=
 =?us-ascii?Q?SaekOI2qXIQyddnCR0CifM07tIWRIU09JkEir6oLlxAAO6OVCv+OuyXyG6hc?=
 =?us-ascii?Q?jeZUBoQGSFa11dACATGcJx6WzU9/NML9BLK4YubEduLBD41tTvNzwKrOte5A?=
 =?us-ascii?Q?MNKq7ffCXhyYSgV7Bw616ncRZQKDfIAIwjtlijdj3rQvJ1sBvlJOhRprrEU3?=
 =?us-ascii?Q?cDO3ILaZcoGDlZG2qqwInKRgQ+RTaN6WhdVtnBMdc663/j6oTlhBYyrDOlBE?=
 =?us-ascii?Q?XzwcDLyHrTQPue5mipSvfXtk4R0sYT+LxCMYNqRmHnoMxzh55cLvo5t8wro7?=
 =?us-ascii?Q?omqKcmL7howRpjPGOfKedGVFu0k50eWGpfj8wb16Mqn1/y6dQ5NB40Bl0OB1?=
 =?us-ascii?Q?QcSGguJzAOp1GnfiDK8Sfi5gvYc8CAHncM955ihKat3dOOMURbvc5YfFPKuI?=
 =?us-ascii?Q?9jDMejcyLf7SS1a2Eq7swnz9EeSRK8yAXkFr021ffftvpZdXDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mVz88SXhbOGYMT7fk8TLUZqjln+1aJDrx+QyseQ5q54GYQLt3tiwRJpM0TwA?=
 =?us-ascii?Q?pVkQgzTRn20LMWu8ceB/fGuLJjgMhvu5uaSYxhZGX/FAXd51wc6AgP9A4DMQ?=
 =?us-ascii?Q?Y3cDln8dCt2zO39K853O9UJeejwgxt3BVPixm2o++rdCyR/TgEKQmJFHS8df?=
 =?us-ascii?Q?vFbfiUnRLfUTuClploBPgGiHmyUADG07Qj4604BrHV1N43XIY6pPt4wZsAda?=
 =?us-ascii?Q?HPpY4nDdE3pgWMgPwiqR95vg2xdvSHaeIFqPfucUHtVjc1u8TRSpUDhbhV5P?=
 =?us-ascii?Q?1ZuBUL7JFcdr8ytYUk5sFEgbJAvg0TrmWBEY5EQxsabrD0Q5bNyDQCQhMFkz?=
 =?us-ascii?Q?y4jcDrgKJ73uZiNuI0u1ZV9iPBBjSm8EDf9tjuIKVAYgxBabfruU05PqXi+m?=
 =?us-ascii?Q?1GgnovpARt5rwr5YFlEzXqp1pvRiPmwE/MI/2Vawc0fJwh5KNT6GMslgxHty?=
 =?us-ascii?Q?Dr/QRsgLEjHLwGLRRUaCTlcG2mrMn9mei+cifS9Grb/5N+DAt3bSngLWwu06?=
 =?us-ascii?Q?jzNpRq5H40KREHQcGGk21rAEibSx8qQ+eLq7aq2irJ6cINwtgejh0LhZmUJl?=
 =?us-ascii?Q?Hd91ciiiCIZ9Ps6ZjWNM0oFw36qAHnUyQy7Sgx0hyzMYP+w/VU1I/syyoVgi?=
 =?us-ascii?Q?EsEaOc/aJ3ffv6trXFuwa1kveTj0T013K1p1zknwxt5+XLxleDUpalEDa/uA?=
 =?us-ascii?Q?JgTDUfMBGtKptezq9KsQjnxWyNqncRGecRcsTexVkVXgpK6Z9ikFGVtfd29P?=
 =?us-ascii?Q?rT+n7Rs0e7bKkOmrTz7g6We75wuduDfXS6hpW4wajUqjLolMixg6txOwnUsq?=
 =?us-ascii?Q?vBUkY3tRii4hJhoamBU2+GwSVR2h5mIPwM6UTbcHmftfJF2zHxtbqG5XyhMi?=
 =?us-ascii?Q?Z3jBVoQbQjbgG9IDtXhOk4goO3bVbS52WaMk4u0aWLR3Rfe7CkjfFeKDXIFh?=
 =?us-ascii?Q?qG4qlvWSOPCsUOioy6n7OHN3w4H/1IaYhrQYGSBLZvAVLalI3sIb4o49wN2R?=
 =?us-ascii?Q?mSFEliWiFXcX2XXcu+iOvWgmDvyhMK3FLbuvNWzaygCK2H5gqoN6nAJbVPrL?=
 =?us-ascii?Q?XAIRDWkgxOeFwpTFl9d1kTJIxvJlaQWgTtlvN1GyavmOPHxV7bXnBWQc8Nk/?=
 =?us-ascii?Q?vShAW5pht38DWN+DzTIqTN9Mx9gw79R/PbBbBToleldCVA8hbyzakER5U6WD?=
 =?us-ascii?Q?ImuwzjVtEuK5TxBnLZNoruQ8ZUOo9PESsuAAi2A2FSvrXcNZQNUvzXn7zBc7?=
 =?us-ascii?Q?3f6OX3vbFLAP7EM6g0kHOfrIjf8//4NsYujfeJvNvLKU9qGfjQ68z4QPFLHh?=
 =?us-ascii?Q?l/RZ1QzdWXkytvITI9dYQ1s/j9VHFnS8IzVr2iK3MhMIjs2SQ0UaHAmGggSh?=
 =?us-ascii?Q?fR4vZbDV4HsCBnEmd91jhxtjYpaJUoaO30eF9L0svNACPafm3uOp7+SfPoLJ?=
 =?us-ascii?Q?qjwJEyqp7nP8grNQZQU1qNt5ln86dm2qloS8efhv7tTz3knHNeC/2pXFTV0y?=
 =?us-ascii?Q?hw5XPSz4URgaEpyNxscUb81/leB/cJow14wYGHsT1HBfkzRJRY4PK1+WHVb1?=
 =?us-ascii?Q?QA7YBm6nHenozBCaFOk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c6a8a9-2d30-4b6f-2f83-08dce16330af
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:18:51.5834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjsmY2byHajoFytG50DjtsnzNL9s7TgNuhN6ErPnSK+wxmdyK2v55dl4COcn7HKXEPIk50Y2BkPQgmyctJBdUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8844

On Mon, Sep 30, 2024 at 11:30:54AM +0200, Stefan Wahren wrote:
> The target value of scldiv is just a byte, but its calculation in
> fsl_lpspi_set_bitrate could be negative. So use an adequate type to store
> the result and avoid overflows. After that this needs range check
> adjustments, but this should make the code less opaque.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/spi/spi-fsl-lpspi.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index 977e8b55c82b..196cc68f2057 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -315,9 +315,10 @@ static void fsl_lpspi_set_watermark(struct fsl_lpspi_data *fsl_lpspi)
>  static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
>  {
>  	struct lpspi_config config = fsl_lpspi->config;
> -	unsigned int perclk_rate, scldiv, div;
> +	unsigned int perclk_rate, div;
>  	u8 prescale_max;
>  	u8 prescale;
> +	int scldiv;
>
>  	perclk_rate = clk_get_rate(fsl_lpspi->clk_per);
>  	prescale_max = fsl_lpspi->devtype_data->prescale_max;
> @@ -338,13 +339,13 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
>
>  	for (prescale = 0; prescale <= prescale_max; prescale++) {
>  		scldiv = div / (1 << prescale) - 2;
> -		if (scldiv < 256) {
> +		if (scldiv >= 0 && scldiv < 256) {
>  			fsl_lpspi->config.prescale = prescale;
>  			break;
>  		}
>  	}
>
> -	if (scldiv >= 256)
> +	if (scldiv < 0 || scldiv >= 256)
>  		return -EINVAL;
>
>  	writel(scldiv | (scldiv << 8) | ((scldiv >> 1) << 16),
> --
> 2.34.1
>

