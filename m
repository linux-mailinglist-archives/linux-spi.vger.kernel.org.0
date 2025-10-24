Return-Path: <linux-spi+bounces-10838-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB4AC082CA
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 23:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625E43BB9CB
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 21:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D970302CD1;
	Fri, 24 Oct 2025 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rcy21b8o"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010040.outbound.protection.outlook.com [52.101.69.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14472FFF91;
	Fri, 24 Oct 2025 21:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761341134; cv=fail; b=HKoNehuUR+FWVXaSZqX49AN/3YDC3BDpg7j39REGfIIUKiCPzewVWof7Q5coy/P+KqfyaT5/cu1nkom4AAumAgd1Lr8gpPCCND+ySX6lZSlg99Z8/SOi4z2X03U6VGQjKnz8IjUI9GMT/vj7SaqfqUlwc0GU7S2T1h/2lTMsn3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761341134; c=relaxed/simple;
	bh=C7rfQwS3/MBZlN7Pm8RAkKOzI9ljIVfiwvvUXS00Ebo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H7wH3aPquAB2VWotfJ3n4zcdUuOAbHmZKsKz1X5RFVOWBF/ShSGtQru6fNs3MwiZmZed9vS1iJTLmN5W4Y5UF/rxVicN8Pyc9xtBisyXLrXRIYtLzXBm0Ve4lj1b+XRswySeBAmA83k54XTejwc48j4Oet53bO9R7EzCMJIlHjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rcy21b8o; arc=fail smtp.client-ip=52.101.69.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEIAV9g0rL4qs4E7FaQ5E49NAgIT1B2EkzhCbJzOvom7mRCWAso6PuVhLTTw62QnQga5QA1WSGIMH3qe3ykUXfgEcjRxojSoZD8SXqSn4/I9CSOlXqbcYOEK6Uh+/IUrSovCCABPDSqBTS7EKD7VnV5GpIQib4OWlyS/i5P0xcahkLjuxlbGUWGuQQRZhk8AfXb93YyXcZA01SbADiAFHsMEiU0IiNTNgj2B0S//v9chl4cw6ZIjQdZnyqIPqwFVwOYqajf7q3EzaWj+UTTZ8ErHH07i0FSTRF33pJ5cZpUDIgO5BOWjLVVudJsxLAYxMFtYqOTw+23hJZYCeKCgug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1DsjFzZRmMvHHGGkx1iCftEGsLbC5MGTWXJsUgGTL8=;
 b=ISNKnPI7kewRAkvDOojdi4jchyGmMMA/+kDvVgWO2lmxbnvnzPZg3bFElaCeoHhcqIVyGaeVEa5hI/iKaTL9IfIhCuce5E+qAZzVerr3dgo1AUnEKq/NT+ygkTTh5ejp84XQkBjqUoai0gMXGTENHJ9CBjfCSm+fVmz6czMK61bkX2J3bnapznQW28ApGt12T2fUwm/2fTss9N/J+Hp6belxeq0CY53vXndtQC7xQTphlB1wJZQciQYgcNnWCKaM5Jglw7x1R/QK9LYlOmVX9YnK9X3vMEMeMhrsRJWDxAVQAllP+2OhledfuPwAh/iDZkUojfoZBtxp/IQf4Au7/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1DsjFzZRmMvHHGGkx1iCftEGsLbC5MGTWXJsUgGTL8=;
 b=Rcy21b8o4D89r7IT/QBz8P3DuMsQPg4HKK7CGn6GNu0eLAFnDgA8a27LSVZFpqLfowQzOlGhLNfc8D2qw4fmc35Dj1k4yrPH+HH249RJhYtAUh+1fyDkWfEszepBcwnhQDKA3Jl6uVJE3MmTRj5GmA7syYPhkxYGWTPus4cT0fzupaRZnxfl/3bl2mC+JcSW4mEP+yMSuCHdZfMbUbOA4pYqtG0cZbaK8Jfd+DhUu0BWzSiAvQjeM9ROHUh9UqB8r9mJZpwT5GQ67QUb68tuVLfVPiE4jmbpsmCcsryVtdkyaWxI633WkiWSQbHkDb1X8HzPNE6qPSC1hg/X9GjtqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 21:25:30 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 21:25:30 +0000
Date: Fri, 24 Oct 2025 17:25:23 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alex Elder <elder@riscstar.com>
Cc: han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
	guodong@riscstar.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/9] spi: fsl-qspi: add a clock disable quirk
Message-ID: <aPvuwxCaZ+9cz6qO@lizhi-Precision-Tower-5810>
References: <20251024191550.194946-1-elder@riscstar.com>
 <20251024191550.194946-6-elder@riscstar.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024191550.194946-6-elder@riscstar.com>
X-ClientProxiedBy: SJ0PR05CA0191.namprd05.prod.outlook.com
 (2603:10b6:a03:330::16) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: eb75990e-9000-4ae1-4b60-08de1343db90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6RaAM+L2et4g+G3iRbcZfRPQD+YIsx27ZTPny3u+mtijnAyOAKRVBHM1KinN?=
 =?us-ascii?Q?qP6E0e7ht3b9dFaT7OPETQwEJGUIaCiGzfHXQvwDnhc8h59oQOxywFosPnB5?=
 =?us-ascii?Q?LAjB00RfAHqxjSMDCp3bgG6Fag3KH33o0xke2rHMKzuTL+kOlPqoRNsBc6re?=
 =?us-ascii?Q?ovY6uPF+Pb2AsZpKU51T27J33JZhQUcdcpAls4kOIIsp+16H3q4S4kCZUb0Y?=
 =?us-ascii?Q?Yw1ts3bUWk4Hw20VIgWLY4QsuXOPXC3iyxh66J1HN9oM/dQRwVWvTQDIkkH+?=
 =?us-ascii?Q?580t46lmQrT75LiGCo0w0ETxsaz5rAlZIy2Fx1+QdG384DQCPP+7VffkvH4P?=
 =?us-ascii?Q?Y2WolV53BuSWlBiZ95kMAJU9WhXrYaidZNTqnHg0kDUXkYcEsLo6HrA7qcfX?=
 =?us-ascii?Q?Wg7vV8s205Mgg7H4ewwjqPntgXmqTkiJhGpxcRbBevcnDFQAjL+lDtptLnK0?=
 =?us-ascii?Q?jvcFtim+iy56gBSAqcBSEwEN+1oJEQA1akdMNXOpokGOCIkVVz5RRhyXku4T?=
 =?us-ascii?Q?pxjZeu6Tt9r5c7OPnd5jql2/xDwmdDKYyCM+irs/WF3TzJWVEQB130U//UUK?=
 =?us-ascii?Q?YlGIP1sW8SMWrpvWALTuVIsD0H4pSleAGVESyQYcFKm7F6bZlOO3J1hLOFvR?=
 =?us-ascii?Q?7ODOhvbP4u62PTD4EU2/rFLcqUB8P+Ma8fUJZA5R/u93txBOtXSxNWyIuFyb?=
 =?us-ascii?Q?vY0Y9cXVy5QuBKjz0z4TTlK5il/DWJZOrwGtNpdHXUpZePJCpA7unhtfQl5b?=
 =?us-ascii?Q?d5CIH6qeQmHDzI/w5b+yPsl6W81x2iGxnc7PES3/1qbicH/1fxSxEfVLrosh?=
 =?us-ascii?Q?8LKIdGx7+P+IgqVdF4oE65BCUd5nXjc4pRxyi6UBUn7+rH+VJR5MOw9t7Gz7?=
 =?us-ascii?Q?aMiC4ANRHWAl4IToH+OY8nQLAzg56MuXeH7hrUbKPDmT0TrQ5epYqHBWFrXn?=
 =?us-ascii?Q?GUNQs62UUD1Y2gK7k5sBjeIyV2xSiKauzqSDyy7X91OZRNC/BjJD5O9UKCwC?=
 =?us-ascii?Q?Pgs0lAwPiPvlCXC7KTyV/QqcPuM7706jb54uXvgpUEIJpJxXEdwglYbp19HP?=
 =?us-ascii?Q?R8c3LBUc3x9XiPTHKVqcxFnToTsmFJO2tqZr8YBu2aXtN7FIPzKCKfYuRx4X?=
 =?us-ascii?Q?lWEowplavuS+z8AbRMhNhCQRsF9CKluENFpheAPrjxSYCX4HSqGOEpGzVchH?=
 =?us-ascii?Q?IN7CfQrscnPVMb1Tf1h5vKIA5ie92v/xeKvf+Zm7X2AS+kCwjonD7pszk06s?=
 =?us-ascii?Q?7u9ZMmwVA0zoM10QsEjgAqLatahvWGZn70VIvlOKGSqr20k07dWcvlU7CrFr?=
 =?us-ascii?Q?PMfKGDgfud1YVbjVPfygnp8ckq04NQUaH3DO8jR6MvXVPkecmVp0ltygFTgp?=
 =?us-ascii?Q?t3V4uYwxSMwTuTa9KVbtOX/s0zCp3goIaydBOMCwxAXpnUv5KFvh8ysFgMHd?=
 =?us-ascii?Q?BCzwVO1WJ5Vf08ZJJySuNpqqliY46a6y191di5QQWMlnT66/lIHVgqVVUhDg?=
 =?us-ascii?Q?Vl6sU/eU81yfBg1qZIQicPBQJ7twkLJSCvCC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eGhuTSVV6qj6c9o+4x8xzq7501PeBQziqvuKSMza1JDIh8tjtYCe8vPRANsZ?=
 =?us-ascii?Q?YxyP0KZVD4sKFfan5oDRDRZvlqIhbvId/qdIepKtOrBg00eOoo493iUXHo6o?=
 =?us-ascii?Q?G+YMYl0et4R/PBneBvSB1X8hilJZFdkMaePx3uH1mj0liciWO6skYhALpJAE?=
 =?us-ascii?Q?0IwGRqJTuQ2NxEldnUhccUJcaY/GILzVp6a8tJ4RawGDJLMD34ijNgUnLZdP?=
 =?us-ascii?Q?qJvdy3yNdy3bIRdEynroafy2f1UuVRWYgD2ulr95HBNrYVYI1ZwwdWbrcGX/?=
 =?us-ascii?Q?MYuU3q7BqUIEl7s7BZK+za6KYhxEuTcd+dl070TW1buQxAJY1NakCwHDRJsu?=
 =?us-ascii?Q?QM1TeLvxn+rIZyuezK1ezVr2F49YskAJxLz6BnoKP+pA5HhNl889btsxO4qZ?=
 =?us-ascii?Q?OR/J6+dv/BYx5aZIknYYrrq6ajcDvg8WVm9KbaPw5EXcZAaiOw41L8AUQ5oI?=
 =?us-ascii?Q?YDB6Hq4Lwdp6kd3/gxhmj0e+1sdzg73bgOPnq/GvKxulgJvIsIS85VZDLwg0?=
 =?us-ascii?Q?BCbwgcCt91tsP2H7QLtqjpWsxCFKgkl65Oo5V5G+0bApk/kiGjjqx3Sk8hjq?=
 =?us-ascii?Q?DbycT9ltG1Hb9Mm7k7gqYp/CFRcoKIaZXChcV9iZQwBJ64g6dIOM+4j9YoKR?=
 =?us-ascii?Q?vDPolu7D5J8bNeUt4Qm5MCtlL6lLlERT0fEwCG+f9207M0515lDFMGzNT+2Q?=
 =?us-ascii?Q?XnemH2DtFaIWQgJBmICetSDnZLfzjiY5PQvgXvClrTyDMM9qd3nPffTN/NEX?=
 =?us-ascii?Q?ZE6hBPooOY18/L5w+JigCHQrfGDB3sWwYqBdQc70jkz1XXuPG5AqJnSbxegP?=
 =?us-ascii?Q?4Dl8Qi/ow9S1WtWKZS+rO42fIFewvB1pN7IWnSgAbjqMOdRfq/u6Nucg07iY?=
 =?us-ascii?Q?cdzkXfWC6hEBgEmKTzoWwbq2cPZbleVcRKPjWqBo8sEgOjPk0sCUh/kttcN8?=
 =?us-ascii?Q?kgchJ8TlY3ZEOMouot+a8Jc46Y7HvLrYKRNO1vx77O/nt2CbhB3pPPXT0zMs?=
 =?us-ascii?Q?Td3gEHMv+x6yZFFtFhUpcmMs7yGNMNriFf0V6vY9R/4n2PwdK+CJB/Sk5KtT?=
 =?us-ascii?Q?jR8q4moDTtAASVadxASG5jjJjrQ6FE+Be87nvW5unrgSaozhrh8wP1Untt5e?=
 =?us-ascii?Q?KoypF1zKn34+/93Y9LD9/ck6kFcZEAOjHyABHeLzizYTN33s4p/jPoGUhjpG?=
 =?us-ascii?Q?2GALtZFr3i6HITjOcNUSNYxeHb9hiCI6A6q1xCUkPCHzCAIKgMTX4fZkqcWO?=
 =?us-ascii?Q?Hdjq+tOlcih/7KGJSTBbKMn+NS/dkTqbbQbCbNY6ZYYyoSRPartPyXuzqCNf?=
 =?us-ascii?Q?8Xwd4eYTQvxpwxU12A0Fs2HfLHsM/Vq2lzd35dxr6w7A2DjT2lqWzeuzwtIc?=
 =?us-ascii?Q?n4ZM04IkwiuKmTzuuzZGEluZIUGSU+OBpGtJJeScp+85JgbcJXfMtpSGOfUs?=
 =?us-ascii?Q?mdBH5A8nKa0Gd5s0QybitZ4fYyHkJAmJeRapvv6KaRYMOaindn6M24bco90g?=
 =?us-ascii?Q?MSZ8iboecCi2lsHcmT8Y7O7cfyUdB5iCNDuYGG3ZlRqfxgwIyt9PxVyWkp6+?=
 =?us-ascii?Q?RVd2+OkF2/Q70mhnJX4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb75990e-9000-4ae1-4b60-08de1343db90
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 21:25:30.2157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hxe7c4ijOWLlJXImI3CFkUF58D39b9/3byEXNkc72dO6vp0p22mGbqM3EMMLAKvF+dl+BKp4yh8SOaxt40rgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8465

On Fri, Oct 24, 2025 at 02:15:45PM -0500, Alex Elder wrote:
> The SpacemiT K1 SoC QSPI implementation needs to avoid shutting off the
> clock when changing its rate.  Add a new quirk to indicate that disabling
> and enabling the clock should be skipped when changing its rate.
>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> v3: - needs_clk_disable() is no longer inline
>
>  drivers/spi/spi-fsl-qspi.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
> index 1944e63169d36..2c030dd6facc7 100644
> --- a/drivers/spi/spi-fsl-qspi.c
> +++ b/drivers/spi/spi-fsl-qspi.c
> @@ -197,6 +197,11 @@
>   */
>  #define QUADSPI_QUIRK_USE_TDH_SETTING	BIT(5)
>
> +/*
> + * Do not disable the "qspi" clock when changing its rate.
> + */
> +#define QUADSPI_QUIRK_SKIP_CLK_DISABLE	BIT(6)
> +
>  struct fsl_qspi_devtype_data {
>  	unsigned int rxfifo;
>  	unsigned int txfifo;
> @@ -306,6 +311,11 @@ static bool needs_tdh_setting(struct fsl_qspi *q)
>  	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_USE_TDH_SETTING);
>  }
>
> +static bool needs_clk_disable(struct fsl_qspi *q)
> +{
> +	return !(q->devtype_data->quirks & QUADSPI_QUIRK_SKIP_CLK_DISABLE);
> +}
> +
>  /*
>   * An IC bug makes it necessary to rearrange the 32-bit data.
>   * Later chips, such as IMX6SLX, have fixed this bug.
> @@ -536,15 +546,18 @@ static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *spi,
>  	if (needs_4x_clock(q))
>  		rate *= 4;
>
> -	fsl_qspi_clk_disable_unprep(q);
> +	if (needs_clk_disable(q))
> +		fsl_qspi_clk_disable_unprep(q);
>
>  	ret = clk_set_rate(q->clk, rate);
>  	if (ret)
>  		return;
>
> -	ret = fsl_qspi_clk_prep_enable(q);
> -	if (ret)
> -		return;
> +	if (needs_clk_disable(q)) {
> +		ret = fsl_qspi_clk_prep_enable(q);
> +		if (ret)
> +			return;
> +	}
>
>  	q->selected = spi_get_chipselect(spi, 0);
>
> --
> 2.48.1
>

