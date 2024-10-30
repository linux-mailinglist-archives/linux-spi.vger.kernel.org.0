Return-Path: <linux-spi+bounces-5546-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3719B6295
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2024 13:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0321DB21315
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2024 12:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361751E47C3;
	Wed, 30 Oct 2024 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L5iOBSYY"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E62C1D0E01;
	Wed, 30 Oct 2024 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730290195; cv=fail; b=iL/0hnfHYH0h9GK9zb0MvhEcrsGAVB1A7nTfQPexy1wJamMU/kxVLXNPPWRJSW3Hrn+mpHI6xRwY2hBnF7R7RR1ztOrkmLQ/D8pTIBa+8bCstWxAOxtCjaUutavXfvrYzVyQ2EJknA5pwLZMw/bALNglEFtL6nW5QOY4dAIN+5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730290195; c=relaxed/simple;
	bh=eoOeQJceSwS2JM09yFkq+UBef6bwt8nSNpSm3uTE+0U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cIce181OsuJYCSAfTPqguFUkqC8SHn+AwVe4B3JTh3usZXbKTge8ldaEEeRLmNpEW1F2bXdRSkLYPMoGRnwKy9J4ow6azchyiG9C0RiZtPjexAgnU0If56cRIR7so8ujjvfSNVo8C4hunUGRJwev62e2zFRz24FqXQJ5SAZR6JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L5iOBSYY; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCRqKwHOTYTTOgIWDUw8YApiT2SfXdzRnE7wAiPPFtZX5MUZyrVIZRIku4a+SIByGfFGdLgtVLYFBrPZPMHYnBpcKyHCac3NNxe7eQuGX4C/tGTOv9wXqwuf0JFX7UwMss4Ow5dX4eVRL5BOW4YNa21kudM2HV59I9vhZHzh2VUSQOzs0hajMyhKsTWyYMFYh1PtDoNr5UHwV3A6fvyrY+h+6KKBMoQ/uwSxOPo3x/QmdlOPkieZ55/8en35HVDsdBs7BUXQ26w2e2kMoM6mUV4+RA11k1xKntsFGpG5ENrK1WTC0TInevZHGTx81K2/b8Pb+kxgUQlezqJHg/ioeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoOeQJceSwS2JM09yFkq+UBef6bwt8nSNpSm3uTE+0U=;
 b=lZp9CKv1FC4/vVao5JND1A+L+o3y4Pn7NhQIx1LE7wOSkyWb4U1pJMuqSGUjDklZc7w5nBnb0FPbADVw0pOdKyLI5+1QXNURGQ43KnwLMYZLbGzo9Fgk7wWf+ajfFRKPOvlsh1mXGoeoKL/NWOH/T/fIPZYyDcdfNGLCWEQfoQHsMk6PkJrWJzxB71ZLk76gP59QVQyKtTiBt2tCmY46GUgH7bqoibq6q7pGM4UEIydFgJotRvx2oKBaszfn9sVA2fqSsSmlakJol33cR6WVS7mgeSUnR/jnqAxlM8/Sn0GvelYQ1ySuumOjLrG6RlzbpPjEkRuP+u9oIm+rfL1aJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoOeQJceSwS2JM09yFkq+UBef6bwt8nSNpSm3uTE+0U=;
 b=L5iOBSYYG2/nh/0kZXUW2tEDJDKqjBdY5WZwHYOVqED6nbtGAvIg83pvyfG0LOBI290FnHwfG32TcQAcC/Ux5iB99JFXt014kfUkNriBXSVUPsmPNaSy9bQOBLH1MrZtczkrNgTbu4achDWY5NPK4Ma1nR2zeXcQtmfMy6/FtOc=
Received: from IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 by IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 12:09:44 +0000
Received: from IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa]) by IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa%5]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 12:09:44 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
	"tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>, "michael@walle.cc"
	<michael@walle.cc>, "broonie@kernel.org" <broonie@kernel.org>,
	"pratyush@kernel.org" <pratyush@kernel.org>, "richard@nod.at"
	<richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>, "robh@kernel.org"
	<robh@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>
CC: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>, "Simek, Michal"
	<michal.simek@amd.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, "patches@opensource.cirrus.com"
	<patches@opensource.cirrus.com>, "git (AMD-Xilinx)" <git@amd.com>,
	"amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>, "beanhuo@micron.com"
	<beanhuo@micron.com>
Subject: RE: [RFC PATCH 0/2] Add support for stacked and parallel memories
Thread-Topic: [RFC PATCH 0/2] Add support for stacked and parallel memories
Thread-Index: AQHbJ3xB9LmpIkfrvU6wQ9mSvcxe2bKd7XgAgAE+QqA=
Date: Wed, 30 Oct 2024 12:09:44 +0000
Message-ID:
 <IA0PR12MB7699B63C9E9163C9841C1F9EDC542@IA0PR12MB7699.namprd12.prod.outlook.com>
References: <20241026075347.580858-1-amit.kumar-mahapatra@amd.com>
 <b025774a-adf6-443f-b795-bb138c490c2b@metux.net>
In-Reply-To: <b025774a-adf6-443f-b795-bb138c490c2b@metux.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7699:EE_|IA1PR12MB8334:EE_
x-ms-office365-filtering-correlation-id: ef42a21a-3dda-4320-9376-08dcf8dbbdac
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TjlmblZlY3pSd1RRSDVNZ2hHcGpxV3phL2tRZEVYbFVkUi93MjFSSVdKQWZq?=
 =?utf-8?B?VUM0dTBvV2RLZkpFOWMxNDNGUVNtcFQwUUpBQkNGbmFheVUvZlVSOUxaMzdM?=
 =?utf-8?B?YXpyVU1oaHF1aE51NG9yL2EyckxYUzIrZ2VKbG5ZMm1GaHkrS3kyZUUxUDVT?=
 =?utf-8?B?N2x0cUhQelNrVjh5MWRyYXJDTlJ4aVpOZVFYMkg2Qzg3TUZ0TnQzbE5raXlH?=
 =?utf-8?B?dHUrRkJYdnhndThQbzNSejY4TEVmQlA2TzcvYlVSVkxtazdHdFVLWlptUmJE?=
 =?utf-8?B?TlF5N0ZOV2ZicFBiT3lSRXBPM3ZOZlllbWF4ejNvSWZST0pZTFJ3SWp2QjVz?=
 =?utf-8?B?U0lDeS8wR1RYcVZNZUhKZFUwV1RWQUJLbWhiZjJOaUxMazRrdXVqcThWWVdW?=
 =?utf-8?B?YVR0NCtoUEVBeXdDbGJyZ0dCMlg0b25scUlmNmNjcFRRdTR4RUErVHBIbzFa?=
 =?utf-8?B?aWJ5elFaS2xIV2dFSklnVDNoR25UKzc0SWhLanlkNzl6OWFwMUFoSWxQdXFW?=
 =?utf-8?B?NFVmcnhuVTF2S1RDUkMrU05wVGdNUkF1VHMvYkUveTBzTUMxZHJaUWtMUUNh?=
 =?utf-8?B?enU5ZUhQK2NwYzZYR0h3Sk81S281N2p0KzA4cTFvR0tnNXpUamxnWEs1R2R2?=
 =?utf-8?B?QllONWVaaFJJblhJcTlJREwybmIyeFB5OWpKYnk5L3dic0prNENiakFLQkFB?=
 =?utf-8?B?eEJDdUhVVWtjeXNDV3BuOTQ3d29SeGE3ZDFKOUwvREhiZkZOQW9yN2RUSm9t?=
 =?utf-8?B?eUNMQ1B0VGRCVmFLOG54ckZ0ejBKc0FjQ0Q4cXAvUFB0d2VQbDJ3bi8yRFZv?=
 =?utf-8?B?dmRJQnZyR0F0K3g4YllHSHpZT1RkeGJNd1g3OTV3S1ducnNOcFFwcVhDSG43?=
 =?utf-8?B?TmtER2JWQVZrUlNwbWdqUGxFSXlQV1BzbngvVXBERmN4S2hubDJaNnl3ZFdH?=
 =?utf-8?B?bitSM1QvVU8rSkRnSHZXeDRrSXVFVU9YTThwY1A3a3V6M0lsOWR4UVVYQVNH?=
 =?utf-8?B?Y3c1ZVpxMlRpQjk4N3NkcEZ2dlVQbFRrMExhbEdWdmpCTzArWGJMK2MrNk9W?=
 =?utf-8?B?WmpUYnZUNTFmSWlNSlRpOWFzbjFKS1c3OVJidDdIcStVSFZIQWRpVE5pb1VO?=
 =?utf-8?B?SHZ0Vml5ZHp6UnpGR0RkcmVqeXNMaElaS0g5SjhkT3lDd1d0N2dlOHU3a1NE?=
 =?utf-8?B?dlBWQ3FOOUtjMUpHZUJVaDBYOUhjbmUySitkcDRzMkxSTXY5TSt4SGYrQ25n?=
 =?utf-8?B?UVB6akNOd1FXR0VBeG5FRHNaZkVsL0paZzRZd1J3SXh0ZXdrREZFdUdySG5n?=
 =?utf-8?B?UTYwSE9GY2hlYzY1eFcwalRPa282VXdBZThoUXVET0NrS0ZhQytNWEM5YWVK?=
 =?utf-8?B?bUsrN0VpMHVXUzZLM2g4Q2Q3TFZnMWtzMG56RWpYamgzWFVBOEdIdUplTWgx?=
 =?utf-8?B?Wm9FMzN5RXpzMWRjcU8yWHJYaWVPWVVlM1hDaWtMTG5xVG9EWGcyNVgwSktQ?=
 =?utf-8?B?Ym9BNC85MXBWNkk4REtMMGhJcFIzamVzblRBejJJeTVjUTdPZm9PNTZkZDFG?=
 =?utf-8?B?RnBqaFV6ZXRqaEI2MFJtQkNJM1RaL3VIcGpPcm5EWmxRRHViK2lVbHo4WWJq?=
 =?utf-8?B?aHlVTStrLzJSbkE5WHJ2aHRPdGlCYUVjN3ZkR0JMYlY1OWI5QXp2dklKRkRI?=
 =?utf-8?B?ZjhEVlp0WjcrV2sxQ1AzRmFTb0pRb1JjN2FnOVlvYTlPSWFyYlVBd2JYcUF6?=
 =?utf-8?B?R3A4TklSckpVR3RIaUpuLzRxTHZRNFVKR21VSlBFa3VSMTJoSjdZVnVVNXpY?=
 =?utf-8?B?UTRTaWQ3cXAwdUo4UHdQczY4ekc5RXhldEVKV1doajhpMHBIUUZVa1pwTC95?=
 =?utf-8?Q?sf484GVNxNcda?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7699.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eXljWCtFNXRMeEhJQnNEV2dzLzhCZHFaTk1Cc0d6QitDNFVjMkkrT3MxamNS?=
 =?utf-8?B?dEhRQTRKWmtCcEttbWRUUlBmeHJYTXl4c1JwSG1xS244WFNxZ2RCZmljUFFS?=
 =?utf-8?B?dHZrSzU5cHpYdno4R21IR2JncEhxQzNjM3M2VUpVb0dCRmY2b2lFQTNXVy9X?=
 =?utf-8?B?YkZkMHI5VGsyb1E4Vkd3UU9GMG01bkloMSt0SERzV3MySWdic2c2UWZpQjFN?=
 =?utf-8?B?b1N1YnVjYkUzRTJvYmR2SWlndW9OMTRmcDhPSVhadGtPTUFCam9OSjN3clBH?=
 =?utf-8?B?RkMwcFpBWm9DVkRRUm02d2N2L0Q1RGUxMUQ2Yk9QanA4WW11Zm9jTDlmOEh6?=
 =?utf-8?B?Q3dOcUFxeS82WEFjWWduMkJtUHowMGEwY0V5OTJSUjIybGpOMjh3UFFSNDhP?=
 =?utf-8?B?cjBleitQMlNkTExuSTR3Yy9ITkJFZHkreGkvMWYwVmFiZkkxUkUzYWRFZzZF?=
 =?utf-8?B?YjdpZlNyUk5BZnE4eCtscXhxWUpEekNWMDczUDN2TXRMQ2YyK2tuOFZ0RE91?=
 =?utf-8?B?eVhGWk5CRHZudVBQa3Zic1JIMmVZK0J3S2lxVmozckNaRzRLYjRmQ1ZmWjlq?=
 =?utf-8?B?enpJdHJ4RlI2cTBUTGFjNzYrOWhvd2trelNNMld0M2ZyemV1aFBDbXFJNzgv?=
 =?utf-8?B?dldkVVQwaWNpK0pQTzlLamFKRlA2MlAvQ1FKU29iZ1hMbEJJMXVsS0tKQkZt?=
 =?utf-8?B?dHkzdjJKSFZOd3N3TzA1enlxSlpHRjUycEMzb1VicFRsSXdBUVREUGhZRDMz?=
 =?utf-8?B?YkkvUk5JNDFKUVdRclRRTTZOamxBZFp2Vk9GMVZjMzYrRnlNR3BnTy9qMzVq?=
 =?utf-8?B?dkRTNEx4WDA3dnBnMmlzVlZPK2E2dGExRmJzNzYvc1BkdUkrMngySGxtekdB?=
 =?utf-8?B?SFQyUmNBamkvcE92MjYvOVRnTHNabUZKZk1XZ1E3eWZNSHhNVHRTeCtDYTdQ?=
 =?utf-8?B?L242OE0yWU96SlloSHVFWDQ0VngrdnkwY3pXVVphNWRNVFYzWWF2UDBLaWY1?=
 =?utf-8?B?aVV4OHA3cDcxZ1RkWlpHZFlOWDhrZTlEZTBCYi9WRVQwMktLYzlabm5IRFFq?=
 =?utf-8?B?a0J6YUo1ckRubGN5NEhBSm9GZkR1TDloZGtDbkxIOGg3R2hGQ0pnK0ZoUkl5?=
 =?utf-8?B?Mi9WU1B2VzZmcEZZaVZ4UkZqMjRiL2lIdE5lUlRRUU9ES28vUjd4SHZVamNT?=
 =?utf-8?B?RGIwQnF2d0E3S0xTMllZWW03bXZ0TEZmM0Q1RnhMTEN2T3hQRmk3SzVTWnd4?=
 =?utf-8?B?c1oydkt3NFJlOTBWMnVvcXhoeXNBUURGZlYrUHg5UFpmTzBRTTlYbVVnVGhD?=
 =?utf-8?B?Z1BtaWdDcnVuMXpNbTBLNS9TM3UrYXRJY0UvYlJ2K3RKb0l6UnkrYnhNNktm?=
 =?utf-8?B?VXlTcFM0aE4raUE1QmNIY1AwSk1xZ1BkTlQ4TlFrNEJnaGFocHhGSE9DckRD?=
 =?utf-8?B?Y3doN0YvM1RZUnU5d3UzZmpxZGc0M0d2TzVlYTlyZlZkT2Nsa2JKVHJNaHQ4?=
 =?utf-8?B?TSthNk5xMWxCaURlVFdKY1FQQkR6K1RBL1R6L2k2by9HZDd5cm04YUVuWmlI?=
 =?utf-8?B?YjFtSlJWOGsreDcrSENNTGVHdnA0RGY1YlJPc2ZUVSttbk1IbGE3aVQvOTMz?=
 =?utf-8?B?eFkrWGk4QVFWSkE3MDJuV1lQSml2SkFzbnprRzFibXBLb2loM1Z1SnIzSHRL?=
 =?utf-8?B?L1QvanJKVnVIeGtLYTVvY3I5eDl2OUVZKzBWaXh1U2xrcjdBWFFnYTJzQnVS?=
 =?utf-8?B?anlHMG8rYzZHNURJODlubVUwVjlTWHVGK25ZUXF5dmo3OHFpQ3g5V3A0cng3?=
 =?utf-8?B?eC82YUFiWXRKOXkxalNPdUNYa2lEb1ZQTFVhQmMvZVRySE9oR0FnZ1QwSEph?=
 =?utf-8?B?aWpEdVorOUl0d3JLOEJHaStjbUhnTjVuZWVva2M2dUFGcloxQk5tQmRwRWFq?=
 =?utf-8?B?dGl2Nk5YNjlTWXJWSU0xdGwyNHppSGljY3d1QThjK29LQzU3anA0Y2d5OU5H?=
 =?utf-8?B?N0hCQ2pyeURVb1ZPeWlJSVgyRXk3VUNRVGpaVzMwM25WdmtRNDdIVG9PTFN4?=
 =?utf-8?B?ZEhnckVTd2RuRUdLbGZlNTNmbU9qekh1YmVnQ0pzR3YrZXVvRFVMZ2ZFRjZv?=
 =?utf-8?Q?SrLc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7699.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef42a21a-3dda-4320-9376-08dcf8dbbdac
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 12:09:44.3247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8wBCjs73wFlmcAOrAIeQzgcuCEvbT6O8IkA2202CUMHRGxlUnz6Ig73niUJNRB/XdWT2cwWrNb+i0BXXhwM0yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334

SGVsbG8sDQoNCj4gPiBTdGFja2VkOg0KPiA+IEZsYXNoZXMgc2hhcmUgdGhlIHNhbWUgU1BJIGJ1
cywgYnV0IGRpZmZlcmVudCBDUyBsaW5lLCBjb250cm9sbGVyDQo+ID4gZHJpdmVyIGFzc2VydHMg
dGhlIENTIG9mIHRoZSBmbGFzaCB0byB3aGljaCBpdCBuZWVkcyB0byBjb21tdW5pY2F0ZS4NCj4g
PiBTdGFja2VkIG1vZGUgaXMgYSBzb2Z0d2FyZSBhYnN0cmFjdGlvbiByYXRoZXIgdGhhbiBhIGNv
bnRyb2xsZXIgZmVhdHVyZSBvcg0KPiBjYXBhYmlsaXR5Lg0KPiA+IEF0IGFueSBnaXZlbiB0aW1l
LCB0aGUgY29udHJvbGxlciBjb21tdW5pY2F0ZXMgd2l0aCBvbmUgb2YgdGhlIHR3bw0KPiA+IGNv
bm5lY3RlZCBmbGFzaCBkZXZpY2VzLCBhcyBkZXRlcm1pbmVkIGJ5IHRoZSByZXF1ZXN0ZWQgYWRk
cmVzcyBhbmQNCj4gPiBkYXRhIGxlbmd0aC4gSWYgYW4gb3BlcmF0aW9uIHN0YXJ0cyBvbiBvbmUg
Zmxhc2ggYW5kIGVuZHMgb24gdGhlDQo+ID4gb3RoZXIsIHRoZSBjb3JlIG5lZWRzIHRvIHNwbGl0
IGl0IGludG8gdHdvIHNlcGFyYXRlIG9wZXJhdGlvbnMgYW5kDQo+ID4gYWRqdXN0IHRoZSBkYXRh
IGxlbmd0aCBhY2NvcmRpbmdseS4NCj4gPg0KPiA+IFBhcmFsbGVsKE11bHRpLUNTKToNCj4gPiBC
b3RoIHRoZSBmbGFzaGVzIGhhdmUgdGhlaXIgc2VwYXJhdGUgU1BJIGJ1cywgQ1Mgb2YgYm90aCB0
aGUgZmxhc2hlcw0KPiA+IHdpbGwgYmUgYXNzZXJ0ZWQvZGUtYXNzZXJ0ZWQgYXQgdGhlIHNhbWUg
dGltZS4gSW4gdGhpcyBtb2RlIGRhdGEgd2lsbA0KPiA+IGJlIHNwbGl0IGFjcm9zcyBib3RoIHRo
ZSBmbGFzaGVzIGJ5IGVuYWJsaW5nIHRoZSBTVFJJUEUgc2V0dGluZyBpbiB0aGUgY29udHJvbGxl
ci4NCj4gPiBQYXJhbGxlbCBtb2RlIGlzIGEgY29udHJvbGxlciBmZWF0dXJlIHdoZXJlIGlmIHRo
ZSBTVFJJUEUgYml0IGlzIHNldA0KPiA+IHRoZW4gdGhlIGNvbnRyb2xsZXIgaW50ZXJuYWxseSBo
YW5kbGVzIHRoZSBkYXRhIHNwbGl0IGR1cmluZyBkYXRhDQo+ID4gd3JpdGUgdG8gdGhlIGZsYXNo
ZXMgYW5kIHdoaWxlIHJlYWRpbmcgZGF0YSBmcm9tIHRoZSBmbGFzaCB0aGUNCj4gPiBjb250cm9s
bGVyIGludGVybmFsbHkgbWVyZ2VzIGRhdGEgZnJvbSBib3RoIHRoZSBmbGFzaGVzIGJlZm9yZSB3
cml0aW5nIHRvIHRoZQ0KPiBjb250cm9sbGVyIEZJRk8uDQo+ID4gSWYgU1RSSVBFIGlzIG5vdCBl
bmFibGVkLCB0aGVuIHNhbWUgZGF0YSB3aWxsIGJlIHNlbnQgdG8gYm90aCB0aGUgZGV2aWNlcy4N
Cj4gPiBJbiBwYXJhbGxlbCBtb2RlIGJvdGggdGhlIGZsYXNoZXMgc2hvdWxkIGJlIGlkZW50aWNh
bC4NCj4gDQo+IEludGVyZXN0aW5nLg0KPiANCj4gV2hhdCdzIHRoZSBwcmFjdGljYWwgdXNlIGNh
c2UgPyBTb21lIGtpbmQgb2YgUkFJRCBkaXJlY3RseSBvbiByYXcgZmxhc2hlcyA/IENvdWxkIGl0
DQoNCkluIGEgcGFyYWxsZWwgY29uZmlndXJhdGlvbiwgdGhlIHVzZXIgY2FuIGRvdWJsZSB0aGUg
Zmxhc2ggY2FwYWNpdHkgDQphbmQgZGF0YSB0aHJvdWdocHV0Lg0KDQpVc2VycyBkaXNhYmxlIFNU
UklQRSB3aGVuIHRoZXkgbmVlZCB0byBhY2Nlc3MgdGhlIGZsYXNoIGRldmljZSANCnJlZ2lzdGVy
cyBmb3IgcmVhZGluZyBvciB3cml0aW5nLg0KIA0KPiBoZWxwIGZvciBwcm90ZWN0aW5nIGZyb20g
YSBicm9rZW4gYm9vdCBmbGFzaCA/DQoNCk5vLCBiZWNhdXNlIGVhY2ggcmVhZC93cml0ZSBvcGVy
YXRpb24gY29tbXVuaWNhdGVzIHdpdGggYm90aCBmbGFzaCANCmRldmljZXMgc2ltdWx0YW5lb3Vz
bHksIG1lYW5pbmcgdGhlIGltYWdlIHdpbGwgYmUgZGlzdHJpYnV0ZWQgYWNyb3NzIA0KYm90aCBm
bGFzaGVzIGFuZCByZWFkIGZyb20gYm90aCBkdXJpbmcgYm9vdC4NCg0KUmVnYXJkcywNCkFtaXQN
Cg0KPiANCj4gDQo+IC0tbXR4DQo+IA0KPiAtLQ0KPiAtLS0NCj4gSGlud2VpczogdW52ZXJzY2hs
w7xzc2VsdGUgRS1NYWlscyBrw7ZubmVuIGxlaWNodCBhYmdlaMO2cnQgdW5kIG1hbmlwdWxpZXJ0
IHdlcmRlbiAhDQo+IEbDvHIgZWluZSB2ZXJ0cmF1bGljaGUgS29tbXVuaWthdGlvbiBzZW5kZW4g
U2llIGJpdHRlIGlocmVuIEdQRy9QR1AtU2NobMO8c3NlbCB6dS4NCj4gLS0tDQo+IEVucmljbyBX
ZWlnZWx0LCBtZXR1eCBJVCBjb25zdWx0DQo+IEZyZWUgc29mdHdhcmUgYW5kIExpbnV4IGVtYmVk
ZGVkIGVuZ2luZWVyaW5nIGluZm9AbWV0dXgubmV0IC0tICs0OS0xNTEtDQo+IDI3NTY1Mjg3DQo=

