Return-Path: <linux-spi+bounces-7532-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FF0A848E5
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 17:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E1C1BA0006
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 15:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DACD1EB9E1;
	Thu, 10 Apr 2025 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IK06yl3J"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2052.outbound.protection.outlook.com [40.107.247.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE36F1EB1BC;
	Thu, 10 Apr 2025 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300367; cv=fail; b=tC3ZG1VAs9t7MMIeyhsOXl3C0H5sqNp0E9MMwx6BWPrukvP/W9oaHDMFf15mqoXeNyq96atX2aDVswuYK8351pbCjV47hKdyKSY/I7STsNmNJjcr5wMZBdeWc1tm7HM6/mUdGRxgnbJo3rumTqhfphF1cIA5yTOF6pguDl3QJyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300367; c=relaxed/simple;
	bh=t7taD8igi0ONId7IFIf21gU1QCpQFFmSpIahBLPsivY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D8j7MxjYYViZUztafv5UUElM36aLT7bIF/ywmJTcaCs3WcVtSfyR2mPJwB6eyoj8EbYRBrAbFA4ubAeiNcHRtIUL4JbRG3kU9QMcXzoodlWAOZ5bYvAKsUwNVT5hMNIKVLgkL4NfKJrzurVAC1uzX2yUumHracbtWSQmwJ6Fdmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IK06yl3J; arc=fail smtp.client-ip=40.107.247.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrM3jjjWmdP0aoxuRr34lhhBIwC1ZtBzwTrpeX8uZ+/mFOMg+A40fnf9XNOyGMP1Dv/nFDb5mEgn+jIBtBojfWB2QHt+GZpMX3seLMXTz9QdQw7RH25DPX50at5jpvvvI/TDz5nJuaTNMvH/pCuOaYmiLOH5+xAPwEDhgYsDdGdKFcWtVnnlDJQT2BUaVqjLpxnAanvTIGodPXp2oVnbKGx8aQ65/+VFSaIfQf+GYOjDkmHI98g8Ys480bA0Y491H6pJkpEr5cCyNj0mo4766U06lQv2Y4NfxlVPRPr5+F5WFOBl9oEIR6n07RkE9qZjHBtsVnjyJJYVTju3mEPHow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyndTudwH/xZOqm2bIiBCZwGUsx3uXTq+iLHluntUEc=;
 b=gCTPzeTe7rMr5zRXx0OzfHWc6MoiVEqNyoUMVCIA1JZvVo6WSkwGAFJbf9IM6txyydIl1zhoLMIlT7bmkuKoF6ShPWrm7wseUB+YDVO2jFIePGAXbI1vG2D3XZ+1Hq3Ch7AOcVdrVZzBq8IfA2qnOyu+jD1icFiTgHhNlLSNUuP/1mk7UR6TgFWkkyvJEcum2mJp2PNMOaOsEBaiJn2OgIcdd+Q6/QosNPuZQz6wkZApSTzbCryKjhpQQJ66UfrpIOafFp67hC9z/gpWgEhjvJL27rqmmwV1UC07Qjs50aFguSekZ2R/IBWex9hY72QEberGFeHkol/lI7VREnsMxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyndTudwH/xZOqm2bIiBCZwGUsx3uXTq+iLHluntUEc=;
 b=IK06yl3JAtegTL40tgPXfPtyaA85C+VJPF4Mk5n0iDvd1HXcqk2R6CnIZWIPrUkHZAwbyfsQYGE7OfclkeWg+/jxtsnws0VGuxAJp9riqCkdaBeK72O/60kNfEW/x9Q/yANGlRDesz19GJExgd8FVuwWt272StKNlFe99jJ8wthxo8OaL5O2XmH1zqqnJhS/osEc3BFkAXvQ6a/9wwtmUcMZpfezoSvK2qI+K5e3KzV6dSffCnmH0sXOpD1r0+D1VX0ELS4XHkUShm3qLoWJHHJ5kkZ65hBICN4gco8DxfpusqHC7ZN45tCqFMniNv1TQ8pErMEk7FAAhGfKjbELHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7602.eurprd04.prod.outlook.com (2603:10a6:20b:2db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Thu, 10 Apr
 2025 15:52:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 15:52:42 +0000
Date: Thu, 10 Apr 2025 11:52:35 -0400
From: Frank Li <Frank.li@nxp.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: linux-spi@vger.kernel.org, Han Xu <han.xu@nxp.com>,
	Mark Brown <broonie@kernel.org>, imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: fsl-qspi: Fix double cleanup in probe error path
Message-ID: <Z/fpQ5Qf9KZwK0LE@lizhi-Precision-Tower-5810>
References: <20250410-spi-v1-0-56e867cc19cf@gmail.com>
 <20250410-spi-v1-1-56e867cc19cf@gmail.com>
 <Z/fniXBnfnx7RHxR@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/fniXBnfnx7RHxR@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: PH7P220CA0032.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 4200998b-1836-4e52-5fdc-08dd7847ba33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tZfs39dU3KIfKncXiYK7Val2LdI800YiKqT59WZkRq2cL2KhMheXW1/4yBzy?=
 =?us-ascii?Q?3xZg2PFAxm2g0fETI4bwlaybHfSnYB1QiE5y06QToUuZXaMNWrsOG5GjAljT?=
 =?us-ascii?Q?LUcBYArIJy5BEi8853LPsfqXy/F8x4nji+4cZ7yKJsamfvqFb8kkcHytKH4B?=
 =?us-ascii?Q?BsAYbW8a4UN0q+wylcDapl20enr+2ffZJPHbioNmV01VbDQ7FA3WFuSYlQ9E?=
 =?us-ascii?Q?sRYZR97MG/EVU+dihw+VP9qDXX5jpBQw4OzFKWRa6mH7gdaqUA3LKodgIZVV?=
 =?us-ascii?Q?vkbVCpU8UOQV8dfp4dqX1iuvYk1Odqw9top5qG6OYlba2gyISiB/huEWAgSq?=
 =?us-ascii?Q?9kHi1BVvTYK2xJqt4t+8w1TnGqY79Y8+FEY602eM3SdTaohHRJaexa/g0Htr?=
 =?us-ascii?Q?EbVtmrBv9V862erYHVWTGXMXLYHuHYk7jAZtDuQy2uwUz7+q/WNODjFlfA7f?=
 =?us-ascii?Q?WM/EzJ6oISoj7bJii/GK03ndcehYGpAWcXjJs0XMdgwMRL4F9gJkXfl98vPX?=
 =?us-ascii?Q?99w6sU8a13ofgQzr+ZFBmPBkFhoo2AEtwDLSr800XO1X4BP4MdahvvIDgnhc?=
 =?us-ascii?Q?Z+DyV+yf1J12zAPmATaWYNC6H+QWO0CYZ2DoH+qvQdXYu2ij+YTtg6H+oJAu?=
 =?us-ascii?Q?ZqclSwWFLepb2PGt5G06CdMsMzI1+1HDc+F4p1kQM7CcUL39+ZNXrlqrSARr?=
 =?us-ascii?Q?nGaFK66xgnno6oCMboTHrKU3XFwr+LJ6LDL6DC3MAvccN2jWGUuvATFK2O9H?=
 =?us-ascii?Q?LTTYJlLL7COZk4IUsEoToaMrhblEkR7QIHMnUcYzhiWsKxS5UNuPa/KyFbhr?=
 =?us-ascii?Q?tUnz67P38otblP233MDu2/OMlv1pPMHKzWHj8JER+RONitunbU63r/TpgNcA?=
 =?us-ascii?Q?Q3cy4bwK6fJgNTCW6WnCG22oyx6X85M/ZRMy/8Se6T+92c1rvtY12wgPm1px?=
 =?us-ascii?Q?stS61VX6JdYaHEij5yBzrVGuRYZQcpzkcV2Cacda5/Go9m0kAFpifQozM5ga?=
 =?us-ascii?Q?9jASYBlTQv2e43Dc8OA8B8xSgKZo2QAdtej2KVFjc60OFdwowoSB6cEKo0KO?=
 =?us-ascii?Q?nByWWNgKsYZbf8EG19DxXcVsmEzq//6ke5/pQPYxDGpK/qZKFHBlmSKnLuK1?=
 =?us-ascii?Q?4lGVqH5t66HkQ5FsbvePIiulkJ7Dz6VoGeEZCOHCQtwJTvj9TO+tEl5iTq6H?=
 =?us-ascii?Q?+o8kP6sO8nXYwzW3uLjSB0kNEznNCvBXGFEuVhWaSz+y8wW5LKv8QLT+lSEg?=
 =?us-ascii?Q?bM3LkvNxYHComd2/B1R8m7qKh4byGfQBumRAqCvFOYA4jA/jc7j+C0ozVl6m?=
 =?us-ascii?Q?kgiY2FTsMwfByt/PolpVcK8TBRKOmg4Xz7+2zwk0L8gf7awIilX2ig+jggJ1?=
 =?us-ascii?Q?EbSOF+2r5YMyHrCdRj/q/tektQtTBvnvCbw1H9S5hEkhB/3axyC6r4IsFqYB?=
 =?us-ascii?Q?0jNXCIm3GGvo4RN4t/5SDvpo+TYJY0et?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FI9fpe9Ga4suXE30CSgSkOY+jb/GB3RPuXKwr7/po0wSxGLcGLJJGd0Cmes7?=
 =?us-ascii?Q?+54jZkb1/3yR/u1yU4kxd7xbKlSDodgWhXKfrdfSQZROV9aJb0kHQBcGfOcF?=
 =?us-ascii?Q?+aGaijhVzliYiNiwzC+ne0zM37Czd1NniaHDJRsQvaysfqEsSEVS+ju67u1a?=
 =?us-ascii?Q?Ax8G1d69sB1OQxt9d+jjiuxSmjZUOWey0K6Eb/odh6aHGcE2z/1uXxhqJu7y?=
 =?us-ascii?Q?bjkftwoqYdP04QHLwiCL2JG+ltL9ruItulg44F910R74mHC87Gqx8nEApfsB?=
 =?us-ascii?Q?KKP4nZOhUS0TCkTOcPzYxqa3Efd7R/OMCYrvHtW2Bn02x0ufyTKBUvJDrwTC?=
 =?us-ascii?Q?HifAEmHVQIM3gbXRGxsidDosm19zTdK+Oj/lIJ8pUAv4SCS2poCxuwTQorG1?=
 =?us-ascii?Q?d6s9ydYw728OdefYEtI8wppspOk0N0OyB0Qou2KBDdG8/JJ2QjNe8Z2u/X9d?=
 =?us-ascii?Q?8Tw+8Ckz0B2c9vlpVrRfPKA86c2VjVa2WsEhuJrrhio/K4DHPDYoZObyO30o?=
 =?us-ascii?Q?boTzI2b+Bn+lEWF/MjvHNmX7cmFEuL5eJzQOAJYesIn7iFvxbj9QLsfU3dsB?=
 =?us-ascii?Q?wpV+9fZ1ulH126A+SEX0bNeIfb13QiDW+8j/bnea28tqpg29/7jR+Pza/JHl?=
 =?us-ascii?Q?N3qL7QtWzBZvuDarMSPawGC5dVXxpX/jDyTwrbDsJpdlZFiIKAn8boXI7EfP?=
 =?us-ascii?Q?wqWlBAcUfYoHqsAn4zpKb3ZrnobcPeLYUFGayU/4DVk0xUegUC12mlZFamUl?=
 =?us-ascii?Q?CygQV/df/+vKB5PiollvMxEPbOIzR3vKPZRfcXyEYfDvYEK01EejCulJA6Sh?=
 =?us-ascii?Q?3/zOnhkqKHGWImq+E5+yHP2MBLFoIeysD9mY42OnZq0d1nwmCKDu1MSkUDL5?=
 =?us-ascii?Q?uW9GUl2dA3ecM1GLQj66DcYK/5mOMl0yXtvQd5Zn2B7auJ9kkR2Gyywr2lDk?=
 =?us-ascii?Q?cMIhdwx585W25NRrKVM2qpDucGp3iVVSh4xmCsW1+0llqmzFmraPy2QtMPyT?=
 =?us-ascii?Q?WPujMADqnNsg1fBnHBHZFEV3UbmOP1nM7qfiVa34qcq5DDCOpMHD13NAkq3q?=
 =?us-ascii?Q?s1Vxb9o5EVqVzkaAEy8frVz/plY7nV8eJaH3OPXdVgoLzRp16T7YGGaGbMZ0?=
 =?us-ascii?Q?U2n62okOtArhuAFJc3rBAiFcse3S0cywYO3I2riqRsPu4LECcSIvffpYu5Gc?=
 =?us-ascii?Q?I5zIWLFE0RfI0nXom7NIG5gC3zmFNBido1tcbZkyAKAoZm18lX7s8BA3bLNb?=
 =?us-ascii?Q?cl+C655IqFGPgp32dP1lyCfQWfSxjBypQdvd3H1se4qHv1lK71S4M7EQ9hBM?=
 =?us-ascii?Q?gxWthtJrnB3agri52saKKWVqOCs9ZOaTjBPE6r/ZUGRSUCvd2qg+X6NTJQ9C?=
 =?us-ascii?Q?5hOkF/z1YPrgFc4y0VyPSsAjQIVtL+wLJMX5laA21/2QxnfyHaTP7HHcRUDm?=
 =?us-ascii?Q?VtqWkc5YM/ZBM00JOkLic98lIxsLPtfv8RHW3oQM0AM65D2/d580g6OqyPxj?=
 =?us-ascii?Q?Wu36O0zCm2t2HeIdMjSX0shNgLZuut4F47UOLcNogwNr7PAKeRevWJLZK4uJ?=
 =?us-ascii?Q?p291gl8PxxwT1NYw1O72k3uwvSMQ49hrhES1fOrm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4200998b-1836-4e52-5fdc-08dd7847ba33
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 15:52:41.9504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KzAtli+DdKvSwjY2uZ1qIDnTnxFAQOUEufzEcaI6LAQ8299bKXUKHk+brRfhs386YxswCyP/7GAhVxLfy7Oozw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7602

On Thu, Apr 10, 2025 at 11:45:13AM -0400, Frank Li wrote:
> On Thu, Apr 10, 2025 at 02:56:09PM +0800, Kevin Hao wrote:
> > Commit 40369bfe717e ("spi: fsl-qspi: use devm function instead of driver
> > remove") introduced managed cleanup via fsl_qspi_cleanup(), but
> > incorrectly retain manual cleanup in two scenarios:
> >
> > - On devm_add_action_or_reset() failure, the function automatically call
> >   fsl_qspi_cleanup(). However, the current code still jumps to
> >   err_destroy_mutex, repeating cleanup.
> >
> > - After the fsl_qspi_cleanup() action is added successfully, there is no
> >   need to manually perform the cleanup in the subsequent error path.
> >   However, the current code still jumps to err_destroy_mutex on spi
> >   controller failure, repeating cleanup.
> >
> > Skip redundant manual cleanup calls to fix these issues.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 40369bfe717e ("spi: fsl-qspi: use devm function instead of driver remove")
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > ---
> >  drivers/spi/spi-fsl-qspi.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
> > index 5c59fddb32c1b9cc030e7abb49484662ec7b382c..2f54dc09d11b1c56cfe57ceec8452fbb29322d3f 100644
> > --- a/drivers/spi/spi-fsl-qspi.c
> > +++ b/drivers/spi/spi-fsl-qspi.c
> > @@ -949,17 +949,14 @@ static int fsl_qspi_probe(struct platform_device *pdev)
> >
> >  	ret = devm_add_action_or_reset(dev, fsl_qspi_cleanup, q);
> >  	if (ret)
> > -		goto err_destroy_mutex;
> > +		goto err_put_ctrl;
>
> fsl_qspi_cleanup() already included mutex_destroy() and
> fsl_qspi_clk_disable_unprep()
>
> simple
> 		return ret;
> >
> >  	ret = devm_spi_register_controller(dev, ctlr);
> >  	if (ret)
> > -		goto err_destroy_mutex;
> > +		goto err_put_ctrl;
>
> return ret;
> >
> >  	return 0;
> >
> > -err_destroy_mutex:
> > -	mutex_destroy(&q->lock);
> > -
> >  err_disable_clk:
> >  	fsl_qspi_clk_disable_unprep(q);
>
> remove these two labels

Sorry, I missed your patch3 and Mark already applied. Please discard
my comment. it should be fine.

Frank
>
> Frank
> >
> >
> > --
> > 2.49.0
> >

