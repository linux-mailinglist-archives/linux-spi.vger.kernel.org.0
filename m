Return-Path: <linux-spi+bounces-8831-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9DEAEC041
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 21:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54453A7F51
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 19:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E0220B1FC;
	Fri, 27 Jun 2025 19:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NOeF+QP7"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012033.outbound.protection.outlook.com [52.101.66.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96D2202998;
	Fri, 27 Jun 2025 19:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751053291; cv=fail; b=VLFMwLBBhHOMgYpbtBX+2b+73ngi7tKaZjR08a31WBMkIaCTkSE5aaStseJfSaC3q3eFiYfBxU1F7fQPTQ82D31DMbjWoCWTDrNo/RKMaXzcehKsbkbDtjdIQbHGvwCmAtZ9TrPnpfXDb4VXa8tbaSGNFHOu+VhbTTitnrRcNdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751053291; c=relaxed/simple;
	bh=UKlqWimJR0V1OMZI1ViEU3MXpica+FhCYFrmRFdsN6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fHCEzvnYxk5v9Pgs9UtJt/wNCt/xXu+Bccq1UZbkS7AZHTMmG6sX4rOybCWahDNFs1b5/hRzMLvpuYGMt/UXSZzN2lSP7hzu8ZUKngdMH+A9AAtbVK3Z6yeC4MJtM3XTHDgFSfyJnynDNJxfbcYyDwuDEezLe/nKrvMCczrXNag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NOeF+QP7; arc=fail smtp.client-ip=52.101.66.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjX0NtmhuD23Rsg9CClqFzmBm1olNL+WVVsFF9mH2Nt2SPo5beVn/XAIFuC3DGtTMyZmcZ2StKNs1WeZbLxVz/2apOhZaLaPfsjJLqp/07KKMfJGFuhWpdR4dVzM018wD1IsjuZ9r1odzXfMJSvjPimLI6KRqLnwgTAt0MmdtVtmQl1TV1DnNh4sTPSxMnYtgle80iwalj7R52Aw+Oc/rv9gsFnebKMmS8nAiXFOMSWytTiBttsXSuYR8JGojA0MYwSFJgGsCeCYdT4RetaZxhn/yW0G+DSmflIMjsz8uazzGXq1rmnJKQ4hrRfXRvoPJTn7aVO5cxdZD+wBoCx96Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ET7NhfYJhYr4XYshLDQv4GRlctFtc/P3tWHtkleB60Q=;
 b=xkNtSeVJsIo3qqSKFppxwr6maKcpP6V9L4IJ8XYh3lHUpEmi0ndqaFUJxTSrX8iat2qLDAmUgWDqSbJOlleRBc0RP2ZCATNhVDCpr+qIuFmb/ni9H8vpgGQ80RE8qN4kotoiOy3TDjfXjjLafKWk6pmJGdNhVRC+kU7RExN7nLWPGlzrJCMIlTIDFKqw1iG+kgl3UQEU5QT+kHKDpv/qGuTnO6Gw/6pQ5S2cIFimHoj2o4E0yOvVHg3O8wTg9waSNcXwesDb5Rr6aXHQhUjAFvJyFZMaCdVE5EtJObnzTwUAr+olx0d0Vd+fjIV+LMd+IIJJHjdoVQC4eqneFpW/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ET7NhfYJhYr4XYshLDQv4GRlctFtc/P3tWHtkleB60Q=;
 b=NOeF+QP7eVzZS7l/Z+kzxtoETM6jpWslQEFw4Ymui41MEmzRz8Er79wrPA9P4KzpCVxjuEkgHNsNK0sgf3xyeoQUDqCn5vnIm8/scv0NWN1Z5ql26h9aD0c4ostePyrdoKydD0fuRT+J5bJ8BovHKPVgFRvyaSw3OWZKbaTrZCBHggssIJjjY7ADfdEpl9f1HHB7CvZ8X5LX/5O1js1uZn4LhkZaARYhccdQrhZcYK6jP9hdDGrI3g6IJtKMv+C6ilZJYkcE4sh8wEjMhUbzab3Pqj5k/PLSt8yzI7NN0XgpgXyZmd2AzbmtZ4F8peWUCLlizO4ohKo98q3tUduV1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9111.eurprd04.prod.outlook.com (2603:10a6:20b:44a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.20; Fri, 27 Jun
 2025 19:41:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 19:41:24 +0000
Date: Fri, 27 Jun 2025 15:41:19 -0400
From: Frank Li <Frank.li@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Christoph Hellwig <hch@lst.de>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] spi: spi-fsl-dspi: Clear completion counter
 before initiating transfer
Message-ID: <aF7z37Cpyv1zexQu@lizhi-Precision-Tower-5810>
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
 <20250627-james-nxp-spi-dma-v4-1-178dba20c120@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627-james-nxp-spi-dma-v4-1-178dba20c120@linaro.org>
X-ClientProxiedBy: AS4P192CA0029.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a0a04a-d2cb-48e0-8986-08ddb5b2997f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2XiF1Sj88DErc0JXb+ASeE3xtjaA+9xm1sED5Tc13v+GcerSvrNzsTQg2w/3?=
 =?us-ascii?Q?F3yFFWliL/VUzvZuBrNkl87IiwSI+U0LSeXuLKz1MyVO6Uw5/SxO1ybDOX/h?=
 =?us-ascii?Q?zEMv42DbgxQmiUpGJYkLa93ABuHdNXw8p+eyQxSfUTtM7SLmsGAV9yookUV2?=
 =?us-ascii?Q?9L95ZstUv/fmHmq/koODuYu64qrlV2oqUkSB36V152hBzdN949buhlCVAzNy?=
 =?us-ascii?Q?QWL+HBsUtq6HFFIJDjjTAbT0u6HxYKux9iBkhsHLqsixjHEX7VcaZ/VRK3tF?=
 =?us-ascii?Q?2UjzbsXJN4VqMaKoAgBO/g8fT+NJhBynhYVxc6czl9uDpjNSxEr41jkegN20?=
 =?us-ascii?Q?Ni+x+cOJECpnwelkzVWEKqFxorZBLlb96e8l0bBsHEdDPcaOO3bmWEJyhXvJ?=
 =?us-ascii?Q?dNyELhFJf9TrkNTJlqMk8DyLv7cjQZh/A8qGDCRGdmvyHTxwjJlDSwbH9qSj?=
 =?us-ascii?Q?MgJ67/DOVNdjoxXAG+g4HtbDzb140boxzc8UtzbeaCTdF/qzERyWUxBHSueH?=
 =?us-ascii?Q?dPBbNgHuOgn2IUCuV5R5v8ea87du/vyVX6elt2mFvF44RmdwA2wS2DNhT/HQ?=
 =?us-ascii?Q?YeRB6UIt2NsSTAGmh08WTEPBvbZjD677MAYSb4LgMSbV/UaWiLZ5AJp9bowG?=
 =?us-ascii?Q?aVIDCPp7hl8a7swdq7WlZuW/wOJlJPYhZBvYrSHjfLzpMMGsuFzVeZtOUusX?=
 =?us-ascii?Q?d8Fse7LSDVTPG6rUgLaX8s8bGj17MuX01qeG7e9+BTf//iAqm4+bBZ7ECYrr?=
 =?us-ascii?Q?QnzSvNGeGbxOkxPS51BXELFoa1BNbzZIkbm3JnELegr4YahMK3klkMsJVpV7?=
 =?us-ascii?Q?6qb//UWcfBT2s9guhj5gQ6k2+4InifqH5JjglPd/d3bzLqKH5UtVLpI5nk0y?=
 =?us-ascii?Q?rZRuDCKiSuatKB01oSvSGmXPcG1x13CAjycK1x2JvH6xK3KyuJcNRk7Q8QKX?=
 =?us-ascii?Q?rLUjn2tGV1tM7zO2xA3DkOwCd2uxed7wv0aSLQKERZJIrbup7KC9cc+hHaYh?=
 =?us-ascii?Q?keUDVABlAYDHdOyHpd+xjontv0QnhkwJu2FJ/gHE70R07A+f3ZEm2O9IgDU0?=
 =?us-ascii?Q?D2RNCo76eG1nwYwinCZhvZCvv+FZSwUnpqCv+HQZOtBBn/SHcMr4jvTO937R?=
 =?us-ascii?Q?OXzm9bcr7eBDKpWml4KdLZyO/qse7ccuzbcgzecYK20UZCGp3MNTiCVPA7V1?=
 =?us-ascii?Q?884+3p5ZlUbLGrOTVNhuhUw8n7Gb+MydUnEYrVo7dmqnGYRG2jDUGooHp0Ob?=
 =?us-ascii?Q?4gt13otDJBqbKPBh1jzICseetFp3AdciRWnOshyUgmPEJ3mx1qNfoGqf/oKl?=
 =?us-ascii?Q?nPdwSxQkBf2OxloltTPUywsH2IHHD9V2NJsAFNy7ylwxt3cigpF8vFLK+vss?=
 =?us-ascii?Q?5wAZ3uLoli7ZFf5+2LZJqF5qSppjX0YHB8cp7zrqO0E/7SIztWsyg2fRny2C?=
 =?us-ascii?Q?lR19GlPuhPkM3cYd/hp7jBXqP7JMKOSyNe0ORfXMMQJsY5C09b3fHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a2m8LKF4geWgfk5nNPNVgknRYhjRlrewcXB61FlK4wok/U/wK+b0DcjCdaX2?=
 =?us-ascii?Q?Z+YZCsph470hg6uDO1+9c4X+RCBfKF5tXaasot6wna0Xmfuu6Ui82uBa48qp?=
 =?us-ascii?Q?xE4XFPMhk9aKDj7C5KLLBNwe+Koh4pLiE9GXQ61/Dl5awsn7THdKohoUeatE?=
 =?us-ascii?Q?AV9Xy3CXZKZgZjcjaz2Bc5FRFmkEMgkr66fbrDfaCF9Yrta+KdbLUOxb+7oC?=
 =?us-ascii?Q?ymT3VkKp6ri/SYY+nQU3XwuCKU7EAlR5zPI3WIx1EH4MnPfbbnaafFncbOJr?=
 =?us-ascii?Q?G46AeKTpOzxRiMYieY8tIAmri9XBUIeVxLtak+EW6FjooU5fhw/kLM1QoY7i?=
 =?us-ascii?Q?11poAou3T+23/arZXCMOFXasdx2AOM1dOXT9r6f5nGHV/snXZRuJ0fN+h97+?=
 =?us-ascii?Q?UGmcq6ehNE8F24C2uGT/izMEG/IF20vfJfNabpwI9zf+6eiRIN5a+MdfbtYO?=
 =?us-ascii?Q?L1/nDcA2D6NAZDZPKAgMJ57CKlixxD1K7wvDrcXZHbtQ9dDl7FC54CDOXPPP?=
 =?us-ascii?Q?WF5pi7tx8qTSpGK5QcEfzR/7nOvL6Ac9jLKZ/kQ7ne985tHWdBhgfeqz/JvK?=
 =?us-ascii?Q?+oWSsADPeAufYDhIV9qUV06RNHENxwYx3/K2atJgvs9SUleO76atoIIM6td2?=
 =?us-ascii?Q?yalGKQ/E2DM/TSTNeiUA5H9N8wG+7B3RGmUMcAiGj2yjLZ8snh8CIs4URfA5?=
 =?us-ascii?Q?1pNsHEXSoCMUSZKteVs049XQwG429DXNyit6N8egMbGs8ewSr2nNss4hzf8g?=
 =?us-ascii?Q?kukU3H0QbSDC3lS5fzL0cAJbi4OPYY4V5tjm+DOSH74sW4jSVLdrHyTsaPS8?=
 =?us-ascii?Q?qUVbwsT/gAIxZD7HYQIj7Mjajm0YDvLfTW3s4KqM87V27aEF7usv26FL2fHx?=
 =?us-ascii?Q?m57xkvMrtU1AnYTQ0aNk34bJPF+N6v0OQVJcmBYis4VOb23LWwAOAcGsJYZk?=
 =?us-ascii?Q?/O5NKfj/3pg0byFrkkTpE0Lq55mIK5idrsdhy7ifZh/zcursCFEYJDZnYOjI?=
 =?us-ascii?Q?V7QsYsKxvSkdQIEQ88HPmpu3Qe6NBTVyf7NvLiuYe0itDgRorladawP42pBq?=
 =?us-ascii?Q?mswIZHfFTOD5DQQ49Exm9ptwF/+MPE1zpBwEDjlFYON+7CUlO2e5wirH6u5u?=
 =?us-ascii?Q?hculwen8YDuV+7eT9oypRnE2iigWo+Ej87OrnxZj7gZWsMsjLkMzMy4SsZi9?=
 =?us-ascii?Q?FkbXgNBcq1A3Wfab/vAdzHocDi++vQwlLKnBnPnPX7vj2NMCC7U9sbzaP7mp?=
 =?us-ascii?Q?PhDjiV+Ggy2KlUKZtxnxidDI6p4BACeL+2Yo5AMvr/SsuM5V0eS6Hh1nbBwN?=
 =?us-ascii?Q?uqLsdScfdOq0va3LWXWX+FYW8LuVnLaeCaKmClQ35vMZFsx0Xlmg9Org35L6?=
 =?us-ascii?Q?ehqag8M2u6wIbh3tFg9rQ7kCOsiXSuEyY91LZpVxKVdsyHiSddER+we76DZG?=
 =?us-ascii?Q?aPvXIDDRspVflFznryppd/gHzTLaNBCyY4iba65l1PT4hBOWVafxW52v3Vm2?=
 =?us-ascii?Q?NjTVm5hE7ZzV635ibm73WIurjRSD78w2UmN8IiKB9QJVyOX3ANOkw8M7IPpS?=
 =?us-ascii?Q?zd+11aIQ9SWQjz4TJVU8lUAcKKLJu0AV07VEu22Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a0a04a-d2cb-48e0-8986-08ddb5b2997f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 19:41:24.2780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qH8nSnwlTRJ1al+12bWShHAEAvriSBET1jw92024p2Zw7t4H4VwmgN671syWdAhYtdBUUgZoeSdpOrZNOEIeYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9111

On Fri, Jun 27, 2025 at 11:21:37AM +0100, James Clark wrote:
> In target mode, extra interrupts can be received between the end of a
> transfer and halting the module if the host continues sending more data.
> If the interrupt from this occurs after the reinit_completion() then the
> completion counter is left at a non-zero value. The next unrelated
> transfer initiated by userspace will then complete immediately without
> waiting for the interrupt or writing to the RX buffer.
>
> Fix it by resetting the counter before the transfer so that lingering
> values are cleared. This is done after clearing the FIFOs and the
> status register but before the transfer is initiated, so no interrupts
> should be received at this point resulting in other race conditions.
>
> Fixes: 4f5ee75ea171 ("spi: spi-fsl-dspi: Replace interruptible wait queue with a simple completion")
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/spi/spi-fsl-dspi.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 04c88d090c4d..4bd4377551b5 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -1122,11 +1122,20 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
>  		if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
>  			status = dspi_dma_xfer(dspi);
>  		} else {
> +			/*
> +			 * Reinitialize the completion before transferring data
> +			 * to avoid the case where it might remain in the done
> +			 * state due to a spurious interrupt from a previous
> +			 * transfer. This could falsely signal that the current
> +			 * transfer has completed.
> +			 */
> +			if (dspi->irq)
> +				reinit_completion(&dspi->xfer_done);
> +
>  			dspi_fifo_write(dspi);
>
>  			if (dspi->irq) {
>  				wait_for_completion(&dspi->xfer_done);
> -				reinit_completion(&dspi->xfer_done);
>  			} else {
>  				do {
>  					status = dspi_poll(dspi);
>
> --
> 2.34.1
>

