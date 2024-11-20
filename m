Return-Path: <linux-spi+bounces-5781-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF469D37F9
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 11:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E161F214F7
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 10:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3D374040;
	Wed, 20 Nov 2024 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kIhyIOtP"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5E317836B;
	Wed, 20 Nov 2024 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732097315; cv=fail; b=hN3+Li6pvbxdYhVuBU2WIGIQwUWh/cIG9HGubx2aeYoHEITtgcHu81BTx+4MRivf6L3k6So0J9fyqdW7Xf3bmrrVZMpE9DlTirWAtBSbLfQIpN8byKY4PY9gyeHYtZ01Dez6IRSlZHq6jU3lAp27OHa/nMS1sJ1vbWa138C89hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732097315; c=relaxed/simple;
	bh=0Vd0pE3h1+owFCMkUUFz1xQmMNu+P/Qr5iR56CYsSmQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ILplHz4uZ4Mqsaxf/ja0yEiytazWv6v9Fv/ckGJL8sntwts799zrnErXcmIraFLT++1bVolXyhewzRrhWQMepFoZVtFe6Kyq8lzR19j+5aurkt7hpe8cx4R8rltK45JDrybsjr84GffuIz2Jbgh4qLOc8VUpe/zoEjOy9LvqIcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kIhyIOtP; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tE/8/z1OzPbE1h+OWEViS2PpDdHPC6QyerLWr4sCAj27UpN5eJL7jZzgqNk56z2/yZmJh+Qs4Gf4fS8geGrcoo3Eny4UB6jto6XgN3vPvoMaRM3ZdV8c34/xgjBh73nVN54D0W+Qiu+pImyUKpK7nqbsAH1PJKW3akCtaAjkxv30jThSZhq31MQtYouJuKQE933Ai+Gu1PIPPJTnhrbG7ki/9g4OfKmoMN1/qz7Ti60wrqm8NWBu1CVHz+lu0LNevxgpO8+1VtJy78clm83KOofI7vCBdzCwXUUt59N0X+Dg9ihBakGisRzcgmfEB82d2GbbZ/gvt9mnW6tN6SCZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Vd0pE3h1+owFCMkUUFz1xQmMNu+P/Qr5iR56CYsSmQ=;
 b=tFQNxzI9tLbbR+ahPg9ZzdFrwX+o174mQzczAJ8adrJD4Z8YHInZLCjkkof4DefUJABLUnS+2lfX+tkv480YMBAvktxghRoDAaDoylPsfzchkwL50tvFyEeXBHNivedoJhunrQfnDTNIPi9t3UQhwVnbSsU7L0RPkbeD1vNtFmSd7vxr6L0sO4UfiN3sRdd/C8bKncwjhS53L3Pju9FUGmUVLh2y9PQRMc60btB5hKwS8RAR0CZ1hI5KQW6hFTscM0xQdyzVoEkvuhL+MiReEasDvFeC1iUW2dxrqSH0JC3pSWVNGZuvsMmRsGQgQ7H2YWu/le1SkkgT4TGwUQdmpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Vd0pE3h1+owFCMkUUFz1xQmMNu+P/Qr5iR56CYsSmQ=;
 b=kIhyIOtPmimB5trjry6rOYrZOhcSHbgk+YEYMsP5WHb7TWXGnvi2kZqnU52PBuNLpuPuTgiX0XsJ2k/R+5IAZl6NwPRoorjHe5e+ydd7jLQYhmIaOxgWDWpf8hyOlKMxy3lnLqSGKOQYw0U4pkvfBhM6LXmaEtbSRgDnzWwm5j8=
Received: from IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Wed, 20 Nov
 2024 10:08:29 +0000
Received: from IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa]) by IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa%5]) with mapi id 15.20.8158.021; Wed, 20 Nov 2024
 10:08:29 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>, "michael@walle.cc"
	<michael@walle.cc>, "broonie@kernel.org" <broonie@kernel.org>,
	"pratyush@kernel.org" <pratyush@kernel.org>, "richard@nod.at"
	<richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>, "robh@kernel.org"
	<robh@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "Abbarapu, Venkatesh"
	<venkatesh.abbarapu@amd.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>, "nicolas.ferre@microchip.com"
	<nicolas.ferre@microchip.com>, "alexandre.belloni@bootlin.com"
	<alexandre.belloni@bootlin.com>, "claudiu.beznea@tuxon.dev"
	<claudiu.beznea@tuxon.dev>, "Simek, Michal" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, "patches@opensource.cirrus.com"
	<patches@opensource.cirrus.com>, "git (AMD-Xilinx)" <git@amd.com>,
	"amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>, "beanhuo@micron.com"
	<beanhuo@micron.com>
Subject: RE: [RFC PATCH 1/2] dt-bindings: mtd: Add bindings for describing
 concatinated MTD devices
Thread-Topic: [RFC PATCH 1/2] dt-bindings: mtd: Add bindings for describing
 concatinated MTD devices
Thread-Index: AQHbJ3xBTx+wL/tjcU+OTs1kcRvpc7K9LE/QgAFrroCAAXz5EIAAAp5Q
Date: Wed, 20 Nov 2024 10:08:29 +0000
Message-ID:
 <IA0PR12MB76997482D362A83205E3D9F3DC212@IA0PR12MB7699.namprd12.prod.outlook.com>
References: <20241026075347.580858-1-amit.kumar-mahapatra@amd.com>
	<20241026075347.580858-2-amit.kumar-mahapatra@amd.com>
	<87frnoy8na.fsf@bootlin.com>
	<IA0PR12MB76994483BBB757BD9F691513DC202@IA0PR12MB7699.namprd12.prod.outlook.com>
 <87sermxme1.fsf@bootlin.com>
In-Reply-To: <87sermxme1.fsf@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7699:EE_|PH7PR12MB7377:EE_
x-ms-office365-filtering-correlation-id: 3928a432-a534-49c5-0e9d-08dd094b4822
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UFF3czBzaGkyRnlka3BFZFUrWE1qaXdvRFpyeFNOck55THhzZnY0Sy9IQ2x4?=
 =?utf-8?B?TTRmLzE4Kzk3VG9hVGlpUU0zYVJLSi8rN0FTRzVRUjRRWG4yZWk2NEVLUUtF?=
 =?utf-8?B?dVlHOHRkRG9DNFhSU0V1SFlEbjFTQnlHbktud21qWWFSZWNROURlOGlva2dr?=
 =?utf-8?B?MnhOZk9zR2JkV1NMWThudFB5MUJsRWhVUEx0Zytzb1c1YkMyeFlvTnF2ckVu?=
 =?utf-8?B?TjVrczUwMVYxa2wwTDJZSWJxZCtlSXd1aVN2R3gzTU1sM05VTVQyU2ErcWFM?=
 =?utf-8?B?bGZ0b1BJTUNiQ25aSW4xLzhGaFZoQ25taVVnWXgxeFNDTE14MDJ5dnk0YlhK?=
 =?utf-8?B?QThKSkVyay9xWEUyM0tPdzZadU4rZUFWZXZoUkpnbnpaamo2V0NEVHF6UVBL?=
 =?utf-8?B?bHpDY1dwOTBtSVJNWkRnYnVHTG8wdGhzcHR5c2JscUc3K1h2MnBqNVh4dmJF?=
 =?utf-8?B?TGR3Y3NzZk53T3FWaG1ubUFWNEQzVHk0U3ZNekZjazZQNFEyL0liVENsVkl0?=
 =?utf-8?B?d0Z1T2s1Y2J2QVRPQllxWVozdW01UFp6aUE4dVVkUlhMdnJta0pnRE1NeUdK?=
 =?utf-8?B?RGp1UVArQ1k0Q1M2bmZqcWJRb2M2eVFVeEFvemZ2Tm1UY21qdjBiUUZ1WWIx?=
 =?utf-8?B?UVNvb05aWWNFbW1RL3RPZDhFKzNMSmE1QnJ5YXVyd1ZpSlYvdjhvWVBoVlpS?=
 =?utf-8?B?QjErM3hwNzJxeFh4YTBIUWhpV3JGYjVMdnRqQUhIeTM0OEFCNnEyNkhDWUtH?=
 =?utf-8?B?SE5mUExJQWUrWHh3SytDeG5iVTgzZ0NDNHFablJGc1VDOU5aMnVFRlRRWEV6?=
 =?utf-8?B?aVFrcVNWSk4zYi9IVFEwclF5WFNtTm9OdCsxdHhmdHZUTFdHdjdSQ3lUOXJI?=
 =?utf-8?B?WEFMdFZKQVFQcVdyTGNpSmwzMWpsOWNidlBNRG1zNzZVUkk2c2pUekhIbmZy?=
 =?utf-8?B?dnVQZkVLVUhsM2pHUXVMeVZlbW1nVGIxMzlyWTUzUXV5NEJUV0RKVWd6WlRW?=
 =?utf-8?B?Wjg0UlRwM3ZkczAzUEw2NnlsTFBrbGJmRTdWRXNsWVE0OHJ1Zk9LY1pJUmFQ?=
 =?utf-8?B?RktUUGwwc01GY3dmZHp2NFMxKzdKWHJIcEdyYVB0K0d4b1lhWmlkbHNHNjBh?=
 =?utf-8?B?TythNXRpVVNvSWVoU0JKNXkvdVYwNDFmTkxVaVo0R2VWeTdBcmhlMHhpdldr?=
 =?utf-8?B?WkUwMjVKMkI0N09NR1hncU1lZDdnNGxhMm4xVW1uRW4zVEloL1pLZHBBVHlY?=
 =?utf-8?B?QUxzc0wvNVZCVzYxSy9QbDV5V25VZGxHQ0lJbXA4cXN1ZHJxcnhDdk5EbUw1?=
 =?utf-8?B?dDVkSlYvV3RVak5vbUdFUm03SDc1WUtvR0dUM3dkeWVRdXcrQnZMTHliMGRz?=
 =?utf-8?B?bnBVUno1VXM1NU9Mc2g5Q3VRVzlkRnhHSFhZSHJYaXRaWVk1WjFEVHdtQWYx?=
 =?utf-8?B?RnJDVmRmZERxSmJ3UWE2STkzQ0ZSVGNqaVNTNGVBaDltT0ZPME9IdEhlR00z?=
 =?utf-8?B?c1lNZEljWDZRWlRNVHlQZFhQQzNncVk3Uzk5U2N3d3gwamtZUEtjN21QZCsv?=
 =?utf-8?B?blpHdlkzZVFwRCt5M2NhWVc1dmpLOFhwd2poU3VFb0pkR0NaSURRZDQ0dWJi?=
 =?utf-8?B?S0VJNUpGMkkyUHV5YUd2OVZrU1dqcWxVTzdjbmVJZlNhaytBbU90N1E1VWc3?=
 =?utf-8?B?c2ZmQXpkZDBWRFpjZXBhM1NIVFE0R2JyWmFnSk9DZEp1YmNNNElEeSs4bVdZ?=
 =?utf-8?B?OFNjQ3dwc3pYZU5lekNoUmZEMm94VWk2MDFOcEM0UFE0NGphZ0tmWWJnVEla?=
 =?utf-8?Q?G0XrVV8nQ6HTCuzbCOcLqTVNjVjm8VEiW/nUA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7699.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZCtKSzhZeHg1TzNlWWwzYXZXN2lPaWlka0RxSk1HeThvd2Q3OWRHaWZzVGtY?=
 =?utf-8?B?TmxoUTlSak1qT2NSQW9UQTJVajZrdEZEOUx1QWdPSW1yekwrNDMyNmNoRHJ3?=
 =?utf-8?B?dlNjdVFEZEVpbUVJbmpXdEN1dVRDZ28vMmtwU2tPbFg3bW9QVHRyRXNBSWJN?=
 =?utf-8?B?OWVid0JEZE5JcGExWjg3UjFGbGViTGN4aFdyUlRpWjE5aC83dVdiU2tHZE9z?=
 =?utf-8?B?dlpDSmtodVhURWhmbmdxRFByTW1xQTNLL2FwbHpsbnFEbmVNWkRNTTJWRnRw?=
 =?utf-8?B?QmN3QnZoZFlUQUNIK1RBWDFCdXRRNG1ocHA3eEk2dHZEU2NKdnB3amtBQnNC?=
 =?utf-8?B?U2NMc3JkNnZTTFR5d0hGVkdoZDVDcWxEcHBUL2hnR04rR0VEdmVXczJvWnVN?=
 =?utf-8?B?Zjl0cTFkU0htTWlVK0dZYjdsYmZxY1ZuWGF4UCtxMTJUZ0pzUnhsbFNDcEdm?=
 =?utf-8?B?MWE5c0hsTHNmUUtFM3hrWnJ0MUp5SUI5TWZFYytrQVZENlNPT1BRUkxGK3dt?=
 =?utf-8?B?NjhhalVzamRFUCs4aEVHQ2FicjBodlNKM0RQYTc1LzFXaDJYYUNWSjk2YWxi?=
 =?utf-8?B?NGpEV3BKK2Z5ZDU5M1dScGx6aHhOSzNad200b3JRTllNUSt4akM2aUhsRFRT?=
 =?utf-8?B?aTlQYytobkZwTi91SnQ1QncxdVMzTTdmbm5wdTNjc2F2VTN0WVc4NUUxYklx?=
 =?utf-8?B?dzlqV1FBYUVRZkNybDlmUmNsNkhkTHJwejNjMGI0bXI2RFEyd0FDelNmT0Vv?=
 =?utf-8?B?ZXAvMWtMNTFUd2p5V0tkdTV1eUpFdmZVK1hPT3lsRFJ3WDI3WHN1cVBod1Iw?=
 =?utf-8?B?Qmw0ejVvY0Q0RjBTeUJ2bTMreTZHY1lLdEhJOHN1S3pRU2JtWEtyVFV1UHo4?=
 =?utf-8?B?L2RGU1ROanoxODBoQnBVOVZmaDQrZFlQSEVlME9QYVc2WVVpbGZ4WkY0VitI?=
 =?utf-8?B?azVNRGxSR1VuVTBIcWRocGVpZlVYcXE3cWxoTlAyb2g2N0tpWng1RXdkSHpJ?=
 =?utf-8?B?VVBkZnBWYk1DejlMSmNlaUhWWUZZcnJGVlZ5cHBpdmM1bVJETHFjSjBlZG1E?=
 =?utf-8?B?cE15bGNsM3EvQVNDYk44RFZpMTJ4cHR2OXdMSnZzVFcwdWIwbkI4MWk0R2xY?=
 =?utf-8?B?ME96WDBuZ2U3ajdZWHE2czVORk5QZ2RueTBueHF4SzJnejZRYjB3SjQwOXFR?=
 =?utf-8?B?UG1DNHk2aURSQUZxQ3ArRzd2TUE3ZFUySHpjZmJacWpiVDc1UytleTlkNDhn?=
 =?utf-8?B?VCtkWE5lb054SHBHS2gzVnJWQkVuZFVOTFJlbW9aZGw0MDZ2QThDbUZ0dXph?=
 =?utf-8?B?OXdtZzN1UlJ4RkdLU0NkZkpoTk83YnFBQm9LTFhnakJ6RkJTM0lkMWNyRnVD?=
 =?utf-8?B?VXluajBLVlFVakVuVUg0M1lDZmFBMUpaRHR2NG8vbHBwUVdSV3BXMkJkRUZo?=
 =?utf-8?B?b242cHdnRTk2OXNkZ1RBV1RuenlGRUpJL21tbm9hV2xsMmxxSnlFQTlGR3Fo?=
 =?utf-8?B?cVFBTlk2Z0MxUE1UUEtYa2hBdlVySVpxL0Z1ZTFaWlBNRnF2TnNiMFNLdCtO?=
 =?utf-8?B?TUFxREJ4R1FUQXlBaWd1OXF3WmYwcW9TMytiaDhJZmJCZlBXWDNvNlI3SHlW?=
 =?utf-8?B?VnhDazJjUFhaTU1xcktaT256ZVViKzYxclYvb1ZCL1ZLV2FhcEc5SlpsZGRi?=
 =?utf-8?B?UW9sUlpUT2lLaXlhcWsyTndlVFYvWExlM3c4Y1NRNkYxelorUGhvR3gxYVU5?=
 =?utf-8?B?djVVUFFsL243QUZWZGhnNWk1QXdGZ0lDYUlrUTVXRG5heWxWTnhSOTZlSHNi?=
 =?utf-8?B?MFJxbnlhamN2cTBIYmNmK3hjS3lWazNXMVg5THY0N3NyUWlCL1ptWXFRYlNJ?=
 =?utf-8?B?QW16SHhONzlRSEVHZXFtUHRMbDFRWU5RTktpSjNPVitvbTBHci9wNnRYU1Av?=
 =?utf-8?B?TlVCdVExbUpJZmZGcVc3cXlaN3NOS0tTY0xNaFF3b1NZd0JVQnNQZ2Z6bGxH?=
 =?utf-8?B?OFVtOE5jZ1VnMjk5SGZCMFhKQmJtRVMxU3FSN3NIdktnN0s4UlpIRndUY3Vl?=
 =?utf-8?B?bWlGMVV3MWNVeVVTQnFHMjRxajZ6aVc0cUdlZHZjN01Xam1FQkY2cjVwREhk?=
 =?utf-8?Q?lHs0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3928a432-a534-49c5-0e9d-08dd094b4822
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 10:08:29.3764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4aKkwTXBJ/ZIuBU0ksNzjJJCUep3oDt5UD3Fvocf6C5+Ve4oDAGK53/ZCSS+Xm6bcRzG0Z79b8q44CCpl2etvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377

PiA+IFNvcnJ5IGFib3V0IHRoYXQuIEkgYW0gcmVkZWZpbmluZyBib3RoIHRoZSBmbGFzaCBub2Rl
cyBoZXJlIHdpdGgNCj4gPiBwcm9wZXIgaW5kZW50YXRpb24uDQo+ID4NCj4gPiBmbGFzaEAwIHsN
Cj4gPiAJY29tcGF0aWJsZSA9ICJqZWRlYyxzcGktbm9yIg0KPiA+IAkuLi4NCj4gPiAJcGFydGl0
aW9ucyB7DQo+ID4gCQljb21wYXRpYmxlID0gImZpeGVkLXBhcnRpdGlvbnMiOw0KPiA+IAkJY29u
Y2F0LXBhcnRpdGlvbiA9IDwmZmxhc2gwX3BhcnRpdGlvbiAmZmxhc2gxX3BhcnRpdGlvbj47DQo+
ID4NCj4gPiAJCWZsYXNoMF9wYXJ0aXRpb246IHBhcnRpdGlvbkAwIHsNCj4gPiAJCQlsYWJlbCA9
ICJwYXJ0MF8wIjsNCj4gPiAJCQlyZWcgPSA8MHgwIDB4ODAwMDAwPjsNCj4gPiAJCX07DQo+ID4g
CX07DQo+ID4gfTsNCj4gPg0KPiA+IGZsYXNoQDEgew0KPiA+IAljb21wYXRpYmxlID0gImplZGVj
LHNwaS1ub3IiDQo+ID4gCS4uLg0KPiA+IAlwYXJ0aXRpb25zIHsNCj4gPiAJCWNvbXBhdGlibGUg
PSAiZml4ZWQtcGFydGl0aW9ucyI7DQo+ID4gCQljb25jYXQtcGFydGl0aW9uID0gPCZmbGFzaDBf
cGFydGl0aW9uICZmbGFzaDFfcGFydGl0aW9uPjsNCj4gPg0KPiA+IAkJZmxhc2gxX3BhcnRpdGlv
bjogcGFydGl0aW9uQDAgew0KPiA+IAkJCWxhYmVsID0gInBhcnQwXzEiOw0KPiA+IAkJCXJlZyA9
IDwweDAgMHg4MDAwMDA+Ow0KPiA+IAkJfTsNCj4gPiAJfTsNCj4gPiB9Ow0KPiA+DQo+ID4+DQo+
ID4+ID4gICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZml4ZWQtcGFydGl0aW9ucyI7DQo+
ID4+ID4gICAgICAgICAgICAgICAgICAgICAgICAgY29uY2F0LXBhcnRpdGlvbiA9IDwmZmxhc2gw
X3BhcnRpdGlvbiAmZmxhc2gxX3BhcnRpdGlvbj47DQo+ID4+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgZmxhc2gwX3BhcnRpdGlvbjogcGFydGl0aW9uQDAgew0KPiA+PiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbGFiZWwgPSAicGFydDBfMCI7DQo+ID4+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgwIDB4ODAwMDAwPjsNCj4gPj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICB9DQo+ID4+ID4gICAgICAgICAgICAgICAgIH0NCj4gPj4gPiB9
DQo+ID4+ID4gZmxhc2hAMSB7DQo+ID4+ID4gICAgICAgICBjb21wYXRpYmxlID0gImplZGVjLHNw
aS1ub3IiDQo+ID4+ID4gICAgICAgICAuLi4NCj4gPj4gPiAgICAgICAgICAgICAgICAgcGFydGl0
aW9ucyB7DQo+ID4+ID4gICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZml4ZWQtcGFydGl0
aW9ucyI7DQo+ID4+ID4gICAgICAgICAgICAgICAgICAgICAgICAgY29uY2F0LXBhcnRpdGlvbiA9
IDwmZmxhc2gwX3BhcnRpdGlvbiAmZmxhc2gxX3BhcnRpdGlvbj47DQo+ID4+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgZmxhc2gxX3BhcnRpdGlvbjogcGFydGl0aW9uQDAgew0KPiA+PiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbGFiZWwgPSAicGFydDBfMSI7DQo+ID4+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgwIDB4ODAwMDAwPjsNCj4g
Pj4gPiAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+ID4+ID4gICAgICAgICAgICAgICAgIH0N
Cj4gPj4gPiB9DQo+ID4+DQo+ID4+IFRoaXMgYXBwcm9hY2ggaGFzIGEgbGltaXRhdGlvbiBJIGRp
ZG4ndCB0aGluayBhYm91dCBiZWZvcmU6IHlvdQ0KPiA+PiBjYW5ub3QgdXNlIGFueXRoaW5nIGVs
c2UgdGhhbiBmaXhlZCBwYXJ0aXRpb25zIGFzIHBhcnRpdGlvbiBwYXJzZXIuDQo+ID4NCj4gPiBZ
ZXMsIHRoYXQncyBjb3JyZWN04oCUaXQgd29uJ3QgZnVuY3Rpb24gd2hlbiBwYXJ0aXRpb25zIGFy
ZSBkZWZpbmVkIHZpYQ0KPiA+IHRoZSBjb21tYW5kIGxpbmUuIEluIG15IG9waW5pb24sIHdlIHNo
b3VsZCBzdGFydCBieSBhZGRpbmcgc3VwcG9ydCBmb3INCj4gPiBmaXhlZCBwYXJ0aXRpb25zLCBh
ZGQgY29tbWVudHMgaW4gY29kZSBzdGF0aW5nIHRoZSBzYW1lLiBJZiBuZWVkZWQsIHdlDQo+ID4g
Y2FuIGxhdGVyIGV4dGVuZCB0aGUgc3VwcG9ydCB0byBkeW5hbWljIHBhcnRpdGlvbnMgYXMgd2Vs
bC4NCj4gDQo+IE5ldyB0aG91Z2h0LiBXaGF0IGlmIGl0IHdhcyBhIHB1cmUgZml4ZWQtcGFydGl0
aW9uIGNhcGFiaWxpdHk/IFRoYXQncyBhY3R1YWxseSB3aGF0IHdlDQoNClllcywgSSBhZ3JlZeKA
lGl04oCZcyBiZXR0ZXIgdG8gcHJlc2VudCBpdCBhcyBhIHB1cmVseSBmaXhlZC1wYXJ0aXRpb24g
Y2FwYWJpbGl0eS4NCg0KDQpSZWdhcmRzLA0KQW1pdA0KPiB3YW50OiBkZWZpbmluZyBmaXhlZCBw
YXJ0aXRpb25zIHRocm91Z2ggZGV2aWNlIGJvdW5kYXJpZXMuIEl0IGF1dG9tYXRpY2FsbHkgcmVt
b3Zlcw0KPiB0aGUgbmVlZCBmb3IgZnVydGhlciBkeW5hbWljIHBhcnRpdGlvbiBleHRlbnNpb25z
Lg0KPiANCj4gVGhhbmtzLA0KPiBNaXF1w6hsDQo=

