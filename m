Return-Path: <linux-spi+bounces-10746-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9A8BF321C
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 21:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 361AA4F8770
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 19:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A41B2D838F;
	Mon, 20 Oct 2025 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g6Bqbp/G"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013057.outbound.protection.outlook.com [52.101.72.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0FD2D73B6;
	Mon, 20 Oct 2025 19:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987631; cv=fail; b=rOcvG+PK7OrasoQ99qeOW5PWQkHcQrPnKgf7JaNqWstTfSa4qTPUBw7ym077I8rAErDu+RFv4U+cQZdB4LcJ5Vb818SklGz4UTO2FkBQeHj0thYJVzjhpEKdyNMvQkMmfpAViZVU/mz0vd9bvwcRH3lXYF3KLrglK1ojsG/AmPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987631; c=relaxed/simple;
	bh=49Ja0C+JAR6tzCHaGgQ/a46NWwJfSl7Fb6e8DePzi8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hGiLcNFjkzpMMj7LQmMjKwKXeDJ+TtIntXcf9k3Ws10jBXIx4ztPp0iBI2EXIyfhQy619ASuvB5v6t3JEGCDkzLns4c+Zb2NHWuEM7J23njdqn7tBK93AGoahYyhodIEnTkndF9++1aCG9Idhgg7Kcir42fWPdp8MIt1uN13V8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g6Bqbp/G; arc=fail smtp.client-ip=52.101.72.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ut55HddjFcdvRQq1u8ONsE21cwQyISwHvx8zXO4KAa/00zcNliJEXDKtyOxVjbydLnSZrb6rp6zFReKmkIXEOlVnHadzZGtT3ACTqv2nChcyQGs3Ttj2CCDEl3WDtnlGYIngsTURbmOdUPx7ZfBrXNdC3O2a80PEGC3kFmyxtfNTioLJWUx3is+UPokDbpbrL/g9VEMaTsM8ZzgEbC5zbSbxUjckvV8udwbcCE1Fr+6pcJ2TfI0DkFNkwrQRczl2mscWP9blF5TP2e6zgNOQnVUjJTEQWPg11JChHeBOShRq16nS2E/QIX85Y65dpow171AHjzFpnkuJdXOUwd0Pww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YontUkHt1pgPf+ohSV96nKeBDQDH6MhfWqUTXrDOriA=;
 b=vCbICBoGAMzBiQUoN8LmMTik5z7ZIv5+GD3aXjEpLiNZYxNOhAouuqpxDBoylvb6A1d1OV3r8psdXYggsypYxspR8oE1LIVbnssvX0mnA+VbpTDfSC5WceBPC3fmCJWUOMfnXSZqLrK+lxGJJgRmMKrBTtC8TuukdZIJt0LPJ7dUNMCLNeXLCZj/QccGotq1WADdTQqyreVd00fpYFkKQq3WpLKl4M7+IxJmEUwgfN3UWyYtbpavDHQvnlKXcK5cz2kRspy4giY75feTxF/0SzxSIZem9SRFHdLr/DrHncaA89fOZCR41cTEIx3b1asjF+27eeHC1F2rMAKIGKR4uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YontUkHt1pgPf+ohSV96nKeBDQDH6MhfWqUTXrDOriA=;
 b=g6Bqbp/GNrUS6A+1z3tCvYBsCBpq0nN92AVGgjDiO7OoY8ni3IRN6/JaP+Jq7BTmDLniyavMEH9QtEEek2QToX1pwDHAmoMcd0x4eEWvOCmpwhientW4ycbWQyhuEfx/UgGjMU+clXzDU8hawANsxnkpvWMjfDAgbth0gjBofAy1XY0e2AhgOsJoN0Zq7PsbZYZEvWozzIYpIhvIMoVTZG09q9aQt0npcuYbnTuDAVVosg+C+8Nq1rUZL3FffBXgYLKsTZlpZOTCgDiAK9Ir3twoQ+QAKMohzA2JwNyvSksnJ8gabsqUYEeagEl6F3Ac/Y8XFJTFF6yJoJZw+h84og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by DU4PR04MB11927.eurprd04.prod.outlook.com (2603:10a6:10:628::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 19:13:47 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 19:13:47 +0000
Date: Mon, 20 Oct 2025 15:13:39 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alex Elder <elder@riscstar.com>
Cc: han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
	guodong@riscstar.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] spi: fsl-qspi: add a clock disable quirk
Message-ID: <aPaJ479zH/90fJ2d@lizhi-Precision-Tower-5810>
References: <20251020165152.666221-1-elder@riscstar.com>
 <20251020165152.666221-5-elder@riscstar.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020165152.666221-5-elder@riscstar.com>
X-ClientProxiedBy: BYAPR08CA0067.namprd08.prod.outlook.com
 (2603:10b6:a03:117::44) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|DU4PR04MB11927:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e84785d-3d82-457c-bf73-08de100ccb3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BC4Tb+fJThnZeQrP8bRQYIj5c1qBO/Urmi4xVGgItB8kPH+VRVamB4zec7rU?=
 =?us-ascii?Q?9JXsv58NTTe+MXZWt2gPIdt8XY9JFC5v0R04xjYrpF89iX4f3/gXWnio+VtU?=
 =?us-ascii?Q?atX+z8Y0xxJsLnsbESnEqXpCzGWzkcyK+EryZ0xRMgNpSCK4BczHmwdRLmUr?=
 =?us-ascii?Q?Mloy4poDzW+bbIcXgpNVLUdsUAR+nntZMS/b6Ib9tXGkFcpW5BOVn0awpM6P?=
 =?us-ascii?Q?rvv7EukCLUO1DIBUO4hqpWjJn4mFc7Bj9M5yDRP5n+bYRjffxbvnm99XDE7D?=
 =?us-ascii?Q?3UyoUIyDNaFyC6QqfdtrvsSntlKtLtgPgR914Uoy928BMEV+G4x/8aTC9HDT?=
 =?us-ascii?Q?erQN+umwK+I6cnk8nmteK5CEEy/V0zWfubBJ/G8YOjG/vNCaNc2zEEsG0n6U?=
 =?us-ascii?Q?nPXYHUtH3mf3OCXQdrh1mzu7lg/snMTh+soQta9QMVQ7YX5Xd2vdhAZq4BhK?=
 =?us-ascii?Q?pcQ07vKpQf4zOpRcp4URPBv18dPssdehJf5Tr3WwC6Di/gSveh4vqi4sG8Pw?=
 =?us-ascii?Q?gpby52SNpeqQW5lf2K/yNoVLdspfd65z9ZlJSH3BRrz7XS1kFrYXWq6V014U?=
 =?us-ascii?Q?cZnNqebVB0Eis/zGQBk6mIuJULqyRuJVAKtCYCDslw+6Ff7T7UkP1s8zefT+?=
 =?us-ascii?Q?R+vIO2iyF53Yqcx1SO5Q8sLcE9K0L2w4Jpw2sR43EAQcDsNRCFyCqMZZ2FrF?=
 =?us-ascii?Q?rGFTgHuUcQ+0c+SI22MK5ndlKpU80C053YMGuwNifQ28hFiN8Sf4M8jcN06w?=
 =?us-ascii?Q?QBbzpCGnK/qY9VbZL9QyaVwZFz1Gin44C+UJUyT/BlLrhxkPIjGjlNRsFsYw?=
 =?us-ascii?Q?ta56Q0N+S0h4S0zh5mNHBwwZK6QEomuCOTc7EUhJjhHTorrkIuaK++daeCgL?=
 =?us-ascii?Q?Fs8Hb3frnjM8W0Lxkyi9ZY9/vfcKNhmhQGZdLTMXV0gBeXsfQj8mJp1HxKVa?=
 =?us-ascii?Q?LWKCv+XdBWnDWOp1QiD+DzxtpMMXGGQVaifNtlkE/HbFgW8lIN1Ds9JThzD9?=
 =?us-ascii?Q?TCg+GAATuKYhCOwPcZFPJ/wbstTi9m/9HrdOj4upyYALzk8wjKI2tCpsBDKW?=
 =?us-ascii?Q?E0J6wfx5AJonq3evnrNa9X7gq7JhXOblMyqV3Ad0KvMdp28+fqAx6qu1guvA?=
 =?us-ascii?Q?AnCKGl66eVDbVX7mGAtm1JVVa4sRPVoLyKMzQW26nptqYM5JcAeefIW7zVXR?=
 =?us-ascii?Q?apUZIt6qGFaA+Kwo8eN7HY8C4APF3Bw3Xt2c983DBh/WVjOz4G2h9+rHbgbx?=
 =?us-ascii?Q?dgX1aFWnj3f/T1o0Mz3iqo6ZPOlKii1c8VVdWmUssu7d/tXgMmXzCSEi93Qz?=
 =?us-ascii?Q?i4ImDjTbTyS3yHK5nGs0T+KCoCJrUYFa2rgXHSFRoZLyuhD0dVHhdrpDJi+Q?=
 =?us-ascii?Q?dYY/7zITPURpiC9kdvaBldTvPA2amXBdwji7fd6YTVbxfsfWUUMORfMvI1uR?=
 =?us-ascii?Q?B1YuCxNLae3gvyWMTvf60tLsigxjAkLG0+PFCv+vhteOWpkQSrvBqUiWFUzj?=
 =?us-ascii?Q?YdHNY/kpY89Ghsmd9jg2hThUWwJ44NgOkZvC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dZcPnWTw7ut9uBYlR6ecHs24A1l8x8VHjVNLDSAzsQz5UBoe/dz603JanVi4?=
 =?us-ascii?Q?GH8p6IP4CGQvibkImOvu9GkkDzA9VvcGwaCI00cRxwgBxRQrKWWrAd+I1TSQ?=
 =?us-ascii?Q?3RiAhPfk9WewffbF6vZm6HrO6lt3Zz9KrBgp2Jm+YCYjEgX1obLSOsnhLf5R?=
 =?us-ascii?Q?cjIb2MoJSL721ZLyzcO8+M9k5xl0VGq4IR2e4seYLC4DzA5tcA7AnLy88zqe?=
 =?us-ascii?Q?5bqsS23XEtDUv2fMBOJEVHYG4EzOhE7TNZ1w3KvGJm1wuAYR0MqdHJgmiNf8?=
 =?us-ascii?Q?HDl9B5ZjHnUmeFBqRSap2SG+xSDtayvrH0sRVKrUeC5n61pqUUAt74T5hTTq?=
 =?us-ascii?Q?alM0jytMqaPN8TdqDsyvkFkmwp+Em0LzCqXHfimzNwgP90tOQJO8r5vLnQ2Y?=
 =?us-ascii?Q?2k3GZc+bQEb3dfLePpoF1cdfz+S6ZNRlv07YJm04SuMib3SmyAEB7FggfxRx?=
 =?us-ascii?Q?A9aADObMgU1mGpxLtmAu9XHedougRu1U0heJMffdKEzoXcB39m2B9AXhM6Sp?=
 =?us-ascii?Q?iIU2q1DvvynCj7IPVi9zHQo46pSnaONLuWAJoKIOB17w8/x/Jtjyf8srCJG3?=
 =?us-ascii?Q?yOxz90PDquzyYoBjTnJUtaH+deLvxmRWymNN8wFqbu3ZCfxn++iGQp47PcBl?=
 =?us-ascii?Q?jK8ctH/eb03L2r2OWcjM8BbtM22wqpJerx2zXHmMoPuR1NnRaL+x40koKDdl?=
 =?us-ascii?Q?t5kvRSV6QHmBt11qbNwUJjMa87gvqBWkglWUdt8++J6193FJo2g9Gi5mEUb4?=
 =?us-ascii?Q?Fi3nv83MhGEa1uq33Y59r6M/lJ0DZfn7E65zFWRP77scK/azqRVMse26eHr7?=
 =?us-ascii?Q?3bIPHt76vm0Pn1XuYJJUQRzSxkOn9sxWzh4aGUQ6s9pHq+zdunF2ALrdqCHU?=
 =?us-ascii?Q?f1/uMI6RfYmenhhtTotA0EEkE0kRYEEs7/6OOxJAia/MsYC+kfY7rw7ZIMjJ?=
 =?us-ascii?Q?GIQCA8gW9VwPYX++vbKH38JoEXtXMrnYaU1u1aEDJ4Vd1amG0JzPiwZvbST+?=
 =?us-ascii?Q?2y8qTZJ4/48Z9EIBapE9c4m448ESWwk6PVljLkv8sVrKFCjtmhkchCa7tVUK?=
 =?us-ascii?Q?39lw9ExQxKqYzo9SCtP7Y8wSYBo9QBwikPH39q4nae3nuu7ekzBoU7jPIxr7?=
 =?us-ascii?Q?E4PtL5TNzLi0T/lQb6pYAI3VOMrzIcbTCOkYUkQREtyroQ5EKivm/moVrJLZ?=
 =?us-ascii?Q?+0DujsB5BFva18glmlSLWdpo6/0kU8ZuhxMc7AmOzQLYUHKdLK5j8xSijXli?=
 =?us-ascii?Q?XjxspXuHjbRdptZy+0Sdzdt9XDVGUDF1oiuT3ctPlk8w26Xc+qycjL/f3q+g?=
 =?us-ascii?Q?upS06FsUG9UU8zMxots+6y0dW5Wovkciemch/OPSkCWkK2RXnt3Bm8ZFuh8u?=
 =?us-ascii?Q?5lwM0dbVlSuhZamWewaXDQtpA+5kQ3Yi2g8i4Y1qWZ3sz72ZH7qdohFKBXWJ?=
 =?us-ascii?Q?Cfe4Kq7gSWuje2sqVndJgug0JNDGWgVn8kmYXs2cOxx9dVqUx9kaGNs2+1+K?=
 =?us-ascii?Q?AqCO2dR50sHpKgipn87GMcXarKHlad52tlpLPDHPasq6S51kdHEK8l3itkIM?=
 =?us-ascii?Q?HYtlYQ5a/Tn8EhSd/pS5ML7yJs6ZNq+oaHwfX4c0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e84785d-3d82-457c-bf73-08de100ccb3a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 19:13:47.0393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fmPFp0FmwmuIPq9Ehty/NjK2HNrSyvdlEc3jjoGAO/dtxleLyrqD/Zkxu3w+ZAsuniLffgTWV6DP3iC8GoX0Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11927

On Mon, Oct 20, 2025 at 11:51:47AM -0500, Alex Elder wrote:
> The SpacemiT K1 SoC QSPI implementation needs to avoid shutting
> off the clock when changing its rate.  Add a new quirk to indicate
> the clock should not be disabled/enabled when changing its rate
> for operations.
>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  drivers/spi/spi-fsl-qspi.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
> index 1e27647dd2a09..703a7df394c00 100644
> --- a/drivers/spi/spi-fsl-qspi.c
> +++ b/drivers/spi/spi-fsl-qspi.c
> @@ -197,6 +197,11 @@
>   */
>  #define QUADSPI_QUIRK_USE_TDH_SETTING	BIT(5)
>
> +/*
> + * Do not disable the "qspi" clock when changing its rate.
> + */
> +#define QUADSPI_QUIRK_NO_CLK_DISABLE	BIT(6)

NO_CLK_DISALBE look likes not clk disable capability. Maybe

QUADSPI_QUIRK_SKIP_CLK_DISABLE

> +
>  struct fsl_qspi_devtype_data {
>  	unsigned int rxfifo;
>  	unsigned int txfifo;
> @@ -306,6 +311,11 @@ static inline int needs_tdh_setting(struct fsl_qspi *q)
>  	return q->devtype_data->quirks & QUADSPI_QUIRK_USE_TDH_SETTING;
>  }
>
> +static inline int needs_clk_disable(struct fsl_qspi *q)

bool type?

Frank

> +{
> +	return !(q->devtype_data->quirks & QUADSPI_QUIRK_NO_CLK_DISABLE);
> +}
> +
>  /*
>   * An IC bug makes it necessary to rearrange the 32-bit data.
>   * Later chips, such as IMX6SLX, have fixed this bug.
> @@ -536,15 +546,18 @@ static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *spi,
>  	if (needs_4x_clock(q))
>  		rate *= 4;
>
> -	fsl_qspi_clk_disable_unprep(q);
> +	if (needs_clk_disable(q))
> +		fsl_qspi_clk_disable_unprep(q);
>
>  	ret = clk_set_rate(q->clk, rate);
>  	if (ret)
>  		return;
>
> -	ret = fsl_qspi_clk_prep_enable(q);
> -	if (ret)
> -		return;
> +	if (needs_clk_disable(q)) {
> +		ret = fsl_qspi_clk_prep_enable(q);
> +		if (ret)
> +			return;
> +	}
>
>  	q->selected = spi_get_chipselect(spi, 0);
>
> --
> 2.48.1
>

