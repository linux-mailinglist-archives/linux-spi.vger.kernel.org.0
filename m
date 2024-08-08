Return-Path: <linux-spi+bounces-4155-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D019594C222
	for <lists+linux-spi@lfdr.de>; Thu,  8 Aug 2024 17:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6412833C3
	for <lists+linux-spi@lfdr.de>; Thu,  8 Aug 2024 15:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD8018E749;
	Thu,  8 Aug 2024 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lvJTg25a"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2054.outbound.protection.outlook.com [40.107.104.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C00D18EFF0;
	Thu,  8 Aug 2024 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132721; cv=fail; b=XD/XQXKBBY7psO5inYoPxH6ZLUDHDvK4SKt0fMmoQICz5ph8Hfc0tbkICyD6dxROSL5Tj7EPEkNXU0rwbov1RjeUhojHEliXdRMlEdDhO1THli1CuueWKOymalwQOoDSrxayXzP9tSaMUeqYr2jQhH4cW9jZkeYo5i5X6pLhQII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132721; c=relaxed/simple;
	bh=2HBRF0EyAYcHFpqy6wBAVjA8QgV2vxOEQRVdMJFhCb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pxJQbE3LAaLE038C9aa9Nbsm3gV80FXPDrBp/+ElJn6tWMRr2JifNofv1pfvjCZFQyrqWp+eiPHfBKObox38EF0LXmI76sFzwkW6GciGK7DzxeZYR24FwurJ1VdgRN8El2HO49sKqHlcNY5qTPHawRFBUlngJxU93pf7UUdlJY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lvJTg25a; arc=fail smtp.client-ip=40.107.104.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Za3mIObWqv6g6gEbXCfvChgxviyVwwMRTXbpYfm6LSCyX/9bzto8gxar0iKy6BE6eZGnp6ueVhJbuqhtTEKotvgu7kqMLv6bB0bafBa+I9p2hiAKGMfQpFQiR/XFpRX7E8YKNLSAHrib+OhkSa7MZDOJEDrsUnkcU1dbUeevHRlfE/6bpkgrIwvE13cCttrzyaZx+PEbW/uvvnoenCQqgjOYiM6EuwW+elivPVbbOLF4px74mV2qH7XOeSRU4+f6RXFIWLWQw6/cLFHZAKtFhW2wUCs0fQ9zwQIw0ciQuWu9gOUJHPAHH2vliFnyFUoVaB2hfKyhGm72jd38/BDxjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnWmk5YG8jeSsh8SFIdzZinBNNoBlcABrzSaWyugNL0=;
 b=rzpKswcuEXhJIEs8fLws/WYWnTI+iCNG9QVVKH+3jiKaxBE47nQd1fukdEwu2r6s0zHHdmHMgdIvtaAii/j9uuflahA9UrFF3fS9HQyw2iiitrjlv5Lu2hnkbr+4k24/ONVRsCKliA/zBER0VZ5K9ZXaGg0gHi2/ziQlfxJQ+vAo2/WrY1sM7xebwvxv/X4BkpH4FdzE0WBsiXETKieqpctP3LZkZhc6PU/aVREnDZ481WrxQ4LE3zFVpt+FdNPGDloHKOtPH4G9Y5sIyKxvb5cPHwmB0rcnrgJznw61Ly2d79aePGeYu3b7T/XTTwHuPSdsSVO4mJqvfgET8Z3+1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnWmk5YG8jeSsh8SFIdzZinBNNoBlcABrzSaWyugNL0=;
 b=lvJTg25aAE8eSOpm5wC6cAOo2zhnMAVONQBJkQG1C+2unFz54zh4tOzSgSVgvK/2mTqBQTqx9tYrjygsMi+NRsi3lgL166qcALnzBFEkYTUK6KEQky6mSrOxP+Z8UGbspyu+wUCGIE2vEbVkB8Tab9V/sjnzbXeuxyXGj0Q4RGP37vgdhVWjUFOzGknvajBEkVBsD//TbEdUrYMkLAH0kKekUbk3KHyW892d8+cKV7G/VjbD+or8Vs7LbpIVv6VPcRH5BPno8HF3HSiZF5IMZsPYrdVcHtQDSB39FiuHcheSHk6/pMysdoRZv0NZq4XoHeY5QB1ZR86z4qr7xoAdTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB11001.eurprd04.prod.outlook.com (2603:10a6:800:27d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Thu, 8 Aug
 2024 15:58:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 15:58:36 +0000
Date: Thu, 8 Aug 2024 11:58:27 -0400
From: Frank Li <Frank.li@nxp.com>
To: Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
Cc: broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	lech.perczak@camlingroup.com, krzysztof.drobinski@camlingroup.com,
	pawel.lenkow@camlingroup.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] spi: imx: fix use-after-free during driver removal
Message-ID: <ZrTrIyDWsXkixqSL@lizhi-Precision-Tower-5810>
References: <d5aeab83-347c-48c5-9482-b01ef73baf97@camlingroup.com>
 <ZrTRW7Y/vUN0wGx+@lizhi-Precision-Tower-5810>
 <19c5442b-984e-4758-ad50-34392c0ae79f@camlingroup.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19c5442b-984e-4758-ad50-34392c0ae79f@camlingroup.com>
X-ClientProxiedBy: BYAPR21CA0004.namprd21.prod.outlook.com
 (2603:10b6:a03:114::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB11001:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc30f8c-3ffc-44b3-c469-08dcb7c2f610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UWPqCxbPrckuom6R1CUj0jROiZjWb6WreGoY4LHi2jlKvxH19C3UAOrQz+02?=
 =?us-ascii?Q?wSxZZeO29uPTUUn1emETM3cbmbjqd77196sW1RLeKUvmL4A2UnNaDbGpsvrW?=
 =?us-ascii?Q?Jgd7CreO4tDYJeZvWAkLsiZkCdIHkCMpF7MYdqrT9R3jbO5oQj7G0Y3bVw7Q?=
 =?us-ascii?Q?bZAEYwMhgo8gXrKPKYTd+xsaalF1blRwWej8U/nxcfFjE5uyoKeKz0myM+W7?=
 =?us-ascii?Q?Wxbh9r6UZKV9J8Hjd4SAPzwhMtWeUSrmxnYpNPHv0puV56d2z/xauGWmVv0r?=
 =?us-ascii?Q?6EQAgotBOKdWoDKhcGmQg8pRI+4Ske+LrGqvmEbdyZ64CZWnX2Jp/EnlOYLt?=
 =?us-ascii?Q?HegvQUYWb5QKaqaAqbzUj6WRh7T3GFgjjemllgXje77NP7HPmbglkxLRGgvt?=
 =?us-ascii?Q?68MY8ANQ18hpvVUY7CVBePkd0JNEecPRvx8bHBhNraAgjHLsQHmzkl8YPvr7?=
 =?us-ascii?Q?2Guv0H0vofpSNFPqmd+rXFYLX+DiV5HDYpzYOzHi3abt/LKwcMvD6Lf+KoR7?=
 =?us-ascii?Q?quu0yUB3zu3PYwysITS4c18I3q75dsnebSpiX5+x9Q6SgNNIWlIgtAhbILOQ?=
 =?us-ascii?Q?xCnJlBY2GR+7EJn3zEtM46rQLmcUaHkynjIUhltSTEWV3JT+dDOJmoWf4Mis?=
 =?us-ascii?Q?0PB/dThsd4G/WCXdJy9VcaB4Z+EZ0UAp1AAesRo/6/jUffI/0WVkiw94gjCP?=
 =?us-ascii?Q?r3o/xd9M3TftK8en4em5G39oNaTQPfH3CG1FiMBBKsnqg75F4zryWBXPpw7N?=
 =?us-ascii?Q?u0Qc7ROXmVaXjwCZlOOybOyHeieFq9tjaTDTuFZTNsfhrWSwT2ziOyumbuQ1?=
 =?us-ascii?Q?IaLS5fqcDpJL2xupMS+QkV9SNuS+2RHGkp6K5V10l1ocWGQT7ZWSuZRpxIff?=
 =?us-ascii?Q?mwKbMJ35ZIcaiqGgQTdxVuMSXwSFkyTrFbWyIVdCRFLYufm0Mh229NhTjgKS?=
 =?us-ascii?Q?LZF+J0Qx9ZL8Vvs8ovI9lB/esvW+8HBFM69Lei8Tb0hjm9psMcn6tr77IurU?=
 =?us-ascii?Q?E69i4ev5i/CO4y6j+HgH7YBdKMqwIQFiRO2leHRhdLtaWBVTHbTcbVn7p/cO?=
 =?us-ascii?Q?PZ4rcmP7WJLQIvMXCdE3P+hSw5ZyEnKMfKyNplSxhZ0OANE9fRsXWY6dIVo2?=
 =?us-ascii?Q?IJEgt8bbj0EJ98d7ZRM4paGs5Uk1gZloK6DWHjTYSX11Ga4+5znbAiIvJebo?=
 =?us-ascii?Q?B8Fdbu3i19+y0XLuqUeLqvfya9W0IRibzhh1YxDeSKfb2T6a60sJKzpyOCZi?=
 =?us-ascii?Q?aEygrhYAuLiAu/DYQm+/QbG2x6uxA01khwMqSHQqcwtOGif57l8pBXfvHcl1?=
 =?us-ascii?Q?1/HbevefmzNlGi73JqVAFpnbNh3nkGlwoW0Eiw/CSvPsmX5qULMtSp2qMf4C?=
 =?us-ascii?Q?+uGy0CwG5Bq6RuCuV4Et03xPOVg0VpNa38xmQNYx3is5npNvKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iwRo6yKbuz8AX2NGuzm30vWRyVQorku8W84t1YP3Is4FaWBZm8AzzkMwNYFH?=
 =?us-ascii?Q?6GNGqZnbORGQlu8oqdlS4tVmyOdEnJR2r8rd8I/WK6vwPuxjgCoYmGyRh6wt?=
 =?us-ascii?Q?8DJSk+TiWAtstOiGZroZXJJshbKtkk9ermMWqrwAsV/+bPQkyFqO8+i6PGKm?=
 =?us-ascii?Q?TVqvQftiMeHn5u5PC47iJfcj1IMrCwPS6PgvixSj8hZM4OoOXy/Ka/I80zFm?=
 =?us-ascii?Q?JqPSlg6N1xbyPbvQ3wl9XF0FR7GRd6Np3A9g8xk1qRWEP+6/dS/wsJmc30ub?=
 =?us-ascii?Q?aPsHC5dD9m8S1gAdIO7BtPgyatyxihSC6lnNys4C/5eWCN6pJccvxErUjymI?=
 =?us-ascii?Q?HMvAxey6pyyWED56zpNXASVgKlHyXdEBIqmvlcsjBgtSBWTZZAnZ3ac4U7d+?=
 =?us-ascii?Q?skm434OuZeFoN447SN7gw3KnK2+CbQ6+EmoLqKIUIoh1hir+2726Bf1bxgZb?=
 =?us-ascii?Q?VUSTp5HVe3hqfvTP4chtkqbexRiS4Xusyc9cUGgutGy3YASEdCb2BhowjVQe?=
 =?us-ascii?Q?yeYSNY6ahK2tiesys247p49Y+HiLgohuvtjFN/slI9LDPNL87ErKWhEDlgue?=
 =?us-ascii?Q?5Dkn/MzErpRGF7x/IaXyW/ffRbgZHGM+TgFtW6XzXWnFR2tCq7POzeqQmMl7?=
 =?us-ascii?Q?RJNUysKEQD9lHmTN/jWS+IHiGAsxE5+rHunMkz9vsW2zDo/sg454VskXbqlk?=
 =?us-ascii?Q?mNo9hWEYcDxaWcRkHaUawjZe3AsnxMnCxha6rAQpeX4bhVLYMkMzsnW+JmHU?=
 =?us-ascii?Q?dsZIEjuwJleZ/TGvOJuf5AuEEYcBCaiRqWC2BUwl29FWN8vuB35AQcxoJD9T?=
 =?us-ascii?Q?i/oNxm8B14VVj+xHmW0ePmxqUxDi//SVXz+/dHmd9tQiTSvvq5SH46hq/EKx?=
 =?us-ascii?Q?mPHL4Grii6W6Bj9p8B3d4hFs/HBt+Lubkpzu4cW/tR0sE8uWI0lWllChm9Zk?=
 =?us-ascii?Q?hvvfY8W+0gAOQJsGc9LMYwk+/SGHANNwbuGVGQ4LD8nmUtP+dLUjRS9MuoKC?=
 =?us-ascii?Q?HxwugIUfZZbp61nuQV15u6J4epdGxsD0Brpkf+l4gva18yg/MAOFtBP1BzYp?=
 =?us-ascii?Q?XkfWH2pSLBstx4Vs1YiBsUGCX2ikOFw5o3lc4VX5RW12prIDUXKdzoqMVWvH?=
 =?us-ascii?Q?9Kpe/JEXAY082VmpPlbOaTYVzQxsXKc1xTgsLRvunsienMyZM9Fo/E8MPtu6?=
 =?us-ascii?Q?vsvICcOmzfiCqfnACu5MVnsztbHY2nx5dVXYzMSj+F1OTnK1UNUl7Kwe06P1?=
 =?us-ascii?Q?uSozMf3JxM5i6NZG2zWLEZZJl/RHgJQIRQStr9TH4FgCREBFOnt4zkRE2I8U?=
 =?us-ascii?Q?Y08CKec1eQJG3uLN7hjIOV4M/ctFMG2KQ1XWFE+qrw0Ko3mHuQk9cDdlR75D?=
 =?us-ascii?Q?lko19yoVC6QMfGFtzsePT5lGMWH9JL4kSQugHog+cBIz0rf4qHB9JHb7u0hV?=
 =?us-ascii?Q?OuucofFG3DzaH7ZR6toeNE7KK2JkjqXPcWC7JGwbRT+K212g6rWC35Ax9gs8?=
 =?us-ascii?Q?0LcOA+9D/1gnoBu+JLwHByIEo5lRyWTqxugrNGitwRHzA4p1KqYkHDnxrPIP?=
 =?us-ascii?Q?rqJ5Gq5sM/JLaVn4+NChhxCb9gxTZNFIgyEClotP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc30f8c-3ffc-44b3-c469-08dcb7c2f610
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 15:58:36.0464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLVBwFy4Ec7KWzVRf33hKVeyf25khCPyeSar0bIk+VnlvLT8F9qBNILfuSrbYQrYqYs96IP+MGBQqZDcv0ejuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11001

On Thu, Aug 08, 2024 at 05:52:23PM +0200, Kirill Yatsenko wrote:
> With the CONFIG_SLUB_DEBUG_ON enabled the unhandled fault error appears
> when unbinding the driver.
>
> The spi controller driver memory is freed inside the spi_imx_remove prior
> to executing PM callbacks thus leading to use-after-free.
>
> Fix it by switching to the devm version of spi_register_controller.
>
> Unhandled fault: alignment exception (0x001) at 0x6b6b6c53
> [6b6b6c53] *pgd=00000000
> Internal error: : 1 [#1] PREEMPT SMP ARM
> Modules linked in:
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
>
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
>
> Call trace:
>  __pm_runtime_resume from spi_imx_remove+0x1c/0xa8
>  spi_imx_remove from platform_remove+0x20/0x5c
>  platform_remove from device_release_driver_internal+0x184/0x1f0
>  device_release_driver_internal from unbind_store+0x54/0x90
>  unbind_store from kernfs_fop_write_iter+0xfc/0x1e8
>  kernfs_fop_write_iter from vfs_write+0x25c/0x450
>  vfs_write from ksys_write+0x70/0xf0
>  ksys_write from ret_fast_syscall+0x0/0x54
>
> Fixes: 307c897db762 ("spi: spi-imx: replace struct spi_imx_data::bitbang by pointer to struct spi_controller")
> Signed-off-by: Kirill Yatsenko <kirill.yatsenko@camlingroup.com>

Avoid send v2 with v1 message id in future, it should be new email thread.

Reviewed-by: Frank Li <Frank.Li@nxp.com>


> ---
> Changes in v2:
>             Shorter Kernel oops message
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

