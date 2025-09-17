Return-Path: <linux-spi+bounces-10071-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0434B81096
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 18:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C011543F17
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 16:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35282F9DA0;
	Wed, 17 Sep 2025 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ICbmNfyz"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9612FB98D;
	Wed, 17 Sep 2025 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126632; cv=fail; b=P/f5T06zUXwvk0RH+//Sy4Cwy1l2yzjj+BbfIFAVhDPSscRQ8T6vhSqNSBDZT7R00QsbQZ6SeYRXw57QV7osiZ4ba3YXWZopE36RxaKY/p85k32JCo0gAV+++RE8vRa55wnS6j60g/EPANHFMK78Z/AYyRfmdFbqTeBNW/gpLqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126632; c=relaxed/simple;
	bh=IgZ65H8zFzVtEQEPC1KbqTPuiWFDlJubeKdFViqD+PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WmVNqBI32fQkYAwl7wSYqYDbor4UXPLKExzd1Gb/M+rxTKWuSR/Ck5H5p0yUZMEYiUAxo3+Exjyti7mtWgx7UdOMlFlOlHkDPB68b4S/k4YeFViMFdAd7OwM+dcfdHAK1BqhY2J6UX5bHavqdOM0egrTjy5oQP9KX8banG3v9Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ICbmNfyz; arc=fail smtp.client-ip=52.101.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syg+zAP6uAXCdL7pV9TDkfurN/0//eST3RS13SRQljIwq1vPGnOvefT3KMFITvDqo/U/P/S9VBxwnrKNk6dKX+YYRFJatbdAPpoytWie6TFh2mN3EUXOp6BOzFC6aLdWdcRDjVz3u1pc/gFgkQbcWzZX5K6mY9BjpjYoMdevncM4p0Uvey14cxwmHjVLYkzxa+716soDEWuACxDen7x11TychHd/lLY4C8N+Uoe8duAf3Uo/qqku9HANtRR+2+tk4f6uFhH77EZPKpBe2v5+jltMjBOcHhq8jl52eE5LugbBQEBw2GFm5fmFoYtqWwhAk1/ZHv36uvFZekfAKub6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DHPm9jphGVW5hm8VjcZquBXWWDKkOaM7nUMp5T5m0I=;
 b=D3CsgLTWzypvKJ7GIRs0TA9VK+QKjdRClG/RwHy9QtfgOLtCzaxaHPYRH58um6MJG3bQo4t//R+2SKgzoqt9hy90g5IsGyFdb2uoMIaZDF0pJVXpacUs/VAkt481lao/0Tf0XNo9I26VnwGMFJFP//SCXzikt9u31sfKjVGQ6rZbhiLm5euntj4x3e6eF8wDpGhmUx9dtr1TyJ8FE9CQh8zdFA+HVI32yalI2YVlteXepXjbLHhaPQ0LxHz7EznQ/w8jPY1Awi+eKZ2YOtAYSjPHAjlbdmSi1Ztz93dgf3ARwbGvsJi+vk9PeX/Qk4yHRuZPoIwbo3gTcQ83omCLOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DHPm9jphGVW5hm8VjcZquBXWWDKkOaM7nUMp5T5m0I=;
 b=ICbmNfyzU7ANrz7g8Ea3gYFoZydb6t4McFzKFlnWiO2Spl2H239p84AhbC2QFhD077AYQHadaEpOqL3F8FIwU38aOCN1sbuo2a5oS1+d9PZaLuD9x9TCU0VPR3hVwSirPsxmHN5TvhYPButqPu9jv5MU32VUaDV9udSuiT0/EO0lMpwytia46PwKHYatz+uV4bNARW88VtnNd5sxpJsz/AGNLrYBWhaZY9t5m6UIvsGm5VryHR4xsDXZNqW8UTQ/lNwKDeefKbLHSBY1HGzhlKHdCaLf/2KoJPg/+hbStc4nXmF55LCSNMVlGgpWuiZuC0Zeu3WIDiOkvnSYZkLUyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV2PR04MB11144.eurprd04.prod.outlook.com (2603:10a6:150:27a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 16:30:26 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 16:30:26 +0000
Date: Wed, 17 Sep 2025 12:30:19 -0400
From: Frank Li <Frank.li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] spi: spi-nxp-fspi: Add OCT-DTR mode support
Message-ID: <aMriG3Sp4Ns93Mxd@lizhi-Precision-Tower-5810>
References: <20250917-flexspi-ddr-v2-0-bb9fe2a01889@nxp.com>
 <20250917-flexspi-ddr-v2-5-bb9fe2a01889@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-flexspi-ddr-v2-5-bb9fe2a01889@nxp.com>
X-ClientProxiedBy: SJ2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a03:505::27) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV2PR04MB11144:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a4fc9e-0602-4573-0347-08ddf607821b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z2qs0amKDULWuAgoY8kVv4sRWeTlZG2XQz39ey4wQ/aaHdSOrnPk6dgH1sTR?=
 =?us-ascii?Q?/3fDq0cpdSWt9fVV/8ScOdXJDK73txiEoU0ZgFBbYiSS3EUWd3fz0gxI5IL+?=
 =?us-ascii?Q?RIgslW2mDJwaohwSk9jKhgSQZAaQdcBGkm02KvH7BdOfP3AjYXXPVHZQOOuc?=
 =?us-ascii?Q?XMDQIZOpz6r6u+fJzSLT0t3tfwMTC5fLwbhsWtqio31IQukhOCKE3mEARnN2?=
 =?us-ascii?Q?339HyLEIUxB9TCgJYXMzn28dRXC5+xMIN+Nli8XguxwpmbozFnsvpU518IBu?=
 =?us-ascii?Q?Mh5ox2e4p+Kb4RTxsB4xG3dmyIgazPdJb+NqjxdoyZxWm5rrEZ8qfygQo62J?=
 =?us-ascii?Q?+fUO4g9CzAfpqL3oldlABiT4pJYSo2pIf+Wjpdfgd1qdCUqgcD1IJilCRddu?=
 =?us-ascii?Q?WfAprFHgZmdZifsILuRxY3mQ41bkY2jl9H8nWZr1KvNmWXUYHY+yie9tFcba?=
 =?us-ascii?Q?ojqAWC2CiC7uMcsOrZ2MV2y74H5gAnjBjcyYtPOoGeBDUd0Bhxjftvhm/cgg?=
 =?us-ascii?Q?XJPVNcum4fJ370KAqoK94I5nzygAIN7nraJUVR7MVtCDzBtqXWAul0v3LPSb?=
 =?us-ascii?Q?DXSzxt9tNfImmbtTX23SZ15wcXICSpPPzlIHrkwJ+P0TGbu/pGNVagd+vr05?=
 =?us-ascii?Q?6xXgcEGIOi0pPDbKWuTOhzXiF1iRPKDAWI+z4NOrqDTwOUKHmpKp3VNPaTEn?=
 =?us-ascii?Q?O2/GQ/cHxFrx3c7OFh8oB4MhuiJ2/08Mr307/i8vjZvB8LohrFx0XoZ9R1tn?=
 =?us-ascii?Q?zsDXPK+nnCO2CzwNVlut+8NMOwW6v3V95vqaUigopgOc1JRu0wBtwkS4FekZ?=
 =?us-ascii?Q?zUMbKF3d5df7AlbqDDMtqo3yf4wX12rl0rXLhWVcQkxfjMPfe6p2Up5GWnKQ?=
 =?us-ascii?Q?0pMtRvM9g5hhwU0WkhhZtMVdO78JC2vB/9+HSfolmJp6gWL98w2tv/Utqc1M?=
 =?us-ascii?Q?minuxW56Xmnpe6IWMBbVP8Y3j02r/Pbqw4f5vEX9QpIBwkcMpWbj8ptFWTd6?=
 =?us-ascii?Q?HlPkWwbUvHf8+46XCXSPMwGhBznt8rvxDwciyYMa4VdMqESJktRGu0yD9dT8?=
 =?us-ascii?Q?8h7yW9isNrJblwR8mciCkXkmqK/KuIymoCOBaMi6pmRhrcyUOK8eFTGA5aBC?=
 =?us-ascii?Q?sDgaQw2s1lyCx2MSoB7UYoyAD1pamzVPXoF5G5wo2wUlbsbtVmh77WDytsNU?=
 =?us-ascii?Q?vKHgzCiBmGspBXDWenPNYrrt+bVN4FTlHg+XW24PUZ+uH38N6swhanhvyMf8?=
 =?us-ascii?Q?EHVvHM6sZqt+C300AnwMiXznl/YQCU01cHAvsTYp7eeZwrR7xv/Mibje3feZ?=
 =?us-ascii?Q?H7lFkRxcXkwt6IxnnUk2sVKwimW/9lYv5+T1UtblPPXxur0eLcvHFNSaylyE?=
 =?us-ascii?Q?E2qXq+9Uf0602ko1cgBkcjLJ8CR6ugAdzaNM/K+4mY07qymbUbyJDT+ouaDG?=
 =?us-ascii?Q?7m8ZKqs+y9msvl4XxIP1Xi8BDrpcf/cS0NNdc/qJ8MjZpj41JLS3Rg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TR1iKtiSbAIS+IWaHxoXheosUf4ibLkG+KpaCJAMxcoXUiH1ykFypMDRl7S8?=
 =?us-ascii?Q?hovB44ppN/DxugBmGqIYgox72/PmReS6Cgv1hHt7pCwPyOSoCT6szcerHD43?=
 =?us-ascii?Q?FnUmkHRUfv7L0pnsI127daUDbJ4rhA8x2LP273d3HJ3qGGonmyw2B71lh6OJ?=
 =?us-ascii?Q?tmrr9kAI8YjFctvk5fL2uoEadzdfUwPXiquNQ91MUcU5iMmDQJmev3wNzjHf?=
 =?us-ascii?Q?eYSrNU+PMONB3d9ReyoNZhWyMU4sT6vtTYtUbP+kZM9G79NK0kk2Hro8IIm1?=
 =?us-ascii?Q?FPnxyOk0ekQaN4s+ny1WtU2f7wpTTlByGvRbCrvDknzlEf0FbZeOgy0kNk5B?=
 =?us-ascii?Q?COailTCKlhXktCZn5/zpqoNllTLqcj4/GBnxzK2bAs7aaSkn4lI1ETLCBnCw?=
 =?us-ascii?Q?dlZ9qGlmHq4SKYgRXWDMZ5DMw1Mohb3uV+X03NHwPHj2m7Pn62x4wGbAHJ+w?=
 =?us-ascii?Q?uBpVv3+sCSmyWf3I8Z+zhpPTxfXkb6KiJVYZfc7mxH+y/rRB9hL6ihdo+GW0?=
 =?us-ascii?Q?6B8dIBVJU3zpVDzLzUNLpfmjmjPGqq2w7dslFD6GLhNfdCsIHHp7KzZ//vyo?=
 =?us-ascii?Q?V2P3btWgvWMORL1AXMEAEe8EQKLtE9Ite/SME9oGVquGFZHEEOEOA/Qy9tNS?=
 =?us-ascii?Q?I53MyTVE8kUq0efZfgYe/PLNiCIkMf4BlaCkFaPKia1VV4DKmbp5Dt7t8u6C?=
 =?us-ascii?Q?Ef0ZiJ+JzmiG4YkwPMUlRzRDgggWZbHFjriqxba1rKjziB18nldwN8akKei7?=
 =?us-ascii?Q?MFdUGu6NMDPH9R69neD9oXdJxlYLxW4YURAWEjiv8TfwmQhwoqQYGrFS4x3F?=
 =?us-ascii?Q?dDLB6yYP7/h9mSTNr8UB15iNXcNnJxGhzxUrtnFaThGwIgrH5GayBI7lcjVo?=
 =?us-ascii?Q?AQL6R3cNvdgbljJYYj8NhFWGF5+Jf718vDDqbXUR+uJxBCnSGcWFj/uWKxAw?=
 =?us-ascii?Q?XE4SqIJJJPBivHrm+CXPXKN8xgSmB6F2p7j1Z3Xk2r8rphq/S4pO+/4qPAdq?=
 =?us-ascii?Q?oz6sHkfcFWEW3KtEkkDaBtbIO7s3Y8CRPH8KEEveBPqgWHhGubo/UCk12Wo6?=
 =?us-ascii?Q?jdHDP+8E/TW80hW5cMu5Mlxoz4f88XrrNCSxILYeccUQmzfPdKzkFz58oLMP?=
 =?us-ascii?Q?4n3NFMTmgWlbK+QhzAetrUEC2/Df/PFEWwWp7j5lmrUlCWaPtIPmq8ymE0+o?=
 =?us-ascii?Q?wfhIdD4kaFpWAkvfvVPR29HNgmlGOZNuLvjDiTbJ4QdHPTCvaHuVRihLhpsC?=
 =?us-ascii?Q?beci1lGdGLMy+W2tLAqVoWQYtPKoZatXaYJ7OhIAs2YSFtWMvw6cTo6KMvSr?=
 =?us-ascii?Q?9KVcr/R6JQ8mj9x7sGYhpEDkJRKGwyFIVwMvqaKYwZIDmi1OB5caTr/dgJWW?=
 =?us-ascii?Q?az8C/0dIjhMW/mz43h/lkWAGWLjjCN+IgIaut1cGRDvblYxXvz8GizaE4zWX?=
 =?us-ascii?Q?64JpRq3t1ystUBB+fkkxpcPQRu54T6Bi6Jz1Dgxzj20b9EjbRGUFb48z7XtJ?=
 =?us-ascii?Q?Cy5nuVpOsIDRuVrPgHjXpgYnXfPz7wvTuma2qK7HhdE0PIBMoRP35sbUxKU7?=
 =?us-ascii?Q?MlHN6Vk4fuMtqNNYof5r0VPnD1hVbcZaRdMTbNUa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a4fc9e-0602-4573-0347-08ddf607821b
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 16:30:26.5415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8BIbIWG1vXL07x3/zdrC637LfnZ3lC7mg+fMq1Gp9q8VLgPaVdKg47vPXaNUY+VSAtVJSG9+9xl+btuqg77BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11144

On Wed, Sep 17, 2025 at 03:27:10PM +0800, Haibo Chen wrote:
> Add OCT-DTR mode support in default, since flexspi do not supports
> swapping bytes on a 16 bit boundary in OCT-DTR mode, so mark swap16
> as false.
>
> lx2160a do not support DQS, so add a quirk to disable DTR mode for this

does?

> platform.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/spi/spi-nxp-fspi.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index d25679fafad7a94a7ea2a79d7e3da53f4939c9fa..f9371f98a65bdc7e5eaa612c0770a6228bdda364 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -330,6 +330,8 @@
>
>  /* Access flash memory using IP bus only */
>  #define FSPI_QUIRK_USE_IP_ONLY	BIT(0)
> +/* Disable DTR */
> +#define FSPI_QUIRK_DISABLE_DTR	BIT(1)
>
>  struct nxp_fspi_devtype_data {
>  	unsigned int rxfifo;
> @@ -344,7 +346,7 @@ static struct nxp_fspi_devtype_data lx2160a_data = {
>  	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
>  	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
>  	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
> -	.quirks = 0,
> +	.quirks = FSPI_QUIRK_DISABLE_DTR,
>  	.lut_num = 32,
>  	.little_endian = true,  /* little-endian    */
>  };
> @@ -1231,6 +1233,13 @@ static const struct spi_controller_mem_ops nxp_fspi_mem_ops = {
>  };
>
>  static const struct spi_controller_mem_caps nxp_fspi_mem_caps = {
> +	.dtr = true,
> +	.swap16 = false,
> +	.per_op_freq = true,
> +};
> +
> +static const struct spi_controller_mem_caps nxp_fspi_mem_caps_disable_dtr = {
> +	.dtr = false,
>  	.per_op_freq = true,
>  };
>
> @@ -1346,7 +1355,12 @@ static int nxp_fspi_probe(struct platform_device *pdev)
>  	ctlr->bus_num = -1;
>  	ctlr->num_chipselect = NXP_FSPI_MAX_CHIPSELECT;
>  	ctlr->mem_ops = &nxp_fspi_mem_ops;
> -	ctlr->mem_caps = &nxp_fspi_mem_caps;
> +
> +	if (f->devtype_data->quirks & FSPI_QUIRK_DISABLE_DTR)
> +		ctlr->mem_caps = &nxp_fspi_mem_caps_disable_dtr;
> +	else
> +		ctlr->mem_caps = &nxp_fspi_mem_caps;
> +
>  	ctlr->dev.of_node = np;
>
>  	ret = devm_add_action_or_reset(dev, nxp_fspi_cleanup, f);
>
> --
> 2.34.1
>

