Return-Path: <linux-spi+bounces-10802-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C35DC03DF2
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 01:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2DDF4E14EB
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 23:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A102E1EF8;
	Thu, 23 Oct 2025 23:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BGuYBS1k"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012027.outbound.protection.outlook.com [52.101.66.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC16291C33;
	Thu, 23 Oct 2025 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761262904; cv=fail; b=eC9SSmLep5vohkWFLlaNnEZIm0oCwk5DATDKyy+ZKWBovQREIqJt6fxpY0u29Ucf1G6Kyx5Z6vXHc++3tLGQ855+3xkTenSx1ad7Xrc+tIVuGOIW0S9TP7kF4BKJgLyfGDAChohquXe5F+zbBsmzcHj3jUSIWVJ+pfUiMs9cNXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761262904; c=relaxed/simple;
	bh=e5Cur3FzhqrASjMHtudA+DL2QB1SZ6MSdz7ZxNZKLPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cmzgHVYTpdOd6ueMYFzC1TeHZUNE/lwsNgMszcMWjXNixj2ovv8ZYJaIiDG8CqPzRx8lC6fjYc6JVvrFzYhS5c7ehzokHGutxHU9JNHylOPUeXLHqrbtmpKI4D4uj09ken/sOdiWeJ6dE4aGg8aq8T5U4X/PvEtw701XXOxWXxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BGuYBS1k; arc=fail smtp.client-ip=52.101.66.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFIXqyLJXpMRTMB4PCgJbsmw+VLU42niLIXnFxChLEvqA7NygxQ0JEL3GJQqfdE5j8hyswnx3Q483TOzdXjhLRlsm9pGrnUoQve9HRBLa+fu9bYY0iFD426ycJJQa3IPtWQVWL40Z8grWXM5CKsAEokhMjQ7ngLAW3WsLpA+rmJ5TeOtbVsS0R27mFQSE73SC2I13gPALoVtJTSpcKM4O1JMtQ37b4gj1AqXe7m8Ysg8DqR+YmSExoR3GArKHbG3zbaLBdSzCSs0DglSUAN6A7VSG6zATh53jV+mcrL9QW3QfGf0xkTk6coyV8tCibl6gzw5J/4gCbmh55Bzq2FK7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r88l0LzDCkfqGRdcillgNECBJDWG2NfKI3odOm9HRHI=;
 b=Mfn6+MBlzlvPu5pLNrjqZtFz+lHcAZqxeOkhmiLA8+kXrC7yFUX1Chc/XVGYnF8h1rJUhsiDIB5y/tJvRrELaYZV1n/VY8Y5ZYZk5iXKvvUJ45NOnYtFmQthGMlv8Tqd+tIt4yPgUx18wyUloycb7AZ1fIyxNT+D3IaqPIOq03oMpSXos8aoDNIiQxXdAmOGuLz+cZ/A5c9IlQowQWR9T2TFgbbLXOU7DHP0I3kLYQDFQkg6vzvYLVIscpJOhZWHMGiZHIIMKKK/2mjilAm8w19UwIUXAtq2YQit6okP86v2ZNmsCXnIopRtipfVWvGgKga+MsE7cg9/M4LkFo8BLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r88l0LzDCkfqGRdcillgNECBJDWG2NfKI3odOm9HRHI=;
 b=BGuYBS1kwUVr1UsAV0Rf8rN0O+eKyZDttyxiw1iJt1HcP8ksDgwxJSC+h9cyLeFvyD2dR90hr/JD1n30V9xcj9jLagah465JuyraRNxUHwXk83YwsoJfO06oMKZDx3nv9GQlVT6exTby5NuhlSH89AomIf+hshCXYpAMPtcC70U9r8DMEQT2rZ2spq4sz6JSBeCwgwzqfqd1dFWYhQYOryoDGm06k3oc+lzptS8ZaYKHZCaeoQwoVNEg+hBSfF9sJEBTYAT6T4mq9Sfz9uygq2ncanu7mxkaJD6ydOrczbNzycQtcw+zz8l1A8ZTDN6h58To1DYhqrrU5l0DnN5iMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM9PR04MB8413.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 23:41:40 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 23:41:39 +0000
Date: Thu, 23 Oct 2025 19:41:32 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alex Elder <elder@riscstar.com>
Cc: broonie@kernel.org, han.xu@nxp.com, dlan@gentoo.org,
	guodong@riscstar.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/9] spi: fsl-qspi: support the SpacemiT K1 SoC
Message-ID: <aPq9LHwtALpsOIwz@lizhi-Precision-Tower-5810>
References: <20251023175922.528868-1-elder@riscstar.com>
 <20251023175922.528868-8-elder@riscstar.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023175922.528868-8-elder@riscstar.com>
X-ClientProxiedBy: PH8P221CA0064.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::16) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM9PR04MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: 40eae981-d256-4a9f-4c9d-08de128db6ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|52116014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fcXCMViXQ38Y0P+i0o494P9qK5IXvtLObJ5UUudhbWihZISay4AecjH4t1fn?=
 =?us-ascii?Q?R9u+UMAZSDhkIVh1P/iBuKNvVncLdhpD6kTzj7abPQhQfjT0MrL7rGGbdaZm?=
 =?us-ascii?Q?nJADhPYIwOR1VEaHCiTU0Cc/ojaAUxuznLOpiCByisJdGs3qgSOl0JmRu/lw?=
 =?us-ascii?Q?pg1O6gTLMNR/0GNvNAijdrf1oqWpmNToJHaV/Stek8CmZbn/+y9hsp36ZJYL?=
 =?us-ascii?Q?asJrGf73JUxvyKIjcPm5gLPyrbiUbBYo79a7cp8NVvN2gwYjvY+wqS5yWhSk?=
 =?us-ascii?Q?NIkyokvkFFbt+ZMShmUcB2+5u2qOIjiiLGJUlvEUIcCo8nFDKJ8QKDbw7syp?=
 =?us-ascii?Q?yJyRE+Dx2cB0lHYh5drv44PXw8kfDD/XEUrbN+X75+fMrCy71h1Kb5WYWuAE?=
 =?us-ascii?Q?L7d1hlm/HN2y//hwx5Z/u5BuufZSfs7l/1mf7SR63AmS7gIOrpOOUhzQ1GRT?=
 =?us-ascii?Q?NC+8IRZ1XqiGVLNepVj2Rg0N4AmY7IPbA+gWTKmgPxZKzyOJXj9vfFLsDLoS?=
 =?us-ascii?Q?G42xMEWUJXrmVdNX7/K/BWcPAoFFT1wswub9lqCOItd8nMry+IoyrnG4oDJE?=
 =?us-ascii?Q?xQWJ+txc+OGwQhW+geT2O2mOQ1BmIeT1kdphnV2+QoWaCyGp04A3km9f/mvG?=
 =?us-ascii?Q?hZWqeY44j3+Rxgc1uzvsDEu8vPW2OMMq70K2keqRx3cgijmH/CYFwpE1S18t?=
 =?us-ascii?Q?0O/+YP/A0EQUunf6veKwoOMO1nMBYYdNYl8gPGtEuOYQGaRpLnGVPHvMw6Ot?=
 =?us-ascii?Q?otGbWZvM9M5MMBLFa32C+BsSuBorMX8D/yuqDIChHYHsYCCc4nBeblZb7g3D?=
 =?us-ascii?Q?7XM4wPZqDoUQ1fSflTK7wckm6FKKpZk+cYdmTNP9BHfiRNQI4Tq+vaN1qYxD?=
 =?us-ascii?Q?mGUbSsdLLeVJZKLFCbOWOPuC9/8dbm27cYV6F7PvE2w750IjSkp0xZoulCHT?=
 =?us-ascii?Q?N7/FkMGKbi1g/JkrzlRq6S1gPZFkO5dO2gLSnv7c+t5bkS6Haag8ZbU8/L7t?=
 =?us-ascii?Q?75TDRZjFI3xWQ2RQDgJf4pFNXa3uD/vBw+UMmzjKfa+RiaEB3qsoRSSy4nHI?=
 =?us-ascii?Q?uQPxoiklh480nq+pyCOFfS9dAH2Kvw0X7SLo0ibX7I6e8Ihl4Vr39ZOx6AB1?=
 =?us-ascii?Q?+5v+xUtzT9PsYsstDKGBBfLIlYQ6q38HD986FLpPMeg+FDhTB0UyLFkzWvaT?=
 =?us-ascii?Q?NZIGSKtlXwmbEJIDzjmHPEYrTAaVanTdWxbFd9ay9rEiLUkRDoImJX+b0ntW?=
 =?us-ascii?Q?mtlYVRkVKn4w3xj5gr4WE1JOcoXRV69lq/wRvwekJmOZ2TgJSAudXVMl1xTk?=
 =?us-ascii?Q?4W34VHHDLIPFKUEZKDZ+4rdO2x2irG4iUgh+ejo0Mxud/U5DE6E+svj9AhzY?=
 =?us-ascii?Q?d2TF6y4WEWdQaOJ5LO5To8DhPHd6l1mCojRKyv2uCwJoiGFsAQ8vpAtKlJyA?=
 =?us-ascii?Q?hrtEZEZRjnrQC0g39UxwSDpTWUzNjcpH9/fJU4VVgV8kYGXML6yysUoQOJuW?=
 =?us-ascii?Q?DXHXlpEaE3pBSEE9nGKHeGg5jjkBW94N4K7h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lvu5Ns+rKCUUwwG3kKLar37ddatYLtMAIHxsbOvT4ZgXnklBujWcmLIXN8xo?=
 =?us-ascii?Q?SEcfgFIRE5eYF1UXbeERZ3nWKmIDEWiBwORwXKBHIOFrtfKznOzQQceHGkYf?=
 =?us-ascii?Q?v1Zt2ussFk6n8dOI2QpSqYKMva1+9VcWU9sHc7N0P6sUH15HgYDXFO4DhZ2S?=
 =?us-ascii?Q?d5oEsjnyB18JH9/cv2yv74WrJ9SEit8tTfwluQuSy8Was9aedUZtv+bJVxlq?=
 =?us-ascii?Q?TSyQySEnNqW833zG/qaaoRjmFDfNqKUarezfAifnFhGYd3jkfMHb6LlHMhV7?=
 =?us-ascii?Q?USK1M1MaLu0ln8sJs3EoTp+D3EzMwiDC82LEOUzcy0YgJsh9tImIsd66kjGn?=
 =?us-ascii?Q?oIwSlsduaVJ+aLaTGy6rsb9SOcHrCGRmfZPV4ijf9K7DYt81sdWy1P98T2rp?=
 =?us-ascii?Q?UC59Wvw7X6Vny1x2RJORHsQke7CItyR5ZiqErzOoqmQWvrLCKIjwyxqFoCt0?=
 =?us-ascii?Q?k4rUGMgoRhfcA4+APtG/g6txDMLHEDWayuW+iw1w+C56l2V8WVmIB3FuqVg+?=
 =?us-ascii?Q?J6Wd8MKGpzz8Kwh6WSw+UlrO2DGy70KnA8t5CWbDo12z1x2Uwq32tNccegcr?=
 =?us-ascii?Q?6go8srNlBsom1ppxQaeN45CaSZulkjkldiwaEWE29fx/Fn4CE2uTXzmPZ3i/?=
 =?us-ascii?Q?Ir1K0Mwl9vC7OL9qM+8OLNwjh2kd2CqlI5WiT3PZ8Ql9jYk9sciJS7JH38gb?=
 =?us-ascii?Q?fVcjaHBvOlned4E8L05D/NY9hpELG0SPbmyIqMhOQSaZ1txTjB6CTG3RoqQC?=
 =?us-ascii?Q?09eVugt8EfZfMCTwLpiWlz6tx2AHkSiFySPpFDw0MbBZW8jxQuRMydmi4tn8?=
 =?us-ascii?Q?o+zrSCdbYNv4ujoxtnbvh/eSXZWofp5suVQtyOTtTNYKb/oBARwsuvmeg+6t?=
 =?us-ascii?Q?1le4N8ic/C2U1/mr4W0qfyxjN2Jcw3bvucMJuJcz8yn8+bVjVGo6ZohD/VIr?=
 =?us-ascii?Q?Bg4SK0ce3Md5WNM7kOKixAbQozwAFDXSEkH+BGpRsi0YH5ysFt8qiOG5kTNJ?=
 =?us-ascii?Q?DnRq48YStyyUkaV6+J3+uNyjV1DeC1VPdUddifEQwZAYCUEkYZXSf2QS6VlN?=
 =?us-ascii?Q?sf//1suFXWlrmY3k++0hsbwcJDap/NMdI8PBalzfwg6AOdzBOiax9I71TiFV?=
 =?us-ascii?Q?cq3kB6TWvnrZLlt1yZkp9lCzWXbNBPe9ba59PlDM8SrEqML0xkVGYGgzNzgF?=
 =?us-ascii?Q?ICsM8w7MQfLDHYPA2ebm5vAW3oVOvxkAZ7GevQ8mlgm9SWd9KxKxi5awGLSp?=
 =?us-ascii?Q?Zfqv+sSTDE45ETpLxmEyqOfC2jp4VciakGMufPp/95AoOMDXJkM0hYTmdgeQ?=
 =?us-ascii?Q?STs6dTbvnvFxoCQfb7keZgQnhdsd4GBGITNfZHkGpAv/HefMD+uubdcGLiam?=
 =?us-ascii?Q?9QAgSoTye0ouoq0V/Dar8S7pT0MFtT+RNYQlGfq+Y29nS8lnoMIs4brT1whl?=
 =?us-ascii?Q?KaWAJCa/uhbFUtiw/4ysSEk2ZtOPfcgqEYHQbhE5S2VTB2Bl8y14S9+k+3o+?=
 =?us-ascii?Q?xTxi7uFGb6y0nhz31KSWgREMgDH2kBxTeqFcvcB/gUoVtubusQTDe7o0ERoK?=
 =?us-ascii?Q?EX+UvTXIvMvfGE5lFOFb5rUWTC8oxSIFZsxICuq3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40eae981-d256-4a9f-4c9d-08de128db6ab
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 23:41:39.9214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKxVsJeG14eQfTNefBCGX9ibR4ySa+zU4i6mcVBROI9Uzg00jfvsN5XvwjXJi0/JdOphsaI8rn1NkiGaZnUziw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8413

On Thu, Oct 23, 2025 at 12:59:19PM -0500, Alex Elder wrote:
> Allow the SPI_FSL_QUADSPI Kconfig option to be selected if ARCH_SPACEMIT
> enabled.
>
> Add support for the SpacemiT K1 SoC in the Freescale QSPI driver by
> defining the device type data for its QSPI implementation.
>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v2: - A continued line the Kconfig file is now aligned
>
>  drivers/spi/Kconfig        |  3 ++-
>  drivers/spi/spi-fsl-qspi.c | 10 ++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 4d8f00c850c14..592d46c9998bb 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -435,7 +435,8 @@ config SPI_FSL_LPSPI
>
>  config SPI_FSL_QUADSPI
>  	tristate "Freescale QSPI controller"
> -	depends on ARCH_MXC || SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
> +	depends on ARCH_MXC || SOC_LS1021A || ARCH_LAYERSCAPE || \
> +		   ARCH_SPACEMIT || COMPILE_TEST
>  	depends on HAS_IOMEM
>  	help
>  	  This enables support for the Quad SPI controller in master mode.
> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
> index a474d1b341b6a..d4b007e8172b2 100644
> --- a/drivers/spi/spi-fsl-qspi.c
> +++ b/drivers/spi/spi-fsl-qspi.c
> @@ -268,6 +268,15 @@ static const struct fsl_qspi_devtype_data ls2080a_data = {
>  	.little_endian = true,
>  };
>
> +static const struct fsl_qspi_devtype_data spacemit_k1_data = {
> +	.rxfifo = SZ_128,
> +	.txfifo = SZ_256,
> +	.ahb_buf_size = SZ_512,
> +	.invalid_mstrid = QUADSPI_BUFXCR_INVALID_MSTRID,
> +	.quirks = QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_SKIP_CLK_DISABLE,
> +	.little_endian = true,

did you test your code? miss set sfa_size here.

Frank

> +};
> +
>  struct fsl_qspi {
>  	void __iomem *iobase;
>  	void __iomem *ahb_addr;
> @@ -1003,6 +1012,7 @@ static const struct of_device_id fsl_qspi_dt_ids[] = {
>  	{ .compatible = "fsl,imx6ul-qspi", .data = &imx6ul_data, },
>  	{ .compatible = "fsl,ls1021a-qspi", .data = &ls1021a_data, },
>  	{ .compatible = "fsl,ls2080a-qspi", .data = &ls2080a_data, },
> +	{ .compatible = "spacemit,k1-qspi", .data = &spacemit_k1_data, },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, fsl_qspi_dt_ids);
> --
> 2.43.0
>

