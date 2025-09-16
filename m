Return-Path: <linux-spi+bounces-10051-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 730BCB59C1A
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 17:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1F15821E8
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 15:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A949FC1D;
	Tue, 16 Sep 2025 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HM7OXRT+"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011010.outbound.protection.outlook.com [40.107.130.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131F21990C7;
	Tue, 16 Sep 2025 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036709; cv=fail; b=oWf2mRi8olOMYUAkbIELtXWr2VgAEsWDycdKKB+dzTL4Ovn4KA88x/cRjSBUO6MtkoV3I+ZOnZdTkbXI5cBQfE07erX0+nPPwwfhLFPvUEEUanlo6BQvnO4LYgMsoXoYZLDR44eZkhi3j24SWLgRozG6R05vVMrghRj9mvX98N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036709; c=relaxed/simple;
	bh=T2RS6HF9KcVF11wvrCy06Uq4nQxAztdnq6AKSrVELMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bvw4SH9RDyzp6ZpEcvD5KcOz7cAENmWD9QdtuyetXGwO7p38EomRRzxPueC3WREJR4pd5EAmZUmKqoLVZKu2lSTbhiAEH/+TA3O7UbItWQbqUXt659kO/ZOMI4iKTP2sDm2qy9KIAcaFI1Y/uaDvFM2pIeVBj5ncC1xpWe5jSl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HM7OXRT+; arc=fail smtp.client-ip=40.107.130.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWoLehad30RccnK2G6wacTKqGDCP6zpmX/OjdMTzMPACsed43PENbZJSi+NXIR3x0Bfp6uVbQjf1xA0hGA//dctp1CmRWJdyjnbwMmXMnbciUoC+xTH3QlvK3qezrJmMN5hBWU0Rkh4cPVzhK6ZUk6P2qTMTm6F2GE8+4cfl9TUnHejj57mzH6ZCeSERViK/yaxN+PKpqqkAaYyd77Zstg/Pns4vrSZm9QRnEATu6ZjCQrwWjfe4XeRQZhFCHmkHM67/FYKETryQDT+QRh3k9MXDhJY+koUnePE8rPJuQ4qMYfDsK8zJ0YTblcFXPhphjcPf1A7oQ2bTa5psqV8LFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISNIkFiNpgox0bWTneW8hV0btr4Rv9mzU/90v3fncWc=;
 b=T9sYN5mwJ/GFiXCIQKGEx0cjM7knf67oKEiwUkMUY6P9Fj9Wh7BOnSdm5HwhtVO9NL7nC8w1PXE8friM1dJMmPel+JIiTeZFK9+SrBA11hoKVzot2d3F1zbz9n27DTHK/gRYF9htVbd4F9KJffLkLqVtjoJRA2CDphTArrambhXS652WYhGEEZqIfrLzyOwAung5yNLh/Ve4mCmW10cm/tZr4loj2CCh0Xr/oI8QX600S0/m2Ma39NIUT3mVAeY3nZ2fRWj4/08JEfd+mGxsBUQchfB5gnF7+yshN1uqz4LFYxLknNXxj2ZeodbPY2PMmVe+la5SAX08OO9rlA6ihw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISNIkFiNpgox0bWTneW8hV0btr4Rv9mzU/90v3fncWc=;
 b=HM7OXRT+1/TRtzKtI2GWS5Mi+nt5zWtQuxUOokgHjJbPHlhGcXZtqDkOe6Ldtrul6xEQIj3O3kikLSo6Fl+OYWcX5jrF/4XtJS/L8RkDrx5bIExdij9k5wOHX1XuVt7XPPZurfLLHgT3m9fGNG5N9wwtt1gDTLeq1RVYDKvodA0wUsgAxzwexTLHN39o6HrtGjtO4/j10II5M3X7PAa57wudnQ1O1qK82yVYokJ357yrSqc1FMX0eU8Q2OjhVxrmnLOgHBtayUD1YCHwnXzG6/gCZBDtlmijuTo2A8hHWn0SjiJO1WYihgWFMeMez93SCMw+1z4YDAq1+++3LoMi/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AM9PR04MB8892.eurprd04.prod.outlook.com (2603:10a6:20b:40b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Tue, 16 Sep
 2025 15:31:44 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9137.010; Tue, 16 Sep 2025
 15:31:43 +0000
Date: Tue, 16 Sep 2025 11:31:35 -0400
From: Frank Li <Frank.li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] spi: spi-nxp-fspi: Add the DDR LUT command support
Message-ID: <aMmC167rzSYrIeTd@lizhi-Precision-Tower-5810>
References: <20250916-flexspi-ddr-v1-0-69358b5dc862@nxp.com>
 <20250916-flexspi-ddr-v1-2-69358b5dc862@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-flexspi-ddr-v1-2-69358b5dc862@nxp.com>
X-ClientProxiedBy: BY3PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:a03:255::6) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AM9PR04MB8892:EE_
X-MS-Office365-Filtering-Correlation-Id: 91fc0e03-ed69-4890-ad22-08ddf53623e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hmlcA9yzHqhOqehwV9GbR0PrpsMSEpzO1r4bwwO9e3PqKjBH5mceCBH61np3?=
 =?us-ascii?Q?ixC2EI4b1K1rg55N74UfNV5Ru08SM6heFajA4vk9MBXmmpL1Ooc64JwEdKth?=
 =?us-ascii?Q?R7cvH5UI6278EcHaOXrCdd8O00GY2TYuJO67r+Vr9nFFXO2D2ZXhW3p4GBJi?=
 =?us-ascii?Q?dS8x+Iacgr74SQiqhbcxL9ZiHs8OMiPrnx1ZiNyJL8O75j+PnHwmh8sIdM+r?=
 =?us-ascii?Q?ZSdHnui4iyqNvcXgQpWOoBE0ke1oFQYltkFct8YZLWTgjy6an1vOtAsgSnZk?=
 =?us-ascii?Q?cb5lVm0C53OGCy+/rHyk/jJsuWPbQ+5mNO/1h7xtbySRbix9MLEo7iTlWPmS?=
 =?us-ascii?Q?sWqSeAts2ZtLnzrVPN77DBq+vj2LDvsaPkglFrTwSl6cvtj1ZTgY4g060g6/?=
 =?us-ascii?Q?cd6h1FytqpebmG6g0/M5HXX8wvciBhdPF8G/k3WVFpBmnqaJHTGcM8XO5ogM?=
 =?us-ascii?Q?QDrlZmnZeD8vnVwSCDSAccqIxrbl9kHSWY0ugpAaS+e1cc48E5JxbLzTMBC0?=
 =?us-ascii?Q?1bx6dkVtXsL7NyDsgiva1eASKCxktPEJVmRmGSSJNua228ZKwpMZ5IMWw3ag?=
 =?us-ascii?Q?7sVwTwzpjw6ubC+iiQ1TSpJ7KVkDlQaOxdrzcrvIBYs9wmIQcmhROd51GEd3?=
 =?us-ascii?Q?mJw4KE6TE+j3bQx1L/ZpC89LhUuQWDnO+FHfqv7o/EeZUYQtQO9DkuH6r4IV?=
 =?us-ascii?Q?QFc/KY2BTzaHR7DqB/LjRMmqTQMe8BdEYn3avREfvlzTt+gwAkOj136IuoV1?=
 =?us-ascii?Q?QJyYTZgi3jmGueoSNqcV782yrPYFYT69VmJtaI5HbOB8RZ5WpPO9GupRscOi?=
 =?us-ascii?Q?xdEKVcKBmIGw+/8pUomMFNncDn/DLvEV9qTzhOB51pH5g0FSr5h8WaGDGhK/?=
 =?us-ascii?Q?7Pu5cR904LFHaypUKUqXrUE3R2O/khWp9lgpFe1vqWq/H/M4swCs35BDDeYv?=
 =?us-ascii?Q?M9Ufy8WOmK/9XXd3QnkYnTUWnb0+7/HHvCEq1xelqAnLL1zOUK7fFnggUrY4?=
 =?us-ascii?Q?8QdXa6l9BJyfsDVySE9LfbXGOCLS7TjjJsZyhAxlt+6dZMmy3MJcyQwihqLw?=
 =?us-ascii?Q?YO/yJ/9jnM8QeVo2FTb/mUApYGK8qmCzmiZCvHwJm9t/i9uVuXQUn+P4el0t?=
 =?us-ascii?Q?u5kY8JPB7m9JNhhBTamPwbh9xeJtOE3qUmqmI0IyvSlrXdZvOhCVNERH0wzM?=
 =?us-ascii?Q?kjJ+S5IE3Ig8YgZGDo+nHTZFa9byJ05xpfpnZzVJrhIuAOVCxKVUdyahamDA?=
 =?us-ascii?Q?HjWii8rIQXqBrb+YIR3CF48thKmG+0PTXx+Q9Bru0Kp8S+mVHXtz25pSxvnr?=
 =?us-ascii?Q?PJMuV2qWWCLBUCzuZ+jFQ7aZcPhm7V3fxreFd4MEwh2/J1dt5FS2ZkIImCKW?=
 =?us-ascii?Q?a1VdzwiH40wVnHsw+cvmeqf+XjfA7oKpCaDjGtFYkHT1OxCwHI1NuU8NcrKB?=
 =?us-ascii?Q?iWU1a1t7ff6j1E8VvIjOcEPNb2gVWY+1+ryJ29DiTRYe+DeSNGBYDg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R13UPEWU4ueWUR2zn8Q9cKKrJFfjtPOkhIL6PYUEHlssy2f012V23p7vYErv?=
 =?us-ascii?Q?/6jFkVtsNCejSAQ0EzJ+yUJwFVSgY2DkeNors04RMkr1t1B3rSPauCCXMGAL?=
 =?us-ascii?Q?omiyH8u3eIJtk6emksE2dx/HdD+joYJxzamRhTjOhGIeCp20BNcnRZdfnEFa?=
 =?us-ascii?Q?JTjf1RVvaJjg4wGNSk6kRidNlzeNQCe61PiEFtNeWesk5J3SlcNDgE61WDqL?=
 =?us-ascii?Q?c5Mm3ERzLZO8F2/bDJkVBwOfXPnS67P+hEn0rYKGtQYJmah98HS+s3bTfspQ?=
 =?us-ascii?Q?Tcm594iguPzVFMpx0dZlBEojMW+ljbQmkWJs0z7W2hKy0bWbz7ESVqY+MV0D?=
 =?us-ascii?Q?VbHDOsyURfF5oJr4YvpRW4gFqcQDZrjamk+YxQOcRDu0VlXLY8o1ebRiJSrp?=
 =?us-ascii?Q?tMDbjhQDr0iVET08IHMf0+gcj8IrGunloq+i7ttnNoqZ66kZSRgMhG4rvRtJ?=
 =?us-ascii?Q?3ehKhoLp8PJArOnlB6nrLckp7L73x5VtL21VK/HP8OnEVxIk4xFTC9teF1nV?=
 =?us-ascii?Q?PeX159wqt8gvYZGMtDUQk1s6j9V93nYV/v5m6eTYnIgxY7OA8euGl4sh4KOR?=
 =?us-ascii?Q?6wznX0W/7Gpdoy2/HHu5vIJJ9vC5men6qyWZttA850zpIT/qWnpHIrq0tv5R?=
 =?us-ascii?Q?sRGKyUqBn0N8FHUZrrK3ympuKotZ4/frIL9eLhVnzQx5KJKuys21HDPqcWKd?=
 =?us-ascii?Q?sWieeibNtKCsul2U4YCz2LN2g4HuYgOm2XOlmw3Sc9LrUDpuS574E5hkwpaW?=
 =?us-ascii?Q?V1cQ5CoebIu9Sy1/LI9Miv3+fwkTxMUsA+qhVb0IuNuiccm6ZzXfNmnyXSnV?=
 =?us-ascii?Q?maQlGD74IA/u1YZoQMnF34QD23jF5K6qCbQHqWVxjcbbTxi0WBnzPriBhrr7?=
 =?us-ascii?Q?O9j7S32AjfTMCNINsbGky+BYTT3IJcner2VLgfnCn5UaSWWX/k7m/ePcojuu?=
 =?us-ascii?Q?7DvA4zUL19fbFUDWxrgLPqnSSRHp922mDlCqC0lUW3emKs8yOT+ndsG7TFXl?=
 =?us-ascii?Q?3sKUY1mSptOpBmrTmNzVMVoIJGYIfjDSbyFuHD/w7qOEFumdnP/Hck1gKON8?=
 =?us-ascii?Q?LbqwQQVeQv7qeEBR05qfixKBWmfRp0ndenCflA7Aji3u7oNTE8KeVQGk6TCl?=
 =?us-ascii?Q?wgTC0R18SP1yAFafKozNuM/FfwbcbDOWn+gBeQbXo4+3MSVQDWqd07H+nOl9?=
 =?us-ascii?Q?n44q80x4G7pb1fpPrdqC6F/bcIYp7smLlZkT5UmIS+adR4dzXBOZl8g87GPZ?=
 =?us-ascii?Q?GSPJb5Nx4W7kndLQM2U4NVrxtMV/Ixf1ABW8QEZXR+knM94glZR+dIxvrW6c?=
 =?us-ascii?Q?YqNxILs49trAeSvVpaYOwJ95EzIWXd4m/A0cZSKmz3sH864jo80M6cYX5Wcn?=
 =?us-ascii?Q?b8H3ks/nvkdjAaqrIBSauycQFljiyzqnNLsX+lRC8e2U+jIV/aZ9auwG8lwr?=
 =?us-ascii?Q?GPU3DduIg4wH1inVP4lmL45fVvjy3FIDHHebRkViYScqXAW7cdlJusaGWu74?=
 =?us-ascii?Q?MRa6tKUSxoJKvd2+0LXaswJn/v/ybEkr2jUd4746hOuxIecz/POW+nSgDYFq?=
 =?us-ascii?Q?SlSmdf9dI56Lr8JDjrKO0ywTxNsrEnWFDEl+rdYa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91fc0e03-ed69-4890-ad22-08ddf53623e7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 15:31:43.8706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1jSBmwcTuwklWc/gBIkbzisryb52noMcnCViVahWuwi0VnCvee4pyS4cTk+35+/jtKnjYQoS4899p6ZCudxZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8892

On Tue, Sep 16, 2025 at 03:56:41PM +0800, Haibo Chen wrote:
> For DTR mode, flexspi need to use DDR LUT command, flexspi will switch
> to DDR mode when detect the DDR LUT command.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/spi/spi-nxp-fspi.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index a1c9ad03379682dc1fc2908fbd83e1ae8e91588f..6b3e6b427ba84734a2359a964635a8f05cd146fd 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -559,12 +559,22 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
>  	u32 target_lut_reg;
>
>  	/* cmd */
> -	lutval[0] |= LUT_DEF(0, LUT_CMD, LUT_PAD(op->cmd.buswidth),
> -			     op->cmd.opcode);
> +	if (op->cmd.dtr) {
> +		lutval[0] |= LUT_DEF(0, LUT_CMD_DDR, LUT_PAD(op->cmd.buswidth),
> +				     op->cmd.opcode >> 8);
> +		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_CMD_DDR,
> +					      LUT_PAD(op->cmd.buswidth),
> +					      op->cmd.opcode & 0xFF);
> +		lutidx++;
> +	} else {
> +		lutval[0] |= LUT_DEF(0, LUT_CMD, LUT_PAD(op->cmd.buswidth),
> +				     op->cmd.opcode);
> +	}
>
>  	/* addr bytes */
>  	if (op->addr.nbytes) {
> -		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_ADDR,
> +		lutval[lutidx / 2] |= LUT_DEF(lutidx, op->addr.dtr ?
> +					      LUT_ADDR_DDR : LUT_ADDR,

					      op->addr.dtr ?  UT_ADDR_DDR : LUT_ADDR,

put ? to one line to look better.

>  					      LUT_PAD(op->addr.buswidth),
>  					      op->addr.nbytes * 8);
>  		lutidx++;
> @@ -572,7 +582,8 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
>
>  	/* dummy bytes, if needed */
>  	if (op->dummy.nbytes) {
> -		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_DUMMY,
> +		lutval[lutidx / 2] |= LUT_DEF(lutidx, op->dummy.dtr ?
> +					      LUT_DUMMY_DDR : LUT_DUMMY,

the same here.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  		/*
>  		 * Due to FlexSPI controller limitation number of PAD for dummy
>  		 * buswidth needs to be programmed as equal to data buswidth.
> @@ -587,7 +598,8 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
>  	if (op->data.nbytes) {
>  		lutval[lutidx / 2] |= LUT_DEF(lutidx,
>  					      op->data.dir == SPI_MEM_DATA_IN ?
> -					      LUT_NXP_READ : LUT_NXP_WRITE,
> +					      (op->data.dtr ? LUT_READ_DDR : LUT_NXP_READ) :
> +					      (op->data.dtr ? LUT_WRITE_DDR : LUT_NXP_WRITE),
>  					      LUT_PAD(op->data.buswidth),
>  					      0);
>  		lutidx++;
>
> --
> 2.34.1
>

