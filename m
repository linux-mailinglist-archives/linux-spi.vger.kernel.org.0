Return-Path: <linux-spi+bounces-10068-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB262B80F76
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 18:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D283A4890
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 16:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BE934BA34;
	Wed, 17 Sep 2025 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jB/PzBBa"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013063.outbound.protection.outlook.com [52.101.83.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A007834BA3B;
	Wed, 17 Sep 2025 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126301; cv=fail; b=rGc+uN9HkVVow9CCmu0UwkPtQo67M+icn6OXOD89Sl3cG/WT5+BdkMLpcT+08GgZsjlmeJ8c0YZElQ5ntQCuPwQD5bspNfN5MTTsAnJ4gJlgZge26PS/25ppwyPfBPbyWXB4Afj/zYvMx6CSUh/IAxghcQzgQ70gndzSpQy0Vlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126301; c=relaxed/simple;
	bh=XSVwHRte9UtoiVFCU3Xzn+jsRQ0AAPWCdQ0O68YIAP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OgdicQNMxn3vqhcyjs99NqZuCC97gYJeLq2Q2DtH9GtsuZO3PUSDotJoh8OAKzb3fAjfu7J9Br8qYg0OBW+gE5zbp82IVENlFaT9ZCa1yUEQLFgrfAYsYGZucFCxMx10rkZ8IYBZ/054+GtnpVBbQmNt4xxK88E+Pmg48TVPLFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jB/PzBBa; arc=fail smtp.client-ip=52.101.83.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emvHFKvKIx+xAQg7FAXWBH1bbUiy3D0iElyeUV9lDMpXIHM71f2eiiGThtmi67e8zw8eIxAnM3z5Ag+HqvC38PCKOG0JhNjH1pSMSGhMX18+ogDfsYRQ5CNnS/LkrOZzC4pnixia5pJe9A0fzS5bxMm33O8KaNIEcxfUyWUEUsODk7y7fyQBZ9vAlXnV1HaNLlqBaKzX365No0aePIGVCmEs+CrcpNaY5+MXpmnyRjZSYC7sOyDhoR2umWBZADy+dpcw7f1RUri4+Lk1eGaMePp5JccgTfvrnAGitf9CM43Zf3t/x9fwaev2GLXpagqNbOCPAJW3PorvkxN+Ru5f0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/DVGXGYBY2l6/FasDjl1tSg0joWXaVCXq9Pr1uxoYk=;
 b=ZUVs0FEYx+yUEJ+0J21nJPhlv6tbUvN2cf16tyDiQo6e7v7dOLlVaZZTIYcihrx62B34287d88+RMUOHdp2/v7C52iZo3ZVC9/JvjZ+36JtS7orVnbUcESiKlRZ6UIYIa0swBpTrcRvQRjVBS0Ff+JOioe9dKDWQ4/EYDafy1P8dv3mOB0OOjqlJPf/VfzBPDraTkZsviSgXNq7Xnv2O5Ad4ct3woc1STcVZCKGKjNQ1kxm2oH88WmtzGn0gRuU5m2U/vsy3Fim5LRMmQR16yBFKn2cr9G/P/mmXjuy4+20WBMde0MZhnN6j1x5NfZSh2l2Frm5gjbGPGMWCiGEZHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/DVGXGYBY2l6/FasDjl1tSg0joWXaVCXq9Pr1uxoYk=;
 b=jB/PzBBaz68Qx6+Cj5iM6OyoeVLtM6GBcv727JxOjICZyhxZRGAHiFIoawrhLHSLG78MlwujbFrqRFQVBRR7HDWRfw7AgEQXoYa2LoUurAfXEAbEOOc4xC6BlxXGxlIs72DwmRFz3CtrooiRybGJeGCfle6FYzMT6AsISzTV6s/dArv6m5v2Nrjmn3dH8Nn1QJW5bqxQf5chMrNDE7+CNmk/6Ze8R8Tp2Y8YwIo4Ogt2j13vSJk9Xu2txwiJZv02lGxNG8CmjQFuIvKg9Z0OafdIbi+G5m8M1GtZu/lPRThD4RpqVUYluT4wZIWdcLKE7Gxz5CsZkxgy0hQup116GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI1PR04MB9859.eurprd04.prod.outlook.com (2603:10a6:800:1d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 16:24:55 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 16:24:55 +0000
Date: Wed, 17 Sep 2025 12:24:48 -0400
From: Frank Li <Frank.li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] spi: spi-nxp-fspi: extract function
 nxp_fspi_dll_override()
Message-ID: <aMrg0CnsdQozU9G7@lizhi-Precision-Tower-5810>
References: <20250917-flexspi-ddr-v2-0-bb9fe2a01889@nxp.com>
 <20250917-flexspi-ddr-v2-1-bb9fe2a01889@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-flexspi-ddr-v2-1-bb9fe2a01889@nxp.com>
X-ClientProxiedBy: BY3PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::18) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI1PR04MB9859:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f06b881-4e94-4869-1ef9-08ddf606bcb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jaq3fOiTQCbBCvZAv9R+0YLEOZ/UDUZcK0t4yk/HRfWeJopb+UEtLfqZmH8Y?=
 =?us-ascii?Q?z+jDNGM1hPiCqMjfqQkIny9DtMC+whvUPc2I/CrMUPz92kB82nAWJi1XK79/?=
 =?us-ascii?Q?47azh1i4cmJOxzctDasvBCzld6ns15j7uYNXavWLvm9vFGwy2pTloiNAjrbo?=
 =?us-ascii?Q?vThdYlmB3/Y4Ff9K2+ku2YXz2chiexbnf4Pjof51SHiWOfy9HvlEeOirSwQq?=
 =?us-ascii?Q?oCn8CzGa6cDsZ0fdbpdXkTynEjTAsSLLieSuDO+qd4aN27DKpQj+5S5M574B?=
 =?us-ascii?Q?PcHgYVfhBga48DTT4i1bXLkTmu2W3e/9OgqmA981DFhLd5HYYrTHmShaeRZD?=
 =?us-ascii?Q?42jQaUp3xgOU6WekOvP5DtPt58oakedeIUF56eTOm/V0qWeVWSiHJspLZihP?=
 =?us-ascii?Q?PYUKswT0dPWCt7fmRYkD6ie+HaLo3VL5plI1ywZbj1VQA5VI66j/UWxGYZJG?=
 =?us-ascii?Q?kbLoT+7dUiza4t7/D6pOmQNmvX4wMMWHwpG6TzYvmELmzAwm3XEPbrqqAu8I?=
 =?us-ascii?Q?tI/1gMp/wWediMRBRgMRHMAFPRlvXmqGYFHM29YbgOy0762cxc/cfpRoT6i2?=
 =?us-ascii?Q?RbF3BK3gOF7xH4mMeMAT1y8/HUpwESHVTgnQwJ117rh2JydIOniqB5DKZYMj?=
 =?us-ascii?Q?9b9cbD38KccFZKdIbHkU5V5QzJ5Hzytsih+aBU/aWzgu3xMPOVwCNDC0pbaR?=
 =?us-ascii?Q?nxPfvR1hG0zusgkxHHqjMkLDaqw0aZlXeOAAYOt/EqTzfVv9no+gozFxN9Z6?=
 =?us-ascii?Q?g1azfMYr9m24ucwp1BzRmZCQsgDjffoiXHne/IvRTecS6txAvzO5piGVqfCb?=
 =?us-ascii?Q?iydIrhaJLLXjnWiPLhz/LVa7os8OA2TAqbldjALAsu497zzqPjDrdMx26b2/?=
 =?us-ascii?Q?wsGTQx5Dm6lP1k3U3tINu0tCGvbogqQujAxYY4pb2PTLW5ys59njLLOIB8SC?=
 =?us-ascii?Q?2NgxyDFEHpmIFTi3ZFUdS51DX6VlyzSrTO0Y2QH6t9ZYxmFmpvpIdL725Pcv?=
 =?us-ascii?Q?B/+LDdFrTuzTErV0vBLuZAOm/ywwdg5Pa2oYM8dC3jsxlbmpT5xt8+w7AWBQ?=
 =?us-ascii?Q?0oJWHXUBG81If6QnzAWHuUuXi3iyo1Xg4J57+fj9imdD0RxN1heBe65//Z8a?=
 =?us-ascii?Q?8uwHkRbSjbLZCbH1O6Y8wFLZ6RxHQLSaWhga05h/G2tmOupAZVc8fOFwIgI7?=
 =?us-ascii?Q?4349NpHEMDx3NzuL8aye+mrTVgUbdxas3VT/AmXtv1KWOY0JgfnUqezkMlmM?=
 =?us-ascii?Q?13hGEaNEud83gMA83s04b/n5T8iOxB9XpJj0s8L1wvvCs2qLHHFXNOX8U6q+?=
 =?us-ascii?Q?wXvKZORfxo739GgvoHZkBDa358fUa1iJQvNh4YxBuT+Ty8Q2h2X2CXvO2CRE?=
 =?us-ascii?Q?eK9XxT6KfyXy60d41kB/0MrBfIzG8Jabh1ajlWKw2cBHUySSjdcU45RNz/1O?=
 =?us-ascii?Q?WRbllZvwCFLCSN6L3s3A9PDOS78zTXoXpSC2uTzTT9zCOa40IesFRw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cXKiEiJeBlZ0HH1ACEMzRmOEqM27SgmSQyHWvX7wQeESscxDyqBKzJWvdtT3?=
 =?us-ascii?Q?M9i9zrUh5n61yMOJCDqDdCvpYrYlUF7SVc041+SctyQd+MmY53aLwrImW11z?=
 =?us-ascii?Q?b9bHH0vtMkrv5KOfPEIc7dpMbFJOiZDG1m3ljLVA6Q9YKlnphLCzOhtu/yh3?=
 =?us-ascii?Q?DHI8lY41HQuReeDiVE9a5B9+9qG4K9+xC998ySfp/y5Sm8MKnNQzGMqC8m3o?=
 =?us-ascii?Q?ZUzoCQ/4f7zP4zEQu9n13fD25WuMjxEEmRIvh/QAwisgOEG/g+2m+f519i/v?=
 =?us-ascii?Q?ghYZXgYItKUJXkRHcMWdBh3KiKgu0tKnsj3JyAF5nQPquoiSVDZ6js2PITju?=
 =?us-ascii?Q?e57WxzzKxMb2FiOtDPm/n4w3uzZdtFIh3GjDpNlEOJicZXEK73DSTS1gtEmo?=
 =?us-ascii?Q?8PmSQXQ0W28Iz1blnSivz00Gn9c0lDewv0Op/CAlBiKh8LGfaYi7X8fB8ov2?=
 =?us-ascii?Q?RiayZSF2buI+TpFlhzFdXXyrPQttVGshTqm5nHFYS+NNQ9atqOnQV9tbWA3g?=
 =?us-ascii?Q?YH3kuccUOgESMOazvrY+a44ZzJc4zXlQ2kLNn9e+tHnapm6Xmc8EmdCAvrPv?=
 =?us-ascii?Q?q4DfTc//NEZPG7fupkRMXOR7LwQv6Jo6gHuaJCAW3kxd78XQbuZTDRz0MrSn?=
 =?us-ascii?Q?nlRnVeZ6SqUJFSCyO2twQGkzLt4GDENMW7acLWT/bmQxRG4eGxcckfkOnrTG?=
 =?us-ascii?Q?Jlfgj3iqgre2gzSR7cFUTvUGAyE4RByOkAw5sf01RHqvV7zTOhAYuEeXxxS0?=
 =?us-ascii?Q?iOhEmELUtwi1ATZ+PaWeTXGUrQfNCyxcaEgj7tQtqL4bi1eVp7kFlyH8l/FI?=
 =?us-ascii?Q?RRT5F14ylmkKkZtaQGghSGXxcHxZGBhcv6/kR5nq59ZvWO1Ea1pTUhLrqfD+?=
 =?us-ascii?Q?LyMAJOz023jAwVHCuwI9jGu2DnRalXBvCqMlHDNKjwDcNQBRBMINl4S3UJup?=
 =?us-ascii?Q?Au5X/Wr5ijnEE0F/tTqEwiYPaE7up02Y6oJ6ZvaHt70e+Nr+9U94RmZRTxd2?=
 =?us-ascii?Q?jOoaOAVAlw3et14f6A7r3yASXgbNqAaPd5jNiOHNO2L1HEhpD4a1gtWoKhZG?=
 =?us-ascii?Q?zBLNAnAtvpYRg4yyW/UR2twzjXPIbcQ8jZTvPIvf5WNOKGSwhn31CP2xYrRf?=
 =?us-ascii?Q?rIGUrCA80xTM0A9QB2zkBbiPX4/gik2aBr+TjYdXcjPohzUoT6Y3+bbqdN7a?=
 =?us-ascii?Q?RSWMF4sdvwSlNWNc+R97OoFXdApooUMti4nuwGYzQ7jhwVEfHvxinZHBvZdr?=
 =?us-ascii?Q?sZD9GlNq6KybZOgSv4qZlQ7kU/5fQc2XjYj6OPSWn5g7DLW6+fPoAIySq12x?=
 =?us-ascii?Q?crpYpLeCqspnzLcfNyhEB+cLvJTioI4Oh/ZHGBk2S3ogDDn43qg2sdt66XkN?=
 =?us-ascii?Q?7oB5rRA67th74gEw/to3+OSrBzxoq2e56dHUoWvI4ChpMD7rzVZmq2l+j/TH?=
 =?us-ascii?Q?HBmXu1aw4k6ewgEiauyHg94xNrUjAh1y2oSNmhRctyOnBn0/1lzwWdA6JRTI?=
 =?us-ascii?Q?1sMWtoesDLmGWMLtgImVyVeRMl5AFDjUrg+lQcfgx3K9TYj6VBMbLu/EqC3X?=
 =?us-ascii?Q?v4qlHp+APIG/VVSYnWB9BWeVkvAUvGpzXcaposmN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f06b881-4e94-4869-1ef9-08ddf606bcb6
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 16:24:55.4022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFKizqBNJjoxz5lSZBUcTRLcx2PhbmtTpcvNWEyj3He2XhZK5zy2erRPx6s/H5773Jc5oEA6pvcOFAAnvvS95g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9859

On Wed, Sep 17, 2025 at 03:27:06PM +0800, Haibo Chen wrote:
> Extract function nxp_fspi_dll_override(), this is the suggested setting
> when clock rate < 100MHz. Just the preparation of supportting DTR mode.

Remove "this is the suggested setting when clock rate < 100MHz", which is
not related this patch.

Extract nxp_fspi_dll_override() for preparation of DTR mode support.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/spi/spi-nxp-fspi.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index 848fa9319e36d65e8152931324b8e34eb162f5d3..db4b92490de957580c6298baeb8b68a310c23615 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -674,6 +674,17 @@ static void nxp_fspi_dll_calibration(struct nxp_fspi *f)
>  		dev_warn(f->dev, "DLL lock failed, please fix it!\n");
>  }
>
> +/*
> + * Config the DLL register to default value, enable the target clock delay
> + * line delay cell override mode, and use 1 fixed delay cell in DLL delay
> + * chain, this is the suggested setting when clock rate < 100MHz.
> + */
> +static void nxp_fspi_dll_override(struct nxp_fspi *f)
> +{
> +	fspi_writel(f, FSPI_DLLACR_OVRDEN, f->iobase + FSPI_DLLACR);
> +	fspi_writel(f, FSPI_DLLBCR_OVRDEN, f->iobase + FSPI_DLLBCR);
> +}
> +
>  /*
>   * In FlexSPI controller, flash access is based on value of FSPI_FLSHXXCR0
>   * register and start base address of the target device.
> @@ -1071,13 +1082,7 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
>  	/* Disable the module */
>  	fspi_writel(f, FSPI_MCR0_MDIS, base + FSPI_MCR0);
>
> -	/*
> -	 * Config the DLL register to default value, enable the target clock delay
> -	 * line delay cell override mode, and use 1 fixed delay cell in DLL delay
> -	 * chain, this is the suggested setting when clock rate < 100MHz.
> -	 */
> -	fspi_writel(f, FSPI_DLLACR_OVRDEN, base + FSPI_DLLACR);
> -	fspi_writel(f, FSPI_DLLBCR_OVRDEN, base + FSPI_DLLBCR);
> +	nxp_fspi_dll_override(f);
>
>  	/* enable module */
>  	fspi_writel(f, FSPI_MCR0_AHB_TIMEOUT(0xFF) |
>
> --
> 2.34.1
>

