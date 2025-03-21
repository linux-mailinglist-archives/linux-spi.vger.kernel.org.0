Return-Path: <linux-spi+bounces-7276-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E9BA6BE4A
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 16:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9A91898F33
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 15:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9371DDA09;
	Fri, 21 Mar 2025 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rblyk9qJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E0A165F1F;
	Fri, 21 Mar 2025 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742570598; cv=fail; b=FuKgQ2wNbJhQSZrJZ7ZQYe/sUQnEgojLvnF2VzT/I+dtbkcqBie4pD383FRcwSD81wHfx5NZxp3FnmgnNRPeOmD8hO8977UnK4zRH6iqI44kewTgdvLnFC0hsfwvHAsG3VY69QOZ4Ny9D7MhkgcWUJQJ+Je3y5s9bjGmph3hFRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742570598; c=relaxed/simple;
	bh=Ouj36VDSlBPmH4SDnyDMWTeqVyZLesF9+0T16kaJEdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SYewbWDiyKl51tQlgZlK9Hjgjd84pzCkYnkdPRNClmAwf/k4qaJRZSsA64s4ro2RsUsIGledN1GuSwMrykrn0V3C0RYEk28GDi8chHHBWyydCxkHcvF5MxoxiawJqAEgCp8EtPl9U8aEH5QcaBVj/35Xjif75hAVK+6XWqPXwOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rblyk9qJ; arc=fail smtp.client-ip=40.107.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loi4tZq8BIgTMur0mLfHnrJjjeiXq0ImAg8d/JWq77Wq6EIbBT4X22HIpp3mlUUSDK2mSIHg4g5mufTdhPl8d4ZT4Dus+fmxum3mIvDV9gJxQrg77LYS+mwjJiu/dkgaB704SHSo1a45AiWhqI98hctXyVgy4VFmNppP1jsQSCGbJhEqX5SRz/isGHF65QW5oRAX+jwpjJ3FbtWf1LvGY8JVvwEkL8eSwQVXRRNaJCrYn6sGFP2m/XcnQ0yZ03Nt/9orXTippnbeYBiN3vdVaNbRn5wFQnKnx2/T3mvErYfJ2vOeG46i0YseRgCdVswYxx+tyAhtPRojPr5Zc/mHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WRqMgWO2qpCnklvIxMTpZBuAp559ec9QQD4eQbZ3QE=;
 b=it1yiGHQHqPbgm9xkj7HtMjtIpm3RiMfcmWHq47++1AY+OYB55/5Za+cNBwcPIH6+jkVlNCSxFWSXlvGmThxLwy0h3/g+sAyT+aZWaGMDPETeuvOYqNeMxKW9tGod2W8cv0wwTdx8tguajQ6kEyVqQNPx02mjRQpkMtWGBVNDs0FHMrFdd9+5eAqjyGfAl6DXJA0u7M1R0Nb4i3W5eCmAGF/IpeyQEpsWH75M5q49dIWRj6UTj9jaa/+FXfzGWlb4Mz7+fn8fcSiMmrK5XlYv3I8UVn/jcDW22MWnOjQsfWWKoaGNj62ZCZD0jg/cL9HEBbKmT8UbB2mF3PzgrZG2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WRqMgWO2qpCnklvIxMTpZBuAp559ec9QQD4eQbZ3QE=;
 b=Rblyk9qJtwTAWvik3OHZwiGNz6ax5t2cvWzBi9jBngeWnDLRC1qpsQBAqfJzJjsUUiwmILDwQqLMhn0gcUmr5WScL6P+GqD1G6PLFDKuin0ujugsMdxmDLc/31HjjHlDoi29j1f5rgILYLdFQUk+LDdTR6Z0v+Fw8XFVVOVff4t+9rmuCtSJ0ZRzPVXzNLoLbIuEDflIt3NWiV/Bt1FzpWBgYdsZ9qb4/4jsXcVrJUbbgthHA9PLjuK8ljzosPEfCXN/LWYSVGWCXw0jhV/+BhKa4uM7KLO10kbCB0+4ETj+9r9Ej8qCqtCB/OQ8ptcQ+ivuUHcWIgjpxXOQ/7fVEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by DB8PR04MB7068.eurprd04.prod.outlook.com (2603:10a6:10:fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 15:23:13 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58%4]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 15:23:13 +0000
Date: Fri, 21 Mar 2025 10:23:07 -0500
From: Han Xu <han.xu@nxp.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Volker Haspel <volker.haspel@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>, imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: fsl-qspi: Explicitly unregister SPI host in
 remove()
Message-ID: <20250321152307.wzjmouuoypkukoqk@cozumel>
References: <20250321-spi-v1-0-b9939baa64b6@gmail.com>
 <20250321-spi-v1-2-b9939baa64b6@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-spi-v1-2-b9939baa64b6@gmail.com>
X-ClientProxiedBy: BY5PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:a03:180::45) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|DB8PR04MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: 81bf78b6-e277-4097-2f96-08dd688c4be0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DRBJiaQ7Fc23hiOhghkgweplARSkTEsLRFkS+z58Xz4YQSezWhPMUDdO7dgO?=
 =?us-ascii?Q?bg+wbJe/JRa6+c4/uh1DA7Z4qHCYKx08adIxT6MeBXmMyRDGGAmTJ2/l5HY5?=
 =?us-ascii?Q?ZL8c90K5ht/mwbueoQkgMS5W4tW2QfulFox2GlX+203YNfX8+oobtT+n/cA5?=
 =?us-ascii?Q?wbPZF1SZ1eng6FhVUTR4SKhU+s0auLUKieVl0BAtQkWRrHbIT0gJQT+sSUzc?=
 =?us-ascii?Q?3e3ONaWdEfJxnTCePb+RIWGKFNikbxeCCZh3oEoeot4EE/HGWwj485SFxLFT?=
 =?us-ascii?Q?airPpZFpaADw6DQEBDevkPrd/Aa5NWI4GDe4wnFLMpueH9bPDTXFvIcGSQrs?=
 =?us-ascii?Q?PvnsugM3dY1DRjlWVV7SC0IiUK2wkD4f+rqQ22zW6Ls1t2EzZ3sdSenaU3vE?=
 =?us-ascii?Q?gkZx1pc8dCEeAClua/TkDD2zOZ1J9QvsjV+babmaw5Uko1cpo4Dlhzt2nhtC?=
 =?us-ascii?Q?+SE4/f3DDr55VC1+aWiS5BRFbBGp+xsb1f9J9cFTAfSd6uoUvn8RwSX0cRt7?=
 =?us-ascii?Q?ZvReVERqiAhUSIwCcp6PAuwJAioMaIyFSKKIYS5a5rkqdHTYHOATemJ68Ckl?=
 =?us-ascii?Q?Py9jewRawoB6VAZroMSLzDFWusBkO2sYi6OcQnToEpHjkwPExyxfa9SDly58?=
 =?us-ascii?Q?4IV9UQ6FnkJD5ROcG7FY3ES/CtfW4ZMYyHHIvz5z8MMUC5sgitkmJ5HX43gv?=
 =?us-ascii?Q?tT9qwyzDIM2TU9S37UMx36umgIioxTskjQEw3pvMfjm/9Barz1ddguT3lFiu?=
 =?us-ascii?Q?vkPZGkDpAi5foBV4QF2tPrSWwC4dCADcLcHyhK3ZaWBsI/LIKrfplev5gJHl?=
 =?us-ascii?Q?2DPeQXTpHdKjQ7ncBulyjcuBnXiutAEE+uJZfWi4Dgdom6ELJyPKFMEjYvfy?=
 =?us-ascii?Q?QuHPTiXXuawry1YYL6zUCoJR2VPElHalZH2i1TvsDCUxius6hGjeRVz2XFqk?=
 =?us-ascii?Q?qwQn0j3Z85mupDsD7oHq3QZnvNT552d821dx5dhwaQb9ZhCvrE1SqG5CiYE8?=
 =?us-ascii?Q?+A5Nd2+hp+OsMhB7Vr6dl+cYBbnDpKbdRq1Vf2hv1Ty6nymXi9wvPa0eDbsn?=
 =?us-ascii?Q?SDwhi/NVuKjtqoTSPHJXgxXpKT2eouq/LbXlkG8SAlrRJ2o8J9ALerbKjxoK?=
 =?us-ascii?Q?KzeZnZv6aJ2X+hUJd/0w98JNkmkW7TA5bQLX8td8sGinLLOjNU5XP+hs5GHI?=
 =?us-ascii?Q?jqhs9M2RqwfXzvIlxLMfxZ8cb8453g5d95ZW0YtR5rawoySl2Gu/ZxI5NOcP?=
 =?us-ascii?Q?d0/VB1OFGmiMx5rD+40+mszshju5g8R4V2i/GGLyp/Tda6nbFWYB5LgrY/oL?=
 =?us-ascii?Q?RpSrEKxwExTM3jrfg+nieZZELgIb65hv5rgg9Zc8bSCMAblrT08jooH0d71o?=
 =?us-ascii?Q?5QiGL9RrDA2rv2/Q1UKfbWxZlA7L3HvqsCyvYEPaqGwomvzW7U8Au+AxXu0L?=
 =?us-ascii?Q?MzwVpL7mJL18Gh1zT/jywSAiRw5PKF81?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bgmwFwq0CJJ5uJPuvsOW6+fnMDFB0fOSh8JwxUVlz5bYcvo9eGwcUDAx3jRB?=
 =?us-ascii?Q?usFtn7ZsRNZ+DrtegdwqNwHELG2DRMpnWzlU3Znn+KaVivx4+Ujy6dQDrScO?=
 =?us-ascii?Q?ehhukiJrAQGP8vRHH5+3DmD2usKZ/ITwsT9jZlPfnx+9QlhA3kjEd3SEv5/l?=
 =?us-ascii?Q?iq6Na6+p270Orgp/sGzY77rFS2HuyyU5Ft8hADOsoz5os2GjrOPzUff3J0pm?=
 =?us-ascii?Q?/2syz9xiESeGgtB0PIxUbdV4lnpDbG8EjeMXBN7H02DMMbbw3pz0YOlL/YDC?=
 =?us-ascii?Q?6oE9dY7UIOsMvo9KZiQdHkI+fCml+XpcxT11k02kQrjCYQ/h+nlhb0IO4k03?=
 =?us-ascii?Q?JDScLfJyRrsDXw2l+RqEKct762Y5wIr7AWYg+WbkJnnrQY+LANbH3Bw9SIdc?=
 =?us-ascii?Q?VdlQ/EycGw4TJBv1Br2hF6rTIjsGj6U6ZkWbNN8ED40sPqvPQvp4LbHIXses?=
 =?us-ascii?Q?XrbMkidWH8odAI5VJvCR9eVyhVG2/fcJO1LSyMc+mvjqfanKgTQyvRCv6/J/?=
 =?us-ascii?Q?PJ6vfK/htUQDR6L+ybTGMHYmXb0qBDsuiANFwv0yOr0X3hLq9iPCbqg+RYED?=
 =?us-ascii?Q?HjibBhtioJIyDd4QxvNhlWXXfExkQtzu2igmtZNeKEHoki0iQlqD+9AGrl8K?=
 =?us-ascii?Q?wFAcBdjS8y8ErD0/tOs+CFAvuIDq9phB9h+kAyiZKat2UuJrdUU7XURiiKTj?=
 =?us-ascii?Q?QW2QJV6/bblLCDqUdqHU+FdE2YBn6s8aykcHoC5diWqwjsBt+asYl5psliJC?=
 =?us-ascii?Q?/+v5b1EiHSe+dpwsmH0vAfUerXFYmK8A8iK2blzGHdK35No5q50zloC2ULf8?=
 =?us-ascii?Q?BcFSqJBxtCekRLUDefsqhD6f2AccornaANxO96Fuw7UD4kV2jRkb+fZ5rlFF?=
 =?us-ascii?Q?qi5TcBIpftdNRKpZrMB2O3tW5E3KVMYhWFWKoScq3h04jqjguTT/1jPZ4Opf?=
 =?us-ascii?Q?qcEOgOSznIKvD++dbBMrcXR9f/ACXixJHaA+uMwKzKIPM8diHlX7VNT5OyNM?=
 =?us-ascii?Q?KmgTWrd7Onl2f23uqjHUfCLV5JjPG+E5taszuia7e6sKYfdQ0mZkhWZxInds?=
 =?us-ascii?Q?dcaRr9mz36hSPkO7dmqmiTYqAkNhihULutEq+tJd0mYjuOiL54AL1CKmRGLO?=
 =?us-ascii?Q?6Bpo8gKfhNUq531E/pLtuAOhg90pH7mb0h9PZH6amM9vPL1DSNus6TsgZRkT?=
 =?us-ascii?Q?Ik4ljSaxeRaQMEk40jl3BpUSUxjR8cCE3pZdX3WnzVKjWgo/JrCSNDn0f3qS?=
 =?us-ascii?Q?0S4s3z52xNG5zQikVb49+JXdKtCUKOyi7eIxKWo16YnO9mXSybZRFinRhj/+?=
 =?us-ascii?Q?GQoKSGpr0IarIq84XN8jQkom7pjyPTgR4DFFXYkm6B9sDOUjlqrIps7pXHuj?=
 =?us-ascii?Q?KOFIMcozrseLfgqnG7veSHQ6aS5pRXwE6SBgRw37V64QyF3EO31ch1zQP61d?=
 =?us-ascii?Q?UTD3B9hCqKlIpGWfdByzysyvKlukZN2MmVuIoo+jjdLGoPR8/Yj0mRK6rVdH?=
 =?us-ascii?Q?/o31QTELnmRbL+8t4S8OWVyUCqc6CXrr3Lo4hqMQbBwR6lUEh0Dz2p63KaKw?=
 =?us-ascii?Q?XSLnmxzvmKnzAY7xQIM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81bf78b6-e277-4097-2f96-08dd688c4be0
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 15:23:13.6030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVpkYa/kBWRjRb8zaMyOMWaFg7mmZJObOGEd8n97ZzP9PQ8HlLytaBV/r9etykSi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7068

On 25/03/21 08:40PM, Kevin Hao wrote:
> 
> Currently, the SPI host is registered using a managed API, which
> automatically unregisters it when the device is detached from its driver.
> However, this unregistration occurs after the driver's remove() callback.
> 
> Since the host is already disabled inside the remove(), any pending IO
> from child devices can easily corrupt the kernel.
> 
> For example, the following steps on an imx8mq-evk board can trigger a
> kernel panic:
>   while true; do cat /dev/mtd0 >/dev/null; done &
>   echo 30bb0000.spi >/sys/bus/platform/drivers/fsl-quadspi/unbind
> 
> To fix this, explicitly call spi_unregister_controller() in the
> remove() callback. This ensures that all child devices are properly
> removed before the host is disabled.

If you explicitly remove the child devices, such as 
cd /sys/bus/spi/drivers/spi-nor
echo spi0.0 > unbind
then unbind the fsl-quadspi driver, the kernel panic does not occur.

Not sure if it should be the responsibility of the fsl-quadspi driver to handle
this, IMO it is a common issue with all SPI drivers.

> 
> Cc: stable@vger.kernel.org
> Fixes: 8fcb830a00f0 ("spi: spi-fsl-qspi: use devm_spi_register_controller")
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  drivers/spi/spi-fsl-qspi.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
> index efd87f44c63a5b12b76538aa459ca8eb203b9dcd..4767d2085510c2f231476ba75e46f83271c4c645 100644
> --- a/drivers/spi/spi-fsl-qspi.c
> +++ b/drivers/spi/spi-fsl-qspi.c
> @@ -272,6 +272,7 @@ struct fsl_qspi {
>         struct device *dev;
>         int selected;
>         u32 memmap_phy;
> +       struct spi_controller *host;
>  };
> 
>  static inline int needs_swap_endian(struct fsl_qspi *q)
> @@ -862,6 +863,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
> 
>         q = spi_controller_get_devdata(ctlr);
>         q->dev = dev;
> +       q->host = ctlr;
>         q->devtype_data = of_device_get_match_data(dev);
>         if (!q->devtype_data) {
>                 ret = -ENODEV;
> @@ -934,7 +936,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
> 
>         ctlr->dev.of_node = np;
> 
> -       ret = devm_spi_register_controller(dev, ctlr);
> +       ret = spi_register_controller(ctlr);
>         if (ret)
>                 goto err_destroy_mutex;
> 
> @@ -957,6 +959,8 @@ static void fsl_qspi_remove(struct platform_device *pdev)
>  {
>         struct fsl_qspi *q = platform_get_drvdata(pdev);
> 
> +       spi_unregister_controller(q->host);
> +
>         /* disable the hardware */
>         qspi_writel(q, QUADSPI_MCR_MDIS_MASK, q->iobase + QUADSPI_MCR);
>         qspi_writel(q, 0x0, q->iobase + QUADSPI_RSER);
> 
> --
> 2.48.1
> 

