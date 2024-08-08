Return-Path: <linux-spi+bounces-4153-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD5A94BF24
	for <lists+linux-spi@lfdr.de>; Thu,  8 Aug 2024 16:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B641F26D00
	for <lists+linux-spi@lfdr.de>; Thu,  8 Aug 2024 14:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D0118E74F;
	Thu,  8 Aug 2024 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mMfMZ+lc"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2088.outbound.protection.outlook.com [40.107.249.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC1718C90C;
	Thu,  8 Aug 2024 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126122; cv=fail; b=IAHfzxM1hgeoC7dEMe1S1MWhh3I0KA4arflm13TrCn3U8yLmhgdWKjJWMZLkDLzAD8jGFxb4ceV5Yb2dXhZCnKKbZ11gw+oz3p07ONABlbioPBT6HkRlZKLPQe0Ncbo0odA2BuGft6FUSVntnB5HgyMa2YRzciT46dX2ZLo/Ugw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126122; c=relaxed/simple;
	bh=J2JUkr74CNYTV2huGfpV8EcfktWp+n7heZq2jSqBKZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dHRhPeym43Aqa5LzA4PhT66nWo5vipwY+fMnrDppz2MQZ86fmoV4Rz2ap/KJ/cTAM/bZ/qnU9/1LPQkNyltGKSxfM+mHjE7E4JZevFAj66/7ZGbB1x0PlFuyAAEPVBEV48jGyPEe284pg82p3XOZUuC46G3RNMDhoE9A26zdW5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mMfMZ+lc; arc=fail smtp.client-ip=40.107.249.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A57PTMmhrzHQjqdOMG6K0ooTZUi7/bpJ5EsNjpR0P5RHWk4lC0SV3iV7Az5Q50rpnZrmbdpxgcXpqul0vx0cBui97iOP86+3VD1lTiK6sIaXJKUjpHtAEECmxY+NumbGOqJYP3ZZfCp+PtH6EtGjpRTS86qpaBytTuah+q2KXMPvuPWn83xYavPhm75U2LIrP30l6Cmf0lk7kbYDoYXlIb/3s7qFSlW/E10IMEi0tMsJuEvAncp8i/+4IeTJLT/MgFd5LhWMVGllAqqgvJKb21GhbBPgx3cnneuR7RbXlOamPl0VpbammTfKBRo3HXsK2UytejbM2f9qxI7QKLwALA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gn0NEQZPGKj6oy5AQoBeSMY4Fh2o1Q+dAo6vcrv/9o=;
 b=Buo/toYHhPfO8v93b64GMZBR/br7ynUct3mO2qcwkDNIqGOVlpErLdHPcrPtPSQlEnFlPvAFXt7GGhq1yr3qko+Ofx1enIERTzs5i6xeDqBRei1w5z6B4PyHk0P0PBLdjPQDgbBh6Qfw2qepoEhKgjW74WXnvOGuTy9Cr+j+WK9Cqn8Pq2f+h6f0sxiONQ9H3ouyXlpomaP21qT11j4YZ/v8djzxZwy5bEm2zENllAcE89jYmvVpjWnFqsHJuIMlT9x1mnpxxDJ7vPsag/Pz4IqOngDr9Le+aJVA46tuoKbHEiq4Qf/Nme0fwsYjJpqonv+PWSlp3LjPKcE5W5vbuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gn0NEQZPGKj6oy5AQoBeSMY4Fh2o1Q+dAo6vcrv/9o=;
 b=mMfMZ+lcfpvyy64koqeMLJjNuW6JiL7xUXlTFDLfDtJmwgoiosBCySg+IB0vEdunXRX1mO9s4Fe/0r55OjZsknsDUObNq8BdlXcMV1H5MIAjR4JSDN+A7fTCL7M53+txJeaHYYp3GRQ020g2+XxSHvTwaRms9oPqPiUKqW1PMYY+pKMiEqquV04sYjPtotCick53GPRggv5B7taBv+Fy7VY0uAHoryX3nK/E8wPHH3a/4Cv5hfwD5n7GWM6pBpf1EuSl4VH+aP8tROuESZYlWu4GCJ2QKzjJEYAwCcosWQZBwd960mHF9KxJRUfN8K43/ZEgpINr7GvjQQrvjELmzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8431.eurprd04.prod.outlook.com (2603:10a6:10:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 14:08:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 14:08:35 +0000
Date: Thu, 8 Aug 2024 10:08:27 -0400
From: Frank Li <Frank.li@nxp.com>
To: Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
Cc: broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	lech.perczak@camlingroup.com, krzysztof.drobinski@camlingroup.com,
	pawel.lenkow@camlingroup.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: imx: fix use-after-free during driver removal
Message-ID: <ZrTRW7Y/vUN0wGx+@lizhi-Precision-Tower-5810>
References: <d5aeab83-347c-48c5-9482-b01ef73baf97@camlingroup.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5aeab83-347c-48c5-9482-b01ef73baf97@camlingroup.com>
X-ClientProxiedBy: BYAPR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:40::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: 67afcae9-64f9-453d-a081-08dcb7b397fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Je2I/IBuU0EkULDamlZWGXMK82T+VXiXd4UW8PdfPr4NjtGbZw5jDsIxmqIQ?=
 =?us-ascii?Q?/YQEE1ry8ak4TNiuTgmk6Rghv4oytytBo1ayJHoQFLeHZkqCRo8tbIr+wyZs?=
 =?us-ascii?Q?fFwi2inLYah5MDvMnyZRmi19RwUScgrkTylHXuMejAjrVBclsy41zviwpQGP?=
 =?us-ascii?Q?+c/B5JGO5+DRebhb6vakcd+Br3zqi0AMWVdEEbI/2v0PUXYVeaSICM7MbiuT?=
 =?us-ascii?Q?otuBNiLEvZnCI4LLwRR/jXDFxoCC8LmoULmVzu30JTtkaxVxyQgmDQSDZSTn?=
 =?us-ascii?Q?76ULAO2ru9JpC6hnbKdSFO0odhvZgfCQ+9q793SEN/JkvmJdqgqPT2tpqbP4?=
 =?us-ascii?Q?LHj4sf9HWtqYAN7Vs2dKAwCJX0dToRAx1y7lYodZekiw4xK8OPJfOWlgdUBL?=
 =?us-ascii?Q?t5Jj75q6uYXEJHOU8rA9D/aPundckdPSdHYCr0NibgCLAeXgs3ZFHh1x7dkj?=
 =?us-ascii?Q?jNpiUQqzkE357hWIGD7JfQJrE5iVtP+5WeDPSsg6H0M0XUruK7pruxyo631L?=
 =?us-ascii?Q?B0Lxj+0Cg0XmIaqSzhMtrjmeOhG3/iPILghsitSGTDdDXXdoeIBFGHCCna6o?=
 =?us-ascii?Q?/pZYeLDazvHPuTV97xu4nvyLmJ9ssmPaTktgkqjxT536JtqqzETFiFksCAo8?=
 =?us-ascii?Q?Ub/FDFpRR5b4GH3iFG2yIwJH3owORRsxGdtfmXybEX1ecUosNELbC00YoD6E?=
 =?us-ascii?Q?APnRAexcFsYFzyG+ldMBzdIFPh4l50ZCGju1MkSsI/7GBZQrAtwB6ZzWYGAd?=
 =?us-ascii?Q?zf3dJCftJGACBaGU1Z9P2e3BlInVEGMPBk4sq92j+xHJsx8GGeABlWwuOOuK?=
 =?us-ascii?Q?1qOl1ppb8AjWLUxjS1guQZlueZh4Ut8JZQRRN34FOsorZGPm+AFSl/JgxUtb?=
 =?us-ascii?Q?E6K24Gt1pRLoDxK03RD0b94kzNM5bUNv+dwsku/4IfqSK/0B3FFBncHuqspw?=
 =?us-ascii?Q?b3EpHyr731FXaDfe35Oyv272Wuv/q1ZYjishpMPb6hUrwSbCo1JAwE0nn6p2?=
 =?us-ascii?Q?4algMyg/QxvZXe4XMFBnZD0lNQDhLJzyowy/Htn1bAPUYbRULQV6Hb5hkLA3?=
 =?us-ascii?Q?pGTxtDsm+wTYt9CKTxjdTqwPM/uzKcEUeHUerym5r8ZJdWvLfyHVjF+naEjS?=
 =?us-ascii?Q?WYnaLMniVeudQmlQayfmQLyb1rGMHYTy7GwatYOmnqvwDaKgQplf6fuCs0fj?=
 =?us-ascii?Q?/xeKEc0PxooXqIUzcp+3Aq4vaLd4/Ol7N8WFD6l5B/33MCcOxD2NTi0cbGOC?=
 =?us-ascii?Q?awxyQokoEEHvjHIlsmyCU57JYGDET6+4vzHe0DzTDYbMMm16beU7lBoJ5BRv?=
 =?us-ascii?Q?pD860UabIELIL8n8g2AvdzLbFQISYSzUAwjCe2j0yXpMLHgcSLQ+qzW8JEzt?=
 =?us-ascii?Q?hNl1vN8rg1+TY678EpIAysZcgXvnYD9ivPGYAji1yKLM9Y/WlQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c8HMADCVxKwbFbsF+hv5pvs2OoJFXl61UnpfSL8l8bE5DSlmZZpTzNrnGpwx?=
 =?us-ascii?Q?MdgMLmoBPOmfxEgq2N7W1YeP+A/b3bpJidU6JniXOfDW47OXq07K9fFQUlHA?=
 =?us-ascii?Q?je0vCErmhEaIC2EXZ/pArgnLLwWGLWtpy3LGdZRN4s/zZ+AofkO0IyHgN+Y6?=
 =?us-ascii?Q?xQbVuJ6zKniaDkDDXRu/dcPZ9nGkdiZWdDT4ZRXxcBA0S8tCRMVxSKsv6xW4?=
 =?us-ascii?Q?OsE5bMGh1lnC4Vi/iYZv8eUj64OpGeJ5tTVHFWfaQAbIOPcml10WydGxMm3n?=
 =?us-ascii?Q?rN8Vj1KBHMadIMdspmHppZfeRhCvKiawq0YLts1qUexGnytok4lOa3Fz0sEe?=
 =?us-ascii?Q?MVclsHpWmbjSDCdtBCGpE5VoU2CMQ39WZsL9UYsFcyP0ScV5W3QK2ZPTQBY0?=
 =?us-ascii?Q?PoyD5dLKNg7Pqyeo7Cm/Y1S8OkGRVLCyh4aNYrhQrWfRHeox6xiTjvP13rEq?=
 =?us-ascii?Q?GbbV0LjZdUN+qVskol0LiXJJXSaCKVi66PIsFtDrWQo2pKzvVoOXa919q3dQ?=
 =?us-ascii?Q?PZhULPDWg1WdAmywyqX6krBON49OfTsrAxMjDYgRsf4Nu6xNDl1XJjKNlQ1V?=
 =?us-ascii?Q?oi7W9LiV8vlG8QiHt+0jHRUyBIqsGSic4iyPaOJk/rGwwkjzUrsFwR4tOGFg?=
 =?us-ascii?Q?Ka8Roy1raRqekp/mgNXv0+8Ee90l1TxGxK3ljP6GYN7i139jgBbQlFjpwChL?=
 =?us-ascii?Q?S9ALosO1oOwHlaCVVrShEk5NxO1HzhEvDB2P05o/85jSRE6OgHtkyS+R2uKl?=
 =?us-ascii?Q?GvfXHDhkoEQKDSiFlcQ9m0KjpPpZVMfaC2oQNiDWiCox04wGIjvOdSOvw2qx?=
 =?us-ascii?Q?8uOojxXHFVbZlny9OMnCyTh74xzSMEKEE+cBBKxktAPb9WMg2jO58Ec/7XQX?=
 =?us-ascii?Q?u0sOhxk6xBHbYygE1RoBYwO7BsuzSqXSVmIZ+2IpUOUAvbxyk5mUqrkvpt3c?=
 =?us-ascii?Q?BkbZByyBtUlWsu+ZYyg9I5kkYkiDi9g04zL/us8ib5KZ51Mae/A9rxOxBjPi?=
 =?us-ascii?Q?pi4W6FJ+/it6YdJn5Oyz6IpS+TOKgeXgcv6ItyOcE4jQcaApFmKlBBHtJ3zd?=
 =?us-ascii?Q?+7HHfh2bjzJuLqQjKe27G/VS28f4s7izhhzzJ677NP5uVGeBeR+iqNAU3u8S?=
 =?us-ascii?Q?DZMkvPvqI/S9itDMe/RIq4eB2Bnp9iqAJ0wPNEhMAyTB1Jxdc8i9v7rObGDF?=
 =?us-ascii?Q?a4Ivc7MtxfuQHVzqWtGTX5NKqV7aeNUvYG+t2wBLcgZp4+cD7Lo6T7qpKjPG?=
 =?us-ascii?Q?38AFVG+guRqF4I/XqUHvqSzM4EOHlyk+dSoV5iq4wDhlF/d/IpgKq/ukmt/c?=
 =?us-ascii?Q?zf25sll6x9bN1SYOvoki68MsAxx08YX2yu5NNy0KkEOg58hpKH3z2Fr0HC7J?=
 =?us-ascii?Q?R2RevnuobtYXax+nW9GIf3kiDrp9vbtKVxVy6pU1jA17RF7XEGfzt3txpDBf?=
 =?us-ascii?Q?8UkV9+WByT8b744xecyCFYRSfLv1obIgqmUz9gTW9+O+NovBmWjw1B9c4IBj?=
 =?us-ascii?Q?+TJBtciC0ePcKUlDwiSLS5C9xW03ezXY2llvtn3EqD41P48CpDRvQufJNnTt?=
 =?us-ascii?Q?wC8XlwyYeL65+QwJ6yyxaWajk5HthuOMt2vTJrEV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67afcae9-64f9-453d-a081-08dcb7b397fb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 14:08:35.8310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFZygKQDlz4E4m2N/tGcihh0KwsquKFEWaQl8cbADmiuJp/30vwcsb16CHO7fh2w+0v7c8tvVxVEZ8BEjfWxEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8431

On Thu, Aug 08, 2024 at 02:38:45PM +0200, Kirill Yatsenko wrote:
> With the CONFIG_SLUB_DEBUG_ON enabled the unhandled fault error appears
> when unbinding the driver.
>
> The spi controller driver memory is freed inside the spi_imx_remove prior
> to executing PM callbacks thus leading to use-after-free.
>
> Fix it by switching to the devm version of spi_register_controller.
>
> Alignment trap: not handling instruction e1932f9f at [<80632434>]
> 8<--- cut here ---
> Unhandled fault: alignment exception (0x001) at 0x6b6b6c53
> [6b6b6c53] *pgd=00000000
> Internal error: : 1 [#1] PREEMPT SMP ARM
> Modules linked in: cdc_mbim cdc_wdm cdc_ncm cdc_ether usbnet cdc_acm usb_serial_simple usbserial usb_f_rndis u_ether wl18xx wlcore mac80211 libarc4 cfg80211 wlcore_sdio phy_generic ci_hdrc_imx ci_hdrc ulpi usbmisc_imx roles pwm_imx27 pwm_beeper evbug libcomposite udc_core configfs nfnetlink
> CPU: 2 PID: 1241 Comm: rebind.sh Not tainted 6.10.0-dnm3pv2-dnm3pv2-ga03695deba11 #1
> Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> PC is at __pm_runtime_resume+0x58/0x6c
> LR is at spi_imx_remove+0x1c/0xa8
> pc : [<80632438>]    lr : [<806ebefc>]    psr: 20010013
> sp : f1d81e88  ip : 83c0e204  fp : 00000000
> r10: 00000000  r9 : 00000000  r8 : 82dd9454
> r7 : 82dda054  r6 : 810f82f0  r5 : 00000004  r4 : 6b6b6b6b
> r3 : 6b6b6c53  r2 : 85321240  r1 : 00000004  r0 : 6b6b6b6b
> Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 1687c04a  DAC: 00000051
> Register r0 information: non-paged memory
> Register r1 information: non-paged memory
> Register r2 information: slab task_struct start 85321200 data offset 64 pointer offset 0 size 2176 allocated at copy_process+0x1d8/0x1b2c
>     kmem_cache_alloc_node_noprof+0x10c/0x334
>     copy_process+0x1d8/0x1b2c
>     kernel_clone+0xa4/0x340
>     sys_clone+0x70/0x94
>     ret_fast_syscall+0x0/0x54
>  Free path:
>     rcu_core+0x2b4/0x7e0
>     handle_softirqs+0xf4/0x25c
>     irq_exit+0x68/0x8c
>     call_with_stack+0x18/0x20
>     __irq_svc+0x98/0xc8
>     cpuidle_enter_state+0x168/0x37c
>     cpuidle_enter+0x40/0x50
>     do_idle+0x108/0x200
>     cpu_startup_entry+0x28/0x2c
>     secondary_start_kernel+0x12c/0x14c
>     0x10101340
> Register r3 information: non-paged memory
> Register r4 information: non-paged memory
> Register r5 information: non-paged memory
> Register r6 information: non-slab/vmalloc memory
> Register r7 information: slab kmalloc-512 start 82dd9e00 data offset 512 pointer offset 84 size 512 allocated at platform_device_alloc+0x20/0xb8
>     __kmalloc_noprof+0x148/0x380
>     platform_device_alloc+0x20/0xb8
>     of_device_alloc+0x34/0x178
>     of_platform_device_create_pdata+0x60/0x11c
>     of_platform_bus_create+0x1cc/0x35c
>     of_platform_bus_create+0x230/0x35c
>     of_platform_bus_create+0x230/0x35c
>     of_platform_bus_create+0x230/0x35c
>     of_platform_populate+0x80/0x110
>     imx6q_init_machine+0x98/0x21c
>     customize_machine+0x20/0x30
>     do_one_initcall+0x58/0x240
>     kernel_init_freeable+0x198/0x1f4
>     kernel_init+0x1c/0x12c
>     ret_from_fork+0x14/0x28
> Register r8 information: slab kmalloc-512 start 82dd9200 data offset 512 pointer offset 84 size 512 allocated at platform_device_alloc+0x20/0xb8
>     __kmalloc_noprof+0x148/0x380
>     platform_device_alloc+0x20/0xb8
>     of_device_alloc+0x34/0x178
>     of_platform_device_create_pdata+0x60/0x11c
>     of_platform_bus_create+0x1cc/0x35c
>     of_platform_bus_create+0x230/0x35c
>     of_platform_bus_create+0x230/0x35c
>     of_platform_populate+0x80/0x110
>     imx6q_init_machine+0x98/0x21c
>     customize_machine+0x20/0x30
>     do_one_initcall+0x58/0x240
>     kernel_init_freeable+0x198/0x1f4
>     kernel_init+0x1c/0x12c
>     ret_from_fork+0x14/0x28
> Register r9 information: NULL pointer
> Register r10 information: NULL pointer
> Register r11 information: NULL pointer
> Register r12 information: slab kmalloc-64 start 83c0e180 data offset 64 pointer offset 68 size 64 allocated at kobject_set_name_vargs+0x2c/0xa0
>     kmalloc_node_track_caller_noprof+0x14c/0x37c
>     kvasprintf+0x5c/0xcc
>     kobject_set_name_vargs+0x2c/0xa0
>     dev_set_name+0x2c/0x58
>     spi_register_controller+0xcc/0xc48
>     spi_imx_probe+0x41c/0x694
>     platform_probe+0x5c/0xb0
>     really_probe+0xe0/0x3cc
>     __driver_probe_device+0x9c/0x1e0
>     driver_probe_device+0x30/0xc0
>     __driver_attach+0x11c/0x1cc
>     bus_for_each_dev+0x7c/0xcc
>     bus_add_driver+0xe0/0x220
>     driver_register+0x7c/0x114
>     do_one_initcall+0x58/0x240
>     kernel_init_freeable+0x198/0x1f4
>  Free path:
>     kobject_put+0xd0/0x29c
>     spi_imx_remove+0x10/0xa8
>     platform_remove+0x20/0x5c
>     device_release_driver_internal+0x184/0x1f0
>     unbind_store+0x54/0x90
>     kernfs_fop_write_iter+0xfc/0x1e8
>     vfs_write+0x25c/0x450
>     ksys_write+0x70/0xf0
>     ret_fast_syscall+0x0/0x54
> Process rebind.sh (pid: 1241, stack limit = 0xf1d80000)
> Stack: (0xf1d81e88 to 0xf1d82000)
> 1e80:                   83c54f40 82dd9410 810f82f0 806ebefc 82dda010 8062698c
> 1ea0: 82dda010 80625014 810f3b60 82dda010 0000000c 810f82f0 f1d81f28 806228c4
> 1ec0: 85cad640 0000000c 85e56080 85e56090 f1d81f28 802dafe0 00000000 00000000
> 1ee0: 85108e00 802daee4 f1d81f80 0086ae30 85321240 80b14188 00000000 80257d8c
> 1f00: 8687c020 00000000 00000000 00000000 00010000 0000000c 0086ae30 00000000
> 1f20: 00000001 00000000 85108e00 00000000 00000000 00000000 00000000 00000000
> 1f40: 00000000 00000000 00000000 00000000 f1d81f50 16506a32 0000000c 85108e00
> 1f60: 85108e00 00000000 00000000 801002c4 85321240 00000004 00000000 802580e4
> 1f80: 00000000 00000000 0086b000 16506a32 0000002d 0000000c 0086ae30 76ef6ba8
> 1fa0: 00000004 80100060 0000000c 0086ae30 00000001 0086ae30 0000000c 00000001
> 1fc0: 0000000c 0086ae30 76ef6ba8 00000004 00000000 005a6dd0 00000000 00000000
> 1fe0: 00000004 7eef2468 76e982fb 76e155a6 40010030 00000001 00000000 00000000
> Call trace:
>  __pm_runtime_resume from spi_imx_remove+0x1c/0xa8
>  spi_imx_remove from platform_remove+0x20/0x5c
>  platform_remove from device_release_driver_internal+0x184/0x1f0
>  device_release_driver_internal from unbind_store+0x54/0x90
>  unbind_store from kernfs_fop_write_iter+0xfc/0x1e8
>  kernfs_fop_write_iter from vfs_write+0x25c/0x450
>  vfs_write from ksys_write+0x70/0xf0
>  ksys_write from ret_fast_syscall+0x0/0x54
> Exception stack(0xf1d81fa8 to 0xf1d81ff0)
> 1fa0:                   0000000c 0086ae30 00000001 0086ae30 0000000c 00000001
> 1fc0: 0000000c 0086ae30 76ef6ba8 00000004 00000000 005a6dd0 00000000 00000000
> 1fe0: 00000004 7eef2468 76e982fb 76e155a6
> Code: e8bd8070 e28030e8 f593f000 e1932f9f (e2822001)
> ---[ end trace 0000000000000000 ]---


Can you cut log short, which only show related part?

Frank

>
> Fixes: 307c897db762 ("spi: spi-imx: replace struct spi_imx_data::bitbang by pointer to struct spi_controller")
> Signed-off-by: Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
> ---
>  drivers/spi/spi-imx.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 4a56a5b16e12..14834c4e839a 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1854,7 +1854,7 @@ static int spi_imx_probe(struct platform_device *pdev)
>  	spi_imx->devtype_data->intctrl(spi_imx, 0);
>
>  	controller->dev.of_node = pdev->dev.of_node;
> -	ret = spi_register_controller(controller);
> +	ret = devm_spi_register_controller(&pdev->dev, controller);
>  	if (ret) {
>  		dev_err_probe(&pdev->dev, ret, "register controller failed\n");
>  		goto out_register_controller;
> @@ -1900,8 +1900,6 @@ static void spi_imx_remove(struct platform_device *pdev)
>  	struct spi_imx_data *spi_imx = spi_controller_get_devdata(controller);
>  	int ret;
>
> -	spi_unregister_controller(controller);
> -
>  	ret = pm_runtime_get_sync(spi_imx->dev);
>  	if (ret >= 0)
>  		writel(0, spi_imx->base + MXC_CSPICTRL);
> --
> 2.34.1
>

