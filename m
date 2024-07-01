Return-Path: <linux-spi+bounces-3713-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C84291E405
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 17:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC541C20CD8
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 15:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCFB16CD04;
	Mon,  1 Jul 2024 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IrxnJbsk"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AEE53AC;
	Mon,  1 Jul 2024 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847495; cv=fail; b=QZjDDSLdqOOveUg5i7pz6D4Mqw4cIu0n7LuXCJYxC4PLFY2F2uodypsM+ofUzTZeP9gA9H7twYGWFbtPSAjlzMaVQTHKoRQp3nB/m7KWCntr0iVj2fSAr+NWla9EH1mBi1Wb9vhKj1S2BqzNjuZ8S82ols87+V89/8I0oYcGUT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847495; c=relaxed/simple;
	bh=XrtnskymWlrNdhzTE9O2GC2vycMTMIN1ewR94+3iC7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MYehsatEX5yiqU0pgMa+JNPznGN/H2DESKdYUmRk94Eblo3eemzCjOVsKpqfWkISAnCyPRlFwvfMyXXpa6sJEJiWUy55R89rvQI1mK3B1ykwIfbatc8G7hhJ+28Peu6hcxuzmjwHr0xHBj0AqJ6MmmI/vQsFQkqUrngSWWJ9Vf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IrxnJbsk; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERIncN+pjAiUMrCkRA964uPdEMFgUAR36cMsg27uRhbTSXd3k06RGi7ypE5iyZEr6fIQEOiVxFuqkLYVEcZqqUJEHcZ2IHq9I4IZYIJAPBChwQTqpel3uRu0DRDbvkZ5hrds6tnnxxmiqjNxVY2hro9kXbBw55eImgyoU5Crsrz/APOpyE1ryD64VG1sdvphftnforwQXOxsrRrp+JZGzYqa7NLS8hXKhBh9RRLo7hrQHtVe938QgeLO97JMZJOop0My6bIv3TFwqcHxF7g9XQqzBhLoPbl6dh3axAbQOF/rMQLhLBwu27+FL95g7flkqbUK/BY3Ft2UJy26FLys7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ramfOSs1HSP7r89s/jeK59wtK9VBqzziercSpo9rhy0=;
 b=I9962RDz8DSov2dmB5UOZMyqzW6IyxI/LqoeFA7AnOiPshbSyiaWp9jjrF5rr+4V9G+WincpQh2uZAQ5k1BoWqpYy7SpaqBzz4s3AwL31O/MFNNphU7z3oJZFfgBxeeg1kgxI/yfIB60c3GrFQdB0Mf5uP/I1/HFVwfeDl5Fgfj/hLOnxQvvCd/mqVzANNbN1OT9rDGnxDCc779DaQq+M2scEPljWeUToenEGiuibRVBMDI6bHgYSFsqXsRn6AGcKd0/6195ACGeXygwYd3q9Hfk30aC+kLd5GvXwC4z18xB7FWi8awDV3Bj5sksimN23E8FXliHp83flCS1NfVAyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ramfOSs1HSP7r89s/jeK59wtK9VBqzziercSpo9rhy0=;
 b=IrxnJbskm3JHBQymZd452RgX0HmmVnoTSuIQwiK31v4qAZdU+JgcfLCT72Km+43vGT7jfgH+dUlTSv7MkqScRqR30mBRmqJOesDiopjksdsq6pU3kobYO0d72l9E/059TL4b4CxRHf0KT2lrhvjWrp2EtucpYTpmthXIynbXGFU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8410.eurprd04.prod.outlook.com (2603:10a6:10:24b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 15:24:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.022; Mon, 1 Jul 2024
 15:24:49 +0000
Date: Mon, 1 Jul 2024 11:24:39 -0400
From: Frank Li <Frank.li@nxp.com>
To: Mark Brown <broonie@kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Kuldeep Singh <kuldeep.singh@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: (subset) [PATCH v4 0/3] spi: fsl-dspi: Convert to yaml format
 and use common SPI property
Message-ID: <ZoLKN6a2qLXrR+oX@lizhi-Precision-Tower-5810>
References: <20240624-ls_qspi-v4-0-3d1c6f5005bf@nxp.com>
 <171984553050.67981.12522537296340689285.b4-ty@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171984553050.67981.12522537296340689285.b4-ty@kernel.org>
X-ClientProxiedBy: BY5PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: ac820209-a560-4f2c-8d99-08dc99e1f275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RKBDAbeta6K9AkuD8Wp2Z9AQAV6Ek5zcaOERWQkHlnG+G+bqhwPDj/2aEpOk?=
 =?us-ascii?Q?2fk00Hm34AndOzZJOc5lLrJSroPlPohEUhWYaii2EkzwEYvXNyRwxDQ37nXc?=
 =?us-ascii?Q?oKx4779KnKes70R955p7y0PgWwm1sswddmtz0PFeFwQ+nz4JA7OhMTLtCPs+?=
 =?us-ascii?Q?THrFAsFPZ0XQ4MhycjvbHIKv+9rhKCOqC2hI1tZ1QnLa+E5gaGPtq0XQ6WHW?=
 =?us-ascii?Q?oGHU3wGqUDboo769dn3Nw1jSdSU1HxzmOiYnjPemyzcYDO/BeV1YjIOgpV2J?=
 =?us-ascii?Q?x6MlGNORA3psi/GJ/xH8ImPo3jvEpTIJ8HQa5g8hbXqRpDOIuwGMbBfPmOk4?=
 =?us-ascii?Q?NyHLsLS/bS13te5D5rfKElqc7TFKCSYtCnMGIC7r9x5JZgrajuwrtcHyarbd?=
 =?us-ascii?Q?pVl9WmVGWdEb6Yj+P7vJjRxV59lear7qB8o7Ozs+/qnzpwnPFyORLMubUDSB?=
 =?us-ascii?Q?BD66XM/lp6kU7E6sKnryfyTHhlWz8wqDh2V1iyQpDUd6lFBF+7lrrE+lK+Ee?=
 =?us-ascii?Q?mEsGFv4WXLXMn6YhdDhPI3mstEjyUe/Nsp4ZgOAgjFj4v+tHQQNJEQmdI+Id?=
 =?us-ascii?Q?C0IW3qdd7sQjYcm/czlzSuxM7EmtXeZK2im72OkzighGP/PYjb9lDXFgYaaJ?=
 =?us-ascii?Q?3gkNWzcjBBQI4/xpVxnIb3XIOtQ1E96dHclNMay7egu+KID8xYIH6aHfXTvz?=
 =?us-ascii?Q?rk/0cVQNnFKwIAFE3wSMxarKgKl8rSYJZOHAd2sYo9eg9fxUDPg+B8aM5DL4?=
 =?us-ascii?Q?pfaR5pPCiAyT3JzG7O4RrYxXX1bNu1RCIgcVD+ZKOIBIOLxkookgbM0t79Iu?=
 =?us-ascii?Q?xSYlC4MxqHhm0rWTs4o+ya9sBSDZvzvGe/iODpfGKzAMteGtdif1tLlrf0pZ?=
 =?us-ascii?Q?j9wmOdqXIanVwKbfRHDWQJojnhRzquIgLdyRV9ApjllwtXcIZzbfj0c3lLXT?=
 =?us-ascii?Q?jueNYEIYvvq81b7XWzn2qXH3+P+4z0rGBrqaeoxJQlXbB9vsw6Qsnp5QptUE?=
 =?us-ascii?Q?hG0847pv97XiBHnVXnDcRw18+Sd+KK9RzsXw0w38cGImBw5exLRsGhKy8kOt?=
 =?us-ascii?Q?ajb3nJU9wduC239updDCxS7QRYa50LejwNzKmtDUlj14cuO3mk6gFnKDO+gK?=
 =?us-ascii?Q?b8MW7U9E5geclyYtU5jnG9SCtbyDQf3ciMuLbjI003LYA9kdst/LPQqBqwMr?=
 =?us-ascii?Q?Kc2b2vnUDrhEbX2u7YEQi1YKWD0UxEXmQ9n2qCjaM7CGm3AiuR0P/kEclX+G?=
 =?us-ascii?Q?hZM/oZtEEGRtFgDfIGEWA4mFJycO23QRHZq5ceVKmfXGWk9caPSs+dJTQqMc?=
 =?us-ascii?Q?jnFJOBavvDI0xgskRVsl8sN5Re1HX/+AFb6D2WnXMqoIiTC+EzB67pdXVYHp?=
 =?us-ascii?Q?pIc3n+Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MNlzjc734/xCb6PZiKP3auTG+eSACIOjQQcIwvdQ5FbQ3kS2BtqqUpBSZp+I?=
 =?us-ascii?Q?7D0tdGtex1rIGSf+d0q1WCO9gvLxiZg+Mhw0hDgOJlYENKZFKQXwrZ39gcko?=
 =?us-ascii?Q?xl2qxXRZrWuGbVFjOro2q2dNMfMXo37+ivOUsGKJCDR6t3cCRsLgURsBINtT?=
 =?us-ascii?Q?ztgpKWT5KgnUHMH3kXZJvwP0o0u1LNvTQZKG3PiaMHdb1vnT1qx5RF+7YozC?=
 =?us-ascii?Q?F36fovuSgrsupMNOJeLnKTsjobm2s/d5hChiTDuNBe1PixXpL2wqhe3GYHnN?=
 =?us-ascii?Q?CNKDOXuAJ/vM10j5IUgIF2Ccgq7D/kLnVyIYLZ888oBVN9DVLnIvYPVIR0Fq?=
 =?us-ascii?Q?Yxt1SoHyMqJfuwJo5V5d2NFjjpkka7pX/9fOPXeRE4fNfCKERL+Rrly+5Z/a?=
 =?us-ascii?Q?B2EPSOfNC7R6rIuV7rlt/63i2fzZUEP8LtseZKMmGTYzvgl9ENa79SXyfTko?=
 =?us-ascii?Q?fOzKRpqp8NXmMMMxsEPGdJCReNNVtRShAbfwC+3NaF6DHgBOSObq3lDjqCKz?=
 =?us-ascii?Q?EjbQMukm2p7e+sZBcmv9HhfYbgZnA9/m31gdFEdktB7GSbFkoieVjvUfUeEw?=
 =?us-ascii?Q?M5XCYiloVE0HLw41WAl6QlpNx1goJt5dG+hCqUr/2daDUF93VY+4kNmgLj9g?=
 =?us-ascii?Q?Vgl9aMnVAOb70MYOAPBM4x4rMGBdDb/dlcAMc03F8c69+pTuu2CKdmcizco0?=
 =?us-ascii?Q?3Lu0LgHGqO85l3t6H22sQFHysMPVBx32alzDBzt4Ma5nhUIrx+jZ8WZqaESU?=
 =?us-ascii?Q?NRlpDQkni35akG0MzXCG+F9ulcXWGrAMq5py+vVzDCLD+13vOxQArtnamGwV?=
 =?us-ascii?Q?U8Tkj21tuT8HYrp/UDcyPozSszdKJ+Klk4E2etsXWdka1OdHZNFMPAha5BS2?=
 =?us-ascii?Q?Y8ioebEvbT73tV7MHV8RuFrb2FkXYd8sEXZrp3dYdje01e7H8qEy7IaDhUuP?=
 =?us-ascii?Q?Q/c3FI0v39Cjh1m1rXE6KBh7fAMESh0X+ryyMR6QSqZHjaLZtydXII9XP70Q?=
 =?us-ascii?Q?7jSl3tCy0DCEOHUdCB/V/d3SmWt2scLT+BYUvFfsoVgsWBG5LvF8MktNy9VE?=
 =?us-ascii?Q?2u/PJYd5kGbU8w/lJI7LHqBfww1F4Vort5ltuwS4NiV6a+hmknIn6ejhFoet?=
 =?us-ascii?Q?IwekxkoWx4NxQQv38jN4wHxfCjZyveL6jT1U+b8Yw9ccWSgJPHKf+3PIEZrm?=
 =?us-ascii?Q?nUKNIws02Fr6f1oid8Pd6TnwCqCT3JYaZwb8wiyQmHe0g2Bo3LcRKneprq86?=
 =?us-ascii?Q?qQswCjyXQtzUdM4mqvwfnZ/xgKdxgC9FthtjUe+8hmy480U7mL29irPMcWKI?=
 =?us-ascii?Q?VnvJnFyU3SQVAsHBI8p2I6e4ovPsTzY53G/Pe8L1sLjY8QpU+mDF+dO4+lcr?=
 =?us-ascii?Q?53nhK35v6QG9W4WE2fMHFMQKqEzLjbl9zPR0F3Ub9Vqmqi+uOIGlLZogOQqj?=
 =?us-ascii?Q?D5qFrmXad6lLDcLT6sEl/ui2GOQrhxwFG6I65wPZi/613+l+5k28Rq+WKRKG?=
 =?us-ascii?Q?3C6vTjYmD38k4uMw9AVZ8sDzZJffoZYN/6le12mvzhnLNYfqtwoO0TIhiPAN?=
 =?us-ascii?Q?wTP9EA61Aj/HisdFdM26VXA5i9sZoQNokj22e/hX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac820209-a560-4f2c-8d99-08dc99e1f275
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:24:49.5535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQX6qK7BCFjorZVeWSHeQosJ1AIa69JF7FmswyzAqITKPdaBplxO2HhF2FBX37gbPtoeLHIMsxjrRHbOAfcS7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8410

On Mon, Jul 01, 2024 at 03:52:10PM +0100, Mark Brown wrote:
> On Mon, 24 Jun 2024 14:55:26 -0400, Frank Li wrote:
> > Convert fsl-dspi binding to to yaml format.
> > Using common SPI property spi-cs-setup-delay-ns and spi-cs-hold-delay-ns.
> > Update driver and ls1043 dts file.
> > 
> > To: Vladimir Oltean <olteanv@gmail.com>
> > To: Mark Brown <broonie@kernel.org>
> > To: Rob Herring <robh@kernel.org>
> > To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > To: Conor Dooley <conor+dt@kernel.org>
> > To: Shawn Guo <shawnguo@kernel.org>
> > Cc: linux-spi@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: imx@lists.linux.dev
> > Cc: olteanv@gmail.com
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thanks!
> 
> [1/3] spi: fsl-dspi: use common proptery 'spi-cs-setup(hold)-delay-ns'
>       commit: 52e78777b6bfd4bc47448791a99d5f97c82ff81c
> [2/3] spi: dt-bindings: fsl-dspi: Convert to yaml format
>       commit: 94f19d076218a193d170da6d5ab2a87c080cc69c
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.

Thank you very much, I sent out incremental update before this patch
applied since my one miss understand. Could you please check this?

https://lore.kernel.org/imx/20240627203308.476437-1-Frank.Li@nxp.com/

Frank

> 
> Thanks,
> Mark
> 

