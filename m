Return-Path: <linux-spi+bounces-11521-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE024C85DE5
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 17:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C34C3B40A8
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 16:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E01522541C;
	Tue, 25 Nov 2025 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mE90f2lE"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013040.outbound.protection.outlook.com [52.101.83.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F272248AE;
	Tue, 25 Nov 2025 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764086771; cv=fail; b=dV/fkxG5nLGnvMbB8wNVogYOXfIm4+RDryQuzT+Ari2P1qZhiVcuI2tH65RaTJCQPO2wnfPOQHk4n2xT8Hxg+dV9B+nLmm1fFKDemPNjh9qpKGMY9ivCHvuMZYWr1jtSM9If8r0pVB+4gvW65jk4ZwGxLTPheNloXSJrU10XK7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764086771; c=relaxed/simple;
	bh=aXlcwjaYdMYnYQ24zuC/g3vKSaGChbSzWFaPEfy1dOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ucGzj5VY0G3cVo3jauH4jPWJ0V8dyMj8g4dCw4In4rxSyjL8aVtBE1Xty8kMDySuhwcf1d95UFrYsS9o+nFMWm+GJIDGrddAd+ZqavyKGxqDB6tHKcmuIORP41Qb6FeDX7TgbpXEeFmtzoMnlsAsaeaI4Rq3GEW7zixPdv+ldHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mE90f2lE; arc=fail smtp.client-ip=52.101.83.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQ2Tpw7aoUBtM9vibs2QnZeswtEBmEr8G0t716T2k3+g/hLwj8K/0PZEZHbMe+16zFFGh71Z5Tkc8QvSyqIXHip++gOk2zQweOid3l5abfnNBusfD3VDLdHJhFfHKPzLHxg/ZkzuIRoeDmXC8j98kdiLwin+mZzKCdXkZwJK90UaKwRljI3aTdyqjB9UigE6cTGQa/ybrJuCTmzJjv+EuyGCUEeXikRWD85pEZekF9oJd2gGg9fhDw/1r4L1b8byTxYRkB2kzunqW1vO35DxPojrpCrEVLMzDHKw94FtoG8oX8O8Y1aGnSE/HAG0TisG5+ZHNQEEIblIeFNY39scJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cORYgXD24tEvmENoBfdkigftzkce/ZLpD6EvL9fPU8=;
 b=bLgfUtYKsfkVH8RYFQqDjujW/WP0K7yGBISp6xFczIVC5vCxHAF5VEiGjaF2VZWeqr9lUZ9ALYW+7+Y5CJTkNUNNRZXWI7gV2bKw8f2oQYtcZUBTwL2vNA6/9OAkHBR1S9iz/Rt40o7qvbxE4WRrWlh7mXGNjvdAMoEnPx7zLSVaEYEcAkJFP/F0hOUrIeBx6Tmuk/hm099ro7q5gh3xqJtPlVJqMOv4WX93FWNnerqpe77PlxdVsE4xPDR6eMpdQS1RSByWht5LnyoMzZqTeoEJWLf1gLUotkoWVas1VjK5t6NhxZP7anfW6JJ75rVa7OkzVnFOYl5Na38hxlZ08g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cORYgXD24tEvmENoBfdkigftzkce/ZLpD6EvL9fPU8=;
 b=mE90f2lExmRHvE823ZC/3Wwlbp0zReEQN9By3HTTDk9imE8kbtS451uYfuj/+PHBzTGhxByl8oxIuSaz+XGXfn4JDvV78O9J0B5MfHsIXWRGUJGovrhSrbwCF5ITkGQiO75eGBOqBcyVAOaUnY4iLfcLqkaK/mxo11CeZzksBx2cCu7k0A1M75RJlRpxGwJrrJ8np222bBvVLnzcpnNWweKW5wUEyk4SkzNC49rE8m+/HZpI7OBOALpb3ejXa38h3g7EcQYnmKORHDGidOipPVeWIOm7SUeeP9HaKX5sRSEsTfib7HJ+rAaY95LUFxEeyACl0y1aDBwgVAiAXd5cLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DU4PR04MB12082.eurprd04.prod.outlook.com (2603:10a6:10:645::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 16:06:06 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 16:06:05 +0000
Date: Tue, 25 Nov 2025 11:05:58 -0500
From: Frank Li <Frank.li@nxp.com>
To: Carlos Song <carlos.song@nxp.com>
Cc: broonie@kernel.org, hawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] spi: imx: enable DMA mode for target operation
Message-ID: <aSXT5tzhfHYVUrGy@lizhi-Precision-Tower-5810>
References: <20251125100618.2159770-1-carlos.song@nxp.com>
 <20251125100618.2159770-7-carlos.song@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125100618.2159770-7-carlos.song@nxp.com>
X-ClientProxiedBy: PH7P220CA0052.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::34) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DU4PR04MB12082:EE_
X-MS-Office365-Filtering-Correlation-Id: 7829e566-fba3-422e-d55a-08de2c3c8967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5NKqNblbUezjTx4E4Fy8NSWvExvzSHNawE9/IHKqS6eG+RFc0TBe92HsbMqT?=
 =?us-ascii?Q?tJc3T3A5A46zcSX0gLBTlw4p9XcXMLDMtUJyVd1mNOjNuDHgIOhq7Z9RA5AD?=
 =?us-ascii?Q?vEow+OWC2Jyy2lEfBrinfBaRuH/RBvAPRG3euCa0zHO/fj1PiS5iR6ZMywWq?=
 =?us-ascii?Q?/PTSSqTFz7JzqUCK2gzr1bkNJP+61V2sy/6asTxAStMZMmTN5HfT5xdpqzZL?=
 =?us-ascii?Q?IQ3P3J1wER/U4I0mWnjhKqkdxs3w9sMshKLgoMO3xbA10gtFEBdmIlq4HBs6?=
 =?us-ascii?Q?WPcs/MVTwnKvGCMEg7hBgKttsv/riKgJ1hZJPuqaFVQansJnhFFXrnB4BOJb?=
 =?us-ascii?Q?InwdNLu4ISApsO4jdBLA9uCRVSCeoChG0MyME39JNkggM4V8lFUPf2Mz1r9J?=
 =?us-ascii?Q?XtZ8cl4sf0FQ+g4tvAdOxr6TLya5w047u1dE/f2B6D4tvB85fktM2m2fSDsF?=
 =?us-ascii?Q?ccnu5wzf4lrdbl5lLOTVo7rdx1JQCILVHHr2fQZyMVI3ewqoORKxOlGIvAPZ?=
 =?us-ascii?Q?8jVWjJSSxPlCEikYCftfLO+USqHQpAgHk6ZEBdDM62UrBRKHY5+c3vagTAAj?=
 =?us-ascii?Q?C1nFsXWyjGQEDuaGkd617z8eYoI/q026IBeElJIKFCDq6pu9vSVJZhoPxaeW?=
 =?us-ascii?Q?n/mddTqXU5h+k/StdKs9Fpb9DQcGfssUkKfDhQ2Fzr9yYXcBRaU1fMuMJF6U?=
 =?us-ascii?Q?9QEqC9kKXTnkvbOyWXC1dIWzhRrAdk6u34KzXC/g03Z7ojMUBMF4NF60NGJd?=
 =?us-ascii?Q?EysfVEXa0fbVZ+dp62uhggek3Pvdy6GeF4Gv60TN1O9P+fRp1jDm/xm2H32/?=
 =?us-ascii?Q?VvdJ5kJ0+BNVnFo4IkrlIln/dXtZK9KZQJS60rExJIrKkyOf/UYfbAbRCWKl?=
 =?us-ascii?Q?DF6IuN7s59nHii5CaQuz5ONxSx13HPWrJpS/4h1Ku0Oh+1lCyxBJsHMXZJVE?=
 =?us-ascii?Q?3LqpwoWRsqZDgoRrVAPyly52958Ob3RN9T8GqtCwi/5/K59rWQcWPHnXVnof?=
 =?us-ascii?Q?EcxuO4Mfzt0Qi3nJd/adUZ/UTnTcFfOAMo0VjU20TKj72XGNgXOmbR3CBF3l?=
 =?us-ascii?Q?EsDPuIGCulFyvq3oFqMAQyYUsLz+XCi0fG++88igHCRynYDT7sIigiKvpWOT?=
 =?us-ascii?Q?KwBMKfExGoh+eJEDYSDHNYuL12Ff57vxK6EF1lKG1KLkGoEMwF2TxKaqdIw/?=
 =?us-ascii?Q?O4E219AJ6lEuuEVOB6urvzOzmTSJlle47TGih6GSZgMG9jMmGZC/3sYUoE0i?=
 =?us-ascii?Q?c4cRTixhco6qfG0Ci1lBRnlGpvGFeaFg3MQiApCRYEQ+TsckAcw+bhXxZNuA?=
 =?us-ascii?Q?0+2NW5bESmIRvhJR1azyGzsxmRqOxyr3oAt66nbM725APKuxPseSSl77Jees?=
 =?us-ascii?Q?JGy1/sYCSXh2sR3Yau2V5/bP1b23qCabRpPW+hLdHvlyRSC9AQtzVNbtarnd?=
 =?us-ascii?Q?zgM9SCh5Ne+XWAMCuj4eGF987FP0mTybJzCsEWC8LPcU8V/RM7lnHhw0LiEB?=
 =?us-ascii?Q?f8BoUxcLmt7FsL6OZjzJlpNCT4Hj44k/T0Gp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jrR3oytEvRhnUoSqAXyyPQCoo4G275TTyHyiD8Ezmkry2Mqnp4D/l2F07HRr?=
 =?us-ascii?Q?+YLRvATJvyiwOT8+2Y8XvaQA/ntmvtbmTO56vB/K+GlDUlIgWSWWp6o5I4Ol?=
 =?us-ascii?Q?T7jWQ6H1FYVDOfe/MEEeFZJR3RIBtOr30WT+YtwL/b3KhRYQdLQETwsULk4y?=
 =?us-ascii?Q?7yzGe/rZ+PmP8C+6QLBtea6NPvo07sWvzWrtg4Rs8rfatPxV8gW8hBzP+JRm?=
 =?us-ascii?Q?GzH2rHUD77HgWrrWeWYhRn64djU2Z7zVQ65ZCABzJ12xCuqsGLR89t8rBfSW?=
 =?us-ascii?Q?Lw/v37yWDsHO6tcFB+lGlAOEvjFGqbH10w2PSdxvGIn7mjs3rZUGhDJj7A42?=
 =?us-ascii?Q?q3JbiyaBC19yJr/gVASxBXxI2298hHbDOtvL0uTV/LvPmgaUqLbG9qUiLrKc?=
 =?us-ascii?Q?IOYQRGYJwFGC4UeqGpNTpJplKG4p3vmxSB2AugFVWFDBMdARu0cSA/TpcR2L?=
 =?us-ascii?Q?M/Uxgg6rqcW+xykYT8PYVnwJaKhioIcBAuz5WIRUPCE2sE3aGhThoUbqWddA?=
 =?us-ascii?Q?QBZuJjyrm8HhsCNGbVi/TjTJo/vCYQPMTiepbHCGKylagrw3zmySASXNtUry?=
 =?us-ascii?Q?ApHTz3C/MoMsxpRTFYqo/xO6JvRjglIYh5B5ONbBeE7SGiy44V0i2bUVrVZZ?=
 =?us-ascii?Q?KoUSZVzew+r7MTZU9/UUP0tduZXfrUFz4g25eDP3latT+aqaNMdwK2nUnpNq?=
 =?us-ascii?Q?t2yotTZfI+xJIyhCnqREXWuj9FSTZ2wazQxK7eEUQ/Amjxv85bR/EOankf6y?=
 =?us-ascii?Q?EB5xSlaSaQ04kTEuBYi+8jhkcaS0peK1EvcIInaVSnTil2xPCFu+ELJ94VxC?=
 =?us-ascii?Q?3KqqBTnXl7HeD1cMYn00tNCyMpv2n+pRWVND4uy52gJiXXUB6PcfnxjTU919?=
 =?us-ascii?Q?WWPDI56uLq0etvKUny1XPQHHC/o5Tft/ec2L4DL0STrjtlNU9f6EV0kut5yW?=
 =?us-ascii?Q?8YJGOKlqJrtFUM9r0g28GtAlRCnJVk4DkaeZD7apAIAhEeazONsg1rlqyK0B?=
 =?us-ascii?Q?A8tZpIAsQnd+YB7gLr18arGG5B+NrvmVO53/4g5znY97hT/QZLC8dRWoiEaN?=
 =?us-ascii?Q?esioOC8vg/7hfFvpoqovf1zkW6F98UUuw4hdFpb+4wvGoK9uBFNrNPxYJs2j?=
 =?us-ascii?Q?8m4yxBtIvP8LXMtzEyNHMJWOycnDnmCFX9OpV7R42+zJRS/UUgM7mG13EoQC?=
 =?us-ascii?Q?cyxxSRor5sC86ItwFbs0uH+VDkeJ/9vNCMWodJYGdazZP/LmhH7i+CQ6jDNB?=
 =?us-ascii?Q?xLnA1rfstmZG2FvxiCEvlOTNiB/c/5FOZ+nnDERZ1mGvdydm4c4RmqvWZb9y?=
 =?us-ascii?Q?al2IeBnxVeupj/x0i3xzbmwi72OeqT4ahdzZz+h9qEXQULJONecmlViubqsP?=
 =?us-ascii?Q?2b9nv8K1jE9jMuOBqZsAPG7+z45GZUH2+u8yXBc0XJHE9p02773isMKTSFVc?=
 =?us-ascii?Q?FbIB+2lOueNGoAm2eqqy16qQiL1u0Hahf4LM84PaioPH1NH1dA8sxzUCbs2a?=
 =?us-ascii?Q?W9uJdSGlZYtkVggWzhg7k/EXKPGwAkbRBi7/V+UWCKXdQRiANhDtSglZyeEm?=
 =?us-ascii?Q?yyDoF90k/UGsvWJ30MI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7829e566-fba3-422e-d55a-08de2c3c8967
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 16:06:05.0080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nG7e5Gth9VmxqPLKwUwHEQIXafgTZv9TepWtR5c4ZJoM9e97xW2J4WKalwbTDWBstE+BsJwTGZ8k3VIvMLEnoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12082

On Tue, Nov 25, 2025 at 06:06:18PM +0800, Carlos Song wrote:
> Enable DMA mode for SPI IMX in target mode.
> Disable the word delay feature for target mode, because target mode should
> always keep high performance to make sure it can follow the master. Target
> mode continues to operate in dynamic burst mode.

If two paragraph, need extra empty line. If one parapraph, move to previous
line.

>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---
>  drivers/spi/spi-imx.c | 78 +++++++++++++++++++++++++++++++------------
>  1 file changed, 56 insertions(+), 22 deletions(-)
>
...
>
> @@ -1756,23 +1753,51 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
>
>  	transfer_timeout = spi_imx_calculate_timeout(spi_imx, transfer->len);
>
> -	/* Wait SDMA to finish the data transfer.*/
> -	time_left = wait_for_completion_timeout(&spi_imx->dma_tx_completion,
> -						transfer_timeout);
> -	if (!time_left) {
> -		dev_err(spi_imx->dev, "I/O Error in DMA TX\n");
> -		dmaengine_terminate_all(controller->dma_tx);
> -		dmaengine_terminate_all(controller->dma_rx);
> -		return -ETIMEDOUT;
> -	}
> +	if (!spi_imx->target_mode) {
> +		/* Wait SDMA to finish the data transfer.*/
> +		time_left = wait_for_completion_timeout(&spi_imx->dma_tx_completion,
> +							transfer_timeout);
> +		if (!time_left) {
> +			dev_err(spi_imx->dev, "I/O Error in DMA TX\n");
> +			dmaengine_terminate_all(controller->dma_tx);
> +			dmaengine_terminate_all(controller->dma_rx);
> +			return -ETIMEDOUT;
> +		}
>
> -	time_left = wait_for_completion_timeout(&spi_imx->dma_rx_completion,
> -						transfer_timeout);
> -	if (!time_left) {
> -		dev_err(&controller->dev, "I/O Error in DMA RX\n");
> -		spi_imx->devtype_data->reset(spi_imx);
> -		dmaengine_terminate_all(controller->dma_rx);
> -		return -ETIMEDOUT;
> +		time_left = wait_for_completion_timeout(&spi_imx->dma_rx_completion,
> +							transfer_timeout);
> +		if (!time_left) {
> +			dev_err(&controller->dev, "I/O Error in DMA RX\n");
> +			spi_imx->devtype_data->reset(spi_imx);
> +			dmaengine_terminate_all(controller->dma_rx);
> +			return -ETIMEDOUT;
> +		}
> +	} else {
> +		spi_imx->target_aborted = false;
> +
> +		if (wait_for_completion_interruptible(&spi_imx->dma_tx_completion) ||
> +		    spi_imx->target_aborted) {

Suppose somewhere set target_aborted to true. I think here should use
READ_ONCE() to make sure read from memory.

Not sure why here use wait_for_completion_interruptible() but at master
mode use wait_for_completion_timeout().

> +			dev_dbg(spi_imx->dev, "I/O Error in DMA TX interrupted\n");
> +			dmaengine_terminate_all(controller->dma_tx);
> +			dmaengine_terminate_all(controller->dma_rx);
> +			return -EINTR;
> +		}
> +
> +		if (wait_for_completion_interruptible(&spi_imx->dma_rx_completion) ||
> +		    spi_imx->target_aborted) {
> +			dev_dbg(spi_imx->dev, "I/O Error in DMA RX interrupted\n");
> +			dmaengine_terminate_all(controller->dma_rx);
> +			return -EINTR;
> +		}
> +
> +		/*
> +		 * ECSPI has a HW issue when works in Target mode, after 64 words
> +		 * writtern to TXFIFO, even TXFIFO becomes empty, ECSPI_TXDATA keeps
> +		 * shift out the last word data, so we have to disable ECSPI when in
> +		 * target mode after the transfer completes.
> +		 */
> +		if (spi_imx->devtype_data->disable)
> +			spi_imx->devtype_data->disable(spi_imx);
>  	}
>
>  	return 0;
> @@ -1895,10 +1920,16 @@ static int spi_imx_dma_package_transfer(struct spi_imx_data *spi_imx,
>  static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
>  				struct spi_transfer *transfer)
>  {
> -	bool word_delay = transfer->word_delay.value != 0;
> +	bool word_delay = transfer->word_delay.value != 0 && !spi_imx->target_mode;
>  	int ret;
>  	int i;
>
> +	if (transfer->len > MX53_MAX_TRANSFER_BYTES && spi_imx->target_mode) {

why only target have len limiation?

Frank
> +		dev_err(spi_imx->dev, "Transaction too big, max size is %d bytes\n",
> +			MX53_MAX_TRANSFER_BYTES);
> +		return -EMSGSIZE;
> +	}
> +
>  	ret = spi_imx_dma_data_prepare(spi_imx, transfer, word_delay);
>  	if (ret < 0) {
>  		transfer->error |= SPI_TRANS_FAIL_NO_START;
> @@ -2104,7 +2135,7 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
>  	while (spi_imx->devtype_data->rx_available(spi_imx))
>  		readl(spi_imx->base + MXC_CSPIRXDATA);
>
> -	if (spi_imx->target_mode)
> +	if (spi_imx->target_mode && !spi_imx->usedma)
>  		return spi_imx_pio_transfer_target(spi, transfer);
>
>  	/*
> @@ -2116,7 +2147,10 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
>  		ret = spi_imx_dma_transfer(spi_imx, transfer);
>  		if (transfer->error & SPI_TRANS_FAIL_NO_START) {
>  			spi_imx->usedma = false;
> -			return spi_imx_pio_transfer(spi, transfer);
> +			if (spi_imx->target_mode)
> +				return spi_imx_pio_transfer_target(spi, transfer);
> +			else
> +				return spi_imx_pio_transfer(spi, transfer);
>  		}
>  		return ret;
>  	}
> --
> 2.34.1
>

