Return-Path: <linux-spi+bounces-11279-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 910E9C6AB07
	for <lists+linux-spi@lfdr.de>; Tue, 18 Nov 2025 17:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60ED33A5479
	for <lists+linux-spi@lfdr.de>; Tue, 18 Nov 2025 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E4A3A8D43;
	Tue, 18 Nov 2025 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jNnv4Lmu"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013058.outbound.protection.outlook.com [40.107.162.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A743A79A9;
	Tue, 18 Nov 2025 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763483573; cv=fail; b=u1IV4YqbUEoQUAPxlhw99FK8ybeKVsv/4FcPorGNV/Wg5Ck02NOoI2L45sTLgPhkxzydCkKKXKAlctg5mFz2uchsd4kpaiit92d8LV//IsxocT5oDuDgiyFbhyw3c/6xba4l5eOu04dSBhE+ZikurN4o4obU9HU5/HVPuE30ZDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763483573; c=relaxed/simple;
	bh=licvMRuZA5H+DoMNqjrUL47o2ZZR0qATzSRUI7XKg7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c5WCdfhiNfO+lUctZfUNV9qOmYbzOLXg9Ds5V4T7z6v0GAbdTHTOqFrdIlsCsRemG+GITnMSIz/wZ+VT4r9uyYw15Kl5hcFCfJY8pGAYdFWZRnUuAIw1Xcuz8GHH2QX5qZqfMiW15/Z4gxc1xKc4EfUPaDED9vravonOySYgPYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jNnv4Lmu; arc=fail smtp.client-ip=40.107.162.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHemuQzZLB/xgnLLkC4v85FjDFiyqnmS76tJUEksImqJnTGTLJJ9etBV8KawzCEw4zvAQl5Ark2ZKeanbYHFdOBfrWZpkr3ZICE2KMOSSgkN5WJpyyIh7XRqU10gkNHB5SP4zy37dU9Gmh+IZ/L3XlFZ09vYbEVgZ3xIM7F5rgp04m/G+iQGgGLwY5BNoW2MQWRRL/vsxWuTMET2YenD2zG61VUtbNNz0jnsoxuq+mU3tGqxgTyEGn9qW4xt3YtKpiTIU+WH9ay2FauEWq7MIeoN5sbDYaF5dQj0zY3BXLCuEyI8v1DMliOkzsONhfzE8K4ljvkD38PNuZSa7ix4hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+vyuwom7ZkgQ/EBImjmPv3lb/sp5DLOG2eTTemPo0g=;
 b=DjFDS+pfaXpig7MDGv4Cc6kceibgLv/m6E2Ku5OWkY4NB+kk9NTfA9HBkaCBmAcSj5tzqdK/tU9reK0XUly+IaXRqLdGHQ+Atp302HQ4gwTqgCuX91pyjK1FpqFvFmww/i7YIg6d+a8OQAfvVTnq7BoEOW7+e2wP0jCfNrahjupYauaQDK9NMX9S2ph91GtBE8zBFfUYkGSTULjKAilH1v3/8sSaZ026MgNWN08uHbE2IShvFlowDuFpfhuRXop7Eg0o6R37I14G5YlW2ZSpni8o+ETigo/D7Babihx1ytsGWB92mieG/eOxHsfx9XGq6OfqJTxlL6Uz7Wm5qtxzcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+vyuwom7ZkgQ/EBImjmPv3lb/sp5DLOG2eTTemPo0g=;
 b=jNnv4Lmuvf1UcxrD00hfj5/4k1cw0+OxQvYyc/7Q54polzJZx15ZCR2MDHMH4zN/+lQ2j+lUMfq+iHFOcI240OQjplVlppfx0ys9eu/8tp7LrKCHO6HLKHpQMYWa8BsXHYn2Z62GEd3+YXHifhhX1f/6CYIe5TRKYnfk6eYAVhfWwsecDRQqqcIQwixFpcDgxDVd/DoiK0z/D+RMuzPBevq/J4jtLwAspeDiRgqYUXUHuEsUfArnBfsYbagRL6ujaBDaI5VoRVs9J5aFFoZrsapAmKAaPOvHRUsOVtmQRSr8L2/pGaf9Eu0XP8PF19bfnIoNTB8Ba3vhP5B75FbefA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV2PR04MB11095.eurprd04.prod.outlook.com (2603:10a6:150:27a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 16:32:43 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 16:32:43 +0000
Date: Tue, 18 Nov 2025 11:32:33 -0500
From: Frank Li <Frank.li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/2] spi: add driver for NXP XSPI controller
Message-ID: <aRyfoXaTdL1gvPOY@lizhi-Precision-Tower-5810>
References: <20251118-xspi-v3-0-6d3a91b68c7e@nxp.com>
 <20251118-xspi-v3-2-6d3a91b68c7e@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118-xspi-v3-2-6d3a91b68c7e@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0174.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::29) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV2PR04MB11095:EE_
X-MS-Office365-Filtering-Correlation-Id: be5e972f-3e59-47b9-315c-08de26c0195a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HkxeWzA+APhJTJNBJxxtoLUOWYdPPR6pNmi6Or7vA25DcbZEGxGi2khmoFcf?=
 =?us-ascii?Q?QYJvlgr/hSwu5HQmZCexjdgNCTqAyC4MMcSAqfYorPD4mdGjclIAbMckexkR?=
 =?us-ascii?Q?EaDZcreIyg6HKe6oiTgeG6f5q7Q9Ek+oP5ejzxTmF1m6QTYQonIaZ8GAZy8N?=
 =?us-ascii?Q?SOv5oQbXocdFHNC2MAqaPMKy5BCy2I886pKN6c/jfnIUUHuVVCbuHpdIlNot?=
 =?us-ascii?Q?vDRBOF7MkG5KKOEYjj3qgP+WoS5KXS3CMIXKARu7DokH1RbMVPm2KfaO61eQ?=
 =?us-ascii?Q?0jbRreVUhg29R3LYRr1J4pq5Bkj9eLLiIn9gQvHPc2QBjlQCCec925l2zLnE?=
 =?us-ascii?Q?yWAfDCGST87Ah6vKqRXU94843BENUDqEMT/+UgUVdzmBIcsNWgseNGxQ+J+/?=
 =?us-ascii?Q?RyVnK3jiFFJJ3/S6ov+uG5xGFKJ4WW7f3xmPClpvje+JgsM+wAsHRF9Oapux?=
 =?us-ascii?Q?8gRcZqGf1vvydDc3MPq7P7536HKYrnwF3C6run7IXb2FQSIIpjDHKtYGtq5n?=
 =?us-ascii?Q?6U0PUiL0GkcM2EMavZkuAlrIRqvYO+UruMzAi+rMb6M5fHuQ1ALr5w2wjHEP?=
 =?us-ascii?Q?2X8gZZ2v3/OsttHjqvOAlfsTdC3mtW0c+nNinFclsJH1sVuyHa4KlPkOYKaY?=
 =?us-ascii?Q?IL5DrYLYdXlOKzE/ERTUNJYOCf9p/MGhJd3iia1N85Tiz/42GQfffyMIDHEg?=
 =?us-ascii?Q?Ny5M7F6Ugbpq6zgIl+T1PUTecz99EPj3CzCW6Od/gPnb3Hx8jAO+7i1ap6QZ?=
 =?us-ascii?Q?pCo9ym2rjhi8MOLLPzuaQw3YoGhbGwGluxajHj5EJ+aQa9u3kzMt9o734HOV?=
 =?us-ascii?Q?4Yl6lGs+VPJiIWSQGs93jHef9V7uIFoQ+QAxVTsXKUwkzecHjR9DluGEVBaX?=
 =?us-ascii?Q?x6VXfMC8r8veYwc3tUITejGU10v9nqUO1XKkh2yU94Y/EGA2XAgEpdxEhF29?=
 =?us-ascii?Q?nL89O1/oHzjY3jcMt0AHCe2aqekbLnaDgvhfN/X2JoXcVNaeEZIsQFmaXo62?=
 =?us-ascii?Q?ugxDcU64MoUQOPGUMXDwB1GyC8bVruTbMvIABcjHR04xKP1gfub7a0wIwWRC?=
 =?us-ascii?Q?wKXEQyxC005uKLXcSeGECWhTb9sGVzrxJGMoqC2kbdqcYe0jt5ni4yMteAfe?=
 =?us-ascii?Q?m4oPdE5KI+hJn7YS0UM3yRGJFa3YtP5EKlBg+unO53UKwYqp9eNGNM10Qg+5?=
 =?us-ascii?Q?uppCcfRqnpOQbOhv49wM8ljWvjAuykY8HLWA56J5+e0Gi1mLexrMTKsAq+Mn?=
 =?us-ascii?Q?/0rKCihssFBalEtRZO/DADop+yRFNuUCL9mtqwuBRPBwNZUhmgCDfGrPbo1D?=
 =?us-ascii?Q?oKQ5yGzxWRoukgKAakAlZ96ruEoo4xD8LmNtC4tNnQju2fEiK9r+k3ZNJ1M3?=
 =?us-ascii?Q?FSjFK+VaZWtMKSGFdcD7FSwmbiOHJTESzcbaK9fErBOX0qR4qy9cG8BG/rES?=
 =?us-ascii?Q?kaH7hHlY9u1NxuP9dcAeocKBOGXGeUvVyA1tAYz7v58p2jzeQuV7BNAgjKO4?=
 =?us-ascii?Q?lcfY9cuR0VHBlbrurCP+OzPXGY9x/h0WVJdB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5T9rJJxitbbP0j1Cc91wLTQHWq7cWv+LJbxNWO816R8BNvUa819ZCvv5AXuO?=
 =?us-ascii?Q?BF0/C3wZqlzIRwS18HJjZfRSwUT55sXrzlUBW6oN72nqa+/acAu8c1MxQ9Ed?=
 =?us-ascii?Q?lYhau0KoTJSsWyAMff+THA4I1jCLI0x9SDuWRNF6D9dOZHmaO7ZliHtd/pPp?=
 =?us-ascii?Q?jRWCDtgfAKLPDkwFpyRBfYkjKzQOxFl1PlvaoEQbPm6GTOfPRQjjtHBlPms2?=
 =?us-ascii?Q?z/t+xSvSIPlmur0M5wnDlevRBgFlTCOCPyqUWCjWAOWA9HdXRbowhXGB0yZE?=
 =?us-ascii?Q?g4uwT0U0AmqKLrKGG5S/IGKcxwlrwi03OfOTSxtAkkVc5I8uWZKmSP+tWZW5?=
 =?us-ascii?Q?qvyovZrp+2nr3YZwEVCWXkN4kR9Du+zqIOYBaFw6NuMOWEobYLhMxJZ0p/Ed?=
 =?us-ascii?Q?8Uj5X2RtFmgKrlcrmV261ZR/gklo4DvCysXt9LBr5Ol/9Xt+km73JXR+cNn7?=
 =?us-ascii?Q?eqjiv62jKLYB61U0MtCCk1arQbgKWMblRgDnHKBesnpHvNJW2oBnx1Psfgaa?=
 =?us-ascii?Q?8xzymL14qmqhuqvjeAHCt0p/p38ad9W0xeXrCaIcoo5nFyQJhyF3NVnYknQn?=
 =?us-ascii?Q?bXVtHuY5+b8TwochBfbYTEJLXjBnyiz9aSLT+/D2P9fS88zVGHTy3rCcZzYp?=
 =?us-ascii?Q?BDQCCrTYp4uV1f3QgNNxMQuUBmpk/f372mjuCrtu7QYEJt+mfs6cpQHrVd+7?=
 =?us-ascii?Q?pGliwnqM9HS6bpi+A3MsZ2uWeZsBgeRO8b4Rdjc+3r1tR4z1u+f5juiY1n+L?=
 =?us-ascii?Q?brphrwfxDZLxO2jw81CvCelkKtYZV47i/9qvKNxJarZ99FRMSQavlSUZ7EP+?=
 =?us-ascii?Q?T8f+VaAVIYFYSgbnpp3r973WFs5BnGveVxgfSbbUl7lVb3jumB8YZJpPD7/f?=
 =?us-ascii?Q?MG7TesvOTlsIRfKN2HjwtPtrkJoSlMabovhIqbP/SOEpG6ohcnrBLULT1AIc?=
 =?us-ascii?Q?lFa4sjqwPMe4lhqJsffglAEmuaB6HD9BoP4kvc7ay9wT3doF0PHLgDOVE/u3?=
 =?us-ascii?Q?vF45qqdKL86Z26g2jyiMtkBTp8EASg5TZQwHVL1X9BIoSdSllBkDuvYb5Uvi?=
 =?us-ascii?Q?EfQtO/XLdaNLJoEwyzTYJtw0CBga4Msiem+V2oenp5OfZ8e7RcBQRCKBNYqa?=
 =?us-ascii?Q?AT1gvIlzUQNoeHZeptLNkKgGBVUTyQ/rNUXUjv7LXgy7dzl9+2OLHCCijiaN?=
 =?us-ascii?Q?YPhGI/UETcbjLSl7LY4pUaRpa/+22kcdC2v8xI4sER+nJo3cfqNJFfWcGVQK?=
 =?us-ascii?Q?LaZAJ6kaskltKVxX3UxqQMZCVxkp7az+FaIoKLi1w2QQah0dT6bzLkWT7pic?=
 =?us-ascii?Q?TeqeAgTVJgIIBMViOvMRf7qX0uPwmVkdTzzM/gZA77IBiI00AnL/BZyTpI4i?=
 =?us-ascii?Q?EocIopHU1aN2NxyIodLM/s03rhKEVW+pmyh2LrUy28ZO2om6qmdn2HV4sFEE?=
 =?us-ascii?Q?nrIyG9UE8b5Yw01fX1E4oWU+vFOwEA5Q+gpyZERxqEugIruhKF+qvvzv+LAn?=
 =?us-ascii?Q?NnZdiMRVuwSwPYEP37TyM6eudP+pqVJYISFAKdLq4PsTaR0k8kWFmhvNegRH?=
 =?us-ascii?Q?nbrdlxwDbfKq+aGRZ/jClUdN8UlRVMSI5le8s2VQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be5e972f-3e59-47b9-315c-08de26c0195a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 16:32:43.6581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBNvaj/BL7lUtk3zNb6/Df/Hn9B7EQBV34eNIduPSpn6UD9rJpjr4zsibBaRaqQmIvBromgrEN4TpaGadP9nuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11095

On Tue, Nov 18, 2025 at 11:34:17AM +0800, Haibo Chen wrote:
> Add driver support for NXP XSPI controller.
>
> XSPI is a flexible SPI host controller which supports up to
> 2 external devices (2 CS). It support Single/Dual/Quad/Octal
> mode data transfer.
>
> The difference between XSPI and Flexspi:
> 1.the register layout is total different.
> 2.XSPI support multiple independent execution environments
> (EENVs) for HW virtualization with some limitations. Each EENV
> has its own interrupt and its own set of programming registers
> that exists in a specific offset range in the XSPI memory map.
> The main environment (EENV0) address space contains all of the
> registers for controlling EENV0 plus all of the general XSPI
> control and programming registers. The register mnemonics for
> the user environments (EENV1 to EENV4) have "_SUB_n" appended
> to the mnemonic for the corresponding main-environment register.
>
> Current driver based on EENV0, which means system already give
> EENV0 right to linux.
>
> This driver use SPI memory interface of the SPI framework to issue
> flash memory operations. Tested this driver with mtd_debug and
> UBIFS on NXP i.MX943 EVK board which has one MT35XU512ABA spi nor
> flash. NOw this driver has the following key features:
> - Support up to OCT DDR mode
> - Support AHB read
> - Support IP read and IP write
> - Support two CS
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  MAINTAINERS                |    1 +
>  drivers/spi/Kconfig        |   10 +
>  drivers/spi/Makefile       |    1 +
>  drivers/spi/spi-nxp-xspi.c | 1367 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 1379 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2f17f925ee23dd90acc1b4bf25f158070cd2b65e..527b4f284c3207fb9760ece5cc1d350e7ad8fe50 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18853,6 +18853,7 @@ L:	linux-spi@vger.kernel.org
>  L:	imx@lists.linux.dev
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
> +F:	drivers/spi/spi-nxp-xspi.c
>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/log2.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi-mem.h>
> +
> +/* Runtime pm timeout */
> +#define XSPI_RPM_TIMEOUT 50	/* 50ms */

Need unit XSPI_RPM_TIMEOUT_MS

> +/*
> + * The driver only uses one single LUT entry, that is updated on
> + * each call of exec_op(). Index 0 is preset at boot with a basic
> + * read operation, so let's use the last entry (15).
> + */
...
> + *  ---------------------------------------------------
> + *  | INSTR1 | PAD1 | OPRND1 | INSTR0 | PAD0 | OPRND0 |
> + *  ---------------------------------------------------
> + */
> +#define PAD_SHIFT		8
> +#define INSTR_SHIFT		10
> +#define OPRND_SHIFT		16
> +
> +/* Macros for constructing the LUT register. */
> +#define LUT_DEF(idx, ins, pad, opr)			  \
> +	((((ins) << INSTR_SHIFT) | ((pad) << PAD_SHIFT) | \
> +	(opr)) << (((idx) % 2) * OPRND_SHIFT))
> +
> +#define NXP_XSPI_MIN_IOMAP	SZ_4M
> +#define NXP_XSPI_MAX_CHIPSELECT		2
> +#define POLL_TOUT		5000

Need unit, POLL_TOUT_US

> +
> +/* Access flash memory using IP bus only */
> +#define XSPI_QUIRK_USE_IP_ONLY	BIT(0)
> +
> +struct nxp_xspi_devtype_data {
> +	unsigned int rxfifo;
> +	unsigned int txfifo;
> +	unsigned int ahb_buf_size;
> +	unsigned int quirks;
> +};
> +
> +static struct nxp_xspi_devtype_data imx94_data = {
> +	.rxfifo = SZ_512,       /* (128 * 4 bytes)  */
> +	.txfifo = SZ_1K,        /* (256 * 4 bytes)  */
> +	.ahb_buf_size = SZ_4K,  /* (1024 * 4 bytes)  */
> +};
> +
> +struct nxp_xspi {
> +	void __iomem *iobase;
> +	void __iomem *ahb_addr;
> +	u32 memmap_phy;
> +	u32 memmap_phy_size;
> +	u32 memmap_start;
> +	u32 memmap_len;
> +	struct clk *clk;
> +	struct device *dev;
> +	struct completion c;
> +	const struct nxp_xspi_devtype_data *devtype_data;
> +	/* mutex lock for each operation */
> +	struct mutex lock;
> +	int selected;
> +#define XSPI_DTR_PROTO		BIT(0)
> +	int flags;
> +	/* Save the previous operation clock rate */
> +	unsigned long pre_op_rate;
> +	/* The max clock rate xspi supported output to device */
> +	unsigned long support_max_rate;
> +};
> +
> +static inline int needs_ip_only(struct nxp_xspi *xspi)
> +{
> +	return xspi->devtype_data->quirks & XSPI_QUIRK_USE_IP_ONLY;
> +}
> +
> +static irqreturn_t nxp_xspi_irq_handler(int irq, void *dev_id)
> +{
> +	struct nxp_xspi *xspi = dev_id;
> +	u32 reg;
> +
> +	reg = readl(xspi->iobase + XSPI_FR);
> +	if (reg & XSPI_FR_TFF) {
> +		/* Clear interrupt */
> +		writel(XSPI_FR_TFF, xspi->iobase + XSPI_FR);
> +		complete(&xspi->c);
> +		return IRQ_HANDLED;
> +	} else {
> +		return IRQ_NONE;
> +	}

else branch is not neccesary,
you can directly

	return IRQ_NONE;

I remember there should be a warning for it.

> +}
> +
> +static int nxp_xspi_check_buswidth(struct nxp_xspi *xspi, u8 width)
> +{
> +	return (is_power_of_2(width) && width <= 8) ? 0 : -EOPNOTSUPP;
> +}
> +
...
> +	} else {
> +		nxp_xspi_disable_ddr(xspi);
> +		xspi->flags &= ~XSPI_DTR_PROTO;
> +	}
> +	rate = min(xspi->support_max_rate, op->max_freq);

use min_t

...
> +
...
> +
> +static int nxp_xspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
> +{
> +	struct nxp_xspi *xspi = spi_controller_get_devdata(mem->spi->controller);
> +	void __iomem *base = xspi->iobase;
> +	u32 reg;
> +	int err;
> +
> +	guard(mutex)(&xspi->lock);
> +
> +	err = pm_runtime_get_sync(xspi->dev);
> +	if (err < 0) {
> +		dev_err(xspi->dev, "Failed to enable clock %d\n", __LINE__);
> +		return err;
> +	}

Now you can use

	ACQUIRE(pm_runtime_active_auto, pm)(xspi->dev;
        if ((ret = ACQUIRE_ERR(pm_runtime_active_auto, &pm)))
                return ret;

So below pm_runtime_put_autosuspend() can be removed, actually
you missed pm_runtime_put_autosuspend() at below return err after
readl_poll_timeout().


> +
> +	/* Wait for controller being ready. */
> +	err = readl_poll_timeout(base + XSPI_SR, reg,
> +			      !(reg & XSPI_SR_BUSY), 1, POLL_TOUT);
> +	if (err) {
> +		dev_err(xspi->dev, "SR keeps in BUSY!");
> +		return err;
> +	}
> +
...
> +
> +	.swap16 = true,
> +};
> +
> +static void nxp_xspi_cleanup(void *data)
> +{
> +	struct nxp_xspi *xspi = data;
> +
> +	pm_runtime_get_sync(xspi->dev);
> +
> +	/* Disable interrupt */
> +	writel(0, xspi->iobase + XSPI_RSER);
> +	/* Clear all the internal logic flags */
> +	writel(0xFFFFFFFF, xspi->iobase + XSPI_FR);
> +	/* Disable the hardware */
> +	writel(XSPI_MCR_MDIS, xspi->iobase + XSPI_MCR);
> +
> +	clk_disable_unprepare(xspi->clk);
> +
> +	if (xspi->ahb_addr)
> +		iounmap(xspi->ahb_addr);
> +
> +	pm_runtime_disable(xspi->dev);
> +	pm_runtime_put_noidle(xspi->dev);

if use pm_runtime_put() here, needn't call clk_disable_unprepare() here.
after use runtime pm to manage clocks, it'd better use it all place.

> +}
> +
> +static int nxp_xspi_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct spi_controller *ctlr;
> +	struct nxp_xspi *xspi;
> +	struct resource *res;
> +	int ret, irq;
> +
> +	ctlr = devm_spi_alloc_host(dev, sizeof(*xspi));
> +	if (!ctlr)
> +		return -ENOMEM;
> +
> +	ctlr->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL |
> +			  SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL;
> +
> +	xspi = spi_controller_get_devdata(ctlr);
> +	xspi->dev = dev;
> +	xspi->devtype_data = device_get_match_data(dev);
> +	if (!xspi->devtype_data)
> +		return -ENODEV;
> +
> +	platform_set_drvdata(pdev, xspi);
> +
> +	/* Find the resources - configuration register address space */
> +	xspi->iobase = devm_platform_ioremap_resource_byname(pdev, "base");
> +	if (IS_ERR(xspi->iobase))
> +		return PTR_ERR(xspi->iobase);
> +
> +	/* Find the resources - controller memory mapped space */
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mmap");
> +	if (!res)
> +		return -ENODEV;
> +
> +	/* Assign memory mapped starting address and mapped size. */
> +	xspi->memmap_phy = res->start;
> +	xspi->memmap_phy_size = resource_size(res);
> +
> +	/* Find the clocks */
> +	xspi->clk = devm_clk_get(dev, "per");
> +	if (IS_ERR(xspi->clk))
> +		return PTR_ERR(xspi->clk);
> +
> +	/* Find the irq */
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq,  "Failed to get irq source");
> +
> +	pm_runtime_set_autosuspend_delay(dev, XSPI_RPM_TIMEOUT);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_enable(dev);

devm_pm_runtime_enable(dev)

Frank
> +
> +	/* Enable clock */
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to enable clock");
> +
> +	/* Clear potential interrupt by write xspi errstat */
> +	writel(0xFFFFFFFF, xspi->iobase + XSPI_ERRSTAT);
> +	writel(0xFFFFFFFF, xspi->iobase + XSPI_FR);
> +
> +	nxp_xspi_default_setup(xspi);
> +
> +	ret = pm_runtime_put_sync(dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to disable clock");
> +
> +	ret = devm_request_irq(dev, irq,
> +			nxp_xspi_irq_handler, 0, pdev->name, xspi);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to request irq");
> +
> +	ret = devm_mutex_init(dev, &xspi->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, nxp_xspi_cleanup, xspi);
> +	if (ret)
> +		return ret;
> +
> +	ctlr->bus_num = -1;
> +	ctlr->num_chipselect = NXP_XSPI_MAX_CHIPSELECT;
> +	ctlr->mem_ops = &nxp_xspi_mem_ops;
> +	ctlr->mem_caps = &nxp_xspi_mem_caps;
> +	ctlr->dev.of_node = dev->of_node;
> +
> +	return devm_spi_register_controller(dev, ctlr);
> +}
> +
> +static int nxp_xspi_runtime_suspend(struct device *dev)
> +{
> +	struct nxp_xspi *xspi = dev_get_drvdata(dev);
> +	u32 reg;
> +
> +	reg = readl(xspi->iobase + XSPI_MCR);
> +	reg |= XSPI_MCR_MDIS;
> +	writel(reg, xspi->iobase + XSPI_MCR);
> +
> +	clk_disable_unprepare(xspi->clk);
> +
> +	return 0;
> +}
> +
> +static int nxp_xspi_runtime_resume(struct device *dev)
> +{
> +	struct nxp_xspi *xspi = dev_get_drvdata(dev);
> +	u32 reg;
> +	int ret;
> +
> +	ret = clk_prepare_enable(xspi->clk);
> +	if (ret)
> +		return ret;
> +
> +	reg = readl(xspi->iobase + XSPI_MCR);
> +	reg &= ~XSPI_MCR_MDIS;
> +	writel(reg, xspi->iobase + XSPI_MCR);
> +
> +	return 0;
> +}
> +
> +static int nxp_xspi_suspend(struct device *dev)
> +{
> +	int ret;
> +
> +	ret = pinctrl_pm_select_sleep_state(dev);
> +	if (ret) {
> +		dev_err(dev, "select flexspi sleep pinctrl failed!\n");
> +		return ret;
> +	}
> +
> +	return pm_runtime_force_suspend(dev);
> +}
> +
> +static int nxp_xspi_resume(struct device *dev)
> +{
> +	struct nxp_xspi *xspi = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = pm_runtime_force_resume(dev);
> +	if (ret)
> +		return ret;
> +
> +	nxp_xspi_default_setup(xspi);
> +
> +	ret = pinctrl_pm_select_default_state(dev);
> +	if (ret)
> +		dev_err(dev, "select flexspi default pinctrl failed!\n");
> +
> +	return ret;
> +}
> +
> +
> +static const struct dev_pm_ops nxp_xspi_pm_ops = {
> +	RUNTIME_PM_OPS(nxp_xspi_runtime_suspend, nxp_xspi_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(nxp_xspi_suspend, nxp_xspi_resume)
> +};
> +
> +static const struct of_device_id nxp_xspi_dt_ids[] = {
> +	{ .compatible = "nxp,imx94-xspi", .data = (void *)&imx94_data, },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, nxp_xspi_dt_ids);
> +
> +static struct platform_driver nxp_xspi_driver = {
> +	.driver = {
> +		.name	= "nxp-xspi",
> +		.of_match_table = nxp_xspi_dt_ids,
> +		.pm =   pm_ptr(&nxp_xspi_pm_ops),
> +	},
> +	.probe          = nxp_xspi_probe,
> +};
> +module_platform_driver(nxp_xspi_driver);
> +
> +MODULE_DESCRIPTION("NXP xSPI Controller Driver");
> +MODULE_AUTHOR("NXP Semiconductor");
> +MODULE_AUTHOR("Haibo Chen <haibo.chen@nxp.com>");
> +MODULE_LICENSE("GPL");
>
> --
> 2.34.1
>

