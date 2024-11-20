Return-Path: <linux-spi+bounces-5782-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6169D38E9
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 12:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3521E1F23F83
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 11:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF69519F47A;
	Wed, 20 Nov 2024 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OtRzy0e7"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B293319F13F;
	Wed, 20 Nov 2024 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732100283; cv=fail; b=LWeIRJA/Y801EazCXw2Wae4fU4P/Tha3krSet13lMLtKki3CdYQtjgsMnBU5j1M715ZnWI/+G3NmhifQ98kZlglDDTTIr5sorf7bgieJ6PACgLv0+bnzl9GmkMdOty8BwXRh06fI2O51pDM0lpbMzvlXC8TQ9vQqU8ccQI90WOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732100283; c=relaxed/simple;
	bh=1zDJTJqHsi8Kkr9uij6iqWeYPRkg9g84CDyXNVgfg7g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PUK1uyXzr3HM+FASS8airsujYaVgkleUl9bYXcERb3EVe1p7HVi7NVatvnFBZymSRnD2bnHN4tEalwxwSfo86svkIyLGqFy9bWrp7qgUIc6PkQBHTpd18/k5btfqiUUeWf7CCKwMjgU45NeUxJtA6rUJR+zUmS06oslHuzZ+gDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OtRzy0e7; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQU9ADo+W3W66OO8LaTWNcrTXeL4Ex9U+Aek1HMadkyJk/d22/7rk9+OdM5HkiVu6Ph+JYssUCV4UE6ht2y777tvUHC2iQ7FVIEr4DvyN5J7+GdLZ5N8SvJLNMfFnP1E/2Te2GlO4SeUQZ+tXofxcehONWRV8oZUoUhiU8i0NCg3rHNldB6VsR4Fwa49V25T68lj74IY6Rtd3wok/2Qh588J4/m1JOpzZbzvA4bsF1LKqfdkt4v1Q4yb+mewYa6STf2sKqcf8n7h/lS6i8g8/Oa7CghTv1SOO9vZlqAquJcDt9VO7iwmODSGXfBGnBI0Ji1/Rc9mmMCtG5qBNYZ+nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zDJTJqHsi8Kkr9uij6iqWeYPRkg9g84CDyXNVgfg7g=;
 b=PXvz97YsinrYhZ7WWpWR5ctZ+Et2iZckXM7DGScXX9a69xes8C+TOaK8RYOtDoxlL5ay2BgXUVIGPLZCG1UVMSgCjGivMbXDK4aoRbefvPiAOXjak0y2Mm2msyW45x2yFMYgBQLowPjNAm7Os/4A9Zcthdkgpsd90z1iqoi6TdpyhmsXtoYlcWLuwyNZsgk3P1TDFWx3QLRFbLPLaukLlXW2MIZs7QSSeoffLkkbfAgNkTe3Cwot7DgPG8/3UKacdvwTUEOUsoV90dOpnSKWJF9pRfgU2CnFjzwXpr1wfKueGBRcG+lN/bA3B8qvkVcxRSPbpmJARc0bOD330WtndQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zDJTJqHsi8Kkr9uij6iqWeYPRkg9g84CDyXNVgfg7g=;
 b=OtRzy0e7dKxt/UhyI2dtrmcVRXKpvt0i04StwzT7QMGUCanXHQt6RfApH43gy6wQT2UCDERlgK0KJq+ti18NAHgCkZRPYWkfe/YeT/Y2zzufwV6kzPlJLLug9jU4kM0NT9brRGDfTvhJ2Tap4Z+KUOqMreheBdzeE90WdbX/fDg=
Received: from IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 10:57:55 +0000
Received: from IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa]) by IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa%5]) with mapi id 15.20.8158.021; Wed, 20 Nov 2024
 10:57:55 +0000
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
Thread-Index: AQHbJ3xFSrN5RV0JF06yVz3ubrcEDbK9L7UAgAFyenCAAXRLzYAACNRw
Date: Wed, 20 Nov 2024 10:57:55 +0000
Message-ID:
 <IA0PR12MB7699ED80FAAFD3CF0B4F5502DC212@IA0PR12MB7699.namprd12.prod.outlook.com>
References: <20241026075347.580858-1-amit.kumar-mahapatra@amd.com>
	<20241026075347.580858-3-amit.kumar-mahapatra@amd.com>
	<87y11gwtij.fsf@bootlin.com>
	<IA0PR12MB769947EEA7AB4D9DFF0B2510DC202@IA0PR12MB7699.namprd12.prod.outlook.com>
 <87bjyaxm4y.fsf@bootlin.com>
In-Reply-To: <87bjyaxm4y.fsf@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7699:EE_|IA0PR12MB8327:EE_
x-ms-office365-filtering-correlation-id: 389a048f-0a9a-4d75-e2e4-08dd09522fe2
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R0NOZHVSL2diclVPQnJiQ1BxM2dzTkxrWVRBblZ0SVYwcjBBdXB6OWk1MmVn?=
 =?utf-8?B?emZSZFBrYzhpQVNZK3owVTRUUG80ZmlWdTFxUldlMHhaUytVOTNyVVZ2UnVt?=
 =?utf-8?B?T3BJL2hvdlQ1TFpkR1UzNEdmZ3FveHdrdS9GcHNZWlY1Tm5hakNTYlZIVnE2?=
 =?utf-8?B?bnVHakRSTzFNR01FWlVqRi9PYjEvK3VEbjJOMDYvdFZEQXlNeFd6S0E2Y1RQ?=
 =?utf-8?B?ZUs3akVGaHh2Q1RhUGpTallBbEV4alkra0VHcWsxS3FObjJSajJwcUFnU1Q0?=
 =?utf-8?B?REc5QUJ6RjdQcWF5TTBuSFhlN3FQMURvTVJIYUpvb0lST0h4NzQ4VGdZSFB1?=
 =?utf-8?B?dWE0TURESXdjUEdDSWN1NSswK3AzdE54b2xWQllYWUVwU2VPQnpSVFU0Nlph?=
 =?utf-8?B?MUtlTlRMaCtLS1J2eU1YWE55NlI2QUhXajRiT0U2Y3lCM0xYYWV1dWZaWnhn?=
 =?utf-8?B?S0dWQ0tTU21HaTQvcmxPY3ZacExLRmNONGUxdmh2elpqeU9NaisvbXZaT0x1?=
 =?utf-8?B?RHFpVC8rWS8xUURYbFA1OHN0ZFVUZVR1K3czM2JHeUxMZGExTHFqdkYzWjVv?=
 =?utf-8?B?UkdpNmNiWU45S0dlS28wWnpjRzBKQTBpWlJpK3JTVVFGQlUzc1o5M0ZqNjE5?=
 =?utf-8?B?dHZ0cEUyNGo3NzEwb293eVFUamExQWdSRzVYNmppdnh4Rzg5NkVCZzFuUXo1?=
 =?utf-8?B?NFR4a09iSy8zT1BvYllmbld2d2ZDNVFYTDUxVWs2UzVPY1NmVnJXZkhmVmxN?=
 =?utf-8?B?ZHZQa3RlalUvbnFkaFJEOEE3U1IyNDg5UnN3NDQ4akt4Mi9WS09YUzVtV0V4?=
 =?utf-8?B?RzJFamJmOGxZUEZjZHZlVEJ3Mm1NS1RxcUdSOE15NEswcjFiNnlGR3hTb1dX?=
 =?utf-8?B?WGJHeWxjRVptb2Z1OTZRS3NWL2R5c3lMcG5sMUtrSmp4T2V4VlcwNXVHK0xD?=
 =?utf-8?B?RFZIaTU2ZnV0bXdodnZ3Qkp0YVMzWFZBY0ZLY1RXWlhZejFxVSs1VFg4cUhO?=
 =?utf-8?B?YWd4RmJLTHUxZVN1MFdmOG1EVm5YcXFYUEtrL1ZmMHEzY1JRWU5UQVBSeHVE?=
 =?utf-8?B?VXBRT3VKcHp6WVdFT2hUeE1zL0wyeW9sNlkwUXg2SHRHWngza1VsbWhzRCt0?=
 =?utf-8?B?dGg2Y0RaYmVCMGJmN3l6QUNwVnY2M1ZwMzNZS2Y4UGh6cFJhckMwT3pOWHlM?=
 =?utf-8?B?V3JkZHA2VmFOb0hKVGxValNSR0loaFpZQ0o0WlM1UTZ4L29mZVRYalZlYVFX?=
 =?utf-8?B?UlNFYUlzb0M5NDNwdXRQNC8walNjYzJlQ3ZFRnc1bkpLOUxmMEpzdGk2YkFJ?=
 =?utf-8?B?WmJOLzBURUhVd1BXR1RFbGVTNG5zUS83bmwxTzhDYnFOMTlmK0t0dnJOSXpL?=
 =?utf-8?B?RmRpd0ZkK0FiSDJneXA5YVQ0K2RvMHFsM3FWdlZKWGFiamJ5eGpXQ0kvRTgy?=
 =?utf-8?B?VXNJdm1TcEhTRTVLTk1YYU9xMnZhd0R4eUR6UDBJaUFoTXVid2tSKzVoZXAy?=
 =?utf-8?B?dDRTUzkxUHQxM1ZjNmd4bGtBRzQzZzR4bGJEVGpvSHlVcjBzTkhYU2xwd2px?=
 =?utf-8?B?NEMyc2FaeGNYKy9zczM4RUZ4QlJDNFc2WFVPYzRqS2RrUzYrRmhvM0ZxSE9I?=
 =?utf-8?B?M3RZTjRhdGdZODN6WnhkTWowcm1EQnMrcnFCcm5yaXkveGRGTUlhQXkwbDVn?=
 =?utf-8?B?QmZPTGtFS01WL2VoSU1uZFJoN0lLTk4yMmJ5VFYwVHNCbjFZSll0VlFPaFFS?=
 =?utf-8?B?Q1hUZmlvaWZJb0s1Zkg2NWlFcFN5WXFsYzF0MmE2SnVzdEVaem5RNHA4RGZ3?=
 =?utf-8?B?MGNvK3kyU29yWXRZcFkrS2hERXUwZGxVOWFoZTZNc01KSmEzR1pvVVg0cTJ6?=
 =?utf-8?Q?GTY9NNBjHedZN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7699.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RnEzWm1hdCtrUHZYd3NwQ1REeDkwOFArSG5UOXowVnh5RWQvK2JDQ3F4VG13?=
 =?utf-8?B?dk1ETlpHRjJoZWg1b3pmblp4RlVCVllrblh0NlJZYlVuSDRqcitEMUZVWURv?=
 =?utf-8?B?Q3l4alNXMTJsSDkwSmJoYWZMQjhRZGhGSGVzbjdGNjFpbWorS0pCa2cwVU1O?=
 =?utf-8?B?dkZXYjNGeXE4QUFBZWprTVdjRDRJRFpnM1daby9FOHk5MmJJMGNJY3haK2FN?=
 =?utf-8?B?UkljNEQrMVg3QnhCYkdlcGs1SWNCQ3pnTHBxOWdxbW12WXhIa2x2bTdMWitR?=
 =?utf-8?B?Ym9RM1JON1RJUE82YXZ5MGFibUNnc3NoVzN1TldXTnRjVFFWWVlyKzFTQVlo?=
 =?utf-8?B?bS9mbVd1WFZGdldMdjB6U1ZWZ05DcWU4RkgvTy9KZFJyMmNpSHJ2ZEtVQ0pV?=
 =?utf-8?B?dm1xUVRiOW5oN0I5MmhrL0JYaFYzNmxLRUtqbnlIZGJ1dC93TTJmRm9tUjcy?=
 =?utf-8?B?ZjR2aDRQM3Nlc29DYnhjUGo1eFRNcjRoUlZqUlYrUWxvUHNXY0Zoc0tQd3J6?=
 =?utf-8?B?TGtiWGUwdzAyZ1lwWjdrRHJ2M3lCbTl3c2hVVHZWZnVkY3QvVU1CUFFzbjlF?=
 =?utf-8?B?Vk04bWh3OWxyYWhBWVE5c1VvUytpSlBDQ3J2SDZTN2gzWSs3YytVbm9jczFZ?=
 =?utf-8?B?ckVXN3BFNGhMemdaMVFnVjdpS1VUd25OQmk5dCtxWkErMWRGaFlHSndtaTF5?=
 =?utf-8?B?ZlNEVGJRa2U3d2xBZkFneFdMbm1DMWxGd1ZVZjJxaG1JWWV3QkZteXArdGw1?=
 =?utf-8?B?NUhKY0NmbTVtOUYrZ0l0QlV2L0t0YUlXeDFvZ09pb1BLekMwWmVhaDdKdU1o?=
 =?utf-8?B?MC82ZlJGZTNUdVg5aUlwY1F2K2NnZDlaMGovS3JJQjEvazhadkxxNEtRUnlP?=
 =?utf-8?B?YWpiSXlEWDBvTXR3cjBXU1hLT3lLTm9YYzdvMy9PR2szNkxEbS9WTlpPbHpq?=
 =?utf-8?B?b3RKbFpmNlJ6d1FIdWhEcENwNlJ6R0wxTm5HMEw2RGtka2FGM3ZWc0hEK1R1?=
 =?utf-8?B?RHdrdHpPS2Y0VVJ1ZThLY0NJTitjS0Rjd1ZNRVRmWDY5czFWM2NkSyttVDJy?=
 =?utf-8?B?OVU4UGhHc0Iyc0MwVThJeVVIcFlZOGE2eGNKMTdobEZFWTNDT2xrVEJQRko2?=
 =?utf-8?B?SnYrUjFUUFYyUkVlWEV0RkNMVFJldVVUdFNGT1lDRU9tVXNtVnF3Y1RtK1Fm?=
 =?utf-8?B?QkV6RUxXdjBYOGNwam1TNzloRno5RDJnWi9VU2lMLzdINjFTUE4rbE1wblVj?=
 =?utf-8?B?dmVrY3RwczFGUmdjRStGQ1BJOUNSdG1HQ0pKcStwanBzREdXVHNWRTNxQ2lz?=
 =?utf-8?B?dk9teExuNC9wY2FLMXExVGY3YVBlRHpHS2s5NVlaTC9sMnBEOXMwYXF6YmRt?=
 =?utf-8?B?NGViR1ZIR2dpS1RJRWJCRzkwL0Y2bTNtbDQyc254MnZTVlBtd3N1bWlhRHY3?=
 =?utf-8?B?dncyN2VXcjV1ckxBcnN5bUdTMEdDUG5xSlgwWVdLalZ0clkrcXZuT3BqWndC?=
 =?utf-8?B?MWZ3TkszK2M5dlFSc2RzSTNQZFFnZ0NiQTZsZ3dacEJoblhwZGh0cjI5YWpr?=
 =?utf-8?B?TWRFWkFTalhlRFVISGpHayt5VGVtbXBhMlpIKzJBQU9IY2FraGJoZDJrNFFP?=
 =?utf-8?B?MVJMdlFHMGhLaHV6WjBqQUpoeHBLblQ0eE83UnJUMHZDbjgyL2ZOYysvNE54?=
 =?utf-8?B?YVZNWXdleEtaNTliV00vTHNBVzE5NUNaQ04wNmJtbXF5NU8wQ09YMTdmZ0Ni?=
 =?utf-8?B?OHBWNzV6cE5QeUUrS016a1VzSWN5UTcwMHpwREFuc0l0NmR2ZTZVMGZxSDFi?=
 =?utf-8?B?S2Iyb0ZiQUgyd2pwK0JBNlRnNi9xYkNJNTBJRU90b1Q1SDE0ZVBpMUhhQjFm?=
 =?utf-8?B?MWhlNlBSOWFOOWppSVRSZHZIcWI5L3JMRnlJMWhOdGx5ZWFuSkNkRGJQN2Fa?=
 =?utf-8?B?bmpOMUdqTVhIcTBCQXBmNm5wQ0ZQRkdYSkJNczd2d1AxWVRGVDRjNnA0cVRh?=
 =?utf-8?B?VVpMK3J2NVNNSmJWNy9QNTFSMWNKNHl0WlZIS1lHdEZSdzU1ZnpkT2ZOZHRi?=
 =?utf-8?B?V3h0aGVzTzhhc053a0hSTGdKWUR1azV2bDgweDAzUXZpZ2FzTkY3eWkwN2c2?=
 =?utf-8?Q?yaYg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 389a048f-0a9a-4d75-e2e4-08dd09522fe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 10:57:55.1290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y6aAVRJBeaMDng57kw9dcy09qSKLB5jbv35IByAJ+7FsMzLbLXGkgC2REVzsrroSrGhwVV8bbYvdTZGqi5c2GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327

PiA+IHNwaUAwIHsNCj4gPiAJLi4uDQo+ID4gCWZsYXNoQDAgew0KPiA+IAkJY29tcGF0aWJsZSA9
ICJqZWRlYyxzcGktbm9yIg0KPiA+IAkJcmVnID0gPDB4MDA+Ow0KPiA+IAkJc3RhY2tlZC1tZW1v
cmllcyA9IDwmZmxhc2hAMCAmZmxhc2hAMT47DQo+ID4gCQlzcGktbWF4LWZyZXF1ZW5jeSA9IDw1
MDAwMDAwMD47DQo+ID4gCQkuLi4NCj4gPiAJCXBhcnRpdGlvbnMgew0KPiA+IAkJCWNvbXBhdGli
bGUgPSAiZml4ZWQtcGFydGl0aW9ucyI7DQo+ID4gCQkJY29uY2F0LXBhcnRpdGlvbiA9IDwmZmxh
c2gwX3BhcnQwICZmbGFzaDFfcGFydDA+Ow0KPiA+DQo+ID4gCQkJZmxhc2gwX3BhcnQwOiBwYXJ0
aXRpb25AMCB7DQo+ID4gCQkJCWxhYmVsID0gInBhcnQwXzAiOw0KPiA+IAkJCQlyZWcgPSA8MHgw
IDB4ODAwMDAwPjsNCj4gPiAJCQl9Ow0KPiA+IAkJfTsNCj4gPiAJfTsNCj4gPiAJZmxhc2hAMSB7
DQo+ID4gCQljb21wYXRpYmxlID0gImplZGVjLHNwaS1ub3IiDQo+ID4gCQlyZWcgPSA8MHgwMT47
DQo+ID4gCQlzdGFja2VkLW1lbW9yaWVzID0gPCZmbGFzaEAwICZmbGFzaEAxPjsNCj4gPiAJCXNw
aS1tYXgtZnJlcXVlbmN5ID0gPDUwMDAwMDAwPjsNCj4gPiAJCS4uLg0KPiA+IAkJcGFydGl0aW9u
cyB7DQo+ID4gCQkJY29tcGF0aWJsZSA9ICJmaXhlZC1wYXJ0aXRpb25zIjsNCj4gPiAJCQljb25j
YXQtcGFydGl0aW9uID0gPCZmbGFzaDBfcGFydDAgJmZsYXNoMV9wYXJ0MD47DQo+ID4NCj4gPiAJ
CQlmbGFzaDFfcGFydDA6IHBhcnRpdGlvbkAwIHsNCj4gPiAJCQkJbGFiZWwgPSAicGFydDBfMSI7
DQo+ID4gCQkJCXJlZyA9IDwweDAgMHg4MDAwMDA+Ow0KPiA+IAkJCX07DQo+ID4gCQl9Ow0KPiA+
IAl9Ow0KPiA+IH07DQo+ID4NCj4gPj4NCj4gPj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBj
b21wYXRpYmxlID0gImZpeGVkLXBhcnRpdGlvbnMiOw0KPiA+PiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgY29uY2F0LXBhcnRpdGlvbiA9IDwmZmxhc2gwX3BhcnRpdGlvbiAmZmxh
c2gxX3BhcnRpdGlvbj47DQo+ID4+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBm
bGFzaDFfcGFydGl0aW9uOiBwYXJ0aXRpb25AMCB7DQo+ID4+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGxhYmVsID0gInBhcnQwXzEiOw0KPiA+PiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgwIDB4ODAwMDAwPjsNCj4g
Pj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gPj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICB9DQo+ID4+ID4gICAgICAgICB9DQo+ID4+ID4NCj4gPj4gPiB9DQo+ID4+
ID4NCj4gPj4gPiBwYXJhbGxlbC1tZW1vcmllcyBiaW5kaW5nIGNoYW5nZXM6DQo+ID4+ID4gLSBS
ZW1vdmUgdGhlIHNpemUgaW5mb3JtYXRpb24gZnJvbSB0aGUgYmluZGluZ3MgYW5kIGNoYW5nZSB0
aGUgdHlwZSB0bw0KPiA+PiA+ICAgYm9vbGVuLg0KPiA+PiA+IC0gRWFjaCBmbGFzaCBjb25uZWN0
ZWQgaW4gcGFyYWxsZWwgbW9kZSBzaG91bGQgYmUgaWRlbnRpY2FsIGFuZCB3aWxsIGhhdmUNCj4g
Pj4gPiAgIG9uZSBmbGFzaCBub2RlIGZvciBib3RoIHRoZSBmbGFzaCBkZXZpY2VzLg0KPiA+PiA+
IC0gVGhlIOKAnHJlZ+KAnSBwcm9wIHdpbGwgY29udGFpbiB0aGUgcGh5c2ljYWwgQ1MgbnVtYmVy
IGZvciBib3RoIHRoZSBjb25uZWN0ZWQNCj4gPj4gPiAgIGZsYXNoZXMuDQo+ID4+ID4NCj4gPj4g
PiBUaGUgbmV3IGxheWVyIHdpbGwgZG91YmxlIHRoZSBtdGQtPiBzaXplIGFuZCByZWdpc3RlciBp
dCB3aXRoIHRoZQ0KPiA+PiA+IG10ZCBsYXllci4NCj4gPj4NCj4gPj4gTm90IHNvIHN1cmUgYWJv
dXQgdGhhdCwgeW91J2xsIG5lZWQgYSBuZXcgbXRkIGRldmljZSB0byBjYXB0dXJlIHRoZSB3aG9s
ZQ0KPiBkZXZpY2UuDQo+ID4+IEJ1dCB0aGlzIGlzIGltcGxlbWVudGF0aW9uIHJlbGF0ZWQsIG5v
dCByZWxldmFudCBmb3IgYmluZGluZy4NCj4gPj4NCj4gPj4gPg0KPiA+PiA+IHNwaUAxIHsNCj4g
Pj4gPiAgICAgICAgIC4uLg0KPiA+PiA+ICAgICAgICAgZmxhc2hAMyB7DQo+ID4+ID4gICAgICAg
ICAgICAgICAgIGNvbXBhdGlibGUgPSAiamVkZWMsc3BpLW5vciINCj4gPj4gPiAgICAgICAgICAg
ICAgICAgcmVnID0gPDB4MDAgMHgwMT47DQo+ID4+ID4gICAgICAgICAgICAgICAgIHBhcmFsbGUt
bWVtb3JpZXMgOw0KPiA+Pg0KPiA+PiBQbGVhc2UgZml4IHRoZSB0eXBvcyBhbmQgdGhlIHNwYWNp
bmcgKHNhbWUgYWJvdmUpLg0KPiA+Pg0KPiA+PiA+ICAgICAgICAgICAgICAgICBzcGktbWF4LWZy
ZXF1ZW5jeSA9IDw1MDAwMDAwMD47DQo+ID4+ID4gICAgICAgICAgICAgICAgIC4uLg0KPiA+PiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIHBhcnRpdGlvbnMgew0KPiA+PiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZml4ZWQtcGFydGl0aW9ucyI7DQo+ID4+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmbGFzaDBfcGFydGl0aW9uOiBwYXJ0aXRpb25A
MCB7DQo+ID4+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxhYmVs
ID0gInBhcnQwXzAiOw0KPiA+PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICByZWcgPSA8MHgwIDB4ODAwMDAwPjsNCj4gPj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIH0NCj4gPj4gPiAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+ID4+ID4gICAg
ICAgICB9DQo+ID4+ID4gfQ0KPiA+PiA+DQo+ID4+ID4gU2lnbmVkLW9mZi1ieTogQW1pdCBLdW1h
ciBNYWhhcGF0cmEgPGFtaXQua3VtYXItbWFoYXBhdHJhQGFtZC5jb20+DQo+ID4+ID4gLS0tDQo+
ID4+ID4gIC4uLi9iaW5kaW5ncy9zcGkvc3BpLWNvbnRyb2xsZXIueWFtbCAgICAgICAgICB8IDIz
ICsrKysrKysrKysrKysrKysrLS0NCj4gPj4gPiAgLi4uL2JpbmRpbmdzL3NwaS9zcGktcGVyaXBo
ZXJhbC1wcm9wcy55YW1sICAgIHwgIDkgKysrLS0tLS0NCj4gPj4gPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAyNCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiA+PiA+DQo+ID4+ID4gZGlmZiAt
LWdpdA0KPiA+PiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGkt
Y29udHJvbGxlci55YW1sDQo+ID4+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3Mvc3BpL3NwaS1jb250cm9sbGVyLnlhbWwNCj4gPj4gPiBpbmRleCAwOTMxNTBjMGNiODcuLjJk
MzAwZjk4ZGQ3MiAxMDA2NDQNCj4gPj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3Mvc3BpL3NwaS1jb250cm9sbGVyLnlhbWwNCj4gPj4gPiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS1jb250cm9sbGVyLnlhbWwNCj4gPj4gPiBA
QCAtMTg1LDcgKzE4NSwyNiBAQCBleGFtcGxlczoNCj4gPj4gPiAgICAgICAgICBmbGFzaEAyIHsN
Cj4gPj4gPiAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJqZWRlYyxzcGktbm9yIjsNCj4gPj4g
PiAgICAgICAgICAgICAgc3BpLW1heC1mcmVxdWVuY3kgPSA8NTAwMDAwMDA+Ow0KPiA+PiA+IC0g
ICAgICAgICAgICByZWcgPSA8Mj4sIDwzPjsNCj4gPj4gPiAtICAgICAgICAgICAgc3RhY2tlZC1t
ZW1vcmllcyA9IC9iaXRzLyA2NCA8MHgxMDAwMDAwMCAweDEwMDAwMDAwPjsNCj4gPj4gPiArICAg
ICAgICAgICAgcmVnID0gPDI+Ow0KPiA+PiA+ICsgICAgICAgICAgICBzdGFja2VkLW1lbW9yaWVz
ID0gPCZmbGFzaDAgJmZsYXNoMT47DQo+ID4+ID4gICAgICAgICAgfTsNCj4gPj4NCj4gPj4gSSdt
IHNvcnJ5IGJ1dCB0aGlzIGlzIG5vdCB3aGF0IHlvdSd2ZSB0YWxrZWQgYWJvdXQgaW4gdGhpcyBz
ZXJpZXMuDQo+ID4+IEVpdGhlciB5b3UgaGF2ZSBmbGFzaDAgYW5kIGZsYXNoMSBhbmQgdXNlIHRo
ZSBzdGFja2VkLW1lbW9yaWVzDQo+ID4+IHByb3BlcnR5IGluIGJvdGggb2YgdGhlbSAod2hpY2gg
aXMgd2hhdCB5b3UgZGVzY3JpYmVkKSBvciB5b3UgY3JlYXRlDQo+ID4+IGEgdGhpcmQgdmlydHVh
bCBkZXZpY2Ugd2hpY2ggcG9pbnRzIHRvIHR3byBvdGhlciBmbGFzaGVzLiBUaGlzDQo+ID4+IGV4
YW1wbGUgYWxsb3dzIGZvciBhbiBlYXNpZXIgdXNlIG9mIHRoZSBwYXJ0aXRpb25zDQo+ID4NCj4g
PiBJZiBJIHVuZGVyc3RhbmQgeW91ciBwb2ludCBjb3JyZWN0bHksIHlvdSdyZSBzdWdnZXN0aW5n
IHRoYXQgd2Ugc2hvdWxkDQo+ID4gYXZvaWQgdXNpbmcgc3RhY2tlZC1tZW1vcmllcyBhbmQgY29u
Y2F0LXBhcnRpdGlvbiBwcm9wZXJ0aWVzIHRvZ2V0aGVyDQo+ID4gYW5kIGluc3RlYWQgY2hvb3Nl
IG9uZSBhcHByb2FjaC4gQmV0d2VlbiB0aGUgdHdvLCBJIGJlbGlldmUNCj4gPiBjb25jYXQtcGFy
dGl0aW9uIHdvdWxkIGJlIHRoZSBiZXR0ZXIgb3B0aW9uLg0KPiANCj4gVGhhdCdzIG5vdCBleGFj
dGx5IGl0LCBsb29rIGF0IHRoZSByZWcgcHJvcGVydGllcyBhYm92ZSwgdGhleSBkbyBub3QgbWF0
Y2ggdGhlIGZsYXNoDQo+IGRldmljZXMuIFlvdXIgZXhhbXBsZSBhYm92ZSBpbnZhbGlkIGJ1dCBp
dCBpcyBub3QgY2xlYXIgd2hldGhlciB0aGlzIGlzIGFub3RoZXIgdHlwbw0KPiBvciB2b2x1bnRh
cnkuDQoNCkFoLCBJIHNlZS4gSXQncyBhIHR5cG8g4pi5LiBIb3dldmVyLCBiYXNlZCBvbiB0aGUg
ZGlzY3Vzc2lvbiBiZWxvdywgaXQgc2VlbXMgDQp3ZSBtaWdodCBub3QgbmVlZCB0aGUgJ3N0YWNr
ZWQtbWVtb3JpZXMnIHByb3BlcnR5IGFueW1vcmUuDQoNCj4gDQo+ID4gV2hpbGUgbG9va2luZyBp
bnRvIHlvdXIgbXRkY29uY2F0IHBhdGNoIFsxXSwgSSBub3RpY2VkIHRoYXQgaXQgY3JlYXRlcw0K
PiA+IGEgdmlydHVhbCBNVEQgZGV2aWNlIHRoYXQgcG9pbnRzIHRvIHBhcnRpdGlvbnMgb24gdHdv
IGRpZmZlcmVudCBmbGFzaA0KPiA+IG5vZGVzLCB3aGljaCBhbGlnbnMgcGVyZmVjdGx5IHdpdGgg
b3VyIHJlcXVpcmVtZW50cy4NCj4gPg0KPiA+IEhvd2V2ZXIsIHRoZXJlIGFyZSB0d28ga2V5IGNv
bmNlcm5zIHRoYXQsIGlmIGFkZHJlc3NlZCwgY291bGQgbWFrZQ0KPiA+IHRoaXMgcGF0Y2ggc3Vp
dGFibGUgZm9yIHRoZSBzdGFja2VkIG1vZGU6DQo+ID4NCj4gPiAxLyBUaGUgY3JlYXRpb24gb2Yg
YSB2aXJ0dWFsIGRldmljZSB0aGF0IGRvZXMgbm90IGhhdmUgYSBwaHlzaWNhbA0KPiA+IGV4aXN0
ZW5jZS4NCj4gDQo+IFdlIGRvIGFscmVhZHkgaGF2ZToNCj4gLSB0aGUgbWFzdGVyIG10ZCBkZXZp
Y2UgKGRpc2FibGVkIGJ5IGRlZmF1bHQgZm9yIGhpc3RvcmljYWwgcmVhc29ucywgYnV0DQo+ICAg
Y2FuIGJlIGVuYWJsZWQgd2l0aCBhIEtjb25maWcgb3B0aW9uKS4NCj4gLSBhbiBtdGQgZGV2aWNl
IHBlciBwYXJ0aXRpb24NCj4gDQo+IEkgZG9uJ3Qgc2VlIGEgcHJvYmxlbSBpbiBjcmVhdGluZyB2
aXJ0dWFsIG10ZCBkZXZpY2VzIGluIHRoZSBrZXJuZWwuDQo+IA0KPiA+IDIvIFRoZSBjcmVhdGlv
biBvZiBpbmRpdmlkdWFsIE1URCBkZXZpY2VzIHRoYXQgYXJlIGNvbmNhdGVuYXRlZCB0bw0KPiA+
IGZvcm0gdGhlIHZpcnR1YWwgTVREIGRldmljZSwgd2hpY2ggbWF5IG5vdCBiZSBuZWVkZWQgYnkg
dGhlIHVzZXIuDQo+IA0KPiBZb3UgY2FuIGFsc28gZ2V0IHJpZCBvZiB0aGVtIGJ5IGRlZmF1bHQg
KG9yIHBlcmhhcHMgZG8gdGhlIG9wcG9zaXRlIGFuZCBsZXQgYSBLY29uZmlnDQo+IG9wdGlvbiBm
b3IgdGhhdCkuDQoNCk9rLCBncmVhdCEgSSdsbCBsb29rIGludG8gaXQgYW5kIHRyeSB0byBpbnRl
Z3JhdGUgaXQgaW50byB5b3VyIA0KcHJldmlvdXMgcGF0Y2ggWzFdLiBJZiBldmVyeXRoaW5nIHdv
cmtzIG91dCwgdGhlbiBJTUhPIHRoaXMocGF0Y2hbMV0gKyB0aGUgDQphYm92ZSBjaGFuZ2VzKSBz
aG91bGQgc3VmZmljZSBmb3IgYWRkaW5nIHN0YWNrZWQgc3VwcG9ydC4NCg0KDQpSZWdhcmRzLA0K
QW1pdA0KPiANCj4gPiBSZWdhcmRpbmcgdGhlIGZpcnN0IHBvaW50LCBJIGN1cnJlbnRseSBjYW5u
b3QgdGhpbmsgb2YgYSBiZXR0ZXINCj4gPiBnZW5lcmljIHdheSB0byBzdXBwb3J0IHRoZSBzdGFj
a2VkIGZlYXR1cmUgdGhhbiBjcmVhdGluZyBhIHZpcnR1YWwgZGV2aWNlLg0KPiA+IFBsZWFzZSBs
ZXQgbWUga25vdyB5b3UgdGhvdWdodHMgb24gdGhpcy4NCj4gPg0KPiA+IEZvciB0aGUgc2Vjb25k
IHBvaW50LCBvbmUgcG9zc2libGUgc29sdXRpb24gaXMgdG8gaGlkZSB0aGUgaW5kaXZpZHVhbA0K
PiA+IE1URCBkZXZpY2VzICh0aGF0IGZvcm0gdGhlIGNvbmNhdGVuYXRlZCB2aXJ0dWFsIE1URCBk
ZXZpY2UpIGZyb20gdGhlDQo+ID4gdXNlciBvbmNlIHRoZSB2aXJ0dWFsIGRldmljZSBpcyBjcmVh
dGVkLiBQbGVhc2UgbGV0IHVzIGtub3cgaWYgeW91DQo+ID4gaGF2ZSBhbnkgb3RoZXIgc3VnZ2Vz
dGlvbnMgdG8gYWRkcmVzcyB0aGlzIGlzc3VlLg0KPiANCj4gVGhhdCBpcyB3aGF0IGlzIGRvbmUg
d2l0aCB0aGUgbWFzdGVyIGRldmljZSBieSBkZWZhdWx0Lg0KPiANCj4gPiBbMV0NCj4gPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC1tdGQvMjAxOTExMjcxMDU1MjIuMzE0NDUtNS1taXF1
ZWwucmF5bmFsDQo+ID4gQGJvb3RsaW4uY29tLw0KPiANCj4gVGhhbmtzLA0KPiBNaXF1w6hsDQo=

