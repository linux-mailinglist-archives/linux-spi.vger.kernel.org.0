Return-Path: <linux-spi+bounces-10901-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FF3C15997
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 16:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF0C3BA0A7
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 15:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34E6343D91;
	Tue, 28 Oct 2025 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ngth1kIU"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013034.outbound.protection.outlook.com [52.101.83.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596533451C9;
	Tue, 28 Oct 2025 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666223; cv=fail; b=VX/wOrXK2P4Ev5hH7NcqjMuY37FRvxs4Ps3G0yHubNCv+Sty23BkLSjeP5HENwBfIV0/XP3PChud9x/Ee9uu0Sp+P1YmpWA5HwcveNzJkT/4eiLtYpQ+V8H5dFOknHHycm9CS6OIACbT5hqutgUzbymJxxayNhx8wo8e+q4DD+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666223; c=relaxed/simple;
	bh=5R2leiVlA87E2YqJbfwFcyJOnBW+XdpZO1UKKhIh6Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sED2nWpdoRLggS2ivBPwShh6Ie9u61Z88jnGRyf8oZiT0MLZH8lIYcwi3ViI9LGkgEPFxrL2sShtUr00a84hhGBfHP86j78oo2K1qlU7tn+tQIZOU2idoX/IOw3/p4JVR12gA4MUUOUhKWXf8B4fxFUXFejBVK5JRcZrtcSgKC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ngth1kIU; arc=fail smtp.client-ip=52.101.83.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYhhFnyAGBXQ2NlJDa/snv9FWb+893p2cJxn+CPcf6+0sstI7naCBxdZrwE9ZBgYswzZbULpW7pBcqFNjS+Ol2555juEJRtKI4iCy7S62OsqbpjVu6ivEt+c9KFCbC1pxtAaj6IWYqqdidnE0X/OzpMng/ET6yLyzpoHVw7KHmEhsFq8EvwZJkh5vhBqSQqR5xVqzw7z7es7F5aYOGDHeUrUxy8hSkeCJTu+7dUPZ9yZVr7qYBMkMrGik6a2wfQDMimBCtcdb0L+MPXdyJMBlmCDiONWcMK53SwF26laDWJXFLBmYhUWSvpSl/v5L0ng8Ly5WZw8VO3ZcrXRZ0Qcvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLzgqt9BJ8ROBu1ytd8NRk8G5nhO+d5g2MyNEPanXaA=;
 b=LRtWCAo/EvGX9b0aKuj11wSR5o9hzn975G6/IjnG3csNJdMAqFaRBvYR/dLk4eky3x/A1iidXDOgH5Usll7yfxNHAcS0I/FZgaAZ2KHXTwlB+Ak9fNLV+euCAgnzdsSWMwqvy39xcNjnO636DP2Q7aFMCEPTyUPqXbdoo5BY9kh4Iq1/ybzfp3Bk2QsBD+EjWStKIVQrJ0y+a851xyX+zcB7c2jOTiSPE6AOzndFYcJQCuagTJnYCbq4B/HYEzPxjr3QnccgSST+8m+bXkEz7yTqEbw5uMrm++HxyKe2f7JG/S9fHf4WydWenwO7SoBW/h04bSFNEPXQTi0E+L2XKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLzgqt9BJ8ROBu1ytd8NRk8G5nhO+d5g2MyNEPanXaA=;
 b=Ngth1kIU07pN/U4JHAeMUgdbxEJJfQZIR5zA0vSg+RAQOIdNKQvGhAyQljBOsEIU+cWJ9h2kHGpn0Kx8kzWFAyZEc8c1mnXyplxi+OImfbGKWhFAu6KGbX3n7D5ZYLj2kMpByGt+MKx00Gj1xWwjk8hxdnbXj3JTon+dFok+Pd1+msDHZWLz2l0l+ja0gpqhfiAsrld8xrtn+EL8LyaV+hFvs8IePEfOjVOCGzAE4cHccS7UlvpG9xQdDFpiUzpnAXHGf4uAXnlrYR4qtCFi4NHHx/6aGrp3Tv6WTF8Mr3sK1YxVUvUBrorEwJehQUNr9j/VCwEhyjsmaMf50TNRcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS5PR04MB9970.eurprd04.prod.outlook.com (2603:10a6:20b:67e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 15:43:38 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 15:43:38 +0000
Date: Tue, 28 Oct 2025 11:43:31 -0400
From: Frank Li <Frank.li@nxp.com>
To: Carlos Song <carlos.song@nxp.com>
Cc: "mkl@pengutronix.de" <mkl@pengutronix.de>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PACTH v2] spi: imx: add 16/32 bits per word support for target
 mode
Message-ID: <aQDko60j5lB1ngCl@lizhi-Precision-Tower-5810>
References: <20251024113107.513604-1-carlos.song@nxp.com>
 <aPt+JJhaB9dUOwL8@lizhi-Precision-Tower-5810>
 <VI2PR04MB11147AB20690F99BB6CEE2300E8FCA@VI2PR04MB11147.eurprd04.prod.outlook.com>
 <aP++6ghId1LvQ1NF@lizhi-Precision-Tower-5810>
 <VI2PR04MB1114746F42268876E27C1B93FE8FDA@VI2PR04MB11147.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI2PR04MB1114746F42268876E27C1B93FE8FDA@VI2PR04MB11147.eurprd04.prod.outlook.com>
X-ClientProxiedBy: PH7PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:510:23d::20) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS5PR04MB9970:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aecf1e8-72fb-4725-7649-08de1638c2fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dFf6O9/7G0KmtozUhEWMETCp7/sgXTin1zgSx6C92VuIJZPuIkRi1jc2aJx9?=
 =?us-ascii?Q?ZZ+2p1IPztE+KORgbb2HTJ5Cdj3/avrzMf90aLt7LmCJrhsGYONWC6pbj5H5?=
 =?us-ascii?Q?uvhCFaEYB9XJl7/zjj8KJhgFQMflIbMYAzLtD0aCYJOpQu4NSreII2Ut59Z/?=
 =?us-ascii?Q?+2I1sGfMw4cQLxVUartGA/jbPKi8FcCLOvlp+MLf7cWXHTqav9ibtQpSARrw?=
 =?us-ascii?Q?kaJttv4jBnVxc185MP6tQKY2z/sDWrUoNV9jhy3WEkMxyAkwcxUu7I2m33LN?=
 =?us-ascii?Q?ZvgPyglyyvCXb48XL+W4ovuTMK86bQaSZ46WgExQAU76mPA4W3l7tM6psee3?=
 =?us-ascii?Q?q/58IGbfVIoNOubM08KmSf6WexPp8XwM4vJxC6JnWDZc/W0Juc9bL+AXi4la?=
 =?us-ascii?Q?R8aaHNDJ8u3sKJXWjn5Yf3ybs79WaBYA9PWJ6FBD2o5vQyh2JgijbG4LJlhT?=
 =?us-ascii?Q?+aMDoRA3YGhsRSw7U2WXEXpAUgwnAIfKBpPW0Mj7mzvcB1E6QGCgSKMUdvwY?=
 =?us-ascii?Q?HqRLWH+OGMp/+baRoVLcw9eXpr7gJCv8GmM0ywipLEvU2++8lS0GPMerFmPo?=
 =?us-ascii?Q?ZKIWo4o6UlOxhR/fBJahPF2eShSI2gO7TrsKaYx7PGHPkrmb1fqBH5gOAzQo?=
 =?us-ascii?Q?n1byx9IsWlpx5e/OfmJHhOrs3Gng2MBEO7sMqdfeLQrjDkohii9Rnn4vAHlH?=
 =?us-ascii?Q?WgB9n/JwkCx8YDcOQ/8pj/gCRr8+82A6Inhf7qlLhN8zLElWBARoxnXdIjKV?=
 =?us-ascii?Q?gBYGDULywRWt74K88ezR0HTBv1HtJyTgbqi/1JyCT1zu8vOr4E2qzQ3l4Xym?=
 =?us-ascii?Q?3HMXnSOTLTJdWr7AaO1BrcRGBGLl1c1yYUnQgGnSNo6ibx182U3mhxiuZe9l?=
 =?us-ascii?Q?wruT1iLTYq47V3tsWt32ErAH2PmFGSYZnCIATw4dyEx+SQZk/tGqhCLaazyQ?=
 =?us-ascii?Q?ZC9cpF3Sao2UYz0HoRC4Z5tL1CiUl6OobALmZQA0WYsgvG+u6ILLI0t0Zvmn?=
 =?us-ascii?Q?Vsg9gBG1wvCloblH85OhyXJ0whLbTQg+qETbKRoqSFBJYMDp0abXwi7vT3nn?=
 =?us-ascii?Q?WBBDOz6PbGgaOB+Jmnt7umn9Oux8pPMkwZ80WhOFriUNMwlWFA/M1dA/kgR/?=
 =?us-ascii?Q?MKOnmg6eHE2Wr+uwjdB7CRPstZ4OOH57aKWc2Kb3E9jFi2rQaGnCrrt7PFNc?=
 =?us-ascii?Q?vFs29BKvJPiwbfUUYCco3l1pinShsckPHYltNsAUeop/5qhtM5YuQEwknI3A?=
 =?us-ascii?Q?eeYdJsYRqJD8RB/Pf9CJ42Y3aLMdEF4CeCmmm9SxQZISR86GasSGS7henEiO?=
 =?us-ascii?Q?9Rxeq1I6hrxTomj94IxgO650qcf1Meq8wtzTs3pwR94D80Wr9luDNF//19SZ?=
 =?us-ascii?Q?8XsN1NZp42CArWrb7+DmabLo0l/vtjpr5fsFzjYo59IVY/w+mG2XF1mMm/+j?=
 =?us-ascii?Q?r0Zc3iSeAvKeHsyCawNs52mkIbNwW/H1WQKrXuAu2lFemIuG0SpyY2rKWpBR?=
 =?us-ascii?Q?XLeaO/F781ecbJSP3dxKBpAVDP/8vdYlWAWm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8NKERhosz3h1ePM9/ox82p9pAGExFydkZCHZpHJZgMt9yGZe5eQ0S4CSqi4z?=
 =?us-ascii?Q?oDbEkZ/Gw1r67tVk0K5ko0ENGPRi5wC7CliESYV6RaBCDYIECBg2DKuGo1wp?=
 =?us-ascii?Q?8hBdFORWyTHTbTtzOlDxvfO1KPFOyU5nkirp0RauJ6MDIXbLAu5USvbB2Ng5?=
 =?us-ascii?Q?n5zgAihmBvN0ehcLZwjwyEkb5N8HnIqQnrE6JSdx4meiXUnJympnb5a2zoM5?=
 =?us-ascii?Q?wQQCVA0MUCn5U/UzQmhFuoDLHJHPxl+rrcVaFGLe00ihsbezxXNEU+v7SvSm?=
 =?us-ascii?Q?/JcLY6Q5Y+F5P1wPb0noSlE2p/GK6aBjNChAl9fjmN6nBga+3lQFPRz6iEr3?=
 =?us-ascii?Q?qWDTIv/iR2HdGRatcnIwPoJ/RY4pq9mK3/qnFE3o+Vib3/UQj3J3GEpe+g5j?=
 =?us-ascii?Q?7EwKMq7et0U4uVVZ/yAkaCPhqlujiPRr2arasSYaqiWmncuIg6EUZrDp80vV?=
 =?us-ascii?Q?PkAoCPyXjbOSS54UsLhIVQbQEsr/MDfNjyiGEUEV1W4hOgxT7kRPrmn94/bG?=
 =?us-ascii?Q?aGmQ/tWgPRakxsUaI3sMOV0g0ez2xkkFO06OKWnAic2gm+sI779NHERXEOV9?=
 =?us-ascii?Q?v/2G0keIknrcaRnWs9YLfHO5RB03OobP4Dh8bC2ypoPAsuoS0tmRJwa0ikht?=
 =?us-ascii?Q?8L3HOSZ2Tx7AGO2bmuja+9Z4Tqlb8OxBcW6OLOd7FC7+Ua6/IIUhUR60U9H7?=
 =?us-ascii?Q?+d8q3YzDqI6eSgRVUznVBTocxMyf4zJRgnm9g3ethgYM/NoV0LbW4pCqzMVn?=
 =?us-ascii?Q?bpw196XlIqly2NwRBSazXGIFnhBY1wiQI9+f/SpjfQNpKlTZ7RGKW5X9yiMn?=
 =?us-ascii?Q?DcGeDLM7zQpTO20RbPioPFEqK9DzRmoXnMA+ywM1NT5uCv8YYaSmP/WtUk1Y?=
 =?us-ascii?Q?2CoDsaBpjDhB9lh8kGmsOyqF9bNy8rpAydjUH9AD3+G4PHUEtEkhGSjXAKSk?=
 =?us-ascii?Q?vpL1r4BesVqyYBaiONYdfyQUIQfLgXsgnHOchXpjC51B6OaQgWiRbvq/Wx13?=
 =?us-ascii?Q?OQJhMXlljBDRsgc28QAgrupdfjDk4bxNV+U8VWridup4WsdwZNjpXhYn2ynm?=
 =?us-ascii?Q?JTMaIaK1mjxqdNotNJ/sb6I1H7N7iNnouoYhz01anKEZ9wvm4dxyn5pzlCg3?=
 =?us-ascii?Q?j8nN2D+ftHRxOzfJyt5FMpMo12LzlJdlkWGudQvPtf4C1MsCoxTcustrMNW5?=
 =?us-ascii?Q?CK1XRD/SSjDSzPkpgqvLJOv2Kxzfr5zMg0DgnJO/08j9PG1ZfKwQgucNyb1J?=
 =?us-ascii?Q?hbB9d3x7Rg2LxJR/s6mBDf0l4OVN0f8okU0wsVLhXet8WX7SVGFUXhryEKSE?=
 =?us-ascii?Q?LC74pF3KQpiqHpkck6cAtGOusNfEtbTgx/tb3rY36yysDXKpT7TB7uz7WVRJ?=
 =?us-ascii?Q?ipTFN4y0L9ylzks9CgxZRuLAtnkU9BQq57na8hF0vq/uRIAQKxOEeG2Z2nee?=
 =?us-ascii?Q?1YhssB1e0c9c0mC1knF+3wm1Ty5OBtNf3RH8PPwvv9OGTlO17B7fIuP2pfmP?=
 =?us-ascii?Q?DHU0t794QkpqG2ubjZEaNcchktC8xXloobSX5lNGjTJS9Z8/pnhm9hywwVQX?=
 =?us-ascii?Q?j+0nxgtRMIxsWDQyvaQ3BmDs/jx59J5btyG0BZXh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aecf1e8-72fb-4725-7649-08de1638c2fd
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:43:37.9586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/980zArF9X7s5AdTBjOoTjpbviBiyfXyNrnjg7ROMVWL9Qnadq7ajfvlYQyrGU1qpL/pHivAVEUj7BfhflaEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9970

On Tue, Oct 28, 2025 at 09:29:02AM +0000, Carlos Song wrote:
>
>
> > -----Original Message-----
> > From: Frank Li <frank.li@nxp.com>
> > Sent: Tuesday, October 28, 2025 2:50 AM
> > To: Carlos Song <carlos.song@nxp.com>
> > Cc: mkl@pengutronix.de; broonie@kernel.org; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > linux-spi@vger.kernel.org; imx@lists.linux.dev;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PACTH v2] spi: imx: add 16/32 bits per word support for target
> > mode
> >
> > On Mon, Oct 27, 2025 at 03:39:36AM +0000, Carlos Song wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Frank Li <frank.li@nxp.com>
> > > > Sent: Friday, October 24, 2025 9:25 PM
> > > > To: Carlos Song <carlos.song@nxp.com>
> > > > Cc: mkl@pengutronix.de; broonie@kernel.org; shawnguo@kernel.org;
> > > > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > > > linux-spi@vger.kernel.org; imx@lists.linux.dev;
> > > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > > > Subject: Re: [PACTH v2] spi: imx: add 16/32 bits per word support
> > > > for target mode
> > > >
> > > > On Fri, Oct 24, 2025 at 07:31:07PM +0800, carlos.song@nxp.com wrote:
> > > > > From: Carlos Song <carlos.song@nxp.com>
> > > > >
> > > > > Now for ECSPI only support 8 bits per word in target mode.
> > > > > Enable 16/32 bits per word support for spi-imx target mode.
> > > > >
> > > > > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > > > > Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> > > > > ---
> > > > >  drivers/spi/spi-imx.c | 12 ++++++++++--
> > > > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c index
> > > > > 155ddeb8fcd4..017f83f5dfdf 100644
> > > > > --- a/drivers/spi/spi-imx.c
> > > > > +++ b/drivers/spi/spi-imx.c
> > > > > @@ -424,8 +424,12 @@ static void spi_imx_buf_tx_swap(struct
> > > > > spi_imx_data *spi_imx)
> > > > >
> > > > >  static void mx53_ecspi_rx_target(struct spi_imx_data *spi_imx)  {
> > > > > -	u32 val = ioread32be(spi_imx->base + MXC_CSPIRXDATA);
> > > > > +	u32 val = readl(spi_imx->base + MXC_CSPIRXDATA);
> > > > >
> > > > > +	if (spi_imx->bits_per_word <= 8)
> > > > > +		swab32s(&val);
> > > > > +	else if (spi_imx->bits_per_word <= 16)
> > > > > +		swahw32s(&val);
> > > >
> > > > Needn't swap when bits_per_word > 24, like 32? or our hardware max
> > > > support to 16?
> > > >
> > > > Frank
> > >
> > > I think we don't need. We are reading/writing FIFO by 32-bits word. In
> > > this case, we just need keep the default byte order.
> > >
> > > Is it more reasonable only support bits per word=8/16/32 for target mode?
> > > -b 8/16/32 can cover most use case.
> >
> > yes, I only can't understand why needn't swap at 32bits workds, but other
> > needs.
> >
> > FIFO 31..24  23..16  15..8  7..0
> >       B0      B1     B2      B3
> >
> > next you
> >
> > in memory val is
> >
> > 0x0: B3
> > 0x1: B2
> > 0x2: B1
> > 0x3: B0
> >
> > swab32s() to  bits_per_work 8
> >
> > 0x0: B0
> > 0x1: B1
> > 0x2: B2
> > 0x3: B3
> >
> > if bits per_word 16
> >
> > val
> >
> > 0x0: X
> > 0x1: X
> > 0x2: B1
> > 0x3: B0
> >
> > after swahw32s change to
> >
> > 0x0: B1
> > 0x1: B0
> > 0x2: x
> > 0x3: x
> >
> > B0 and B1 still be swapped.
> >
> > Does SPI defined term word fixed big-endian?
> >
> > Frank
> >
>
> No, SPI doesn't define this. This swap is caused by the SPI-IMX FIFO design.
> SPI-IMX FIFO is fixed little-endian.
>
> One example to easy understand:
>
> If buf is:
>
> 0XB0B1B2B3
>
> So data in TXFIFO is:
> FIFO 31..24  23..16  15..8  7..0
>   B0        B1		B2   B3
>
> So we can always see data on SPI bus:
> 0xB3B2B1B0
>
> For this patch:
> bits per word= 8: it means one byte is one word, so it should not effect by big endian or little endian, so every bytes should keep the same order between memory and SPI bus.
> We write FIFO by 32 bits word, So we should swap every bytes in this word from 0XB0B1B2B3 to 0XB3B2B1B0
>
> Data in TXFIFO is
> FIFO 31..24  23..16  15..8  7..0
>   B3        B2		B1  B0
> Then we can see data on SPI bus is
> 0XB0B1B2B3
>
> For bits per word = 16, it means two bytes in one word, so every 2 bytes is one word, the word should be a little endian word,
>
> so we should swap half word from
> 0XB0B1B2B3 to 0XB2B3B0B1
>
> Then data in TXFIFO is:
> FIFO 31..24  23..16  15..8  7..0
>   B2        B3		B0  B1
> Then we can see data on SPI bus is
> 0XB1B0B3B2
>
> For bis per word =32, it means for bytes in one word, so every 4 bytes is one word. The whole word is a little endian.
> So we keep the default order.
> 0XB0B1B2B3
>
> FIFO 31..24  23..16  15..8  7..0
>   B0        B1		B2  B3
>
> So we can see the data on bus is:
> 0xB3B2B1B0

Does SPI require send MSB/LSB first of a CPU's word?

Frank

>
> The RX handle is the same with TX. From bus to FIFO is a little word, so swap in memory.
>
> Carlos
>
> > > Carlos
> > > > >  	if (spi_imx->rx_buf) {
> > > > >  		int n_bytes = spi_imx->target_burst % sizeof(val);
> > > > >
> > > > > @@ -453,12 +457,16 @@ static void mx53_ecspi_tx_target(struct
> > > > spi_imx_data *spi_imx)
> > > > >  	if (spi_imx->tx_buf) {
> > > > >  		memcpy(((u8 *)&val) + sizeof(val) - n_bytes,
> > > > >  		       spi_imx->tx_buf, n_bytes);
> > > > > +		if (spi_imx->bits_per_word <= 8)
> > > > > +			swab32s(&val);
> > > > > +		else if (spi_imx->bits_per_word <= 16)
> > > > > +			swahw32s(&val);
> > > > >  		spi_imx->tx_buf += n_bytes;
> > > > >  	}
> > > > >
> > > > >  	spi_imx->count -= n_bytes;
> > > > >
> > > > > -	iowrite32be(val, spi_imx->base + MXC_CSPITXDATA);
> > > > > +	writel(val, spi_imx->base + MXC_CSPITXDATA);
> > > > >  }
> > > > >
> > > > >  /* MX51 eCSPI */
> > > > > --
> > > > > 2.34.1
> > > > >

