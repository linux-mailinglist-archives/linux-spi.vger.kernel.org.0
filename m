Return-Path: <linux-spi+bounces-8743-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 153EBAE6C99
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 18:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443491889DCC
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 16:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3703074B3;
	Tue, 24 Jun 2025 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cQUSI2Aq"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013050.outbound.protection.outlook.com [40.107.159.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E77286430;
	Tue, 24 Jun 2025 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750783159; cv=fail; b=tSr3Tf+FdA1Atxk2+mB1RavXs7QKSAlH5mqPVn6hjh7cr8VbtxRp1NCFerfmJ5V2j1d9hG2OHqSDgMfyETqR7ftfmRjDHP/WH0CKJoys5/jQtFAhk6vJp34+b3mAYJ8X1oIpurUvtCL9sqyuyD8BPdfPVBASUG9zcWPEsKxu2ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750783159; c=relaxed/simple;
	bh=eD/OyD6sni4GC2AiAZQ3xcksMuhCrVNXC0ovFPuL9G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JL9/Z9r32bECYLOARpCzL4FjejeydhcAFQhYYDnxB6eCKlC08tQCVXa7nA1V+fCZbx0BIPpJMfj4pLne/BAyZZxzCQTs0HrH0xBzczf7wyVp/w7+IJnn15MsQKB+vQ/AsSupLWpsY5EMRPTfodh4wYwDAXQzup/MGiLWJxdtDC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cQUSI2Aq; arc=fail smtp.client-ip=40.107.159.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeR+6dHBVzPxtVAfPxgP6N2Qpmpr1dg2rVZ9sOTbykPo17U23H5oBbAN21yWFSCzufEy0UUzgxnpfdKUAMABqZyl43iv0J3LcNGP3tfUbhHpkxgrN7hBMy1yYMTChFlKD1TvMrLZ7HNB0s4X6cU1z7dqvh0cbBmI7xcnDSXnmjlea3L3emXOT3iufCn6OJoj6MGgPF4pI0dIhQ166mcWgxwMYcCA6nQJSURGr012Ygu4WNYQbx6G9vVsR8bTzvkOy6WT7hHyMwulj18v6TqmmCy1lc2aYP/kuhrl9+lZVKkN3M9jWk6kX0COQIpmpAbEnjsq2It74e9duvp7L2fJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGMLeK88OsUK2I2KTHjfnBpy1R1jHwOlMtIhkrbX1uc=;
 b=q5xJJ1kjDIPKDbYUYISTOiOb0seeM3Mbf+s9JZKxDlUPw2MqpvlUQk98hc0xF7N7goeJGYChcaC2CvvXn1EdO0LtNGrOoa0zWeOmgAdQPL7dWk8wHOJIBGbyp31BmRur+cuky1RR4RCx9ZAnDHEqbaNf7fHKQIdiiSwBmctDdFnlCovmUK8ENxyP6pSGoEkM1VU51DkpD1IQvUKwF+lDuq1xQXQzTQCMyjeIixmA/2w5QGkjG1tyqdiD6EJX5gk3GPEmjtDNXhRJMvr31N2NzVdDjctdDCRDj1PTmbCmdMDdfeYzhvXEhEXvUUoY8lrc8dqCTT+KwqXHKq3aJosXyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGMLeK88OsUK2I2KTHjfnBpy1R1jHwOlMtIhkrbX1uc=;
 b=cQUSI2Aqu2i2lMkXZ6jsCH5d4IaAtVbeRubH6ozk7KF9/jA+46N6j3AsgnB0kbbpsl2yok2y+JlG6IbIIePVcB5cmrLcG1mTf9t25yK/0nFiFOrfDvnIAODyW+0s7LiY3wTPreUDOJIPdQLhaG/GDLRbcuXIPXIHU2z2M8y2+Gp1YQLyWhi/F/ghT8cHJEQCqv2nCAo1O26EY5WHU4veD8mnzE7tSIpTf3aAe2W+a85Vzkz5zM8WVrwFEuGg9DjrB/fbAJNIytOFm+YgvnjtyXWcfq2mCfdZfjZax5VPyd/isfOlmFs0nqvbzRV6FKjlUWXDVP2RSNBzPu4vGsoi7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA3PR04MB11225.eurprd04.prod.outlook.com (2603:10a6:102:4b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Tue, 24 Jun
 2025 16:39:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 16:39:13 +0000
Date: Tue, 24 Jun 2025 12:39:05 -0400
From: Frank Li <Frank.li@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Christoph Hellwig <hch@lst.de>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] spi: spi-fsl-dspi: Use non-coherent memory for DMA
Message-ID: <aFrUqW0ijRt7CJzw@lizhi-Precision-Tower-5810>
References: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
 <20250624-james-nxp-spi-dma-v3-4-e7d574f5f62c@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-james-nxp-spi-dma-v3-4-e7d574f5f62c@linaro.org>
X-ClientProxiedBy: SJ0PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA3PR04MB11225:EE_
X-MS-Office365-Filtering-Correlation-Id: 7190c1c1-9df4-4684-c12f-08ddb33da6f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yXQripjW2V7LtIHBPZfw9b0z8c3TBb2F7q3zgssAlv9oun8Q+Jq1ReHU91Dk?=
 =?us-ascii?Q?J7COR1EmoqqVAiFfITa66GWk4UuPu5hiYNIyN0VLxsBXXxpxIdwv7Tr960HX?=
 =?us-ascii?Q?f9OKvqlfzrPbDPM417s4kD9H7bPT/ru4gDYyc0ZdLpWxiaziL02sJHQUhWcT?=
 =?us-ascii?Q?c/gS90UsGVnAoR4L6Lfq1TVQYaH1bhl4ms2UmnO81spNY/SmKUHpME5o3oTL?=
 =?us-ascii?Q?xqwQtVKRKmcAHSgrkFI2jLS8BTEPsLn3j7MBJf85qZotSBqdA/OqOc1Hxv94?=
 =?us-ascii?Q?QU4xrnGT/my/HcMqYImpjONNQJAF3v0WhMMvAHb08s8kdDRG9t5c7htDUy8a?=
 =?us-ascii?Q?ggzpzs2L+BtHxFXtVhpc/cKeZFDlYiPzmK37GwyZFsBZKTCCx/dFN7RZgksQ?=
 =?us-ascii?Q?gQTglPopJNQzmJK3P33JO/0FUkyarQ4x/+sTqi74LIP271hFU5EBlKEFZiuq?=
 =?us-ascii?Q?XcHHkRlPVNeNQw5HDTXeQDfcEMUxyrd4sGe8GbH4CNFK1sqZeotNQwnAv0bO?=
 =?us-ascii?Q?4GydrEVwL6DtJAuMzDCECf7jP++lyfOsScKDAY376NJtJOR3+wv0AV9Wl+Pi?=
 =?us-ascii?Q?wo48oMI0sGXJBancn6u8z7du9b8eWH8BeEPe62AZo1gsj+elL6hLhFfBIFwK?=
 =?us-ascii?Q?CHrBD6uJlIIQpV4Qo251DYFJ5aBnbROYiFYy95HMrT6tS7olUQHprweS4cgq?=
 =?us-ascii?Q?I+Xd/K2OGl9kHet5eYGRAJ/PAAJyL+VP/5MEfmLNo9bysYcvEXk8tMhYTMvF?=
 =?us-ascii?Q?y4VkdfSKmQqcqA9vB9jrdqO1jZzGr448LwhfumSkiaf8dbye9ad1J7d+Ew0l?=
 =?us-ascii?Q?UYKkZtpeb1kMgyh0NbSBLDsbBuSIl0o7Gnc0g/mIRCpPoUhk7wQddhPGSiDs?=
 =?us-ascii?Q?TLfsDLJTRKtwIbwXQCxSkRjEVDhugyzwVg+DF4eCSnwLo3bk/NcKUAJOCI4Q?=
 =?us-ascii?Q?/ZkPMLre7TLanpbO2D147H03sPhVccLo90Ier3gXnRnEIV2U66J9nFN31gL9?=
 =?us-ascii?Q?tSIFCeMcaRAGVlQ3btAYZz9lNrH7haLtO6TgEEV+ToxyQ96BpTM6pej9sktk?=
 =?us-ascii?Q?DJBOU7ad+httTuRhwjL3SV/5Dn+Y5h9EP0CstapMhdxWImEU16ClKfJa+xo3?=
 =?us-ascii?Q?ae9+Bil0Cvlp+MEIa9HR13MjUbAzpWUTdvt4QCKqWyXPOY2c5zX2XOwqWBhr?=
 =?us-ascii?Q?jA57Zv8P2jrrA6ikMih7KmuXbXvVLBKosDZbvQw52ChVouMc6WeSnyH7u5Gj?=
 =?us-ascii?Q?/Z96cXNLc94LlkG05/+pDMxJoBhFV8hA2rGWrarb6iR+Yr3+dvGZhCrE6j3s?=
 =?us-ascii?Q?TGQdcR5zIGE33DxtlHIzaHOJ3lCpnPrq7EHXxWUiHHpCF2b7wKWNMYKLQByv?=
 =?us-ascii?Q?5xlmoNdMNeyx2tKH/GT7ZepEb9BqvlmI6FlRbUJw9kZCtEf0gMNDuZwpJ7w4?=
 =?us-ascii?Q?CLT6sHFgdI2M3yt90UmNFURe0cU00W6Up2mzSSZG2vy2zlmVWi1w+tc3NeAz?=
 =?us-ascii?Q?HSA6ZW19MPbukvE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BAllYngKrRUvkA20qzLU17Tb4Vq9uLC1WBHgPw3EyW/O+oVDP3t4UVVQ4I5H?=
 =?us-ascii?Q?R/7lEA6wtrwiNagsK3Hxnu4roe04ET+fzZ97GrxyqYYAfmvlBLsoHX8ULT6z?=
 =?us-ascii?Q?xnLUgBM7w+YeI9eKtg5YJultYda1PplE7y7kd+tDOtqO8iQJ4XemL9m68noT?=
 =?us-ascii?Q?TBsedfsGrUzP657LJlMKWYRXFdxeMHynGEVlK6elMyHrgAaIe9iTBSb1qk75?=
 =?us-ascii?Q?IAFbdR2sCNjCyDK8ygQDzBmmIT8pETQBmGmJPQADVkyXIDa/uFWbI9z6SINR?=
 =?us-ascii?Q?lJDTcg8JGYBOJftXDWimT8LsjehUEwjPb9fmov8RvEuaayaE2v+ee8C6hms8?=
 =?us-ascii?Q?MJti4r4fH9WiQohYrfz3WfelCyVt9ZY7DGNAX8SCmo9V3QmUmncmxEJePVM3?=
 =?us-ascii?Q?5a87mfmeAYRG4+bchCe23mf+ApnkaNwM7+RMxUAVxg1e1UuKvsAXezCt8Bre?=
 =?us-ascii?Q?UfzbLBBOi/bTRuEeBFhS5j3FEt4XD3JnKqdv96p7mPfGqJIvQiE+j+ppO9CF?=
 =?us-ascii?Q?IcEmFuniSsImIuoyTGIlR8ClpIb0XBbg4JRKyJO2WofRMOFKhmkOZhs1Z25E?=
 =?us-ascii?Q?oNcgfI+BIaVpTHlZxY23QZtOVxjAYxmSOvyphxBydaqm5oYamGZ4vf+8dTDo?=
 =?us-ascii?Q?OBmf4CEvefgrpnD5DZNptOCxvJmKlueRrZy6o1Iz2M+P5y9oJs/LASL1XZ3i?=
 =?us-ascii?Q?P6wR3YNByVBZYbFIuHmI4dc1Gd9d96N6Wcctz4axaRuBo8SIrnfayZ4smQEZ?=
 =?us-ascii?Q?hJC2oCET5YtJnK1sGCXoll81HmZaxo1zcMEZSLA40IfHYsSSwjGw30wHV6Pi?=
 =?us-ascii?Q?B/F7YTS2ymb85AVwayk0kdYVwBS1UNqRjcx9Yh/wvjJkUF19GK3RWzdybJLS?=
 =?us-ascii?Q?o608hB1CetlgboPIdg07CbE533aBxxIf2WmhM5Vo42CaABeXa/d+Qb3JFXrj?=
 =?us-ascii?Q?YmJ96voECMEXNgNZKLcAm5hOjYCuISuroetTo7WUzve7srI3YDezW2L5hURQ?=
 =?us-ascii?Q?hfM9pCKjPeEdp9DoPf2V0Ew0lxvqi5L4q0vW1aZOYSZWD/KN8LCqIg6ZIBUP?=
 =?us-ascii?Q?OZs56d3bZ+bhsxLVgzNvFWlaelriSGkMUBcz0WriXO3KkZubI3nRPfvkhR3d?=
 =?us-ascii?Q?VqaFcd4Iap8lX1jFBc8ytGBKysd71y7S3N7cQBuugbgrD60mKjsdS38V3Ytk?=
 =?us-ascii?Q?9kcVohEwF0Rt04Q0KJkei6W5ejSVAiAkpBdjCTJR/pWUdtlUlzlCMXQtUZ/L?=
 =?us-ascii?Q?bNqZWkeunHZJJz03B5U3SAipXcMWMBDI4FwM3jY5PNGChWt76hvSgCyQyhcu?=
 =?us-ascii?Q?fk4/p29Zwok3kPygMWk7+Moko4ClOtu2cDeO6srBRj0Ot3UXSnNoN2b07cAf?=
 =?us-ascii?Q?EtE2sYw2ov3RbKc+e+rxzW5f/J945zpNTrvGJI4mQF20qzfjjdyccdlu6d2g?=
 =?us-ascii?Q?yCcaEtChkIkDqJlTjpwnEVVO2CGuBTKh/YgpMQ/vTFcfiPAjiZeAx5QDO9cO?=
 =?us-ascii?Q?p5nXFzddZfAhelRfL0qhQ3Pq1XjHMWXBoePa32SQeoA1OlVntrFVrSMSHkC2?=
 =?us-ascii?Q?z+4xVQvM2qvEi6rw0mIHpkC6zobnrD5PQcuzB5ni?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7190c1c1-9df4-4684-c12f-08ddb33da6f2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 16:39:13.3997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yx3g1tEISoFANPKiRf7iCkQaDO+uAewL8NFqd9fd0SPjB9ZG+lCYBaWk6640qXMktYs2sW7lw5kgtnGDjiBZDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11225

On Tue, Jun 24, 2025 at 11:35:34AM +0100, James Clark wrote:
> Using coherent memory here isn't functionally necessary. Because the
> change to use non-coherent memory isn't overly complex and only a few
> synchronization points are required, we might as well do it while fixing
> up some other DMA issues.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: James Clark <james.clark@linaro.org>

In https://lore.kernel.org/imx/c65c752a-5b60-4f30-8d51-9a903ddd55a6@linaro.org/

look like less performance, why need this patch.

In https://lore.kernel.org/imx/ad7e9aa7-74a3-449d-8ed9-cb270fd5c718@linaro.org/
look like better.

Any conclusion?

Need performance gain here if it is better.

Frank

> ---
>  drivers/spi/spi-fsl-dspi.c | 56 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 36 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 8212c4193536..172eb9929de1 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -492,11 +492,20 @@ static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
>  }
>
>  #if IS_ENABLED(CONFIG_HAS_DMA)
> +
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
> @@ -504,9 +513,13 @@ static void dspi_rx_dma_callback(void *arg)
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
> @@ -516,6 +529,7 @@ static void dspi_rx_dma_callback(void *arg)
>
>  static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>  {
> +	size_t size = dspi_dma_transfer_size(dspi);
>  	struct device *dev = &dspi->pdev->dev;
>  	struct fsl_dspi_dma *dma = dspi->dma;
>  	int time_left;
> @@ -524,10 +538,9 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
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
> @@ -542,10 +555,10 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
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
> @@ -642,17 +655,17 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
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
> @@ -687,11 +700,12 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
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
> @@ -712,14 +726,16 @@ static void dspi_release_dma(struct fsl_dspi *dspi)
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

