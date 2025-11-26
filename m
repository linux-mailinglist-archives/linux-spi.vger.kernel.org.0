Return-Path: <linux-spi+bounces-11595-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1F1C89C3D
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 13:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D00634E4C2A
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 12:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4142032779B;
	Wed, 26 Nov 2025 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AUI30WUo"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEA5325711;
	Wed, 26 Nov 2025 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764160210; cv=fail; b=W1zSQpa7m2uGGlk6kXGmBwjXx0ctrkCHcAF8OaZLWXWi9qRK8NtSRH1O5Q7npNsbYOevvxfOUAYQlZQmuDU5f2id9EfAUu6+lc9Jkn7aOKldUr/REDVdDRgPiVm7wYdf8nvYbJdxiO6iIxkNWyj1/1O5S/SL3n0i9CfnX7UirJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764160210; c=relaxed/simple;
	bh=nvMQIO2tHbSIpQpMSotZE/YoShrrxMMdjCashSZBQF8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=skY9YXlbTGUTEq9JHUFlKRuWLLZ245BdziSiKH+EScwH02V4hKUFBH2g3XkII8Vf15b2u2/yA+IH4IDkK74cqozzNtzPTfyWMpR14SoRDax/yKp1i8schHA32SDxWfkauvZeoivIAnkgiMvG1qhM2hBIlJgB37llW8BdT8D7hHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AUI30WUo; arc=fail smtp.client-ip=52.101.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRSTPCnaYt+UwCS5gJzI2LTVwawwwJViIWWWUfyJ1e0IwDWIP/sHYtvFVeRpnc2cZYDHTcBqasabWjZdiwhObXgAOo5zOiziBIua+cDmgYL/ZgfZjGv2F/DIxoWY7t/lBKxG/OwRuGf1ri+zkEk+nhWW6/m3QfS9FrtRrWpjbTK5DTccvMrk++tOGMpZbwnIkitsgymiJ/l2ZojcvCp+fJXEjXKuZWFSasRvrPu02zNbMlGH40fizr7u9YDeA32KiLCjhTLg2EYp0lbKAj0txocif+1X9ZdCYH//Zqzre3hm6zyfqN7mMvAW4wPx06OIVm/Ni05J66zFu5/nJ83ziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvMQIO2tHbSIpQpMSotZE/YoShrrxMMdjCashSZBQF8=;
 b=pDGy/1M/dqpQC2Hqx4B22PkaQLUjwN/WSq7tgox1SLFB1ZJWEkd/gWhrj9xJWjt+gg3KRfNt+tcdvbfLJcb/RjARatyGkSbEDDrOcUb1yjBNaqYE+FwS+S6szqxKZHvVa+728mIrZgNOnDRaL3m6OYgLzA3SvgulIwSAjodpOcEiMm64utd4BZdhXjwzBlTi9aIlzR0MQSK5cDNZo073U6kbt1lJkZ8I9bnpebAJ6GbIeWVTOAyW+A85e/5ZMhZxalHmd6X+xmqvVuf6hYfQsmPbxnSxbCRNLebQJ9D9jvJeUbQORCRGEystRkbh/uCwDvwuAx5MKK/5FrHeVsQ5DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvMQIO2tHbSIpQpMSotZE/YoShrrxMMdjCashSZBQF8=;
 b=AUI30WUo4Np/vBHHF1O4dWGfTHp5PIja2WeXbuI8llVR/GI1YmMJPU5ZWR7I1VmCSuk+256m06hgLym0NbTXhwbguY8UL7h0HEpxsOcprA+AnFk3Zpy2dZrCguivUyB/2HQVCRDlmfxus5PiePeM1BJD13++ihtluQN8kbAb501vzMMkjwrRuOfyT2e4koNi7cy8V1tVpkhWMckc36rZK9W0I2xI/sd/aVSRdM1ROAOsS1C4tTwwTZuN5yqOUeee2VsLPKVOCi4unHIcwlxiKbLssXDlfvZaRvaTRyAz3y0xQrM6vHxf9SpWodHmyNb/8mDr/jbGW9XYS31U7OfAPw==
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by GVXPR04MB10247.eurprd04.prod.outlook.com
 (2603:10a6:150:1c2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Wed, 26 Nov
 2025 12:30:04 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 12:30:04 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: "broonie@kernel.org" <broonie@kernel.org>, Frank Li <frank.li@nxp.com>,
	"hawnguo@kernel.org" <hawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 6/6] spi: imx: enable DMA mode for target
 operation
Thread-Topic: [EXT] Re: [PATCH 6/6] spi: imx: enable DMA mode for target
 operation
Thread-Index: AQHcXfNYgnkhVybOTEWLiW6Jy5/IP7UE4YsAgAADONA=
Date: Wed, 26 Nov 2025 12:30:04 +0000
Message-ID:
 <VI2PR04MB111471333F43391BE85ED7B05E8DEA@VI2PR04MB11147.eurprd04.prod.outlook.com>
References: <20251125100618.2159770-1-carlos.song@nxp.com>
 <20251125100618.2159770-7-carlos.song@nxp.com>
 <20251126-bulky-mega-beaver-de575c-mkl@pengutronix.de>
In-Reply-To: <20251126-bulky-mega-beaver-de575c-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2PR04MB11147:EE_|GVXPR04MB10247:EE_
x-ms-office365-filtering-correlation-id: e4c87dce-5d55-4781-dd30-08de2ce786c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?U2YxWEU4dlM4RlZ1NXhVWnlQeFpFS3RpTHg1aVZ3R2o1Sm9RUEdJaHNSRkJE?=
 =?utf-8?B?by8wRm0ybFdDMitrMzBrT0ZEUWUwaFlHK1MyNFBkUjZkTWRsT3ZXbTZPOTVW?=
 =?utf-8?B?TUkwU0FSMXA1MlFDeGZMQ3RwM1RQOC92aTNIZ2RWTHZ3WlhmZGNuVDc1RXE0?=
 =?utf-8?B?NFJhaUxXRkpudG0zWG5qcktWalBtbDlHY1c1eFJudkhOUjRZMkdwZUt1a1Y5?=
 =?utf-8?B?RXNoaVZ2clNOSS9jNitMdUlIZndGZUZWZndaZU1PUThpOEtoNmpZQkpwMnBN?=
 =?utf-8?B?UXc4aGtBU3Q2YUx0QURTWmlmeTBlVzRjUG92Q1NScERtbVR6R1FyNFdZTTBn?=
 =?utf-8?B?RjhCRGxaWlYwcWFGMUU1Qk5kb25pdVBRWW5ZNDVseVBCdmExOWZVcHF3a0FR?=
 =?utf-8?B?NjVRVWVHbHNjNVFFRjRTMWkrS20rM2hiNHNTTm15WEhTNmZiUzBZb21hNjIw?=
 =?utf-8?B?dGVPNDlHV2hZOFVoRHp2SnBzaHAvZm1HNmV1cWVZWDFRZVNSbFVMSC8wZUp4?=
 =?utf-8?B?WlBCazNzOGlxNzVpT1dCTmdYSVFHUXRXS1pPTURqV3dCcm4vT2ZLK2J5bGlS?=
 =?utf-8?B?UkJBR0lISkVwQ0tWRW84ZERNUm9Oa0hwbFMrelJJTmZUSGM4Y1RxRlh6S0gz?=
 =?utf-8?B?Wk9LcU91bXM5MTVXVGwySjNPRXVUeGQxN2k2aWhvRDE0VzdwZWp2bm93QW9X?=
 =?utf-8?B?Qkp6WDFuV3RDUiszcFlLemdKc2kxQ1kxc2ZXSUk4WkhoN2xUN0pOVGVUSCtB?=
 =?utf-8?B?QUo1MnB2NDVFdW81ZytKY0tVWitkRmtXdHY3aFpUbW1iOUdTYkRUNXVNMmFr?=
 =?utf-8?B?ZmNuQjBaTkhtVXE2S0cvOGM3M3JVWkQvaVV3aVdTUlNnTzEyYkx2cGtpa3E4?=
 =?utf-8?B?NFFtODdKVUJJUENXbW02bjczaTJEYmk1QzdSRkYrZFljc3NKamlEOVFHTHds?=
 =?utf-8?B?cmRpVUcvZzlDcU9nZExxTW1YTHBIUWRPTTljc09odkJ6UFdkRm9QYk95SGNJ?=
 =?utf-8?B?MGYzZWw3RVRmS1IwWlZGeEJnTUtGVFZweHR1b2J2ajVocEplejFLeU9iMldk?=
 =?utf-8?B?cFg3MDJhYnphVDNTWUNUQVFpY1RNYVBhOE9tZnM4c2JOclRhYzVLMUxtQUN4?=
 =?utf-8?B?QU5CTmt1M3dFdVI1ZThCMmtwT0o5SG9nRGdNYzhteWtYRm9QcWF0Z2ZVS0JN?=
 =?utf-8?B?Z2F5SjJaN3RjTDZ6RXQvWEJraW5pTXFEeVhlREZYQ0NTS1Y5Q2NLbG9UK2Ey?=
 =?utf-8?B?cTRMRHhlakVTZVRaQlVOeWY3eW0rUGdpY3FUZ2x3Zlp3TFBLSmpRTEtKU2Vu?=
 =?utf-8?B?dCtGRGZDMk9rRmkxOFpmVEhxZmhwU01hZHhEemZYSmU3aytoZU56dUhFU0Rv?=
 =?utf-8?B?NThMejZXOXRlLzRDTkw1em5iVVZJZDd4ekJINko2TXNhSjJTWFowWHVFWlRq?=
 =?utf-8?B?UlM3UXZ4YVhZeC9XcXZTdHQ0VzArTzNNenhrWHRvMmlMNzRyWlNPeGIyNEhr?=
 =?utf-8?B?UXZGNlhZZzR6TVNOMEFTanZhN1ZYVEoxcmRmaDFEcDFXUVlJSkkwMFNhQ1No?=
 =?utf-8?B?OW9jeFA5VXhyT0VLYnhiMkNSR0dEVkd4M3BoRTB2VCtOTGVEQ2ExUk5JOS9z?=
 =?utf-8?B?S0prdnNBNWN5Um1ySCtKQ1FLM05YNzZvMGM3QWxzZkFteU9rcVFOazVYbUJs?=
 =?utf-8?B?UUdvaG1MQ0l2QU1nOTZXelRoN1VuN09CN1QxQzJFb0MzZEJOZE5XU2RhTStj?=
 =?utf-8?B?OWJQMEpLY1J0Ym9DZ25rKzlkVWlzb3FycWZsVERwd21hOTVEaCs4OXBKQlJ5?=
 =?utf-8?B?VXFWcFAvdTZmTllzWHlzcEd5ZlVSdnFqeUdaSnpOeUFQYU8xQVR0aXlJM20x?=
 =?utf-8?B?c0FENkpUM3hNM0xIVmx1bnk3QnJneDFXdFY0T1VTeFk1eXFWM0J1RTJ4bzRL?=
 =?utf-8?B?SGRsZW52TXU4dVd6aGVnV3FOWVB5aS9ZL1NzUnR6OXRiZ3d5MDlRMjVyQ05L?=
 =?utf-8?B?aGpMaXN2R0N3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2NrNGh1MDB1UFIxOTJaSWRqVUpiOUZENi9qaEpYOHkybW1LYlQvV3NtVkhJ?=
 =?utf-8?B?UDJRL1FSMmcyS3Q0SFRqTzFrb1RrZ0FKSkxhb25TL0dEYUhqOGR0U0FHQnVE?=
 =?utf-8?B?bFpuVnowZFV6c0w3Q2I5ZkFUUTBxRFU3eHYycHljbWJhMlZsemVONi9sd3Zk?=
 =?utf-8?B?WnJiSDNvV2NseUtzTlVLZVpwVGlSZWZ1UkZTYU5weUQ0NFhyTm5yWmRVaVBm?=
 =?utf-8?B?bWowZ3Arak1MalYyOTFRRlgrZzlJTngyUW5pbzd1VFZsMXpDUnhRS3V2MUM2?=
 =?utf-8?B?blhyM29zYkNQb1I4R29VYjZwWVh4VlpCdWRBRDFUTklIVm4rYlJaL2M1VkdR?=
 =?utf-8?B?cXhaTWZFckNkL1pTZS9kSzBPa3JyQzJGOG1kR05aRVNNOGJjK3d2VGltaHlq?=
 =?utf-8?B?Ry9Dc2lzRGNpOTRtRFFEV24reUlsSWxVRXFaaXBXSVJzUEY3dkY4dEZIeG5C?=
 =?utf-8?B?cUhiNC9pYmcxdGpjSWJtQ1JFRmZVV2hpV2dUejRaN29ZTGw5REl2ZDdGVlIr?=
 =?utf-8?B?VWRHYTVPeUFzRUxMYTNKSUlQU1l2dDFhMHBydWtOc3diZW14ZFVVOTFRVndw?=
 =?utf-8?B?SFViU0pqZXEyUnZrRWllYkd3QjJjUkgzRmlsRHN6Z3l1cHFDcFhIMVd2dHhY?=
 =?utf-8?B?eGdFTURTWlI4QWlFZDhsTWFlUTUya0VCaEc0OWYvUVhLbXNGQldDWjUxUTVR?=
 =?utf-8?B?QTBWMHJhaHMwZ0dXeWtZWllRV2lnSUJPcjZqR1BDWHNJa1p0aUVSb2F1YkN3?=
 =?utf-8?B?cFdJUVF0bmV1TkFpNm8wZnZJZ3lBdldiSEdLakZqUkg2b25PU1YzN1JOTTRE?=
 =?utf-8?B?Q3RBUXU2K0FpS0F1REY2bG9xWFo4akhOVml5R204RDh2Tmk2VmxhQ09Ya0ZX?=
 =?utf-8?B?NTFndm9ocjZCVm9Pb3FxeVpkbCtaOGwzcTFyNHRyTFpHc2FaaW0yRG5jUmU5?=
 =?utf-8?B?azY2Rnh2VVQ2Q1htaUVPOGVqcVdVZWM3dVNNSnVPaDN4WS9nL0FUL3NHcEx3?=
 =?utf-8?B?b0xCc1pMK2lKMEVNeE9NOW1hcXhMSzNSVkJNZHZCK3FFaWJGaG1WQ0VORzJC?=
 =?utf-8?B?UUR0ZzJzKzQ0VHc4dnRPbk9UWHBmUFlOclp4RXl2RkxoeG9DRE9LMEQvM1p2?=
 =?utf-8?B?NmVWbkgyUmM1cmJ2Y1p0YWxHZitHcDdnMlJvWHpJa2V4RElzL1Fac0RsNkNo?=
 =?utf-8?B?MGxUQjFoeXY0aXdnZ2Erb2ZRUGJadDV1UnlnRS9Ndi9DUWdzd0s0T01maGJO?=
 =?utf-8?B?L1lHSHA4ZDNnTUtUSFBtY1g5Qkc4d2JIbkkwQ1dRaURrdkpkdi9qdGVoclVp?=
 =?utf-8?B?SCs4cFJTSUFFUUZTc1NsSjNvWlFxanhTY2xZWDc0NGVFMFJGRmNsZjdDdUp3?=
 =?utf-8?B?ZVh3VmlFbFdmUzFTL1hGR3VIQ2J5aVQzWEVraEJZNGx0eXhRRkVWMmZhVkVR?=
 =?utf-8?B?b3Y3NWQyWllxdC9odHVVa0I3RVhQYVJTTWJRK3RzYXM1aVdzS2pjdW1HaGJu?=
 =?utf-8?B?eTJaVjZBMndoeGpjM3FMcmYrT0JRU2w1NHcyUEtTTVlMM2FDQ1h1S3h4QlBx?=
 =?utf-8?B?K1Y0SWpNNGxlQWJsSHowYXRHWGRwTDkvSGsxaE05bmo0V0pvNkVOMkZIZTJo?=
 =?utf-8?B?M05CNm5qTmVyOWVLRlhDUGRhU2JRNVBSRldCeGsxaENWODA2ak02c1Y2NTcy?=
 =?utf-8?B?K3EzYnJVekxnVHpKdWJpc242Z2ZnNWRKRnZJakVDd2ZpSmdCa3F0c2lmWS8x?=
 =?utf-8?B?NFh1TXZWZGVJSExqRWRJczMzc2g0VVoxcGE5cVJDSHJCWG5RbzVYL3RmZHho?=
 =?utf-8?B?SXE0d0FITisrbDBTNjhTOUhXVDJXY2FOMW1XR3ZhRlNZektva0E2ZmVqdStF?=
 =?utf-8?B?cHYrKy9Bc2NBT1JQZlQzRzNBblNZZHZZMnVJVmdzTHFxN0wrYVVQQnVpSFAw?=
 =?utf-8?B?eDlsdkNxV3VKRDFZR0NRaEd1Q240TnpCY3RuRjlSV1BiWVFzYThwQ1k3ZlVs?=
 =?utf-8?B?c3VIS09wQ3BwZDg5YWhFYXdDN3Bjby9qMWdLMkVQc280OGg5TzZNNHpzY0hw?=
 =?utf-8?B?YXJ0Z01GQWNIZ0JzSlEvN0k0TFp6MnBtSEZlZGd1UlcxcVlsM0NOUHR6VGtp?=
 =?utf-8?Q?mQmHJUKER/Exq22Erwte1NrAp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c87dce-5d55-4781-dd30-08de2ce786c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 12:30:04.2653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kq7nFSdTSbNfaxZ6aRv6E7vfvJkDfodslyMaQoQ5UhwoDU9vPcD92j7mJOUnmOQulwEkEl5uhmAdHqCXjd4cdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10247

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBLbGVpbmUtQnVk
ZGUgPG1rbEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAyNiwg
MjAyNSA4OjE4IFBNDQo+IFRvOiBDYXJsb3MgU29uZyA8Y2FybG9zLnNvbmdAbnhwLmNvbT4NCj4g
Q2M6IGJyb29uaWVAa2VybmVsLm9yZzsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBoYXdu
Z3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRy
b25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBsaW51eC1zcGlAdmdlci5rZXJuZWwub3Jn
OyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVF0gUmU6
IFtQQVRDSCA2LzZdIHNwaTogaW14OiBlbmFibGUgRE1BIG1vZGUgZm9yIHRhcmdldCBvcGVyYXRp
b24NCj4gDQo+IE9uIDI1LjExLjIwMjUgMTg6MDY6MTgsIENhcmxvcyBTb25nIHdyb3RlOg0KPiA+
IEBAIC0xODk1LDEwICsxOTIwLDE2IEBAIHN0YXRpYyBpbnQgc3BpX2lteF9kbWFfcGFja2FnZV90
cmFuc2ZlcihzdHJ1Y3QNCj4gPiBzcGlfaW14X2RhdGEgKnNwaV9pbXgsICBzdGF0aWMgaW50IHNw
aV9pbXhfZG1hX3RyYW5zZmVyKHN0cnVjdCBzcGlfaW14X2RhdGENCj4gKnNwaV9pbXgsDQo+ID4g
IAkJCQlzdHJ1Y3Qgc3BpX3RyYW5zZmVyICp0cmFuc2ZlcikNCj4gPiAgew0KPiA+IC0JYm9vbCB3
b3JkX2RlbGF5ID0gdHJhbnNmZXItPndvcmRfZGVsYXkudmFsdWUgIT0gMDsNCj4gPiArCWJvb2wg
d29yZF9kZWxheSA9IHRyYW5zZmVyLT53b3JkX2RlbGF5LnZhbHVlICE9IDAgJiYNCj4gPiArIXNw
aV9pbXgtPnRhcmdldF9tb2RlOw0KPiA+ICAJaW50IHJldDsNCj4gPiAgCWludCBpOw0KPiA+DQo+
ID4gKwlpZiAodHJhbnNmZXItPmxlbiA+IE1YNTNfTUFYX1RSQU5TRkVSX0JZVEVTICYmDQo+IHNw
aV9pbXgtPnRhcmdldF9tb2RlKSB7DQo+ID4gKwkJZGV2X2VycihzcGlfaW14LT5kZXYsICJUcmFu
c2FjdGlvbiB0b28gYmlnLCBtYXggc2l6ZSBpcyAlZCBieXRlc1xuIiwNCj4gPiArCQkJTVg1M19N
QVhfVFJBTlNGRVJfQllURVMpOw0KPiA+ICsJCXJldHVybiAtRU1TR1NJWkU7DQo+ID4gKwl9DQo+
IA0KPiBJZiB0aGVyZSBpcyB0aGlzIGxpbWl0YXRpb24sIHRoaXMgY2hlY2sgc2hvdWxkIGdvIGlu
dG8gc3BpX2lteF9jYW5fZG1hKCkuDQo+IA0KDQpZZXMuIEkgY2FuIGRvIHRoaXMgaW4gVjIuDQo+
DQoNCiBNYXJjDQo+IA0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICB8
IE1hcmMgS2xlaW5lLUJ1ZGRlICAgICAgICAgIHwNCj4gRW1iZWRkZWQgTGludXggICAgICAgICAg
ICAgICAgICAgfCBodHRwczovL3d3dy5wZW5ndXRyb25peC5kZSB8DQo+IFZlcnRyZXR1bmcgTsO8
cm5iZXJnICAgICAgICAgICAgICB8IFBob25lOiArNDktNTEyMS0yMDY5MTctMTI5IHwNCj4gQW10
c2dlcmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2ODYgfCBGYXg6ICAgKzQ5LTUxMjEtMjA2OTE3LTkg
ICB8DQo=

