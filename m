Return-Path: <linux-spi+bounces-5053-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFCE98A85D
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 17:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0E91C22570
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 15:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C5E2CA5;
	Mon, 30 Sep 2024 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XEMNC2J6"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2051.outbound.protection.outlook.com [40.107.104.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7F718E758
	for <linux-spi@vger.kernel.org>; Mon, 30 Sep 2024 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727709730; cv=fail; b=ldlN2JT0ZeqsERdParQUb0h+FCEiQtew6px/Zb2ujqpjSVbdGSZR6nPBGeYEhKly8DAlGsV+fS29gIRC9bByqcWXba7FQk1AZLqvfDQVmvmB2r8BmrM8mH8fvVBulxSWADKykggSfgloJIb0BMMQvs2ENE95XJEUhEA8tZjLUZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727709730; c=relaxed/simple;
	bh=qOrdLnp2joN/Wzu5axkUY6eMuF+w2Bu7CJ2Z2L3I1Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q3plBRikBJ81bqxAadGR+OGw4+rzVfluKlBcTXCR196qAEa8O1zzpmQ1dmC7jzxaYu2bKTlwAJOGG+pkUVcN2rUhr6tNqgyZhk34k6SlLzmLZmHnjfUDUjl1PShN8MagiR+dsRaIbA7D5H3BGmFs9n0PAL+cirHZZUjrKYmUfg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XEMNC2J6; arc=fail smtp.client-ip=40.107.104.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6vsZiwAS/W6AjDO9DKXPvJ7gXPP5gh8fswnMyj230Xs7rqg/DcdX55tKF211LD/kEyTOUFi1qapUBx9hAbL7MZKLfwku+ZlZD8kDr3pc3Kzso2MceQotfD9NuwaYtymQy++UQ0CLve+PnM6TEjhqRREImVs3qB+GQKSnw2XcPQ5axLnyk6lNgb1kEfxWa2uhITVunNKT5DSYhPgMnQq/8LOnI/jf5QOTewpiRPb6sFhxkf0k1UzAUHhCKOkxbec+zIiwdPKJAHPcoD7YxEdGDXNvDUVuPRFHG1mhhcmLgFr/Wfw+ZxUeWEZvBJEo+XIxkVJ8Cd6x/G0g/tyUzWMHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68bJQzmNKPWbY5fZp/bvueO9AVZSDGHB9jxxFjvI8tM=;
 b=LYayMS+OtH4JssM0yhg0m9/idmjY8UY98SnbRxfplQ408QZSHQQjKTz73+FhGa3Nq68m2r2MAR4JH9PV8OGO50MW6RwNPO4DBZUkCbZrBqy8nxroCNnPjFq/OpvF1wzCGzMakZwlbCLPszOw3/aaTVdGlvmR013/u+CVgkli7DFYMFAjvkG0aaUBDUrIt/z8dbHPN1ghDUV/yKbG8VXA9wqOlLH5knr4OPOyXFV6LHlXTzLeQWCeYOvj4pjlE+zc4NltaT1aYmyi62YYENCKpPZrglqJtV0X8hh/vEmurDt75ARHFo59anYxss715/LppmNyQ3qkkUHANbZCZhZ7Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68bJQzmNKPWbY5fZp/bvueO9AVZSDGHB9jxxFjvI8tM=;
 b=XEMNC2J6NOntLa9xdE+zWAK7WEgXsMKuVfzw249j9eP1nQcQytMa/ZpnnfIluy8KHZwONGbsmy7iS6cdOlcSnUhOuEbZl6q9/THlzMdQNr1/iAkgRM5b4/MM31JMRL6yYKWroByKQkTsZTJgCipYrv3ZTxRSrXOIosVbGCAo9kq7vf0avSKH8NT1m2kul+nYm5VBD9RnepeQn2RY32QmYUY1hBVfKQeL9IT04g8mQY5g9lQQn3LeEVyHXYu+e2q81IHGIFWtLga3ULrfBti8KWPgenCbkdM6W+nkEbYB3aTeQ9DlCldNtQUm+4/XxbBzR3GcTfjswqp0YuurLqUW+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8155.eurprd04.prod.outlook.com (2603:10a6:10:24d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 15:22:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 15:22:05 +0000
Date: Mon, 30 Sep 2024 11:21:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Mark Brown <broonie@kernel.org>, Carlos Song <carlos.song@nxp.com>,
	Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	"imx @ lists . linux . dev" <imx@lists.linux.dev>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 3/3] spi: spi-fsl-lpspi: support effective_speed_hz
Message-ID: <ZvrCFvKyaU/mzZ9Z@lizhi-Precision-Tower-5810>
References: <20240930093056.93418-1-wahrenst@gmx.net>
 <20240930093056.93418-4-wahrenst@gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930093056.93418-4-wahrenst@gmx.net>
X-ClientProxiedBy: SJ0PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:a03:331::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: 67de019e-a39b-4681-6937-08dce163a479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L/ngYBIbe6sj+ev8yIMSHkLH29ZvDmFivAx9XgbJyewyyKKEFE/8Rm99PGjr?=
 =?us-ascii?Q?++tqZ14HMQVaduAH7qSF8FoPe5ZkwaAu1/Z10nOjFR+oKAg9S/YxuVoLdLLq?=
 =?us-ascii?Q?R2bTcS2D3lRnO8ZglCcUS2QkUIhQNletMpqt6f2r9RaV9SmhuVidU60MH0nW?=
 =?us-ascii?Q?uEAkdCyB9n+Gx78qGPu+39UU5rkrr9TYPzy7s08UUyMO8ZJm4BKiPrhF0UOr?=
 =?us-ascii?Q?7OCTxuGdnA5sAJoByzvGxZ9mavwzdWkeWPMhw6z+wtoezilCFRVF2yZc6utv?=
 =?us-ascii?Q?6jvoimyMYfzf18KOE8qJJdGJzFjbzun8QX2piSsyupt8mcB7ss07V64CvipA?=
 =?us-ascii?Q?MRsEbNF4FrAf+u10iQByv3HhMSoPU0JPoZsEyOztHrBysJsADjGPdePMbio3?=
 =?us-ascii?Q?8o5R+jHnP994ScAsO1f0siUGI2RB7fRbLGYKBVYGvSRrgTQSnOC2YGa+RFz9?=
 =?us-ascii?Q?/YzbfERD1OlwhA/SV5bpBg0g7ACQFVAWB7RP9QVMhd/NUuUZgt+3ysiRHiUi?=
 =?us-ascii?Q?XjYCbEeBiTXzI1w4borudEFilYSf+zb8DpLF6Tp80ydjWKpOLurGYfzBSmsC?=
 =?us-ascii?Q?JuSCRsdvvcr77CWCub9uaXArBzIn18rJSSUH4GRqqXqXpHdZMu44atotKqiP?=
 =?us-ascii?Q?GYf0w3Orkf9pgsriublXKztVnA8l5Fpq0fHeLDSNH7nVarnoDuB37/E/FO2T?=
 =?us-ascii?Q?I1kGvwNc2tP4cEsAMU/SFNZJxSPI091ZJDUwciGrZZGcs1WtXFqFK8HKTkqq?=
 =?us-ascii?Q?ga3pQaC1oUojZNhueCfbjzHtJZdYff8wMdNLyyiY62/Va90IV+VvV6sjOzsZ?=
 =?us-ascii?Q?9wIOmt4TXjJwZFo1bVPjqvR9oZGtiD5BMLeARvHcGf1zAV0xg1N28B0MW1Bb?=
 =?us-ascii?Q?zTarnfQ+/rt1x26aykEuYcboKlY+aPE+LMHzqYYaw0OlnMBlJJ29oONKVZf9?=
 =?us-ascii?Q?aXGYRkJtWrfxMzevq6NsG1vfR2DsQYx7yE9ZL93YEfo/zl5oCqnQOwHdlJrI?=
 =?us-ascii?Q?KvXp0tdQcF5/qGny4dXvJy0HFet7RBbj1ogTX0PENCqBDzbbYXmuM2HtjCuC?=
 =?us-ascii?Q?g9kdf7fwhbBHVRZtFcsNidVTCFFcPyT3OCdCl2YtmrMnJlnEqUuXUmawCQEI?=
 =?us-ascii?Q?mivgSqX43Q0vdmQlR2L3Bi8v2j6IX8CVRA32fiRFCdiro89XBc2E4t1FagU/?=
 =?us-ascii?Q?qhMd2wucs3zlYTE5POCwOcsvfOWxouHsUVFjgdD1RnrCWemDw2nV7LK4qzk3?=
 =?us-ascii?Q?vvUhYeIFtwdMDACHgQKoKEORxGHg2Md+3h9kW3CXUbzxCA055384eq0z69lV?=
 =?us-ascii?Q?BCFbqZr+IsPNe3qZMHFlhBeEOMnBbT1fj7rDzi3sAkDPBg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?No6C3giHFldcX+NBKyGHRNMHkU3MT+h7sBBJiEScWmL/evWTAKlJrZoSm473?=
 =?us-ascii?Q?Eyg5PwktJ+9YIA666snyauaDuK3lWex21+6mYBQf6jsacpv8bKnqAQK2t2oD?=
 =?us-ascii?Q?V3kaLFpP2mrLNFXe7xR6K3D4qdrM3Ifz97toaVMK1pdtc698Fs/MTAHB+Vgf?=
 =?us-ascii?Q?dKaIJ/1oqkaNBzpAYOqYuBT0QwEF8XS9Aj7tuR4HgOggli55NKRyHDNKBqc4?=
 =?us-ascii?Q?Ak9O24zuVtXcpeWcwnJYHRZFA8ziGk3ShowltMa9GcWrZvkVIYRmzFEHr55t?=
 =?us-ascii?Q?KJmznpzSenBCHpacbMnAtjNYB3A7LyhFY9RI/WGXoiiaZmKYIa2KqKQ3a/bU?=
 =?us-ascii?Q?fOXK/KvAaAkb4YHP0w+QojaKAzTiJ9rp6rivEwdTODelDzuI6UFGbJxaC+iL?=
 =?us-ascii?Q?fJmDten7cHxcx5tFHUdM4eLOTTtkB/mPkcn7hEVoVKBpbcOtRJVp90zEdizy?=
 =?us-ascii?Q?moZNl3UFAAABYm4t1hBBFTUGOLJ3BRNCSlCf3XL+nM+ZWJ5BmVMZ3kIf6C1w?=
 =?us-ascii?Q?6chyEklU1pekF7cio/gsOZev0g+lqEzUi6UYr/692LLYzphC5o4kARRqNikv?=
 =?us-ascii?Q?5JJxzJemGev4n4Is9UkK4C2PaJv0lSEq9fOqX0QHDjaCzaMNQSIaHWwTnl5I?=
 =?us-ascii?Q?crJC4ee0HqT04oMOf7J//TEXxOZWqzXYlGeYzj5UfO7E0tZzxl2SHfYt2CFp?=
 =?us-ascii?Q?JRF4s+2d23c5o7xGU0G0RGNrVh87I/tVn6j/aoBxisZErCp13J84+VirnNas?=
 =?us-ascii?Q?/p4phnSINAx0BSRb2LvWs5vuoaMJFbgfE1TXyWeFZ5Zchin6zAHYpQUd0pRN?=
 =?us-ascii?Q?uFonFGIhLCaJ9A/2NeFnDQze69n5ADEfu137h+KJr1IcksVDeE1T7LzQ/2ag?=
 =?us-ascii?Q?EABsQDEU7ErqElft/GiQ1tQXVA+3eAJDiZ30hnbqQLW6nrP4Kmv6xhdn77Fk?=
 =?us-ascii?Q?JQ80vjmXUS7HtvBHBLo//N2XGQXK+nlA2+pVF33dHMDbMTvZvSdthnqyo8Gm?=
 =?us-ascii?Q?EBUOQRU8A41ac8GNNLzoyGRSXFFtNEg/Rzj/O3zgCqUgzJ2mtwnkmZcmFI1j?=
 =?us-ascii?Q?wmdIpjK8mqiTmodMJZJk9czv+e8HqmAN9WrOIJ7QX/STd04j5bA7dv/5EgRb?=
 =?us-ascii?Q?KARspDBmgZu8d4nJm5NF0T8wChdL1d49I/M/k4ImqssCl54WqumnzsHBe0Rz?=
 =?us-ascii?Q?Ir2RoSJEgrTBHxso/mvRgE7XWxarejXA5TGScY+cD3mVs6capCSkDeQXAtzI?=
 =?us-ascii?Q?LONptUJGIn9i/YoeI+Uj3MjFCTl5Alo2Xi6JSjItwJeqBUhphJhLZ9jgRAeH?=
 =?us-ascii?Q?PW2tmvrUZrzrw7CGIiHzcFNe0V9mKkjgpcIl9Jsd91Ge9TPKyU8cASKkhbn+?=
 =?us-ascii?Q?J+xw6lIye1gh1G5RMHx6Gj5hfOVqnM+VqSMJI+cJDMDLgQA8JNeO9vH5KQWG?=
 =?us-ascii?Q?FZPotqPKkDOtK9zM+pciMhdTZY5veNq1ZgrmbXFskdFuKzOCUUXedPMwePif?=
 =?us-ascii?Q?UpzLHRRkylVq+I+KmI8k5vX+diWyLRi2Aku8+2/KDXVC9wRr8M9+vEnkQ63H?=
 =?us-ascii?Q?Glmuqg0f8/gRDDMuwmpxdSZhxJKRjaZquS0Ho+h8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67de019e-a39b-4681-6937-08dce163a479
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:22:05.8119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJNBXtgOCpOkryq2F9oxpBZ2gvHEL7C/xSuAYQgGfaZavayFmYPvcovtmxbznR+MIQnFI4NA4OT+oDjoAh1VQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8155

On Mon, Sep 30, 2024 at 11:30:56AM +0200, Stefan Wahren wrote:
> Setting spi_transfer->effective_speed_hz in transfer_one so that
> SPI client driver can use it.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/spi/spi-fsl-lpspi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index 3b5aa91079ae..5d55ef4d4ba6 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -92,6 +92,7 @@ struct lpspi_config {
>  	u8 prescale;
>  	u16 mode;
>  	u32 speed_hz;
> +	u32 effective_speed_hz;
>  };
>
>  struct fsl_lpspi_data {
> @@ -351,6 +352,9 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
>  	writel(scldiv | (scldiv << 8) | ((scldiv >> 1) << 16),
>  					fsl_lpspi->base + IMX7ULP_CCR);
>
> +	fsl_lpspi->config.effective_speed_hz = perclk_rate / (scldiv + 2) *
> +					       (1 << prescale);
> +
>  	dev_dbg(fsl_lpspi->dev, "perclk=%u, speed=%u, prescale=%u, scldiv=%d\n",
>  		perclk_rate, config.speed_hz, prescale, scldiv);
>
> @@ -750,6 +754,8 @@ static int fsl_lpspi_transfer_one(struct spi_controller *controller,
>  	if (ret < 0)
>  		return ret;
>
> +	t->effective_speed_hz = fsl_lpspi->config.effective_speed_hz;
> +
>  	fsl_lpspi_set_cmd(fsl_lpspi);
>  	fsl_lpspi->is_first_byte = false;
>
> --
> 2.34.1
>

