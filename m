Return-Path: <linux-spi+bounces-8836-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E7EAEC20D
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 23:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4069364692E
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 21:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDE9281355;
	Fri, 27 Jun 2025 21:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W/mR8W1K"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012041.outbound.protection.outlook.com [52.101.71.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9AF280037;
	Fri, 27 Jun 2025 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751059850; cv=fail; b=guOpSUy+jfVqBqnKvx56Ek6sbDchzAfpp+w+oC04hrLPWL9ShJ4pctBuRDOrmyE+IYrNnTFdW9Cm5pN9J5m/m22TboX0+/V41/FvsVhkxXJ1gY7YRkap1QO4sn4nk/3teqMYwdMh3VfwxwEshKwur6Dxue1DgVl4zzfSlodELK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751059850; c=relaxed/simple;
	bh=0qsAQ2uhwapYe0JUns7/qMr/pOwn8tjPiM8g3aLoFcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pMHK8SZxJpuI78nVpKnChKdH6T/kQfgQj5Cx/36tcpYC+CLgFP+4ZCWqrv7KZMHV2RfJ6yzIwHSaD4dV1R0IPTeXUejrkgtQ4z272ljWiytERBy3KiYn6Cayz/AxFOg3OQoqpeEXS5qYi/CGrN2Ou6g9J7dc/Cybfj0GZvYBkY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W/mR8W1K; arc=fail smtp.client-ip=52.101.71.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHTFn0noWDQ7dQx9z/iUC2ib3aj+NAUq7HK0D+gCTZYvzjRlPHxEVjyJE7xn4X12dnwEnB5SRxUttayGMvxBRmkRiA1nhsvKkBGSd8xA9RRIINQ5v/TSCCO7ElRV6TzlZ9yguEfeMS9TUhSGb4tDmNDi3eJNiuj135v+qz9d0ocaL/7V2m7sP+X2otOWGcphtaNbPsBZraHIVgK6XoMdeWDxKL0WNoaO0k1K7kL5FoKJLKcppgWJhJlxxPmzekcxWdkshD+V0Dq4g8HaDI4Q8VYxgSXRTzzXhgqwq3SHmPTguD8Ihjay69LlXvVhHIPB/YyISxT94ACCgyNLwhqOgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsWSECNHC+8m9abj5VX8vOO0RUi1qj+Oe3B67CLwdOk=;
 b=zSEQQHecNWlTmZ65IswjHvKnDCOJf5RRdSUkQztQe4zUP8HhPpzN3igHX/dl/nc9pqOj/IUZjJ/SL6XYmrRA29wMHS8NbRxeXrZ2JPmVAD3F0oPdGHUnYz7gK5ZdwMdiZzqzGYV+r447EEmQPmuiiDnxEUiTlh3LsCVmqa2ajvsaoCJggmEEOaoaD9+k1GvJvMrUGrTeXFgYqglkKSsqx0w99FG9vOKS6tAEtnZ3a1tKhJUFIV+Z1vEbGTaHkAMut+daJlEojDuLMfffa2hmn0i2d59fyr8E++GASXAm/IdV5oiBgdLOMk9Y7Aa/ZSobLnuYh/oddiixstIFmOtn7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsWSECNHC+8m9abj5VX8vOO0RUi1qj+Oe3B67CLwdOk=;
 b=W/mR8W1Kxt9xZqOA9tpWZ5jo9zzywVBF/TfeNUh8wijMRPHffNcFz2rND0Lwp5yDcNw/MDBhdCRyHrbxFFH/TNdnDwL1THV4Bm1WxR5my5oCOVfcVttD8ski/1gOejKBsIkNHychCm4OARPdcoSIilzvpLcWpWsucJdGllIOjBBGcbjDygN5w0Fu/yE2ijw17gIv8tIYzEmRUKpFzlFG/8ayPBx0pQm9Jx+47qQZ6JPmHWLngmvTzomX5TQ3OE1O4g+PMW4udYc5FWgkOiofL+AA+ql5mf/d2IW6FTdMKzTpRM5tAjQXg4aQPP5X/KpUO/Gipe25kzf8MOSdHdNPmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by VI0PR04MB10903.eurprd04.prod.outlook.com (2603:10a6:800:265::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Fri, 27 Jun
 2025 21:30:44 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%4]) with mapi id 15.20.8880.023; Fri, 27 Jun 2025
 21:30:44 +0000
Date: Sat, 28 Jun 2025 00:30:41 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@lst.de>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] spi: spi-fsl-dspi: Store status directly in
 cur_msg->status
Message-ID: <20250627213041.vp6yfcgf4xysdklf@skbuf>
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
 <20250627-james-nxp-spi-dma-v4-2-178dba20c120@linaro.org>
Content-Type: multipart/mixed; boundary="zwdlutain6qm4enm"
Content-Disposition: inline
In-Reply-To: <20250627-james-nxp-spi-dma-v4-2-178dba20c120@linaro.org>
X-ClientProxiedBy: VI1PR02CA0066.eurprd02.prod.outlook.com
 (2603:10a6:802:14::37) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|VI0PR04MB10903:EE_
X-MS-Office365-Filtering-Correlation-Id: 55a0ad5d-4513-45da-5cbe-08ddb5c1df8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|4013099003|4053099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W61Bw/0Pl5b2ZODLUCIfB1JDoaAsJz0JUODS/UNxqldMOpAxiT/s8zofYOjB?=
 =?us-ascii?Q?QcyyJeLz/lG6WAPFwcMge17LjSYfNYXr51uE5IgNOzEd05rssRs/RateM7yx?=
 =?us-ascii?Q?PrpL5KQjSkErv9pyDmE4SnTjYGHlkF4js8jKz5kjKOeVDmUbEnD8cdxhuVme?=
 =?us-ascii?Q?sMvDCDBZcFDS/wDo+0PXT4Ps/uzcQ4Pm/hMGljIUOUtUWwqAC0bRRGqf95VY?=
 =?us-ascii?Q?NAWw7za/v63vnX4s9IFj4QDtha5bZJxkXpjxnERjc+2mFBMn20FQP4ToGSZ3?=
 =?us-ascii?Q?/Fgf3Jib6Fy1OSG04Bsq/VZD+My/H7b2CjhuvbUrb0+OTFM+mCQyVYFZZ6hZ?=
 =?us-ascii?Q?K+p1NKjKqC/uZ8JPriXAWAuzjKExuLqLnbMfBPph//6k9EpDIDYFbZWV2SM0?=
 =?us-ascii?Q?NcvUOh7a4FaRg+4fGgcRj5wYzGjQ7VFbA3OFXXgDp4ymxshsi3ggTdrVDKvQ?=
 =?us-ascii?Q?1SR6r4eKXgi29D0cbqLBuDeQWaPMbEMj4g0s8gsjfwQBkfR/kpkipVWB58cz?=
 =?us-ascii?Q?1lmPpi+LTPSuWg2fQt9DY3VZeQ0Xf/LWLk8zJVpArvLvs8LpgnQnOamF3Vk6?=
 =?us-ascii?Q?0ivVczM+x7itAcomBO3KCQk7lTApvvnMVrIuQLYm0EBJ6rp/kL5MaWtL9qjB?=
 =?us-ascii?Q?FBzssu8nHms+0MMAj/joh+00I266/7LfM5sKJ8//+Myv2rAu9xzI7Z2r0OFH?=
 =?us-ascii?Q?F6FAC3oUwJ/K1R3M/UqxdjLRJD81qaVsr6vANlrJhYd+GjbxLwXChtSnJeB3?=
 =?us-ascii?Q?jFo5w/WeeWOeuNYVzqob0Mounc0zTR+R3Azu8+2AO+zXAq7vmp/GNkJpRg3c?=
 =?us-ascii?Q?0josocGBR4DC5Be9Z/aAA+K5opaYtfvKKhy9WamFD+suGPAIDZoUoKv0n7iX?=
 =?us-ascii?Q?NOuX/LbPQCAj0XI4kH3vKd0giqz/0VCubS17zGpPC5vuLWwiL18w/Dn9rs8b?=
 =?us-ascii?Q?LrPhEeTcwUjVYrtH0z9B3rR3i655AEsR4ke8FEBHakNtlzRLpnJnLrgejhf7?=
 =?us-ascii?Q?C5Lq3v7EpYLC9ByvSjziczr5oIm8pHPrifpR5xM9DtLXwK+6EI2PiBWxwBX8?=
 =?us-ascii?Q?uwnZJzfXpt3i+6K9ai6jh0aZl9zJaDsL20ObolzdR22bcPeG6z9iPUUyWVBK?=
 =?us-ascii?Q?52nI2k4TmdCYl2MccHb6zgVLyjH4ATN7dJ+kwN5fD6NB5KovtV3G9UKXe0eF?=
 =?us-ascii?Q?m3a/Vzc1Ua8qtLxAj2Hi776WRxUq7u1rpeWSkxpGl9RWkexQTQF1hz0WTK/y?=
 =?us-ascii?Q?89hAGzm554AF7ygpjXg+6iSsfOKOm9cQ8u2l+8l6jWgl/4ocPdVnGzqEW+l6?=
 =?us-ascii?Q?3KKYPSBQJIjmAg3ERkjygykoIIm1ktIZiI77wJW5+v1bmCPdRccvn8fuzbQa?=
 =?us-ascii?Q?MbM0Sc1FCPAmoI/ZnfGi6W7oy9t16o+ymcoC549cm1iCWnAcsQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(4013099003)(4053099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A8LdJCRdiLqC1tnf/QQU4loHMSxGNxnFh/ukgxdwCcJCeUcb+ffocpRjIA1W?=
 =?us-ascii?Q?agpVDkwJ2FQy/4nh7mAvvmoPSJQg6wMrkFT1tdqLzvlid2hH+4JxeK7VFFJa?=
 =?us-ascii?Q?YO4xacTSvrUQeOUJx28+E+KGBufJlxVybw1dIWxNKiVxETxg102Hq++4EF7S?=
 =?us-ascii?Q?TuDNOFg0Xh8aDcyIXt01p7F4a3hZfJBTAnAFbJnzTmQnYbSo3WyUh956V1b7?=
 =?us-ascii?Q?6TcHiJ8z/S5DyIB5pcjTD4quSDYwtQ80mhkyeitU2jPiLcqWquBrolI2flnp?=
 =?us-ascii?Q?kjxLUwFvJVIu31L9caTzHxfjcPIeSCgvVTIHfE1VfXryxrbrDB8msc80RArt?=
 =?us-ascii?Q?+rAMI7qKYLzYSEi04Fo+qmd8v6pnxKumWZOFdVv08Hewa5ilWkOdP+xxxunb?=
 =?us-ascii?Q?7Bu/MitCWetyDrk4RADuWmw0OQJAkRpKX2vvULBwL8Z3syK87RsU25tqOLjg?=
 =?us-ascii?Q?YRZr/sFExj6GsC2ID/gNEopyPEFonRQbFn2+OYAB25wSSpzfq0pzdC4cnv78?=
 =?us-ascii?Q?KfygrG//Af+WRyLLQbZVh9qbFhCm9Yboj8PFoj3kq4CEyXekDjsdF2cB5lgE?=
 =?us-ascii?Q?eEwgdpHYRgs5cFYcuqUr/dSZY/ouvXgq3NcqmnQOcTh/NNAl7g1QlGllqeYh?=
 =?us-ascii?Q?9wJnXFB5nOglS86yaMrqwOfImEUY8PqfBphaI9xzzfvnWvN6+tJnW6tjh1FW?=
 =?us-ascii?Q?vyQ3pSz+BvVMPeQmR2CAHzuIKsLiugjAb4Vnq71K2NTC1SJouBO6YHQlyJWw?=
 =?us-ascii?Q?KF/IAb5bSpvO+hqDm0QwZg4PQbUqBHaZwQn8h8JhTKyDDq3yJbmNESVZuM80?=
 =?us-ascii?Q?bASEkOBfnWyqMKbcuA/ysIaset7flaI9X+DaWMkYzT+GY9/iZ5Q75eIJYmqH?=
 =?us-ascii?Q?WQPQvGv+TGTy5oJVIdbUMw5Pp7isVDfziFcFx/YoK/v3YnS1ODXV+Wlc4bYj?=
 =?us-ascii?Q?my5kb/qyvQ4jmOZeQn5AHQTUQvB5f8lbpji+T5JJ1lj+6lpK+LndKniMBeGl?=
 =?us-ascii?Q?15YrOHioTMybuX0cWjqsWsXJtjiLI2yWP9nXadJ6pmN64lhvi5k3l7nNWoKq?=
 =?us-ascii?Q?6OpW0/SWkKGBNsFUxSLaPEnKaGeDaDq9g726SNtVff9bZG/CZAAuZWt34i4E?=
 =?us-ascii?Q?bAnYsaKPfwOWe7N5d66daIjgCojrcmTlH7jAYqrxdaQvsYNEEl0zkcHDBBOA?=
 =?us-ascii?Q?uWq5Nwf4djy+iJddKQWxO/11H63e5eSr6FLQATxsDM3Mb51lT/YvzjdHUf9+?=
 =?us-ascii?Q?5ra+rTwfsdne8QHF9BRihJuYJ7SnzJl0pozoyqKMnBSZseDPAGPsnyN3hRUZ?=
 =?us-ascii?Q?XH2AN96I+cgfFcOpOaMjpyO7007ohCVrSHeKL/8F5zfrZ/wQzq9g7pH03ekY?=
 =?us-ascii?Q?s1ZqRTl9B/sXLVBfqWCJjj/T9FZsggVbb6kxaRaBQQzVpJeUFFnWZLlURHzh?=
 =?us-ascii?Q?VB6Df+JVtjUbmddIQG5xxaVgC4Qzo2UZGD9jm3ckIYe9lMAADX8KM6nhKsam?=
 =?us-ascii?Q?Yvp0K8vFRMA1vqlBNTO/jXqiTLKBalAYRsYEPL60tf4+rS/arF/mbcs3kD1W?=
 =?us-ascii?Q?BzpAD2d7QMrtw4Zijuw64oz4h+1270VYcXcLHjfQGrTVCHXFsRz2nT1x6B6k?=
 =?us-ascii?Q?G4QAqYa2rWVD4yHFBk8npMbPiqI8xXS30iUqcVaQoZtu+rBnKQxNutp7fDY6?=
 =?us-ascii?Q?TamHyA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a0ad5d-4513-45da-5cbe-08ddb5c1df8e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 21:30:44.2665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sbW4Cf26KLwxyjAD46Em+dCyyLnh8WEb7QTapOU+UP5u0eG9biaJxQiO2IxsETzq5U5mH3bruE1tYVZlQsVaGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10903

--zwdlutain6qm4enm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 27, 2025 at 11:21:38AM +0100, James Clark wrote:
> This will allow us to return a status from the interrupt handler in a
> later commit and avoids copying it at the end of
> dspi_transfer_one_message(). For consistency make polling and DMA modes
> use the same mechanism.
> 
> Refactor dspi_rxtx() and dspi_poll() to not return -EINPROGRESS because
> this isn't actually a status that was ever returned to the core layer
> but some internal state. Wherever that was used we can look at dspi->len
> instead.
> 
> No functional changes intended.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---

This commit doesn't work, please do not merge this patch.

You are changing the logic in DMA mode, interrupt-based FIFO and PIO all
in one go, in a commit whose title and primary purpose is unrelated to
that. Just a mention of the type "while at it, also do that". And in
that process, that bundled refactoring introduces a subtle, but severe bug.

No, that is discouraged. Make one patch per logical change, where only
one thing is happening and which is obviously correct. It helps you and
it helps the reviewer.

Please find attached a set of 3 patches that represent a broken down and
corrected variant of this one. First 2 should be squashed together in
your next submission, they are just to illustrate the bug that you've
introduced (which can be reproduced on any SoC in XSPI mode).

The panic message is slightly confusing and does not directly point to
the issue, I'm attaching it just for the sake of having a future reference.

[    4.154185] DSA: tree 0 setup
[    4.157380] sja1105 spi2.0: Probed switch chip: SJA1105S
[    4.173894] sja1105 spi2.0: configuring for fixed/sgmii link mode
[    4.232527] sja1105 spi2.0: Link is Up - 1Gbps/Full - flow control off
[    4.312798] sja1105 spi2.0 sw0p0 (uninitialized): PHY [0000:00:00.3:07] driver [RTL8211F Gigabit Ethernet] (irq=POLL)
[    4.443689] sja1105 spi2.0 sw0p1 (uninitialized): PHY [0000:00:00.3:00] driver [Microsemi GE VSC8502 SyncE] (irq=POLL)
[    4.575718] sja1105 spi2.0 sw0p2 (uninitialized): PHY [0000:00:00.3:01] driver [Microsemi GE VSC8502 SyncE] (irq=POLL)
[    4.588012] Unable to handle kernel paging request at virtual address ffff8000801ac000
[    4.595960] Mem abort info:
[    4.598757]   ESR = 0x0000000096000007
[    4.602515]   EC = 0x25: DABT (current EL), IL = 32 bits
[    4.607843]   SET = 0, FnV = 0
[    4.610902]   EA = 0, S1PTW = 0
[    4.614048]   FSC = 0x07: level 3 translation fault
[    4.618939] Data abort info:
[    4.621822]   ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
[    4.627323]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    4.632388]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    4.637714] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000082b7a000
[    4.644437] [ffff8000801ac000] pgd=0000000000000000, p4d=1000002080020403, pud=1000002080021403, pmd=1000002080022403, pte=0000000000000000
[    4.657016] Internal error: Oops: 0000000096000007 [#1]  SMP
[    4.662693] Modules linked in:
[    4.665756] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.16.0-rc3+ #30 PREEMPT
[    4.673615] Hardware name: random LS1028A board
[    4.679116] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    4.686103] pc : dspi_8on32_host_to_dev+0x8/0x24
[    4.690742] lr : dspi_fifo_write+0x178/0x1cc
[    4.695025] sp : ffff800080003eb0
[    4.698346] x29: ffff800080003ec0 x28: ffffc25414698b00 x27: ffffc2541464c170
[    4.705512] x26: 0000000000000001 x25: ffffc25414b06000 x24: 0000000111705fd3
[    4.712677] x23: ffffc25414257bae x22: ffff8000801ab5e8 x21: 00000000fffffd98
[    4.719842] x20: 0000000000000000 x19: ffff00200039a480 x18: 0000000000000006
[    4.727007] x17: ffff3dcc6b076000 x16: ffff800080000000 x15: 0000000078b30c40
[    4.734171] x14: 0000000000000000 x13: 0000000000000048 x12: 0000000000000128
[    4.741335] x11: 0000000000000001 x10: 0000000000000000 x9 : 0000000100010001
[    4.748500] x8 : ffff8000801ac000 x7 : 0000000000000000 x6 : 0000000000000000
[    4.755664] x5 : 0000000000000000 x4 : ffffc25411a308d0 x3 : 0000000000000000
[    4.762828] x2 : 0000000000000000 x1 : ffff800080003eb4 x0 : ffff00200039a480
[    4.769992] Call trace:
[    4.772441]  dspi_8on32_host_to_dev+0x8/0x24 (P)
[    4.777074]  dspi_interrupt+0x6c/0xf0
[    4.780747]  __handle_irq_event_percpu+0x8c/0x160
[    4.785470]  handle_irq_event+0x48/0xa0
[    4.789319]  handle_fasteoi_irq+0xf4/0x208
[    4.793428]  generic_handle_domain_irq+0x40/0x64
[    4.798060]  gic_handle_irq+0x4c/0x110
[    4.801820]  call_on_irq_stack+0x24/0x30
[    4.805757]  el1_interrupt+0x74/0xc0
[    4.809346]  el1h_64_irq_handler+0x18/0x24
[    4.813457]  el1h_64_irq+0x6c/0x70
[    4.816867]  arch_local_irq_enable+0x8/0xc (P)
[    4.821330]  cpuidle_enter+0x38/0x50
[    4.824914]  do_idle+0x1c4/0x250
[    4.828152]  cpu_startup_entry+0x34/0x38
[    4.832087]  kernel_init+0x0/0x1a0
[    4.835500]  start_kernel+0x2ec/0x398
[    4.839175]  __primary_switched+0x88/0x90
[    4.843200] Code: f9003008 d65f03c0 d503245f f9402c08 (b9400108)
[    4.849313] ---[ end trace 0000000000000000 ]---
[    4.853943] Kernel panic - not syncing: Oops: Fatal exception in interrupt
[    4.860840] SMP: stopping secondary CPUs
[    4.864788] Kernel Offset: 0x425391a00000 from 0xffff800080000000
[    4.870900] PHYS_OFFSET: 0xfff1000080000000
[    4.875093] CPU features: 0x1000,000804b0,02000801,0400421b
[    4.880683] Memory Limit: none
[    4.883750] ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---

I still intend to do more testing, so please don't send the next version
just yet. Tracking down this issue took a bit more than I was planning.

--zwdlutain6qm4enm
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-spi-fsl-dspi-avoid-using-EINPROGRESS-error-code.patch"

From 44aad50011575e720633ad1d733fd053e4a862b4 Mon Sep 17 00:00:00 2001
From: James Clark <james.clark@linaro.org>
Date: Fri, 27 Jun 2025 23:53:55 +0300
Subject: [PATCH 1/3] spi: fsl-dspi: avoid using -EINPROGRESS error code

THIS IS BUGGY because it changes the logic. More info in the next patch,
together with which it should be squashed.

Refactor dspi_rxtx() and dspi_poll() to not return -EINPROGRESS because
this isn't actually a status that was ever returned to the core layer
but some internal state. Wherever that was used we can look at dspi->len
instead.

No functional changes intended.

Signed-off-by: James Clark <james.clark@linaro.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 4bd4377551b5..c0a6c6c6459e 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -986,36 +986,38 @@ static void dspi_fifo_write(struct fsl_dspi *dspi)
 				dspi->progress, !dspi->irq);
 }
 
-static int dspi_rxtx(struct fsl_dspi *dspi)
+static void dspi_rxtx(struct fsl_dspi *dspi)
 {
 	dspi_fifo_read(dspi);
 
 	if (!dspi->len)
 		/* Success! */
-		return 0;
+		return;
 
 	dspi_fifo_write(dspi);
-
-	return -EINPROGRESS;
 }
 
 static int dspi_poll(struct fsl_dspi *dspi)
 {
 	int tries = 1000;
+	int err = 0;
 	u32 spi_sr;
 
-	do {
-		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
-		regmap_write(dspi->regmap, SPI_SR, spi_sr);
-
-		if (spi_sr & SPI_SR_CMDTCF)
+	while (dspi->len) {
+		for (tries = 1000; tries > 0; --tries) {
+			regmap_read(dspi->regmap, SPI_SR, &spi_sr);
+			regmap_write(dspi->regmap, SPI_SR, spi_sr);
+			if (spi_sr & SPI_SR_CMDTCF)
+				break;
+		}
+		if (!tries) {
+			err = -ETIMEDOUT;
 			break;
-	} while (--tries);
-
-	if (!tries)
-		return -ETIMEDOUT;
+		}
+		dspi_rxtx(dspi);
+	}
 
-	return dspi_rxtx(dspi);
+	return err;
 }
 
 static irqreturn_t dspi_interrupt(int irq, void *dev_id)
@@ -1029,7 +1031,9 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	if (!(spi_sr & SPI_SR_CMDTCF))
 		return IRQ_NONE;
 
-	if (dspi_rxtx(dspi) == 0)
+	dspi_rxtx(dspi);
+
+	if (!dspi->len)
 		complete(&dspi->xfer_done);
 
 	return IRQ_HANDLED;
@@ -1137,9 +1141,7 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 			if (dspi->irq) {
 				wait_for_completion(&dspi->xfer_done);
 			} else {
-				do {
-					status = dspi_poll(dspi);
-				} while (status == -EINPROGRESS);
+				status = dspi_poll(dspi);
 			}
 		}
 		if (status)
-- 
2.34.1


--zwdlutain6qm4enm
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-spi-fsl-dspi-fix-logic-bug-introduced-by-previous-co.patch"

From de229c0b2602a2cf3d936993a7946f3cb7a80ef2 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Fri, 27 Jun 2025 23:57:53 +0300
Subject: [PATCH 2/3] spi: fsl-dspi: fix logic bug introduced by previous
 commit

dspi_rxtx() is actually "rx, and then tx if necessary". Refactoring the
code to look at dspi->len outside of this function means we are losing a
necessary call to dspi_fifo_read(). This makes XSPI-based transfers
eventually hang.

I don't necessarily agree with the premise that using an errno value
privately within the driver is an anti-pattern, but let's at least make
the code functionally correct and use a boolean to track whether there
is data left to send, while still allowing data to be received.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index c0a6c6c6459e..e74ff6e9cb02 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -986,15 +986,20 @@ static void dspi_fifo_write(struct fsl_dspi *dspi)
 				dspi->progress, !dspi->irq);
 }
 
-static void dspi_rxtx(struct fsl_dspi *dspi)
+/* Returns false if the buffer to be transmitted is empty, and true if
+ * there is still data to transmit.
+ */
+static bool dspi_rxtx(struct fsl_dspi *dspi)
 {
 	dspi_fifo_read(dspi);
 
 	if (!dspi->len)
 		/* Success! */
-		return;
+		return false;
 
 	dspi_fifo_write(dspi);
+
+	return true;
 }
 
 static int dspi_poll(struct fsl_dspi *dspi)
@@ -1003,7 +1008,7 @@ static int dspi_poll(struct fsl_dspi *dspi)
 	int err = 0;
 	u32 spi_sr;
 
-	while (dspi->len) {
+	do {
 		for (tries = 1000; tries > 0; --tries) {
 			regmap_read(dspi->regmap, SPI_SR, &spi_sr);
 			regmap_write(dspi->regmap, SPI_SR, spi_sr);
@@ -1014,8 +1019,7 @@ static int dspi_poll(struct fsl_dspi *dspi)
 			err = -ETIMEDOUT;
 			break;
 		}
-		dspi_rxtx(dspi);
-	}
+	} while (dspi_rxtx(dspi));
 
 	return err;
 }
@@ -1031,9 +1035,7 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	if (!(spi_sr & SPI_SR_CMDTCF))
 		return IRQ_NONE;
 
-	dspi_rxtx(dspi);
-
-	if (!dspi->len)
+	if (dspi_rxtx(dspi) == false)
 		complete(&dspi->xfer_done);
 
 	return IRQ_HANDLED;
-- 
2.34.1


--zwdlutain6qm4enm
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0003-spi-fsl-dspi-Store-status-directly-in-cur_msg-status.patch"

From f478ca8a462881249ed65b8d279ae77a9bc1ac52 Mon Sep 17 00:00:00 2001
From: James Clark <james.clark@linaro.org>
Date: Sat, 28 Jun 2025 00:08:49 +0300
Subject: [PATCH 3/3] spi: fsl-dspi: Store status directly in cur_msg->status

This will allow us to return a status from the interrupt handler in a
later commit and avoids copying it at the end of
dspi_transfer_one_message(). For consistency make polling and DMA modes
use the same mechanism.

No functional changes intended.

Signed-off-by: James Clark <james.clark@linaro.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index e74ff6e9cb02..e586694502eb 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -591,11 +591,10 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 
 static void dspi_setup_accel(struct fsl_dspi *dspi);
 
-static int dspi_dma_xfer(struct fsl_dspi *dspi)
+static void dspi_dma_xfer(struct fsl_dspi *dspi)
 {
 	struct spi_message *message = dspi->cur_msg;
 	struct device *dev = &dspi->pdev->dev;
-	int ret = 0;
 
 	/*
 	 * dspi->len gets decremented by dspi_pop_tx_pushr in
@@ -612,14 +611,12 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 		message->actual_length += dspi->words_in_flight *
 					  dspi->oper_word_size;
 
-		ret = dspi_next_xfer_dma_submit(dspi);
-		if (ret) {
+		message->status = dspi_next_xfer_dma_submit(dspi);
+		if (message->status) {
 			dev_err(dev, "DMA transfer failed\n");
 			break;
 		}
 	}
-
-	return ret;
 }
 
 static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
@@ -1002,7 +999,7 @@ static bool dspi_rxtx(struct fsl_dspi *dspi)
 	return true;
 }
 
-static int dspi_poll(struct fsl_dspi *dspi)
+static void dspi_poll(struct fsl_dspi *dspi)
 {
 	int tries = 1000;
 	int err = 0;
@@ -1021,7 +1018,7 @@ static int dspi_poll(struct fsl_dspi *dspi)
 		}
 	} while (dspi_rxtx(dspi));
 
-	return err;
+	dspi->cur_msg->status = err;
 }
 
 static irqreturn_t dspi_interrupt(int irq, void *dev_id)
@@ -1035,8 +1032,11 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	if (!(spi_sr & SPI_SR_CMDTCF))
 		return IRQ_NONE;
 
-	if (dspi_rxtx(dspi) == false)
+	if (dspi_rxtx(dspi) == false) {
+		if (dspi->cur_msg)
+			WRITE_ONCE(dspi->cur_msg->status, 0);
 		complete(&dspi->xfer_done);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -1066,7 +1066,6 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 	struct spi_device *spi = message->spi;
 	struct spi_transfer *transfer;
 	bool cs = false;
-	int status = 0;
 	u32 val = 0;
 	bool cs_change = false;
 
@@ -1126,7 +1125,7 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 				       dspi->progress, !dspi->irq);
 
 		if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
-			status = dspi_dma_xfer(dspi);
+			dspi_dma_xfer(dspi);
 		} else {
 			/*
 			 * Reinitialize the completion before transferring data
@@ -1140,13 +1139,12 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 
 			dspi_fifo_write(dspi);
 
-			if (dspi->irq) {
+			if (dspi->irq)
 				wait_for_completion(&dspi->xfer_done);
-			} else {
-				status = dspi_poll(dspi);
-			}
+			else
+				dspi_poll(dspi);
 		}
-		if (status)
+		if (READ_ONCE(message->status))
 			break;
 
 		spi_transfer_delay_exec(transfer);
@@ -1155,7 +1153,8 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 			dspi_deassert_cs(spi, &cs);
 	}
 
-	if (status || !cs_change) {
+	dspi->cur_msg = NULL;
+	if (message->status || !cs_change) {
 		/* Put DSPI in stop mode */
 		regmap_update_bits(dspi->regmap, SPI_MCR,
 				   SPI_MCR_HALT, SPI_MCR_HALT);
@@ -1164,10 +1163,9 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 			;
 	}
 
-	message->status = status;
 	spi_finalize_current_message(ctlr);
 
-	return status;
+	return message->status;
 }
 
 static int dspi_set_mtf(struct fsl_dspi *dspi)
-- 
2.34.1


--zwdlutain6qm4enm--

