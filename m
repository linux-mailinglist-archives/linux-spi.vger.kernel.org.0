Return-Path: <linux-spi+bounces-5753-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F083D9D2C07
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2024 18:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A6F41F24A98
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2024 17:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088EF43179;
	Tue, 19 Nov 2024 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ohoiYCxV"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD8A211C;
	Tue, 19 Nov 2024 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035786; cv=fail; b=Gh7wvZvvGoew+77imHNjGn6YzLbEx7RCqNrY/FUq788s2m4bhY9KV4igYY7vy3uuUw9by+kpW7boLeTpIkC8ySaSNwoxpcMzaHmkBxtj7c2wz9MSJlnpuWNYZFrXyHdHRZSDg9U4gI+Js0oqB5R1QIB5iAbHlx8s258NvoYmWDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035786; c=relaxed/simple;
	bh=Pz14/Ddns9Ga8ORD+3EtvpHefIGt5Z/kel/pk7LcMuM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rje32G9v/2hJ8zGAqMoABdxspnIKtRyeTeWH7jN5RM28Asp4kpXglGtSUYBomzUlBHT8jhafdgXpLDQWzumybHsg288XqHv90z2cokoES23VJby95wvahuKA6HBWFTLGRPU5k+3pJFU9Jd0aNPnkXAXAozAX3QaF+nEa2rSljEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ohoiYCxV; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkJ826rpiShIgTyd6qiBTlcEW9FAIDOF7OghG3k+QMbGepNBfZ+NS+1GaNFrugNnO5hOo3UIP/OlrFTBpAa00w1SHvZKUGZ8iuKfYRlNXhrUxF7GxNWrouM8cLBIKaHWpli86xuFm4TWpol9dixS7VO3i03h+TpR8HTLHAu5IwwKSC7SnWHsmNxInt6qoBbUDKk5pCGJ13aMuIcWCRdFjFTkbxHi4asw43gVgK91OR07dy+8YPSZJaLYCUxj7klV9yYiw0FU138KAvF/iP0Mph2Vm8IMuKlrfrC/KrXLf3xV0mHq1rG8yNKm9yc1TBfTwGzykC28AcDcOSl80l0rtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pz14/Ddns9Ga8ORD+3EtvpHefIGt5Z/kel/pk7LcMuM=;
 b=g1T9CTfEnSHv+uvSqHvzfm12JeAU7LATtR+XfkcFV4fdMH4IBbBp9v2iGzJuG27H4hdj9LSvWDjJm/2SKETRM9xOc2iQONli8/mmu6T75IqXPvQ1aoIAHGmadJVJbye3RmoUd49iN6L+PgqMZjQEQQVQMwhPmqMyVt6L5FdIJlKxoFPdj80b4nHszEbTtfYmfepoSav7U0TbLpzuJH6+P5f+JhrycGE9u/0gE3C8NSZN8GXYWxUKmzN0qApHhUQk6hpB21yUGQ8WNbXJ1Eslp8tBLi8WKKzXaNOBX8n7nMKO9H9RATabTCzN4yegcXQLFFmxtRQepa/cu/CvxGE2Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pz14/Ddns9Ga8ORD+3EtvpHefIGt5Z/kel/pk7LcMuM=;
 b=ohoiYCxViaRiTLw0EPH+DrJUVmTKDYpne+Gm3pWuXVnqNmmyJjlrAxZl9s48GnyUzeVrWgRkIfVRBTH84aLPpJxWg3e4bNQ1cmczRCGKiUJ312jUjfvCzxADKYPdW9qMWal/xlkrx+0Ie2SZO1OZFiKHVzNuSwUpAhBonGjjUKg=
Received: from IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 by CH3PR12MB9172.namprd12.prod.outlook.com (2603:10b6:610:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 17:02:45 +0000
Received: from IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa]) by IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa%5]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 17:02:45 +0000
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
Subject: RE: [RFC PATCH 2/2] dt-bindings: spi: Update stacked and parallel
 bindings
Thread-Topic: [RFC PATCH 2/2] dt-bindings: spi: Update stacked and parallel
 bindings
Thread-Index: AQHbJ3xFSrN5RV0JF06yVz3ubrcEDbK9L7UAgAFyenA=
Date: Tue, 19 Nov 2024 17:02:45 +0000
Message-ID:
 <IA0PR12MB769947EEA7AB4D9DFF0B2510DC202@IA0PR12MB7699.namprd12.prod.outlook.com>
References: <20241026075347.580858-1-amit.kumar-mahapatra@amd.com>
	<20241026075347.580858-3-amit.kumar-mahapatra@amd.com>
 <87y11gwtij.fsf@bootlin.com>
In-Reply-To: <87y11gwtij.fsf@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7699:EE_|CH3PR12MB9172:EE_
x-ms-office365-filtering-correlation-id: efec48f3-f804-4866-ed81-08dd08bbfd3a
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SnVSeU5ETXlTRVRWSXdzUGJSSzIvdEtENXQyYTFGZG1qZmFPa3NXRXE0ZHAr?=
 =?utf-8?B?Y1RuK2ZYakhVWjhJWDU1K2RtR05ZZmVlSTdwTTJrNy9RVnNFeXZmanR2VVRG?=
 =?utf-8?B?ZXhWeHhpWjNUM2JSTndvYUJLMW1HQlQ5ajVZR016eHhGR09oMFgvSGJ3NHRX?=
 =?utf-8?B?bDBQb29PcU1OZlN3UTUxRVJFYzlYQm0yMEh4czVzcHN4Wkl3RWV5Y2FhWEFY?=
 =?utf-8?B?WFRxbkduMlozZEdUMzg1T0F0YjhOckpVUzdXTGtiaG9SSWZrd0R1dnpybTBt?=
 =?utf-8?B?alQ2Y3d6VEg2K2szUHNBYWR3TEpuV1kyNzB4STZBRE1mQ1pjbGRZejVpdGtL?=
 =?utf-8?B?NnpwOUVoWHBqdStycGlmNUNmNEVmNkZBZlY0WjVqQTdUR292TzZEdzcrRHZI?=
 =?utf-8?B?TTkrU0w4dDYraUZLTXU0RDEreGJvUVR5YlRwQmdibW9qUUVOS29RNmJ0MjBN?=
 =?utf-8?B?YWVEeEhhVk04WHR1SFZNVmh3YnozZ1ZlV1h2SWl2dFRBNkt1NzdUYmZWZ0JM?=
 =?utf-8?B?N1Bzc2o1VE9HVDE1M3hWU0pHdy9qS1RZWWlpMEZjUWFsL1hMdHp5S1pqTjVH?=
 =?utf-8?B?RkFUVjB4bVlSelVZQXdNVGJkVHBqdVA0MTdlM0NnMkRYTU1SWDB4OVgrOE9H?=
 =?utf-8?B?NmQ2TTlSbk5YYlZkcFJHbWx1SU1PT1RSV2FUUkVLKysvL3U3MktOd1JFbXVY?=
 =?utf-8?B?SkoxVFFvbnVCdDRJb2RFZDVtV2k3Tk8zaDNod2JlUkc0NmNzUi95djhiSVFs?=
 =?utf-8?B?RmRwaC91ckR5Z2dBbVVlbGpIMzArZm1IVWVjNUNaUnMwMXRmVzl0bEtkWm94?=
 =?utf-8?B?OU9qck5WMlg2MHBOb09CcDhiMXlra1c4czZlMCtrRWREWTBvQ3JNYnFSV1Zk?=
 =?utf-8?B?cmV6TjRyR0F5ejBDNEkxVmpVeW1WYU5DV3pDcjhmSk10VFRlN292TnErZU0z?=
 =?utf-8?B?TXBPRDc2azZvMEtTZnVBOC9lUnNZR1hBTnpHakxRVFpJeHBMbytXSzdldGdK?=
 =?utf-8?B?N3ZYUi9MYlF0UlQxNnZHSlpoMS9IaUdBMVZhdjcxQkRJeGtmSjVXTUdUR2Rh?=
 =?utf-8?B?WGx0b3luNXFheGVuRi9CWm9nYTFSSzZRK2xxOHdiNEpNVWlSOFduN2NNanJR?=
 =?utf-8?B?T0pYczNiWXpRSS9rRHVpdE5mU0o3VC9BSmJ5R2hBZHdoT1RibFpQcEl2YU1J?=
 =?utf-8?B?c25HL0ZWcUNjd1lYS1BKOVI3WUljaG5OaWJ5K2pqS2M4ZmpuNDJNbjVrM1do?=
 =?utf-8?B?MDdZS2NOSENSdGdSNDZBS0VUcWRxQjhZSUFzU2Zuc2JkRzNUNkVnQWhzbDN3?=
 =?utf-8?B?cU9NNFJVTXF1TU5EQWRGRllrVHRTM3EyYTljdnJ0VUxRZWliTnRGUzR5Tzgv?=
 =?utf-8?B?YTc3SkFMMWdBOXhoYnJoR1VEaHJLb05RV3ArODUyRGdQeTZBVXVmSkw2Mnpx?=
 =?utf-8?B?QjhacjZ6NTVQZG91Sjd2cHRaMGppYWlQOWlHeDU4dVBDZTc2RXpjQ0tveERP?=
 =?utf-8?B?dnovRXpoRGs4L0VmcE1xcEpOc240dEhtSjZETklZdHgwMnlqUHROQ3dmaVd2?=
 =?utf-8?B?WEFMRnhaU2NRbFpqYTZjRW50UWpOVHN3TW04MVBFemxoYUFiSlBuRC9waWU4?=
 =?utf-8?B?V1hQY3BBZForRmpIN0FpYzJKZW4wdE1QRzBJSFFqV0RzMnVDQmd4RFBtd0t0?=
 =?utf-8?B?UkFPcnZVWHNLcXN5bUZ2d0ZRaG85UlNlZ2xNb2J0bzlIanlHN3NSY3Nic2lI?=
 =?utf-8?B?VVo5Z082YWxrVHN0Rk1HbFBxTithbVBLb2FLY2oxeDRkazNNRngrSEM5NEhQ?=
 =?utf-8?B?YlpzL0RuenNyYkM5d0d1KzJrSCtJTkpKOVNYbkdwN1pkME10SkFYaTRFUVZH?=
 =?utf-8?Q?27lGiZXYEbPTU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7699.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VmZ6NVowNDdmOVV1WWpnUGtuaWFUZ2hIQ0QwUFNCTmxQcVZwWDF6NHhPMjBI?=
 =?utf-8?B?R0RCd2tHSTMrSG9VVmtrVTcvbFI3b3JTK3pQQmEvTTBpWGxobmlQcDY1MDgr?=
 =?utf-8?B?Wnl6YkRzcU9JbHBibzhFbXZwenBDU0hTV082MENQbms1Y0tzcDltalNzMDlJ?=
 =?utf-8?B?cDYyeXZCRGQxQUlwVWZzS3VGSzYybzRTekVIODM4cGhYNHNUU2NDWVo3TVZE?=
 =?utf-8?B?VEJMckFwU2tnSlJpTm91MXBYSlRMVVJxQ0Rld282V1RrWWNqdndZL2t3V3A1?=
 =?utf-8?B?ZDZ2TzFYMXpYWGZOalpKQk1rVHBQajRTOG5IVDd1TmJjZlhhZVpNSSttbWp5?=
 =?utf-8?B?cVVST0FWNEswSjZwV0l3d2grRVU5UnB0N3oxRUkzeDAvS2VGc0tTOExGOVJ2?=
 =?utf-8?B?SWd1cmNCdlJKY01LdFBqM2dhVG1yZWFuT2h4aEdHY3BhTUFtNE1CUG9wenk4?=
 =?utf-8?B?dUpEUzBZZ1UyandiRVNtMmFRREFZeXFzcWI3aFA2bXJmS0lweUFPUllYckxN?=
 =?utf-8?B?MWVlMzMrYisxVkcrMWE1RE5iK1BScU9VbTJhYVI2bUJ2cGdMTE1aRWV6SjQv?=
 =?utf-8?B?K2RTdHhJODh5TXJqcEtPYnhTdTlHU0NxOE8vY2w5K1FZL1FWMXROMm1BMGFn?=
 =?utf-8?B?ZytYY2pxMG8ycFFZY1VMMTV0U2ViZUNVRjBrTitiTVVBb0VTMDh0ei9xaGNU?=
 =?utf-8?B?R1JhazIxTTcxTy82M2FOWXF1VXB6VEhOdkhSdEV4R3NHdDl1WWZxR1dQOFFG?=
 =?utf-8?B?S0tBcjRHdEcrb0xLK3o5UnBVY0pjYlhtUFBJV1d1b09Jc21jWmdGbTdpMW5H?=
 =?utf-8?B?bXhPUnZlelJhS1RxWEloRW1PM3F4cGgzR2xCWmdHcFdMeWlCbVdjcjc4cFhu?=
 =?utf-8?B?WXNORndZWDlQd0piRmJWc2UyTTg0SDlHZnhWNENheStUOGJiWXIrL0ZlTVVR?=
 =?utf-8?B?NFVIZTBtTm4xZXoyVUZzeTBGenNsMWxob0RqeDdVU2ZBSU5oUmcvdklJQnBr?=
 =?utf-8?B?ZHJLZ2pwVHZiZWcwVzFpWHZoOEc3bTVCUEo1a1BVTlF5SW1pUGx1QnlCTU5I?=
 =?utf-8?B?WjM5SzA4ZlFBV3dZQlZOQXRYWHlJdVdHdjBxN2Z0SDFrNk90ZXFoQmdFUko2?=
 =?utf-8?B?c0Ztd2owK2pXREhjcEFoamswK3NTRDlveWw2ekF1ZnpBdHdoR0dKZFkwekJE?=
 =?utf-8?B?cC9td3EyQlBOWGFsWXBjalJCNVdGOG5qZnFKV3NZRGtTUWNmRjA0c3hNdE5t?=
 =?utf-8?B?UEtmVkpNNG9HTW5yNEVxVlQ4TG5ta0lNRGh1Z2VJZGZmVGdmUUkwamYxRDFJ?=
 =?utf-8?B?cWxlWm9EbUVMTjJBOVAxbnQ3Ry9sRC83ZTY5cHgvVlhicTZMZGVBU0ZWSkhh?=
 =?utf-8?B?QzVOTFJ0RWJtT3ArbFBnMG1xZnptQ2E3NmtCbytKU1kxRjIwMFE5dS82dTg0?=
 =?utf-8?B?Q3VVUXFZaEozNXZDWDhXVU9ta2VTdFo0Ym1BaUM3ZnV0bVJHT3JhYVd0UzRt?=
 =?utf-8?B?ZXhKQ2RoTWxsUWs3YmxMcjlWL042QjBCU25LUUY4NmJHTC9tK2wvWnNjWXQv?=
 =?utf-8?B?T0I2a2tjZWxWZzNlWDJYaGpaVytvbXBCb0k5NVNieFJBV1JpbUQ3UXFOWi9h?=
 =?utf-8?B?bnVOSFUxWGVZbm9zS2dMS00wbmd3d0RnYW9JbGhUV2lRMTBqbjVEMkVOdnBt?=
 =?utf-8?B?ek9DVExjbzNtQTVPRDBUV2JjeGMxUEFaQjB1S3VmZHc3YVpDNWxmOHpLazdl?=
 =?utf-8?B?cjFNNmtia0RmYUw5Z0dFZWhRTFBaQjJpRUhLQ2VGa1lyUnhBRHhIWThTYTBz?=
 =?utf-8?B?OE43Uk54T05odGRIYXJlY0RFUnRsTUMzL1RaRkpvV2R2c2RLRlNrN0FiOXpp?=
 =?utf-8?B?RlhyVTZ3Sy9VUlI2Q1FNYTNPZmcxcjhLUzhyWmg2NXFtK1FPdkpkZEVZWUdw?=
 =?utf-8?B?QXJKZE9BeDlkbEVXMVpDTjNFeStYVlk5RURlWi9uaDFCRE1sRWdpVzR1UUxt?=
 =?utf-8?B?R24wZHBuNHJwdDFaZnc4aHl4VzU4QVdqeWhLaW5RUTlFQjZtRWlVVUxGcXZm?=
 =?utf-8?B?Qzcrckg5cUorNmt1bDE4YVFLRFBwN05mbUZIeXI5eHN3aHN3QXAvZzFjVXRa?=
 =?utf-8?Q?w2F4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: efec48f3-f804-4866-ed81-08dd08bbfd3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 17:02:45.6852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhk0NGQ5btGCUw0bYipy0uoYP4Bw3F1aJn5puSmxbvS2PHaaG4pJGvWpMVPo60VDSVOxzqQgP+a0ff5OfXdJ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9172

SGVsbG8gTWlxdWVsLA0KDQo+ID4gICAgICAgICBmbGFzaEAxIHsNCj4gPiAgICAgICAgICAgICAg
ICAgY29tcGF0aWJsZSA9ICJqZWRlYyxzcGktbm9yIg0KPiA+ICAgICAgICAgICAgICAgICByZWcg
PSA8MHgwMT47DQo+ID4gICAgICAgICAgICAgICAgIHN0YWNrZWQtbWVtb3JpZXMgPSA8JmZsYXNo
QDAgJmZsYXNoQDE+Ow0KPiA+ICAgICAgICAgICAgICAgICBzcGktbWF4LWZyZXF1ZW5jeSA9IDw1
MDAwMDAwMD47DQo+ID4gICAgICAgICAgICAgICAgIC4uLg0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgIHBhcnRpdGlvbnMgew0KPiANCj4gU2FtZSBjb21tZW50IGFzIGJlZm9yZSBoZXJlLg0K
DQpTb3JyeSBhZ2FpbiANCg0Kc3BpQDAgew0KCS4uLg0KCWZsYXNoQDAgew0KCQljb21wYXRpYmxl
ID0gImplZGVjLHNwaS1ub3IiDQoJCXJlZyA9IDwweDAwPjsNCgkJc3RhY2tlZC1tZW1vcmllcyA9
IDwmZmxhc2hAMCAmZmxhc2hAMT47DQoJCXNwaS1tYXgtZnJlcXVlbmN5ID0gPDUwMDAwMDAwPjsN
CgkJLi4uDQoJCXBhcnRpdGlvbnMgew0KCQkJY29tcGF0aWJsZSA9ICJmaXhlZC1wYXJ0aXRpb25z
IjsNCgkJCWNvbmNhdC1wYXJ0aXRpb24gPSA8JmZsYXNoMF9wYXJ0MCAmZmxhc2gxX3BhcnQwPjsN
CgkJCQ0KCQkJZmxhc2gwX3BhcnQwOiBwYXJ0aXRpb25AMCB7DQoJCQkJbGFiZWwgPSAicGFydDBf
MCI7DQoJCQkJcmVnID0gPDB4MCAweDgwMDAwMD47DQoJCQl9Ow0KCQl9Ow0KCX07DQoJZmxhc2hA
MSB7DQoJCWNvbXBhdGlibGUgPSAiamVkZWMsc3BpLW5vciINCgkJcmVnID0gPDB4MDE+Ow0KCQlz
dGFja2VkLW1lbW9yaWVzID0gPCZmbGFzaEAwICZmbGFzaEAxPjsNCgkJc3BpLW1heC1mcmVxdWVu
Y3kgPSA8NTAwMDAwMDA+Ow0KCQkuLi4NCgkJcGFydGl0aW9ucyB7DQoJCQljb21wYXRpYmxlID0g
ImZpeGVkLXBhcnRpdGlvbnMiOw0KCQkJY29uY2F0LXBhcnRpdGlvbiA9IDwmZmxhc2gwX3BhcnQw
ICZmbGFzaDFfcGFydDA+Ow0KCQkJDQoJCQlmbGFzaDFfcGFydDA6IHBhcnRpdGlvbkAwIHsNCgkJ
CQlsYWJlbCA9ICJwYXJ0MF8xIjsNCgkJCQlyZWcgPSA8MHgwIDB4ODAwMDAwPjsNCgkJCX07DQoJ
CX07DQoJfTsNCn07DQoNCj4gDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJs
ZSA9ICJmaXhlZC1wYXJ0aXRpb25zIjsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbmNhdC1wYXJ0aXRpb24gPSA8JmZsYXNoMF9wYXJ0aXRpb24gJmZsYXNoMV9wYXJ0aXRp
b24+Ow0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmxhc2gxX3BhcnRpdGlv
bjogcGFydGl0aW9uQDAgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBsYWJlbCA9ICJwYXJ0MF8xIjsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgcmVnID0gPDB4MCAweDgwMDAwMD47DQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB9DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiA+ICAgICAg
ICAgfQ0KPiA+DQo+ID4gfQ0KPiA+DQo+ID4gcGFyYWxsZWwtbWVtb3JpZXMgYmluZGluZyBjaGFu
Z2VzOg0KPiA+IC0gUmVtb3ZlIHRoZSBzaXplIGluZm9ybWF0aW9uIGZyb20gdGhlIGJpbmRpbmdz
IGFuZCBjaGFuZ2UgdGhlIHR5cGUgdG8NCj4gPiAgIGJvb2xlbi4NCj4gPiAtIEVhY2ggZmxhc2gg
Y29ubmVjdGVkIGluIHBhcmFsbGVsIG1vZGUgc2hvdWxkIGJlIGlkZW50aWNhbCBhbmQgd2lsbCBo
YXZlDQo+ID4gICBvbmUgZmxhc2ggbm9kZSBmb3IgYm90aCB0aGUgZmxhc2ggZGV2aWNlcy4NCj4g
PiAtIFRoZSDigJxyZWfigJ0gcHJvcCB3aWxsIGNvbnRhaW4gdGhlIHBoeXNpY2FsIENTIG51bWJl
ciBmb3IgYm90aCB0aGUgY29ubmVjdGVkDQo+ID4gICBmbGFzaGVzLg0KPiA+DQo+ID4gVGhlIG5l
dyBsYXllciB3aWxsIGRvdWJsZSB0aGUgbXRkLT4gc2l6ZSBhbmQgcmVnaXN0ZXIgaXQgd2l0aCB0
aGUgbXRkDQo+ID4gbGF5ZXIuDQo+IA0KPiBOb3Qgc28gc3VyZSBhYm91dCB0aGF0LCB5b3UnbGwg
bmVlZCBhIG5ldyBtdGQgZGV2aWNlIHRvIGNhcHR1cmUgdGhlIHdob2xlIGRldmljZS4NCj4gQnV0
IHRoaXMgaXMgaW1wbGVtZW50YXRpb24gcmVsYXRlZCwgbm90IHJlbGV2YW50IGZvciBiaW5kaW5n
Lg0KPiANCj4gPg0KPiA+IHNwaUAxIHsNCj4gPiAgICAgICAgIC4uLg0KPiA+ICAgICAgICAgZmxh
c2hAMyB7DQo+ID4gICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiamVkZWMsc3BpLW5vciIN
Cj4gPiAgICAgICAgICAgICAgICAgcmVnID0gPDB4MDAgMHgwMT47DQo+ID4gICAgICAgICAgICAg
ICAgIHBhcmFsbGUtbWVtb3JpZXMgOw0KPiANCj4gUGxlYXNlIGZpeCB0aGUgdHlwb3MgYW5kIHRo
ZSBzcGFjaW5nIChzYW1lIGFib3ZlKS4NCj4gDQo+ID4gICAgICAgICAgICAgICAgIHNwaS1tYXgt
ZnJlcXVlbmN5ID0gPDUwMDAwMDAwPjsNCj4gPiAgICAgICAgICAgICAgICAgLi4uDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgcGFydGl0aW9ucyB7DQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgY29tcGF0aWJsZSA9ICJmaXhlZC1wYXJ0aXRpb25zIjsNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGZsYXNoMF9wYXJ0aXRpb246IHBhcnRpdGlvbkAwIHsNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbGFiZWwgPSAicGFydDBfMCI7
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDAg
MHg4MDAwMDA+Ow0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgIH0NCj4gPiB9DQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBBbWl0IEt1bWFyIE1haGFwYXRyYSA8YW1pdC5rdW1hci1tYWhhcGF0cmFA
YW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL3NwaS9zcGktY29udHJvbGxlci55
YW1sICAgICAgICAgIHwgMjMgKysrKysrKysrKysrKysrKystLQ0KPiA+ICAuLi4vYmluZGluZ3Mv
c3BpL3NwaS1wZXJpcGhlcmFsLXByb3BzLnlhbWwgICAgfCAgOSArKystLS0tLQ0KPiA+ICAyIGZp
bGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktY29u
dHJvbGxlci55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3Bp
L3NwaS1jb250cm9sbGVyLnlhbWwNCj4gPiBpbmRleCAwOTMxNTBjMGNiODcuLjJkMzAwZjk4ZGQ3
MiAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3Bp
L3NwaS1jb250cm9sbGVyLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3Mvc3BpL3NwaS1jb250cm9sbGVyLnlhbWwNCj4gPiBAQCAtMTg1LDcgKzE4NSwyNiBA
QCBleGFtcGxlczoNCj4gPiAgICAgICAgICBmbGFzaEAyIHsNCj4gPiAgICAgICAgICAgICAgY29t
cGF0aWJsZSA9ICJqZWRlYyxzcGktbm9yIjsNCj4gPiAgICAgICAgICAgICAgc3BpLW1heC1mcmVx
dWVuY3kgPSA8NTAwMDAwMDA+Ow0KPiA+IC0gICAgICAgICAgICByZWcgPSA8Mj4sIDwzPjsNCj4g
PiAtICAgICAgICAgICAgc3RhY2tlZC1tZW1vcmllcyA9IC9iaXRzLyA2NCA8MHgxMDAwMDAwMCAw
eDEwMDAwMDAwPjsNCj4gPiArICAgICAgICAgICAgcmVnID0gPDI+Ow0KPiA+ICsgICAgICAgICAg
ICBzdGFja2VkLW1lbW9yaWVzID0gPCZmbGFzaDAgJmZsYXNoMT47DQo+ID4gICAgICAgICAgfTsN
Cj4gDQo+IEknbSBzb3JyeSBidXQgdGhpcyBpcyBub3Qgd2hhdCB5b3UndmUgdGFsa2VkIGFib3V0
IGluIHRoaXMgc2VyaWVzLg0KPiBFaXRoZXIgeW91IGhhdmUgZmxhc2gwIGFuZCBmbGFzaDEgYW5k
IHVzZSB0aGUgc3RhY2tlZC1tZW1vcmllcyBwcm9wZXJ0eSBpbiBib3RoIG9mDQo+IHRoZW0gKHdo
aWNoIGlzIHdoYXQgeW91IGRlc2NyaWJlZCkgb3IgeW91IGNyZWF0ZSBhIHRoaXJkIHZpcnR1YWwg
ZGV2aWNlIHdoaWNoIHBvaW50cw0KPiB0byB0d28gb3RoZXIgZmxhc2hlcy4gVGhpcyBleGFtcGxl
IGFsbG93cyBmb3IgYW4gZWFzaWVyIHVzZSBvZiB0aGUgcGFydGl0aW9ucw0KDQpJZiBJIHVuZGVy
c3RhbmQgeW91ciBwb2ludCBjb3JyZWN0bHksIHlvdSdyZSBzdWdnZXN0aW5nIHRoYXQgd2Ugc2hv
dWxkIA0KYXZvaWQgdXNpbmcgc3RhY2tlZC1tZW1vcmllcyBhbmQgY29uY2F0LXBhcnRpdGlvbiBw
cm9wZXJ0aWVzIHRvZ2V0aGVyIGFuZCANCmluc3RlYWQgY2hvb3NlIG9uZSBhcHByb2FjaC4gQmV0
d2VlbiB0aGUgdHdvLCBJIGJlbGlldmUgY29uY2F0LXBhcnRpdGlvbiANCndvdWxkIGJlIHRoZSBi
ZXR0ZXIgb3B0aW9uLg0KDQpXaGlsZSBsb29raW5nIGludG8geW91ciBtdGRjb25jYXQgcGF0Y2gg
WzFdLCBJIG5vdGljZWQgdGhhdCBpdCBjcmVhdGVzIGEgDQp2aXJ0dWFsIE1URCBkZXZpY2UgdGhh
dCBwb2ludHMgdG8gcGFydGl0aW9ucyBvbiB0d28gZGlmZmVyZW50IGZsYXNoIG5vZGVzLCANCndo
aWNoIGFsaWducyBwZXJmZWN0bHkgd2l0aCBvdXIgcmVxdWlyZW1lbnRzLg0KDQpIb3dldmVyLCB0
aGVyZSBhcmUgdHdvIGtleSBjb25jZXJucyB0aGF0LCBpZiBhZGRyZXNzZWQsIGNvdWxkIG1ha2Ug
dGhpcyANCnBhdGNoIHN1aXRhYmxlIGZvciB0aGUgc3RhY2tlZCBtb2RlOg0KDQoxLyBUaGUgY3Jl
YXRpb24gb2YgYSB2aXJ0dWFsIGRldmljZSB0aGF0IGRvZXMgbm90IGhhdmUgYSBwaHlzaWNhbCAN
CmV4aXN0ZW5jZS4NCg0KMi8gVGhlIGNyZWF0aW9uIG9mIGluZGl2aWR1YWwgTVREIGRldmljZXMg
dGhhdCBhcmUgY29uY2F0ZW5hdGVkIHRvIGZvcm0gDQp0aGUgdmlydHVhbCBNVEQgZGV2aWNlLCB3
aGljaCBtYXkgbm90IGJlIG5lZWRlZCBieSB0aGUgdXNlci4NCg0KUmVnYXJkaW5nIHRoZSBmaXJz
dCBwb2ludCwgSSBjdXJyZW50bHkgY2Fubm90IHRoaW5rIG9mIGEgYmV0dGVyIGdlbmVyaWMgDQp3
YXkgdG8gc3VwcG9ydCB0aGUgc3RhY2tlZCBmZWF0dXJlIHRoYW4gY3JlYXRpbmcgYSB2aXJ0dWFs
IGRldmljZS4NClBsZWFzZSBsZXQgbWUga25vdyB5b3UgdGhvdWdodHMgb24gdGhpcy4NCg0KRm9y
IHRoZSBzZWNvbmQgcG9pbnQsIG9uZSBwb3NzaWJsZSBzb2x1dGlvbiBpcyB0byBoaWRlIHRoZSBp
bmRpdmlkdWFsIE1URCANCmRldmljZXMgKHRoYXQgZm9ybSB0aGUgY29uY2F0ZW5hdGVkIHZpcnR1
YWwgTVREIGRldmljZSkgZnJvbSB0aGUgdXNlciBvbmNlIA0KdGhlIHZpcnR1YWwgZGV2aWNlIGlz
IGNyZWF0ZWQuIFBsZWFzZSBsZXQgdXMga25vdyBpZiB5b3UgaGF2ZSBhbnkgb3RoZXIgDQpzdWdn
ZXN0aW9ucyB0byBhZGRyZXNzIHRoaXMgaXNzdWUuDQoNClsxXSBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1tdGQvMjAxOTExMjcxMDU1MjIuMzE0NDUtNS1taXF1ZWwucmF5bmFsQGJvb3Rs
aW4uY29tLyANCg0KUmVnYXJkcywNCkFtaXQNCg0KPiBtZWNoYW5pc20gb24gdG9wIG9mIGEgdmly
dHVhbCBtdGQgZGV2aWNlIGJ1dCwgaGVoLCB5b3UncmUgbm93IGRlc2NyaWJpbmcgYSB2aXJ0dWFs
DQo+IG10ZCBkZXZpY2UsIHdoaWNoIGlzIG5vdCBhIHBoeXNpY2FsIGRldmljZSBhcyBpdCAic2hv
dWxkIiBiZS4NCj4gDQo+IFRoYW5rcywNCj4gTWlxdcOobA0K

