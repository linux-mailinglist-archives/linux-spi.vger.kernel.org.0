Return-Path: <linux-spi+bounces-10050-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 534DCB59C13
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 17:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08ED73BDA06
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 15:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C256342C81;
	Tue, 16 Sep 2025 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MnWN2No5"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013020.outbound.protection.outlook.com [40.107.159.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD3D340D88;
	Tue, 16 Sep 2025 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036499; cv=fail; b=W+vo/U3ytSdzXDd9Bn4t4GqUpzB7QqRsiHbKe9mbiEq+tby74KUSZ8UmOpyoM45vf0GJzukrKokXpqEoZc4kOfHBI6yfrDdDBDKeZg4u9RpJRGhRSvFujPKByy0gSxK07L4gzq8c9+H+JW5Xk2QxLT55ww/5f7u6GfQv5YKgIBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036499; c=relaxed/simple;
	bh=3l0VVzt0UIS2TJjXEwCU7tT/frt9tS6vjEB2mim2yC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ClM1ET7kFyA59BiJAE0maavCr26BRrOlNxXs63eYV2r8aDJC7+QJDpaSMLV49awBMT+usJZewsBpSshrLBgqLJLErdWF6PNxN9NRJJaQq8TSlwUX0h7tiRo9asp6vTTr0B9KYwfxl8TyeRg4fFNpCkCPM+DJ4y9l9BH0kOk5WE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MnWN2No5; arc=fail smtp.client-ip=40.107.159.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFCKFqXYfxoenI8RxmMAL5bpZCNvmxqli6zWWjCWl6ufR1EAGariUmlQoxKtruqCJbNOLh22TtpHq3aYfPiRE6IyI+PR6P3jss49ak7QdErEdDhe9STstNx8IKUYXjtjy20Nff1DBsfm96prQMF/0eKmItxtijL6sKGh38cAydRQzSgFBHwXkLvYAF8fpUNCDqGRKnAeJ+2WBNuXpv/YjDpYy+PWzexfGNdo36SChf0+LhfVuDkNMssYC+faSdX3bb1Jezm8UWEvhxuAVSre5oY5ZgrHg+skNiJSeLHGiGC92VYOZXcy42ls351OJNWMoLUcyWFwN5aJgfV+xpAYgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0bmHeZ9i2O2S9CVu1xBSPz83N8jjL8hX1Pun1PYc4U=;
 b=mxqZyi5LrwNNy6ob4hAeFbb3xMTniWfWU8Qbvw+m3lHB/0s1/OjDgftrFmJYMzR3Nj/DcLtRAY6fYWyCcovX59d+gx2YpM4zgPE0LMIzqfTIfJxI/ZtC6E3nE2eBBR90gi3eAeY+vA7DrnOGrrrCoTCLZMcpu2UpxdZ48umLnxFAQwly1rvoKhJt8HOQkk2NDolknBSkprTlUxPLia1Sld2GmNrs2+pvdHxL8kwAuTVFr1kaJov/+vacuDgtKMAeJVASKbiS34uKgkdyypUEPcIbhp2YUk7NC4peMSFzosKRZxxSCxRegpQzRfTmkOJ3KhLcl0gZaQGzTHgP6Tgt+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0bmHeZ9i2O2S9CVu1xBSPz83N8jjL8hX1Pun1PYc4U=;
 b=MnWN2No5QwDSdB7nzymYwwn5pFzQWXb0t8g8/BaMabTm8N9S/3XhDPdLmaD0V2uunbLwHG55VJRLuFF8j4IN8I6VVq6U4XhDgItfR+O3R0argIDjIvDjbd6FmKo8nVBxXF7ixeLwBCu5fu79BJO7OFaUHLW2DSoA2GnOuupiGdPpKwaU3oj0kc6KsU9q9bXhKP6cEUPJmDw2J9vEM+R2rouoN7NgxUxtfEVrvNhtdLIRwa/DyOJ08AT/QCpK5ps4F6fX26BeCJqZ1GFQUs/UofZRae6euuKqITn2mTHFWbOARNl+9/MpL3dLeQJ7zvjXLp/KLL84nglWYEjF2ZVHfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by DU4PR04MB11055.eurprd04.prod.outlook.com (2603:10a6:10:58f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Tue, 16 Sep
 2025 15:28:09 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9137.010; Tue, 16 Sep 2025
 15:28:09 +0000
Date: Tue, 16 Sep 2025 11:28:02 -0400
From: Frank Li <Frank.li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] spi: spi-nxp-fspi: extract function
 nxp_fspi_dll_override()
Message-ID: <aMmCApK0pXxZ2xlw@lizhi-Precision-Tower-5810>
References: <20250916-flexspi-ddr-v1-0-69358b5dc862@nxp.com>
 <20250916-flexspi-ddr-v1-1-69358b5dc862@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-flexspi-ddr-v1-1-69358b5dc862@nxp.com>
X-ClientProxiedBy: PH8PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::29) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|DU4PR04MB11055:EE_
X-MS-Office365-Filtering-Correlation-Id: d27aae3c-865d-4609-1895-08ddf535a3dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kXKV5btQkCTEfKeJ8cI4qYCR1ZPOarDiSb3XuaJsKSl7IIyW0uOYit3YbQQw?=
 =?us-ascii?Q?u11iNXN1dEsFPhrPUSyDWDUJFPwDbzR+y+8mWfEwL1FpGsUyrTlHu8bt2r4x?=
 =?us-ascii?Q?JGQ+iDiXNXKB6RwiGn33USh08iD8mcfdd5qWXatXmW9Cd9R9qpc0I/1Pp8NW?=
 =?us-ascii?Q?HZamuewD6v/+67mtPAJezN60JEGz6K4AXkFCD1ZJAsNhMqodd37L7Cn61YdE?=
 =?us-ascii?Q?yx7KeJD4/nNMMj13t+BV6ZW1Jpu7h0OTrzbnLBRqMphTvBeOAkl3BlUZELz/?=
 =?us-ascii?Q?ZqTVv4ATPCrCBA78p8CdJobfi/DiFCNN9jXBXMss7gho/y4fwcwbviFF6Xwq?=
 =?us-ascii?Q?j4jH2ZJiRgmBX4sKyE4LIvp44G6qvJdXK1IEzfJnDn2P/8a781pFYV5A2+pQ?=
 =?us-ascii?Q?h/TzDaMqtcMrxEXe/govZVZ7T1reGrIRZKOIvCv0zDZZRm7Es1lCseIIQjb4?=
 =?us-ascii?Q?gneQN6erdasmbosWyW7ovxXiB2yB4E6xRZAiNmEzqeVR0gxnWhPfGjzFlF2c?=
 =?us-ascii?Q?bRDc7M0LV7XOpZ1rDxciwEITGyuxkf95n6aEQ9Fby82Y9oXb4S7t4io2KPDB?=
 =?us-ascii?Q?aT8W7rhOW/K9qhvfxHXbNJhqS21EhxkKLiq/zUpQMRjsXRMhx3uEO4cKEFRK?=
 =?us-ascii?Q?rCsZIGWXjapLk8arHJVNlc5c/ECJFQ6Dr1qdWsPWcPVADuPM23z4lY/5vwQN?=
 =?us-ascii?Q?NV4isZb/XacsfwUOcsdsW32hN1GX/VLvblPPcJPQsSXCd4YR76nXKP2jdkXm?=
 =?us-ascii?Q?eh4ny2T8HvJ5TdwxNTLAnTjWgMDTxZlRhSygQ9YjhoUcI3bFEBIrgcl0e2m6?=
 =?us-ascii?Q?xvSSz079cCDQBbRFucxt8qo9dbn1YrQvyJPA0hYWfaL94PGqcVfomnewNZ/O?=
 =?us-ascii?Q?qmNGKm5SP9zk11Jfw3pvWgvmwRpj93a5DuMtXhMwwNhT3qwZTVJqVe7lp26f?=
 =?us-ascii?Q?vYbIi/sGo9sq0eiQToTveF9f/EC071v9Cb2u/FT45GtG2dqCyvDcDbc+hT+J?=
 =?us-ascii?Q?3FgcFGwMz4JiiZr6XT2G2kCV/v2FPb2MNl2YJ6oJUtyYK0lmdkIDkOKsW9FR?=
 =?us-ascii?Q?0VUASPIjf2rWsCUdAkg/4uVFnSHjKKPYgaZ0KW4fsLbw3ocs7Ggrsp7VKQ1e?=
 =?us-ascii?Q?xHNWnDmvJkcRoMkoR09c8tRUEi8Peq8HeF8jtS632eh2Es1zuDiDPQC01S3U?=
 =?us-ascii?Q?R3Uti/zRklmOF5rww6Pm3Xl3ezlq00EWHA/HeKMSor7EG5BYrbUmmzHljHO9?=
 =?us-ascii?Q?YE9pVubQyWUDO1ZkkaAKNLOyg/hONK+s6fNxNwWXjMqbpl4Yq2FMKk4Wvjhk?=
 =?us-ascii?Q?jGpFhdXpBV5cclEN7+Qd7J3ey6xUTvdWXlrtSjvdcSrcRzKTp9kM8EioN7Hu?=
 =?us-ascii?Q?hSFy6y9oSLV9zMx3w1P9nzuTIHkWR+FfGJ3tYnwFpMbkZeaNRcJNBSpdjt1G?=
 =?us-ascii?Q?twuELmUIjfadudH1WKqJAWx6EBBYIuUWY3uiZzcV7wcqeZwsC8ciNlUCt/+C?=
 =?us-ascii?Q?Q05VI0g3K8UpVpw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bM9upqlKl8ZZmyWgzOfKRwMkE3JNPranolLa8PyXYZeCxzJ+f/wlo6p9wNxl?=
 =?us-ascii?Q?sBy3nH0+Jl/gllhp/W2an9t5WAxUiBNb/gVsT0Ot5MiqUO3vh72ap4GSIDGt?=
 =?us-ascii?Q?91+w0sUH/0Lb7HWNUFZM31VchSeQcffuP1wV4g2/8ikvauSHXIOuxw+V2pRm?=
 =?us-ascii?Q?zwkDDXbmKerambaJ1MFGXEnjRgSEL6z2iqOXUs6FQfHXYggsL0t8TMrqewdf?=
 =?us-ascii?Q?i2Tn7K4TzWkTlkZKmvRKnHUiOEOZl5UYEkjAT92yqnWLRo9lbroM4jaqfiDH?=
 =?us-ascii?Q?SsyyQsu7HFvWuKw/TbkaPvjd+8CjLsoq1ouT3vAgGy+Gb2EZDAfZt6Btnxfb?=
 =?us-ascii?Q?pcNcD0IZum4VrYlApAbmECrSjMIJZ9aPcV5Ri97kn4r0Uxsko4aDgMw3nque?=
 =?us-ascii?Q?G+/fcRVYQAp/gUqR79+AIfLSlyANhESd+i0wN4Suh4XtMLD/ASeiM/kaeQRd?=
 =?us-ascii?Q?uarxig6WRhC3eDnrmIRzuZxFy1TaVrvcyvLhDzceK2O/kTGPPfmeUTSRahNM?=
 =?us-ascii?Q?fHt/vQknfQuvYdSYaaHyDs+stRaozBXzBarBCH8P2ImQdLccCymMXTOPh1tS?=
 =?us-ascii?Q?3I0318ux4TCjcB3H87S4KT0TvA3IBqLis72QDTl1thkwccw58YjaCeooIKpY?=
 =?us-ascii?Q?OHNI+iKnsNqn5AvLyICX15815Bn1kv+PuHPPY55+W/0SLaq9pX1N05xz6kuM?=
 =?us-ascii?Q?VsYdAMAgg6viYReSm/P1uXOAXU73xyKgIGcdbthb7U3+SQ6+rHttrKEZEoYn?=
 =?us-ascii?Q?OrzRY9sgovnfW2wppuANvU9CQVUqzRRAi0fTXDLOrubDbO6rHoabLzDPdIzN?=
 =?us-ascii?Q?RL8+X6YeaNVbet3pMxh3LqoojSKoUNnejkdfQUS6sHTtbnjdZuNx9sIdyQnM?=
 =?us-ascii?Q?bMWEVssjvxuHLHg+9C2aMVnsH/j2/TWSVECIrLJmg2plO2Gz462TDtKduB2T?=
 =?us-ascii?Q?Q5QjfifbSjdNwfr7zn8uPGSJys00pEupe2vbhLQp3nI9+FsC7vDsZx2Fe8cN?=
 =?us-ascii?Q?DKAk8BRnuNFVL029HYExhaUUfGb6tLwdD87gW04/pt+jD5bJ3NMLw7uiAPQ5?=
 =?us-ascii?Q?F7YLTaLRkRDKRq2g/5BwlJu75+RTz83qA8fUAYVi16JF/bXhIdk2U7T8AnW4?=
 =?us-ascii?Q?Gy80ybQ3DBT2mUIlR5E293oXWs/5Gz19LSzDwzLX0711ULjfs/cQJQeyBeSr?=
 =?us-ascii?Q?KE2ugsJFpnTKGlIumD0/jJ0NQ7KjsNr7vpiCXWxIDCp95vnrk2mUVomrKWay?=
 =?us-ascii?Q?JW9Hc9XcGHtGlnQzTobs8T8mLxUfWTLladi+5p2Zt0O5lWPHrAAxGo79u60f?=
 =?us-ascii?Q?556jtjQsKh3E459KnZEFuo+mtp0yLyNA/Ce1h+F5Dmgv3xJCMyZv2LqIuY5K?=
 =?us-ascii?Q?poHhISsFoB0FnA4UMndq94AguB0p4mXITmJLXRzrcVMHXV99NzLLhSkI0mIK?=
 =?us-ascii?Q?lFbuJhhUsk28VRL7dS9u3uMPq6WH3ZGlNQNN68Iddfkuorw1bOJRjjEwQeAV?=
 =?us-ascii?Q?EUMrjeGI4hNAr8cfx34X7ddcMzu6fLUA5rTWipzlscGGv89VzwfNiWg4iQib?=
 =?us-ascii?Q?3mlNwm0sQfF1NOGIe+CLXKBL48G3dJir/HEh93Qq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27aae3c-865d-4609-1895-08ddf535a3dc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 15:28:08.9253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlQat+uBOhX/FpJYW1wLCYfzD/ppYF5nJXQRz4gnUHI/ZWYxUfT171A7C/ShW+153TQfM/i8lpxOpR7LKn8V5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11055

On Tue, Sep 16, 2025 at 03:56:40PM +0800, Haibo Chen wrote:
> Extract function nxp_fspi_dll_override(), this is the suggested setting
> when clock rate < 100MHz. Just the preparation of supportting DTR mode.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/spi/spi-nxp-fspi.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index 848fa9319e36d65e8152931324b8e34eb162f5d3..a1c9ad03379682dc1fc2908fbd83e1ae8e91588f 100644
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
> @@ -756,6 +767,8 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
>  	 */
>  	if (rate > 100000000)
>  		nxp_fspi_dll_calibration(f);
> +	else
> +		nxp_fspi_dll_override(f);

This one doesn't belong trivial code restruture. Suggest use new patch for
it.

Frank
>
>  	f->selected = spi_get_chipselect(spi, 0);
>  }
> @@ -1071,13 +1084,7 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
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

