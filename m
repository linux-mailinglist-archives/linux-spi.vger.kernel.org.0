Return-Path: <linux-spi+bounces-7531-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B70B5A84853
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 17:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC371881AD7
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 15:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0B41EA7D4;
	Thu, 10 Apr 2025 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dwqCuYoA"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013000.outbound.protection.outlook.com [40.107.162.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78E41E98FC;
	Thu, 10 Apr 2025 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299924; cv=fail; b=XReKUKsKQ55BsjVvVmmXBK5SssOOsoRVkG8QhsnHLzw80oTbcnGlW0u9OS44Psu/hsHXFspZtbsnvbt2fL3EbvC2w0qZLaYCqf2N5y1wWUlQZC4jwM8UOuwJSwG/3EjfifLvljQQafvDu7TNcLx77hv89JGWIfqB0+urvBAmaHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299924; c=relaxed/simple;
	bh=K7xVGSJj8FMVa5U0f6LwnA0S8VyqlKsoLQ0k0QxJjK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NE7oYRyNwY21Y6LpmHXvxkeXSdZaVQzp0EL29Vrf4tC2hRagn0emwbYsT/qEZW2qzv5auOicgnqeLuV16kjesrLPkG2LT/6Oi6SLh8XN7Xl2UB7AeB3AGofgVgD7pmIIAuY9/k4Iz/4zKxjHir50T14FML9AkLKhMDbKG4GyGf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dwqCuYoA; arc=fail smtp.client-ip=40.107.162.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLRCA7JRNpS3xzr/0pN00ufggpt3ELIladmercYw+ISbf9u4RiN9ks7kVkgJ94Oi6MlV/JlhxR3nSP18LD5ggBnGfZXozn4ez6NHb13X1RLVTGAPi34GbuBk0YsIB72PCngbmAHm3ECAFGL03yHDgxQfBaVlSqxIUMBoXawGPKeuF/7xFxfQWk3ul+DNJ91I3zD3kd8CYUXnPJkyV2A6N9cHlVIdaiz5OJmNJEFhhHPO90n/q3SlGl4YtPATiEeOSC4AesBvRP8rXOSGv6891R3xXGeseFZlOCcZlIW3LVzxU2PEoWnNThhdpiP6vFiQCslyg/ohgomU3szA/IOiXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snrslRUZA7M1SW+pdCvnTdcKYVIP6NIYIpCwRwa0Nxw=;
 b=Rer9h7/FNSa7S/lrfvIz4TqPeXwlfakg2LaQRYl4+p4//pwvRoSBpf7c2FhbPaz0lFwioGzQlzdL8M5nG09bid+5L9O92088ZF4cgV06egGQG1KAi+d47NkqvpYln4bh3Kb2rHZfwQxq9Bs2yACP3Yygu3Vc7ADbw3mrnySZQCDR7KmHjNhwLPa/TN4prKXY7jBuz1e6Kj8VNqENHQjqohtThvmz9h8nsjHXiSTBNLIaRhYYt9ko/mDBSUBaa3Mu3DCUlErLZy/RvuTibAg/QKgZqh9zRZ1HEPb7uEi/pIjEKnlMD3nPDggvzmmhuJLuG/B1MoEMDfd+WCs8QiFpCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snrslRUZA7M1SW+pdCvnTdcKYVIP6NIYIpCwRwa0Nxw=;
 b=dwqCuYoAktFIkJfbJhIFtqrMhH9CEXPSKQSqKSV2JTtatd1NZho9SyHmZoc4zGEG0KoKbYMbyJdICtVK2QWkwRRbSx0HYi2+eV6Srok3zSsgCus3Nm2fuMk7ugvfWo9Sl6WjG1q0xSCmCT8bZdFcJv5A0gZLMd7a+C4ZrsBKmot/e13e+kBTrsBzTEGbHw9J/p4ClA8w0jeNTs9F2H23Do6w2zjy1F/0wEhSMPEQ1w3RODNODSRolrHlLDjCR2/98L2kW3BebJI0512y+wOmaLoLQvJzaK9KXzOYuFzg2XRsWbtakY7yCgkykxzVutzfbYYZFiLg17chV627hzpb8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7841.eurprd04.prod.outlook.com (2603:10a6:20b:244::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 10 Apr
 2025 15:45:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 15:45:19 +0000
Date: Thu, 10 Apr 2025 11:45:13 -0400
From: Frank Li <Frank.li@nxp.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: linux-spi@vger.kernel.org, Han Xu <han.xu@nxp.com>,
	Mark Brown <broonie@kernel.org>, imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: fsl-qspi: Fix double cleanup in probe error path
Message-ID: <Z/fniXBnfnx7RHxR@lizhi-Precision-Tower-5810>
References: <20250410-spi-v1-0-56e867cc19cf@gmail.com>
 <20250410-spi-v1-1-56e867cc19cf@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-spi-v1-1-56e867cc19cf@gmail.com>
X-ClientProxiedBy: PH8P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa6436c-2b4f-49e3-4127-08dd7846b236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rQEP/6pRQ8iwyfA1OYU/HeILymw8Khgfr81z+peI15m8ewwen4lAy8r8M523?=
 =?us-ascii?Q?YN7/z4Fs9Ie2CS+iNlgKKOWRIDoa2YkwxgPKJaVDKK7DbwgmigtrmIUPCz2Z?=
 =?us-ascii?Q?7FThqFdopm0FVWxjFOa2ePgCpGKuDvUVz4OxIIZzaiJTb4Rbgz+t6u+opGDI?=
 =?us-ascii?Q?6ZvSqLg7o+jrf4uz3CAQbsy4yjD7E+S5TlQP0nw4bUsGCtSXflIjeVHuBiX+?=
 =?us-ascii?Q?mCrZyqOv07jwSmjmvgj6aKXl8WoKjHfKnTZ83ZKLPV/IjNmL5tLaLgYjkqbo?=
 =?us-ascii?Q?n7fehPHb6JfM5PEmz37uAT0rhsDcJZwDpU7lJCP3ebe4gZS/syQqFpzujTCW?=
 =?us-ascii?Q?s+gDroY/BdCmrn1FWWVTasPNbl0BYqcas2qbK4fAvJxtwN7tBNYQWfmAPIUo?=
 =?us-ascii?Q?k6Gx0O80mrGAa0fLUDasJ6A26h35XruTSbbnikeiVQ6tG5HCAj5lmT0zvyd2?=
 =?us-ascii?Q?QdoIGJhRnpmNywUylJ/GSPwCODhxKCXFv/mQ0dp8pIFUom+3VxIr6L3vnIAX?=
 =?us-ascii?Q?XtfWQk91LiT/Cv6GEVLFvHGDBOOEQl1KOtljkSYFxicFawMvUeGxhw0y9J/P?=
 =?us-ascii?Q?dpp0Y/bLQhNQxzxoDA9ZIlSFFa1JE1Bw2fPStM9Hpa/UIHdwZkfwvj4WtQTm?=
 =?us-ascii?Q?YSo7Fu0noP+ayfTNOAynBnCRCVUt6gBVHX7kytEMGK+RTGrX3SAtcKnY1TlD?=
 =?us-ascii?Q?J4tQHrj9RxBiT6xb8zvfFFHzbHQYwQrbc7x3E/oFI854rS5zF30g59iLIJ14?=
 =?us-ascii?Q?MTiK0fLD42rH1IUEBbfnHu0+A8UefazkPfzpan4697snkZS412wUBKfDuLXe?=
 =?us-ascii?Q?CRIkj6ZbzycIDN62TBJRh/s4I45JlcXGuyCRcWekBH7SDC48p5Gbgz8LOkDe?=
 =?us-ascii?Q?mCg11ZV/9Arwz9V8AuKdxBwjQcpJr3uwFJuapZDy1WJ8LotOMteTx2H6trZo?=
 =?us-ascii?Q?L7RaQQOpkRVICVAkPujKeE05+t+0y2OUdXv/aUQAX7Bmx2S2MEQp+xRiXpfM?=
 =?us-ascii?Q?m1LrdsRY1oJkCFXjUOhd4xi5bHR1IqIZBWUF/atOLJohu1o1XCgfIKVUzZN5?=
 =?us-ascii?Q?7vxTMF3XA6rnBRQ7vTMvxtTa/UXbxLV23bX84fNwJ+p7rD5vteVB5Q4n44Dv?=
 =?us-ascii?Q?fvUwY8bxPAMlGbmHzLsghIFX6fO5uxDaW6qwdys4ik6HSzoN4rYgJtSAv2Ji?=
 =?us-ascii?Q?oLOddzzRBzowsC9Z01Y9Wd/LwsSfqP/Ijz6N7nfQh6QbPh3QH9lMtgzA36up?=
 =?us-ascii?Q?isNwr1opuUkH/B3Q7LR6BZYNWovcicDnWoqTqfuVkW47DqQyEM9ZVFXIl+/l?=
 =?us-ascii?Q?INn+l9sq34I5E/OYqvs5v/2vCWFOSQvHd5K+03jormp6pkk1610KarM08y5M?=
 =?us-ascii?Q?IVbkLSMoyCNixlIAqq4qlFMKwrwZGnl+1sdbW2BPdpR8jVPPs6ngcs2+6uVf?=
 =?us-ascii?Q?qwqf2rxW1fEp0WR1PwodOXShn2MRghfIvUFqE2uY1aoS0ZqxStIPog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0ULYR8K+2JZU8wuM/tW0en0X0QOja+mnxaog4ier4we0Ahi3iVwsyNidvxhE?=
 =?us-ascii?Q?4qYEChY0r5XEAKrxb7veVQH41Q8tukDKftsE2L3Pqzj+1Te0LI+KtDeNc/88?=
 =?us-ascii?Q?DOCrqd5EZQGYYFXyjaz/4/svc8ozyTi4s70easrmIX+3kz/TD+hDKxP3W5o6?=
 =?us-ascii?Q?cWD+3o7dXa6v2Bp4NlCSpclSOgWgEcH9Ivi52wm6Qq3PJo2SkDZ2nBz+gh09?=
 =?us-ascii?Q?s7GPPqEZHjA4l1tiQYu1jPv1nkInW3fJVV3NovmanmBfAWT2e1kMQ4N/KzJn?=
 =?us-ascii?Q?EsYoO8ECvgJmKQrQWm/U6YanEl2uqh3nYEbbkQmP0QtVZW8EqHQwGEYQkPAR?=
 =?us-ascii?Q?k4oNCLi2pPhk0Fpuy9SEt3QwoQS8/+I9t3Usqm3EKxM5C/cpZ3n4NCMmcWY7?=
 =?us-ascii?Q?mTLsE6iXV17GYpg0gZppyYJD1BS2prQVRg7plL/X7ptI0sen/exV4OGxI8Vb?=
 =?us-ascii?Q?2I7FUmeocZr/DgpRpN4rR/JgteLQWFXSZBTCEi9+AhfPzxvNcdssuNylSl/7?=
 =?us-ascii?Q?BSfhqJ/r/dK6AEhX51NlYPLaSqaivxxeP18ORG28/iEO9C8f1gabNAWVVQtl?=
 =?us-ascii?Q?NzPzC7iihwkVEoAq5aZMRFcj1gD4s7ewuCG3a9JgIl+XwfBKOyHM4ePMunJb?=
 =?us-ascii?Q?LdB0qWq6BcaU2r2GOWfuCziilodUsU9CBzgyEuTeKJPp2cghsRBNjwaonTiZ?=
 =?us-ascii?Q?aGsQLVc0wOOUcZa8G1pr62u43bB/6DIQrpXWJ5yaCjPP+otEyOymGqexU81c?=
 =?us-ascii?Q?OxTFSQf7r09caVupNWZc3Y9Sn+wprM6YFyd62PRmI9IkdwL86cUQxgcfTAWE?=
 =?us-ascii?Q?rrSiAWzXXwu690dQga0zO2+jZHfY0HtC9MfDjjXOIm9v9nCRUecygVYDHVBd?=
 =?us-ascii?Q?DoxPJR3STO9trBgmhMxF0XGGiJqulbKObvuTyXARdHxDSUt92vQL2sV4d/6L?=
 =?us-ascii?Q?E5upLhdtMI0/CUIHECKCKb1Z2dd0L66lQXYcQtmGV3JYMGtlVl/f/U2meDtu?=
 =?us-ascii?Q?+30sE22b3uRAuQNvY348SuXKywXJNtwshf7FS+Rm5zdxx9/hsg/QgLAU0KnD?=
 =?us-ascii?Q?RgXAix9acHyRzWVIZbPifFnlTYJo5wrWjC9e0ce1/TMdMfHqjGWuQ5jUrULo?=
 =?us-ascii?Q?cP3uHW8EwoYFtkD3uYvP3HuAVJl6sbNGcA82vS1LKx4R0DidzSCkZ3cuDhSh?=
 =?us-ascii?Q?yBqzqnwlFvoCriZeD1SW4sjXJtP00sJ7igJBfMgsZ8NnldkxFFN5mjocY4IH?=
 =?us-ascii?Q?szXr6xqAq9U1JLE0t8LpsWI0aCrIa0VAjtidfq7399glXQvHdYZ9pBRR7+MU?=
 =?us-ascii?Q?1LFWARkDLN6u8TjC4I/V8Ig3ilxn9OAPVZlmnrr+2oZdgr8rQs9Lqdlb5uBQ?=
 =?us-ascii?Q?JnFompw3bz8gprJj9O3m6rJQ7JFbtVO2EIH97FdNs+c9YL2YM3HOiOWNJEx9?=
 =?us-ascii?Q?ycgPbpIhSlrZp1k0/XBIkzCW+EAqatWT64DaFT/GwR5Y/dEuHefeiiI/pM79?=
 =?us-ascii?Q?0cBx0kzCD4eJhERrW6b3GC5rw4hp5p9Egv1INwP0fGod9RSHFzeoSJxkMNAd?=
 =?us-ascii?Q?Ug2upz8gCCy8LMbNo9WZ9nB6favuusikTGe1KcC2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa6436c-2b4f-49e3-4127-08dd7846b236
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 15:45:19.1771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UG4ujrKrU5RBu3ndxpmx9VYxQ/ZTrQyk4r43dvTf0B4ve5ZztGlSQ3VkxQSojg6PDhslgfhrHqEArG64LzSaVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7841

On Thu, Apr 10, 2025 at 02:56:09PM +0800, Kevin Hao wrote:
> Commit 40369bfe717e ("spi: fsl-qspi: use devm function instead of driver
> remove") introduced managed cleanup via fsl_qspi_cleanup(), but
> incorrectly retain manual cleanup in two scenarios:
>
> - On devm_add_action_or_reset() failure, the function automatically call
>   fsl_qspi_cleanup(). However, the current code still jumps to
>   err_destroy_mutex, repeating cleanup.
>
> - After the fsl_qspi_cleanup() action is added successfully, there is no
>   need to manually perform the cleanup in the subsequent error path.
>   However, the current code still jumps to err_destroy_mutex on spi
>   controller failure, repeating cleanup.
>
> Skip redundant manual cleanup calls to fix these issues.
>
> Cc: stable@vger.kernel.org
> Fixes: 40369bfe717e ("spi: fsl-qspi: use devm function instead of driver remove")
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  drivers/spi/spi-fsl-qspi.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
> index 5c59fddb32c1b9cc030e7abb49484662ec7b382c..2f54dc09d11b1c56cfe57ceec8452fbb29322d3f 100644
> --- a/drivers/spi/spi-fsl-qspi.c
> +++ b/drivers/spi/spi-fsl-qspi.c
> @@ -949,17 +949,14 @@ static int fsl_qspi_probe(struct platform_device *pdev)
>
>  	ret = devm_add_action_or_reset(dev, fsl_qspi_cleanup, q);
>  	if (ret)
> -		goto err_destroy_mutex;
> +		goto err_put_ctrl;

fsl_qspi_cleanup() already included mutex_destroy() and
fsl_qspi_clk_disable_unprep()

simple
		return ret;
>
>  	ret = devm_spi_register_controller(dev, ctlr);
>  	if (ret)
> -		goto err_destroy_mutex;
> +		goto err_put_ctrl;

return ret;
>
>  	return 0;
>
> -err_destroy_mutex:
> -	mutex_destroy(&q->lock);
> -
>  err_disable_clk:
>  	fsl_qspi_clk_disable_unprep(q);

remove these two labels

Frank
>
>
> --
> 2.49.0
>

