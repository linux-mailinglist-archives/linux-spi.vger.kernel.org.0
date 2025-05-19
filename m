Return-Path: <linux-spi+bounces-8181-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A39ABB2ED
	for <lists+linux-spi@lfdr.de>; Mon, 19 May 2025 03:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28741894A58
	for <lists+linux-spi@lfdr.de>; Mon, 19 May 2025 01:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19451189F3B;
	Mon, 19 May 2025 01:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="T9NwH71v"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010023.outbound.protection.outlook.com [52.101.228.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC458B67F;
	Mon, 19 May 2025 01:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747618755; cv=fail; b=FWGUzlT0+C+fHaeBcHir0fbYT6HkpzAmfqwMoQ0DZRsj5spmfyXjTFATw7eZXASobPWXXJ3LT3WKp1f1sWU1tNxzNbUvUK2jObpY36/dEW6l+H6Ry3hfr5S9pGyK996aM1AlpufHmaGmTaXBPwhHIWEi2vHD7W3ilWjpdVUBmNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747618755; c=relaxed/simple;
	bh=qaxVFb9REIybKXEhseqtPX7on+UoDy0LeYiEWVT2MyM=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Yh2kuZiO3Brx5+cJnaoPxujX5RG71Ab/Je11sRiXLClPFf4QIH1ug+vDiN0bxaLX90Hgl9l5X9BOfx3DYcTAUPTru8byghC50K1L5jihb1cxxKKHxbZPy0rA1vc8e5MFCv4lIBckZICnZsxJubm9DQtwyBxpvIVCguNTAAjLdOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=T9NwH71v; arc=fail smtp.client-ip=52.101.228.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2RCNqhfhRSchNkqI9lgmnQjBRtbRdnU8q0x+FuflFlnW2soili+7FzpDTqfdKxbzYWLxrUNoxMXH75B5/zW14GCz4JfXB62dZ/yX+n7IGwi5xiQYepF1CU/WEyULc5jTgSRWE20zCGtWwzC7mw9j7LeoCFM9N4qjTYz/aFpylISv5ASNVUpBY26SE28FUrVzhRdraiLdq/4tP39NhAt/Nsrt6Km21u0Pv49UzyOp3lg7KxIrBt/ks1o2Ku6CWnEe7vrP+K2z31gGQqVtZLbheScd0m1s57HDtVTBRzVGuOvwfe6k9JNOHfpGUjNdy9zdy1gzQpaUsV2L1hlYzaY7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3B/11+VbxCrr+7tmUL6VrF0S0AHqagrNY6UCMQwkZp4=;
 b=ac3S7hbOTipbZJ2/bGYBJgN2yfUXHe2TzvLuQ24sZcFn78v6Uezb6SkZlXzEmgY4NxzL0eszvi4IrLKdaB2ScoshVbIjd/qYZdRKFb0tsVXOdJt3s1MZVOUY3NzI6kGu1tIZ3He4R/ikvwrp4nGxcnFDXmazOgd1n1cvUCdzngpwkHZh1yR5sFS42sqlShJSTv2bDTsn0yBIUJ8/vlMDSqy0NUtmANdwYrrMeSsfE53Bv692AHaO5Wg+WkmN5Q15nQglwRkE2omj2DFCPCWjYSkBuGu2+DM43b1Gdm6rk24hEDMBHc4LImsz93WFsBpljuJgQfisEmsR2oiuAoctTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3B/11+VbxCrr+7tmUL6VrF0S0AHqagrNY6UCMQwkZp4=;
 b=T9NwH71v0DxsDXYeUSRcvOUdVNZhgnOa3cHdzNUWnoiYEtGksIYip2EtUmnh4aup5B5Ra3xL6dKvpu7Zp/yr9esjBXZkxGATqGbGN/HlE2iIltjH1Op7tSPpcwf556XnzfsL7xXL07get9Tsz85HpnpE2iSz6pwC+ehdYPXD2mE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYYPR01MB8184.jpnprd01.prod.outlook.com
 (2603:1096:400:f9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 01:39:09 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%6]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 01:39:09 +0000
Message-ID: <87tt5hqszm.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Koji Matsuoka <koji.matsuoka.xm@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-spi@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 04/22] spi: sh-msiof: Complete using dev in sh_msiof_spi_probe()
In-Reply-To: <88d271b2d16c6ad7f174858894573f91cec1bc90.1747401908.git.geert+renesas@glider.be>
References: <cover.1747401908.git.geert+renesas@glider.be>
	<88d271b2d16c6ad7f174858894573f91cec1bc90.1747401908.git.geert+renesas@glider.be>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 19 May 2025 01:39:09 +0000
X-ClientProxiedBy: TY4PR01CA0008.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::9) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYYPR01MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: cf99f8e0-88f7-4701-e545-08dd9675f351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+8iK/RF9l2LvJ/A2ZMEL4AjL32T7PmDAOIA5s11Xw+kvt2Lure/k9cqyeKoi?=
 =?us-ascii?Q?F7LkJHexZHvJIPNHC1lQfmF74k/frNli+0UsnUnRai9te++yvImJnTMcItbF?=
 =?us-ascii?Q?PpPlg4gRbQhDobMrC5IExj5VAfNEBPXW38owChcnT2Q9SoOb2bffCNwvrD47?=
 =?us-ascii?Q?1RBDE7Gm805LA5dMbx2RVnIk/u34HFPdr4q7BZX587uRfSGxSbbH3ibz87lO?=
 =?us-ascii?Q?v0h8YU7Ub7w6qfIZcKKwFDFn24aaWBXfNKuMJY+1lHXgCSY/67esxX4/udIm?=
 =?us-ascii?Q?WjuJegJCeXDTwiF8zV1F6lF/HKVvT0tuMzWhgkQY/wIdTCLs/+qCaUZhqmfM?=
 =?us-ascii?Q?HPWcqA8I0jZHiOt3jip6Pr1KPNNelb6RzQ5Rw/U6Gm7ukN7rcvYVAQOHf2a7?=
 =?us-ascii?Q?1vbB3ooJqXiT+oBzOAWjs99hHk/YpFtCXSx5tuvlCVw52/El4+LVvjVakqgn?=
 =?us-ascii?Q?0/xNr/p2/SJTJA091SeE/GGYKtld0ro1bCAlbc94DfHcoKMBLhvDGT7Myut1?=
 =?us-ascii?Q?F8MrWqZ68D2+Dov1Fs2OZ49kLuGm1C1NlZxjX+AvJs7yohhcgQRPEeuolsW2?=
 =?us-ascii?Q?rA3TpICuIZc34UkqqYGbtZuzX3BdpxmjXPWl3YWCueqU/D01fnXCvwHopUwR?=
 =?us-ascii?Q?bf4WveGG6297M8u5EJjKO7o4G6XfIkgQ5RLFfIXg3LyQaqdwLk0Ifx1qeZj5?=
 =?us-ascii?Q?ohErFl+w66Al1YoCbPcU2xRDlWKm2M7W7W7OtTQJJIR9xDdmyd66UjNtLYSQ?=
 =?us-ascii?Q?atg0KT3dpPzUob9dE/Mq9cO/a7puOig6gfMKvGANQ0NGfsICjZIeKnDKtDp5?=
 =?us-ascii?Q?P5IANxUllYc/9WqwsEGEBQ7vJsmPMuQC0be35jId8pu6bYtt6DM9sHhZu5R5?=
 =?us-ascii?Q?46zcEBTrQ+ExueZY3pMfqOSrgAUHijjFsQNq7DkJkFA+SRamfkIco//4ntmU?=
 =?us-ascii?Q?x+nLTCzTeT7xqB0AFtI8TAEtanrdJk96QPpOmLzU0HliuKsLSiocig+KceO0?=
 =?us-ascii?Q?dfXNF+4LbZGVcow2F0/dWl0/2dKwRT/B/u+4Ca+7GDNv6e4Nxzhl6wJ9UHY1?=
 =?us-ascii?Q?LGeKsQKJpyglGewAnG6EsoQKjzR/K5ksaleisudWlAyXcwNCcnxqFwhThB9f?=
 =?us-ascii?Q?lC+QoyiUUyC4iw9kLvrmeeGFPKUmFx6S63whRHUkZVm6W7fasUYB0Uk4vRyW?=
 =?us-ascii?Q?XdqeRjFQW2ZW4j4SZktlDqu0R4lnZri3fypAXD+JgDOFXSXhS8Pus3HEWTQz?=
 =?us-ascii?Q?cOK/zvQTZLlT44N/IU9h5jTTrqyUA9hE2dSYw/4SDVZWXTqKXyBmBZTi+m4o?=
 =?us-ascii?Q?Ic8Z33VqzGKadIfOLjUewfcrVRkJLlSZ9QKbdNM9yg6wNquO4HpgNIOBf7kj?=
 =?us-ascii?Q?16KpCRidhMfj19LQMHg9PRJNy4hrfKombbNWZJi/DGAktXUVXhZ5dSK8ldCy?=
 =?us-ascii?Q?2zTIz7THqJHTeiCknrFUaxCe6Zq4JfZfSlR34iX7jA3bhYgw8Oh2Vg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OjpmC4QBJpGIYiwpv4vFEzaMrxqA9MgFKPLQi0+3LXDzNXsLyvytDI2B+nRK?=
 =?us-ascii?Q?1RiEmIIRvwNp3wu6iziv+grbzDguLhUlCFhH09321v/3JnT04Wqf/oQNPBss?=
 =?us-ascii?Q?yPmK6xaPP8RYi+PQcLs7FZeXWjdXV7vUPxzus9ruHvMwV9jEPYxIIifsJnZ9?=
 =?us-ascii?Q?d7dSaf2aI9nn/EHCoJXM7BIVgvMC+wjaFXMi5txlbaa493JyzJihv9/D28/U?=
 =?us-ascii?Q?TZYIWn2Q33rOqPs9t+NfpPQGbVQrx2QUlMkEgTq3Xe8F/pYS8xJUmSYmBK4X?=
 =?us-ascii?Q?cUsbQ5BDDhrfxBGZRz/NjtIUYNYbSQdjVsmM8FPrXPrBZgOOWYNbB9YZKkTX?=
 =?us-ascii?Q?Sc8TFAtc+BFFpc5/1zCq+VZz9fbdv60olF4BnM1KhZGLtx4j565j2d0gcXES?=
 =?us-ascii?Q?of8O5pNrjH0gdsA5T/F+0Q2WdAyCr2uozSnDXt/4+gndRAeA+TO4hU1mRdLM?=
 =?us-ascii?Q?CxJIs6Sn6kIdVv+B+dSeFoEnaWM64vV7mO6vT+1Az+lHD4E6VXyc58Sp2KFB?=
 =?us-ascii?Q?4k7s+XFsbxAvC2hD55wHgAq9pTnDD5kqlCf1tPxNGpWAPfYwK662D/775FxA?=
 =?us-ascii?Q?8elrqppinPZEatYcslS0osTd+vGLQjJ/FI7hJyR0BUUaIlZof0V/VLbzO8zT?=
 =?us-ascii?Q?gaiWUrK2QsVV92taJv0XcumvCGrAtWA+w9sXqhMw/Fks5iZusYtV0hKtHcwD?=
 =?us-ascii?Q?NfogGVQ1v58z8KBPJSYhFZogUXmhwrHlvglPO9lt3Sf0j0hNH44YVb8U8QBM?=
 =?us-ascii?Q?c4GsqS1dAwU9WzejGaH/US06/hHD/6mKIsweMLHDhKkmpewKutp40xDwVYn6?=
 =?us-ascii?Q?O7dG9jSubwoNx/WuiL1FxwPAmO55qfq7KwsLqMMGNHGBiVsZ7pVjbyfXJBU7?=
 =?us-ascii?Q?3wqbUugRsXHUQk4X8qIVCK0MaHCfodNkeZfiIyAfArPf9YqQlcXvUZGs60yD?=
 =?us-ascii?Q?B7/+XAmyotR3TCI6k/QS3fwzwcbyWnGUhCDKVGN3WRrQCorFJQDcG9KxbXzq?=
 =?us-ascii?Q?017r+576bFz4+ClYo55aM50AsRta62MyE3oQAh/adeNuglzVjxlwtyovYwmC?=
 =?us-ascii?Q?JUS5ZSjC9gzo+oofMNszNBjhdnZEcHlPE6ZfcVycLJgye9siqEW8ZwQQv3Ez?=
 =?us-ascii?Q?H6kVcRVSZswwwOicPgt49D86ph3qDO/foStKUJVANu1NhkSKvLWiv7mWIWQO?=
 =?us-ascii?Q?KYb7QhnI1hoXJtgOW+cCK3YSv7H2y7EzYWe7a5CC/c+g/cGs0xI04+NHqYS8?=
 =?us-ascii?Q?kBFwfB1YeULTOQvTuHb6IQfDcNp2sn7JBaNNTFABNEsPOZwF7tz+v7XSzdXy?=
 =?us-ascii?Q?uEnXLIrzJSwvGm+h4Nsxa8EybaFxaGJ67lYf7LXs6I3tvGLFhmGtPBhUb0ZZ?=
 =?us-ascii?Q?xwqTntdE+nyFcg7q9FWhhDtzil//d+bi5AF80ab4CnWSZ7Sk7LOsYazq1Tmw?=
 =?us-ascii?Q?qkhgIzsXfgo+nYEJRJp3Z/PL/lUqKeATCI17K+3ExWVwyciakSw8qj8M8BPZ?=
 =?us-ascii?Q?V6/n2OVac9XmwWztqF+lnO5l0d4jq2UjIFmM2Gw63dQdt1CmkeJ1YpO9+HP8?=
 =?us-ascii?Q?MsA6oPfeMakd3iC9xn4Lj5uobwgUTmL629VjHMyWMcNBZ2hBIyDahFf9FhxT?=
 =?us-ascii?Q?18rR+3SXuUo/96NtmGi62Ig=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf99f8e0-88f7-4701-e545-08dd9675f351
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 01:39:09.5847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VVzqmevuwt6ShQIkBK/Rt+//69CZX24GRB55OjxeUqVWIyYJcGKUpHnJljJ6v3tc9lsB/2YRu1mLQmkXuT6MuwFv/KksUr1NUceXG3vhb6y2G4zWOtUTDaxxUnAwPPi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8184


Hi Geert

> Commit c4887bd4b35b225f ("spi: sh-msiof: use dev in
> sh_msiof_spi_probe()") forgot to convert one instance.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> v2:
>   - No changes.
> ---
>  drivers/spi/spi-sh-msiof.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index cf93c2ca821f84fa..367622985fea2a04 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -1332,7 +1332,7 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
>  		goto err1;
>  	}
>  
> -	ret = devm_request_irq(dev, i, sh_msiof_spi_irq, 0, dev_name(&pdev->dev), p);
> +	ret = devm_request_irq(dev, i, sh_msiof_spi_irq, 0, dev_name(dev), p);
>  	if (ret) {
>  		dev_err(dev, "unable to request irq\n");
>  		goto err1;
> -- 
> 2.43.0
> 
> 

