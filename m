Return-Path: <linux-spi+bounces-10069-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A89B80F9A
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 18:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D7E7BDC88
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 16:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD2734BA5D;
	Wed, 17 Sep 2025 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MUbOyKEz"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013065.outbound.protection.outlook.com [52.101.72.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B1934BA29;
	Wed, 17 Sep 2025 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126407; cv=fail; b=n89yx6xvSGAwqGF6nqGTOY+zWP7xXogquOrwsVZ/3Ymincy9WsUBmrM+VVMOv4qdf0bCpZokW6Bf9oGBGcKDqJ2GcUUu+Ox95V8mccPfIVKChIKFrvQK/zJM1Xd+K5kaDTCyO2DiHWISzLYtGFgSzr5S2VPzRRIhl7MInFnSWJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126407; c=relaxed/simple;
	bh=zOSWjhR/oQF+mmOXzIx5SvibBgt6zuMiYAvqWscoIOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=htMWTHQURUl9i+qeExUnkQv9IiEN1kUkt3kuycRzEvqJomzArm/47ptx/FKt54J72UMfV2XyJuFiX5UuOlS3H/l2s1QHa3YVT5YDe2mIl7MG6dcCKap1Unj2DJt32wYbN2rs2mVJSKiuWhfbq20d390DUV5cKMVsAXyhxMVnYGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MUbOyKEz; arc=fail smtp.client-ip=52.101.72.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jl0y4L+6HgsQxnGANpn6N8hv0ZPqRSEwTk6g4ZPLk7cT4m90A6AtDMyxbis+c2U9pRf3sk8wZKbyZt+AP+a7a2R53MfRL6p1ZFt5lnz7pp31lkcT13JiXgbW1YNksC+k68aJWxFnHUpGC+PA2mmpMFF4j4HH5HwneZjOX5g/cSq9Hn+Grv54GdVo30McMzuOXt6IwUhKMGo512cPVj8Iqht48b66fCZFluzD3CEHHFrTMqcIqm2ZWiYCqEiRXl1AA2qIRV4KOlVf5EP8K0YqMy1HUwCBUw+bKXYbQhqziTFgwNpuvleWdp2xPHDWX2dO1eBg/XPZBgX32OUY/jSuMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fpcpqhUZYEbkqDAe+z9aXR0i835A1iwQeLfSGS2Bxg=;
 b=BHdBeXq3PqD0HQv9DF17RaDXVIfS5TU2Y1ST3kYNjVo+qhJwaWXrZguq9g5ulezJrd0A+om0bGcm7dB/1wfJXPTqIwkqVt4nNufpD34Ecu9jI9DoFIn0K7p2tSVCXAgXZg9XHYJBMQ51Rxc5NQGYmm/SRCj9T0WlvmuDYyH7f9vjCQZry5hx4eZN8TPO/LBA5vl9dQoInsltiBy+o/9b5EGnT9+bQNxHv5K+ep7rTa874Vb6Uf92ZZ2Nnl1SyBnlwx+pcOAVOKCql34WYJJj9v04D2Dop0scvr1a/Cers4As/2uPt5pO3XEa+K1ZmEXTUPCxxvatyOQe5w0NhKtDGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fpcpqhUZYEbkqDAe+z9aXR0i835A1iwQeLfSGS2Bxg=;
 b=MUbOyKEzfoUT3Lb941bw2aHzUcjL+6PspoFG3QjAb0P2HUcbOx50gnfc4WwWMY/q8nQr0wVrnAV24z4IgZoG8gA0OzH0/Wb6QIdqsUC+OsMi+JoCTg3j3QBfm6uw7FkW8B3EczQjAq4VqQk0X901mV9Qtr2+Xk92LfD7TUbN38CumkfOyuRzKNmXuz8ucBPI8ZNZjZ3vAJXghmR8/LmqFiGzs9BnTUPTRe5AicrmlurPGvW11jJ5WII/8kPdffzmv5rmJ/T6Ng28adqYSqAhU8geo4vEPPKlTWSIMyjZ7RkEjrjOEo5M+3o2buZrHo4EdGp6jlym3jDH9/L4/gIfrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI1PR04MB9859.eurprd04.prod.outlook.com (2603:10a6:800:1d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 16:26:43 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 16:26:42 +0000
Date: Wed, 17 Sep 2025 12:26:35 -0400
From: Frank Li <Frank.li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] spi: spi-nxp-fspi: set back to dll override mode
 when clock rate < 100MHz
Message-ID: <aMrhO+//We97QeLL@lizhi-Precision-Tower-5810>
References: <20250917-flexspi-ddr-v2-0-bb9fe2a01889@nxp.com>
 <20250917-flexspi-ddr-v2-2-bb9fe2a01889@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-flexspi-ddr-v2-2-bb9fe2a01889@nxp.com>
X-ClientProxiedBy: BYAPR01CA0046.prod.exchangelabs.com (2603:10b6:a03:94::23)
 To PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI1PR04MB9859:EE_
X-MS-Office365-Filtering-Correlation-Id: a69d563f-37c9-4d97-da3a-08ddf606fcce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2sPBPXxKIlPDboIkq5T5GulcO5IUzijY9Wdw+2HgiCbEvqIgUn/6WKhgCUeL?=
 =?us-ascii?Q?JD+hd+epnIGd2SQSz/yL12daZ9S/QoZIOKhgH+WyKFzP9aesza0/uvEyWYrK?=
 =?us-ascii?Q?QBGItziL4B0qo5s1rmBUp49u56gsf94IebbSS+zPF8LDioohQ1AlXgiNXkDi?=
 =?us-ascii?Q?ElgPXF0EKGY1d/98yX+Yn2zG9tNyf0MwUdYA1Qf5elC7SYupyMKQxSnRDcL2?=
 =?us-ascii?Q?hCxxkSZk1EY0fkE6rD7KvqLw+Ytp3MdZFBVLEhBt0viPXi1f3ixWn2RPpaqG?=
 =?us-ascii?Q?GMZRDMF7RRW8vol0qgryc4WYYMTCwFkDnWeBuU4kn/49E1AaH52Oc3cI8qbM?=
 =?us-ascii?Q?CQBp9exNknkV39eRVqxhyyaEHdW+C0TXLRItkzQW6a2MxBZGawpjndRAKDoy?=
 =?us-ascii?Q?EIPfgoG20P+gqBEWPvp/LpYH9AFYADUa82yFH+W5epo3Q75Zqn63tn4dCvEV?=
 =?us-ascii?Q?YJ6ElX2DxpN98EKzUICqYEU1OYExuzin/h7hVsw1la3XVF/NX8PN9dwDCQBH?=
 =?us-ascii?Q?c6ICvzEPv0g7v5A6ftq6OJKniKPRMLoGgrQ5ZWgPig4kLoFso3wlzntGkU18?=
 =?us-ascii?Q?HNEBfci66laYRU4IJCqcJifY101541zXyuuVUIL27aq/b8AdnZWskY9QHX6t?=
 =?us-ascii?Q?Tm7EcPAwyuuBW1GYlTio6eyQE4qp/DzPNNipLS1NbuQ8hTcWaDqTWwgVNL77?=
 =?us-ascii?Q?vPg2pXR5ekgIqllGjrG+BWubntaGGP/Kaw7jx32JZ0EStM0cCeSHNNxS8G9k?=
 =?us-ascii?Q?orOCVpklpwH55VpPHEupp3afi0vXmlA7MKdooZQTIiUis+dDW7wp1puXAIHB?=
 =?us-ascii?Q?3lfi2V19KP+25u7GsXuq34/YBMVFTLipu5kDAXuqr5KjxETQaUqmNQKDT/4b?=
 =?us-ascii?Q?7RLadng/poGy/ohFx4wLogHpbpOuHqmuAv2a17AJvRRseizny8A8e0EbNZlM?=
 =?us-ascii?Q?Xtk3zxIFPkJzN3J5wTRl2Nn6D4iHBxyhA92KYjzerd43tR1n+V1JmwsFDPte?=
 =?us-ascii?Q?Dqm8qbT+y9GOBu7kiGTGYYfgilyAIlNiUcyqCacS/IZ5a3dY9HN2h/lIC7Cm?=
 =?us-ascii?Q?ZfHsipGzNu0oB6dTERWpaAeABHGo+yd3YcpS07f9KWN3uacsUFKEeW0VvH2w?=
 =?us-ascii?Q?rEgu7zIhavRqB9nUxFy8Ncx4BAEOZXVbrkgYS7/tgnn53nxUzd/0Hsgz64m7?=
 =?us-ascii?Q?U74Qs+WyjYEPRS5UMrywZwStA40fZVZcSRu/4xB6VfQf0ipkrmiZ4/dwyULt?=
 =?us-ascii?Q?58IOUkdq9omhfiyLQCyqUoLiBWhay3xO4dy92aRZonmjmlwITG7cxFarmqaR?=
 =?us-ascii?Q?gNFCX3ms1UMRAherJE/x63wCIj7i78dJ9aZ3i1xrTHaOYvyJBfbZeKkqOxy7?=
 =?us-ascii?Q?7XYnbA8uYU5MI3A4cLgwzJGIUGrvG1oP6cmT+FmPY/cMufP/F9976FQqw5F/?=
 =?us-ascii?Q?+eRBc5gxR5dsJbzDp7QXedZLWT7wEpB9IAKSur/yHRohv9j6grmqpw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pQY3m6v1uYdwrfFVcMyimTrzz5rpvhZTodkoQCKHF3XQB/Fm/LfWnt4z1sc0?=
 =?us-ascii?Q?iqQxMw/jRN2sew1jm30jxBLj2sABjGPZzPZdHYX/fC6XN5cJyBEoIRixU04U?=
 =?us-ascii?Q?X3a0iYgGQnTSAJT+MskO8Ktz8qgl6p1tfhNKMOSoFesvPitTdY3j1tGDqwlT?=
 =?us-ascii?Q?Ib21XRPbMV9e+A9eOCv90/21XL40gDqFGJAeq/DkkcP8w+F2Emr/ypiqKRVd?=
 =?us-ascii?Q?cHQ711q379QwWPTyAeXSg4Th/JXs4Qx31pOxjyqxxOvZqUd75sjqDjB5CLN5?=
 =?us-ascii?Q?gm+tU1ZE38dqvnW4elGjZ1nOnN9I97W81ct7Mak6WA2zx/MnzLQZEeARJZoT?=
 =?us-ascii?Q?UoNSdD8jxpssETWaY1mv/oSboguQiginY4sBRAa7Xd9MAEdgdPptAU8SYFFU?=
 =?us-ascii?Q?40nGDepT8SK5RHJhAbTyp/gIbgzq7tQxX3L88nXLWWoKf0n1y792efheHq8W?=
 =?us-ascii?Q?IhrDP8eQLfLvnRDTnMVK1yrgikZgj0kDHtJB8FdCiV2LDwxAyIfXrtgDr+Jk?=
 =?us-ascii?Q?HzgifXDDifGDnq+AnhL7PYbYGd9osCXEGeRY3zaWzYBDAPMAeuhITaU9Ivaf?=
 =?us-ascii?Q?T/mso7k6L3eWkJzpJdAQePPktn6q//Go5+twWNTk2SrPA8ErrInYSbhvHm0W?=
 =?us-ascii?Q?9SL1i5OPnZbIFjIC9iJHrzNcAzDuzCNQbzprfQHfRuK2xBeSCrDhjCVMERF7?=
 =?us-ascii?Q?fWH6j+Giy0JxDCwVJ7/+nWW/h4FY42ipNJJcuFLgvP0+Uy/nOUGJJHJLnS88?=
 =?us-ascii?Q?H5tT9qaL25Ci69fRnJMM/pxg5uScCbEOf1kZkUfPmSe+E1McUBW94iHk1mNR?=
 =?us-ascii?Q?rrqhplwgtCxSAdUKsbPAxWOoVHgW5CnOBSogyS1DqQ8E5AHZQciSacNJ6Rs0?=
 =?us-ascii?Q?Ni3zbJBq4wjSgfhuFAfEsit282iupZ6Kdm+0pXZW0Y2fITzk3BBy8bg0gaGp?=
 =?us-ascii?Q?e+2t+OV9n75H+NtlR4sr9XtO5owy1G1hEUr1xYcU+CQic6wduHWCAbWq73yu?=
 =?us-ascii?Q?SIQgiUTJLBxe2hxCHYEfM/emI/vCLkvmSBleGEU+G7vDZmEZXzstBTslZMit?=
 =?us-ascii?Q?LAIv3wKSPSQQO1k+5izeqiwwyuotbZ7lIKSoBD3uL7Y915sGCLCjK4XWSE1D?=
 =?us-ascii?Q?UnAyOrN3kKdARXyqs9reYnqk1TSP2Ijpa94Fxkbvqulv2KALmi32W4RO/tkB?=
 =?us-ascii?Q?4yDZ+b3hdL4vIv8eOZL4EeVFk9yzFS5EuXiEajpHC3Ubxw0Gr8+Rkn4VVTv8?=
 =?us-ascii?Q?prOhbLBD9qnlIQ2ffK/IbDzx1kULmhU3UsiMBnMsC8qY9ra3JeeFqlvUUMuS?=
 =?us-ascii?Q?xf4WMCVhYNZnVv+1YSSoq5xxNHNAZ38T1W1Z0MZ3ImidAQzQX10t14VwTL5v?=
 =?us-ascii?Q?DfENRndY17a0tUcC7+LZO3l3KuShP8nrhxND9Gc0v6l7HtLG1vCsF56fA6fF?=
 =?us-ascii?Q?51IefPFSwVA0qndErPT5YhXZiQOEahRBTbCTmc5F7AkF2cSG4oo9fJZWzpd+?=
 =?us-ascii?Q?bwi6fehqwRY7dP3LQEiMcoQevkHuUgEF6UsYmWCA5W2wfUov5SSJfd0nESaT?=
 =?us-ascii?Q?qomhTh1uGbOYPlMLZaV5ZbTCSOW1a7rax3usRRge?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69d563f-37c9-4d97-da3a-08ddf606fcce
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 16:26:42.9205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qlP6EzqD2nmi490ABTysiLMA6v4//Ep3s1SvBL3I8gAd73OiAPubqurm011fFy+W6ekBcJfuK89AU2Fi0UBgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9859

On Wed, Sep 17, 2025 at 03:27:07PM +0800, Haibo Chen wrote:
> Preparation of supportting DTR mode. In nor suspend, driver will disable
> DTR mode, and enable DTR mode back in nor resume. This require the flexspi
> driver has the ability to set back to dll override mode in STR mode when
> clock rate < 100MHz.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/spi/spi-nxp-fspi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index db4b92490de957580c6298baeb8b68a310c23615..a1c9ad03379682dc1fc2908fbd83e1ae8e91588f 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -767,6 +767,8 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
>  	 */
>  	if (rate > 100000000)
>  		nxp_fspi_dll_calibration(f);
> +	else
> +		nxp_fspi_dll_override(f);
>
>  	f->selected = spi_get_chipselect(spi, 0);
>  }
>
> --
> 2.34.1
>

