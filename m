Return-Path: <linux-spi+bounces-10053-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4FCB59C3B
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 17:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC94F1C02FFA
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 15:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FE5293C44;
	Tue, 16 Sep 2025 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Eq6yaV8P"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011041.outbound.protection.outlook.com [40.107.130.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378C522689C;
	Tue, 16 Sep 2025 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037055; cv=fail; b=ifjb92/TDB2ZXkXwhmWNw/jWEIqNEKlTppMv9DjnbdpSAQKJhReFA8VhRyBNJroV53qrjAcpTEF8AorTcZ9DYBSfCS6tdEyLv/2tJ6vnnYkDeVsS/f9zav5dBgZb3ZVfTpfmWm/T5Ecjj6tfKmf0AJl6amwBi0HUXaRiR6zm+KM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037055; c=relaxed/simple;
	bh=3e1hLbMclXgDqCybAv66MLJhTDw58h4U5zjaCRrhRu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jZWTZvZJWIPGAV7EGIOwN4TGGZ3E+C7IRGh8ZebWC7wDKNe8IDnR9WDOV9k8OIFnOW9hwvFLRGmBteBJGm7LsiegOxJ38swr1Kh+2nTsl1Q29dZJI/PVc/TjHb09QnVcHfrlwOSxxA1FUcNGwrUt3zbsqp8Y54VGSsOsiSShh2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Eq6yaV8P; arc=fail smtp.client-ip=40.107.130.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ceyobsFihRkGBnjPrXiv9jmqk4C2Rsw2wEXhHoz/kLSYH/BS/dfSbIBlAKzWDGW4r+E7WVu8Bf+G7aFtZjE/fKvc3ecEUM9H0Jt/nTj48FzhwzzIpqGdCEwWioAa4YRsuYtHF+GyXzcsDATu/fL/4HNnngoOKgP4otl1RqeZMrqrjzE9ofRwWCtpM5k2eCcWA2+3XE9g0JnGQcYMIkipgVWTIE3ILVBJZA+EF/jpOFnGnMTHwFDMNS/zaGSgsql83EpL3n3HZ1+RGtO23AStoTzwQvBTsQna51yJAGucUcnF/5VpaP546lIEbcSj/e9A7g5+xibrT6g49DQUQXzBGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6aMXbqr1GFnobQNmfycpDr+ec5LDh0+QMssCitFY9k=;
 b=hrED1ygw0xmkYMs5RvMAxNMeoUHbt5mcJk6fqZ3jXD6GyL/KcyF5cQTI9dOeZEzt2o1unKsk3FbyiV+CWgrO5vRnyBMjPYep2mis0pJymY67rUvqFFebUgrze98rBynLFwdPPVCbKJ8FPWPCGfQ657nGjSfDtNziXnQ2QgGQhqReETkiGkXYrxSK3jyF72kcUtZVj+MtvRz3Pqd+ITtNFgM4SyKN6TCBVA9JC9+l2Vbd2vgUnow5bVr1XC7HrpHOQ5BItx87GQcvbzKPIAS9kzHrDK0ZqYrQItx6Aij/hkCZAC/1Z1BrWw3SQ4CJGNZ2VIhGOu5gXSSsWf646EUOcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6aMXbqr1GFnobQNmfycpDr+ec5LDh0+QMssCitFY9k=;
 b=Eq6yaV8PPhg7TlkiIZO3nP0fYwaX11lCqfS7hW6LbYYbFY3keHUPIvAI5/dZrY3VX8pfz8M9fXeY4QOM9AbLis4lDbYUbx6Q/zgYJqNFw5DbRQ4uZKsxGtlkcVmOyRmZdhUGLRwYuWIfS48Yyo80pLlz/XKegQxIo16gF1n+LYLgUrnte38nZ30xVwaGHzmqbYgbraCXxX8doHzDXv4m4tcX3Pz7ICApd8ZBKa60IxkD88wIdCRCWFbo7AaIR6wFpHZ1QX6qdM9vyMBfFcT3yDl8fz0pTlc8mSEneuMrURBnBPhMWn6EYzR+RQrKgBQBP1qFN6LFuhnZesjZRPa4rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AM9PR04MB8892.eurprd04.prod.outlook.com (2603:10a6:20b:40b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Tue, 16 Sep
 2025 15:37:29 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9137.010; Tue, 16 Sep 2025
 15:37:29 +0000
Date: Tue, 16 Sep 2025 11:37:21 -0400
From: Frank Li <Frank.li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] spi: spi-nxp-fspi: add the support for sample data
 from DQS pad
Message-ID: <aMmEMQoa4LMBtkYI@lizhi-Precision-Tower-5810>
References: <20250916-flexspi-ddr-v1-0-69358b5dc862@nxp.com>
 <20250916-flexspi-ddr-v1-3-69358b5dc862@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-flexspi-ddr-v1-3-69358b5dc862@nxp.com>
X-ClientProxiedBy: BY3PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::6) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AM9PR04MB8892:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e1817a-cdf3-42ad-04df-08ddf536f196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j1wp7QPcB0xA/PSi2Hm/xLiXuW0cCibxEnV2FSqzi1iwNSqfHqIS549FJxlZ?=
 =?us-ascii?Q?Q2WOvfcnBoGArCOTdijfkkg9Dun2XSi/hUUJF2SBJRabejXQ6fg5Q3FHM2o/?=
 =?us-ascii?Q?YbBUyBEcekMbcy9yriMMBZ0G6B+RxsxUCW68I4BPdws6Bs3pzKhbMnuOXcF+?=
 =?us-ascii?Q?whY948V6xXG4So+vkbam4IwW1+ZXW+oFWho2jBKEOS9maI2Dz7hy9WUKdWtH?=
 =?us-ascii?Q?iWp4Y0hqIeQuG/UbultYbY3UzVxmwhlaZbdEWhUMCm8niTbKvNZOvyGxJ7xW?=
 =?us-ascii?Q?XzCZVAquE7p+8a12TbAZJG6uT7fCXOy4b5YC8Tb02t43thr2Arcf9ks44XKD?=
 =?us-ascii?Q?tj3ubKZeJAreHsJjijAy9LKn5yrZmJ7ZgYf/HJGk7IOYqkLr8CPKe/KEKfpj?=
 =?us-ascii?Q?r+HnYMbwm3uQz46iRMbuO6E45dBa0l+mj78kbT21e5yupwRfp9IGuofEtMkT?=
 =?us-ascii?Q?bvJWQUXOO23mRan1dSZI1d9AlREx8syTrKU12m8OLr5u5uVoJtCJJBYTuQGs?=
 =?us-ascii?Q?FeC4C4oIcX8ZMXhRNkrOyMUypZiHwDzPzKGoiGqkl024zb3SUt7IU0JjwV5J?=
 =?us-ascii?Q?hgjbpj3ZLebg9u/o8AKBfUcbGNzDFlKAq1B2+N/kfZGjn+3Icvuo3aZdB3Il?=
 =?us-ascii?Q?e1WcINWvOqCpAJ5yATsacQjWrOkfURTcm8q+mdgDQkCK2/Sn2+xjNhwRGLq2?=
 =?us-ascii?Q?yJzZvlXy/w5YYbMu0xZigv/DpJbLEcFJ8HkD+Y2vnZW2XG6G/tBRaQIu/79B?=
 =?us-ascii?Q?PbUEJC7xSJGvl6cNFm0hguu30BZv7/MV5OlRP8TsR2UV7Sg+0JXAsb5VY7F/?=
 =?us-ascii?Q?ZfVhquL8oazkxaFNhkOKgTGZ/ccX+21qns5o4OvfwRahO39R3dx5aZSVcE37?=
 =?us-ascii?Q?QaXqGlrHbzpEcZsLK/vwdShgYaFdMyjqUeWjbicQd1ekBXBDpaUsmRbs0sGU?=
 =?us-ascii?Q?UpvH9AibkP6dyI8wsNnpZaR2Hzm7+GBIXiWNQBMiKjicNEYWewc1rivpGA1Q?=
 =?us-ascii?Q?auRtGmG5uM89mmZWeyD5qLTqgUmi8LiOWoIb4IUQ2CtMqu7GMv1enmcBuOKA?=
 =?us-ascii?Q?pS0eCXtJxClA2k7dEG7rcL3G9NCxkQ7p1hOLFWREh4K3JBm6FS+cZFqrKarx?=
 =?us-ascii?Q?0xIFNSLaduWKFXRF4M1mxMhYcTFODC5oSukJfYfjzirnuSf6KqZf8bSy2WHz?=
 =?us-ascii?Q?I0ufxlR414X+WKbXMUw3E/2osD3WZ6kQjrs2qYvcjTd0RunwfVFuk0qnVt9o?=
 =?us-ascii?Q?pY82l1z6LOboA6w1+Acz9rN71060LpYe7t4lHCleKJLwQAH/yVfjZmQLmGIO?=
 =?us-ascii?Q?GlQ4VFqglv01QOPuOeuOOWTm5Xl5UexeaMyQwxpFstzcMB9ggZLjvk68aUwV?=
 =?us-ascii?Q?NevRKQ4SFBEogwubvfJUGgeYUthLbHOdiJ2VUgWzv5qiqDQmuDQ3kl34h/r5?=
 =?us-ascii?Q?yY+XNlaCSPIzu5wbAb6PVvgtjq36ZQGgwP6Uypr4gH6MYBqc81N+GQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CtdViF+eqEMdWa96LZvVuK3OiqHE+VNAkP1yeTxk7IAG2gNeHNjrw0fDvBlZ?=
 =?us-ascii?Q?NvmzpVAoFxJHbXtSa2fLF6nFHt2i2++GJ+LwvyO7BmrGXTV3/xbl9JyOjhO1?=
 =?us-ascii?Q?LMd8ejuaQIxnQwbF/idRiahys9bj+t4C2Sk/bKBmvJICppZSl1FGblOwTmY9?=
 =?us-ascii?Q?yotXS3yQ0zMaefzt2sMXXqejAGYJ9KpcglMavwSq2w+eWbYQQHyzldVOCOVc?=
 =?us-ascii?Q?7Q/J2IF8bcq7gC6wVJtnnAiqROZTy9yoVskPhDVFLQ/EdlBgwuvK8BWN3+Xm?=
 =?us-ascii?Q?rHIXDyJNN1CK4eE+ZD4lMGVdpIBSi0bRaH4Q7Yh4g6lMQ8mLSPND0Y9Q99iM?=
 =?us-ascii?Q?NTThOg0SK1eusCUCZg0kmNCn1pE+tp8A1PlAmxIFTxbeQ1t7ZNr2S2HlDrII?=
 =?us-ascii?Q?W+Fhkhz41inNWKazAoWnbwogwFfV/19i7FhxDTeQHObENKoztIFxvf89fE77?=
 =?us-ascii?Q?sW6iyiOMu57+Hz9NDHnZur/X+Jg+7xMpchK9ZinAPiSAGAJ2eMGMTJagWIrH?=
 =?us-ascii?Q?SGHlFEqGWE9wlQiwEexxh/SarxkLm8mJh6/ZVVXvTXVndD8EoJPOZ/nIJ+KX?=
 =?us-ascii?Q?6pTFOvMqBPTJdZHpuFkEBVnEydolKAMCcqONEOMrnP1GwnqbpM8iUJavrZEx?=
 =?us-ascii?Q?yFV6YxTlt1CdqrBZrdtgzv7F2/6GnVKGVyqpaAqUROED92zK0+2zlzk9m8Lc?=
 =?us-ascii?Q?4QcDl13k460o/REFs4uLOdRgc8GhJ3VnDZHSEiAW+u8Drg+7GDXRnF7G7obV?=
 =?us-ascii?Q?WjJIYzptS1tXnTCOWNEoJ3BymxMdVWdqTEK83xEewif8eKOD0jWhQDCUod54?=
 =?us-ascii?Q?WL2jg8yx6gxaXYpE6GgF73RmEL2FiVn37LteS11D22vj8VZUrrRLk4M9Ea+s?=
 =?us-ascii?Q?WaUmlu2pyTogiXX1k5xZBgJ1dsqj5/MHCr2lvlNFaUy3ezj1nNqEH4M9nMfs?=
 =?us-ascii?Q?lRvHXv5ogdA6dGNYzdF2vuYMpjKX9bPrM0YAnQWHXZ5/u9PfFFQ3N6NeHlCH?=
 =?us-ascii?Q?5z+C8csNDH9RMWWCIgacH3uX58N/s53LOIe9Ro/Oc4Pg4eTy3xZrChZXDulr?=
 =?us-ascii?Q?SPtWGE+ByCPYJVWTCIe/GHViTbekEl3NcvaUhN7AEXO/L9cYZvJi6FkeyKrY?=
 =?us-ascii?Q?19uzCG9rW+1ZE3BXpJniyxNQaLdnHNU9ohOJIsYk5tV6o2a/AAlk3Ez7yjrf?=
 =?us-ascii?Q?xWOkUTuvZVeW+o4Ob84eo7hD+iUYghj5A93imCKTTks6g1H6qTNO0Ww+fNX+?=
 =?us-ascii?Q?KMoocS3ChUKg96UOBZSTRLL42wJ9LNVnsotpSSWFEk4mG6jkHqy5bQA3XAn5?=
 =?us-ascii?Q?6/Hb+b2MA+m7zeKevVFpvc40AkWk//ECdQWC+RJr8a/wMdn6Tz21sJ66FoZz?=
 =?us-ascii?Q?hDYmVJAn+kRvvMxpOAgnRIiMi6lVHAVOKJWoK1HDHjTHES6LFGEpduMmf33n?=
 =?us-ascii?Q?7jV4xezw9S2dqzhfMhLu5+BqZqK1MNSwkkW0uph47McuJJCkF0ntT3Xu3HCm?=
 =?us-ascii?Q?KDBn93yJzknCUbbIqvDDGA8gvO9Iv/31r+EbYxPPVFrkz94lhRrqixc08PsM?=
 =?us-ascii?Q?QVVFg3TeZ7pYFLMbmgu16hQpPOO0ARZMfHCHZjVq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e1817a-cdf3-42ad-04df-08ddf536f196
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 15:37:28.9227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sH3r4NmzeO1BkG602qtfNwpQfRvjwmFTS9Rx7vDbn9lWHWr9ex7X5cZqsINhEkeA0tB62LL0UGO4aU/W/qAMdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8892

On Tue, Sep 16, 2025 at 03:56:42PM +0800, Haibo Chen wrote:
> flexspi define four mode for sample clock source selection.
> Here is the list of modes:
> mode 0: Dummy Read strobe generated by FlexSPI Controller and loopback
>         internally
> mode 1: Dummy Read strobe generated by FlexSPI Controller and loopback
>         from DQS pad
> mode 2: Reserved
> mode 3: Flash provided Read strobe and input from DQS pad
>
> In default, flexspi use mode 0 after reset. And for DTR mode, flexspi
> only support 8D-8D-8D mode. For 8D-8D-8D mode, IC suggest to use mode 3,
> otherwise read always get incorrect data.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/spi/spi-nxp-fspi.c | 52 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 50 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index 6b3e6b427ba84734a2359a964635a8f05cd146fd..be1e56072b94f38af934556055e321d9834bb07b 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -400,6 +400,7 @@ struct nxp_fspi {
>  	struct pm_qos_request pm_qos_req;
>  	int selected;
>  #define FSPI_NEED_INIT		(1 << 0)
> +#define FSPI_DTR_MODE		(1 << 1)

Can you change to use BIT(1)

Frank
>  	int flags;
>  };
>
> @@ -657,6 +658,43 @@ static void nxp_fspi_clk_disable_unprep(struct nxp_fspi *f)
>  	return;
>  }
>
> +/*
> + * Sample Clock source selection for Flash Reading
> + * Four modes defined by fspi:
> + * mode 0: Dummy Read strobe generated by FlexSPI Controller
> + *         and loopback internally
> + * mode 1: Dummy Read strobe generated by FlexSPI Controller
> + *         and loopback from DQS pad
> + * mode 2: Reserved
> + * mode 3: Flash provided Read strobe and input from DQS pad
> + *
> + * fspi default use mode 0 after reset
> + */
> +static void nxp_fspi_select_rx_sample_clk_source(struct nxp_fspi *f,
> +						 bool op_is_dtr)
> +{
> +	u32 reg;
> +
> +	/*
> +	 * For 8D-8D-8D mode, need to use mode 3 (Flash provided Read
> +	 * strobe and input from DQS pad), otherwise read operaton may
> +	 * meet issue.
> +	 * This mode require flash device connect the DQS pad on board.
> +	 * For other modes, still use mode 0, keep align with before.
> +	 * spi_nor_suspend will disable 8D-8D-8D mode, also need to
> +	 * change the mode back to mode 0.
> +	 */
> +	if (op_is_dtr) {
> +		reg = fspi_readl(f, f->iobase + FSPI_MCR0);
> +		reg |= FSPI_MCR0_RXCLKSRC(3);
> +		fspi_writel(f, reg, f->iobase + FSPI_MCR0);
> +	} else {
> +		reg = fspi_readl(f, f->iobase + FSPI_MCR0);
> +		reg &= ~FSPI_MCR0_RXCLKSRC(3);	/* select mode 0 */
> +		fspi_writel(f, reg, f->iobase + FSPI_MCR0);
> +	}


	reg = fspi_readl(f, f->iobase + FSPI_MCR0);
	if (op_is_dtr)
		reg |= FSPI_MCR0_RXCLKSRC(3);
	else
		reg &= ~FSPI_MCR0_RXCLKSRC(3);  /* select mode 0 */
	fspi_writel(f, reg, f->iobase + FSPI_MCR0);

Is it better?

Frank
> +}
> +
>  static void nxp_fspi_dll_calibration(struct nxp_fspi *f)
>  {
>  	int ret;
> @@ -738,15 +776,18 @@ static void nxp_fspi_dll_override(struct nxp_fspi *f)
>  static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
>  				const struct spi_mem_op *op)
>  {
> +	/* flexspi only support one DTR mode: 8D-8D-8D */
> +	bool op_is_dtr = op->cmd.dtr && op->addr.dtr && op->dummy.dtr && op->data.dtr;
>  	unsigned long rate = op->max_freq;
>  	int ret;
>  	uint64_t size_kb;
>
>  	/*
>  	 * Return, if previously selected target device is same as current
> -	 * requested target device.
> +	 * requested target device. Also the DTR or STR mode do not change.
>  	 */
> -	if (f->selected == spi_get_chipselect(spi, 0))
> +	if ((f->selected == spi_get_chipselect(spi, 0)) &&
> +	    (!!(f->flags & FSPI_DTR_MODE) == op_is_dtr))
>  		return;
>
>  	/* Reset FLSHxxCR0 registers */
> @@ -763,6 +804,13 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
>
>  	dev_dbg(f->dev, "Target device [CS:%x] selected\n", spi_get_chipselect(spi, 0));
>
> +	nxp_fspi_select_rx_sample_clk_source(f, op_is_dtr);
> +
> +	if (op_is_dtr)
> +		f->flags |= FSPI_DTR_MODE;
> +	else
> +		f->flags &= ~FSPI_DTR_MODE;
> +
>  	nxp_fspi_clk_disable_unprep(f);
>
>  	ret = clk_set_rate(f->clk, rate);
>
> --
> 2.34.1
>

