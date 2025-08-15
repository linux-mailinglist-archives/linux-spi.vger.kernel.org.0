Return-Path: <linux-spi+bounces-9489-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344F0B28464
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 18:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ADECB00BB8
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 16:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCE92E5D22;
	Fri, 15 Aug 2025 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ekSU4jtH"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013045.outbound.protection.outlook.com [40.107.162.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583552E5D01;
	Fri, 15 Aug 2025 16:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276548; cv=fail; b=IFaeeDTIRJT+BejLKMWuCjFwbNxHACDtbAXOJWx+xlSdDqru+Nxh8WMAd48s88sUDnAoRWns0/GkXSmoRVqJt1iAuB9TMjE0IbGI08dLsISi9WphAw9b44UXmhDDtnStZZ5R3ymDbrXKB2QPpYLbE/ScUTpVH/e7QuKblRXqipU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276548; c=relaxed/simple;
	bh=7To0JZ7xKJ7eadg0hQXivPGmNTVFoUKt4xGP1l7efJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OZKn7yLXjIY3GnApQyoIBMr48ZE1Hyq08GJBPPYOTdL9W6O8XJzooO7SV2CgGCJoEQN0sWASiNQcwfqiqr7myQYhn8mVWRTuIVI41xcNGpUoOGru5fx0VEnrrpR9BmHbVvot8IGILbConpGrRo/GiL1m68Oa+LldJmBar4RZ8Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ekSU4jtH; arc=fail smtp.client-ip=40.107.162.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCN2W6g0VXExeH8FSRtYQjOTc8kOTJN4sWwmIUgyCoIRDW7z4iYMaKlLttJpU7RhzLvRl0+TCjSEMD3w+CS+gpLK2Ww24vN+xgfNP7pdaR2YMZB3UHkhkwqI4mIjXe16z2N44Ps7suJ81dfkEKv9mwh33y50sk63DhawzyRNqaf9flSDcz7+okQY2uXE9yJvtyWuoh1QK+U0Rq4YLFIUh/antfBJr41N5wL1CE/2vvpCEACEkVZGS+fj1UdJY5XWZgxq7viG6PSiRjaxan8hkgoDP66E1aNxTcNig84DWthRV07RePN+qtgiF6w/hwBYK/2jf0y+UlLEjzQ9AjnzdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18RYULC5uYKiAp90BPojhd6n5cX839K44J3Qc/22Bos=;
 b=baIvksxGYrbUL2XI94GsuKWqP99wEEiyO4tmT8xtonMm/KdWhuJ7yTLfdNkPy79mb/3T8T/lpuXqxQZknP99xuQdKpWAWCnTytYCDem78Dy+AVn0yBsy1CTJZgzBRCTdFVR+BJhp/uDnOrPS+vOp4uXHNNkshCDp4NmoWL4QQlBLukBOUPCBjnRzZtQAyZecTGI39IpWqunEEXTTBV5xB52NTp5AYQXKVc0ekkPo9fMV8pS9pvSyoH0lkZG7hamxCnxieYZZbvOk+IOFftzJdvm8GFA6brRWBdEaHOzN9+fsybazf1lzy7ZFFYg/sbjb0nzp4WYMVextiPplsfNn4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18RYULC5uYKiAp90BPojhd6n5cX839K44J3Qc/22Bos=;
 b=ekSU4jtHFR6Ad8JN/bF/f29HwfKswor6QvRoYzX0X8T0aOuPT5bJOCGk6y0q1jk36Qh/8egnCh/l/SJYruVzxIYpviDreiJC8+thiUNjZkCYwrFI6ysuDLy4EqxDY6iE8oJav1eDmZU+Pz5MgDKooGqzB83Bvk7QXfJCOxNOMwakbf07CI42Upgqr5abkg+UChtkxcMD47c9xk0xlVMWJM1gem/x7Ou0TQR9nz7PAN91x4Oc9RZb3+aH8nTGlsxByWiKnr7wVwhjwzoy6GMftKrdXb43Vc6ChSDTrhbsl8rsAIm7RlAH2il6JkeS5vj4lWDl5RoCpVTx0MMMaJU6Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7684.eurprd04.prod.outlook.com (2603:10a6:20b:287::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.8; Fri, 15 Aug
 2025 16:49:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 16:49:04 +0000
Date: Fri, 15 Aug 2025 12:48:57 -0400
From: Frank Li <Frank.li@nxp.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Mark Brown <broonie@kernel.org>,
	"open list:FREESCALE IMX LPSPI DRIVER" <linux-spi@vger.kernel.org>,
	"open list:FREESCALE IMX LPSPI DRIVER" <imx@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] spi: spi-fsl-lpspi: use min_t() to improve code
Message-ID: <aJ9k+bgEQ8EiEwWw@lizhi-Precision-Tower-5810>
References: <20250815082118.586422-1-rongqianfeng@vivo.com>
 <20250815082118.586422-2-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815082118.586422-2-rongqianfeng@vivo.com>
X-ClientProxiedBy: PH7P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec10d9d-89f0-492f-4bf9-08dddc1ba46c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?698yv2BPdkzuDpqAJwZAh0To8nbRr2pBgL5quWveLagKHczBFMu1OdW4goDq?=
 =?us-ascii?Q?By/msROgG2/eo6uLQHu+OtKw5X+qBaZGTDYHr4bsMqt23QpDMxrUD9ba2ztW?=
 =?us-ascii?Q?OT+qtxCwU0R6eNV3gTKxUv4gc4nlQXGGwxWAxk7tj0ERI+Vvc8+Q+PLbl92R?=
 =?us-ascii?Q?Lgi+HgmM1ykLs7fZbH2BsOwkQODQG6T6LQ0pMaBnT31QpU3s4o+H6pRxS7D7?=
 =?us-ascii?Q?BbcHeql8ynJc1b1dxwQdcOlJZa4ZAoVRirKknNSQ1YN4KeSfLb1yN60rfY7J?=
 =?us-ascii?Q?7H+Jbo4afly+RKUd6edtA9qf9tHjx1s9vQ0QVmcIn3bNqih+D6p9mx2C9x0Q?=
 =?us-ascii?Q?Zy0KBkt/eVaU28s3bDbPMB0RjsxacqhL0wIGNeasZ1h/IAvux/t5ig/h3xcm?=
 =?us-ascii?Q?bWunc/FMEzYMmCV4hEhcBHWWXJaZpkiD2WP2r2KY2F2FOnJccjyflCMP5utA?=
 =?us-ascii?Q?ZUvcB7d0Tagd6laa4Adb6R1sVgBUjt5bZwg6ZV23JTSjXOXtKjfD1gi4ahJA?=
 =?us-ascii?Q?fILHKLHXM1TrlWj2zXPZnk6tIuofY/qpq1aAShrVOGGXBU8o6LAwscMeeh6s?=
 =?us-ascii?Q?Ad8JskS4Y8KZZPkdf1CZ/ONIin7ZElR6APHmmpOBinQ8gBKf9FFLttFQ4jSt?=
 =?us-ascii?Q?lMN3Mq8pQCCM8gezFFDoJ196AQfcoF8NiSv5XxBox3qeUTqzzBmLcEUAjQLG?=
 =?us-ascii?Q?Y7b5QQTAkf3oMdfKD3zSK26kgGustv0pybMYSnL30adR2amCgPeVsqJQOxs8?=
 =?us-ascii?Q?/MkpqkT1WyY28anV9F7n+Ci917urF/D1afnfgiMqdnGCH/ZbzLdbrZfAXBeP?=
 =?us-ascii?Q?ua95pYs0zgctPXnR3d6nBWk4HdT/sA/MNqhcGO3wl3IzVFob1+iGMD3OWwZG?=
 =?us-ascii?Q?rggd8Xf3Jofq+LYilKBpQhwZYdzYFPiLoKM2urAIff76EArWhYKhNbtfxP99?=
 =?us-ascii?Q?Of72snTrYHHCTI46ZD9bbEtJz75wqaAg77iA83xOulFxQeWH9Sc5ZrWED3t4?=
 =?us-ascii?Q?DoqGomR2G0c4V4RqkLHGT6Dai+8xn+X30Uj0POJKMV2U1p45njOb+pr7HTqW?=
 =?us-ascii?Q?i3hhJImxVKgnESY6QEqkveFmSGGQagoyy9DHSLt7nAlap961L5Whbx5JztB3?=
 =?us-ascii?Q?ZhZflHNjQhKQtNA9kGON3UluSh6/ddwpQiH2aWVd8XyKnkxzJSQwKKB4o732?=
 =?us-ascii?Q?jjyu9q8REeZkklITjJcRhed0Z5he4nCpmL2qQkHCucvq2MnfF/yJmok7THKV?=
 =?us-ascii?Q?2caG7nWiVI7JL/Dokhr4v0Ghhd3MKBtlBNf7eGxIhP8p0BdADy9fQT5i3/Qu?=
 =?us-ascii?Q?Bqx/er+6mXEYyMceqougl9Ba3PuHq1ao23kmFs5vXM3Fr+hqWBsldoCM2Ss+?=
 =?us-ascii?Q?aOhBcb8CDMBwpquINIAa4o0leDAq2MWDz3WhnB0lMhgYSywdIus2sto7fwJg?=
 =?us-ascii?Q?tfRAT9KQsK/achLrDy9wE5SQVPGwIJb1ToPddVrlT1jr2q9lGwly0g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?boQLrG51jdw0pwkTY84hnSeic92O1GLamg9+x9kAuZJl1m6ky/VWb/QiPPXb?=
 =?us-ascii?Q?bqpXbrFzZ1BoAYKPQ+rTIuuwiC8SaQDVuE2zr9SgXJTvXws9n7ieINoeLOeR?=
 =?us-ascii?Q?4RP/nP3wocIWsXy0GgKwwfiP9TdesHf/EGvzkNK2jDZns8pTerjtMGsI+dMB?=
 =?us-ascii?Q?M+9IaEpolsDCh1WEknd+2PoOzF2G5XwHCpDZmIo8I0I2SXnmRdIDp2tov894?=
 =?us-ascii?Q?zOxV6AGwIJVF7MvRqrHvfY0VjgwwpcJvR1+z489YfVbXNlwTCYHM0W8kVHre?=
 =?us-ascii?Q?g5XIBM0V5MjNRY/tgYwsWer3JW0wv36xdsDtTpSGB0YpJt+5VSFrvka3A3bY?=
 =?us-ascii?Q?/4toL1NuOQs6DllFYcrIOIcxWjXG4/66m8BvbMCDtfhLESatUu6PqD9tmJA9?=
 =?us-ascii?Q?J97WSlUHBKTe8rLWlLjced5p1yVz2OaqCx5K9VPWuWq+OwOMaBVflFTPleAK?=
 =?us-ascii?Q?fEZNdGL21ddDz0QcZEF+R4l+ttLHj4Z+yHp2+foMjSsRyGaXcflsfQZSsLQq?=
 =?us-ascii?Q?XwCl2P/wW/O3UD9nUWwKYmmyKX/YlTe5mdqN9400KpriMP01VjAHe2NNf+OE?=
 =?us-ascii?Q?y2qpungyYpSJmE5l5GOARxi6Rq1c2Dtq6TDD5XTBn16WuZTmicBN+JqbS7RB?=
 =?us-ascii?Q?5azatazboeocvLpJv7LGxA7nWjGmlTKgyDpaMxK+CpHX/igwG6gtzkruKoUN?=
 =?us-ascii?Q?CiwB7ku8eROqzDIPNyNukR4K+YP2zdPEbQzhpBb4cUBQZTAlk2diVoygwCJb?=
 =?us-ascii?Q?/lNQpPwMSqWLoERi26JAk16waLhuib3aWn/Tr/GAkqYnQy3vu6IYEptHDAiw?=
 =?us-ascii?Q?6dSMgkgEPHQKkOYUpyIGXYH6uaY2mrv77G65BuNXKlhEVK11Q8IgNLYrolaE?=
 =?us-ascii?Q?rJd3CJvhAdQRHz9xwmXudFmVcBscTdCeS8E2gjk8jSgS9m/oy+9a5Zk76eO3?=
 =?us-ascii?Q?ejbiEVCWplTVhnls5NtZIy9jbT96li5HInNqAhfMmGdCZ8Ev2obz5rS6J1IS?=
 =?us-ascii?Q?In6BOo8BPXa5/rvaZj9B55jEFm/5rMXAJ8Sopt4x3Nu9kbGRqvDr0OLcU6jE?=
 =?us-ascii?Q?o9KSmuKgrFinLGEukChgoilMLquKhWAaG8CYu1YcTCzwCy1SAuU9P/q2Xwm8?=
 =?us-ascii?Q?BCgRTrOfKZFh2Ff+m6+DuMIeipp4JNvw6IfwLqsq9akzGmI1iAHVX4mJYFoW?=
 =?us-ascii?Q?xEQJEvUeixCJLDDj/+Pk0eZPnKgX6ia2lBk8xWnPqWPY8bDXKBevIyl3v0ML?=
 =?us-ascii?Q?XQVsbfd8uFUxB5AJhyAjmy9xa1JYTyZJCc9K5bdSJqJ+peJM6S9wk8sV09cN?=
 =?us-ascii?Q?7g2RmVJ6LNm8LsLJWF8RuC4Og7yG2CrG0lB89R5QYWe0O1D+U4IDDcr2tBLo?=
 =?us-ascii?Q?8K0akohwlWt6118Z6GflDCEEdcGC0dEm03IauEoWUt85KEUV2PPHYr8btina?=
 =?us-ascii?Q?wEhJik/1E1DYD8UgpxFwp0v0nTb4Tor7JNvLsatqkUakVDVLFrCcaHHI9577?=
 =?us-ascii?Q?dPg4Ps8XBMjZXDvyXMKf0mf2ef/bvdA+er0ZdZPpyos5hAaYcAe8vtGfh7AG?=
 =?us-ascii?Q?4z4VwotvuOyzEzHVy4c=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec10d9d-89f0-492f-4bf9-08dddc1ba46c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 16:49:03.9457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Zf+GZq7zBwNonrvFftImD6A5xREIL18D2dSlpp2o3sVBvUo2bHDowY/wc38NoQPDb2Qz6zkbdj9ik3Rt0RMTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7684

On Fri, Aug 15, 2025 at 04:21:15PM +0800, Qianfeng Rong wrote:
> Use min_t() to reduce the code in fsl_lpspi_setup_transfer() and
> improve its readability.
>

Nit: No functionality change.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/spi/spi-fsl-lpspi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index 313e444a34f3..dbdb9e114022 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -25,6 +25,7 @@
>  #include <linux/spi/spi.h>
>  #include <linux/spi/spi_bitbang.h>
>  #include <linux/types.h>
> +#include <linux/minmax.h>
>
>  #define DRIVER_NAME "fsl_lpspi"
>
> @@ -473,10 +474,9 @@ static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
>  		fsl_lpspi->tx = fsl_lpspi_buf_tx_u32;
>  	}
>
> -	if (t->len <= fsl_lpspi->txfifosize)
> -		fsl_lpspi->watermark = t->len;
> -	else
> -		fsl_lpspi->watermark = fsl_lpspi->txfifosize;
> +	fsl_lpspi->watermark = min_t(typeof(fsl_lpspi->watermark),
> +				     fsl_lpspi->txfifosize,
> +				     t->len);
>
>  	if (fsl_lpspi_can_dma(controller, spi, t))
>  		fsl_lpspi->usedma = true;
> --
> 2.34.1
>

