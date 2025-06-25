Return-Path: <linux-spi+bounces-8771-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5F5AE8761
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 17:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959F2176132
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 15:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5527262FF1;
	Wed, 25 Jun 2025 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tpc2th86"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011042.outbound.protection.outlook.com [52.101.65.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED80263C8E;
	Wed, 25 Jun 2025 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750863890; cv=fail; b=plqnbitCp4TyGfcluseVbc1pdA50jeRs6y9JgFQk6ehvYQuUp7KxrXvKrfKN2dHuu511iTzue9F+JyAeX/T0N3aDOSIrqN/0cl4rqfZjfcDtsxMvoueq6QvVa9nB5DPdKMOPq359yO4jcf4uCxCpwXgWo1zqsaGkQueCyFZa36E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750863890; c=relaxed/simple;
	bh=kR2X437G5LvRdPZiKcaTcUNLedzFSxdwJB2Z7owHNXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HsJlvkO7rJaWl9N9uR65fqBx8l/Knwf8xdJpsFqJGiAC9JUmCIItc3aWSQAvfJBAbQu2M0BcZZcDm5VvlRUMN5G3baSzsC7jDz4VHPv95hBGetHuoHRDvVN9fyg2+Klj8p7zW2e0El7VYsj4B+JdZrl3/IiARSPfcj8BaUe9olA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tpc2th86; arc=fail smtp.client-ip=52.101.65.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgdzytVwgh1CHhV6YGsdpehPEDM0tlsj5JpXinOrI3ClI8Uu5K6C9ywgOSbtLFEqT9g8qfESHfdiqDYslF71Df1x/7wS+vf+RQ3pA7OitJgOQmNiMhB4jxWjgTDQiuRnbXmqqkrVQ1Zmg0/2MgRkFeSERIUEayMrPS3BXIOcDp/ar/lkG/UQj66UknZTbNnjAGJqPI4b58hBLor0eeIGvchaCpx1eBYW38585L+4y1T0OapBFVAVdY0pmUlp9J148w9vw/4/Re90RIZ6Q+yGTU3KwZCylHh5nUK9Rs6kzvH/5iIC0j/LcflPzbNOF7/8clRUlTzhOsuT9SpkqitHLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kR2X437G5LvRdPZiKcaTcUNLedzFSxdwJB2Z7owHNXI=;
 b=aBAgA3O5p4+yJGFOvqEI9i4DBojaHvmEBkc/qDN18b/scuDZ0x25uJiU4TEh1jK84Trhfa6wGDtraSS/jakBjaaQeX++aq9Euahs5BjkkZ4pC1aVo1JW3benO5XpEdiDvyBwpd7MrS12tuZ2ceuoRjLmOsxYk6cGSbZRZyJSYY0UT1CMnH8N4D368zkvzmR23CVvdq1PlxlEAozTtdw02rDTzEULH4gHjIJLFC1N2on1AKWZlA25q+8z9L1ILg9CoiUP2S70UqOY0eFOxsD/7omfyF8REio5G3fzDwmWt9Ty2Ukklpx3hYsoSH6t6est1OmRSCJSOKLy+/eFrDe+Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kR2X437G5LvRdPZiKcaTcUNLedzFSxdwJB2Z7owHNXI=;
 b=Tpc2th86p5ikM++wnIUwFGUQu52Mx6K2HDqJKJMqx+86pm1gPNW5kJWjYYldpoqkWz3k+UfIPdSm7vx6qmH+MT3lnxeDN7Bc/wSwKRH92sb1cOW1iwLbd+IISKncElw89vQb+c05mrJB8B90enkkRH8OSjpCwkLVOIDjey5nttnXwaDB2uAWM7IbwSm51wfzgf+yjfJzKhfruxt/VlV7PKjlwi5OqypxV5UaxbKk4+XgFNEUHJbOR+S03Bx3VM6gH3jfljNhrDypFA3ITX5oXTmSIHuZx9Sg+bTTsEAvWNMEfFJa838vlHIkevDrCr/Xysy4q8VxVCk+UqqJ1KPa8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9557.eurprd04.prod.outlook.com (2603:10a6:20b:481::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Wed, 25 Jun
 2025 15:04:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 15:04:45 +0000
Date: Wed, 25 Jun 2025 11:04:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Christoph Hellwig <hch@lst.de>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] spi: spi-fsl-dspi: Use non-coherent memory for DMA
Message-ID: <aFwQCL0tQh9peb7x@lizhi-Precision-Tower-5810>
References: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
 <20250624-james-nxp-spi-dma-v3-4-e7d574f5f62c@linaro.org>
 <aFrUqW0ijRt7CJzw@lizhi-Precision-Tower-5810>
 <228fc6f7-52c2-48a8-af7e-6f2cfa7b9168@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <228fc6f7-52c2-48a8-af7e-6f2cfa7b9168@linaro.org>
X-ClientProxiedBy: AM0PR05CA0084.eurprd05.prod.outlook.com
 (2603:10a6:208:136::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9557:EE_
X-MS-Office365-Filtering-Correlation-Id: aa5d92c4-3a04-415d-331d-08ddb3f99ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jRv+bcJwe+vzIgSZ1wNese+r/B8SCvq4U79jUNtOjVgQCXre/QZS5QAjgTbb?=
 =?us-ascii?Q?pOexzz0epvBFT6dxRNdXKx8mjO4I8q/CpZ2brnYuQaeHuMldV8s9GHTymx/f?=
 =?us-ascii?Q?ZmHSsmtGuq2lzT3jZZdDEoRFX3AZhQP1b2TRH+kt8IZI2eCOc0t81WLiYd6a?=
 =?us-ascii?Q?/vWwoA2HVPKT7yHI3ZX1GPRrqnX/vyOhJPQ7962AQK50aP49/DLTCmLvKMzY?=
 =?us-ascii?Q?PaEhnIinutU4lAlyA8MnFrQFhovyAgxIA51iSGTDHl/Vmz29l9xHODVDu2UP?=
 =?us-ascii?Q?9BNOmqfX5uM4YYKSiBCPdALvmetpWzhp/bgDwkjWgjT4SVRH31r6njD1WwOf?=
 =?us-ascii?Q?loKXEGkgsMkTfvmAbs1hACeWc3qk6ug3xXi/rMq/rnDcz3RxWhNs5YQ4fOO9?=
 =?us-ascii?Q?UidhvPcGpUD5MPTxgAMwE2FYQY6jvszGmvwzJpyyrI6jFGy7539RgCl4/oxP?=
 =?us-ascii?Q?bLZIppCMRJ1a9FwwXebq5Kw78bHsEClLwdVnMRM5h1OqF8FUuGMqwqeeGi8W?=
 =?us-ascii?Q?hjvG2Rd1zKPzyyqkSd6UBfdAdSH9CjO7CVO4bmHMKwi4QtvMaoSBa3qF4jV1?=
 =?us-ascii?Q?VHP1f87XoDYJfqb69GxHwtaAHm4T2ST7bPIMFgcyK/7rMI5B7gbpFB7O7gT4?=
 =?us-ascii?Q?9BO2hlBjBEM1pdez/39sc2uUpL2eZonoC0ix6yFzReU/kSJ6hHlWQ8QbUjaT?=
 =?us-ascii?Q?tE3Vz5MH99ynqxI64wfCZ0d0tvYOZDzR2Ds+TCWb0D5QMdhyrWmSDRE9XbRw?=
 =?us-ascii?Q?WrIBpKo3oonvgtf+TY4lcSLFT6LfzhkyWtEmhvyynZi5zGSueUxIMS8YVtb7?=
 =?us-ascii?Q?+emxUxGj9hu2XDG94BPUfoM1rfO7pq4XB4YFU6ZnpkzATZ5c/ReAnx8E3s3P?=
 =?us-ascii?Q?pDuuM59WGZCTY7w/4c2oGSiaEjdXDK0yxXgefDBjG8O8YmYocLk35RcGomra?=
 =?us-ascii?Q?7d+1mSYlYhgUmknxuuqUrl0tOxC7LqMwYgbkDgMIkst2vH83IRah7i9yffw/?=
 =?us-ascii?Q?eVOETDqd8+2ggAng0CRvv9JseAs8+yu43UDj8PROOxkkHT/fy53It+0GJ6Aw?=
 =?us-ascii?Q?X2DYSIP2ki405Z9tb5ro2YZ2z8ERSHFSZO9wua+7+xN14yawzu1MPie0HY/T?=
 =?us-ascii?Q?twBgzwUdhTds3eDJ2mSrulrt2reusYGKFOCD7/+aiMOUGdW1CtADzW8iA2di?=
 =?us-ascii?Q?Diz+SX9jWEhQ0LqAwnq0ajEjQrRpytIY/EInPygk4n5oY+1CUVvnXBImflH6?=
 =?us-ascii?Q?u7/Vcvbs4hEalNfM0565ZwsRmZFQJu0hWDtl3rEdWtDBLQO4RG6wxmOgmRST?=
 =?us-ascii?Q?SS9uuaUX5/nzYxmvONMcD3kZB8nEGTa4b1i0prwn92eTDTEVzxhkT8VzuL+j?=
 =?us-ascii?Q?9pf/dxFnQaiQwb+vXJUZ0rd/DEEXjs6Qk3Z79YHVxdp9Kdr+jzVJ4/OYGn7k?=
 =?us-ascii?Q?kfYfbknEIBxGP/+ByovWxX7xLF1qj0eDNc9ZStyfRGARQFnB60xUEeVSAyKe?=
 =?us-ascii?Q?vO1LpqGrym8BV4s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZDbTopmReszvYqZZb8dpocFm0rzlth+0swD7RTqxJronWvc0LBu77uAwq0Bx?=
 =?us-ascii?Q?9oxcP4bPL3VeOnFor2Cdz6j2L1cDY1VJheDGw/XcmR1EFU5rqAtAGWndNATD?=
 =?us-ascii?Q?EG5S4DyWyA2ZI/SLnAjmYZ3ZSusDAQiAHEV/r5GnXfthRU3K6gmEED1u7kqj?=
 =?us-ascii?Q?i/MNY7jDOb38UbOCJeWjIaoRARZ5jHMrKYlOrp/PW5/wxIHQWF8u4etNjdUZ?=
 =?us-ascii?Q?jzZ4Q0VwGkjJy8YmHlDJkZ/J2QlqEOmhfV69REcALPavHkDuI61636FejbP1?=
 =?us-ascii?Q?KP6KAYfYH3IRE6rNPfFwptiY4iekPTfsHsBSOgzrLt03RpSrSiRhOCGvoPhY?=
 =?us-ascii?Q?05xTgXDxaeW7Qp2Bw5+PtIL4iaI7vOZnl+E4Z6HsoxIkIqPWF4I+UqHBeays?=
 =?us-ascii?Q?ncYu+4vj+Y2gccJdtf6uDFC+hus2yEfNLz86R5tDECWcK0kreC25i73D6me8?=
 =?us-ascii?Q?xj63N8v6UckIQQG5fut9IWRxphymsCvR9YoQ87g9p6K/TZ2BLqWgiiDeMc1E?=
 =?us-ascii?Q?zsREo88ELJrFiEXS0SUAfuN0VRmMGrOpW/cxNOIt01hVZy7A/5j7v3wbgOQN?=
 =?us-ascii?Q?SSwlzDYQ2kbEaWqP3NhcSzoim5Eg5lhu2zZZwXn6KXyEZBdPsIIkKGC0urCb?=
 =?us-ascii?Q?7rv8I5OUwVyOK0Hw0Z2Q7CGtjN0RLQ8M9ZEQhyqjZAQ7ZYpaBaGEGkY+MPW+?=
 =?us-ascii?Q?LNdz6T79HjZKZSOAUZX9LYo93wtY0E3Nc89cMPz0oQdVCV4qVV4Gw2b8/BE1?=
 =?us-ascii?Q?41ea+HJ4KUNElD0mrniizgM96cNQJQPO04xEtQZRU2RuMmFgsDufdPY/M0TZ?=
 =?us-ascii?Q?OdLQJYOQyxQKFThTh32VNwGu+U6m6YNMrYkDSeul2DGxty4jq9awCzyxZxfW?=
 =?us-ascii?Q?Y0RPgoJYLcKh/nUJ/whUM12WQuBLeZw0V79aOYD5dgNr5RbIqAqw7evEB+hL?=
 =?us-ascii?Q?vDHW6TteyKGpA/OLFB2cnsfNhijvsGQz2I95v3uABXaMK5bADLhVykDBZZxr?=
 =?us-ascii?Q?Eg9n6V0X2JwIkx3BHII+9HT9flgywU2nUESTSGfE6CWq6mvsPJQoghxBALM+?=
 =?us-ascii?Q?A1AylpLZBbvoFO4jGLDEilXsbcdQ7/+dgHHChkT236A71nIm6Y82KYv1jfd0?=
 =?us-ascii?Q?vrqKf8ojv/f6RAKqPKUWybTVSSVk2XGEw4M4uu6Q7MTJPxaoK/IrBdcHgvZF?=
 =?us-ascii?Q?2KoOILANy4zfN+f/7hX4DWi076KF9npBNbYr+yJIJqPfq4rDNaZVFeS4bERl?=
 =?us-ascii?Q?r+3AFibCFEb8BZoR6k7IF2BhsY5z1EmQJIOS3cDKEpLWpiKz4pBVUrtMFGhs?=
 =?us-ascii?Q?jSw6Yr7bT3gYFt1R2gtEV3bUjLD7NE0arfGQ0ITFZEotIuoyRZnU9xtCknuE?=
 =?us-ascii?Q?E30RrDu9JzH1B/k78j9yiApljF2+CBrjKmGLMpmB7C2J8g/ZWeLhAbdstzrt?=
 =?us-ascii?Q?GSotWgJNe51mhZJ9swPmEDY2i+m3X1TbHeRa/bWUQdF6eTg6QrrJlclQUg6D?=
 =?us-ascii?Q?Bon5S69bHbZ8UKZf8s7pMt6bV//hgatRXpCOmsFd8Ktyll5CfcVXZmuy50qp?=
 =?us-ascii?Q?iFbYvdmiYV+9pNCFtHHe9C56ccdtUWKIREv1kJkB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5d92c4-3a04-415d-331d-08ddb3f99ed9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 15:04:45.2594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6K9strQ7fjwNJg3D4EyD9npX7uH0VzBhM6UJ92qMcUNiVVCOEN56Yem0wZ1gbYILpsHA1b5IiCxYayowzXCj1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9557

On Wed, Jun 25, 2025 at 10:00:41AM +0100, James Clark wrote:
>
>
> On 24/06/2025 5:39 pm, Frank Li wrote:
> > On Tue, Jun 24, 2025 at 11:35:34AM +0100, James Clark wrote:
> > > Using coherent memory here isn't functionally necessary. Because the
> > > change to use non-coherent memory isn't overly complex and only a few
> > > synchronization points are required, we might as well do it while fixing
> > > up some other DMA issues.
> > >
> > > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: James Clark <james.clark@linaro.org>
> >
> > In https://lore.kernel.org/imx/c65c752a-5b60-4f30-8d51-9a903ddd55a6@linaro.org/
> >
> > look like less performance, why need this patch.
> >
> > In https://lore.kernel.org/imx/ad7e9aa7-74a3-449d-8ed9-cb270fd5c718@linaro.org/
> > look like better.
> >
> > Any conclusion?
> >
> > Need performance gain here if it is better.
> >
> > Frank
> >
>
> Hi Frank,
>
> The performance figures for this set are in the cover letter. It's either
> the same or faster, there is no evidence of worse performance. The one you
> linked was a bad result from not testing it in DMA mode, but it's corrected
> later in that thread.

Okay! you need mention why need this change, why non-coherent better than
coherent at your case.

You descript what you already done, but not descript why need it.

for example:

"fixing up some other DMA issues", what issues exactly?

some benefit, like memcpy from/to non-coherent is faster then from/to
coherenct memory ...

of put test data here will be appreciated.

The cover letter will be lost after patch merge. When someone run git log
after some year later, they need know why need this change , what purpose ...

Frank


>
> The reason the figures aren't in this commit is because it requires this
> change and the one to increase the size of the buffer.


>
> Thanks
> James
>

