Return-Path: <linux-spi+bounces-4677-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F2C96DD1F
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 17:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2561F23073
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 15:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980CB16F839;
	Thu,  5 Sep 2024 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iEeAaE9q"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011046.outbound.protection.outlook.com [52.101.70.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE70843169;
	Thu,  5 Sep 2024 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548542; cv=fail; b=o66uQJiG4MlOh/mGbDZV39ybtObclZHumMTPVrp/IFzw+NNC0Zd4fNTfJnRAOUodK82AdTFlKICQkb6CxpZlGgBLr66SUIwpDEz1mR7XbopZ1P2QwZHmaXedysxUlxOZ3PRUhyXd12uiiDP7VrLe7tiYB4KMz4VEkTOCckkl0SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548542; c=relaxed/simple;
	bh=NK8A32pwthwjh8lkuKisnh6K74oqNPtWkl/MlhLzdkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s/Dm7ov+lYGFn+vKiLwY1aHfIq/bnaKbL8nlBTm8Z+0K8jvyFNEudUJbgD8HgFOTpbwvOho9rGV0R8tn7btlFToTvA0qDSNJzbX8yrMpo3WFu8z3LKhqU8zSt6Iomsm9bwjk6ods4C5lM97VMKelkeEAQ2+7cSLJzUNQJrSb44I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iEeAaE9q; arc=fail smtp.client-ip=52.101.70.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzwQzQ3YlOnrdXJjmb+obvx9E4JCZtklAu6pPwEIMvS/deBGH4+hDcNfVRXeg1TRDaRcDo7KFzs2tAFFj370zbPqGBrrdWi5xH8FRoQ2ZcLRhX71qkNC50kVsTNSTyPFTDG6aWfOrKRiSRj9TVg80ZSA4qnW1v/ayuzYtm9m7xBQI5hA70htpRpdyYbPAva8F4bre+PTo0w75N1RtVRjCTiRx7SDNVpuEMY6/wNCbweUzUE3U/8OZJ0xuzN9wsXwdxnTvO3rwMeew/WqgL+crMXAjplIe9MU7Ig+UJk8KKGA+z1pcH+yn4n6ZxyfbLzrD+blKBIV9mH3NPAS0H32hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXE/a5yf6VJQ6nVdUGpTf0BEf0TbgxZ/9Mr0VDWyeJY=;
 b=NxWQ0JrqtacPfoo52CJ1bvLCfgaSzhaMHkIdLvi5DnzvtQXfjvTPh8a6nSh0r4NKgMr5k+WMA45zDBNIiUWZtPVeeNcNSW7fSMzT/IcunHlOFgT9ThPWomJ/E81Yi1+vCQFjEtJp2kqc1T9kZzmO1RfwKSYk+wGid2pK0ii+k1c6iJJocapsZjDoQuD7wYKKtO/v61OGbwyIP+JrTDpY6LEel40XyrZ1k8N2x6ZDYh6+Jtsb3bUvTVda8eAsV7HmB3rIsmWi1hopovHulj70tJzebQBrnKne148rW9fXbZtva2uQjxk4io5+g5yWW8lgL/1eSNQSoHJ8f/XSGEb1aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXE/a5yf6VJQ6nVdUGpTf0BEf0TbgxZ/9Mr0VDWyeJY=;
 b=iEeAaE9qq1y/4bxx/Y4LiqXlfaDI7gXlKMNInj+GYlSayQgh2bcChIU1IjExXk1bqGpjfmmZYjXRGNG7DusDSAjsktJLqH3YtOSMjpXL71iIcZTWy5SzCDXVfctn5C1vVNmFqGKSBcGWxnozeLo8ER5bgmI8B6nlT4IXISxSeX3jXpmambDU/QpspsNvHynF6IWSygJnEoWQJPoxG8ClOxiVghoLJ13Zgn7g6eIlx+NvSUK+GrqsiZGL3Vk7xJn12BrS91Xtni0mzRwg1mpzo+1NpAvRKORrxBXyU/GQzD8KV7qZfeAQmCD19NuXdSZq8GbDOvvMcc9CBJaO/2kjVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9888.eurprd04.prod.outlook.com (2603:10a6:102:385::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 15:02:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 15:02:17 +0000
Date: Thu, 5 Sep 2024 11:02:07 -0400
From: Frank Li <Frank.li@nxp.com>
To: haibo.chen@nxp.com
Cc: han.xu@nxp.com, yogeshgaur.83@gmail.com, broonie@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, singh.kuldeep87k@gmail.com, hs@denx.de,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, peng.fan@nxp.com,
	stable@kernel.org
Subject: Re: [PATCH v3 3/4] spi: fspi: add support for imx8ulp
Message-ID: <ZtnH77FdwP85fY/M@lizhi-Precision-Tower-5810>
References: <20240905094338.1986871-1-haibo.chen@nxp.com>
 <20240905094338.1986871-4-haibo.chen@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905094338.1986871-4-haibo.chen@nxp.com>
X-ClientProxiedBy: BYAPR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9888:EE_
X-MS-Office365-Filtering-Correlation-Id: fea950d8-5423-4cc6-2bd7-08dccdbbbbde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9f3783WHIOSeYgsTxVbubIIwRTvsmk2b3vNDCPee1n/6SDNYqHv1N/jUteHx?=
 =?us-ascii?Q?t66M8hiou1vv2cIWEW6gnEhxwJG/3niue96ehImSkQJfsZGvtIlF3ufDYPO5?=
 =?us-ascii?Q?WuHdsvOt/VdyY6cm81k6mrpnwY43Yi4f/sYi5EAUIQdPLklQKaZtIj1ZqTvq?=
 =?us-ascii?Q?k/bguzkg+khOXRFWMD81VCfmsep4WXzVDwYjhUeUqDXefHZIe6AM55joZHWi?=
 =?us-ascii?Q?pJZJLHib9iuirc4TBK68CY2PLOOJwW+eJYXLUViME2/vow158QmfQJF4vCf4?=
 =?us-ascii?Q?MBxd8XHA1ljbKPzAUipWzOzoJ67RID6XP2/7L4MfX6fTZjo2ZRNjHvzmUyNC?=
 =?us-ascii?Q?0Dn08xA+gDA0cdwmq3x9VHZTL0KLXZLIvj9Lxw30VJGQQAJ+IYdIc01PI0H9?=
 =?us-ascii?Q?xsqfRE7mAZi3WVf2j3s4VWkkpdoE02ER9wqATRxqldNkkgoh/X3U9MuikNRO?=
 =?us-ascii?Q?sieRJhH8adVSiZofXQlWhTV/MW14MytkLvYbaev1YDU9PoV1lt+FAaJNsA9u?=
 =?us-ascii?Q?bIdZmv0mCFyAbESjsFUX9qfouPv0j2c9cdj89UezGOFa69CONX0Aw4yU9at8?=
 =?us-ascii?Q?MTWdUXXcCn+UEfXE8KUj8q7Kh0ECVqWkycF7SaAF5oNR0oA/9ECJSZw7JJcj?=
 =?us-ascii?Q?tXGZ+qmGic2hQUPA53DI1UYEDnNW7QSbyKoMKGf+UkZPSYzjuGvxSJG7P599?=
 =?us-ascii?Q?fPCx7KBsePJ4akrcKShKhcK2jhesqV6tlmUCuQZVUYp0TR4OUnu6WopuZFxg?=
 =?us-ascii?Q?ThjaGlWeUD7FLe2x8sGaT519u1UJFnjFIAQINQbLJDlquS8wKKt5iQtv/Dzj?=
 =?us-ascii?Q?WZvprIT8Z5yC/PPY1Hvhluo+BvoxOLMADQfe0uxAPUp4N9dJd3Ekoygopivh?=
 =?us-ascii?Q?AegezBxA4oHoRn0cg+FStYCEfzgZVeKXqF5gPklogXKNenJthj76zse1i3gC?=
 =?us-ascii?Q?MWhlLNAE3SRp3Pz6uI3361gnsKO8AUIBPVa2jh5yhJm4k2yLD7kh5ymbEirg?=
 =?us-ascii?Q?Qf4buwb6vpxtNieXgUAbND/3eSgkZ1kRjVkjDhFTGPSUFK1+snZE6eMJu3D8?=
 =?us-ascii?Q?AyENsxTsNF1wwnpwfl9vsGZv+Uo39hp1vknznn121L+qD62md6ePPuQZA60V?=
 =?us-ascii?Q?B2H8hzm9/zsnsvcyI5Mz08Dq9628OvQ/UGBzbkkwu182p2JSqR3ENd8ox7s/?=
 =?us-ascii?Q?5Lwi732evOD447xnfSuNVHMwRETAUVsV4/w6Exlkkfm0zB+VllraWQviwhrJ?=
 =?us-ascii?Q?fBp5nkYWr0wANkfczArk2hYmFlyJ2HZLpZS85YUwnyNirsFg0FKCO47CUN84?=
 =?us-ascii?Q?3Qd8i+GPxiUJh9bhWvlZEKkvd79YZmdSLfprsxwY1UFfXEszZAaJUWoZlHpB?=
 =?us-ascii?Q?5a63K9fhbCuYvN4wS9hLnna1n5kS9ivnBYtEnu1js5dRuHztPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EFwpQgxWPqJyBlXoRgMIQzZLxLE7kf/1PxK0LdUzpZVVvervkedKdptyMbDI?=
 =?us-ascii?Q?3PXKceWtf4W654sTxN+W7MuWz14Z65TC7DbK8tzfwDd0gwGrxCKI1tJORZNb?=
 =?us-ascii?Q?PMhwMvml+f6MDmZnEKDokak2N3JCmwhwAiYITDrOSHsNW4ioKf8m8RqjSQvr?=
 =?us-ascii?Q?dmZKZz5Fp4GRsjj16mdEF47c4C3Q8PRFQuzzQSeMoan5PQACgO9/CgPixE62?=
 =?us-ascii?Q?cR898PDZwDIkB5i6rexE8kgxC8+gjWhCvSKtzzr9YDjzPkdPuPBobPAmhkNE?=
 =?us-ascii?Q?qiVs6BbmGNOk/ZAJRx+UR56wpSz5kcVqwZDrmL1q21AfnrY36ChVT/2BNrIK?=
 =?us-ascii?Q?NX2OE8aqWW10tvIP7yPiRC8XijPgdpCDA5Njoxs3Y6M3Ptzw3Mdo9CknRHw4?=
 =?us-ascii?Q?JMg6H9nGzypMVFs7YVB7MIlMmG90zUBf1ViY/oR14s/Lodn/U83EqNt04xIX?=
 =?us-ascii?Q?BSPs78zRxwnsS26NeDSlpohbe/MI5yKAY28vK+xp7RD7ubXGRf+AHMbhO5Pl?=
 =?us-ascii?Q?j/k5mI3EjZyxGFb+yr38rIlN3jmJEJ4KAT/gGukMz0rfb8tKEyETRwXh+bhz?=
 =?us-ascii?Q?6NiW3GSvI7566AFwhEKDmGlOeTp3+iiaQP9eV9uT8x0awt6UDLMDnJBvTiV2?=
 =?us-ascii?Q?EAURxx0rCL3Gi6Nt2MbIf0FZKjNUD5xe7dQM8uQ3Q3EELF9O3Bqu4OXb9xp/?=
 =?us-ascii?Q?RyefIRZBI2s3Rrom/qGGeJzNRUN9BVJwkPoQmvDsvgxmEgR4zTab9oSnAsQp?=
 =?us-ascii?Q?6f/bllSHRIB9Ap96aGP94PvQIM0zHlBo+ZGMSdFG5rrNmYkYsbJMSIOkMZPk?=
 =?us-ascii?Q?Z6q1azagKyylsqw271NaN3eqxI9Fyl/Pq3VcmogOD+lKONayK1OdBPKQE3uL?=
 =?us-ascii?Q?K/MHEYiNsI4R+gmZQ1u4xz4m9AzK7bUlYZ2ycPEqhEegvC01ibpOrzQvprhE?=
 =?us-ascii?Q?cC2gOlfIfRgjK+NWN8souJ0wqrzd3RZBdEYAPuR7cg1eSKA2+ZfhLCqzD4So?=
 =?us-ascii?Q?G1T2Ozd9WVGKyXIrdHrG+np5Nh6axkMMwrrVWCRP/z8JZken0MdFyxzRnCh/?=
 =?us-ascii?Q?016SakXILFJYhDhIBnEP6siWK6m4QlWGCPLuawRGg16F6GlJR91p5oIn4LkW?=
 =?us-ascii?Q?U/tdzBY5K93RcHtxUb3BuU5m99qFx1tRS0AZ4tb9JM7ZYBAPJTjLy8xcqjzd?=
 =?us-ascii?Q?FlZGISzxAFhV74VRcFyjE/5JVnz56fXtuBQ7iO5jOVX/MOxNl1WNKjiChoxO?=
 =?us-ascii?Q?Gx8SoPacDxqXo7LsWiTXMSRxEYqWEP5LX3v85BIL0CnL9RXFu57GWDvICB7m?=
 =?us-ascii?Q?GSouFdOtOGWeoIUFmKyi/EGNqi1FEjLT7tTtDMMbsWVVwx0RdpywUzBYvBN6?=
 =?us-ascii?Q?x2aWI1k+O09H0QYK16BwvipBY+EWSCQsKAs0iLqE3ML6Uw6eedSO8kJzpWTj?=
 =?us-ascii?Q?XnyEWy9sXFviM3KCS3r420WT71pKmziiMJUueaEqMWFqpsTQgWBZfH90wmwJ?=
 =?us-ascii?Q?fkknRP/gGBkk5Y06q0ZvFBE0ryh2HPYMwnJhfGwPPtA17ksceXyhQaZTByQo?=
 =?us-ascii?Q?7tKLIPbAfFN5xL27RjYFbYJB5c8QBC+ylifgoBkI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea950d8-5423-4cc6-2bd7-08dccdbbbbde
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:02:17.6838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BtqTTVm+XyuB9vw7XXauMdUhCPg4D5rrL0lHiKRLyPVhwI4zMOQ+XLY8uiNhGZVmdYLUG0+CrfpuZgHqvvvl9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9888

On Thu, Sep 05, 2024 at 05:43:37PM +0800, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>
> The flexspi on imx8ulp only has 16 LUTs, different with others which
> have up to 32 LUTs.
>
> Add a separate compatible string and nxp_fspi_devtype_data to support
> flexspi on imx8ulp.
>
> Fixes: ef89fd56bdfc ("arm64: dts: imx8ulp: add flexspi node")
> Cc: stable@kernel.org
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/spi/spi-nxp-fspi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index f42c14d80289..69e427b1903b 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -371,6 +371,15 @@ static struct nxp_fspi_devtype_data imx8dxl_data = {
>  	.little_endian = true,  /* little-endian    */
>  };
>
> +static struct nxp_fspi_devtype_data imx8ulp_data = {
> +	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
> +	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
> +	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
> +	.quirks = 0,
> +	.lut_num = 16,
> +	.little_endian = true,  /* little-endian    */
> +};
> +
>  struct nxp_fspi {
>  	void __iomem *iobase;
>  	void __iomem *ahb_addr;
> @@ -1295,6 +1304,7 @@ static const struct of_device_id nxp_fspi_dt_ids[] = {
>  	{ .compatible = "nxp,imx8mp-fspi", .data = (void *)&imx8mm_data, },
>  	{ .compatible = "nxp,imx8qxp-fspi", .data = (void *)&imx8qxp_data, },
>  	{ .compatible = "nxp,imx8dxl-fspi", .data = (void *)&imx8dxl_data, },
> +	{ .compatible = "nxp,imx8ulp-fspi", .data = (void *)&imx8ulp_data, },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, nxp_fspi_dt_ids);
> --
> 2.34.1
>

