Return-Path: <linux-spi+bounces-9939-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEC3B4849A
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 08:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1D63BBD34
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 06:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3102E613A;
	Mon,  8 Sep 2025 06:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="P6w9Kn/p"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C5B2E1746;
	Mon,  8 Sep 2025 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757314615; cv=fail; b=YRda1i1b7DsYwHGu9MVAOQovpXue3Ha54cpDbPBvNr4hLC0SFYkZmY6XyxOkG92TPcXYdf4OuSuVX65d4cgSXiACXH2KPtjE9iRIytkoSwkZBxxaLBY6CV9lPzHqHOF2iieqIa/mVyWIU+5g+ype1EmqETd5UEDqZlweiIC1NNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757314615; c=relaxed/simple;
	bh=Vp88HGCueHtCRqSutjnzuNknCzMgkmPDJQXsLyS5LOE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FTEzb0Z5tGqUF8g2FvmDfBuiqL6EiyqL49HQVyx3BCSreVtMk5UOatlLOFHyLZ+rHvYYJHMWfXnD9uOJoETrMyHmt2oc+cG98K1JE4oSlGBX+vQCshLcMadmm0Ya2mTwiyoZ1EkEWJwQgaJPIIHtSg0RyM/VdCct0BzNt3LlG9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=P6w9Kn/p; arc=fail smtp.client-ip=40.107.212.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQPZ8RFYYwQi6Tgd0uXq5cVyOd7AIXeqSR4HQJ082MaKyBKNxt4nbVa0nHbeBqCHMkIVSIyU59oFavq459QieLlSZuMrzF2znzVNOwr7QA8Ina9XPutOaN4bjBnPz+ctVtT2Nag++jCaDLOqG0k40tiYVyer1pgGQH9NHdNaxYgzYMn84a63h5xL7cTsJljYFhOpFA9DWOm44Y3CHJeeyAy4CUNFjLPWGQLO0IDBEooQiZpBcNx8u/+3L8TRr5K0MN8wwZtvCo9JHopFYz1zoYmVGp2fHlSH+LGD6/UQUmCnrGP2ptV3PEcA5bS/oRF9k0GeQMd3zXz2khVk5zI08g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vp88HGCueHtCRqSutjnzuNknCzMgkmPDJQXsLyS5LOE=;
 b=NehuTh1ju3bA+LbLenlhwiyMbc+EBWQS6U7zdVoNbG2PnbKfZBE9HGfP6an9ceNVAAbCUWZIKwsKiLdzXmUhwfdhg1jljP+T7fJqSq2LBzZV7HhYNLRXRP54rGIECgBNPqOj2nrxACcjBYEF2iZ0HQDqU68iK1aXlf44NRK5AyBGWNKJZPM8d4U93g7IDvUTmBbFtkH0Z0xAC7TL7I/v50OKJ4oLv1jNEyXuXQswHl1f6AzRqpcg8Ca+JJox6htQMU7CUTZ+fpLH27Kf20uO766zFy8/4UsEvZRwakJMRATLFmAVu/Eg8ersfnm0BzjJhA4ek6rRbAkIT5yWXUfomQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vp88HGCueHtCRqSutjnzuNknCzMgkmPDJQXsLyS5LOE=;
 b=P6w9Kn/pjytoc3mBTAJFvXl6M8pa8ACzQucn+JC++k6ZQtk7r5iPkMpwuAxGPrROXOgVVeofxSZ3D/tm7JUCTYFtAj1suQ8vvQ6ZUADp7Opn2XNAJc/iFA37AjexAJQrJjlR76pw5r68asR449oFkROVqhczf5Qwv2kuU1wXPGnIOzCIxJQGCyzmnGE5hqvkvgel1ZnHdnfTNHUoHolVZ45+lbLyYN+0K5MndIJPiqaNSs4RyRnMGo25ozW6zut+YWcaAxSyDEBg4VRawE46Tmi8wUi6nUQTwGvDfj960bWaWctC9k4Y3Uu7Dq/G0i5cj2lFai1UYIWvDVgvnJk2Ow==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by DM3PPF2DEFDE2DF.namprd11.prod.outlook.com (2603:10b6:f:fc00::f17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Mon, 8 Sep
 2025 06:56:49 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%2]) with mapi id 15.20.9073.026; Mon, 8 Sep 2025
 06:56:49 +0000
From: <Dharma.B@microchip.com>
To: <krzk@kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<tudor.ambarus@linaro.org>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] spi: atmel,quadspi: Document sam9x7 QSPI
Thread-Topic: [PATCH 1/5] spi: atmel,quadspi: Document sam9x7 QSPI
Thread-Index: AQHcG83VB9LmjLEhZku8WJRHpUcCBrR/nmKAgAkQEgCAADFXAIAABBkA
Date: Mon, 8 Sep 2025 06:56:49 +0000
Message-ID: <41a923b7-768a-4f63-8a0a-44198c41a7e6@microchip.com>
References: <20250902-microchip-qspi-v1-0-37af59a0406a@microchip.com>
 <20250902-microchip-qspi-v1-1-37af59a0406a@microchip.com>
 <20250902-macho-violet-orangutan-faac78@kuoka>
 <7099b01b-2071-4561-b27b-0f1443f5856e@microchip.com>
 <c380ffd0-17ec-4162-8d41-37c438c23f8e@kernel.org>
In-Reply-To: <c380ffd0-17ec-4162-8d41-37c438c23f8e@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|DM3PPF2DEFDE2DF:EE_
x-ms-office365-filtering-correlation-id: d4d9a49e-2c3c-42ac-a562-08ddeea4e228
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OUlDT2VWT1E2U3QzNXR4Q09jbnhKSmxHa3Y0NVdMdjVMMWhLL2J3aVlHeGg2?=
 =?utf-8?B?cmpJY29YSmY2emVKaXoyZUhtZXEvK3Nhd2lmaHgvL01RaVVKenhiTlYvdDAx?=
 =?utf-8?B?TUk3ZkIzS3dvUTJsVGdMMWJQdmw2QkZMcEpzVFhEMXR2MnBPS1c4OVAvMEVs?=
 =?utf-8?B?RFdZWkRQaU9wU3Bka21kdlpuMzUvT0w0WGttWjZURUpCdGNXMDkxbFhQcjFT?=
 =?utf-8?B?K3p0YVF6SExtY3VGWkVCdFFMZWJwQlV5YnRZdk95ZDh6R2Q3QTBnamZweWor?=
 =?utf-8?B?TkJSZC9obERWd3ZkSzdvMGZxUE1HblhyQzFJWVZXSTdBNWlRRXVFSWJBR0pV?=
 =?utf-8?B?ZUpwSGpQWndENGhjZVBmM2ZzOWN2bWI2TWduRk9VV3hua2N5NkFYbUQrTEdl?=
 =?utf-8?B?OS8vTU81T0hYTlpMeVpHRDNicDRNZUtVL3FNSkJSSXRuNzlMODJ1dW5lQklD?=
 =?utf-8?B?V0sxek41MEZweEJTU1lkaUl2ZDgwNzVnZXkyMVRaZjY5UExWRlUvZmlVSmtR?=
 =?utf-8?B?Z1pWK3Fac0tIRFIyYmFKNGpLOW9HazBaWloyb0xsODdqbHNpUHFmVkwvdXBt?=
 =?utf-8?B?VTdoNlZOM0lQcXdIWXRtSG5wZ3JBQUkrQVVrZ0swVjcyMHVDZ0FHMmhiYWMx?=
 =?utf-8?B?eHFSaTc5KzA1NlY3ak1RKzNheGcydEF4dE91dzNsa3ZWcmNINHVKM1BjaTI5?=
 =?utf-8?B?ZEtsQmMyUFd4UytjTWttczFSRW1Nc0xtTWVzZndvNjRaS0kvK2lCVkdTMTVJ?=
 =?utf-8?B?TXBycG5VZXlJaGhiTVlBekN6a2pGSU1WR1RtSEVsU3REWFEvcFg1WTlwOWtF?=
 =?utf-8?B?OTFBUkhHZzEvL3V0OVVkVnAxaTR6OERGeFBUNC8vWTI1NG5mS3A2eTY4VXRs?=
 =?utf-8?B?UUF5a1pCbG9EeG1tUXFZU0g2Sm4ydmlCTndueVl5czdIRTVVUTRhYjhzM1Vl?=
 =?utf-8?B?VkdqRFNaa25vc1BtMjdJbHQ2MmpCMlZFdkx3UDQ3MElzVXZkWHBDUFltZU5U?=
 =?utf-8?B?WlI0bVZJRGJ2cFRQcHVQOVRHOGhDSVlDNFdpcTJmbkN4ZGVTL3YzOUd6WWdh?=
 =?utf-8?B?dWRFL3BEVC94bEtpYUd6QUZUQjQ3aFFkVUhFMGxCaXdrUTdPNUxvYm1sUU5q?=
 =?utf-8?B?NGs1VGo0QWxSZzFYV3p6OU9YNTlzU01DVFZhQUpOQWpKTU94MU5qQ2Vma2FK?=
 =?utf-8?B?dTRGOEgwMXJYSmFoWVdUTVVOR21uOVdZaUU4UTViRjhOYjU4Q2hFUFN1N0M1?=
 =?utf-8?B?UXpHMG5FQ0R6bmZwSGw5WGl6NFNpU2M5ZVROOGhXK1ZkcVBDdGd5ZTE4d2VE?=
 =?utf-8?B?NDNueStJMVEvY0o2dTZLV1QyOU5zWjFoT0t2QS9zbjNZZEs2eVc5eFlodXJS?=
 =?utf-8?B?TU4vOEovdEdyelFwTGhIU2Z6R1NMdVJKK1FaRGhXOC9oQ2REWTV6eXNzdGV2?=
 =?utf-8?B?MVFJeEIzWFlFV1JQd2paWDhtU04xWTdFNTBNSFFuT2tnMXQ4dWVWdzZ2ZkE1?=
 =?utf-8?B?TVNaaGNFME9uRjNVM3J5cHBySEZTNXBFanprblFsQlU1YVN0WnhaOEJnZC82?=
 =?utf-8?B?cHBmbWhFYTJTWUlrTDlRSGJNMmx6L2hnS2NUSTNCN3VMZGhSUjFEQnJoODBV?=
 =?utf-8?B?REJsZGJIdll3TmhCSE1MaEVZcmZ1T0draktVdlZja3R0aUE4SVlicldsNVVz?=
 =?utf-8?B?WjN3UmUvaG9pZmpRaGU2VmhBVjBCWCtDT3FhenErNFhrc3VXTUZaOHZGVEZ1?=
 =?utf-8?B?Q1o5MXorZXNHZ0NJSHVDSERpYnBsOUJhazVSRklyQjMrcldxRGhManI4SE5u?=
 =?utf-8?B?WnpSOFVEUlltd3lINXlRQ2ZlTlF4bkZmUGE3bWh5cWoyZVNGSkpITEcxbXpp?=
 =?utf-8?B?dkpYeUN3NGJHTk5sSEFESUVXSTVFNFdNaFgvV1RYZFM2aXpGeGc3YVRoVld6?=
 =?utf-8?B?NXJydTk3TFNFOVdWeVlwbFcyUnNlY2I4QTJOS2tDWi9JcE5BNVFPaHFSRlZy?=
 =?utf-8?Q?vcHW0Pli2M16DZjKTOLEPZFN1cYHwc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MHBuUTJEend5eXZLUEhhRDQyQjIyNVVycjdVMzZBTDBKZkpVb0t1V1ljOVRj?=
 =?utf-8?B?V05pUWJNR2tRNWJFS0U3L3NyNDIrUVdESmlxUnkrbjU3UjRpa01wQnQ3RGJ5?=
 =?utf-8?B?NXlVd2ZZemp0dm5tNXJlMFQ4Y0RvZEMzVUtVN0JSWlExOExDM09uRWhXVmRt?=
 =?utf-8?B?VFJ1SzNCQnhRdXJkMzNSTC81U1BmZ2dWa0ZYSWZYdE8rb2tVUU5kMERBaU1r?=
 =?utf-8?B?c1l3Tk5zVGl3bDRjZ29Dd1ZDTm9aWC9KN1JKdG84NkZJYkdnYncrZFloMGha?=
 =?utf-8?B?QmlHZWVjbGlHR2xYUVk2dkhiWENyc3B6QXlEYzFHMHBrVGVacUJpYm42RWxM?=
 =?utf-8?B?eE1HbXlOK2tvSWd0c3NsWTh6Yi9KQVhwWWNOeUYyQ1JUTDFNNVdsakxWeUN6?=
 =?utf-8?B?cGNnUCtXeE9OU2hxZERZaUp5UUpNUnpiaERRNUI2YkNKN1pMZUxHWEl2YVc5?=
 =?utf-8?B?ZFBQamxyQzVGVHd5T2RpZEtaZzhrb2JJbmZlOHk3bk1GczZiODV6VVNKcWhn?=
 =?utf-8?B?ZDlxQ0VOZnFhdThFWXc1YlB4YndyeHJrSnRtVnBJS3FxMk4vcEdieXYwV1ha?=
 =?utf-8?B?b3g3QWt6U1VGM2l6RnBNQXlKNElNbUVRdnd3VzYrS242N2tMbE5wM1RRUTNQ?=
 =?utf-8?B?dllDdTNZdDhsRWxiR0JKMjBzOVIrRDhvT2M1anlPcTd1b3NlZGtEeEJISVlU?=
 =?utf-8?B?TGdBellDUmpkbE1iY292aC9Sa2QwTzVFMElvY3laejBCamdqWTN6d240Qnpr?=
 =?utf-8?B?VGhUL3dYOE9GZmp6NDB1QTRNbmhJUmJrY0k2YThHUWZ0N09YRWFzUUllaC96?=
 =?utf-8?B?aEowa2dCU3ZJUTlTSW1CbnZ5anJSMjFhQTFDQmFjQnhUclNraXpqMVFRY0d6?=
 =?utf-8?B?K0V4T0I2TDVGSW4weXVZbnovQUlMOUR4WDBaalJ2TDhyTlFnRG5ld2hsWERF?=
 =?utf-8?B?M2hFNzlRNy9WdDR3Um1VemZOQm41MHFmN0xITFFnQ1pXZU5PWlRZWU96N0Rn?=
 =?utf-8?B?UVQvTTFHNnlnTzBuUmVZREtKcVJ2QktFbzhHMXVoTmcyVHl6U3U5ckpMM3hu?=
 =?utf-8?B?aWlGRGVDeTcrbEtBT0tOYzU4R3hidFFjaUQ3UFgxYysyOFR2WFA0VEFaUUlm?=
 =?utf-8?B?b2ZUUlcrblZQTy9qSkpCWjM4SjcxZHhBaFFoTWV2S3A1NGtnNEdBRXVUTTlF?=
 =?utf-8?B?ak5BOVp6UitGTHRyTGtvU1ZjSmFoZ25LcUduclp6RG1ka09zKzBTV2pnNUxp?=
 =?utf-8?B?Z3hqVTU1QXVRTmZ3NEFSQmNRaU5hN29SeFRMVTN4b1E2ZUFaZjl3UldVVG8v?=
 =?utf-8?B?VjJrUjF5M2NNRDBBaGlQWEltVldnaGszTnNsa2FkM0VTRUJNQldwOEVHdUhj?=
 =?utf-8?B?K3RpY09WWGNyY0ZKb3dRaWtTSkc0QWE0dVREd0J3ZW04WDBqUXlLKzNobUx2?=
 =?utf-8?B?RStPMXBJTzBtVjVKVFpqN0xpM0ZmU01kN3JZN20za1pOQ2U2ZEhVMU55MjJa?=
 =?utf-8?B?NEJTbU5saG9oaEZJMXB1UHViSVQwb21UOVk4YnZhNVl3WXFWcHZxT0x0V3Ju?=
 =?utf-8?B?ZjMyWk9JT0psRllhcG43VUhaMWI3b0JmS3NnZnRSNlBmWENteWU1aEg0ZXdL?=
 =?utf-8?B?aGFoNjdRdnhHemxmM285T09aMHdiRjAvWjkwU0RDVGZzdDNwU3NIOElsd3gy?=
 =?utf-8?B?WCtKaWdZTlA5KzkxaVF1eVJFTG9BSVNWTVgvLzl6NzA2SnpGY0J2Z25xVWMv?=
 =?utf-8?B?NVRNNTZFazZqRnVDazBaa25aN2hOelQzVVBqa2paWkRveDg1czl3aGxPaktT?=
 =?utf-8?B?YjlBeDdvbE5aZndxUDhGaUMzZmVEa3NRMkE2dXY4d1JzMTJwLzYwTkk1Ky85?=
 =?utf-8?B?WnMyeE4rNHduY2txWWpPRUxQOU9Ibmdhc3QxMUpiWUtMN3BWMThYaVlnb0Zz?=
 =?utf-8?B?djJJbmZESXZtaWJFYU1sQ0RSZDcvKzdGaWtFUkx5YjNUSWpzM2lpM255TWxZ?=
 =?utf-8?B?ZWsxNTZxbUpEWnJ1cHRpekJsSlZ0OHFVNi9UNXRZOGE3UVZNelZDT0ZZa1FI?=
 =?utf-8?B?TkR3L25Ebit2c2dQWU05U2hPcHB4a290UlFXYWFiYlk1K3hMQlNMQ3lSUmFn?=
 =?utf-8?Q?+tOZw/kpHjaCx43E6hhA0YSVq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C911609CADBB6A47B9FC331647C927EE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d9a49e-2c3c-42ac-a562-08ddeea4e228
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 06:56:49.2767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6vwGTZorT3RVtGmElBTrltpTqyLSeJ/fTO9pWfLpW6HGD3Q43hlaspIgS0/j+QY1nZ/tKU3uiin+6UBp5jjEOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF2DEFDE2DF

T24gMDgvMDkvMjUgMTI6MTIgcG0sIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IEVYVEVS
TkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMDgvMDkvMjAyNSAwNTo0NSwg
RGhhcm1hLkJAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+Pj4gU2lnbmVkLW9mZi1ieTogRGhhcm1h
IEJhbGFzdWJpcmFtYW5pIDxkaGFybWEuYkBtaWNyb2NoaXAuY29tPg0KPj4+PiAtLS0NCj4+Pj4g
ICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9hdG1lbCxxdWFkc3BpLnlh
bWwgfCAxICsNCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+Pj4+DQo+
Pj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2F0
bWVsLHF1YWRzcGkueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkv
YXRtZWwscXVhZHNwaS55YW1sDQo+Pj4+IGluZGV4IGIwZDk5YmMxMDUzNS4uYzE3MTE0MTIzMDM0
IDEwMDY0NA0KPj4+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3Bp
L2F0bWVsLHF1YWRzcGkueWFtbA0KPj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3Mvc3BpL2F0bWVsLHF1YWRzcGkueWFtbA0KPj4+PiBAQCAtMTcsNiArMTcsNyBAQCBw
cm9wZXJ0aWVzOg0KPj4+PiAgICAgICAgZW51bToNCj4+Pj4gICAgICAgICAgLSBhdG1lbCxzYW1h
NWQyLXFzcGkNCj4+Pj4gICAgICAgICAgLSBtaWNyb2NoaXAsc2FtOXg2MC1xc3BpDQo+Pj4+ICsg
ICAgICAtIG1pY3JvY2hpcCxzYW05eDctb3NwaQ0KPj4+DQo+Pj4gLi4uIGJ1dCA5eDcgaGVyZS4g
Q29uZnVzaW5nLg0KPj4NCj4+IEl0IHNob3VsZCBiZSA5eDcgb25seSAocXNwaSBpcyBjb21tb24g
Zm9yIHNhbTl4N3gpLCBJIHdpbGwgY2hhbmdlIGl0Lg0KPj4NCj4gSG0/IFRoYXQncyB3aWxkY2Fy
ZCB0aGVuLiBTZWUgd3JpdGluZyBiaW5kaW5ncy4NCg0KSXQncyBtZW50aW9uZWQNCiJET07igJlU
IHVzZSB3aWxkY2FyZHMgb3IgZGV2aWNlLWZhbWlseSBuYW1lcyBpbiBjb21wYXRpYmxlIHN0cmlu
Z3MuIg0KDQpodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9kZXZpY2V0cmVl
L2JpbmRpbmdzL3dyaXRpbmctYmluZGluZ3MuaHRtbA0KDQpIZXJlLCBpbiBzYW05eDd4LCB0aGUg
Zmlyc3QgIngiIGlzIHBhcnQgb2YgbmFtZSBpdHNlbGYgYW5kIG5vdCBhIA0Kd2lsZGNhcmQsIHNv
IGNhbiBJIGp1c3Qgc3RpY2sgdG8gc2FtOXg3Pw0KDQp3ZSBoYXZlIHByZXZpb3VzbHkgZm9sbG93
ZWQgdGhlIHNhbWUgaW4gbWFueSBiaW5kaW5ncw0KIiQgZ3JlcCAtbnJpIHNhbTl4NyBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvIg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEty
enlzenRvZg0KDQoNCi0tIA0KV2l0aCBCZXN0IFJlZ2FyZHMsDQpEaGFybWEgQi4NCg==

