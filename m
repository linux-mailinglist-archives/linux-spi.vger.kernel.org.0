Return-Path: <linux-spi+bounces-9283-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234A9B1ACE2
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 05:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 793407AD6EF
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 03:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B63872615;
	Tue,  5 Aug 2025 03:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nA8RTmRl"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0551DFF0;
	Tue,  5 Aug 2025 03:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754365695; cv=fail; b=WDbwp1qdKJFNmoeVQlMI2ULGHINYHZ3UjUh/NzK/beF4jwYnPd0ckw595aLp9j8JgBY1KBKKCypjQLYgWWo23XSkSX+h4eUe9+rYZ2igOXsIxFk4WtVvteYWdehpAj5jdxC6XPMaFd8Sj2JXTcTOQ2pK37xhRdOFI+lFD/2PM9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754365695; c=relaxed/simple;
	bh=ssRAnemq6tUjzUk2bN+d9O9CHfb2RmDDyqcyF1BJZuE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sWgL4J/phB2gFN1hmBDCGIx0S43saL/VoMwAy9iteRzYmVg1cTiKsn4+k2d84qMajU2SH09qpv9fIVnmWdlt9tXIh4aog4bmvHiwfMV4T71fEvM7NgqAW/v/8jtqqf9bBcGz65FXimELiJpf9+E6jwXmrsxGaPPbIg6Pbpnk4g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nA8RTmRl; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7EWeOYBoGO2W5kN0lGF2oMEckjwZ0ikAMmCXWWGG7+KZXqgS8MA551krkYBjP5NoKwnS+PcTqoTNH+cOkkmA0Td5Zo0z5zbDIgRPRneW6KLTW98QlBqTof8dRviui0K/hUxgeJe/LcJ90r6g9j698pjbU7U/iVOQiDbYmQmEj8C7sjqmNyEsfabf5LNt41A0uGZmRyrktNOYqVl0M01pYIeVgc5i2XPat+Y3nKIfAAy3xn68GaKOXhiGdQqYcqKu232DbxvLjramTfkkKmsNMBFhTctyAeyOZ1PyxWSLpiwBMX0uZ5fVPKZCZ5GH1vvYIarExwdRMA66HYXji0qvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssRAnemq6tUjzUk2bN+d9O9CHfb2RmDDyqcyF1BJZuE=;
 b=lJaD6HAunFO9gtiHUcYwVX/2P0BC/0taRKDgyNL+Kur+jRTUFmV/A8dOxroYQemjtKNDbvvcGEEbj1Ff52tZwTqENgbj+hU1dIXZEGkrEQKPrN/KUhTdlOH6P8xjpkoZqtFtjIl3nvqKdCs79HhIFf18dJhdCd9oLkauxrYU3A2KD/I/EpcoyXRmVczU+uH/qusetzCb+l8GMoDZJ/wzAgI8RbpfwKEqax0IhHRuDlXh7ZvTNSlCoIuohsQ9vvTgFQm1vMl8aC6RTUNyKoo1+Evq9HEFKiiilsGfnHt4B+PECiYvW00RCFycOK6yIBNDt/8dxU/9/bpbIrnf8fMPeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssRAnemq6tUjzUk2bN+d9O9CHfb2RmDDyqcyF1BJZuE=;
 b=nA8RTmRlKa3TUHBisVWfZJrzLMp2UhFi/Fq/8n4JGeUy2tHYZyG7KfPHx9xSSaU0h3wg1natFm6IlPf4edVHwgjLRpLp9RdkjSksDdNe93iEe65yY313RCGXHLKaEU8xRY5ybvzcG8ntvRt6Zy6P8eq/Z8B8GBuStSed42mdlHEGYUEk9NRxqbPViNF8FWvhMXIqEg6cSUNyL8n5OTLXwaOOp2MqP17EcD5waL0s+wc4SOex+zdvn+vdW9j4LSISLmX/wrarfA5XrliPucPMNaR49d/fVAdmWqK0dUMPp+ZHsokWSqGKLnLtYtjgXHyKqZUFwVdtokqSmEGBcuph0w==
Received: from DM3PPF9623118BD.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f3a) by CH3PR11MB7724.namprd11.prod.outlook.com
 (2603:10b6:610:123::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 03:48:09 +0000
Received: from DM3PPF9623118BD.namprd11.prod.outlook.com
 ([fe80::6ca6:1077:eb18:728d]) by DM3PPF9623118BD.namprd11.prod.outlook.com
 ([fe80::6ca6:1077:eb18:728d%6]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 03:48:07 +0000
From: <Manikandan.M@microchip.com>
To: <krzk@kernel.org>, <broonie@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<Ryan.Wanner@microchip.com>, <tudor.ambarus@linaro.org>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] spi: dt-bindings: atmel,at91rm9200-spi: Add
 support for optional 'spi_gclk' clock
Thread-Topic: [PATCH v2 2/3] spi: dt-bindings: atmel,at91rm9200-spi: Add
 support for optional 'spi_gclk' clock
Thread-Index: AQHcATo0qpdsN9N6RkuKfC724ixwULRKha2AgAKi7QCAAF6GgIAF7ewA
Date: Tue, 5 Aug 2025 03:48:07 +0000
Message-ID: <534227b2-f990-4160-8321-7fa8eb1b373a@microchip.com>
References: <20250730101015.323964-1-manikandan.m@microchip.com>
 <20250730101015.323964-2-manikandan.m@microchip.com>
 <c1230d31-cb7e-4a21-b7d0-ea32d862823f@kernel.org>
 <691cfc11-3804-4f7d-b535-ea25f86c0c16@microchip.com>
 <967dafd1-a1e7-41be-a194-aa7c9f6f7e8c@kernel.org>
In-Reply-To: <967dafd1-a1e7-41be-a194-aa7c9f6f7e8c@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF9623118BD:EE_|CH3PR11MB7724:EE_
x-ms-office365-filtering-correlation-id: 81791c05-9175-4854-5236-08ddd3d2e3f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?eTE4Q0pHck9UZ1UvUTNmRXY0MFc2VXYxZW80MGFxWkMvK05jR3VBTzc4d005?=
 =?utf-8?B?b3lLMndhZVVUVjBLaFQrbEEydkVsTnJRNlZZd3NYbWJRNFhDTHlQZXk1cE85?=
 =?utf-8?B?UHB5TkRTcUxoZy80cXVpZFVQTm5SVW5Wa0N5cWlZZ2ZrMXhWbitDK2NJUUsx?=
 =?utf-8?B?SXpYaUVEUzNUbnJRSnhWL25BMEw3ek5zdWdCS2EvYU8xSnVkQmdkUTlxemdG?=
 =?utf-8?B?c1YzSDRKb1hPRktrZWJLSDNBWmVrck9JNnN5b1RZYjhCOEs3U1VTRGNoY0Jn?=
 =?utf-8?B?enR5N1QyOTBiQklXVjJ4KzRxNlZOcGVhMC8rRTNNQ05QREszclN0MStjektp?=
 =?utf-8?B?R2Q0TnVNL29saDFwZ1JpbVF1MlZDSWtLcU00T0lwMi9sWXQyZXc4dzUwdGI4?=
 =?utf-8?B?NlR2Y1dKd1FHREs2UlRJWHdXTEhSeW50QlN3QjRDRDM3NnNvM2JMQjJuVUpY?=
 =?utf-8?B?c0dFaFBJWE9SNndvQklDWWpraTVtdkoxMHhMbFhlUHlydUwyMkxxd2hqZFgv?=
 =?utf-8?B?R2t5eG1lTUdVRHp4c0NoSFZRdXJlbWVmd1puU3Z4UlBQcnZ5ZDdmdmFHZSsw?=
 =?utf-8?B?WThsZVNyNzRDTmFMVHFEdlhEWFdHUHc2N0R4b3Q1WVpIVXczWUQzWSszeHZl?=
 =?utf-8?B?ZEwyc3FING9xTEtqcEcyZzVHTFJaVnFua29MRFdSM0NRTDhHQU12YzdzdldD?=
 =?utf-8?B?YmtJamd6VjdqVEJQYVhvQ2JXbVgrZGNNamZqNmFSN3FSNmZicUlaTUszRVc5?=
 =?utf-8?B?R2JpZk04ZDljbmFrZVM4VlMwSGk0bm1FSElaK1dtVlhMTVlyYjhaUGp1bTVK?=
 =?utf-8?B?enUrcXdBQnpUdW43Z3dGQkx2SzZLU2lCYngwR2M2dTJicUg2UlhaYUIrdklC?=
 =?utf-8?B?UzJ5dkdPUndVYjF0SDZTNmtUS1RGUDNQbU41ZWpQTXRNbUM5MFFyUEZwdXZD?=
 =?utf-8?B?WXN6Qmd2Z3pYRUdVM0xZR3BNd2FLcVVybVRIKzRmM0hGU3JsL0cvWUxpOEVI?=
 =?utf-8?B?aGZDVktldmE3L0RrUTN3QVZ1blU5ekhYMXlkejZXL0V3MDdBclpVSGcwWWdP?=
 =?utf-8?B?NVlPSzl1NENWM241clJuaitpeE5wU2ZrZFJiazNMNmRlUGNjREpFVTZuQ3BD?=
 =?utf-8?B?eVRkbi93djZ5dUt5WFM4dmhsaHJUSS9McHJ5dmVJaEUyT3FYNkRQdm9PQ0Vr?=
 =?utf-8?B?eVZ4V251eWVWY2prOXdGVUNNMHU2UEpkUTJGOEpuODFqa0xmWDIrS0lVcmVm?=
 =?utf-8?B?RWFTQTE1Myt2Z2xhWXZNYjdwUWtmaGRkTWVKQ2FoSFhOWGtwMnl4R1NUOVZU?=
 =?utf-8?B?ZlhEaFBHaTdwNkdLQmFWNEloZ3NYcnBxd0NpWXlabm94dVlZd0JzWnpFb3N6?=
 =?utf-8?B?Ym9GNit3RFRGM2xEdk9ybDAxekJSMWhnd09PdEhhdHg0MHlHSGRhVkVUYWNn?=
 =?utf-8?B?dGcwdHBLUW4wbVVoaE5SNWtRWlJDSFRVWVB0d01QQ0lpYVJXWGM0eVZvU0gy?=
 =?utf-8?B?N3BtS0hIM2twVzlaSCtMRkFJbTJKcEJlTnMxVzJEYitUQ2hqZGtrVVhhbDMy?=
 =?utf-8?B?ZFcwaWxZS2ZiZEtub21vSkVWOEhVaEpEMlBDSEhhRTlSejJqbTd4WkFDMGps?=
 =?utf-8?B?b05GR1dqR0xZYW1qQldHNDJ6TmlCbEo0ZzZWNlBLWDlIQlRSb2pyUmsxSE5C?=
 =?utf-8?B?SzdwQWt4WnhOQUk0Wnh2NzBlakhnUTNCaHZnWlRwTzFLd2Z5TG96aHhidGlo?=
 =?utf-8?B?a1BzN211RGtPRXhpdmZDcEk4RDhpYUJuN2FJeVhjR2Nnc2o1NVZXYmxoMWFv?=
 =?utf-8?B?WXVXeHZEODZwYXZUWjBQN1M5am5RcjVzK1RxR1V5Q0JnYjAyRGZrelVKUzRk?=
 =?utf-8?B?WFJSN1BJUjdGdVNvTUo3ZHRiaXVheS9HdVd6VEgweTJWbzBRV2VlSHl4MVJ6?=
 =?utf-8?B?b3dFbW1rOXFtTmtXNXRha0dqQndvbUZiaDFJN2NGR1hTcGtiYktmQndRWXEr?=
 =?utf-8?Q?RGyNoECgq6xUF1WshZO5mGIR1bO88A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF9623118BD.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXNuQmIxR2RvZGt5anVjem9WbS9ZRndpR2pFcTZxRHdORzA4cjVtWklKdHY3?=
 =?utf-8?B?cjE2YmFPd2x3OWhRaFJieHM3TFNPd3JGc0tjQ2swM2Y0L3FZYmY2NkEwTktr?=
 =?utf-8?B?cE9iTXZZK2N3L0lqbHdwZHRNUjEyQjRySkpwV1RQcFdrUjBiTHIzUlhrWTRC?=
 =?utf-8?B?dlBBSFgwazVXRVIybm41Rkw3ZGt1ak1tM0xqN0xxWnl1Z1pvUGcvd3haTXRp?=
 =?utf-8?B?Y2NQTlJWVUhYNkI5dnYxTDY4dUQrZGd2RkpoTkZyMTBHTEo0cjFzNU5xMWJY?=
 =?utf-8?B?RE1qQUhicXAyVUlRSzVJcDdjQzdXT1Q1REFSRk1LTE1meUpuU0VXbFN5bmsr?=
 =?utf-8?B?ZFJKcU10Z3ZMbm92OGc5dFVkeFNZOTRTM0dQdXRGRmJjNGxaak1sUkJLZUt4?=
 =?utf-8?B?VGVidFFzQ3FCKzByeG9SMmtRUmNaWkVYVlU0OUdiN3JpV3RRSENDaEI5N0px?=
 =?utf-8?B?U3NlWFAzUUEvWUJiRENhb2xpaWdqZWNYLy9BMVdIVWFOOTBRbU5oclByL1dU?=
 =?utf-8?B?OVcySExSN2pPTk1SVm1obHA2a3NvRVh5NEFxSllsRzdlWjd6TDEycFlNRUFC?=
 =?utf-8?B?em84V241ZnRIZGFZekJaZWYrdUxacWR6SHU5eCtMRW9paE5TMzBoemZiM3ZQ?=
 =?utf-8?B?OS9Fek9pS1FRb2VDUW4ySnE2Y0NRMjYxV0lnaVJVYXlBYUlHQVB3ZHhzYVNW?=
 =?utf-8?B?MzZVaVgrUjU0bzQ3aytBeGJPaGM2ek94cmIzL1lwYTZJcHRIL2NJRk45eGlO?=
 =?utf-8?B?NmVURXRsZ1l1SWFyeGxOOW5xd1dnTXAxb3hadlVVR3pENDBua3UwR2FhTE1W?=
 =?utf-8?B?MXNBLzhUY3ZNdy92VEZLOUtSU3lqNXZna3BiOTZWWUZpSzh1VnRCNzI2cWZL?=
 =?utf-8?B?UEhNdVREUzd3YU9EUHBRd2Y0NXpWUy92OWxSRTdud2VtY2twZU1QRS9kNDJM?=
 =?utf-8?B?SFNSWDIxVGpjRkdOSlNPY3dDSU14aE4xSlgyN2tVV0NoaEpkbEUxMDhScGFJ?=
 =?utf-8?B?WmhqZXh3SlkxN081SDFKazdpZUl5QlZaVnQ0TzBBV1NqWHJiams5ODJhOG9s?=
 =?utf-8?B?NzVQazkrc0R3WUpUK3crN09XU3QyV1N1SE54TUtpUmQ1YVNLS1pYRnFjVERR?=
 =?utf-8?B?WUdjYVRmblA4VEo2NEtxRG84bnNOYTErUzdzVVQ5NTcyRjFrUnVpWGorRmpC?=
 =?utf-8?B?YTdlNHZtOHRGdnNJZ28yNGJkVytodWxmdXVEWUN1RXlpY044NncyUG9MVTdO?=
 =?utf-8?B?bDdMNmRkZVBaTHdYREo3aWl1ZDdQRCtUeE5wK09tOWRKU1EwSkxvMlFOOVEw?=
 =?utf-8?B?U0tQamRZVWRST2JvTWJ4L25hNlN1UGhMaCs5SVBybFMzZXIwMVpVT2ZkYTcy?=
 =?utf-8?B?dXYxWEFqL2NDaXFZOUtQdEh1OW94M2N1RjhDK1VqcGF4NXRoWDc5cnJsNXpQ?=
 =?utf-8?B?bXhiWXVzdHYvT2wzR3lqd0lYRTArdWdNemNLc0ZYeDAwaThHUEMxS0pCN0tz?=
 =?utf-8?B?c0pRS1VxYklFRnVaajRnNHdVdTRRdGRGN2NFK1JmdWtrbFp1cG5ScFZ0TVU4?=
 =?utf-8?B?ODM1MVZqdW9sZHBZbUUvU2xkR2psNHNkazJubmFhcFg1NW55VEVGNTJXMEdl?=
 =?utf-8?B?Zjdwd2tkZWRsT09MeGRBNENFNWQ1YVNwSlEvdDc1a2hMbHl5QlVxUVNNSExm?=
 =?utf-8?B?M1BudTJIU0xsQnZYSXhLRXc4UEZoS3BxSUVGVUNGYTRvSHJFVzZsclN2WlJM?=
 =?utf-8?B?NHBwdXE4WWkyZk5BQkxhMy85ZnUwcTdNcS9LR3RZYWVBcS9RVWtvNG9PWGJP?=
 =?utf-8?B?OEk0RVp3dHlOeno3clBiR3hpMlJtdDFwSWJQUjllTkNnM2JpYk42S1AxZ2cx?=
 =?utf-8?B?SFVPQWkvelUyaU4zYzhRaHM2OWpBQyttT0tLTDFNSStvWTEwQXRCQmw2RExk?=
 =?utf-8?B?cktpMVdES3ZtSlVNNlVwNFgvZFYyWXZPU092b04vTU1RTHhWOUdJSUNkYWZS?=
 =?utf-8?B?RVZWQm1udlRPZzBYUFpYakFzcFF5TTRtTlM4ditVa082WlM5OVUvOFNUYm9t?=
 =?utf-8?B?bWFxZ21kaUFzelI2eEdmNi9mNTZ3VWZtbkJJYlV5WXdSYVIyT2ZQMUgyZGVS?=
 =?utf-8?Q?vPfOz8v0Qm4vRYnrVFwYWm6Fs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <398215DD388C334B8A37958BA5BEA851@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF9623118BD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81791c05-9175-4854-5236-08ddd3d2e3f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 03:48:07.7481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EiiI/f2HXQ8EGoodM3iO8lnPiAUukVjBv+X2y7T4wdaNOOuf/mNBddjHkFehnGaXugwHW1KRbDtFiBAnbwW66WJIaLZIM9AHCesmTIpDJgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7724

SGkgS3J6eXN6dG9mLA0KDQpPbiAwMS8wOC8yNSAyOjQ1IHBtLCBLcnp5c3p0b2YgS296bG93c2tp
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDAx
LzA4LzIwMjUgMDU6MzYsIE1hbmlrYW5kYW4uTUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gSGkg
S3J6eXN6dG9mLA0KPj4NCj4+IE9uIDMwLzA3LzI1IDQ6NTEgcG0sIEtyenlzenRvZiBLb3psb3dz
a2kgd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4NCj4+
PiBPbiAzMC8wNy8yMDI1IDEyOjEwLCBNYW5pa2FuZGFuIE11cmFsaWRoYXJhbiB3cm90ZToNCj4+
Pj4gVXBkYXRlIHRoZSBBdG1lbCBTUEkgRFQgYmluZGluZyB0byBzdXBwb3J0IGFuIG9wdGlvbmFs
IHByb2dyYW1tYWJsZQ0KPj4+PiBTUEkgZ2VuZXJpYyBjbG9jayAnc3BpX2djbGsnLCBpbiBhZGRp
dGlvbiB0byB0aGUgcmVxdWlyZWQgJ3NwaV9jbGsnLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5
OiBNYW5pa2FuZGFuIE11cmFsaWRoYXJhbiA8bWFuaWthbmRhbi5tQG1pY3JvY2hpcC5jb20+DQo+
Pj4+IC0tLQ0KPj4+PiBjaGFuZ2VzIGluIHYyOg0KPj4+PiAgICAtIEZpeGVkIG1haWwgdGhyZWFk
aW5nDQo+Pj4NCj4+PiBZb3UgYWxyZWFkeSByZWNlaXZlZCBjb21tZW50cy4gUmVzcG9uZCB0byB0
aGVtIGluc3RlYWQgb2Ygc2VuZGluZyBhZ2Fpbg0KPj4+IHRoZSBzYW1lLg0KPj4+DQo+Pg0KPj4g
SSBoYXZlIHJlLXN1Ym1pdHRlZCB0aGUgc2VyaWVzIHNvIHRoYXQgcGF0Y2ggMy8zIGluY2x1ZGVz
IGEgY2xlYXINCj4+IGV4cGxhbmF0aW9uIG9mIHRoaXMgY2hhbmdlIGZvciB0aGUgYmVuZWZpdCBv
ZiBhIHdpZGVyIGF1ZGllbmNlLg0KPj4gQXBvbG9naWVzIGlmIHRoaXMgcGF0Y2ggYWxzbyByZXF1
aXJlcyBhIGJyaWVmIGV4cGxhbmF0aW9u4oCUcGxlYXNlIGxldCBtZQ0KPj4ga25vdyBpZiBJIHNo
b3VsZCBpbmNsdWRlIGl0IGhlcmUuDQo+IA0KPiBJIGRvIG5vdCBzZWUgeW91IGFkZHJlc3NlZCBh
bnkgY29tbWVudHMuIFRoZXJlIGFyZSBubyBjaGFuZ2VzIGhlcmUNCj4gZXhjZXB0IHRocmVhZGlu
Zy4gTG9vayBhdCB5b3VyIGNoYW5nZWxvZzoNCj4gDQpNeSBhcG9sb2dpZXMg4oCUIEnigJlsbCBw
cm92aWRlIHRoZSBleHBsYW5hdGlvbiBmb3IgdGhlIEdDTEsgY2hhbmdlIGluIHBhdGNoIA0KMi8z
IGFuZCBzdWJtaXQgdjMuDQoNCiJUaGUgQXRtZWwgU1BJIGNvbnRyb2xsZXIgc3VwcG9ydHMgYm90
aCB0aGUgcGVyaXBoZXJhbCBjbG9jayBhbmQgdGhlIA0KR2VuZXJpYyBDbG9jayAoR0NMSykgYXMg
c291cmNlcyBmb3IgU1BDSyBnZW5lcmF0aW9uLiBPbiBwbGF0Zm9ybXMgbGlrZSANCnRoZSBTQU05
WDcgU29DLCB0aGUgcGVyaXBoZXJhbCBjbG9jayBjYW4gcmVhY2ggZnJlcXVlbmNpZXMgdXAgdG8g
DQoyNjbigK9NSHouIFRoaXMgbWF5IGV4Y2VlZCB0aGUgbWF4aW11bSB2YWx1ZSBzdXBwb3J0ZWQg
YnkgdGhlIFNlcmlhbCBDbG9jayANCkJhdWQgUmF0ZSAoU0NCUikgZGl2aWRlciwgbGVhZGluZyB0
byBTUEkgdHJhbnNmZXIgZmFpbHVyZXMuIEluIHN1Y2ggDQpjYXNlcywgdGhlIEdDTEsgY2FuIGJl
IHVzZWQgYXMgYW4gYWx0ZXJuYXRpdmUgc291cmNlIGZvciBTUENLIGdlbmVyYXRpb24iDQoNCj4g
Y2hhbmdlcyBpbiB2MjoNCj4gICAgIC0gRml4ZWQgbWFpbCB0aHJlYWRpbmcNCj4gDQo+IEJlc3Qg
cmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCi0tIA0KVGhhbmtzIGFuZCBSZWdhcmRzLA0KTWFuaWth
bmRhbiBNLg0KDQo=

