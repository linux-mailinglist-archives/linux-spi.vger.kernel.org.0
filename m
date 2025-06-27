Return-Path: <linux-spi+bounces-8830-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394C9AEC030
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 21:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5A907A7A24
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 19:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80216212B1E;
	Fri, 27 Jun 2025 19:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MG93y2bM"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1636E2EB5A0;
	Fri, 27 Jun 2025 19:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751053146; cv=fail; b=aW5Qc945a9DmFwLrv1HaqSqut7YWCp4tYnZKLFhrpaszx+VxGWjET3vKPnuZDmf+07/5GKwg4XmLaiAyehNB9OE/w6Wg0F5va2qDpmNU1imhm3pnGZ/2AbesMq8Zf4xkQsXPXBCueHwFamKuyZnHvEBazi01P5TqICfXf9ekZfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751053146; c=relaxed/simple;
	bh=+LLZXos/MUFj0rLVhBdLtmv1/WCypynZdqUGzgW2IaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s2eL+oumRTZCLfi8v6MUJMYKmsKCZYy0BGvCkfv3g6lGg02BMMweyyKHwMsHrG8qmYm6Bab4E1gV6hZ+b6BUTHeBscL4pLcBGCq5tgfAfktN37ZT2kV0d7JKgkP+vI8onMeVIHuFU+LSK8OlssDpApeDBUdlXzSpVB2fooUoXTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MG93y2bM; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geL1NhhSfm1Yi4Iho+Bl5iBj+YR1d/NTDN5X5a6ogu6lLI28CykcuHsrXv/rdEErcE+BQl9HWLao3tNLjScDG6FFiQJeKRmB+XU0JMfZPywz4AJIDyAXz58DKb7S3csHcYgbXVcw0LTGyrVFV7F9TmOaG9dqJgFy1Iq4TmOHv0N1TfhThy7/fpAa9GmzX2fA/1kq6mplAaKdNtbm3etxVNR8z9fEMphjWnQKVSavO9w9MzPNGKSiG117okpS4hmucyd7TOL8kInU0ibtqJqpOXuJWsPmXOdL0UTKKokEIZ3fsbnxyDlhq7fZ0KNGT3TVWtk2SL1E2kwEwd/En0lYyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyubAFt+943M/NBaQVCRpJLxoqLZa2DeAarQwFX7LY8=;
 b=JQ1PS+r81LSL/aSLr6WgE7SPVQcIZkD3tHXm2B4Os6E17Vuj8n8jhLN9zH/IDF5gMmZpjMTeEStiH46PFueVvM1kftb/tc8jUPdmu7rMQac6jb6YN2HKk++3vX6tDkOGyRDQESqR884iUQMDlEqFxAtzSHOLFL47QUYuuD2rhGyM526zVqyI0RLyt0PGUshIeUj/nAEJRrPTa0jbdjlqr19bPm8ROhOhsbr9cuqTvtq259XU45bgH3Tzwi80G/WQ0mWXjWiwtl0wVRai3zghZDRu10eO8y5qSdS0NKQ5JXChtSR/xbimD7BpqSbqh9fNdg1L1zIh0eFt7AXG0zl+6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyubAFt+943M/NBaQVCRpJLxoqLZa2DeAarQwFX7LY8=;
 b=MG93y2bMsYh3EVnz5O/yKTvgtXxh3a2Uxnxdy7NCTUSbiGjPlemWksLiDIjRelB6fcuyVez8UWn6PQsMBUk6g27enzOExoA4LSjG2DvmMRBS8/BbzqrNcnSwhpZSsiRM29vKFc4u9VMdEphNXc29Aq0Z27t7k4oYoPZokKxuSbuDKQ1+1dkQnAOFRja95kBhH2WaPX+AHq5pojWKGvbynRt9b5kfZm871F2IQt7nHEikl8fZnmAd2xVvu2RZH728yPd8z3show9CfGjh6JONUZVhBmvInbJxqr1d47e/RSmKM1LqGxgXkZpSWiYVKvRKU6DzeV4dGQirn5kZv0EpPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8568.eurprd04.prod.outlook.com (2603:10a6:10:2d7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Fri, 27 Jun
 2025 19:39:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 19:39:01 +0000
Date: Fri, 27 Jun 2025 15:38:56 -0400
From: Frank Li <Frank.li@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Christoph Hellwig <hch@lst.de>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] spi: spi-fsl-dspi: Use non-coherent memory for DMA
Message-ID: <aF7zUFaOPDr18Uns@lizhi-Precision-Tower-5810>
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
 <20250627-james-nxp-spi-dma-v4-4-178dba20c120@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627-james-nxp-spi-dma-v4-4-178dba20c120@linaro.org>
X-ClientProxiedBy: AS4PR09CA0005.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 446a7790-32cd-46d0-0fc9-08ddb5b2441e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FEnDSsjjO9Gxz4migOAPe1XFUFdD+jqEcTXxECUD73JDr54lYIAKg0WLvUFN?=
 =?us-ascii?Q?N6+g5Mxo7R3zjnCKDXmWCdrk/JI8MnEeQE4rA/HqlUvcDIfKzkERsntrYbLQ?=
 =?us-ascii?Q?CPpiB5upChYIYJoF5eowIvx2zGYmf34O47SHVtxN9JCqjBkLq+ospxh1nNZn?=
 =?us-ascii?Q?wb8kuQH2zHO9PawdLeMrJd3eyeQWld/7C3+HUE2qUFRzqomLjJFdulnG/wqB?=
 =?us-ascii?Q?szqtrYweFKs3Uo9piI+asWzkbJ8j64P4iV8bUqgM3118HuPbVXvrQTPedx30?=
 =?us-ascii?Q?iuAaQzNgCBhsNKMRJMyQGBA66R1QGynodcAGBdioxDYsRsBIpomS/ZJqVSoC?=
 =?us-ascii?Q?MMdcTbB117M7K911t+rialiEcYL3YpaSvEigRQLSkJEFkUshNEpKpk+r4TjD?=
 =?us-ascii?Q?Rlg8mxv+rgAoxQgOV+H+M/+dVgfo9Y3jpFToAqb/nbfbM+KJyJHlQY9Y68i0?=
 =?us-ascii?Q?bsB5yT31mMZ1Gb/aLuKSa9+69TphxXXaIwaprfNj3qoZpE7urpsXZ8f2kMzP?=
 =?us-ascii?Q?CaGl1QR2Xer5VaJjaGmkjhLpxh1FHK/uE+678RH58cSa60OU0uIPjdtX+RrU?=
 =?us-ascii?Q?ehaecbX/6afShclbPiExyFA9WgoZD3DU9misnzd4LFfTrLKkDRCXR0JcEHTj?=
 =?us-ascii?Q?2sa4U5o566Y89lp2DcXrtKx9axu9HqwIfPXrIu2+jDM2k2w6/u0WuWVcL2RD?=
 =?us-ascii?Q?tc6Nl37SoJr0jMOR8QrOhurF6K/gXPyB3MX7Nm5XY9kMf+iaFX8PDG8R6poH?=
 =?us-ascii?Q?5wwSrZOSnb99gxKqJqOY6Ew/crFltGprhB7vNfIETPw8fBVsckCr92XVX9Ie?=
 =?us-ascii?Q?kpAZK9EXYgLnK10fyEb/BZbrlnotbnlAufoCFjwmyqhlEWd+9eKpXTDnmkh3?=
 =?us-ascii?Q?o5yG4QVTu0vgIc3xtzxArSCJ9J1t3FPcqtuI7DSjvFCasdChnkr9qjOqIGuw?=
 =?us-ascii?Q?LKhzXrXsN6CvU2kGxnTvDrKhlGqOaePEagpNVRO+7iW7HyM0X0gQnyq0Sr/3?=
 =?us-ascii?Q?ga6tbgKklHnzE5yt4un1JYZ6uTWlmWMFvikVFI2OiCMZF/y/bZnySJ+0fM+S?=
 =?us-ascii?Q?o/jJHQX2c35R5cYRcs7UnuZ9VzKcawu4hnHYMum6pQXtJJdxsadArtJVM8f8?=
 =?us-ascii?Q?30F+WTZCYWdDpAOd2lFoEJ0+WHZivWk3xYkFQ8WrWqfOBZN7VUO0WESsqGpW?=
 =?us-ascii?Q?k8guMOsjEKlXRWHqXeHcHBzegCMGwoxWVhC9BbpaWCLZ/i7gUjAxI8HpvauV?=
 =?us-ascii?Q?UE3kulc9c26wpyb/7tIdixRwHX4dria3Hi6q22ANYRXg0X4EgMYusHzfihRX?=
 =?us-ascii?Q?WrwdfGbbMXnBbWUU7m33IUxEMkTqTV1UpBrwnOOar/wqqaCS25UJImtHguj4?=
 =?us-ascii?Q?az2KnEd5Ar5Md8oWVvXkUtlZ9jbBLHKLUQcfhDBaVI4yldhWizTK1mJUPLuf?=
 =?us-ascii?Q?L0ixT6l6wUlmb9EAm9QGroj7Gfo5R7j9IlXIgiY4/Ntm6I9gaGlhVA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hQXaWraCE2uZKgNv5p1c9tuXlJR2qEkEABHMjb/t/dTwkD3MG6SueVMlr4WI?=
 =?us-ascii?Q?9q8emvvTb0dtR+mo81Sj3YCGIzKSVa+g13eiVh+3JiGehIL5Qrb1dnNyD6c8?=
 =?us-ascii?Q?zlN0Gh1aCvqM9g036kWrF4wsAWo7xetkXgq53tg0EicmyGGYI24XRmGj0Gt0?=
 =?us-ascii?Q?ZVmwd8tN5p5Wt/NH4zCyykbAOXesQRtqSpTzWbwfEMpbgh1yaoxHC3fYruel?=
 =?us-ascii?Q?D34s66YmZwVDWvix7lsFW4UShrn1lQJOnI2YWDM11FsIllCyUdIN3/G8pejc?=
 =?us-ascii?Q?ygqqI/UAkOUIqvdEQfQzLuAJpZk9yCDDJzY5xgwlfQRmS6bUmVd7Zxx1//Xh?=
 =?us-ascii?Q?yCsOwiew8C1Ip99VuIU3mt31tH532jc3b1AKRx1FNkedL+gwDbr0lNos77/I?=
 =?us-ascii?Q?4z0ywsf+wy1c474Xj4LnHKenMhqH9TF5dbnuR3XBqgCixBphFFvYq/F/aXWW?=
 =?us-ascii?Q?PqxNt+qwI/PEAWqQsOMwozevGqUJQ5eDWiotJxTnXykxCtA4B+AW2WX/A/KD?=
 =?us-ascii?Q?ceGM8aUoX8y9vA3R2Ir5kCt3BF8MTHeJtIlSG3CaJWqO8EEsvtilxkdJH+ab?=
 =?us-ascii?Q?qGoENJINlfUBUQgEivHLM0t4CSCi91OnB4jlb4hXCbBETF3CGg0g7vLX/q2J?=
 =?us-ascii?Q?8/Y9zqdgweYqd36QwlvcYIaXfZL8VVr4wnz7YN29rzW0Zu4Z4HD+KljcpIe7?=
 =?us-ascii?Q?DxtDtZqowErE2qcSZ1mNcQMOd59wbfcvFY9NnMqeu9+6GdsMCa5fNsVatIXD?=
 =?us-ascii?Q?s+Kfpx8WozL9Bod3C7xSMQuawC2Am5Iy8a3NNYyX9h7QeywDBU8F2Z1y5+VC?=
 =?us-ascii?Q?d01WrHt8xJh/J7SpfCBzHvxwGOA6NHCSm99jX7i2AOUmnkwU/IVf52tYfHr2?=
 =?us-ascii?Q?7iSjKNyuyvGK51+w/KpkooCKA8ix96M3ZfVN5finjs+GwmFnrLUghtZLjeA5?=
 =?us-ascii?Q?UJccSQbtMkb042FTVguup64segAmwBgmIjpXa+bshnyfTAnpeleeIclJ02mL?=
 =?us-ascii?Q?RtJBpAnck3ShM4rrfHiO9al2m/JKY/e6iqPog+BIzSPq6ru/qHsR+Mj3qeaS?=
 =?us-ascii?Q?qdXZMmJJ/+5Qp+C2SaYTsuGVfBH+9senvQiBjPS95RBURt3COeIoY4vJCX1R?=
 =?us-ascii?Q?Jz95DPvYfwNO9GjcuQhApamVueYEYpynSd3VLsTzOMFD/36yootpXfnsAflO?=
 =?us-ascii?Q?l3p1gdBl9kOQ4HvLKDqV2eFu7bA0uZ0z7NBYN8HDYYzd0vj2ztJGzar1bYOj?=
 =?us-ascii?Q?d7MPqzS0m8O5TJ4aN4ysNUxKvtkWNc6pRxPvHmSUv892+7eRQ0HSVt9b9M/0?=
 =?us-ascii?Q?nHKLww0MOEM5RdzX4esgrtJn0Hm2asgra/rqMOeKIlKc6DFjGpWXkq2e26OO?=
 =?us-ascii?Q?ZtSUwECUpKgGWS2eGB3uVpQJSJkgS9epFbVoVGl1p0tuHu7Cv8qCDtro9Prb?=
 =?us-ascii?Q?rVXkrokUxx36CD0eEcsMmwdQadZinTHngKT1kQki4a4Set05aFqAuqiBW7H7?=
 =?us-ascii?Q?4HxJGLgarruRcA2xvnje9g77R3JrBrKBsPigwivFYd6p/jZuM69HPzfQpMJn?=
 =?us-ascii?Q?8hFybAAe0n6fFK+U4AE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446a7790-32cd-46d0-0fc9-08ddb5b2441e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 19:39:00.9558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlYyMEHdIu2vg1KrTUaTWnKgu1tDABCRtdWmh4u3MbmBWZwlFSC7AURU4xA5HlLcrtfmro3TMlbGijroqojb3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8568

On Fri, Jun 27, 2025 at 11:21:40AM +0100, James Clark wrote:
> Using coherent memory here isn't functionally necessary, we're only
> either sending data to the device or reading from it. This means
> explicit synchronizations are only required around those points and the
> change is fairly trivial.
>
> This gives us around a 10% increase in throughput for large DMA
> transfers and no loss for small transfers.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/spi/spi-fsl-dspi.c | 55 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 35 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index feff475dddfc..e7856f9c9440 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -493,11 +493,19 @@ static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
>  	return cmd << 16 | data;
>  }
>
> +static int dspi_dma_transfer_size(struct fsl_dspi *dspi)
> +{
> +	return dspi->words_in_flight * DMA_SLAVE_BUSWIDTH_4_BYTES;
> +}
> +
>  static void dspi_tx_dma_callback(void *arg)
>  {
>  	struct fsl_dspi *dspi = arg;
>  	struct fsl_dspi_dma *dma = dspi->dma;
> +	struct device *dev = &dspi->pdev->dev;
>
> +	dma_sync_single_for_cpu(dev, dma->tx_dma_phys,
> +				dspi_dma_transfer_size(dspi), DMA_TO_DEVICE);
>  	complete(&dma->cmd_tx_complete);
>  }
>
> @@ -505,9 +513,13 @@ static void dspi_rx_dma_callback(void *arg)
>  {
>  	struct fsl_dspi *dspi = arg;
>  	struct fsl_dspi_dma *dma = dspi->dma;
> +	struct device *dev = &dspi->pdev->dev;
>  	int i;
>
>  	if (dspi->rx) {
> +		dma_sync_single_for_cpu(dev, dma->rx_dma_phys,
> +					dspi_dma_transfer_size(dspi),
> +					DMA_FROM_DEVICE);
>  		for (i = 0; i < dspi->words_in_flight; i++)
>  			dspi_push_rx(dspi, dspi->dma->rx_dma_buf[i]);
>  	}
> @@ -517,6 +529,7 @@ static void dspi_rx_dma_callback(void *arg)
>
>  static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>  {
> +	size_t size = dspi_dma_transfer_size(dspi);
>  	struct device *dev = &dspi->pdev->dev;
>  	struct fsl_dspi_dma *dma = dspi->dma;
>  	int time_left;
> @@ -525,10 +538,9 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>  	for (i = 0; i < dspi->words_in_flight; i++)
>  		dspi->dma->tx_dma_buf[i] = dspi_pop_tx_pushr(dspi);
>
> +	dma_sync_single_for_device(dev, dma->tx_dma_phys, size, DMA_TO_DEVICE);
>  	dma->tx_desc = dmaengine_prep_slave_single(dma->chan_tx,
> -					dma->tx_dma_phys,
> -					dspi->words_in_flight *
> -					DMA_SLAVE_BUSWIDTH_4_BYTES,
> +					dma->tx_dma_phys, size,
>  					DMA_MEM_TO_DEV,
>  					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>  	if (!dma->tx_desc) {
> @@ -543,10 +555,10 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>  		return -EINVAL;
>  	}
>
> +	dma_sync_single_for_device(dev, dma->rx_dma_phys, size,
> +				   DMA_FROM_DEVICE);
>  	dma->rx_desc = dmaengine_prep_slave_single(dma->chan_rx,
> -					dma->rx_dma_phys,
> -					dspi->words_in_flight *
> -					DMA_SLAVE_BUSWIDTH_4_BYTES,
> +					dma->rx_dma_phys, size,
>  					DMA_DEV_TO_MEM,
>  					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>  	if (!dma->rx_desc) {
> @@ -643,17 +655,17 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
>  		goto err_tx_channel;
>  	}
>
> -	dma->tx_dma_buf = dma_alloc_coherent(dma->chan_tx->device->dev,
> -					     dma_bufsize, &dma->tx_dma_phys,
> -					     GFP_KERNEL);
> +	dma->tx_dma_buf = dma_alloc_noncoherent(dma->chan_tx->device->dev,
> +						dma_bufsize, &dma->tx_dma_phys,
> +						DMA_TO_DEVICE, GFP_KERNEL);
>  	if (!dma->tx_dma_buf) {
>  		ret = -ENOMEM;
>  		goto err_tx_dma_buf;
>  	}
>
> -	dma->rx_dma_buf = dma_alloc_coherent(dma->chan_rx->device->dev,
> -					     dma_bufsize, &dma->rx_dma_phys,
> -					     GFP_KERNEL);
> +	dma->rx_dma_buf = dma_alloc_noncoherent(dma->chan_rx->device->dev,
> +						dma_bufsize, &dma->rx_dma_phys,
> +						DMA_FROM_DEVICE, GFP_KERNEL);
>  	if (!dma->rx_dma_buf) {
>  		ret = -ENOMEM;
>  		goto err_rx_dma_buf;
> @@ -688,11 +700,12 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
>  	return 0;
>
>  err_slave_config:
> -	dma_free_coherent(dma->chan_rx->device->dev,
> -			  dma_bufsize, dma->rx_dma_buf, dma->rx_dma_phys);
> +	dma_free_noncoherent(dma->chan_rx->device->dev, dma_bufsize,
> +			     dma->rx_dma_buf, dma->rx_dma_phys,
> +			     DMA_FROM_DEVICE);
>  err_rx_dma_buf:
> -	dma_free_coherent(dma->chan_tx->device->dev,
> -			  dma_bufsize, dma->tx_dma_buf, dma->tx_dma_phys);
> +	dma_free_noncoherent(dma->chan_tx->device->dev, dma_bufsize,
> +			     dma->tx_dma_buf, dma->tx_dma_phys, DMA_TO_DEVICE);
>  err_tx_dma_buf:
>  	dma_release_channel(dma->chan_tx);
>  err_tx_channel:
> @@ -713,14 +726,16 @@ static void dspi_release_dma(struct fsl_dspi *dspi)
>  		return;
>
>  	if (dma->chan_tx) {
> -		dma_free_coherent(dma->chan_tx->device->dev, dma_bufsize,
> -				  dma->tx_dma_buf, dma->tx_dma_phys);
> +		dma_free_noncoherent(dma->chan_tx->device->dev, dma_bufsize,
> +				     dma->tx_dma_buf, dma->tx_dma_phys,
> +				     DMA_TO_DEVICE);
>  		dma_release_channel(dma->chan_tx);
>  	}
>
>  	if (dma->chan_rx) {
> -		dma_free_coherent(dma->chan_rx->device->dev, dma_bufsize,
> -				  dma->rx_dma_buf, dma->rx_dma_phys);
> +		dma_free_noncoherent(dma->chan_rx->device->dev, dma_bufsize,
> +				     dma->rx_dma_buf, dma->rx_dma_phys,
> +				     DMA_FROM_DEVICE);
>  		dma_release_channel(dma->chan_rx);
>  	}
>  }
>
> --
> 2.34.1
>

