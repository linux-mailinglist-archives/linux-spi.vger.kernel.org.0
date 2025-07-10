Return-Path: <linux-spi+bounces-9089-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D453B00863
	for <lists+linux-spi@lfdr.de>; Thu, 10 Jul 2025 18:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA051C86C2F
	for <lists+linux-spi@lfdr.de>; Thu, 10 Jul 2025 16:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F392EFD80;
	Thu, 10 Jul 2025 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Bruker.onmicrosoft.com header.i=@Bruker.onmicrosoft.com header.b="r4ENAqx8";
	dkim=pass (2048-bit key) header.d=bruker.com header.i=@bruker.com header.b="mmXPVqJo"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx-relay26-hz2.antispameurope.com (mx-relay26-hz2.antispameurope.com [94.100.136.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C202EF9C7
	for <linux-spi@vger.kernel.org>; Thu, 10 Jul 2025 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.136.226
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164287; cv=fail; b=SKNoPSPFR6aVCz9cEXIi/seOssaswduVZjyh+PzasD+2Hhhe4j/5bFMSToCnog/+0R1lt5zCby0E0PT72L+fJ3ngJe9vI1Skd3nS9V4HhMczArdw9XLtj+uFo/WivGaDz9sbUV5k0c+M08c5P2+EPlOFrIQCFUU580c+Ej5z23E=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164287; c=relaxed/simple;
	bh=K0pETfFuU4fvgA4oHvaP8MgPQU4CcIFqYW7f/wfElaw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SSQSDeUHqZlpvkBptvu2gm6pH893gFLOOzEhDqIYObN03IG/gtkJJbmxCF6euXm+S8UI5qo2D7qo9p3lvRZAyiGRbip3NUqIE3eMylJCebiRUnLPBcK5IFdCqAaQS7Rg8phhj0BjfxW87xhsaGkNvDWwYfPA+GDcx5YQi4peSFw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bruker.com; spf=pass smtp.mailfrom=bruker.com; dkim=pass (1024-bit key) header.d=Bruker.onmicrosoft.com header.i=@Bruker.onmicrosoft.com header.b=r4ENAqx8; dkim=pass (2048-bit key) header.d=bruker.com header.i=@bruker.com header.b=mmXPVqJo; arc=fail smtp.client-ip=94.100.136.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bruker.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bruker.com
ARC-Authentication-Results: i=2; mx-gate26-hz2.hornetsecurity.com 1; spf=fail
 reason=mailfrom (ip=91.229.168.76, headerfrom=bruker.com)
 smtp.mailfrom=bruker.com smtp.helo=bruexc108.brumgt.local; dkim=pass
 header.d=bruker.onmicrosoft.com header.s=selector2-bruker-onmicrosoft-com
 header.a=rsa-sha256; dmarc=fail header.from=bruker.com
 orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=hYNlEtgDju7rZofUatAtZhL4ypLGpbxaOROe4GYS6Ro=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1752164259;
 b=UL2zLCdLGy12YgpUTwub5JS9En8kGgSex2kGEsAlGYYx/KpphEwm+0jymh4LsHo1C0SmG2Lt
 TTEJ/Rqf/YkQtdvF4/4W4xc8rwT4vEj+9J7bED+u256Hu4CXMu6eoEYF6FUB/pexktt5jDt6SvW
 B9y8I7DHV/1DPOTLNuK94J8NVlkdLdKjx1jEfriKoXgbW97WRt3UeFcZu5UkG8XUqXx4KyshdDU
 aQyzPz+iZ5wukaDt/sMUQfFhE+aEQnpWY7WuPWi525JrxnWg5YAvTK5D7bRglsOQtfu/ngmF+Vl
 uEJ/QcvV3gXaWyEaYm0INEMB48ER0FqeJrIWdNa2kq/nQ==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1752164259;
 b=jxrJf1L0M/Z5uEeQTRPEGwJh61Fm9SmrY5ZK51601VP1m2OwOHpHP0vgfZHtxPpdebgqGip8
 tgBtUT8nPPtjTcCmdRNjQQL9jKYzSk4/GPix2QKvlZCgkJeipDIRdYGPV8OdhlfVmgDTKwj7aWm
 aA+6rTwBWUh72PFibCwxZbJ50UiNdmHxoR82UkjM8JqpY3dJ7dNGsfXVV+Ks37Jiduh0fJG01t8
 nDN5nxESjrR5wl8E+sIGZbQeuN17kAxb5sKJpERwN/TKlEHL0edgQQUG7Z4aOk7raiRNM/qeyww
 cbnuF24XuhqYtNVtG61knus+z7reD1WWm3M77RlOveHBQ==
Received: from smtp-out.all-for-one.com ([91.229.168.76]) by mx-relay26-hz2.antispameurope.com;
 Thu, 10 Jul 2025 18:17:39 +0200
Received: from bruexc108.brumgt.local (10.251.3.84) by bruexc108.brumgt.local
 (10.251.3.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 10 Jul
 2025 18:15:32 +0200
Received: from FR6P281CU001.outbound.protection.outlook.com (10.251.3.124) by
 bruexc108.brumgt.local (10.251.3.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10 via Frontend Transport; Thu, 10 Jul 2025 18:15:32 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dolF1sREg2lf7pW0JxnPRRX4ITwgYhp89V4NEy1hQgmh0BxiEZk6vrk1mn9SbDSNx/77yOAzB40delToG7hYnVJKMB9naUpZ96Gl9OmOg253ZXsl31eiiyMlf1yqVlRjSXRh7owa/D/Coai2P1rE/HLIj5JbFe3TO9Uwhs15oiEKwj1BTcEf9Js3fKqWgYCA1bkF0XPnI882qatnkulZR4DzzyYNsDkB6syjmw4cdbbRtvqr2tUVk2uqL4TPP3S4vIs9bbjRv14AriI283zL2JVpqnd3BOJ8XT5VGWH8+UN62drYQvQgJYOWquqfnSDqo7ENFvBsj/tHBJM9TbIpfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYNlEtgDju7rZofUatAtZhL4ypLGpbxaOROe4GYS6Ro=;
 b=YM+/oLAHmEKWiFFUIudSa5xFEAYKEZSNfBybwcqREgNFPSqr/Ka58xd1dI3x6L/ryDDgSEsIfGcRXRKYrtU2jIiVFia5bmEXh1fpH9bDA2OPKx7AWRw1TxJjA6TAS75IIoChpvLDgsoPlKs58wBSxjOSO+Npw1HUXTxfpCuu5uEO/Y8rSt3UYdDfq92Y/2cIppK4N76MkRwR90wvW533rt1ENb81cXEjv8XB4MTDKdat9wdslkzle1q6v/twJIJkLp57uusitvvLFcEHRQf8//eI6NAlo/oF0/MjtcDtNyS9QlnHhyMp3v5BnsrRy8HQKb4CeEgrbeAokszgxdciuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bruker.com; dmarc=pass action=none header.from=bruker.com;
 dkim=pass header.d=bruker.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Bruker.onmicrosoft.com; s=selector2-Bruker-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYNlEtgDju7rZofUatAtZhL4ypLGpbxaOROe4GYS6Ro=;
 b=r4ENAqx86tjLdFofCBYlBNJ3d1t0zLVwxbHE6fkdrpLp+rkDXbK2S87UQiNwOmR1shZdeGcDAgO+LyNvpRk0vdgqtsXwOSduNWKTVJNpZ1H9/TOAzIAAeNYi9PY2s1BNAH8f6GYbrS39IaUdJ6hi3kF7PQhlYVQBDn6cpx8xgsQ=
Received: from FR4P281MB3434.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:d3::6) by
 BEZP281MB3268.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:64::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.29; Thu, 10 Jul 2025 16:15:30 +0000
Received: from FR4P281MB3434.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d0e:acae:7d6d:f567]) by FR4P281MB3434.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d0e:acae:7d6d:f567%4]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 16:15:29 +0000
From: "Hohn, Torben" <Torben.Hohn@bruker.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Mark Brown <broonie@kernel.org>, "amit.kumar-mahapatra@amd.com"
	<amit.kumar-mahapatra@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "linux@roeck-us.net" <linux@roeck-us.net>
Subject: AW: AW: [PATCH v2] spi: Raise limit on number of chip selects
Thread-Topic: AW: [PATCH v2] spi: Raise limit on number of chip selects
Thread-Index: AQHb5rZPfQusim3qPkGfN64hDqfGqLQW2AgAgATR8EWADd5XAIACE8kG
Date: Thu, 10 Jul 2025 16:15:29 +0000
Message-ID: <FR4P281MB343444EF2816EC9DD405FC5B8348A@FR4P281MB3434.DEUP281.PROD.OUTLOOK.COM>
References: <FR4P281MB343441EB901D3DD286B923D6837AA@FR4P281MB3434.DEUP281.PROD.OUTLOOK.COM>
 <aF553GU_btT81_b_@finisterre.sirena.org.uk>
 <FR4P281MB34343BD0D260C127866768298346A@FR4P281MB3434.DEUP281.PROD.OUTLOOK.COM>
 <20250709-bronze-duck-from-valhalla-118ef8-mkl@pengutronix.de>
In-Reply-To: <20250709-bronze-duck-from-valhalla-118ef8-mkl@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_e340eb20-1c5f-4409-b1a4-85adc943d5d7_Enabled=True;MSIP_Label_e340eb20-1c5f-4409-b1a4-85adc943d5d7_SiteId=375ce1b8-8db1-479b-a12c-06fa9d2a2eaf;MSIP_Label_e340eb20-1c5f-4409-b1a4-85adc943d5d7_SetDate=2025-07-10T16:15:29.0090000Z;MSIP_Label_e340eb20-1c5f-4409-b1a4-85adc943d5d7_Name=-Bruker
 Confidential-;MSIP_Label_e340eb20-1c5f-4409-b1a4-85adc943d5d7_ContentBits=3;MSIP_Label_e340eb20-1c5f-4409-b1a4-85adc943d5d7_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bruker.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR4P281MB3434:EE_|BEZP281MB3268:EE_
x-ms-office365-filtering-correlation-id: 87b4a721-e1b8-43c5-c95f-08ddbfccfced
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-7?B?cUlpeTFvSnhtV2NqVFNLVkkyOXZBN0w1c3hURHJpdGhjMVM0QklISWdtaFlB?=
 =?utf-7?B?VnlScHlWM3hsSi93MFI2YVVaT1NoeTdXU3ZHQ0VjV3FzL1lGb2I0VmVJYVNJ?=
 =?utf-7?B?ckd1cDNxclROWFJSUWg4U3Vsell4azNDanhFUXhUZEhtKy03SCstOWJEUVRF?=
 =?utf-7?B?MlBWbklSWlM2eVorLUdPRmxpb1E2T3oxM3Z0bmNrSEVLYUVwYU5uUkg1dzJm?=
 =?utf-7?B?VXhNVFlnM2lZbVdGQWhQL0NWcksxSjdOYUJpMU1lMGkyL2hJZXc3STB4SDZ1?=
 =?utf-7?B?eUw4UHYxMDRobUtRUS8zc2RWNksyV1ZzalpLdVF6VDZLUHNxKy1aem9Ibm9m?=
 =?utf-7?B?Q3NNZWsySTI4R0ZvdEN1QmdlVEpWdVZ1b3V5V1BPSW1JRUpRODhMY3lkTWRj?=
 =?utf-7?B?aFZxdEpGKy1zUi9vMXgydmxpVHRXUDRJNDVCcXNXRXZGaDhZNk1MU0tXNWJq?=
 =?utf-7?B?Nmw3cllnNUI0NzBuM1B3azNjcGpsRUcwOXBWNjYvWVZSZVo0S1pidUpGL3Rq?=
 =?utf-7?B?VUhBMGx6UjQxM0ZFcWV5MVJvM2JnVlVKYUw3am9xUDY3SEMzQWF1RGR1ZE4x?=
 =?utf-7?B?TUNQYlZFaUl5QXRMZnpRRGNLeG80TEJoQ1NpeHNPSmMrLTM3T0dnS1h3Mmc4?=
 =?utf-7?B?S3BxRHdiZjRRcTNTYzNVbkEwZUtjVnM4RG9vNGZWNnBTVTFNL1YyM2tPSUpn?=
 =?utf-7?B?QWViVllEcnBxaWZMa1RoRXRibkVIOWU3YWNBVFBONDcrLWhTSlU2RW0wYi9j?=
 =?utf-7?B?YTVXSTFHR1lpS2VOb0ZwZDVsaWxiR3E0b0liY2haRjV1bmdPRm1RSGRuKy04?=
 =?utf-7?B?blJrR3pRejNCOHhzMHJMSk1adXh3UTRxenJIY2xleUlTYnlIdldzN2E3bURE?=
 =?utf-7?B?TXA4ZGRPemNwdi8xY0V5OWJqa2l1TnZRVWJiSDlWTVBQR0pIRUc2eXlMdjg=?=
 =?utf-7?B?Ky1sRTM2Nk92M3hoYi9PMnR6Q2hqWnNmOUxVRWdCNENnSVpyUkZBNXZ5aUhj?=
 =?utf-7?B?ZE82WldPelhTQ015TjExeVY4NWxrdktsdFZTSTRhdDBUUystTWpRQ3piOXE=?=
 =?utf-7?B?Ky04WlNVRTdEQWhYTlRHRGRRUkYvdGhhUkhINSstTmkwOHBRKy15Wkh0TmRm?=
 =?utf-7?B?L1ExbnNYOVozODhJemdzSXVyeTNDVy9DMDk4MUVPODB2WlJzck81eUxwdEE=?=
 =?utf-7?B?Ky10d2tZbU9xRllDb2dDWFhWRGJRYjZkclUyZDh3TnpYalV1L3VucXdmanBS?=
 =?utf-7?B?V1dmNldtN0J3RHVpQk9sem5MUDBVWTRMMDZXMnRFNXAzQnIveDVqRkFnejdV?=
 =?utf-7?B?WDdUYWQrLVp5Ky1JSDJQdGpublBkVTJPQTNxaU0xdEQ5ZVA2ZlZlRFZmMDlL?=
 =?utf-7?B?RmRaRWY3U3NXUGRQakRQeFJEU0gwZGQwQ0pIMHY0a1BUZmRZL2IvczlUalIx?=
 =?utf-7?B?L2dDZHdqMlhSUWREODNqaVl3OGxkTjN6dDdZZURLaXNlMFhnL1RBVTJia0ZI?=
 =?utf-7?B?cnVpRlNZVWI2WEJ1UHViMExxeHFVTjZ5VXNaR0tuYVUrLW05TkwrLUc5VjlD?=
 =?utf-7?B?c1phSFB3MFVHbTBxQmJNWUZNZG5WWGlWM1VMWS9iR1VFc0cwUDhXcS9yKy1y?=
 =?utf-7?B?MGUycS9CMkFwc0h6elU3VGwwNWFrQTNvRVlCQjRzQlE5ZGJxY25hTystaFRH?=
 =?utf-7?B?VWdhSGdrdDVpd283STZ1MVgyUHRzUTErLUY5Vzd1ZFBjQ2JLYVBnbystRUtP?=
 =?utf-7?B?VEFMZFZFM0VwM1ZHKy1BdDB4WnhrMnY3SHYyYUorLWNZQXl0amVGNXNhVWRW?=
 =?utf-7?B?bTREMCstMldLUFR4VzdVRVNaYnZaYUcwdURYMzFCYVNpdm1wcDQzYTdLNFJC?=
 =?utf-7?B?b0VXOXZ0SWd4Wm5VZFE3YWtoaWJXMVFpMFd5RWpQcHVyR0o0SUxPQTVzbFd5?=
 =?utf-7?B?UVJZeU1Qdk9VWnhZV2wwMkgyNXo4QktVWkFpTnZHa2pHcUdYcm53K0FEMC0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR4P281MB3434.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?bDl3TUZPTmRQRUFmUzFhejRETnNacDhqcDczY2oyZVZ5NHNOam5pQlRlbVBz?=
 =?utf-7?B?dnZsaXBQZ2xuVzM5a1lJREN2a1kxYXE3YzJTKy1WTW9JUmdGTGFDYjNidkhn?=
 =?utf-7?B?YXlmdlRrSTV1OGRnQ2FVSm55MDhvcWc3ck05V1lNUjhnWUJheHhPb1prOUdT?=
 =?utf-7?B?d25oQXYvSXRWaXF4TFBWRXE1OW5paHppRXN6aistQXdMM093M0diT3NXWC9h?=
 =?utf-7?B?Vkh4eUU2ME93RE9oRDl4TW5zSUt5eEZoM1NoakRmZkk5S1VHQ1V1ZlZYKy1o?=
 =?utf-7?B?M3VkRUltdTdpVzR4NHhqYm81SjFlRXRqS3NWMlk1VlVWdUhuMjdxUzZCVGVT?=
 =?utf-7?B?NkFLRHpnbm9uV1IxdXFEOTUyamhsalVRZW5SOGNtSVFqTE53bzQxUjVRMist?=
 =?utf-7?B?czYwbU1HUjVnRXdWYkpacDZYWVZxOElGR2NCTW51cU1pdEc2Q1k4VnZkMzVv?=
 =?utf-7?B?Mm5XWWMwYnVLKy01MWhFL0pXSi9YSjVsT0dZS3l0L25BU1RwOFIvOXIwbmxV?=
 =?utf-7?B?eklGUVloUWNwQ1FQKy0yRzM2TistNTFpTUlxR2RKc2U4eHNuZEt1VTdxQ2ky?=
 =?utf-7?B?VTJMcGx2ZHFHTmFmaW5ucnlPVnMyZHZrM3hQKy1tZFY1ejlLNklKOVU4d0pR?=
 =?utf-7?B?OEhKNzFMSmJYNzNJS2l6OUJ2ZXVpNWdUMFplTWFMcEUxMEZXSjNpY0l0Y295?=
 =?utf-7?B?QnJ5N1Bkb3BPbHpONlQyVVd5TG92SkJSR2JhWUE3dlVDMFpYdmFWTWJCM2tM?=
 =?utf-7?B?RWloN1F6NHNkdlFyVEt0WllEelgrLW54eWtuQ3ovSjFlSzJoQVFXdURGbGow?=
 =?utf-7?B?QzBwVkxUSnVlbzRyMXc4RzJBdlB5N1cwSnpHNHJDRHRpZ3lGKy0rLUZjQ1RK?=
 =?utf-7?B?eHNIemwvUER6NHVzTlZzZ3NEKy05N2E5U0h2eTdWRFZrYllodGNzcTVZaHY4?=
 =?utf-7?B?OEEwdk5HSmJWUlpFL21iVW1PZXpyVm5XRjlyNE5tQXMvVEd4aXc2SkpDMG0v?=
 =?utf-7?B?VkNzOFRaV01sUDZaZ2RDVExUaURveFNUUTJhQndRM2ptTHBrQ2ZpdW5rbjB4?=
 =?utf-7?B?SDlUY21IZmJSc2Rnb2lOQistSUUxTDkxazJXWkVkYnJ5ZlJQNVE0WFJjWnlz?=
 =?utf-7?B?TWlmc2Q1czAvNTJ6WXVseHF4aDZBdS9wZmtsUURWWTJQbDdZNVM4UG5rZzVF?=
 =?utf-7?B?Ky1mQW5CMDV3L2NQYkRHS3g3VUUvazBUYS9vUFpnaXdwSkRCOG1veHljYVQ0?=
 =?utf-7?B?V2xaUlR2SWhBTU9uamhUUlRHYTUwSEUrLWI3TEJjYmNHdTMvWlhKWGxRRWRy?=
 =?utf-7?B?TlBEMFhocmd5RWYzZGE1em5DR1pIWDFEdU5saHVpeUdrcjF4amJFaDBrY0Vp?=
 =?utf-7?B?aFA0amVqa2t5SmRONFFoY0VSNC9OdEZUKy1HNXhhMmp5dmN0UWJ0TnBmMVVO?=
 =?utf-7?B?b25mdnIvaEQ4NWRLTzUrLWVnMmpPSzVzTjd3OXpkTFdZNG9kWk1FYUVDWkoz?=
 =?utf-7?B?L2gxdG41SnhTRXZzS1Q3Ky1hYVdGYVlMaUdsUVNLM05vOVRxd3M0YVQyR0w=?=
 =?utf-7?B?Ky1NN1c2YWpvRkkzSkhKSktzbHZxRHNIVWJSdEVucU94NmJzYjluMi9jTU0=?=
 =?utf-7?B?cisteFlsN1YyeElhSHU0bkFvWkliWVArLUt4YistZUZTWGp2M2JNMHZWWWJS?=
 =?utf-7?B?Y2tJMzl6WjJITnYzU2NCajdZRE10d0N0NkduRXc1VWkzMnR1TUppM1ZDWlFB?=
 =?utf-7?B?cEdYYUxVT0pia1A0UERyQWo0eUU3U3ZNaGVLQVNXRkZiV1BzLzdsVjE3d2s0?=
 =?utf-7?B?TistUHdXN0ZNNkI1TEJsTnVzemEvNThYbW0vSjVxYTFqaVZlc1NuQm9CZWQ1?=
 =?utf-7?B?S1ErLXZhSmgrLVR1OXhGSkxOTHZ1eGdSU01BekNqMFU3QXRFSzcva24vNnQx?=
 =?utf-7?B?TlFsdmxBeTFBZHVjYUNXVEphemRNV3dSUzBUc0YxZG5hMDdrL3drNlgxUDBJ?=
 =?utf-7?B?akRVSWN3VmpTM2JVL1lUS0p4VzZBZng1S3BISXBsVWhib3FqaHdkNWFyU1JK?=
 =?utf-7?B?amdGazE2cGFRT1BtQXpvRU1NOEU5U1lwQ2h1cXFGREtjeUpBUEhHT0pyREtx?=
 =?utf-7?B?d1RtanVCcjBIVlNnZWpFdFVZZ3hKSE00RUdvYU1Gb0xSQVg2eHJyZTJTSnJT?=
 =?utf-7?B?Ymc5WTl6bg==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR4P281MB3434.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b4a721-e1b8-43c5-c95f-08ddbfccfced
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 16:15:29.4018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 375ce1b8-8db1-479b-a12c-06fa9d2a2eaf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +/rCV6NoFY7jlqaOE/T1veGUG+mTS76IMR2i5KV8uUsm7qyICitm31aCagpUT9JBuO5Xunwv8HHCFTnRP2b71g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3268
X-OriginatorOrg: bruker.com
X-cloud-security-sender:torben.hohn@bruker.com
X-cloud-security-recipient:linux-spi@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay26-hz2.antispameurope.com with 4bdKkF1xx4z24l7q
X-cloud-security-connect: smtp-out.all-for-one.com[91.229.168.76], TLS=1, IP=91.229.168.76
X-cloud-security-Digest:86b1ccb2c244131de5b142eceac4e51e
X-cloud-security:scantime:2.132
DKIM-Signature: a=rsa-sha256;
 bh=hYNlEtgDju7rZofUatAtZhL4ypLGpbxaOROe4GYS6Ro=; c=relaxed/relaxed;
 d=bruker.com; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1752164259; v=1;
 b=mmXPVqJoQP91mAKZeD79bN+uw9eJk/KBr2z+J8I0wRYBgD2VcvRHpxrxFt5vclMX7+CrwkKe
 YQIZaXqigZPUfOvPnFH3dLD5ICUeaPuYpH3UIoczFOcxhLlnl7uvtdbxpz3/DGdmhYWRmEk4Zw5
 TiLgRiA3Ia+ABcU5DpaoILvwvGqMIkXLcsU+RI0qWwUXJvrEI45F2H3WLgre30p9LnxIrwN+Fs7
 KnPvo8upvwLTpI3Bb/8Cw5KzO7Acxr0nz2+MN7GEPGhIs339K1PNCSOL30S37CzljiV0l+3HWEK
 C/Agyb6WvgF1J0UgtDxdVmD8ZyTqa8iYPLXXzsPtr8lZg==






-Bruker Confidential-
+AD4- On 07.07.2025 07:30:29, Hohn, Torben wrote:
+AD4- +AD4- +AD4- +AD4- +-+ACM-define SPI+AF8-CS+AF8-CNT+AF8-MAX 16
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AD4- If this is increased to 24 now, we need to carry an=
other patch on top of mainline again once we add another Chipselect
+AD4- +AD4- +AD4- +AD4- into our FPGA, or into the next iteration of our ha=
rdware. We would really prefer that a Kconfig value is used.
+AD4- +AD4- +AD4- +AD4- We have handed a patch to pengutronix, because they=
 can send proper emails.
+AD4- +AD4-
+AD4- +AD4- +AD4- +AD4- In the IIO framework there is a Konfig Value for so=
mething similar:
+AD4- +AD4- +AD4- +AD4- https://git.kernel.org/pub/scm/linux/kernel/git/tor=
valds/linux.git/tree/include/linux/iio/trigger.h+ACM-n74
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- This doesn't really work, we're supposed to support singl=
e kernel image
+AD4- +AD4- +AD4- so putting per platform configuration in Kconfig ends up =
being at best a
+AD4- +AD4- +AD4- usability problem.  At some point it's better to just bit=
e the bullet
+AD4- +AD4- +AD4- and make things dynamic.
+AD4- +AD4-
+AD4- +AD4- After looking a bit more throughly at the code, i dont think it=
 is
+AD4- +AD4- necessary to make this dynamic. The Value at hand is actually t=
he
+AD4- +AD4- number of Chipselects a Device might have and not the the maxim=
um
+AD4- +AD4- number of Chipselects a Controller might have.

+AD4- I think it's both. The struct spi+AF8-controller uses SPI+AF8-CS+AF8-=
CNT+AF8-MAX:
+AD4-
+AD4- +AHw- struct spi+AF8-controller +AHs-
+AD4- +AFs-...+AF0-
+AD4- +AHw-       s8                              last+AF8-cs+AFs-SPI+AF8-C=
S+AF8-CNT+AF8-MAX+AF0AOw-
+AD4- +AHw-       u32                             last+AF8-cs+AF8-index+AF8=
-mask : SPI+AF8-CS+AF8-CNT+AF8-MAX+ADs-

This value saves that last chipselect that was active.
Before the multi-cs per device patch, this was a single u8 and no array.
The mask just states which element of last+AF8-cs is valid.
It is in struct spi+AF8-controller but since it just saves the value from o=
ne device. It still just the per device value, and unrelated to the
number of chipselects per device.
And the last+AF8-cs ccount an not be more than the maximum number of CS per=
 device.


+AD4- See discussion
+AD4- https://lore.kernel.org/all/49b52941-6205-48bd-b2ae-e334018ac5cd+AEA-=
sirena.org.uk/
+AD4- for more details.


yeah... see:
https://lore.kernel.org/all/CAOiHx+AD0-mM7kpzR-MOshsgXZM+-CSB0nawfWxMhpt+AD=
0-tuhmJyMTCzQ+AEA-mail.gmail.com/


