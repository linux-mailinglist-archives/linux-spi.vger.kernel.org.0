Return-Path: <linux-spi+bounces-11517-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13099C85CFA
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 16:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C7183432A0
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 15:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DEF328251;
	Tue, 25 Nov 2025 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JPPkLjvj"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011001.outbound.protection.outlook.com [52.101.70.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E3C32548C;
	Tue, 25 Nov 2025 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764085285; cv=fail; b=qn958XhgZEOL9OjSGURyjsvWoJ0cnvuMCtq+mPvOb62IDnvCVh/cNwBx0XcM/V2/tM7W46AV92dZG4WSDGcFGYojwUVChBTafAH1JJUrcEpMuu6Ur3j9mrZe3L/ipTElowLF9GFnIJdMOR98Y7fxr4kmRZPQFxuvwBQQqsJKtcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764085285; c=relaxed/simple;
	bh=NuSGhgMOkUOccwu1VFhcWjCR3vU9vXDFT+OHgEKTjdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qhrrDdGaU3aVMVkZ1D3AVnUJS0KTnPNNpJcUvqm1JYKTA7VanrbUWfKJxBewvoy7qpkzLOgBSpivUXUYDqfj6BB/vhB2JwpTQEwe8zYiF7VdBQskNjlm47WdCW4c+z3Tu5bbdBp/RZ1CZeHdkyggMOOIEQvSO0bYSkLo8YGJpEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JPPkLjvj; arc=fail smtp.client-ip=52.101.70.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvQO8WBb9VSASgeuhu6IeiRIsw235lIsyMYttatUHz7VV+FdDnrZqHVdqh7W3xRX6mR2ksgZeKyxWW6CmN/+DCtvV4ou6ifPQ/nSiczqRbp8JJnvH2sQV4yNqVe5DHRkC3zlFFcMtPTnIi2alkwxbpzOELB+0XLK7uY4ADPWKMSpOM7JJNtKHJGV3lg+3v/9/tGQYNoRnr3wOMHfUYNlDElL1dad8BPFKpGPumT7g9r3+nAYLpR8LQjs8ul1MmgeC7pgqPGwIZj/9i4g4uhzlNYBIjYC4G3RaLQLiJB/jxkdqpYO0dk2qeYICXbS6cB2jvvMuvRczH64Cp52f7oqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0o30hqzQ5TwqE9eu1bC2BAtoVvzJ1Zugc4XKJGq2iw8=;
 b=cCBR7DrJvQw8Is4rhzDm6qFWIiCGoweGn822WS1Z7cde6R2XtsRjQh5WvCmfBZLY7C04hcX3hOGyhC4f9xD+sBaHELn2TAwhy4S5oxdPIYwCzEtIu4FrsIDvAk6uiyvWTPwd5/VW4SOUFiFIRUmvKcS56vs50JQ8+xweXnXMGrQynw3VSp9tCsl3b1A4kpVky4qulDqm5Z6Mc0g0lLygfnY3ZpI0kGbfJSjFOyTZ3/3Kh1/TyX3/D22KWLGnxpJufOkkvj618cGxvJK92958bgnIU87H1kqn6bdU3yQlO+YM++I3Q9AJo8EdtFsog7MBisvTd7Z4bhvAcW2TUA9UFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0o30hqzQ5TwqE9eu1bC2BAtoVvzJ1Zugc4XKJGq2iw8=;
 b=JPPkLjvj4dGK5QaNPGnec4BB73kVJv55MvrjmRdzZ/EjCDpnH0RVMFEXs8mcMGpGU4/pxfL69IZSOMJ14lQz009VWX2T649Bies6R+j9cY/iR/n5QnLREsH0bcwxJcAkolBMpCdQe4357EDLlNSnSMlR0lOlPhNzrE6lxW93LDhDTV0S30CpbIEF6jqXX554CtX8+UjSBajIfKDSFPu77ROH5pV76KZEyuudy24E7O2PnzwnWahyKd0T7KnJlf2Qns3heEY/Ae+Wlsk5jeYt+0vVWpYP4531nxSO0idJy3eSXYpVnxLHEivF+Ft+JQ9xIfnzDSTWQJzZ9HC5GbyRDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by AM9PR04MB8586.eurprd04.prod.outlook.com (2603:10a6:20b:439::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 15:41:19 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 15:41:19 +0000
Date: Tue, 25 Nov 2025 10:41:12 -0500
From: Frank Li <Frank.li@nxp.com>
To: Carlos Song <carlos.song@nxp.com>
Cc: broonie@kernel.org, hawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] spi: imx: introduce helper to clear DMA mode logic
Message-ID: <aSXOGLSN0bXw1nSw@lizhi-Precision-Tower-5810>
References: <20251125100618.2159770-1-carlos.song@nxp.com>
 <20251125100618.2159770-3-carlos.song@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125100618.2159770-3-carlos.song@nxp.com>
X-ClientProxiedBy: PH7PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:510:33d::13) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|AM9PR04MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: 2153a5ca-b1c9-47c0-eb51-08de2c3913a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S48Wf3PSp6w6XlDC3xuIJEQFZDdKhkl9odj0TPoaY0eMVR6nE3pNxpiYopzp?=
 =?us-ascii?Q?dDSkSicxFSPnC0IOfCgH0Akj+ThdlzLV+Nh39U1N3g1G7EFkBsxT3ygojDFF?=
 =?us-ascii?Q?EB/yGb96bcfKsbm3+sB/aqVrOEcdiZVsFUEABCLRQxGDigRmAMumy6nOYHle?=
 =?us-ascii?Q?QvVt0T1zef66e1UeVEM1SBrfFZ43NdW07SrRwkaRgYb1DZtsRvsLgp4ocCvq?=
 =?us-ascii?Q?UCWCUX3LIRqDsc6PHkAicJCJOLjywp5jCy/McCxD8TMf6RCemwRcKvOA9KmU?=
 =?us-ascii?Q?VDR5aweHj+0M6YqYgIJpCn2Xwt5a8zTCKo0D4ZIAkp880UdiykbIqrTKIF8m?=
 =?us-ascii?Q?1UptgERNcvqe08E42IhaCuKtoCQBLc3qkFstaHtqbhlCsolg1edKL3bSuA5/?=
 =?us-ascii?Q?7zxliAwPHGK3IoMIdhoDINAGLZQg2Yhl6He8TBZdgIwsZID/Dhjovz8q3XIW?=
 =?us-ascii?Q?Q/IAnaKFUB4iKfVntEo5Jp3lXh1T9ABfhxm+gxzryZvFlogX0yrdzqTSm90y?=
 =?us-ascii?Q?TTHM71klaVAjLlsrfOa0AKXZ+v+Q1jpwYH+qL+rfXJAwjl3T+ScZnsqjNa+N?=
 =?us-ascii?Q?FsD0I7B/6n5Uw+UMfWhsyYQ8jqy9Kf3ApC5ywDa48PpA1fDQ1i9DrNkcKxYc?=
 =?us-ascii?Q?p8u0NmdOz/d9SCmADZZdwd4RBrsN/mwjLXsz129LoGDhfACREVrrw7gbAqwe?=
 =?us-ascii?Q?tKI0Ee7ck8ErzSwrtsPiFOTs1OLgiD4iziYdE9CegxfB48JUsSmCb4PxErd0?=
 =?us-ascii?Q?NhBTHX+syAMWKkuPgjrYY8dYEIqGM3HDQ5DvPR+dxuVIewGLU1SybhrNeGTR?=
 =?us-ascii?Q?G2M9FglWd9pszJnVLYuD79c3tNEcJAC6OksyICn31FbiBf4j0e4s1eWXZtam?=
 =?us-ascii?Q?mKCU1jmfDRBWRNEmDdTvo/mnzBsI/4GrnFn9KXg086wdf+xs5pqIwfb6kIhy?=
 =?us-ascii?Q?nMjzcrpnxyl0ds6ABr9u+rjhFKfAfGPYZpxXpvXcUoiRQgutb9vU+kEXAzVQ?=
 =?us-ascii?Q?yDIkJPTuHDIyIsWOo1Nolo5jwoNMORRADHkuDYnptAH/Czwd2reJjUUB9TgR?=
 =?us-ascii?Q?V6gzT+XiJpJiOOiHOormNbJLiQ83SbsUIqiDyRKQoxTpsgT89D/AlDbq4TRJ?=
 =?us-ascii?Q?5/19Xtd2N/q7pXDSq4l5+BQ9zgXbe55QSxhW/uRmrO0bF3mez1+lejPgTkNQ?=
 =?us-ascii?Q?Szu2zV0tmHcpO/7nY45J/lIPe8ljHlW3dXMG08/a/orGEfSI5sPo9TK7rfWd?=
 =?us-ascii?Q?pxvmo56OIPwweOvcZSNAMZaQP+ZejgO65zV08SMq3neoMa9y1sR0mqUAmK2i?=
 =?us-ascii?Q?1NE4OnBH629cZdc/pDfYsR5mBVI/3hBrGGJ/KJ1j9tzC/pnbi7VDXzGKWb12?=
 =?us-ascii?Q?NYbnhzajDiT1H+cZpm+MVry3W0kYscVs9oFVgGIpnt8nQhTH2NDqS4U0rujI?=
 =?us-ascii?Q?IRSHJlMhwBUZkwvS28cr3JMUQpiwi07Rrr41OIW8p63SVW8ozgNHtzWrQZcV?=
 =?us-ascii?Q?auR44gjb+L5Q3QlhLw11riJ+wp2XmPRahKT2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?11pexv9QXRq+TKbhxmo0hrY23WCa9IaysJkEl/owY3xlFMaHV8Bht4bC23Sd?=
 =?us-ascii?Q?iwKNlruKVdIFq9cyx8RYs2EYy3ET8fos7CSoFZziCF34VL4veLQbIqumfgER?=
 =?us-ascii?Q?4wWpsVfLHvrKa/5l54Ba3XYIxEG5JWCe5qOUaPb1d5kFc5UswtUAjRLOwMea?=
 =?us-ascii?Q?D10lSjtBLrVTn194o3VhiATRM6BuQMVVTvDlJkVQ8q1hTvQ5tvZka6DtLa4m?=
 =?us-ascii?Q?PdStzQ1lkjvRdKX6l79eN58I9qtSoG7J6IVB1HL8Fz6Odr/jrCNr0YJDw/iO?=
 =?us-ascii?Q?Jt3//EPp9CJtFl/Kv8XwBARTlshvL6G17IgGV+jhwl0z05abyh926PqtAh38?=
 =?us-ascii?Q?c8iimQj/fD/RHITfJRjm4y8zm8lLysaJsT0isGjz4lohzKF0oeHhEoXdPXW8?=
 =?us-ascii?Q?Lwx0yT02HyRIpdJKbJQoRrMXfmdhSJmYCOEKYmo1t52fLZiQ/oAcioPuQxB0?=
 =?us-ascii?Q?vUZM/E6rpUVmJEAyXAMMPpFQ1Q/HRnvm10rlhlz9TW7yzxaGresvLfvGPB0y?=
 =?us-ascii?Q?wMshT8d9G4XGWvGdJ0uuSRD8kLKSyUZf4O5LjfO7aBmSq8D7dnBdrhCYjXT4?=
 =?us-ascii?Q?r/WnHgpYBttzO/onpijRmIdv/tgMIWgDlUgyxYTPwyqjQyHArpiYPpBsA7bX?=
 =?us-ascii?Q?sQ8/dQhbVRo466iDAYOdx+LI6kgSdtuBIOwKqw9rT6yXhIXdHVziavQP9T06?=
 =?us-ascii?Q?6V933h+7d9oVWNP/U9AvY+LHwTB3GD0sDEoXM09G0nLDm9ylzwiFqmF/wwl+?=
 =?us-ascii?Q?CbgtcnKP9oVQXGZPPm4/CJF7YPHlaG6WBBlt+o0VqBLegDRhQ/7LiXih3Fvf?=
 =?us-ascii?Q?g4z6y1xv4eg+xdOl7qRo4twlrMzMDgbqD9I2zJgrgUTcOnJP6e0cgbWvJnjf?=
 =?us-ascii?Q?gGsFFf5wxIUnG5YzOb7djFtN8419id9M0uw5Wt7BcsypE349zzp193DshF3Y?=
 =?us-ascii?Q?4/8PByVStuT7eksip6m8tT2Zagb/GdM8lXqB5h1scz9q8S+thglDMOduRsU+?=
 =?us-ascii?Q?Cx1sEhrifpNDG5cmVu+SHrXNkPthC+rW95toL9DTNxzcLr2sPIJKcV1SbLtd?=
 =?us-ascii?Q?6PtJMb2y0lRR/do1FWCyYmk+ouOgmUYFgKTmNsVktaurXVa7ymHFUs83rc+0?=
 =?us-ascii?Q?uBFuT68jOaC/Bq8HAuZKdlhe6eNNgthVfWGu1ijFN15I0nAL/g+WyMYu1voZ?=
 =?us-ascii?Q?Ry0rvLAlpAMpcEt5y7iJ7YnwDRSyhjLHEgzkZpQMcvdy00b3a33hOnaSdWlK?=
 =?us-ascii?Q?gDHbJSXnvdSlwzOw29UuGHK/WWqW9+MBObnwdW8vt0ZGcNj1UMSsu5zHuUdl?=
 =?us-ascii?Q?JqIc2uXj6IC1xNhQDIgpM7SgEbtGx9FXZ+bKlS2JfQrTszxO+ALnBUsHmcvW?=
 =?us-ascii?Q?AFDOfYGzkySgFH22/HM6qpAF3Nlzoh/99veUyhGOY5Vd0nAwb+R4s6OGXR/R?=
 =?us-ascii?Q?0BzRJ6ftxp6DitHH19ySBzvy9P3kieJKZvtJKSJDFx1KIDABj44KC9hksifz?=
 =?us-ascii?Q?rzQCO109OQQ2zY5crQ/I2PhobBECSycm8KVIlnKXGmDfZ0zVE+rkxtXKi1l5?=
 =?us-ascii?Q?JvYcQaMqnZCjMQ42tc/NF3bkR5DHdEKt424oGJy6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2153a5ca-b1c9-47c0-eb51-08de2c3913a6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 15:41:18.9159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cWzqI1fJ2TkzbfJKqrCjVEtddlkPGEfhf8be7ugOOYs8k1zFrp3SVw2/S0A+Ar1sXWU2ECKzBwXTP+TRkNZUTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8586

On Tue, Nov 25, 2025 at 06:06:14PM +0800, Carlos Song wrote:
> Add a helper function to handle clearing DMA mode, including getting the
> maximum watermark length and submitting the DMA request. This refactoring
> makes the code more concise and improves readability.
> No functional changes.

spi: imx: introduce helper functions to improve readability

Add helper functions spi_imx_dma_submit() and spi_imx_dma_max_wml_find() to
improve readability and prepare to add more complex logic for dynamic burst
length calculation.

No functional changes.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---
>  drivers/spi/spi-imx.c | 164 +++++++++++++++++++++++-------------------
>  1 file changed, 92 insertions(+), 72 deletions(-)
>
...
>
>  	return 0;
>  /* fallback to pio */
> --
> 2.34.1
>

