Return-Path: <linux-spi+bounces-7749-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C92A8A9BA77
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 00:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4A84C03C2
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 22:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187071FDD;
	Thu, 24 Apr 2025 22:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BWVVYF3j"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828C128467A;
	Thu, 24 Apr 2025 22:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745532782; cv=fail; b=Hb7ln/N7mKh5oiM5JalCaRHu+MD2l4jJ24N/fHDysb073i3LtOdvrVdtG9hxxHAo8fAsm3rM/bIFty13DZoFHTyuTcBnsY7l+f1PJEkuBIaG4lv3kGJp929SK3NX4FKDUC12xPOK/tX5J3+L9wxxP/y2zEqTs4S1sMD3jqaXmHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745532782; c=relaxed/simple;
	bh=4YaFwBuaNISTelYOFls9cOggcte9vhJIgWIhkkV/ZGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mpj6Td0CwZGNPMmbwlbIVQY2t0vc9cQ+HfdFPR8usNDx142sR7VtJsjS9EmLU4pvDr8fAY2d2V+S6LTfPwHLdnJJq6cpBg4HIl1p6tTwRrqMB7V3f9ACBFPualU9WKGdEW/2mGP9DCxeGK6zsvQh7ffGt0WVKy/PFU8xftPFsb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BWVVYF3j; arc=fail smtp.client-ip=40.107.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxOrIlRgCWRh/p0dlXfbM68I9UFFiFzEJx/m6Vqt9BmGhzOs/oXr+2r2btdLmBvoj+8kyBo+G15ulhU6HfVsQEEsA7H2U6O/HyiX7yz1Dn/o3trQVpAfGwXRKwwYzA87I+rKeK+4sTuluq59BMDMGAjYHGeYKZsYNeYOUqnCbzrjhYGFMLhH7xtS/PPPDdtyrg5M4zgzNApHXU86AMldNQPJXf6IBzVsaVmgtnoE+gPTnbSdiqcNBMOnHbmaync4J4i1uTy+EgcIUxiB/dAexv3z8SeFBpFAizjW7C9w7bl9Lwha2ZDxAlr+2ASRD9KzRoWVJI9+HUn7ypDs6P8xEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WRiFTAhgR505F7vD9QZZySO0lZkaHfh97PrfSue90A=;
 b=DEPklD2a9JjTgHN0h7drQgLsWr/vpkAOGYle63QSa4GGlwms3JaP/FozLAcwBMNl4EnjUsbIYZY78bDSo2Q7/1aYOFa+gFnniQpfAJPD8Oir4XKwrU7Ut5b65sXg48qJNtj0JXTChFmX81vRZPAjHwXpukdDC+VhGCketFCTewPnxFpd1uLhP5elEqwX/1aZhHX5wlhz6u28pcOVu2NOGfazayAytuk8ZlP32SrzRcj2yniKQqlBfrhOtjPNX6O/IoBVaHKsuNnxiNNl0i1jCdvr5zEnkpgU4dWfAXSog/53w0hLJmmjIkPpZqvZXr5BgbWRBZoh4cwJ/YZtQBazPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WRiFTAhgR505F7vD9QZZySO0lZkaHfh97PrfSue90A=;
 b=BWVVYF3j7622yIhP7Z+9tXKE919psqv6V/R/KJoub73GiQmqFEFz5PdGQJ7HmQHM3EN3CHUWHEBkEOCo7zZCZrv9b1AGVMoN/rMudfr5/XYDSMhFPSHv+tnxN69oNYiR7Qhh2Wl5oGFkYd31OJmZoYflBa8JcZ1l1OpeEnGS/7NR0FOCOJ1vIXyqq6glBvkF641lrCHGWdQ/5Z0TxQ99nMapquusaYDeY+1A2MxOrst2TFebklAd4LXeoKDtu2Cna/LX3/x8JFL8LxU1Qv1IvaBYbKqersr1sBOpVHsdzKQaWemWuzAWOSgpGau2J7JdkJW7LajjoWD+iAxQGMe6Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by GVXPR04MB10304.eurprd04.prod.outlook.com (2603:10a6:150:1e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.25; Thu, 24 Apr
 2025 22:12:56 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58%3]) with mapi id 15.20.8678.025; Thu, 24 Apr 2025
 22:12:55 +0000
Date: Thu, 24 Apr 2025 17:12:48 -0500
From: Han Xu <han.xu@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Yogesh Gaur <yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] spi: spi-nxp-fspi: enable runtime pm for fspi
Message-ID: <20250424221248.pmhi3eixqbjgpr4o@cozumel>
References: <20250424-flexspipatch-v2-0-e9eb643e2286@nxp.com>
 <20250424-flexspipatch-v2-2-e9eb643e2286@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424-flexspipatch-v2-2-e9eb643e2286@nxp.com>
X-ClientProxiedBy: BYAPR07CA0104.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::45) To PAXPR04MB9073.eurprd04.prod.outlook.com
 (2603:10a6:102:225::21)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|GVXPR04MB10304:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e7a419-bb00-49d1-6a9b-08dd837d298a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TzGBybw4TFBy4W0BLCnHU5OULFc/OH4IMZg8fLMS8AH/bYWgca/Sfyfqy6P3?=
 =?us-ascii?Q?7iBPITtvDv4npv+vrztt/q8R4v4hC80Cn62fVMvL3equc6TxInBnekjam1ar?=
 =?us-ascii?Q?bk0nYvGOk2NpHdeBzB+FhrtYt0QHmjq+OOTWeRBroQ3vmJcizJfIuYozebXW?=
 =?us-ascii?Q?liECod5NqN6mBpa9p0Z7pauYBGZDUVdXdl9zlwgGrGphbiW5RTySiLfOL8mX?=
 =?us-ascii?Q?1ee0jRpdJsuMQ0stoQ0i0HI+PkrUe5H6QXxjLBMDAmqOhqRj37CePq/mrTPz?=
 =?us-ascii?Q?bLLIFfrv6yzB2IqcchV0FQqBlksSLCUcOF1tV+z0qLDZLovw6tKEqGBHF3rF?=
 =?us-ascii?Q?N2Au/YX6nozMhX+UItY5Kx5kIzlIETBGb9bFF4cT5s5btkhGVXtUT/lts+rM?=
 =?us-ascii?Q?gF225WTweVitGDMjGiGqom5I5ioqP5vX4GZpmeFWZpMVuhPyfnohppTDng+N?=
 =?us-ascii?Q?glhsqHZeyT9xpDAVues9IUPO4IAK13AZbI2uG7m1IaZjcTbqpw3l6QePchvE?=
 =?us-ascii?Q?uSxyht7O0ynlAa+Z4wzJ4pWPSL2Ks+Tc0rRYmMR9nQg3HRo32iP2edcnGTQ8?=
 =?us-ascii?Q?gLlpSC11ch9zEmbZOGIOWUeUarIshx9K5DT2GiBxR3rSJhsjLf2Y+SGqkFD3?=
 =?us-ascii?Q?jtdpb7qx0zxp4PNGXXU5Doi5p3U2i12xcXHfod7Fmacmiom2iW/mX5dpjM0U?=
 =?us-ascii?Q?7I9ue4Q28uMC4xpXy3SABwKBJwnsipRCl/4fU/njsYNe+mUT++Ss2z17mZWl?=
 =?us-ascii?Q?5jmBCQoO04FimD/ioN/zBqWsZ0/ph71VERbw2myEFOzAy4eC2EOPK8jFY/L+?=
 =?us-ascii?Q?cv1PbEOZeLg6WjUWLOacwJyQcS4juaXcFgNa5zHz37NCX2s7o71i1MVhniq9?=
 =?us-ascii?Q?WshJoyMIUb2MOzEHT9u+OJ2rgrRuDp+csmCLzrVqxoz/J4XIJcHMi/ReOHax?=
 =?us-ascii?Q?Md9DW6am7DPFLGNIC10hp1q4PjNCqH3GsPP/17vvR0/AZrzq5Mste66dEkJk?=
 =?us-ascii?Q?Bev8VCTKWonLwYaeTtlepbT5mGVTpZRuGfOT+B3obhsKzMpbcxdbdGQJwq1S?=
 =?us-ascii?Q?cnOhp1o1XUT8vyZ3NTUGjixuSq6fSVpmd7KG0uTI1//TT42excoIJzllliKA?=
 =?us-ascii?Q?4UYj7fdkabORLzwnBcUhJeAjjqO+alXC+ykqpTcQcvPHk5Ne5lFA+LDt2bkV?=
 =?us-ascii?Q?1Doc5+J31KVJOSYi/uYWeP2qkd0ePeJPDoGmS2HvXecE+z9HyExx73TH/wMD?=
 =?us-ascii?Q?IBB+oZQKT+pQavoQ1d++vX9TaILP3xcJYfwOdxlj/yGiACkwjEDy2PkxOdDX?=
 =?us-ascii?Q?edT/13di5wcJgsRXdvOywHNQnbgFUFIBn56OwBMbIAFavVZpagocm3ewY5KE?=
 =?us-ascii?Q?z8btYWB0UBWgQyNHNaCqbLOVcEthySYwn4fmiyG8IO17ASJvdGu3AF4CyYOm?=
 =?us-ascii?Q?NII73pbEQ2vFkx6WJr6lGa2Ili4GOjf0Dge3oZpQ2ZzH1w5X8qFRqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kv4A8iLVtjQTgW+FiJoSFToqDcROCbwRfdSbHFlH+pGSWju2hAHh7FgMHddL?=
 =?us-ascii?Q?mEC+Qfreqi3gMV0lnjYbzTn+zyQlKQ3AEudBk8YxCtoMONfaUjwnOVDHVXUh?=
 =?us-ascii?Q?V9CStErw1AxyHxrF2UYcHGYU6qYgsbBLaFqQVTXKHkAk3TDPrreVruzMgOh4?=
 =?us-ascii?Q?/MyP1MyIl67IKZ/vOnrQq0nh04x4GlGbw0P3URCUaWOZ2STe9hsgnV5l7wLI?=
 =?us-ascii?Q?y0z0woA0alzXf9hTIVWJQr9GcOFP1SJD8vFxj9BWVDiburowRkbn25LbGcgm?=
 =?us-ascii?Q?OkfLVH+Rp6naUbDBygTIDIh1kP7ozRQwm33+635WaaN4chPVvYyNEur17Cj9?=
 =?us-ascii?Q?WUyKjTrkf6aMhQNeLWmw4oZe96Mruem7o8qTbCwZeSZajmBBuLf8KT5pJ/pm?=
 =?us-ascii?Q?6kztcqOuOPbCFPG9bnh30mhZz4uVx37r9/8hftoPsJ5bhoyqLBK6Q/dk0PFL?=
 =?us-ascii?Q?iA8CEe2ZHEYMTyCJ0nju7TFJvNXcLWq6AMKzuWyeIL5/MWi+QQ3D4qWvPvaK?=
 =?us-ascii?Q?Oy1/DeWC1EBiQ8mGXbG0f50RqV8uO4GY/Zm+0fISvHZ8DyOW7ElfdjCccKpc?=
 =?us-ascii?Q?UqtCdDQ2GUTXBtJp79TS2bBu19iTn3jSMUlc3iVc7VlYiqrBnJEKRwxS0HiS?=
 =?us-ascii?Q?LzIo0WUTciq7VlHQr2Mdz+1F2weFQG9lzEKuaQIT+uTSGU9PDl+69XkKF9XT?=
 =?us-ascii?Q?WAABA9lnNRJz4IxfBQqQklS+TUAlikQJlXq08WWXwAmY2WffVhFgGsY0FjXT?=
 =?us-ascii?Q?NhTtxezLxuLU8qMKRckHCbwa65ok0b6Cahy6ETgfuOn6qHVAJnF6aEvr2QaT?=
 =?us-ascii?Q?v2kl87JfYKufszq1wWcs92RHm/Rvw3+QzwLbaOT/yRCS7jXkZAgNfpBsdEPy?=
 =?us-ascii?Q?tSjRMHB8L03HJhjiPY6Nfd/kcs/FJ68RJ4ecKIPlrbzlvI62h5lQF8jT5dbn?=
 =?us-ascii?Q?pc1VCC2WYe6WzicNY5ZmWHzg4qyPFf73IJI1o2aTfgS/nA3B/my9IhYlgBr6?=
 =?us-ascii?Q?Czzbbc2nvPRdmDZ665/CnFgoO4pw+ExVnO9Z7s5nT6PTdhdOcEziLBZIsRGw?=
 =?us-ascii?Q?sL6nzHpBuLHFngC8bYYlnx6WcIC/a6fSSdZPfRN/IaMgM9JVTWndEdJRPXDL?=
 =?us-ascii?Q?VMMcgdsxrl7F/imkwJGnJ2x90y4QnGKjKBzxxbfs6kEqzuPxN0+Aom/umbQn?=
 =?us-ascii?Q?dBkxA5VJpEOyzF9jEYEaYKPkPviCKbDcUvw+PxqW1PcLZ/jzi2ssrY/8NDiY?=
 =?us-ascii?Q?Y2/xbqbPWTM5souTBE7qH4JKUX4Z1R+cC5xZ60s7b63jup8P6WdKWUY8PkRB?=
 =?us-ascii?Q?X5eCeC0s+foroUf9woVaR8urayFitEtvxi2UwF5pAiXQj5qkaCXnoLX86QHS?=
 =?us-ascii?Q?s4w81f+05mZdNPbeFDCDclh8vpKYlZkWXYl7ErIfCg42XSEayzS2YCu3Qu5A?=
 =?us-ascii?Q?nHEexZILZLLs9cn/jADJ6g0hqN2R/6tjPHTvD34gTsXrfyoalWJxwKpVuzHa?=
 =?us-ascii?Q?RsPg129ZvNX2q+OPdagOxxQgHy7F579gq2/IeG2oWGfn5P2ZcgdNrakjP4wX?=
 =?us-ascii?Q?0+4SChe5/7UfQaDANhxJrt1rTAZp4f5WpmNBhinh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e7a419-bb00-49d1-6a9b-08dd837d298a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 22:12:55.7967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CEl6tD7wFpOlysVSCv+E5Kx6+uZ7bl+WE2d4Qzu3msBPhkTsgBM/Hy+iv3XH9QVQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10304

On 25/04/24 03:33PM, Haibo Chen wrote:
> Enable the runtime PM in fspi driver.
> Also for system PM, On some board like i.MX8ULP-EVK board,
> after system suspend, IOMUX module will lost power, so all
> the pinctrl setting will lost when system resume back, need
> driver to save/restore the pinctrl setting.
> 
> Signed-off-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/spi/spi-nxp-fspi.c | 95 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 79 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index 00da184be88a026bf562c9808e18e2335a0959e9..438a9c103c5969bcae06b4e02d98397ffdcaa345 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -48,6 +48,8 @@
>  #include <linux/mutex.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/pm_qos.h>
>  #include <linux/regmap.h>
>  #include <linux/sizes.h>
> @@ -57,6 +59,9 @@
>  #include <linux/spi/spi.h>
>  #include <linux/spi/spi-mem.h>
>  
> +/* runtime pm timeout */
> +#define FSPI_RPM_TIMEOUT 50	/* 50ms */
> +
>  /* Registers used by the driver */
>  #define FSPI_MCR0			0x00
>  #define FSPI_MCR0_AHB_TIMEOUT(x)	((x) << 24)
> @@ -394,6 +399,8 @@ struct nxp_fspi {
>  	struct mutex lock;
>  	struct pm_qos_request pm_qos_req;
>  	int selected;
> +#define FSPI_NEED_INIT		(1 << 0)
> +	int flags;
>  };
>  
>  static inline int needs_ip_only(struct nxp_fspi *f)
> @@ -927,6 +934,13 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  
>  	mutex_lock(&f->lock);
>  
> +	err = pm_runtime_get_sync(f->dev);
> +	if (err < 0) {
> +		mutex_unlock(&f->lock);
> +		dev_err(f->dev, "Failed to enable clock %d\n", __LINE__);
> +		return err;
> +	}
> +
>  	/* Wait for controller being ready. */
>  	err = fspi_readl_poll_tout(f, f->iobase + FSPI_STS0,
>  				   FSPI_STS0_ARB_IDLE, 1, POLL_TOUT, true);
> @@ -955,8 +969,10 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  	/* Invalidate the data in the AHB buffer. */
>  	nxp_fspi_invalid(f);
>  
> -	mutex_unlock(&f->lock);
> +	pm_runtime_mark_last_busy(f->dev);
> +	pm_runtime_put_autosuspend(f->dev);
>  
> +	mutex_unlock(&f->lock);
>  	return err;
>  }
>  
> @@ -1216,9 +1232,14 @@ static int nxp_fspi_probe(struct platform_device *pdev)
>  	if (irq < 0)
>  		return dev_err_probe(dev, irq, "Failed to get irq source");
>  
> -	ret = nxp_fspi_clk_prep_enable(f);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "Can't enable the clock\n");
> +	pm_runtime_enable(dev);
> +	pm_runtime_set_autosuspend_delay(dev, FSPI_RPM_TIMEOUT);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	/* enable clock */
> +	ret = pm_runtime_get_sync(f->dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to enable clock");
>  
>  	/* Clear potential interrupts */
>  	reg = fspi_readl(f, f->iobase + FSPI_INTR);
> @@ -1227,12 +1248,14 @@ static int nxp_fspi_probe(struct platform_device *pdev)
>  
>  	nxp_fspi_default_setup(f);
>  
> +	ret = pm_runtime_put_sync(dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to disable clock");
> +
>  	ret = devm_request_irq(dev, irq,
>  			nxp_fspi_irq_handler, 0, pdev->name, f);
> -	if (ret) {
> -		nxp_fspi_clk_disable_unprep(f);
> +	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to request irq\n");
> -	}
>  
>  	devm_mutex_init(dev, &f->lock);
>  
> @@ -1249,28 +1272,73 @@ static void nxp_fspi_remove(struct platform_device *pdev)
>  {
>  	struct nxp_fspi *f = platform_get_drvdata(pdev);
>  
> +	/* enable clock first since there is reigster access */
> +	pm_runtime_get_sync(f->dev);
> +
>  	/* disable the hardware */
>  	fspi_writel(f, FSPI_MCR0_MDIS, f->iobase + FSPI_MCR0);
>  
> +	pm_runtime_disable(f->dev);
> +	pm_runtime_put_noidle(f->dev);
>  	nxp_fspi_clk_disable_unprep(f);
>  
>  	if (f->ahb_addr)
>  		iounmap(f->ahb_addr);
>  }
>  
> -static int nxp_fspi_suspend(struct device *dev)
> +#ifdef CONFIG_PM
> +static int nxp_fspi_runtime_suspend(struct device *dev)
>  {
> +	struct nxp_fspi *f = dev_get_drvdata(dev);
> +
> +	nxp_fspi_clk_disable_unprep(f);
> +
>  	return 0;
>  }
>  
> -static int nxp_fspi_resume(struct device *dev)
> +static int nxp_fspi_runtime_resume(struct device *dev)
>  {
>  	struct nxp_fspi *f = dev_get_drvdata(dev);
> +	int ret;
>  
> -	nxp_fspi_default_setup(f);
> +	ret = nxp_fspi_clk_prep_enable(f);
> +	if (ret)
> +		return ret;
>  
> -	return 0;
> +	if (f->flags & FSPI_NEED_INIT) {
> +		nxp_fspi_default_setup(f);
> +		ret = pinctrl_pm_select_default_state(dev);
> +		if (ret)
> +			dev_err(dev, "select flexspi default pinctrl failed!\n");
> +		f->flags &= ~FSPI_NEED_INIT;
> +	}
> +
> +	return ret;
>  }
> +#endif	/* CONFIG_PM */
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int nxp_fspi_suspend(struct device *dev)
> +{
> +	struct nxp_fspi *f = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = pinctrl_pm_select_sleep_state(dev);
> +	if (ret) {
> +		dev_err(dev, "select flexspi sleep pinctrl failed!\n");
> +		return ret;
> +	}
> +
> +	f->flags |= FSPI_NEED_INIT;
> +
> +	return pm_runtime_force_suspend(dev);
> +}
> +#endif	/* CONFIG_PM_SLEEP */
> +
> +static const struct dev_pm_ops nxp_fspi_pm_ops = {
> +	SET_RUNTIME_PM_OPS(nxp_fspi_runtime_suspend, nxp_fspi_runtime_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(nxp_fspi_suspend, pm_runtime_force_resume)
> +};

We can use the newer RUNTIME_PM_OPS()/SYSTEM_SLEEP_PM_OPS() alternatives.

>  
>  static const struct of_device_id nxp_fspi_dt_ids[] = {
>  	{ .compatible = "nxp,lx2160a-fspi", .data = (void *)&lx2160a_data, },
> @@ -1291,11 +1359,6 @@ static const struct acpi_device_id nxp_fspi_acpi_ids[] = {
>  MODULE_DEVICE_TABLE(acpi, nxp_fspi_acpi_ids);
>  #endif
>  
> -static const struct dev_pm_ops nxp_fspi_pm_ops = {
> -	.suspend	= nxp_fspi_suspend,
> -	.resume		= nxp_fspi_resume,
> -};
> -
>  static struct platform_driver nxp_fspi_driver = {
>  	.driver = {
>  		.name	= "nxp-fspi",
> 
> -- 
> 2.34.1
> 

