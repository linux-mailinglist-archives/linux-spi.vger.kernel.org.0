Return-Path: <linux-spi+bounces-8454-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FC3AD5962
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 16:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299E2189D542
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 14:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1130428A72F;
	Wed, 11 Jun 2025 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MzAL7GAa"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012066.outbound.protection.outlook.com [52.101.66.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C087F2857CF;
	Wed, 11 Jun 2025 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653803; cv=fail; b=bTruaOOqicvD0pig5BnKnAYNshDeHs3RxVKEHl000YKxN2mq+mYNdHQyG8Jan7WKpvXA+At/d++dw/LMQSUMOujttRV9wDUJg5Q8mL+gv3SauTcK4KZAjLFUV/hfdiWtGpqjCzWiTLBI9tdPeq5E9CS7o4QiNMSdoq3iWJNRYLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653803; c=relaxed/simple;
	bh=+3ypHjPY+vOTTaXYChN/vr50+sMTObDPnUPlwmDBqvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZZIWAzeFKpc2oglHAdSva8GKtrGycuaHZkkS9yQXfZjiZaf+LbNk8f7iXlyida3dgFKaWshbntjnSmLxtKrvPpGIFYbh57nLrVTlAfzdOhAsKCNVTPcbIDtGsY9yqhVIpKhHVHa/oDZZ9cGpYDO0ZCXNXyPDAn+FqBTTFwh2MEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MzAL7GAa; arc=fail smtp.client-ip=52.101.66.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDzE9aBcUxBf3T2nJ9nc81QKy2zWhMsir+2pk95kh+pjyH8gmLS267Fk8fqhT54zpWtgt2dkUPWWx6YxX6m97i26HlSctwtciFQtO0hJLuQMiqUcUzQn78pPetQ5572W8YXiTVnWej7Q49qeSpPmJteY8hJ9W7YYPvKbfm1wSw+0xc4ScR667SVO8pl74NOZfFlzTpSFQUt5A5/4TKRIpEVLL+KV83k6lpfqBU0APjAm+iDycYKjsGIWdZrQ1FVTZ5aoltyxIbxbEI5IAPT+ntIdtDmMuAB/MFFEsScjfY8Tirz0yrjt6SD3To1UPrOkjtNKWQJV/VLD7XHY68O5AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVfH19WmPFkXggYbuz79vx8HN7MFawxyadh6ZmmfNTM=;
 b=i0e8ZsQu2KWAvU/ts0t94ADnIEQF2bFueTateo/bvUeBxpSet725mnNmLY46Qx3E125aRm7qFdSeVJeUYXnTaP9sGKFiAuMGAEPVFpgHQQ3FQJeBLLwbEhD72AmuPPFUGVmIyQ/a0eXXTYf2Lyn9jzey9IgosO0dSk6YyRKSTB8V8BuuG0vY8nI1pmdtLLdwLKHITvL2upOp2Jyk3qFWprZY5n3zO1onOsMeJ3kgDTuBfmQzl9hMrKio1uc20TKTTox9wgXaXcX/Id5Z3dfm9p+A6h+MkcYGVgiGr7E/bN0vl9N+jy6MMxnh5C22JLzfYOlGBpY3XTssg5a/1H/juw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVfH19WmPFkXggYbuz79vx8HN7MFawxyadh6ZmmfNTM=;
 b=MzAL7GAaksgSAKNDRdaap/t+wQ0RZKuYAHwmRzP5cnUpMm1qH5J+99ygWvsDPQ3vwOrZDt49AQLD00uW4kHPQrRSzxYkrO0a3jfy7B5d6BMwfPOEVm1+1mHszHiQ2BRv61IRVHQQvtmNYgwV7swKxRktpaD3DJk/wvKJpECbzpYJhC3ca+cx9U+UWOcr4EMqubOiUtuUSFa5Wkn+I9gP8C0n7id6q87kh/Tmihi5TMisAHIlh7XSvwfVzUUPZftMA4RuDxeobzg+JZN/ToqizDKgMJvfHIgolg7rQ2kGfhKvbwHEAXshNV1fi56/B+3OVrUA7yJ82OGX1Ph5TXEN9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB11275.eurprd04.prod.outlook.com (2603:10a6:800:296::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 14:56:37 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 14:56:37 +0000
Date: Wed, 11 Jun 2025 17:56:34 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] spi: spi-fsl-dspi: Report FIFO overflows as errors
Message-ID: <20250611145634.ncbzl6wwwxlidjl7@skbuf>
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <20250609-james-nxp-spi-dma-v1-4-2b831e714be2@linaro.org>
 <20250610215233.35ikv4sslkyukgwr@skbuf>
 <d95fbd83-995e-48ca-bf23-147caa80b9e1@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d95fbd83-995e-48ca-bf23-147caa80b9e1@linaro.org>
X-ClientProxiedBy: BE1P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:66::20) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB11275:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a73b6fd-265b-4fca-c60c-08dda8f82a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FuUXr0bTH2xOc1auaAGhBdvUrIEwZhDTCKgSmAyZ59dR8RPA1J9wAPcXJ/2L?=
 =?us-ascii?Q?dvcNdYrFjoQT4wlq7RXL8WonPR+hTGEt5zLtGPArk5XfqFTkEv4kBb/Q493M?=
 =?us-ascii?Q?HaSpKpciRctGmwCDJYij80WRcIf6GGckqjfx8EyQd6FAYjJ9etI5jKj3p0bM?=
 =?us-ascii?Q?uks2nAW0pzTEK3Hl/PrFL+z1s6Q/duSx4g06oCKHAJpD3p/+pEoihVVheLKJ?=
 =?us-ascii?Q?YCk4Uj0v86fZt8bxzHYXHLss/0RjxaaLgm55IVmK1phxeFPAJb/HjDrrb+W8?=
 =?us-ascii?Q?bAtBRhoLD+PLw8LmtD0R885xs1jBWzBQj9xcNS8DGOGe7keSHW4OEFOBctX+?=
 =?us-ascii?Q?XqTuJGxzDqBOn5F9Q2bOuPI6teehXTSHjYilFshkwfkohwYmLSI3njvyknuq?=
 =?us-ascii?Q?I3/frYNLSkPIwNcSY4n3QiVMTgNvYOtSvN1YySwF+GFw/LducltOrGJ6RpkC?=
 =?us-ascii?Q?glyuV9upHHNvPEKTLIWjDtq4u2DdAZNpKc3i3fpGFG0laDloGalIH2Sq7+X5?=
 =?us-ascii?Q?grkZWaKrwC/cG4MsDEbp8TBqVGI58HrIziaeygqAqfeuNbMsZXS1Azl8Qveg?=
 =?us-ascii?Q?obOAzKdAexXFIvBaySayv38v13/Lb9CRqZx+wQyyPw/4VhXIugPOeo395vV3?=
 =?us-ascii?Q?SOXsrY5Is1J1BOY7pvytgkn48BBEv/UEuElFCbuYj2b+aabkCTTTeTVewNhw?=
 =?us-ascii?Q?/HCMlmtP0BR2HVfqcSCSs5ajzB5FC0aTU5PKX67FmDVPwKYJw7g5tlNDe6Mi?=
 =?us-ascii?Q?IXIoUEsFBHz2CUHGIwc4daMU2Eh8/22OgTYEQycRYWmvMczSZeXrYiYkjR4e?=
 =?us-ascii?Q?/5UpK1Mmyv5Mt4+nKOfNiwWQwB44QYKkIoSKvEjvApG/GvNQuEewNakGxUhB?=
 =?us-ascii?Q?+LStZYdYs1/hGsfO3Cy9MIVVr8Tg7p3j7/WLgbzSNWwA/NuHaeyvyiaMi3Nr?=
 =?us-ascii?Q?Ak1jX5bG9vzSKJar/jOkGz18uP9izEyTS3rKDX8pijQmK9sRFG4JrsNMx94Y?=
 =?us-ascii?Q?9JiKX8vqDbpHgd6zcdkaV1J8434czlk2C88mLte9EoQYxpfTNdniAwoGQoVd?=
 =?us-ascii?Q?LmGWlYLLgS24COcUbBz20oI9hy1nk9Svwv1bVS5OwtmdN9SEOTsWTiud4tBf?=
 =?us-ascii?Q?uRSSgpVC3mQ2HuKqpZ23fBaLzyVjaQO43x/Kl1L2TzdDIRi5v4neCDMrle+m?=
 =?us-ascii?Q?h9+f5zW99GTB3EW7OXMjXKKwgFI3VJi3vybLCPepGNYMmb8lhWeh2gcRF8sz?=
 =?us-ascii?Q?RM7BLH5Tl1RNXBwXWOCklAXYhEQ0zQmQ9crvlPmR+WEiENAGM4acezPm1VKS?=
 =?us-ascii?Q?7tyWkbDKtiRpxGJZk4A6TfEZ9ZxvBPWw5PGLqN6apCl6wx+bH7eoTmjrXkA4?=
 =?us-ascii?Q?5nGwstg+ALSCtgnXb4qFnqjytHkMuL+i8wbZbxjrFX0STeH/o5ZWIezPfZDw?=
 =?us-ascii?Q?f8BHGVSLJl4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jo5t6t+LkeStBKaK1C8gZF15mk6vDb5SNcHWqoODYV4V3ro7xbYqdVmFKhyi?=
 =?us-ascii?Q?bH4o9BYlDdraUTtNCdsX4j/8GP2lZQmwSog4cTZTXBhvtGm8cWbwLQT7j2c1?=
 =?us-ascii?Q?nNC4j2JC9FB5cID5JuWY7XjjC5xVMheGxQH3u7NDmBh3zPslhh+f656S0BfR?=
 =?us-ascii?Q?yclTnvqlML/xsGXbrpMMmr8WlSpFFeweVpDdmf9i82K0D54jMKBHXqOrJJ8z?=
 =?us-ascii?Q?1HC7iWDXHYnlEj7/R90R+1cNC3CYpBmZDnee0zoQsXw7FTHndKhzSs7bfCZh?=
 =?us-ascii?Q?M9JYVkVlKOh2YQsW5oaAOamaf9KJ8LyZRR7bEQiwTr6exxktlDVgs4cOoLCq?=
 =?us-ascii?Q?vs474COyTEdRUWNjG8VuNiY8+UcAmIok5dCrHT7lcRhJyPbdQzMFaNum6lFu?=
 =?us-ascii?Q?Mc6PCqLv8UWCuxOFKVa3anVCV33LA5RN7YXI42PthSMAuZMpVV8rTQ4mh7HX?=
 =?us-ascii?Q?csDsNxlg89v3qQ2N4dIKNrb/VfhWYqP/rjjPKSo3AMP0JlG+HNLVpiKd48QY?=
 =?us-ascii?Q?pbRgtZPmYDZzIGKoxBlC4FM/ENOQHOSvSpTUH1prN5c2owdGrcu6QGhhM3gh?=
 =?us-ascii?Q?Vk1NoRZ5WQ5VV1gbvv1QDTMyH1A99hM4rc3HBFFV9juqLoJpLWKWEXJeDV+T?=
 =?us-ascii?Q?udd3EnvMv28Abl7BP1GOHvj+/gDWKdfL3kd8tSf/Jpv0EWsofVB2y8PB2KuS?=
 =?us-ascii?Q?wo5rCSvZP65njNudi6IbrngoT5GLtOLh2fwVluyk5FxBLEQJa+dCMp767VnW?=
 =?us-ascii?Q?vgejeStoenUZxxHbZ0OuO1f6P9E/T1sR4YjEGcyP7cqUWA4JH/HFWlEdBkF+?=
 =?us-ascii?Q?5fFTVAF0RK10rcWhRgceK92WtpJ2y7EiIghper5cJCX6mHjG/ivr9jkRmMYe?=
 =?us-ascii?Q?oVPe4dBX5endqWtg/p98UwyxloLR6h1sttwy2y+Xw57Obt1W0iP4eWHKIhAu?=
 =?us-ascii?Q?SlD1016zo9bEQb1v8jZ84WfdDJ6QSDceIPO6vcF0A7k9ZHwtG6LrrmIVAR1U?=
 =?us-ascii?Q?jOSHhZ+qTTriOJbmpjYBZhPxR1KbCHJD+DC7bjX5YKt8+3CGBIi9gsaxnJ/I?=
 =?us-ascii?Q?Na4tGrz0VRvyyG8KVJiSldOzqObCwQxIMcLHENqmSudvoaYDBlfqxrwcTUCj?=
 =?us-ascii?Q?ONO+/N57XGtJ6hfZ2uw/L+j0Ck6b799sFV0FmtztfVXkozmpCeblXfVTPDcp?=
 =?us-ascii?Q?gHiC8nKROeH8Ktgqz39NwhHCmC5V2vqRUx1twcEnQYTFlYStejipLrJ6MGO1?=
 =?us-ascii?Q?o7zGph4OLwV7D+io7J4KNZUbphFJWLcoK97xwJm+kyCDRSD7joYURmmggLi9?=
 =?us-ascii?Q?GvytAsGzofzRLi51ww01824LcodXuBQhb6qVwKEvoLnyqy7EHwyeZzEkW+VX?=
 =?us-ascii?Q?oyI8zlQI1svBr2BFWPDnyj30CbdEul08HGwrE/CEEB7UbbmJt7G8qfPmu0BW?=
 =?us-ascii?Q?ftnhdfdD2rWt9syqhwMeID+Dg0XRUc6ClVIKCj808QBTPRGIR061+/6EoxFO?=
 =?us-ascii?Q?R6vvbexe5ZkL5BPrVSJgo8QpORQArqPtC8lYVZp+aoEpGLVS7qs6M87vEDhk?=
 =?us-ascii?Q?CVeEyySOWiGrQfBo2gYauz6j9Sg05O/pXM/JpUuVrCT4nEf3sGWzAcrGWZWt?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a73b6fd-265b-4fca-c60c-08dda8f82a52
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 14:56:37.3310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7g2ZT0EPyVG9ojiObZTKeK/28nWftSHEKVdZUKpshRAILYIKTAUARLkFcRRCuDOaV36wdXBpKBrz9N8RUXgYMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11275

On Wed, Jun 11, 2025 at 03:40:40PM +0100, James Clark wrote:
> > Also, could there be individual error messages for TFUF and for RFOF?
> > If you are concerned about the penalty for the error-free case, make the
> > check two-level. First for all errors, then for individual errors.
> > 
> 
> If I was going to split them I would probably let the compiler optimize it
> whichever way was best. The real reason for combining them is because
> usually you get them both together. As long as the message and fifos are
> configured correctly you'd always get TFUF and RFOF at the same time and I
> wanted to avoid printing twice for one event.

In that case, why not:
	if (spi_sr & (SPI_SR_TFUF | SPI_SR_RFOF)) {
		dev_err_ratelimited(dev, "FIFO errors:%s%s\n",
				    spi_sr & SPI_SR_TFUF ? " TX underflow," : "",
				    spi_sr & SPI_SR_RFOF ? " RX overflow," : "");
		}
	}

