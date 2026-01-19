Return-Path: <linux-spi+bounces-12487-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07201D3AA95
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 14:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43C39304356B
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 13:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87A136AB7E;
	Mon, 19 Jan 2026 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BlueCurrent.onmicrosoft.com header.i=@BlueCurrent.onmicrosoft.com header.b="Ht8ynO1h"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023104.outbound.protection.outlook.com [40.107.159.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E39E36B05C
	for <linux-spi@vger.kernel.org>; Mon, 19 Jan 2026 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768830197; cv=fail; b=tnnvVl+u1uzvoyeuXyIQz5ALUt3imLuQZfOvGQ5SQBETNlzr7M/USXn3Ni7TmGbWGzXz8Mn8Khm8N358ZS2OCBVYHI1uFocbcrBKnvNxXiJn859BWfGsYSDHCEZkAEZHm3ZYg/9EiZkESDERXyuyoouCBBG70+KHpOa0sm3glvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768830197; c=relaxed/simple;
	bh=8r7rR/3LcN9c3/NeR2upwN0DAM8Z0RQ7H1tJUp0mqHo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=u38K2ZaEhzj32epUshXLGE27pn4H5mxSSaJEsvq1nfDlkrGOMgBDifujgmH55Lhol+qFs1QuXGb7Nl/kKi+T46H3oAD5ZvObM9hi8EAq5mn/wUiupp8ap5AN/zTS0RAbg1eI132O9RXI35nIW69/GorfA+WVSK0wDCwrasSIbik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bluecurrent.nl; spf=pass smtp.mailfrom=bluecurrent.nl; dkim=pass (1024-bit key) header.d=BlueCurrent.onmicrosoft.com header.i=@BlueCurrent.onmicrosoft.com header.b=Ht8ynO1h; arc=fail smtp.client-ip=40.107.159.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bluecurrent.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bluecurrent.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMxOb5lgNQeVw4XqixDT5X+4b4zAdPnN74HbQieXzK+aMIxC1bp8akmPCg8+fjax2aHrQ9fk+7S35F7C3Jlo4xF595kna9UZ88Tk1L9mShTK0DrrmCYVgv43WFL4iALlGWA4pJ2gUaesCCMxIEaOe4yLZS3q242LMHwK6sHZBcmS4Pv3e9w7iu7WCfG0XToEizhAD9w5JckUnJmmoBtViAKoiYP2Qcs6AqB1A/JpkUqGj195Ksp5ohbJ4twtHapeq+6JA2NcdAIA9wz78vSdAWBEyhG1HcCIwI2fxPtvcOqBWOTArNOeM5lLicJAF+FAU7mnF+tRgwPsAFEb1//UWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8r7rR/3LcN9c3/NeR2upwN0DAM8Z0RQ7H1tJUp0mqHo=;
 b=PFLfHc5IuwIMLwUAJRcPbyzw20WBEsopcNBaFQmoVs2qGT7SBsTM8BPzRxNdr2DAyvi6aygKX7fpBUYARVG6fteM1Lov9LTPSQ5XN9Mwko5XCbfg4zmcdtM5tNP3pJEd0u/2FImlcFxhkzR7amb7qGraHamBjKQ2oq7v1KrQ3UH43NbHPO7jo26/fkELWARF2UEtcAUXEq1QF++iE76gNUPpQWRCL+3F2+ZwX42HWboLXoif18KLzARS0+BhDVw18DrQaUQWvW9f6ARoSe9xwD7yi7u/SNmPUwnIdLUAfPk3y8VhM6rg7cOmOcfUFAxnYTX6HPXHoDGkuRtcW4T98w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bluecurrent.nl; dmarc=pass action=none
 header.from=bluecurrent.nl; dkim=pass header.d=bluecurrent.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=BlueCurrent.onmicrosoft.com; s=selector2-BlueCurrent-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8r7rR/3LcN9c3/NeR2upwN0DAM8Z0RQ7H1tJUp0mqHo=;
 b=Ht8ynO1hUv3Gw+8aeNAal/XFuSdFP1vkto1u4eDkf1FvKYTrU3s2iUZLDmM7qsFtkpcPeHuyht5NVC1G8AUulbKSGa22R6G0hkHzxdAjYFIbHDgjjz+U+uHCa1Ooy+m1Oy4Iy24rCdwP5/S0EdOF2WueXR6wg9/VRqPKYWXZIv8=
Received: from GVUPR01MB12599.eurprd01.prod.exchangelabs.com
 (2603:10a6:150:332::17) by PA1PR01MB11394.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:488::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 13:43:12 +0000
Received: from GVUPR01MB12599.eurprd01.prod.exchangelabs.com
 ([fe80::3b48:df40:2960:7550]) by
 GVUPR01MB12599.eurprd01.prod.exchangelabs.com ([fe80::3b48:df40:2960:7550%6])
 with mapi id 15.20.9520.011; Mon, 19 Jan 2026 13:43:12 +0000
From: Florian Humblot <florian.humblot@bluecurrent.nl>
To: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
CC: Mark Brown <broonie@kernel.org>
Subject: [RFC] spi: ar934x: Question regarding hardcoded num_chipselect limit
Thread-Topic: [RFC] spi: ar934x: Question regarding hardcoded num_chipselect
 limit
Thread-Index: AQHciUkqPbf3olzqF0WC/c3fr84gHg==
Date: Mon, 19 Jan 2026 13:43:12 +0000
Message-ID:
 <GVUPR01MB125993E3E5EA1CA05FF4B08189B88A@GVUPR01MB12599.eurprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bluecurrent.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVUPR01MB12599:EE_|PA1PR01MB11394:EE_
x-ms-office365-filtering-correlation-id: 870cb178-3b5c-43ba-0639-08de5760b0a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?aCRgQdyDTy2WYhSUAm8Ziw8EhQo7Kzq5Warc+stGolSqmeSgExFFKPsLI1?=
 =?iso-8859-1?Q?t+GPBAUJclELSaBzdgOKZL9y8hqL29Hzc/1JaELuXeXAgDPLZA9l+E3H2b?=
 =?iso-8859-1?Q?NvqV35aAkZ1b2u5Ak0KZbT4nD4szcHvZkLowj0Gan3O4lZ9NHeOgtlm7NY?=
 =?iso-8859-1?Q?oPQqvBzFli7sLG3JCbglh/k1x3RyhnQ4GdzE7YtvEf+uzb5kR6kJF87biw?=
 =?iso-8859-1?Q?zApV6w210Tp6ojKDR6EeQnz4l5PQlykxHVXeou19fFQV0Xvz19iaoi64Sn?=
 =?iso-8859-1?Q?cwZYwr8ZyDpc9uit/rZqsSzLR5+GlZPLxPamPSpP2OvOvYo3WEc78NQLHV?=
 =?iso-8859-1?Q?NSDkg1zZEePxBbCDueIiJbDiKSwnQDdqQqOJ0gQ+kpNYTGmp1q5yJiFbAE?=
 =?iso-8859-1?Q?ohlp+lCx4Ef1J1MPKQs4qNakL9NUXkMsmmQ3KoeeoWPvkJ7fzX89yIXMYM?=
 =?iso-8859-1?Q?KmIwdFGaf+ovr6oG/AZvDpuLZigxWk+pafRb60/P0cipR4L5GiLzsEjBYs?=
 =?iso-8859-1?Q?RHw0bX+KrGdQzA2pIftST150B7QJsQNjiIUxBDsnuDGrXa5dDQXvg4iD6w?=
 =?iso-8859-1?Q?MBJoN5ly2FocvblUx6JhtGH+UYB2lP03kAEhtMuBLkx8v/NHYYQqyrGp4A?=
 =?iso-8859-1?Q?a1wI/cMhorm7VB49Rq8N0J3Ya8eL6Ka8BeeptWJXj9WlFiwqRJCWEUE7tj?=
 =?iso-8859-1?Q?ug08US9CzQp88KYOCqrZHVgyAwbGi17xpHR1EyPySDP8B5cEUk/aj0qv0+?=
 =?iso-8859-1?Q?ZLjckCiffSMZ5gnr2PgPqhdU7TfTQ64ZGXCCxLTGMEVH8C5YjLoy1el5TA?=
 =?iso-8859-1?Q?cqZ6uU3vw3DGNENWUk01fevSdnHfpntodmRxW3XIQZmjm1DgZRplxFH4ot?=
 =?iso-8859-1?Q?8ZzsadAfXjiOEdZjA+mP+OHxl3vR05xyv6Kob+fxELHs7mJiqVp5XJ2/z1?=
 =?iso-8859-1?Q?eYqDmXa2pWDDSHgIAQh61/kdDyjaI236ywmTAkLmCzZFfSWW3jaeYBNqMj?=
 =?iso-8859-1?Q?LAMFTMnZeAAnSWJh3EEn628qHeySvIZpUXAVoV4DO4MKUW8wThRoA/JiEf?=
 =?iso-8859-1?Q?UsqvwwvxcUBE0JyiGy7LMTiXKb63+omxpz7pLxbbqpHBUhN2HXacJtdOo5?=
 =?iso-8859-1?Q?nTw/n2aJmKvXNCf7A9QQqd8giSi2vblOtEPNUHsd6+nvXLqBb5WzbBaLqq?=
 =?iso-8859-1?Q?EhWcvLYHzOYBBa/Q3wJIalmHP6namQ0j6tGCp5E7qWXo604vh5Vx7QJ/dm?=
 =?iso-8859-1?Q?NUQykFNkFXRK8h1kgbbx+1zW0az+0BB7nPmuIUH45SzH1c0xLDknk88qsy?=
 =?iso-8859-1?Q?APNCmqWbYew73nEJv8WXm2/172ra/4/zx1xBH4niUj9djd6SJvYGdlKIsb?=
 =?iso-8859-1?Q?V8iuOiTMon4gmFsLwQXpE1U6h0k1HkGWLeYFB5V5LDN2TpuIR+LUMD1bI7?=
 =?iso-8859-1?Q?jUkgXNpTRRSXtiq1SurazRYDHuj+QqprlA+UjNOGIPJnllmEcNSCG/ma5v?=
 =?iso-8859-1?Q?RIaEk9jNq6JIU7ilICBI/RQak2+FVF77JhO4Eg3y/smy4UJfnq8KYppCXM?=
 =?iso-8859-1?Q?QxC+ZaaUrVNzZkKpHVVe4kR43G2SSyPGhr2PwgYpJsUBUFUOGgSXgp9JFw?=
 =?iso-8859-1?Q?C2+MZWYTi6lIEn0A0umRQxDjOHtxClCdh50Mfe6bSfMgF8YmTfLZoFqZY4?=
 =?iso-8859-1?Q?dGB9NBNvv/RpVT+jMvw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVUPR01MB12599.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?JF4exdXe1Xjxq2/dtYo1rp2Qyuix7AcZwZFA1NxZ4T90NuKIujhkUW0BtI?=
 =?iso-8859-1?Q?l7QY/h+Z+JhnDqUqmGZITvjXE2VBotAYRWzE+zLYeNmZJaa55haRGrTJy1?=
 =?iso-8859-1?Q?9xxWfUVFsTFUK43bkURI2slCkFYyVC1cQRdohRbBrvmNvSHHF7FeuBHtn5?=
 =?iso-8859-1?Q?X2sivBWgzDTAyUxkdwat8tSwt9a0fC5dx0rGaOqEa7JqnDoiozxJ7v9xR8?=
 =?iso-8859-1?Q?ZWdYDvgXup8YfMtlFhLuZK0j8VsYoJ6NnOfy4z2ZtnaWB5v+hMX5mqdNTc?=
 =?iso-8859-1?Q?DIa9QruDMzCr4seWxcvHmOdcBSbtIVx3lUOddU4FCXkHQigAJQKyo5O29p?=
 =?iso-8859-1?Q?Bjqo7+/wE77rcQftEkgflSpnVZ6dqGXU7r5zkmeGT76k1WXVI9+lwa9qch?=
 =?iso-8859-1?Q?GryCbIoie7LYn/By/gJ7Oi/LogR8XQaKvqR1at+6CDWKXypy01fb2naYaY?=
 =?iso-8859-1?Q?t+jR70POck5zcMH/8UWMQw/QRHSmUTiQacRDA5xDTLLxebjh2wlX35h5bd?=
 =?iso-8859-1?Q?deCg0/XHxMSeK5Mv1LmgBQgBaWTP/SYClkBMWdnWQ3onOIOGgClsN+STq6?=
 =?iso-8859-1?Q?ia46WcSzhvXniNITKO8+99gpRgFGd4b4H4WRZUd5yU7eOvvDkmjFfxs/K3?=
 =?iso-8859-1?Q?wAGKO0VRist+rS9cKslhlUFLJ5RNKJxYbBny/JSZBgklzmbewiCEAplsTj?=
 =?iso-8859-1?Q?4CmHmKUum4xRwmWi2bQGcPpiCXnrulNh+RH91krdeGWZvUgbdY5HRXz3e+?=
 =?iso-8859-1?Q?kyMebig6gIp4xlqLNPpZJVQAOzcH6Qitbktmt/vDZVr4d6AJUsqKGeS5su?=
 =?iso-8859-1?Q?X9zjHjsxbyXH8uuCRBv4/UO7d6DdiNhC8ZzGoSCG/uKFMmVkMotv3kSyn/?=
 =?iso-8859-1?Q?tDb8K8s3S3Q5kJnAwgVgvZGEpD2isJcQE4NQyFC5uB390bAQJghfgib34F?=
 =?iso-8859-1?Q?GJrPgVLKQNVoLg9nlCXi7bZRGw1aqlGpQPsftbi57SBoQTBr75EOjt4VXd?=
 =?iso-8859-1?Q?kKBmsH3rekl3nGnVw+nWvaHtBDKdESEM3LIbwMgnZbo8yTbtIDU3blpYK2?=
 =?iso-8859-1?Q?f/ELPtEESuQ11YWzSe349X281x39DU+76zRjthGrdLR8UOnUt8jfoqa6YM?=
 =?iso-8859-1?Q?+9E7BTWeAvye0AtRuFmHXeY8U6FB21dy5J+++K6A6OtSZWpnMqc94r6/IN?=
 =?iso-8859-1?Q?dqM9vevsTo9jS8aPxmQt2a4bPCNOP9uBG6n7oLO7DcgXaNKILyQJqNUCIq?=
 =?iso-8859-1?Q?YvqsNcgPIR1QaLMYt8JUmuWOa2Fhh70lHF5TvkbRkPqlDPRWszWQbT1DyT?=
 =?iso-8859-1?Q?cfedx07YcZuQ/8VQ56fj0skOU6MhYX98i9HqN5sv0/OGDYokGSAje82NBG?=
 =?iso-8859-1?Q?FXqf4TAd1SdA1p63byLNNLwypJJax3dRVGl99HlFk9XD0kFjarebkZu51B?=
 =?iso-8859-1?Q?jKQgYqrTm7WJW1on47IVIi0mLuDnF1j2S2qtCGpneYtUAz+InpNLFtYtgD?=
 =?iso-8859-1?Q?EQvy0o2d/5fyN6U/gpwYC8OKqBVTnsBdBWfiAsFRvUgvOFP6vDVc7nIiRe?=
 =?iso-8859-1?Q?713kWrY6KLr4avx3uXhWmFwJcRrScfrdf3lUl/3beOFPyvyW6MTg33f4vu?=
 =?iso-8859-1?Q?GRQg/tQGwJx26Ppz20rVqT2QLpLGV0ui51+lRZSt/AmqJSz3dt9h1v0/Ls?=
 =?iso-8859-1?Q?SklP/RNdjkYoOLy7ae4i8EENRHTbc5nUqBi9PJREKrN3j9nAfn4wkrMfPP?=
 =?iso-8859-1?Q?4pVHSrACnKPFO/EnTBFKcpZwxNon+2xHv8ZXXO1w3zgA2yXCTOWxbypjOV?=
 =?iso-8859-1?Q?THpXDFPSQPuQ67Xii4qz1x3SR8l3TN0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bluecurrent.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVUPR01MB12599.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870cb178-3b5c-43ba-0639-08de5760b0a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 13:43:12.5142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 387212a6-9737-4965-9344-0ac05aca46c5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cnqgpo8aa1U7E5i8RUrjw99zdTXs9ugSIiPiDuw3RDQ2ZqgwUpIrY6wgiSYGIljFwMDUWs6pltz1KFsbnoxPnFB8iFSynmnmehoHtC9jbp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR01MB11394

Hi all,=0A=
=0A=
I am working with the spi-ar934x driver on a ar9331-based board=0A=
and encountered an issue where cs-gpios properties in the=0A=
Device Tree are ignored for indices >=3D 3.=0A=
=0A=
Currently, drivers/spi/spi-ar934x.c sets:=0A=
ctlr->num_chipselect =3D 3;=0A=
=0A=
Is there any hardware restriction preventing us from increasing=0A=
num_chipselect to allow mixed usage of native and GPIO chip selects?=0A=
=0A=
If not, I can attempt to submit a patch to relax this limit and enable=0A=
use_gpio_descriptors.=0A=
=0A=
Thanks,=0A=
Florian Humblot=

