Return-Path: <linux-spi+bounces-10056-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3E5B59C59
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 17:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587FE521359
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 15:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B62346A1D;
	Tue, 16 Sep 2025 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d1Sv6TwV"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010010.outbound.protection.outlook.com [52.101.69.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1457237172;
	Tue, 16 Sep 2025 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037408; cv=fail; b=Z1VUWaXeHQzNPIUCMwd0gwpmCEF18iu1fgrxW6988O698loLlfTNz/BA5kIZVh0lezRYpZLhG8ymUSKtmQD/rVffaEI/m4Z9LT3dQeVTzsz7LyIHOmxG0KpbjUwBx8rb/J7M1Kyaq1JfS5qmLoMHfdXYX5mNX5NBwNwqdTpMFlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037408; c=relaxed/simple;
	bh=k+x+EejTrEPCClAUj8qWUiDk5ytAGrR5sorute4BePQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jQ+Npf2KqwzDFYTmCe1+AD6D6z10LKAOioSLrBsgf8KPeGcTl09K/naje1ruWvple8aYEcViglep6ZJaVYsQxtRPdjdUvEPataoiHl6oIkZaWCN/lP7qjkZsGzWU+IeNXXxrpf2ELPcYw6nBLLxI1/neXYLDppOcgABV6a1yNCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d1Sv6TwV; arc=fail smtp.client-ip=52.101.69.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDsNX8dOr5B+6SqSNVx+FBfDuAJLJWddvqvCA/52LgQYfT2YNNP9u+AHo1HmW1kbFexrsJ9E713ax9uywbV1UfNUQUyQHG7RmznktOsTI+Z5kgb4E7rSJFV8BCef7fBxNdjywZ43GlHcwXlM6bUHQy9WFexaSVs9dv5EURLrcChtXW0PlecWejnIqjFWbqKwfUWxNaD7jGu9FTmIs5hW5+ARC6c6zbd48g0hZ7AXA1DFncVdgsVg7Rac0+N7vWVAKYCAK1EP2aXECbazzphnS/W4MyD06QCdrdnzECuDz4Q4zOTxbFobWtLWTF/cUjwcfjtqPYABHKq8HV1qEy/Tlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5nOAF2llBOtTZWdWb28XQBREVpTnzlNfzAhD9nleR0=;
 b=omeP2VlQ0PgzlQzaw11eqjCjndP1OPwTYMqQYQeegY88TMZSfRVD4uMpmu/4gPRREbwWa19F/iFTli5sVJHmKeSP8JyF9k6fMyAl7meFNPBiIfMkb2Jzulj0WX+QOLquhExdZWOuygYUXM/+lC3Uf+tCzjES3pr7r9pYja5WDsg0mObb7MjzII0zYjm3GmTYx1DKzVjhRuhgPewG6QHazXjBpL5plP5sFqzokNlamMAvMkgEzRJ+egSfz46TJZTQ9DScGn6If0Wpw2wt3E63ER5auW2hW2hhIhxtOU7+wL5mRW1rPu9ZtWPb3B+x1FrJ65rze8j01ytre4PlNKPY6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5nOAF2llBOtTZWdWb28XQBREVpTnzlNfzAhD9nleR0=;
 b=d1Sv6TwVwZBNzA0WPqzb1vi/BiHE0+j2qKgdd50N5sqCpoDuAt+8sGdOh9wTu1OrxF55jLXXwa48Kf9445cVCNFkCOhKuP7w2vSHwMNBTmYsvuAWOb9cOgb8JIqCkS+2N1JTMsVGNRdzOgI56/DUWnBwW0fxF6YyAMhCeWEwPXhw4yxWHFI9yJtWc+hGhkFL0gdc/rMo1wZQ9BQytxU2Epnrzu0WQVyVZ22lP44bRnDnAb5mipILlF8fE+rkUWLNljvSJLObB2m6UGOCIVN2V5CrgXf7e5cTPLTKukZibZP2TY7sGj4oy9IKkKSOIDu37BaSh4bS/W+a+OcNmCAqNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AM7PR04MB7110.eurprd04.prod.outlook.com (2603:10a6:20b:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Tue, 16 Sep
 2025 15:43:23 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9137.010; Tue, 16 Sep 2025
 15:43:23 +0000
Date: Tue, 16 Sep 2025 11:43:16 -0400
From: Frank Li <Frank.li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] spi: spi-nxp-fspi: Add OCT-DTR mode support
Message-ID: <aMmFlClUOkFG3TyH@lizhi-Precision-Tower-5810>
References: <20250916-flexspi-ddr-v1-0-69358b5dc862@nxp.com>
 <20250916-flexspi-ddr-v1-5-69358b5dc862@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-flexspi-ddr-v1-5-69358b5dc862@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0372.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::17) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AM7PR04MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b03a82b-6ca1-4f66-083f-08ddf537c4f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+3LWNuJNz7TqTg33ZLXyfRL6v0hjXOYJZXH9M9WdYj1/8luKyE1hzKmOQJ0f?=
 =?us-ascii?Q?FY7Gg6uFUcEl0+woe5IMZa1idZcbMwYm9f9x5gHtddPvlvmLpPjCUihzRKH9?=
 =?us-ascii?Q?R/8wdEKFmBFUhBBd3qJzsuZik/v4A/Xt7jgdCTZBQSLeoR68bCfPXlMfyYMb?=
 =?us-ascii?Q?TXwJ8UNbClMlXN+Sdt1raC/EdIifILh7qtqm7saSoKLarJFtGEVzKFHLUHqZ?=
 =?us-ascii?Q?yPxKxS3hAcD3cQY2jjzbM0QSej83H6KI+7XkEamCw8wSUWJpHJDxapxJloAk?=
 =?us-ascii?Q?WOV1IIfm4LHJE8x91HaaeoArFGH5k3XV6pEYWGa/Ftgrk73roDYKBZZAzKa1?=
 =?us-ascii?Q?/cHyNtqk4/gAvrnHA9yrztTF7bVkZHCNYSLCI4+k1YSuH4xZq7zCVPj8oni3?=
 =?us-ascii?Q?yuC9ImqJehb8sTeNCZxYBcEemGLkNqde1N2Jcjv/5X4HRjsPJciQCbUyE0Qw?=
 =?us-ascii?Q?C8feQc6hNBZzxL2wc+FP2aleLrAvA83zDmtZ3g7i429owqsQl68HV6nuLm7x?=
 =?us-ascii?Q?ucWWd0Od/qdesPDgPASmNKkJxDc4a0MyJjsVSIWXD114IgTGJpvxuJ7Esyrf?=
 =?us-ascii?Q?Fqa5CpI0ZwlfHwU/78FNNMCoIdpak/mcKSR/0ZKtAOt5xomfoISgaNIBwf0B?=
 =?us-ascii?Q?gtykyXnymft6kZjxn/Z3usF5yw26bGOBNP0gIailIIzAirTrJZcBBiIV3KE+?=
 =?us-ascii?Q?l/G8+o2EclP0C1RTdvfuJjPRYerYsQtzb3/FVqZfgZcwi0Yl7kGAIgTZszME?=
 =?us-ascii?Q?UtfbykCRkRI3a/7mGER/RNTWAqdQ2ezxyYHsbXDQLKBuPgSTWBDpAnil++kc?=
 =?us-ascii?Q?hI4Q5iKUnWpD0Z1dF7nuOXRZyZKuSgm7DuFuTu8i1y4fqzjAdTV5yEA3EjRS?=
 =?us-ascii?Q?yuBW6NJGMi/07A2AohF8ncixf1aqE/QfndUTpAKMcBZTuzifyCCMKql+OMSm?=
 =?us-ascii?Q?ClDHWoGyqZMCmkLGsEBYlO478Pz4VP0kD43LwrflUxK65aSSexNqUzfQR8Vh?=
 =?us-ascii?Q?VS6hYxl8Kyhv/ylMhbpRc7XMjTNsunZYK00szfwK8RR+Tal4QyVMTtQ8hpJh?=
 =?us-ascii?Q?ELha4+e3BlKLPy+86/OF0/0ih7HJKpkE3Ji+HVrJoNIyImGJuHrpHTOWsnTo?=
 =?us-ascii?Q?weMjCt6OGQoyRnL2KDXyWTijbDhHz7/U9BdxEahawAYJobvi7pgAFUlyFTmp?=
 =?us-ascii?Q?5Fn/4stqSFTdNMjDDltK+kuD+SuZj08sMfVPMK0YNRNxWLWIetk9D+LeTY/t?=
 =?us-ascii?Q?hQnuHfrvGmEGV/JlriD5dMZmU/6Dei6qhw5Rkphk81I6yToAdOa8f+I697HW?=
 =?us-ascii?Q?5LQKxZQyawN3eLViLOeE2+1FgjKqlIIYCnaUWvhTllEIKbiKEw8UxUa3inFP?=
 =?us-ascii?Q?suGi+nXX2BK7+WECmv1N4UuEMD63asP3fxlJpt8HNUZF/TxwX95ws3Pqt7Sy?=
 =?us-ascii?Q?fJWzo1YAFp+f83qIOJ6j/14hOUYqInMc4EVSovQ0V95ObJaZCPuiMw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+6RVlXXHd2L9MW2Np0QI+I7yF2dIfhSKwgoIhxC99QpV38wJIftsxA0Tcvqu?=
 =?us-ascii?Q?gaHkyQ3jtTYvQqi/d6heAz6UJRBOjHbvQ1DIRCmOvPNcEQN++a8821VKaiCV?=
 =?us-ascii?Q?yBPxw6o+yR6Pc9B/z1cXdAT7yDZ6IwcxO1l+Wx+q9eUWQREcR3vymroxadFk?=
 =?us-ascii?Q?A10+pKHvnn8JZaXruokG/Uac+ukSED+twXOMMGAuhAJpdTg/t80y/JBWh52N?=
 =?us-ascii?Q?yIx+fBZC+BL725eQf0tujiGjGd2Ml+O9QOlYNbi/3HkuT32VeSeoGOb5lOpD?=
 =?us-ascii?Q?ChAoosEoapYArSq+/talCDcmyqXjoSVxqi5bBdyE3fxX6wMOyXlVxJuLBFpB?=
 =?us-ascii?Q?vR71RC9B95++rUSawsGAWtD5y/B4+E/LUzxJcn7xcMuWIV24tVY8Qj1Lo+eg?=
 =?us-ascii?Q?JRItYQHUrA4F13z6gIpzK5NeJqWIqrZCmbX04umiKgjDya0lUVWK3uvIgldi?=
 =?us-ascii?Q?UjkLZuwn7pwTJ4yZ0Gv4OaUyzWIwdItmSCJ2e0iwyAECU7mWzfdWaGz2nCPm?=
 =?us-ascii?Q?amcgxl/JUh7uIqV4gK6uJmYxHB2fat4qcKVWHNswDQt1tiO85tuO5eS29wyo?=
 =?us-ascii?Q?8+2MgoUXFt5+3hBJInPaBwcp1RulifoSwsnODlMFV9CikxDBBZCGbdASicZL?=
 =?us-ascii?Q?SmjwdgP5HhGVWxBzEf8RBraXwBkqjyZ346w1sr/+NIgg2RHvEm9InllnZ+wE?=
 =?us-ascii?Q?XijzkLhLvpZIVKgrKigExalej6dSLfIoXUXoQZKnuE30yEpXwr+ySrDA0Qvf?=
 =?us-ascii?Q?ANYQSQLJP6NzcN50Gr4BYGeigIss6g7zsFyO0XrBJAbppe5VJA8zS0ssAWew?=
 =?us-ascii?Q?p1NhVnIet/2D3H5H5d2x1D+tucbksn4OElHth3HtVyQZfsO8p5A6z3Yv+YmR?=
 =?us-ascii?Q?RKhjyENHDZm65dFkQRhkBK12bAGhPj6KflCokyEwMGDHZ4o/PHXI7YAHdtdL?=
 =?us-ascii?Q?IHiZ9df6I/JB1LPBxtZoU18yJ8cAZ8gEFXxYuSuhA+CBGF56kaApuOFkh9MG?=
 =?us-ascii?Q?LF2x25cIBZS2e25JgwU4xsJZRoiuW8bJAdOmwGeVZfscn1xfCcPr0cgXx5eA?=
 =?us-ascii?Q?82qOozqmom2U/2LAqgKn3jRb9dcGz3Zcc/GL8hvPzc2iUrPqwfWAQv3nw+6E?=
 =?us-ascii?Q?CVOKr1tEdXUSf9tuQEZmrkVqTccln+BUKxi5MJc83zizivNeXDkkPVJsbYjR?=
 =?us-ascii?Q?tnbSMNY3JhogXcqCFYCisYUompBWLRMwBm7XMIqzex2DFur1mh4erpZ0Dcvx?=
 =?us-ascii?Q?EKPS++GtBekNXxGGMdNZ6If48jJ+2TVLOBTV2p0172v51EWXl5DSOjNmtqe1?=
 =?us-ascii?Q?nxS+IlR8d/sY3lBnF59SgEC7k6dcqpV13CRBOp7wydRhUCGgvKUhQ6wAqVPb?=
 =?us-ascii?Q?+rg4JblbkO3iU6WMR9svxPKMiuZnTrBtiCKqRJyY3mOJ2pB4bl8ucsHtIWkS?=
 =?us-ascii?Q?9p68yOGe+O7nlhAHIFJR42NHYn9EdOCTSLeg5MeZulIqodB0NanWnVcZEX4S?=
 =?us-ascii?Q?bscIvD0TEWFqZkYnpcW0+1PSkldI0q7Ro9zVaMVLPVyUG6IkBPtWQSE/p/eK?=
 =?us-ascii?Q?e5JOscHgtXgJU4ZMVxQASUMtTuHqSatjeEkSZqp/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b03a82b-6ca1-4f66-083f-08ddf537c4f4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 15:43:23.4630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: McNnP4BS6EkGGQv3Ae7mW6Fxf4uIlY1HkQVkRzo2RCzkPy9TmOvy58LBpn3dyowX/o78TAu6mYZNks2M5Ck3iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7110

On Tue, Sep 16, 2025 at 03:56:44PM +0800, Haibo Chen wrote:
> Add OCT-DTR mode support in default, since flexspi do not supports
> swapping bytes on a 16 bit boundary in OCT-DTR mode, so mark swap16
> as false.
>
> lx2160a do not support DQS, so add a quirk to disable DTR mode for this
> platform.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/spi/spi-nxp-fspi.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index 15b094e8e892f0b61c1f320bba897fa1f588be91..389cb20872db6d9653a146eac7182b9a4574496b 100644
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
> @@ -1236,6 +1238,13 @@ static const struct spi_controller_mem_ops nxp_fspi_mem_ops = {
>  };
>
>  static const struct spi_controller_mem_caps nxp_fspi_mem_caps = {
> +	.dtr = true,
> +	.swap16 = false,
> +	.per_op_freq = true,
> +};
> +
> +static const struct spi_controller_mem_caps nxp_fspi_mem_caps_quirks = {
> +	.dtr = false,
>  	.per_op_freq = true,
>  };
>
> @@ -1351,7 +1360,12 @@ static int nxp_fspi_probe(struct platform_device *pdev)
>  	ctlr->bus_num = -1;
>  	ctlr->num_chipselect = NXP_FSPI_MAX_CHIPSELECT;
>  	ctlr->mem_ops = &nxp_fspi_mem_ops;
> -	ctlr->mem_caps = &nxp_fspi_mem_caps;
> +
> +	if (f->devtype_data->quirks & FSPI_QUIRK_DISABLE_DTR)
> +		ctlr->mem_caps = &nxp_fspi_mem_caps_quirks;

the name 'nxp_fspi_mem_caps_quirks' is too general.

nxp_fspi_mem_caps_disable_dtr?

Frank
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

