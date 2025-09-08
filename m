Return-Path: <linux-spi+bounces-9938-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E18AB4846E
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 08:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C15F18981EF
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 06:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9D32DE71C;
	Mon,  8 Sep 2025 06:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SOMBIatR"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C427292B44;
	Mon,  8 Sep 2025 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757314200; cv=fail; b=tqfYbkPnmxTjPwozWI4NPYNLhM5XgHrzAOrHbqmG9N4U3dM5BqhgQHfRYSSoo1L5yEEQ3ryPOQmFtK5q9mylhB7Ru9MIkCbdD6cD6y/25SUd472didTvYsEpUDuUvD4Bjgj2OIGv3fDf2t2f7PNda27xYAVdEmA7vFnKrvjWHaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757314200; c=relaxed/simple;
	bh=O23kWbhOjpEJvmDT6TaIcqQ5oRCD0RYm6dqpHqz5Rz8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HScvYPmEO4uZwhUpvVRiYayPtzOA2pZbHVUTrYgnY+4ziNIcJW5s7sBCdiF+NEwx4JxKR4iWCL4+gwb1yyCVbqInXVQp6MCatigv8H4Qq6guLCreF8ZsKRvC07CPqUqbhOU+P5gJ45qNBbuEmqCckxhrV5MrRTNMG9IuAgLvAYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SOMBIatR; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZadAMu2nTv7454Z15dEnthOWCVfgqYJqthRzhuDYwDfQpRu/U6g7E6vHiCQ+geeA+puaQr8nTbTpLjhaijPNigNTZxre5y1P0MvMPNOsXgfDdEMko2shcwy4VyPW8bE17XKr1S1Q/WeXbPBi3E37zxPeRUVixpJGLiCbIiwcJ0Gs3CFCRjNHu1cyqEjPT+avKFlb9Hc0Ei7fpUp2Pzgrw66QcUXSyo/CpFEA+16+rH7c6EpQBL3K+YmEvAR/w3pB3l847GqSC7mQ2su18KBShXiRqq2pB9hRN1HA/d7ruOjOnodnfq6KZz3gMEnP/RpY3RXFqUKj31tSMiNz6chK1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O23kWbhOjpEJvmDT6TaIcqQ5oRCD0RYm6dqpHqz5Rz8=;
 b=MyWIMvPbxmcBDGBB8+aOYtgVVX6Yo1nQNMLsw/Ow4FPN7Gv5t2rff8kD/20jfAf0kSLsWSYlnuKRKcxUbd+SL9+A/57u+5bCNOm96iXgisgJpzNbDPHwOSWKTaWC4baj1lngZETMtnJiHyTc9DXNiG19pb7tPIBn/lAxizqDNTEu85YtmxC+ISDmdA+tc5+aNDNzNrGubtd3BaFWq2NLguZb0brhDYjj6ieHkLmCBMWvOJEjy8UPGOqhimnnzz4i5UUjltn5ZevSt3+7IVs7JmTvGlU/4N6gE/aWtr8uHyIXI0gz7bKyKLZCnIdYR1ibD8rCLMj+Pl8YpbKevLFUJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O23kWbhOjpEJvmDT6TaIcqQ5oRCD0RYm6dqpHqz5Rz8=;
 b=SOMBIatRkTEQn02HnXAWg1/AcePOt85y9BncPpGfNTmdBDaYTvSDSvJSjymOa08kQdMVF2/+t9pN37f8+UKS+yMTLPv81zS85DYjdvsjYonCNGIyqmmdQIJygVD5zO2sYSCruqP1YJPCjrNUcRo4HCCWCsWMWJCuhTf/Xompc2H+xkRW/mdD4uyndN1zw7w5DNAMH3+t/zkgivM74gDqCC4C79DbzdFjKOuIdTgY6wbNDu08Dzgv1ie0OZ2YwxVFm4yuC2pLMj/HgRwXuLOQ6lUNtGYqixX5WWdlw3hJJDkl7p3eNSbx1PehJFfnP34jnBC32ZDvorCozy3tyEOkxQ==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by SJ2PR11MB8449.namprd11.prod.outlook.com (2603:10b6:a03:56f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 06:49:56 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%2]) with mapi id 15.20.9073.026; Mon, 8 Sep 2025
 06:49:55 +0000
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
Thread-Index: AQHcG83VB9LmjLEhZku8WJRHpUcCBrR/noIAgAkRfQCAAC+ngIAAAlEA
Date: Mon, 8 Sep 2025 06:49:55 +0000
Message-ID: <4d7274aa-c151-4ced-b871-bdcdf6451b87@microchip.com>
References: <20250902-microchip-qspi-v1-0-37af59a0406a@microchip.com>
 <20250902-microchip-qspi-v1-1-37af59a0406a@microchip.com>
 <20250902-bulky-chachalaca-of-superiority-d5caaf@kuoka>
 <a9968230-33af-432a-a5da-3d40b6f5d85a@microchip.com>
 <77ad8686-3ce4-4a6d-8a8c-c61d86cb7474@kernel.org>
In-Reply-To: <77ad8686-3ce4-4a6d-8a8c-c61d86cb7474@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|SJ2PR11MB8449:EE_
x-ms-office365-filtering-correlation-id: bd64cca2-be68-42df-aec2-08ddeea3ebc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d0lwVTBESW1xQ3lpclNCci9FZElNbjZ4ak9wVmxmbTF5UDlOQ1VUZ0k1MXZ2?=
 =?utf-8?B?bU1qL1JFOFV3UnczamVwYjIzWDU2NFZONGNmMlNvaVh1WHhodmJ5TWxnbmx3?=
 =?utf-8?B?by9JdVpUSmlvOThTekFRNTI0NVA3SVgzTWRrUnV3SGI0TTBDc2JVWXo4VHMy?=
 =?utf-8?B?RHd5S081MVlLMEZBbndJRTg5bE9DRGgzMVplV1NBY1hTNW1FVXMraUZHZmJm?=
 =?utf-8?B?RFlhNUtQVjloV0dEYThpZU9BajZMQlVlRVdraVNtcFBTNm1TRGJINXBzQUt1?=
 =?utf-8?B?dnVUOHBhYnFLNDJURW5sMEo2WmlHNlRWT3lxMHgrQVNoQkhxNkdCbG9NRkJs?=
 =?utf-8?B?Z1BvSVRXWWJBZmF6bXdSZ0JTbmRlMTRWUXpVODRXS2RDUXJpSEpCZFlCMW43?=
 =?utf-8?B?TjR4QzlCRW9hcEE1elJ2RlBlN0RUaGFPbkdtVUg0dzJCUzNoT2ttZ2ZHUmNj?=
 =?utf-8?B?azIwUFIxcVhlVXFBUFFQRFpuaTFYODRSV0lhUWtpZFlvY3MzTzc5NVpsRFNk?=
 =?utf-8?B?c2xVZi9neVRQWDJ3WDRoWnhTNHdOcW4xVVBtaGpvdVF3dVpyY0ZUOWxMMm04?=
 =?utf-8?B?QmRUQ2wvMzUzZ04xdDBldjErOVIxZEhodXd2OXZCMit2MW9SSlRJQnFxK2xa?=
 =?utf-8?B?MTh0cFdxNGVFZ0wyN3lhZmNmT3d4MWtNTFVJWXVxREdaRGwxWE03eVRaOFBN?=
 =?utf-8?B?Rkg1cUVySG0zdytjZEVSRDUzUkN3SUdIUzgvUmJ1TnY1MDBXa1I4Nng4SmNY?=
 =?utf-8?B?RmVaTHFsV2hWRk53VGxlWmlQSDJDYTF5RzRDZ2M2NThNK2NkYkFZNE1jZWFB?=
 =?utf-8?B?R1kzVjlDOUhPU0QraTYrVlFUZm5GL1NOT2Nwb0lrSWdGNUludXNITUcrdjFk?=
 =?utf-8?B?MWQzRFMvQTFHZzBPdWpIQWptY3RqMUpIdDR5VjNkdHdoekQwS0krd2pLOUhT?=
 =?utf-8?B?SDdOYVREWkc5cVducG5PaS91Y0FaSHJLVzVtZmtWNHhoK2ZJUlNoeXpoZkgy?=
 =?utf-8?B?ejlSVVBwWXhpejdnTVhvVHhqZHFXOGk4MWZ3c2EwTmhtTk5lZkFvZlhxcnIv?=
 =?utf-8?B?bWZnS2Zia2JqdTZhb2U5cU5MQmpHMXVyS01aTzBydWRoWG5lNzFONUtoRHAx?=
 =?utf-8?B?NGlqNEdFRmcwMEtERjlWZ0hmU1JEQkNPRjF0YnNMd0dCek11cFlKcC83c0xo?=
 =?utf-8?B?NmhyejR4ZEJoT0IyTzNEOXJmTXMxdXorNU96WktFYzF5eXRPYXNLcVJmYm83?=
 =?utf-8?B?NXJGN3FySDByOHB6UXl2R3Fid29vdElsRlorYU5YOWpPdVFtc3B1WHRYY0VT?=
 =?utf-8?B?RkUxcExqZG9xR0tUSjAzRnhKVVR2VnY1QjMyU2RWWjZncEtxbEpKSXYwVEpZ?=
 =?utf-8?B?dlE3VmlPaWxCcWNqTVRWNVh5dnEyU2pHVWpJeWk0c3IrclU1ZWtaMEhuVks2?=
 =?utf-8?B?ZUYxbTNjMnZIanV1V2JpeWFqd0RlVTRDSVcyaGZBb3p3cG0wMVQ2L1ByYlJD?=
 =?utf-8?B?WWoydlBxdGJSTi9ibVRQUklZREZqR3dFTEZCbVFaYXlOTTdlRDlseUpzdWdF?=
 =?utf-8?B?dENaUURiaGtUeGpvQjkzRjVYMTJZOVFZeDhMV0RoT2dlcnVqdWgwUHE2MjVw?=
 =?utf-8?B?c2RUaVY4dWRTeWwrajY3dlkrVnRxZFhPeEU2c0s1NVJwTXYrRGo0UFZTTk42?=
 =?utf-8?B?ZWZvK0trOXdrYi9vVmtrYXJUVUIvSGJMZENIY3BzMWxxbVJybDZRcG9RcEpz?=
 =?utf-8?B?YytURlZYNVlYRnJ6c3lTSHZwUEVRL2lvYS95MXl2NnpqYWJFb1BWU0RpRG5z?=
 =?utf-8?B?ejFmdUk3ekE2SEFwcUNLMEYwenFBbWVlTExjUEg3NGJHUU5QN2o0ZEMzZlFu?=
 =?utf-8?B?bmtxRFk0UE80Y1NsL2xuc0FvaGN5TVdjaEplL0FnUWdSalhoKzAyL3pJSmVR?=
 =?utf-8?B?bHB0QXloenZFb3VwWE9zR2RTeEF4T3ZPM2VGN3BhNG9sQXhUZllaRStzamlK?=
 =?utf-8?B?QWtHdlNPd053PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXljRGZyS3J5MVpudUozTzVlb1lBdi9uY3RnZGhvQzBxL1dtQlRSTUFGRDln?=
 =?utf-8?B?eEZVY0xEOXFpZWJIU2d1QkJKZmNtQTBtMlV6cWMrMDQ2QW5mdGtDd3hCRkJ4?=
 =?utf-8?B?ZHpjMGc5VTd3a3FhaDN6VUZYK2hKK0VSVEJWWHJITlhMVm9vbnowcStxQzhm?=
 =?utf-8?B?S09xSlVVbE5IQ3BiSzBiTDAzTEJxNFJLWEkwYUpXOTB5RTNFTmhjUGY0LzNJ?=
 =?utf-8?B?U1hkd1VnaEpvZ2FCam1lSFBtSGxZTjRpbDY1UWZKaWsrcWk3MHhkdUllbDFB?=
 =?utf-8?B?S1VwQ1ZiMFNLVFl6c3FQMjFwdEZaRHVkYk1OMC83czVrdkIxNHpyRm1hM3N4?=
 =?utf-8?B?dVZaSGhQWUFKQiszMmpkK1I1bHMvYTBld1RSQW81NDNWRUYzYzV4U0plWHda?=
 =?utf-8?B?VE1EUWVSRHFOZ3E5UEV1N0pkZXh4Qi91K1VMZ2w0dmNJNHdYOHdSeTU5SGVo?=
 =?utf-8?B?QnVpVE9pL2Jzajl1NzlsU2RwK2UrS3YvamFxTi9ZMXZtMGJ3NEtYVnk3ZTVa?=
 =?utf-8?B?NXlSbm4xZjdpbmQ5ejFNRUxYRW9ybVMzOGh4NElhcGtiWlMyelZNZVY2TmxP?=
 =?utf-8?B?QUZ1alJ3ck9zZnR1TVRFamdVWWo1dVBqaFgwZGdDN0N3ZkdrQ1pMdzIzQ1Vu?=
 =?utf-8?B?T1l5N1BUYlV2L2lJY0lxZHdTYWZlSFRaWjJqN0hteUhjTkFQQ2FPcndHempG?=
 =?utf-8?B?OTlEOXgwREpNcEpDUjFmS3E4akFKR0tEbmJpT2pRdFNWcXJDaVdsMWxPU0l1?=
 =?utf-8?B?d0xTU3QwRE82bGJkdjNHUlhvOGorbUZEalFlS1gvZEJZWjZoWFdmSU41dDhw?=
 =?utf-8?B?elRORVdlU042TWxvSno0TkwwUE5lamt0VDNNQ0hLU3dyckpUSmQ5cnQrSVgv?=
 =?utf-8?B?dmNTYm9QV2JKSk4wZnhUVWVCRnUzNVRPY3duYzZSVmRyTUlUZHROTyswWEQr?=
 =?utf-8?B?YmFMbFpCMDJLaWRWMVdaR2tmSEVTdTRzeHdYTnhMbUlmL0xPRzBDeS9qYnRQ?=
 =?utf-8?B?YnMxVEZkS2ZJOWo0U1VVbEJOd0FhWmx0K2o1MFkxdjB3OGpQblN3N0lxUFMw?=
 =?utf-8?B?OHBjN1BDL3E4TUdTT25DaE44aVNkQjV5emtNSG54bFRHdkxsQ3pZM01jajNK?=
 =?utf-8?B?NFNyZGFnbjI0TXFhbFRUbkR4WC9GMkF3bkRQdkxsR1JiSzN3RmlzWjFFRUo3?=
 =?utf-8?B?dHQvUWhwVisyQWhpbXVxZGVBaHhIc0diUkFnK3FZYjR0MWdZOUo5UEo1T1Mw?=
 =?utf-8?B?eVdnS28rUm44YS8zRXBkN0dHM2pudmlndEY0VXhDQm5yUlVIVWFCeHJQT2Rz?=
 =?utf-8?B?cytTTkE3TUN0dThUV2R1SnNpcWEwSVQ4LzlwTGc4Um9BL25haTU4elJOWVZx?=
 =?utf-8?B?ZnFrajFHS21DZkE2L3BTK3o2WlNPRlRPQ3NkQ09HYnI3N0VhUk9CWXlrdy80?=
 =?utf-8?B?ci8xdmhpRUhMRGtYYXo1VDJLOXJ3bmM0dFdTQWJHRGFJTDBuT3JzNTJmV1JD?=
 =?utf-8?B?RDR3VTZKOWdNQm1jaGtmeHZBdHByUFFhSytpaDRBZjg4VFk5eEdpMGpMUXJO?=
 =?utf-8?B?TEVoa09UY2JnUDFSR2czMUJuTUF6OE9OekNnaURackR2VldsVDQxNkxyZHNx?=
 =?utf-8?B?Q0Rzb00zd3RsdmQ5Rmx3NGNOaDZ1dXRRTnhlK1RXTVVDOG5EckoxYkpSR25G?=
 =?utf-8?B?dHVmcm5VR25lRTRvTXZvaU8rQWpzQjdsM3c4bUpBdVhobE41ZE9PZ1VUc0F3?=
 =?utf-8?B?bEtPeThmRlpxQXpRZ05MeDkzK0FPN1M4VGRYTXdWSENzdStLM1lsbXlkR0Qr?=
 =?utf-8?B?dmwxVjdsNEs4WU96YjhPMElHTGpyMytaMk02NGVFUkduTjliOXZPcFhoQTVX?=
 =?utf-8?B?Q0hSdUlBSDV1RSt2SjloOTdDcXdGSWtXNE1VVzRGclRqd01VNW5ZdTlYS1l6?=
 =?utf-8?B?ZkwzZ2VuQ2d2OFlWOUhwM2lvRE96a295SERGNVBadm9rVHRBNHQzQjUxSzM0?=
 =?utf-8?B?dUxQb0orSTdIU3FYblYxb0dIc0VVdEVUMW1Pa0huWkVxd1dkL3NFRnU3ZCtK?=
 =?utf-8?B?cER6WjMwNW8vUEVMeGNOL2pFRzNhZ2JrcnhVa21kQ1Z6SEU4MTQ2OEZQUm0r?=
 =?utf-8?Q?fiCNcTEjqcrBAS3vA0ja0Eh8V?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64E9F4D5E6E15E488A60B1158B20A8E6@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bd64cca2-be68-42df-aec2-08ddeea3ebc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 06:49:55.8918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8jPnbVjv+7pYHg4i8auXt3uVWRjypLwfiQwOX6EVNFWNiyL9jzmX17jFkW7OhxHNyzl7uI07FHVA71Ys3tOXVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8449

T24gMDgvMDkvMjUgMTI6MTEgcG0sIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IEVYVEVS
TkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMDgvMDkvMjAyNSAwNTo1MSwg
RGhhcm1hLkJAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IEkgdGhpbmsgdGhlIG1haW50YWluZXIg
dGhhdCBtZXJnZWQgdGhlc2UgY29tbWl0cyBtaXNzZWQgcmV2aWV3aW5nDQo+PiBzdWJqZWN0IHBy
ZWZpeC4NCj4+DQo+PiBhbmQgSSBzZWUgYSBtaXggb2YNCj4+DQo+PiBzcGk6IGR0LWJpbmRpbmdz
Og0KPj4gZHQtYmluZGluZ3M6IHNwaToNCj4+IGR0LWJpbmRpbmdzOg0KPj4NCj4+IHByZWZpeGVz
IGZvciB0aGlzIGRpci4NCj4+DQo+PiBJIHdpbGwgdXNlICJkdC1iaW5kaW5nczogc3BpOiIuDQo+
IA0KPiBEaWQgeW91IGV2ZW4gYm90aGVyIHRvIHJlYWQgdGhlIGRvY3MgSSBwb2ludGVkIHRvPw0K
DQpTb3JyeSwgSSBtaXNzZWQgaXQuLg0KDQpGZXcgc3Vic3lzdGVtcywgbGlrZSBBU29DLCBtZWRp
YSwgcmVndWxhdG9ycyBhbmQgU1BJLCBleHBlY3QgcmV2ZXJzZSANCm9yZGVyIG9mIHRoZSBwcmVm
aXhlczoNCg0KIjxiaW5kaW5nIGRpcj46IGR0LWJpbmRpbmdzOiAuLi4iDQoNCnNob3VsZCB1c2Ug
c3BpOiBkdC1iaW5kaW5nczphZGQgc2FtOXg3IFFTUEkgKHNob3VsZCBkcm9wIGRvY3VtZW50IGFz
IHdlbGwpDQoNCiJUaGUgODAgY2hhcmFjdGVycyBvZiB0aGUgc3ViamVjdCBhcmUgcHJlY2lvdXMu
IEl0IGlzIHJlY29tbWVuZGVkIHRvIG5vdCANCnVzZSDigJxEb2N1bWVudGF0aW9u4oCdLCDigJxk
b2PigJ0gb3Ig4oCcWUFNTOKAnSBiZWNhdXNlIHRoYXQgaXMgaW1wbGllZC4iDQoNCj4gDQo+IEJl
c3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg0KLS0gDQpXaXRoIEJlc3QgUmVnYXJkcywNCkRo
YXJtYSBCLg0K

