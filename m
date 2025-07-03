Return-Path: <linux-spi+bounces-9028-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E00AF7581
	for <lists+linux-spi@lfdr.de>; Thu,  3 Jul 2025 15:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788EE188E77A
	for <lists+linux-spi@lfdr.de>; Thu,  3 Jul 2025 13:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8D9C148;
	Thu,  3 Jul 2025 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Bjepviyt"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011039.outbound.protection.outlook.com [52.103.43.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B349581E;
	Thu,  3 Jul 2025 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751549162; cv=fail; b=RJ2fHsSSowLJpAGiqWOBROuFZTCAn8bsHetw7Ukfwm+NnwLjRo6Le7DZxAZbXHRwjGraOZ4q3NeS8U7iGicZbmZOBjlF/+rW3JFJDM3l92DApXLZzZLO9u1mYBpRsM9NKIN5L2JPuE4TXAj72aJX7sSw/8ihWNFHqkPBWyZ4Bw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751549162; c=relaxed/simple;
	bh=ByTEP0ZdfEbLkmBYy4wyWozdwNuGWF0Z2bIRv64h1Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eH58SHsqzOg1G113eUQXIbtrpkJW0OEbCEG4ORiSv4TJ9AQFoVEuO7QyuABsPBIVELXPqA/ZpX7eka31DIHnk1nlcvfuxFRLf3t0KLQRbsq2VP6sGERG6VEkBsnnJOl9cUkS2uXyVlI4k1f93FyYIYMvhJftr3gGZZIzpBrBZaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Bjepviyt; arc=fail smtp.client-ip=52.103.43.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EX9pQSxSmL8mP69++z62ECNIINIdpR2gDErSYC0WfKS/K7aC+IxhQfnOW8B5B4w5nNha5ty0bX/+IO5HPUQst7a2Pb1oAokjFqZU9K0tqU0nNJOwVjQ0EBfS/o9b8NFHYzlFyDsotTAqH73EjdcGavDW++d68uzFQknP9aYcR2gJhEV/L9BafSpQe4rfVVrIt9GreJxiaPeOwAaX1BuyD5IUsZTNq7JlEdm1KfxkrigF2Ej1yoUPC7XYEFcFmZ3DII5b+7McLIxS2qZwHjlVHAvEdLyvBxhxn67FpNELQHNbi0aVpciCWM+xIIb+CrGxSOHFfJObgQVkHiS0Yt5gTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BD7Nm75kKrPf8c/+aJ6twJJ1btMm84OvnozDCtajpak=;
 b=JDwzSJXmdWVpEPybf6yXcV4egznwNf/dHn+3p78nqb67HKBPEoDfvlqMVqaG0PnD2LNykazhCTpeWyo6VvAHUBTCZUPpsQeb1MarfcWwhUvlKzNpXPIOn+M0wIULfYkgGhAdqzWvshE9iP4EFeh+5CbmXMe2PmKoRxYiPxbZPW1b92M6CExvKxH9m3WnPPzkhk/YHrXO3he4sW58CHHYf+ll0QMxNhRUuGlg3lisDGUtmhRdmwwFozdtMJ9UQdoa6cL4AqgB97OYSP9RAgw7XrYB68MmecTrEBiAdFpV1YoAgsdTTbxCb7Vglj/naZgwxWczu/qBgidSCVXxLsUcTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BD7Nm75kKrPf8c/+aJ6twJJ1btMm84OvnozDCtajpak=;
 b=BjepviytJiQ0dtghvjyMq4UZ/bz/jXeD29NuVcISvDEDnwVW6zVC/Cx97nZ7tirBkhR4wUo9URxh5oknnqy790G+W5Syx8f7E+SXhbNra6nRdEm2gPx3DbUsTFovWyNNcRODoWOb2O53MZJbdVxGI04inf4m34EfWu/U0XCZ0rUsC0Ik7r/7fKggM1Jq4CXneY+fIpmcHPwkVMvDJmA+LXa2EqRwJIw/cKe7l9TVidWGDSGJQf9jkK0rqJZs+fnYBNatET6Wwf2iqTSz9y7m3FCbJ8Tldtg8yjv5xlVSFeuh8snrGdOzwrSUMdrgLgn8ajBgypGZ0aKYRTBygPquxg==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by OSCPR01MB13596.jpnprd01.prod.outlook.com (2603:1096:604:37f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Thu, 3 Jul
 2025 13:25:56 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8880.029; Thu, 3 Jul 2025
 13:25:56 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: tsbogend@alpha.franken.de
Cc: broonie@kernel.org,
	john@phrozen.org,
	linus.walleij@linaro.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Shiji Yang <yangshiji66@outlook.com>
Subject: Re: [PATCH 12/16] MIPS: vpe-mt: mark vpe_free() and vpe_stop() as static
Date: Thu,  3 Jul 2025 21:25:24 +0800
Message-ID:
 <OSBPR01MB1670E0E820F98E006B805C69BC43A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <aGUgxCzTmcBHbdR5@alpha.franken.de>
References: <aGUgxCzTmcBHbdR5@alpha.franken.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID:
 <20250703132524.19335-1-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|OSCPR01MB13596:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c320fc0-cdeb-4d89-7af9-08ddba3523ac
X-MS-Exchange-SLBlob-MailProps:
	AZnQBsB9XmpEumVcsW5TnQs3HzRNAG0ZlmJR1dF34axY+ArlcpkgMO+1WKwChCAcwzIXUlxE/jRdYKxnPwcuIFkDCMx9LPVI6J7wXzcksOZEFQwGSN4gYsdXokm9XMniflGkEDJwnlgaKjgZUYzdg6BUTSYpDne38AvpHop4rOTSG+wCSDuLPhuN2De8CP5bXRTyQyAVcw65MIOKPQXaqQiWzs1sFhfNKJMeLXdTbh1k4yVNSdo5pBPT2YFJhDxW6qPuYixQeI8fm7c4IICPN3xMe+lWSIJQ8G+wTWI2/HeNr2hUNf1FOxcKP9yBV1+o3DAjTtVBMMtWrgd0eUFf3bJuR96Q7befOR40eQHORkrYh5bgKMUW1tI9WNRsZ8GqI3vUwlBGLbuOXb/Q4vu7e2TulhOlm8XaendjBx5a/8s1PEuZVPa9+xn5aH8bKlrtEam3BsaIjZASjdAjitB/pHIju2HNsIWgmMTz5/zanlQiM8Uttl/GJ/5XtBpOE41sV3SPHHMIrqxWIRxt61SWpx2080gH8I5Ovue7OYTFP2c7pKgxyTHOC8uwB93cq3AgJClLEUFq/JOqjjjJPRCxqZxy97xWL3IU1/Jxmo7GoO9Nrm7kX+FcyzAallWGgVP/9gJSrYZvrMK4UEcFKf61qJALWS1NZs6iuHq5CNj3km2F53DMArnmAlOmPb4yVusGpRIeXj0iDA1mmrMzF8IE1gZahESFeZaNQVNFJAgE3b/zUJuQ5PYDRJnfCMja4Nzal8zm0U9kHuk=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|15080799009|8060799009|7092599006|5072599009|461199028|40105399003|53005399003|4302099013|440099028|3412199025|11031999003|10035399007|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FwgFSma4UD319Veto/HmtTNpDh+epA/AGdnYm/EkUpyW6Izx8iLRSTeEkiBG?=
 =?us-ascii?Q?pi1FbB8uXKT7AtDX1BWyuM1jlz8suXgvoekJeUqsEfRGJuiLvK1U3Hl8CN/g?=
 =?us-ascii?Q?VNOMtGRr+PFHKbkstTiCKCLPeYlBGpxaftZUNTHG7gYNBhPldRag7AWYG/jt?=
 =?us-ascii?Q?POTi6lqmEiXmG3pMZYDXXQALVfbP7wsCJxASfiW0u5ogNwEo60rhM6oX9GGg?=
 =?us-ascii?Q?tR4jb3dG8lndB7ufEbiIFefP+Ec7OnC1xhn0GYKl9fSDFTLK2aXkjC0Gon90?=
 =?us-ascii?Q?dBh+dJo+RWvjGHwOtK2T7fIUAm5/VkAkDdCxmtSVgCkai7mf+38puAbcRMBR?=
 =?us-ascii?Q?1mcfzXD1R32BgRP/7kGn4wE+iadRbk1G0BVvHvOjTQB+gAsACEPiRRFSG2KL?=
 =?us-ascii?Q?zu5zxMhzdU/z0JJTnzbjcZCvJ4RJm1OLgP8cofOBxvCUHoFuXr9hM3adUZDv?=
 =?us-ascii?Q?R7yT1POU5Lx2Btv8QAVp5vdY+5hNFLhb8sNRV6itAQ8toVBB14e4gB5w3jjH?=
 =?us-ascii?Q?8qCWkT06L70rRaFLd5hullR+d0fmnalH3U074P4+eUXVM0FKjaVL5/5+O+Jk?=
 =?us-ascii?Q?P7xkJaKhyVDHK4DVdb+HAj+W2et4GAEXuso6VjQypoXBXtiRoe0azxJy2cPc?=
 =?us-ascii?Q?Z8gVKO6qiSqXsPapsGrQPUnIG5CRMw5Vql6gtfNIxUp8poC1K9agEiSni47C?=
 =?us-ascii?Q?CXJSZ7ciGevNIUAvRa+kbdEVnsFhc33lx7SPokgCBg4vRlEBeenYQPt3zJSt?=
 =?us-ascii?Q?3XlSITuABOz93lFokRmw68Ho9/LWak7DcTLK7+/zadtYHd0W344kmLltoZPY?=
 =?us-ascii?Q?trdcakISpGU1n2jwSvLjCKKrI43BExPoTO9eZm0A4lOjqzCWuy6ZlhWDa6JX?=
 =?us-ascii?Q?/9XbzbfugYyEd1pJWiUya6YsC7xxTTA8s6gSApcDOe7JMiXusj++LUS3WfC9?=
 =?us-ascii?Q?IGt0YJcJOoxGxaoXhg2seZ0nG7hos6rndyQG9+95bX8QtQMvd2oMDBxInR01?=
 =?us-ascii?Q?b0FWy9zeSi08Ls6E4gZL+qe0uin1eCvhlOjGL4OmdOk+TmXruXaysPaZOiMu?=
 =?us-ascii?Q?CyCeYLNnXjuHMwviDpHp7pgP6IfL/awl0bwq4SPYfONzzQE9Zyk+QaQUaXaf?=
 =?us-ascii?Q?d+9uatj6m6gyZsbG4GyumRmrZ5TqqhIpUapi9qEd/AeOgSeG6hkrlehp//wV?=
 =?us-ascii?Q?m6Uuhto38qYp2iWPMN+V36eLJHTUA2u02RKSFjhkQGqqkEqixViX6qW/oluU?=
 =?us-ascii?Q?Kvhyzgl0wGmYOR29zCZDQVfmaP01Nr2giM1xjExtt5UOoMpAiLeNJBXRWyGt?=
 =?us-ascii?Q?Zx+q5RAVcJV9UrCIzKmxLbkAgl9AP8hGjEN/x4xfA2+ES7I2+bV7Kdzwe9DG?=
 =?us-ascii?Q?r4RTQR4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rj5XuhLAqTTOZ3XUrqazsEL6Sa/sKCwV6o85UfBKAav2yZYV00+C9sDac3u5?=
 =?us-ascii?Q?UEAM/jm7RV6U6BRkP/PHqybhRejTpTzRAONvt05yDdLMgL5qfylCJh4ORFBF?=
 =?us-ascii?Q?mWcP27nZ6l8yulLPZ6N6n/WZ1AQzj4nVtr3ous2CNFS3Mg/yeNpz/Y/wSfnV?=
 =?us-ascii?Q?y5OBpqMWEzyBGOCUYMJvN1LiZp71UgUp2JLQT30z/HATzb3FK0BDy3B8KbZI?=
 =?us-ascii?Q?o92TAa7jMn0lNQeRLvPQminbjZuJ2EDIVHnYq6RBeQQr102ELlNud7PnbuYm?=
 =?us-ascii?Q?6VFzUL6IrNlxb/Jml1z801Y2IAWYYSeBqaewf24eLLsZP8r9fuygGHfVnl0e?=
 =?us-ascii?Q?tN1G6WEzhk10PMCOjIWLI/rUELGXyPMEYuf/cEkdi6FPIw3Y0SaS7zujVpQR?=
 =?us-ascii?Q?BkZHWmxByXvhEhY5QlbZpVfssvIZfUfInDucHl0NqHiPRh0p+VRxeHIC8mz2?=
 =?us-ascii?Q?/wgqqnTimcVlB6FchGe5Ein7c0S+98kW9FnuAycBoHJ7CrP6sDaRnswHOv6K?=
 =?us-ascii?Q?3CPFIm6Emc3eahCUC1UxSZmuWLXk2uqi5k9dCIG2ObOfcRx5cDRG5gVDSOoO?=
 =?us-ascii?Q?hOBJSvSiYkwyybJlrtF8dyfoFQXbzNJTOgOm/LK609W2cOy3nIpVQHzAHgG0?=
 =?us-ascii?Q?hP/TSky3e/BVsiE+G5tHHLbuwK5UBkKPiOh7IDyMEe2Wino11vrRHWsaObCJ?=
 =?us-ascii?Q?PAajSPwlx8T8fbXKjkHfrEWF1AaRM7iuqZitXcre/9UdGHaSQWVji0brFz4n?=
 =?us-ascii?Q?0Tn3upXKMZfnRIQtLzMmggy74BAMXfl8aQkEI2zRY8S82nMdq7gwIHbP3XQB?=
 =?us-ascii?Q?RB51yVsx1iuceMQ5WX3DGahHW1rM+2RtYZ5xPC8Nj8140AKxeU5DaBezBPp1?=
 =?us-ascii?Q?4IwqFeBoMGzAJbBvc/Gyd9T0JpjFGphcyRqIgjq2HStQ2t3OWaAn4639Wa1L?=
 =?us-ascii?Q?JL9TZMGMH2daaSpAA6wx0wPywMbAhModTCqnLT6rr6Ad7AZHJ5SWziBCNR76?=
 =?us-ascii?Q?zihbTK1rmmYevaix4dao0W71e2iNjkdZUL7x0D9w509ioHPhsE5bpWcITRc3?=
 =?us-ascii?Q?35IBkJ2t8pd+KsQn5gf2uwVeI+IrJDjph/cAGhpelhtsrj9oxkFXSVbQFnyY?=
 =?us-ascii?Q?u6F32UpVU4yqpXZm8bQ57yo+d8To1DfDFVLWD6aO1gejgBxI6srjU4/mGc75?=
 =?us-ascii?Q?C+mXZRcxEiRaOITbKe7RcZ0lJDL16feQUFPwvIHOuuLEqZoQLvR3M0eeRo24?=
 =?us-ascii?Q?hW7EwFI02Vgo3pxOpwHU?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c320fc0-cdeb-4d89-7af9-08ddba3523ac
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 13:25:56.2367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13596

On  Wed, 2 Jul 2025 14:06:28 +0200, Thomas Bogendoerfer wrote:

> On Wed, Jun 18, 2025 at 10:53:25PM +0800, Shiji Yang wrote:
> > These functions are only used in the current source file "vpe-mt.c".
> > Do not export them and mark them as static to silence the missing
> > prototypes warnings:
> 
> you are breaking the whole idea of this interface, The functions are
> exported for other kernel modules. By removing it you break them.
> 
> If we know that this interface is unsued, we should remove the
> whole kernel module, but I don't know if it used somewhere.
> 
> Thomas.

Thank you for your review. It seems that MIPS/Lantiq platform still
rely on the vpe-mt module. I've sent another patch to fix these
vpe-mt compilation warnings. Suppress patches 12 and 13:

https://lore.kernel.org/linux-mips/OSBPR01MB16706BF0ABF807E870C79A86BC43A@OSBPR01MB1670.jpnprd01.prod.outlook.com/

Regards,
Shiji Yang

