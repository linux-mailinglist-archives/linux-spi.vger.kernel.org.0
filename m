Return-Path: <linux-spi+bounces-4676-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F27196DD1C
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 17:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B926AB23044
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 15:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE7F19DF7A;
	Thu,  5 Sep 2024 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N/c5/eSp"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010025.outbound.protection.outlook.com [52.101.69.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16C41AAD7;
	Thu,  5 Sep 2024 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548511; cv=fail; b=Sv6jJ8kbz3EKgtN6HQhimGCwT2E8abb7I6IfKa9FKUJeH3ka7HNQ1U3SDx17lVvfBKTbDVXbIZyAdt5ys3t34Ywn+2DkT7BsjEEEeOqjt2myjvx8aLgpHx4z//D7JQ7sERE5Kb9ptvj1yp3W4+iY3v3ggc4mziK8ch4aGHF0Wgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548511; c=relaxed/simple;
	bh=3SBS1PrPlA6HbN0b25BGltNN2A4Fu9Y0Uae2+K/RzJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uEdwHfmjFDdSfLhmZabI7x7VugCbIWvUcoxSgKEr1wFxqeNZ++ykxr5eFAGJVGmNAGx/PtANcAenYvZkXGgRPc9oroiM5K7aGCcPjFMsWctL0A4TupkyiBPhDF19CHoCXE6HnJDzkNpXWsGpOjJyeXFz8NFja7C9RWcuEyWSE3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N/c5/eSp; arc=fail smtp.client-ip=52.101.69.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0KJmwG8mngvpUoJVuHcGmRrOmK0sDGRSp0+/DLO7L3EA2lyYw0CQEtlRd38yo4DDWnIcIKvMDmjFXf/uMuiM40HGVc0iXrvNvS50ue6FD5OoEBDZ88wrpFZGcTgboUt5VQoFvK5rJA7a5CsKoCBdXecewqXwGIEEgKZUg+qaEWGcuINxAEPIa7nPCKlZsnV9EDRRwADW5XlMjOzkmEX8ty7Rh1NZKstRP/aF7uEMkS/Ljw8xPetAnv/AyZQ/qSczTqTSo5TZv/6NmyYtvPHoHz8D1mpIRG1zXyfs44U3UXsjGHijkkFX/uvcMrrf/B4LirxU0qnO7wmQUz2SBXVVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hy70l6N2wl5ifDUOjCuyZjVJ9i7RDGri3IXujoAOSsA=;
 b=nDwF4MMNxaZT5tYw1vSbAuuIk1T42oUQ8Xf+3hJ9x2dWi9tR5BulO5jTgJugciU3h4+BfujVlxngQUDw97JR8fTFk88KCqWd26Tx54DNYd5Q2EvLrEq00wAxwGLzv+wvDocwRvdxDy4CFmuUNuRK+OBPAnl6wIQRojB7+Tjy5Yu+d47lEBhuVV6vhX8iMomfvdMamT+3iKbpGVbtAm/qsV25FRVu2IPYgVztZRjpBOpfFl+/2LbD8jj/6Z8DSXLehMBs0ofWFFJtvKwcFZ9UAQgmj5K1EKPqaSCKyr3HPgOLZc/FOmbWUF/PknPntcdDsG5FRVifeLzhgq48BjpJtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hy70l6N2wl5ifDUOjCuyZjVJ9i7RDGri3IXujoAOSsA=;
 b=N/c5/eSpzfKqhnm6o8K9Equk7UcZ8FqSSQAXVbL2NEGQf0161PCcl+AK1t8OnvVMoOBZnZQ7BtxWum76Ao6WRj51t7gd2Nvf9/Qn4wWCLFAsZ4UEXrzO8NCng7u3lzJrau1XlXIKAZuKovMskDMg+Ce7LS8rIkCeZMwGwEplZZ+W3i94585724DpzCtfPxEBePmu58siXKJC5b6nOelmPQBGu/pPT5x4xxSt41nT0cce+UJo8T4Lne6t0DHTNEVr9t3Ozszn40NY1ge/3o6bQgHnePs6ypV0RpNejAqLUC5JHco5pv1kcY7ZMcNDxiwShOp5G388SGSH3s9v5Bd+pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9888.eurprd04.prod.outlook.com (2603:10a6:102:385::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 15:01:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 15:01:45 +0000
Date: Thu, 5 Sep 2024 11:01:35 -0400
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
Subject: Re: [PATCH v3 2/4] spi: fspi: involve lut_num for struct
 nxp_fspi_devtype_data
Message-ID: <ZtnHz95ozgxxYIXw@lizhi-Precision-Tower-5810>
References: <20240905094338.1986871-1-haibo.chen@nxp.com>
 <20240905094338.1986871-3-haibo.chen@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905094338.1986871-3-haibo.chen@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9888:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e7176c-2bc5-4e1c-5566-08dccdbba879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zrIelr5HXvAtNZCpboqD2v88vN4hj19CNFJTu5l/W2Ms3TBaqvsbIaendONH?=
 =?us-ascii?Q?AH4G39bVVIMa4F8qOFTkIQ5lrqSI+7ObNv0K1HPzj+o7caQi97BhLpM3TftQ?=
 =?us-ascii?Q?prCPqrCq3AWdOIAFQ7YkQGpveLIagRT7raWZ2dQJC/mWHwADMWe46QCzNw3P?=
 =?us-ascii?Q?sY9J+h9O8MODPqK9h+zcqwj2yyIP7Feo75TTYL87D7xcNScR0r04OvyZg1/Z?=
 =?us-ascii?Q?9MEeRSNZXH04/urt4ALsTVx0RuJ+l3DmNNWJ0HeZ8XY+l6QqofegXmn7y6xP?=
 =?us-ascii?Q?GF0WHusjuFWD/VxoDcjiVpBSNnm1eqXX7DReYXNNtNbBVvk8IS6lUrzRy/a7?=
 =?us-ascii?Q?HRfOhRnmIKVraWaK+596LHaTXKY4xYxuIw42gmgMGDQeZ/rd7XPjpjk3BlWM?=
 =?us-ascii?Q?og4dogsoj8txYz7jDCjspm3bCzWce98pPrZPBUPcZvE7ug0uQgOA94OY/6mQ?=
 =?us-ascii?Q?0joHCAfAK5jGd2i6EDiFUXbMZg0b/MXMACQ+kjy4TfHVgryLkg3HjbJKKrga?=
 =?us-ascii?Q?GCKKW3x1YIjqatJZXM6iUybcKMpUJr7OOqlNLYPeWvtqjr2XkdfUUeI5EWnO?=
 =?us-ascii?Q?hkjG0BrNRJRPPIy+dBMUevzOTEjm4FBYqj829B4B7ZDJY+4ezNRoS0IxY6Lf?=
 =?us-ascii?Q?Vn+tufmYKJK20rE+xSaBgLiBTQ0IkRc7TshWVoemDdg7MQoGjdYDt8EYcQ03?=
 =?us-ascii?Q?xMcrrxWddO5rKHZqfmXACcqyHxXokm0qLelkGuuOz8XeKcPK4nbnKat+SxUL?=
 =?us-ascii?Q?ZovxKXSd/PIZ6sngGm5osma9m/5HGErVhnmHfQR/TNCaSW7EP31K3L1kkVoi?=
 =?us-ascii?Q?Sz16c+Bi9A9gU8BwmQniDkpKdwEDU20hTNxbKzq6PIfTWR9zaQFuxca3KwX/?=
 =?us-ascii?Q?DiUZSYeM0xgk9SmjnMI9x6shY5AZIP3LCW6TEfL2fAEW6WMM5cw3jSG2k9wV?=
 =?us-ascii?Q?LKjVjrab/FvWExGOc5TPHdA8J4JwKH86/gNrlHa30rnzb6G06S39aZAwLPUB?=
 =?us-ascii?Q?8m5G0WdsXucOMi7oqlsxmRBDMle5Pybb9fLWer11vXOb8Nvl5qn7CfEgIz7U?=
 =?us-ascii?Q?cputR8ekmZBVVAXOc4ejyWdnr+s5XGPbHIW0Y2kEi1zzUh+oLlvgvQ+I0wk6?=
 =?us-ascii?Q?LyBzlmsdVufXRCmLzZInWh2QXPB3qlJDtuqb0fWhPFt6JXPEiTKByoYfcTiD?=
 =?us-ascii?Q?sdWrgqQg2S451nAuU8+gNX7LgsQiOcaEbpl5MH5/JO/XqIpRns0cOKA19UKB?=
 =?us-ascii?Q?lRkkICD+df52JUNrrMrOFZNIhEibZYLUIQpKTSlLF0o13cNjaVOzZGX9bFtR?=
 =?us-ascii?Q?uopmyOMnE7DPnVwR6iSIUAt0Xvwcyfy2OQZG7nyiW9cH0N2Ew24RjCPLriJY?=
 =?us-ascii?Q?QcnXf8Ihxi0EXV6ryaPwutkwy9RbMb9crQKI2cMj4oWchsyXvw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kYRhWRq817mgosrt35FW5aqWbNs+ClKeDty3m7nRzn6G0aLbNg54p0tA42DY?=
 =?us-ascii?Q?1b66/glFMMmcf3cjx6/Ejyl9qLOTBBVjhJ4QzrY0WHDlG361MNeM4+G+yS3U?=
 =?us-ascii?Q?TQBf3RtEJooTPyWhsxq6ISxlJhopLxS0fLDzPK16Dfs+omHuYt73f7lO/rID?=
 =?us-ascii?Q?1fkmUQsg1+9uWYHY9fpjxWLAYaeSK7gAWZkOIDqHecondg/3+uXKAjlvRz/i?=
 =?us-ascii?Q?ynX3SpJTzrFrqrH2o37zrmaHLcQ03ksM/4+0jxaJTVgGOWQ7zOOVb+6OITxH?=
 =?us-ascii?Q?CtiTAHjm9vi+pXHZjSLVarWk6Z+pi+LuqXNwUWBctvGPJTJg/osE6Ve46Q/a?=
 =?us-ascii?Q?ZFupaphUxQIm+/ZdYe1b1bmHSIeqpkW2Dlkae5pS6Vcgw6RTqyNksknKtwjb?=
 =?us-ascii?Q?2V3ReZ/U14fiNrqHNnauDJ4EWrBTo6UsLutHUf0lcyZzC1MmM9chsEhcVMdy?=
 =?us-ascii?Q?3IdonaJqnbMggP24OpRdZ9OuJncpyIm6Fm/zkHDM/1eOk5wVpF1BhFr73A00?=
 =?us-ascii?Q?o6G2avGl/lgJHd7J+iXjyl9dLHlApv2bE4MKa744inJNvUurUDxmOoZn95pi?=
 =?us-ascii?Q?aMJD82Bt9WFPAAflnkek67MGxbi5Pre5dqQ9M4PQB4ypQRanc4L7Usfn2kER?=
 =?us-ascii?Q?H5bB8qrQLHUAIvRu7u2HJAINz0iWSlVmTBafkO/oyWJzV915WLnDwx7Wt9gB?=
 =?us-ascii?Q?NimiZ4Jk+bBn7PgDHLk5i+z/vVo+FJ/B9+ai7Y/fbzfIvUV+tfILpBYElI37?=
 =?us-ascii?Q?ft3uVCH+4HGVLZ70CDeijUe3dexM41lGrT8IO343UC+8K3pQ+yMAV50X6w8h?=
 =?us-ascii?Q?Dui+MOqPLzoQ+qvggbXgt9yopb27EwAa/omsni177vK5RfKbyBSywp0WE8ea?=
 =?us-ascii?Q?jl+HJZcHAZ1/hyw2JKXO1hJeRK5WeEzcGvtK1zP37mDaPDjWo4V8U58B7WuA?=
 =?us-ascii?Q?GHG05qibg6czW5k00M2+7Cgrqw5n8wbSiAiuXiMw6bTuHy89Lr5CipaJcw0J?=
 =?us-ascii?Q?eOUIpxunKiJkAaYMY3IFVRtRJU/OGnxawdXjG684zecYYJdEdzvzUDdvpvBT?=
 =?us-ascii?Q?Us3I0FFRUInWIZV8YXvlH5g7iMzdTeswSa9EcUb583tF9xVsXA/9rsQdVf75?=
 =?us-ascii?Q?J88H2NiFNp6xiFL8YJS1ZdqiMvgZauAHp59z5xnc8krqnSpp7Gj4hZ097W3Y?=
 =?us-ascii?Q?MQzcz2gVXyJjm9uSP2+zWLlDaceGVKr4LiefEUcaES73YwKkq/7VFn21uCTE?=
 =?us-ascii?Q?bp6hDvqRZUx4pWnb6W3XCjV45W9LAJZ88uBBkLyJeEKkA+3cjiK7Glbxn7M3?=
 =?us-ascii?Q?hG731Y10jnEjGpacUFe1cnaxavo/31HIYKHlvQ8vYD8N1IwwW+A6mAMtykgT?=
 =?us-ascii?Q?zO9u40c/O8Hwz4MLcTOfpcbGUJvjw6TXtQMSWJfICoA+GLh45mjurt1CKhBn?=
 =?us-ascii?Q?SjRxo0LkQ8vNO5ZJAAq9+NIwE1D1lz9wasF73aT5YnWY5x4WU0w9ewiY0lba?=
 =?us-ascii?Q?2yQiW1JXEywVarS7dJqOxTTYrXAXSmQHWMX8XbvGFoLXfwzdojwva+7CP8Tv?=
 =?us-ascii?Q?9dQQzBa21eeFykotlpk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e7176c-2bc5-4e1c-5566-08dccdbba879
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:01:45.0311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIXM4WEBSjteE98FH+nfMDrqwSzhYk8h5jN7/g+kJY1F39OJg6OHKQASEj5o+anYvfd0Gx/7C1FWo8RnWhrw7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9888

On Thu, Sep 05, 2024 at 05:43:36PM +0800, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>
> The flexspi on different SoCs may have different number of LUTs.
> So involve lut_num in nxp_fspi_devtype_data to make distinguish.
> This patch prepare for the adding of imx8ulp.
>
> Fixes: ef89fd56bdfc ("arm64: dts: imx8ulp: add flexspi node")
> Cc: stable@kernel.org
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/spi/spi-nxp-fspi.c | 44 ++++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index fd1816befcd8..f42c14d80289 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -57,13 +57,6 @@
>  #include <linux/spi/spi.h>
>  #include <linux/spi/spi-mem.h>
>
> -/*
> - * The driver only uses one single LUT entry, that is updated on
> - * each call of exec_op(). Index 0 is preset at boot with a basic
> - * read operation, so let's use the last entry (31).
> - */
> -#define	SEQID_LUT			31
> -
>  /* Registers used by the driver */
>  #define FSPI_MCR0			0x00
>  #define FSPI_MCR0_AHB_TIMEOUT(x)	((x) << 24)
> @@ -263,9 +256,6 @@
>  #define FSPI_TFDR			0x180
>
>  #define FSPI_LUT_BASE			0x200
> -#define FSPI_LUT_OFFSET			(SEQID_LUT * 4 * 4)
> -#define FSPI_LUT_REG(idx) \
> -	(FSPI_LUT_BASE + FSPI_LUT_OFFSET + (idx) * 4)
>
>  /* register map end */
>
> @@ -341,6 +331,7 @@ struct nxp_fspi_devtype_data {
>  	unsigned int txfifo;
>  	unsigned int ahb_buf_size;
>  	unsigned int quirks;
> +	unsigned int lut_num;
>  	bool little_endian;
>  };
>
> @@ -349,6 +340,7 @@ static struct nxp_fspi_devtype_data lx2160a_data = {
>  	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
>  	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
>  	.quirks = 0,
> +	.lut_num = 32,
>  	.little_endian = true,  /* little-endian    */
>  };
>
> @@ -357,6 +349,7 @@ static struct nxp_fspi_devtype_data imx8mm_data = {
>  	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
>  	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
>  	.quirks = 0,
> +	.lut_num = 32,
>  	.little_endian = true,  /* little-endian    */
>  };
>
> @@ -365,6 +358,7 @@ static struct nxp_fspi_devtype_data imx8qxp_data = {
>  	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
>  	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
>  	.quirks = 0,
> +	.lut_num = 32,
>  	.little_endian = true,  /* little-endian    */
>  };
>
> @@ -373,6 +367,7 @@ static struct nxp_fspi_devtype_data imx8dxl_data = {
>  	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
>  	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
>  	.quirks = FSPI_QUIRK_USE_IP_ONLY,
> +	.lut_num = 32,
>  	.little_endian = true,  /* little-endian    */
>  };
>
> @@ -544,6 +539,8 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
>  	void __iomem *base = f->iobase;
>  	u32 lutval[4] = {};
>  	int lutidx = 1, i;
> +	u32 lut_offset = (f->devtype_data->lut_num - 1) * 4 * 4;
> +	u32 target_lut_reg;
>
>  	/* cmd */
>  	lutval[0] |= LUT_DEF(0, LUT_CMD, LUT_PAD(op->cmd.buswidth),
> @@ -588,8 +585,10 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
>  	fspi_writel(f, FSPI_LCKER_UNLOCK, f->iobase + FSPI_LCKCR);
>
>  	/* fill LUT */
> -	for (i = 0; i < ARRAY_SIZE(lutval); i++)
> -		fspi_writel(f, lutval[i], base + FSPI_LUT_REG(i));
> +	for (i = 0; i < ARRAY_SIZE(lutval); i++) {
> +		target_lut_reg = FSPI_LUT_BASE + lut_offset + i * 4;
> +		fspi_writel(f, lutval[i], base + target_lut_reg);
> +	}
>
>  	dev_dbg(f->dev, "CMD[%02x] lutval[0:%08x 1:%08x 2:%08x 3:%08x], size: 0x%08x\n",
>  		op->cmd.opcode, lutval[0], lutval[1], lutval[2], lutval[3], op->data.nbytes);
> @@ -874,7 +873,7 @@ static int nxp_fspi_do_op(struct nxp_fspi *f, const struct spi_mem_op *op)
>  	void __iomem *base = f->iobase;
>  	int seqnum = 0;
>  	int err = 0;
> -	u32 reg;
> +	u32 reg, seqid_lut;
>
>  	reg = fspi_readl(f, base + FSPI_IPRXFCR);
>  	/* invalid RXFIFO first */
> @@ -890,8 +889,9 @@ static int nxp_fspi_do_op(struct nxp_fspi *f, const struct spi_mem_op *op)
>  	 * the LUT at each exec_op() call. And also specify the DATA
>  	 * length, since it's has not been specified in the LUT.
>  	 */
> +	seqid_lut = f->devtype_data->lut_num - 1;
>  	fspi_writel(f, op->data.nbytes |
> -		 (SEQID_LUT << FSPI_IPCR1_SEQID_SHIFT) |
> +		 (seqid_lut << FSPI_IPCR1_SEQID_SHIFT) |
>  		 (seqnum << FSPI_IPCR1_SEQNUM_SHIFT),
>  		 base + FSPI_IPCR1);
>
> @@ -1015,7 +1015,7 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
>  {
>  	void __iomem *base = f->iobase;
>  	int ret, i;
> -	u32 reg;
> +	u32 reg, seqid_lut;
>
>  	/* disable and unprepare clock to avoid glitch pass to controller */
>  	nxp_fspi_clk_disable_unprep(f);
> @@ -1090,11 +1090,17 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
>  	fspi_writel(f, reg, base + FSPI_FLSHB1CR1);
>  	fspi_writel(f, reg, base + FSPI_FLSHB2CR1);
>
> +	/*
> +	 * The driver only uses one single LUT entry, that is updated on
> +	 * each call of exec_op(). Index 0 is preset at boot with a basic
> +	 * read operation, so let's use the last entry.
> +	 */
> +	seqid_lut = f->devtype_data->lut_num - 1;
>  	/* AHB Read - Set lut sequence ID for all CS. */
> -	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHA1CR2);
> -	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHA2CR2);
> -	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHB1CR2);
> -	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHB2CR2);
> +	fspi_writel(f, seqid_lut, base + FSPI_FLSHA1CR2);
> +	fspi_writel(f, seqid_lut, base + FSPI_FLSHA2CR2);
> +	fspi_writel(f, seqid_lut, base + FSPI_FLSHB1CR2);
> +	fspi_writel(f, seqid_lut, base + FSPI_FLSHB2CR2);
>
>  	f->selected = -1;
>
> --
> 2.34.1
>

