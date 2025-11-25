Return-Path: <linux-spi+bounces-11519-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F6CC85D0F
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 16:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 842ED342FBC
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 15:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC5C32825B;
	Tue, 25 Nov 2025 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eknTLH5z"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011003.outbound.protection.outlook.com [52.101.65.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C8723BD1A;
	Tue, 25 Nov 2025 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764085346; cv=fail; b=k91rAY697zWejLSUZGZGprJbqfcVdZe42pawu4IQqd+VIcOf0LvgJvqhCDi12uEhbbSKK3H30Pl8GngzdyVSGQWm/59ok9lQiMLaoBTkFPaZz2ehx+eQSbeRbdGdFGWq7CVx4i2GlGqPtdv/Di1RsW+Z7xQy32trUTLqL9RuTKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764085346; c=relaxed/simple;
	bh=+nxGHppquNroAQJHNLzG5WnxUSVzBXvY5ss0CJYsAZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iq5Z0esxdRA5p2ufdW46sY5aPW9T1OnMiaUFt7LLMcvERtI8y+/KN3oHBlnKoW+cyTZ1rfRhysgBu0VaI3JFI8gGTapjWAJvJTlReekajOZlYBavN/BuqZvmI9lw8+8Rxokue1eUFqQWa+ZQpXXAy1jLsPy7k94buEa/RkygmxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eknTLH5z; arc=fail smtp.client-ip=52.101.65.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIaB5dQcHywHVO9XakYhW7Zll8gXuoH3DzzizFj5Uh7hXYkuwCU8JzHUcu/5AZ9OSXYaQZFoep2PvL/cIRA83uvSZzX0mjGxDOw6DHQ+p1idayl9Mh+foP1JMikh6w57XubvDIPIiXaynaJGTbtj6/OJ9Bvai3f+wyiERDRUxaK2B+bNeeZJfno1aMw2sOECzbGXXJ/0olb7z2TxmZoCPT7RtMzLC6zJZ0Ratw7OywMtAUDvSwJWq/2++ALnA4uAud031yst4OLMoVM3A4gGbIfn2k8UulZWwBfwHynN2+nZDWB8IWJ7NQGDdKtNTvaDzx0wv/cTt7wl/tCWyhdErw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cglGfHES1AyLV3WjpTbXMZr/1UCC8ZwMFRGQsP++r4M=;
 b=PO6WX4orGjGE8VwDH7hXjcjMJNbh+2ZOn/C+fmOvYcgE7/UC6i/hUSBJdt1OIdTjdLma396AIRwQ/K9rUV4e6tdFJPJ8/77mbw5Q3Pd3lzRd/4/2pUpznvt0SS0n3O8SnPrdxfcrzwcWMULZCnBiRARdSOCT1Yy4j/XTQFWiswjT2GMRlJM9kqtziFKhp53zttMO76/sfmgPtwREnesZc4X8quNXzainP80I2ylBLnjGqnuWJKX5Xhy2sN3lMO9r0ldGJhmK6zq9hfZupSPeKHktCUqxvjD+oU2+wUmyewulGXCPMlTgiqq1/kUNKdM1bcvyXqA4i5suaFUbQ67Iiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cglGfHES1AyLV3WjpTbXMZr/1UCC8ZwMFRGQsP++r4M=;
 b=eknTLH5zN5Q5BgV+1h+u4RqXBdvQzxy2MfVE4w5/VmDqy2WzUGZWTrpeqmgIs7bG4zEv14dajvAQi2kQC+zs+WVe7N2QGadfnmI6vneuxMNng9MgkwuVUVNUF+Brg6A/aq3X3JmIhUHT46hyoTlU/uGrqF0uiYPSu38p586X/hPjvrLvzgfegtcpuA+K7MKJ20OPjTZDnbiGLzIRYfhYb0sT3c2+VlNaXRneO4dhOiGyp2orVOMXCs/1yhS4R5LiLZ/nbVKWqgPJBv/SoGx51q/Jog5wREGRqHmTL6OxB/A9HBPtEt5743m78wO/2qerhOboK4uVslPEYvkJeTMCag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GVXPR04MB10946.eurprd04.prod.outlook.com (2603:10a6:150:21d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 15:42:21 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 15:42:21 +0000
Date: Tue, 25 Nov 2025 10:42:13 -0500
From: Frank Li <Frank.li@nxp.com>
To: Carlos Song <carlos.song@nxp.com>
Cc: broonie@kernel.org, hawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] spi: imx: avoid dmaengine_terminate_all() on TX prep
 failure
Message-ID: <aSXOVabiKux8T1QU@lizhi-Precision-Tower-5810>
References: <20251125100618.2159770-1-carlos.song@nxp.com>
 <20251125100618.2159770-4-carlos.song@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125100618.2159770-4-carlos.song@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::35) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GVXPR04MB10946:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac71806-ed7d-414f-0f98-08de2c3938b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rn76xDtipd0IX/EJlRjaw2Hxn0X4rVM9y7aC6G/qQHmbOBtB2X2NKUYMzn5C?=
 =?us-ascii?Q?OcOsShiXWeDxeDCs6F0lA6GwNr7u8Xx8sCdxNec+CbHIhkfltBDIqNJRkNLM?=
 =?us-ascii?Q?BNuD3Lg7Ejslq6lvkN1HTkblCyGQwdvHsu8TuyNPRhxer+4glPsdGEylGJqH?=
 =?us-ascii?Q?Mz3KSj0IRIB9s1KUStK+Bo086SyXoMIb9AuYXARWOjcPgDdmySWRnNHEYw3G?=
 =?us-ascii?Q?nIFh76VEzfuMu/1gAUpdQbpQX0/JATv6RpsR48z9L739XKwg6sIBMSpi5Niz?=
 =?us-ascii?Q?MznDYa2znXLojwqNgXj629l82Ct/wKmJOWosWTKw9sanlOMHLfUrFXoFy3Et?=
 =?us-ascii?Q?mJm6+J21zvA0midFgNdesdJNikPMENC47+SuZQEMyWZASKB03wtkvnWqFJa7?=
 =?us-ascii?Q?Gio5mSYIgpK13MBKcIocvk84PA/Fq8XNLodTul/mNxTi2n3cLHD8GrllA+JP?=
 =?us-ascii?Q?wTB0NZCSuTnKeST95JqD4Vc+RGFa1jsIiuoOTwTsRPyKkW5odjIhUvZYvYYU?=
 =?us-ascii?Q?0J+8HlNZpa/XUhnRPwBxfGk0X4tXOlkbDC8MktOsdPml7n0lklrn5y5WAF11?=
 =?us-ascii?Q?EeV03SeKEf9leVaoryi3b+zivrpUvtXZ9IYS5QpbiYzDE7iwygzRKRTQJ7Fy?=
 =?us-ascii?Q?ior2o2Dk026GuNuPgbjmnum/YlFqV/x3ioIU9Rj0dUTrrECDunXh/po5KR7Y?=
 =?us-ascii?Q?LOYM0EJTEgqvraWB1YTqqAt0Iju0Zwf4tU0tUf8R9hgjnV0fT8A0gQKEHQ91?=
 =?us-ascii?Q?RtJnRC1CvZtufemRh44+ypTcw5bmOP/vIsQv8T1wDAZTNRfnTUabdp7SuytP?=
 =?us-ascii?Q?AE4sDL1W2xITdCvpGqkTf/KWUOzKzcUaJoUH/vQJmkdgrAbPoNdw69aO5mbS?=
 =?us-ascii?Q?Yq73pwBrNn5T5jsErY04HFyYMxXI8Z7VutcW1r6oUitYWNGoXz9A872xjZiG?=
 =?us-ascii?Q?AO8MIYwuQUWVZlppf8MaiH9Lhfx2DkhWMoV1mAUdxVZC5VUFTElkgidEc9Zf?=
 =?us-ascii?Q?J829DwADFPyhIPOvXz1zgpYJ45EHjEnI2lMoS/1/0QW9+by6C/SeSm6uX6Xr?=
 =?us-ascii?Q?v5EeF33I7mTVv1UoYe+jPrsLvNkKlhIqIPF5eGoFe29cTQVCMLEe0avWBpta?=
 =?us-ascii?Q?jUo9pmxA/8VOimebEZ6V+7eQfOtOg54qFk7WBFTowEgAbtP8M7cFHGZ+r5IA?=
 =?us-ascii?Q?id930SDalpr3/D8/yCUVp0b6nYfMRH3LhTdskumj2wQYY4dxsqcWxLHgdmWx?=
 =?us-ascii?Q?M3sPYxm4WilZ9UQGXua9SIwhiHMqh72g0JYTm/8qTi7Fk41WhV5pkcg8AFUh?=
 =?us-ascii?Q?J7GXgIbekmJaejUJu/TM1bC6eTIxK7Q97I7RzLdLXd+MtTTuAijjuo3qzQlX?=
 =?us-ascii?Q?huI1FTE3Kl5hPVftr4JK98tVQ09fOCdNRE7Nczft1Ujp83ZuBcxp7uliCN7p?=
 =?us-ascii?Q?pCEWc2ot/+OKNO9snqvu0QCrc+cmVEBHg0yBqZQ/ratscQs9ZAQlF0GDMF2q?=
 =?us-ascii?Q?pB+m5XiFZgZmGzJRz+QV70KbIilS+Oq8xZr1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7yXaerZZQBT0V8iooW8zVA8nqC1MQGNeRkjX7gxSV/TRyse+Z2aqUnV9PPOC?=
 =?us-ascii?Q?lCeIAS6tMy1dVM090X1cEj70pavfYnMYcfNKzKnKeLHF198PffEGLF0VbKKY?=
 =?us-ascii?Q?qfuzf879zSLpAEvzgdxqhtpaLkP5acnGQMrXf+IzA38+xLoUCMGNcH8x9WjI?=
 =?us-ascii?Q?O4pdAiM6wYs7giOx5VB/TQKk1P5ZSaZ5uRZHdJLXKyNIXP/9tDI50el0PLMT?=
 =?us-ascii?Q?tCVBMP3abecNECXMCuvS2HCI+KbYmbsNQMme3+kNiTZzrLP9s0ADYy4bjkku?=
 =?us-ascii?Q?8/xxqAIcV41x3jhqXhZAFPaN35mUWJCfSVUa6/1ha/tTiKKk1FmlUihCnGkX?=
 =?us-ascii?Q?FwTn4dSbCEwGykRt4pMclQ5PBo2hu9CKIf2msbwXNCgCoze29JF0Dxso6qHr?=
 =?us-ascii?Q?qm+4HwB3kHhtr+se57H+Ulfs6PiuBB3mbwvffTEZCfQZsUN8EpX35PAzqVP8?=
 =?us-ascii?Q?KM/7CiCIcDpNh6kbPECaRZf9Bqn7XriwoziIK0xwNZzn/kv5sxz0x4OrII+y?=
 =?us-ascii?Q?ksi7dfmd27+RA4WWCg8tGk2/ID8dtLJkYFMbBSJkefgdsh9INyigdB2cLhj2?=
 =?us-ascii?Q?wi6lc+I5X1XeYFUomMg47zYTWlpiICbQzTbpkTviDJTIf9k7MZDnh+an9g+h?=
 =?us-ascii?Q?cY4LUC8s1NhyvfFRm1QH/fxS9Irnv8qaolyjHoVvEBfn2hM6vAF4KLz9rDeX?=
 =?us-ascii?Q?nt73tx7yxBhjrReD6aJLfMl3NJngp9lyKjNBt4K2dyNBnNI2/zKqdJsUnPf9?=
 =?us-ascii?Q?xJFlR8mwJG7D8KxQorfhxlMsOXEW25XPcG7bL9upzaQjT7aiu2Ar1kb7rP8+?=
 =?us-ascii?Q?BdOSsVmRxg769tvBbW9R9RgYXM1PF0aj87OzfaRs5yJhyxIZuF/fEsmx5wpO?=
 =?us-ascii?Q?KMpZzH2CpRQVTFRWLp7TbA4jRAti6HgqAgH4aRLUC22zc/FmMudMWVccrCIy?=
 =?us-ascii?Q?5Z0lofVw6h1ej6r0SWCwAUv5mZfArZ3B1ta2QSxa/b7F+Y1NFAGP11l5tDTK?=
 =?us-ascii?Q?CG9NSQWDBgvhmqLJhrZC1gAks6j8DnPzcnE1wZQ3wwadps9CKUQUornBwnbB?=
 =?us-ascii?Q?+7shN0TjtBVG5s9+rzSCx/LWoQZyX2U2e/exjG8ZIz6DC7x8aaZN1+jppbTB?=
 =?us-ascii?Q?9QfkLPGuLugwzTHmTZuphyAcKUUG1P0WYQABxf2npWxmDE2yYOuJ115OQxT3?=
 =?us-ascii?Q?GcgUPCCf26omXvM8p6y3Y/mKYT5H2kzWuAWPLQq92GF94Ebpt/QG+6284Ovh?=
 =?us-ascii?Q?aOm+NA+GCVLv7bbTG9LQC5kVMxFdcnULo7x1ZOlMe++Fcj1kf0+64Bp63/db?=
 =?us-ascii?Q?L7XhWSA2CyNg5Qz9YOm/2kJCbRekC4GG6KJqz9XL5Qv1hRlNszJdz7q6Um++?=
 =?us-ascii?Q?41HH7u4CjLlndNfpuWwEv0jRrIz6mbayMmnB+Wjs+gSR3P0WwfvqlkCesvK5?=
 =?us-ascii?Q?0G+GHrqheraplAoZXTH960PCQESX+vMzdSWxod/BN41FgLMKxdVxbzrFQ6j3?=
 =?us-ascii?Q?tiJvzrqIoVHY8PVRnG9pudvu4/GpgoRfV/zqyDuM/uqrS/Ci4bv2a7YuihFs?=
 =?us-ascii?Q?KN7nBqdiuSUsZqhNPDwSA3XoKwQbU3DULCckJd8q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac71806-ed7d-414f-0f98-08de2c3938b9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 15:42:21.0956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFomQEIlWePv0YhJW13InZDUK8OI7X/6+T9wRlDFTMegtQJf/pt64VQKOv28od0QlwFkYeCJ9OdrI5npc2bNzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10946

On Tue, Nov 25, 2025 at 06:06:15PM +0800, Carlos Song wrote:
> If dmaengine_prep_slave_sg() fails, no descriptor is submitted to the TX
> channel and DMA is never started. Therefore, calling
> dmaengine_terminate_all() for the TX DMA channel is unnecessary.
>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/spi/spi-imx.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 012f5bcbf73f..186963d3d2e0 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1468,7 +1468,6 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
>  					  tx->sgl, tx->nents, DMA_MEM_TO_DEV,
>  					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>  	if (!desc_tx) {
> -		dmaengine_terminate_all(controller->dma_tx);
>  		dmaengine_terminate_all(controller->dma_rx);
>  		return -EINVAL;
>  	}
> --
> 2.34.1
>

