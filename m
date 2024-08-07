Return-Path: <linux-spi+bounces-4149-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B64194A879
	for <lists+linux-spi@lfdr.de>; Wed,  7 Aug 2024 15:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6360285CC3
	for <lists+linux-spi@lfdr.de>; Wed,  7 Aug 2024 13:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9E61E7A5D;
	Wed,  7 Aug 2024 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wSAYTvyW"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2803D1CCB32;
	Wed,  7 Aug 2024 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723036875; cv=fail; b=TyuZQAugxvTzF17Ymf1cs4oXCnc0gGmLS0T4PAYYPNepadAAJcRoaUiaqUyOn4/g1lvKQJ1FAl/qOQjJlmbQAWfsAxwm5yg85+ew3wVOzMph+kcPUEFns3h037XQvDxJm9G0Qah8IEnFca7Y+N+w6KQfKX/myecr1JgF37MMdL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723036875; c=relaxed/simple;
	bh=bRmsd9Bx1AkjAQh/zysJO/ZaX6TOC6wjtp+ypOB8BvE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XGOY8enu2OCCdeorKI4Xw4jOthT3PpXFdMjSBzO4ksrENmqB5PM5ZduUslG0e36LZ5xSBSx+keUkerodaXwYAb2ddGCGdHJMGAJACJX61bIaClSGMDiADEaVGdeGAsjHev8CPo7GdmjxMIfwS86k1mQd0jMFd5Y5nTUG1SEscqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wSAYTvyW; arc=fail smtp.client-ip=40.107.95.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHIiaKVwfiFyjAxzAfGRWK+hJuj8qWbSp7EGr4+BDCedORzLTqmXyuH1opqfwvyxDoKBPP5RbFeX0gY2VVVqtoPC1D0Ok9/6C5m2fFMRr374yj+D5LrRLQCUjXwV6aYFp9ESNkkgsgEw+xGY0L84wnr2KwWJ2ekvKSKBmWS5d3i0G5BnS7IfTuKRaXPj8Gdyf0ivfgUgT1EusctFXdVLcyhWbDT44eUXLcd2a/4GdMODRKT03hNWiOPLEZnoYQ/QCaCTzw/5MVpNifO6DKqrNMv+rk8DLyjDxmXOeFpeUYd7+5jTNo5Hkto/m/fPTG9u/y7Uh5U4yM2KmN31N3ue5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRmsd9Bx1AkjAQh/zysJO/ZaX6TOC6wjtp+ypOB8BvE=;
 b=HIBmwF0wMbna2j6JpkslRJe7ZeOpsEHCqmE928ZKNrhNrrPosu92HA5GhGZKfijOconuf9OMf/KBJKM6+4F3wnUU+FNqzFLXKgWzie8eMNpccgEsS+dS1HDmOr9NBNY1n/fCr1zpEPce84H8YKtCFQDHfHsEaLPafse9bla1iSkELL0XLXsNnDkvJevcxSTUw9ektJKVqJVWegBA4vWIV/oGYYQUtPs5dJPttbSFgI/qpImUQ0B8T0fH4/cbHIq/wX019bX61VBUOxBz3wSXUj671PuiYQoP1Ma2+MbdPS+2qSLCEwwUGHb92IEpOgOzgvQpKAxWHGFdI24pLmAT/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRmsd9Bx1AkjAQh/zysJO/ZaX6TOC6wjtp+ypOB8BvE=;
 b=wSAYTvyWkBimVfkqJFarSxHSjCGtLyhHqqEOFk/AXOuMHVYwEddT2qbDaqiYCxdt0V+gPEgrOUDkN3C/vKLa8o7nO5g9ldDHsFhF3wk6LVLvbUDeNLah6ch52aonyJOC0A9ivqZyqwaXCNuP2S9J0h80RtOyUH1sJ3qvdGYf4fY=
Received: from IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 by LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 7 Aug
 2024 13:21:09 +0000
Received: from IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa]) by IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa%2]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 13:21:09 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, Michael Walle <michael@walle.cc>,
	Tudor Ambarus <tudor.ambarus@linaro.org>, "broonie@kernel.org"
	<broonie@kernel.org>, "pratyush@kernel.org" <pratyush@kernel.org>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>, "richard@nod.at"
	<richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>,
	"sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
	"lee@kernel.org" <lee@kernel.org>, "james.schulman@cirrus.com"
	<james.schulman@cirrus.com>, "david.rhodes@cirrus.com"
	<david.rhodes@cirrus.com>, "rf@opensource.cirrus.com"
	<rf@opensource.cirrus.com>, "perex@perex.cz" <perex@perex.cz>,
	"tiwai@suse.com" <tiwai@suse.com>, "Frager, Neal" <neal.frager@amd.com>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, "patches@opensource.cirrus.com"
	<patches@opensource.cirrus.com>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>,
	"amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>, Conor Dooley
	<conor.dooley@microchip.com>, "beanhuo@micron.com" <beanhuo@micron.com>
Subject: RE: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Thread-Topic: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Thread-Index:
 AQHaH4D9pFM5xtDoeEuMNIpXuxvtzbCcYmwAgAEJ+aCABhoaAIAAMcLwgAAzdICAADdZAIABtmWAgAQ4ECCAAAuVAIAAD5dQgAAYdQCAAAF/8IAGJHEAgAFe7KCAUIcDAIAAVewAgDPXogCA08cW0IAAMZYQgAeZXQCAAAXAgIAASRyAgAAIfoCAAQ9HgIAGbHuAgAAqsgCAAXoMUA==
Date: Wed, 7 Aug 2024 13:21:09 +0000
Message-ID:
 <IA0PR12MB7699E1DA855A3C15F2749109DCB82@IA0PR12MB7699.namprd12.prod.outlook.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <BN7PR12MB28027E62D66460A374E3CFEADC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <e212f9fa-83c5-4b9e-8636-c8c6183096ab@linaro.org>
 <BN7PR12MB280237CDD7BB148479932874DC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <576d56ed-d24b-40f9-9ae4-a02c50eea2ab@linaro.org>
 <BN7PR12MB2802F288C6A6B1580CF07959DC95A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <c6f209c8-47da-4881-921d-683464b9ddd5@linaro.org>
 <9cdb7f8b-e64f-46f6-94cb-194a25a42ccd@linaro.org>
 <BN7PR12MB28028B63E69134094D50F3E4DC2A2@BN7PR12MB2802.namprd12.prod.outlook.com>
 <IA0PR12MB769944254171C39FF4171B52DCB42@IA0PR12MB7699.namprd12.prod.outlook.com>
 <D2ZHJ765LUGP.2KTA46P1BL75X@walle.cc>
 <e1587f61-f765-4a22-b06e-71387cc49c4d@amd.com>
 <D33M26RLVLHF.3Q5YARPBNSBOY@walle.cc>
 <9fb60743-3e89-49fa-a399-3cf2607a7e41@amd.com>
 <D33S9T73M6ND.G7CCJ4PDVYQU@walle.cc>
 <c01d048f-ad8b-417e-8ff0-96f9252c87f2@amd.com>
 <D37U3QPX0J5J.21CTXMW2KC72G@walle.cc>
 <1b726ef7-e25c-4a19-aaa8-77fdbdd8bcca@amd.com>
In-Reply-To: <1b726ef7-e25c-4a19-aaa8-77fdbdd8bcca@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7699:EE_|LV3PR12MB9214:EE_
x-ms-office365-filtering-correlation-id: d0b96c74-78dc-41d8-bb3d-08dcb6e3cce3
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?OGlpblZlMytYcTNOaUgwWjZvaFY4bEJNcWQ2K2F0bmNTM09PQXVzUEZ6N0lh?=
 =?utf-8?B?Y0xpZzR3NjRWdVJrTy9JdHBqSzVBTTdEN21wcE9tVzBCeDZYbXgxUGM1UjFr?=
 =?utf-8?B?ZEJ6VUowNlgvN1dmaUxhYUlZT3JxV1h5Vk1ja05aWGxwTlZwL3hkRVR0OVNi?=
 =?utf-8?B?eFNSQldtVVNhcHhFSm53UUoyNmFFY3dlSVJKK3lUbzlCd0NNTDZlcnc5NXBZ?=
 =?utf-8?B?YkxhK1lEd1BHWk1kUG5hb1FMbFNhY1g3VHZEblR1MkI1c01kNUJtR0RzdnlB?=
 =?utf-8?B?RStIT3hUWHdKd21zUFdxWFV0Ukg4cCs0MXM1Z08yR1Y4cktweENZZ0VXUUk0?=
 =?utf-8?B?cThGMVVMRWdYZTRzL3Y1Rkt6UklBZWdCTXhaQzIxNnRwVVJPZE5QZ1BtZEhL?=
 =?utf-8?B?OFpYVXo4Z0VKajg1VjVhZnJSYU1yNXJKU1lvcWpKRVFuS25rL3FTbjFCdlky?=
 =?utf-8?B?WUJpbjZUQVhUWXBsQUVPWmZHRWVKZ3JqV1EvQ2VzN0ExS1RiR2UyRG9UcmRU?=
 =?utf-8?B?TmhQeVdNdkw4ZzNOSlZSamJybEYxZXlmUFp3aHB3YXpBZ05Cd1RtbGM5WVNm?=
 =?utf-8?B?RXpkWnBIRFlrdS90a0xWb2R0eEZlZjMyUjNhSk5Oc1Z5NnUvVDBlZ2ZGbmth?=
 =?utf-8?B?Z1czS01VaHhjYzBpSHF2REtyYjhnWTArMUZZZlpoNDZ4K3ZTKzFRa2FMN29X?=
 =?utf-8?B?WmxLNW1sZi9JTFhadVk3aGVIZG0vUy8zNXhBYTdVL1NMdkdOdzM1MlMrQVpW?=
 =?utf-8?B?SlJuRGlpWHIvVGZ3MkU0NlZvTGZQTk0wbVQrUTIrMkhqb0x6dnBjN3BoYkVX?=
 =?utf-8?B?NE5jLysyMUVzd0ZwSzJ0UXdJSENzRk5KYSs5UDdPcHI2TVdPN2YwZGlsV3ky?=
 =?utf-8?B?dHJCaStQZ2sxd3ZHa3lQa0ZRcUdwYVNhVERwZ1h0RG1wZlc4UmFjZ2YxcHc1?=
 =?utf-8?B?ZEZmTCsyZFNqeFhYbnlaSHRxbEtlSHVNc2cxUnU2ZDBab2lnMW5sWjRSRGtq?=
 =?utf-8?B?RzgxUGpxVW1BWXFTeW1RbU1wK0JleStCTFpPKytZYVV2Vnk1SlEvMHpGdmI3?=
 =?utf-8?B?SHhZWUZoSnZnN3lnQmtHK21ma0dDV2pmaS9jMlArL1JDRjNjQTZ0eDl3Yld0?=
 =?utf-8?B?WGs5a3hHTlRMQnlCaFdnOWxGTExNWmk4cTZ6OWo2L0t0aGxNUUhrVzhsejF4?=
 =?utf-8?B?VCt1ZDdxeHBnOEh2eU1zUEVrK2xGT0JyUDVMVE0vY1dvSzY5VUwybkFiZEha?=
 =?utf-8?B?SllWcFd3RXV2RDlyUVdCQW02V3dVN0hubnZKc3pldnFEWDRvN2hjb3BCNmZN?=
 =?utf-8?B?Y2w2WUlBOE96cFRFN2crWUlod0NpZXloZE1zaVBvcEIyRUVUSXkzaVhMTXFi?=
 =?utf-8?B?aE5TMFpNVXB3ditPaUVSMzNWVkwwVHZrY3Bta1E2Z0cvUTJ4WHRCOGk0d043?=
 =?utf-8?B?V25JQ3dZM2VMWXFaZmNNelppVmtzcHJ3MEt1QXNmeURaWmRxSTdLZ2FPcGlv?=
 =?utf-8?B?ZThxdG8xL0Jld01qeHdtNkgwRUs5WC9nSjQ4QTc0UHN1VlNsaHN6ZEJyblp2?=
 =?utf-8?B?VW02M2JMekExSDFuQmdiR0NtZXI5bkx1eDlmZ1NscG5jWDArL3ppcDc2WkFE?=
 =?utf-8?B?MG9ET1NMdWpRTXVoY1lOQlJnZXIxMUxnSFRjT1I3UjJIU2luS3N2ZlNGSTFr?=
 =?utf-8?B?bnhBUUZIQjh1cTVaSFNYRkJXWjkxRGdzTEduUHRSYUJrbU0xa3ZtTDBTV0pC?=
 =?utf-8?B?SnpXRnhSUVgrSUtRWlRKVGx5UStnRkhVc3ZpWldzdHpvSlg4TXVrUitaa3JX?=
 =?utf-8?B?Wk1YNVo2QjlaYm1USjFBU0tlL2RjL3UxT1V2ZHFpZnE1OU9MN3ZSdU1kU3d3?=
 =?utf-8?Q?bE0WL8bgZTs4A?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7699.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dU1zdk1lcVVWMExlN3Z1WGEwUFlFd0Z4aHNPOFplaHJWNUJqUjVSNzZXelJ3?=
 =?utf-8?B?cUpyRTRtU2NSZGJYKzAxdVhyVVZIdURMZytLbTZmRWN1amp1ZW90SFZCdkVk?=
 =?utf-8?B?MlBsNUJxSkpmSFVmYWdiVXNIUkFiekdZWSs3eUhuSTluNTVwRGRvUUxGa2di?=
 =?utf-8?B?dU14Z1hoT0FPbFcwTnEvWEZDdHdyb1oySThKSDNueUF6S2haQkVoNE5CeUJU?=
 =?utf-8?B?RTlnQlNlclZOdm5VUC9tM0ZLeWJreXN2YUU3OSs0YVVPdkRyRkJpMlAzdVJJ?=
 =?utf-8?B?ODNFNVF0ZU1aK1BPenErazByWU44TUFWWVdXNC9OaGJ3b01tby9oaVZ3bHpX?=
 =?utf-8?B?bS9CVVdQWmxpOHhMMnpFdm00V2M0NlpIaXZ1Wi96NmlKL1lNOW9pZEF6N2I1?=
 =?utf-8?B?SG9rcWxUMTRmY0hscWJzZUpRTERLT1BOeHJSUzVGcytiZXlmWVR2WTU3ejdp?=
 =?utf-8?B?ZjlLSzRCTUVDYVRPN2M2NXRKcXp6ZVN3c0FyU3MwNkl1alB2OHJTL2ZoL1Ro?=
 =?utf-8?B?LzVRck1ucmVPWXZJNXJHblExYS9WelFBUHI3eXZsSmloMmNZdVlxUlJiRzM5?=
 =?utf-8?B?WVZKMUtOU2owVlIxL0pVNUxNMXVKMlZzOU0vTzYwYzFtVEtWK2FOMnZFazQ5?=
 =?utf-8?B?bUpPNGxuTmc2Sy8vK2U2dmVnbk1CdUxaZ21rbHAxUng0UHF5cDV3VStrZ3l0?=
 =?utf-8?B?T1JySDdoYkRwNnl5SUZqWTgxYzNuK2k5Z09YRE1HU1oxTi9DWnJnY0ZrM2p4?=
 =?utf-8?B?OTk2cU9hQjdPdzRnUFVaL0Q4TVJEQy9tSm95bm45aUtZT0o4VTNibklTaDJ4?=
 =?utf-8?B?V2ZEUlR3elR4dUw1SE43L29ja0MwcUpza1puT0tTUEd6MjFXbmxmV1NRNDh4?=
 =?utf-8?B?Ty9EZ2FkclhoRkFXNTJWWUFGbVUzRW1hZ2gwenpNNnNKQ0xzVUo2OUtpUmlF?=
 =?utf-8?B?ekhmRGx1TjBBY0tMSG11Vy9wbDkxanlBazIrVU8vcWpUalNINkcxSmRzMUZ6?=
 =?utf-8?B?YS92N1RvR3FIUUVWQmlJbWl1M0hHOXFxNU9udVpXdzFQN29yRS9NYWd4QzR2?=
 =?utf-8?B?MGNwdGwyRitjYXJaMWJWQmlSRlpXRzhMZmRpR0FZMm9yaXFxUXY0N0E4a1Mw?=
 =?utf-8?B?aG14T1E3ZUVmVTJNUVkzN051NURVdEl0LzNBaDRLcFpxb1FkTjBQR1hNTnJM?=
 =?utf-8?B?VWw2QzJNTkNrR1J4ZHY3Ym5EL3ozUXdRNzhwUUJLK1E1dDdLVStDQUxGUklw?=
 =?utf-8?B?bUFGaWp1Zi8weXdrTHBoMkdFY3BPaSt4NW8rUEo2Q3JEQjFzcGFuc0NtN3Mv?=
 =?utf-8?B?aC9HRGliOXNiajlhVXdEUHkrR1B2SnFncGFCVHNsVlNvNWtLR2JZc3dWdVNY?=
 =?utf-8?B?Sld2TW5hVlZCa21HR0FzOUNTUEVJV0tWcHNTTlBZWFQwbnk1QUEvdldoNzJQ?=
 =?utf-8?B?aFVVL2E0VWFsenIwUUlIMWgzdDNSaXlQMHNDV0x1aDVkRjJKdjF3SVJILzU3?=
 =?utf-8?B?WnAxVEp4dis5dFM4RklvZHZBVTJycW5GL2lUcWxwbXpQSDdSR2JMTEhWYmRh?=
 =?utf-8?B?MnFLeVhNVnBicTVteXFPa0YyL1krcU5GSlVLeXNZR1BPQ25kRGhSUXF1b2c1?=
 =?utf-8?B?R2RQcUVzK1lLVmZ2QmhLYjNQUUZkT0xXL2Z5L2VSMDl2UVc0MUw1Q09Ib2Fm?=
 =?utf-8?B?cWlicjhRQlA3RzViZGtXR2ZWVXVsTXl6QXdveWdTQUtUNXZHSEZCUS9ueFpQ?=
 =?utf-8?B?YWtNN1RUY1RobEkrczdBU291ZFhvek10cjJqSGh0V2FXWEdQZkV3WWJWbURP?=
 =?utf-8?B?blhpL2R0UlEzc2x6ZGgvM2RSKzBQNi9mcUVHblJvQ2RyaVNUamxsREhTTlZm?=
 =?utf-8?B?MkRlcnUvZStaZWVFc2RNOUFrSU1JelUzNlJUT2ozdEpWV3VzVmp4Qm9rV3FQ?=
 =?utf-8?B?VU1jN1pMaWdMejB1WDZSTERIbUs3MHdJajdEZHRtc0NaVzVrdFhZZjVpZnVE?=
 =?utf-8?B?M3l6YS8yZUljcnhNUkh1c0RoQ0gzd1JTbDE5eUdNcDFiSzVqYk5XN2g4cUZN?=
 =?utf-8?B?KzJaV0hRU3VoNjFhY1FkOGM4M09PM1EzYXRuMXIxTlk2dks1ZEp2bldwcUg3?=
 =?utf-8?Q?XJ3g=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b96c74-78dc-41d8-bb3d-08dcb6e3cce3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 13:21:09.0907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jtp78Dg1njnobzyoZxhbMs4qCJkjgTK0kzGYRm+qVVvpcvm00Vgi52hi1XwVWCCl1C1pBW/Mo1NvET6T3Q1v3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214

SGVsbG8gTWljaGFlbCwNCg0KPiBPbiA4LzUvMjQgMTA6MjcsIE1pY2hhZWwgV2FsbGUgd3JvdGU6
DQo+ID4gSGksDQo+ID4NCj4gPj4+Pj4gQWxsIEknbSBzYXlpbmcgaXMgdGhhdCB5b3Ugc2hvdWxk
bid0IHB1dCBidXJkZW4gb24gdXMgKHRoZSBTUEkgTk9SDQo+ID4+Pj4+IG1haW50YWluZXJzKSBm
b3Igd2hhdCBzZWVtcyB0byBtZSBhdCBsZWFzdCBhcyBhIG5pY2hlLiBUaHVzIEkgd2FzDQo+ID4+
Pj4+IGFza2luZyBmb3IgcGVyZm9ybWFuY2UgbnVtYmVycyBhbmQgdXNlcnMuIENvbnZpbmNlIG1l
IHRoYXQgSSdtDQo+ID4+Pj4+IHdyb25nIGFuZCB0aGF0IGlzIHdvcnRoIG91ciB0aW1lLg0KPiA+
Pj4+DQo+ID4+Pj4gTm8uIEl0IGlzIG5vdCByZWFsbHkganVzdCBmZWF0dXJlIG9mIG91ciBldmFs
dWF0aW9uIGJvYXJkcy4NCj4gPj4+PiBDdXN0b21lcnMgYXJlIHVzaW5nIGl0LiBJIHdhcyB0YWxr
aW5nIHRvIG9uZSBndXkgZnJvbSBmaWVsZCBhbmQgaGUNCj4gPj4+PiBjb25maXJtcyBtZSB0aGF0
IHRoZXNlIGNvbmZpZ3VyYXRpb25zIGFyZSB1c2VkIGJ5IGhpcyBtdWx0aXBsZQ0KPiBjdXN0b21l
cnMgaW4gcmVhbCBwcm9kdWN0cy4NCj4gPj4+DQo+ID4+PiBXaGljaCBiZWdzIHRoZSBxdWVzdGlv
biwgZG8gd2UgcmVhbGx5IGhhdmUgdG8gc3VwcG9ydCBldmVyeSBmZWF0dXJlDQo+ID4+PiBpbiB0
aGUgY29yZSAoSSdkIGxpa2UgdG8gaGVhciBUdWRvcnMgYW5kIFByYXR5dXNoIG9waW5pb24gaGVy
ZSkuDQo+ID4+PiBIb25lc3RseSwgdGhpcyBqdXN0IGxvb2tzIGxpa2UgYSBjb25jYXRlbmF0aW9u
IG9mIHR3byBRU1BJDQo+ID4+PiBjb250cm9sbGVycy4NCj4gPj4NCj4gPj4gQmFzZWQgb24gbXkg
dW5kZXJzdGFuZGluZyBmb3Igc3RhY2tlZCB5ZXMuIEZvciBwYXJhbGxlbCBuby4NCj4gPg0KPiA+
IFNlZSBiZWxvdy4NCj4gPg0KPiA+Pj4gV2h5IGRpZG4ndCB5b3UganVzdCB1c2UgYSBub3JtYWwg
b2N0YWwgY29udHJvbGxlciB3aGljaCBpcyBhDQo+ID4+PiBwcm90b2NvbCBhbHNvIGJhY2tlZCBi
eSB0aGUgSkVERUMgc3RhbmRhcmQuDQo+ID4+DQo+ID4+IE9uIG5ld2VyIFNPQyBvY3RhbCBJUCBj
b3JlIGlzIHVzZWQuDQo+ID4+IEFtaXQgcGxlYXNlIGNvbW1lbnQuDQo+ID4+DQo+ID4+PiBJcyBp
dCBhbnkgZmFzdGVyPw0KPiA+Pg0KPiA+PiBBbWl0OiBwbGVhc2UgcHJvdmlkZSBudW1iZXJzLg0K
PiA+Pg0KPiA+Pj4gRG8geW91IGdldCBtb3JlIGNhcGFjaXR5PyBEb2VzIGFueW9uZSByZWFsbHkg
dXNlIGxhcmdlIFNQSS1OT1INCj4gPj4+IGZsYXNoZXM/IElmIHNvLCB3aHk/DQo+ID4+DQo+ID4+
IFlvdSBnZXQgdHdpY2UgbW9yZSBjYXBhY2l0eSBiYXNlZCBvbiB0aGF0IGNvbmZpZ3VyYXRpb24u
IEkgY2FuJ3QNCj4gPj4gYW5zd2VyIHRoZSBzZWNvbmQgcXVlc3Rpb24gYmVjYXVzZSBub3Qgd29y
a2luZyB3aXRoIGZpZWxkLiBCdXQgYm90aA0KPiA+PiBvZiB0aGF0IGNvbmZpZ3VyYXRpb25zIGFy
ZSB1c2VkIGJ5IGN1c3RvbWVycy4gQWRkaW5nIE5lYWwgaWYgaGUgd2FudHMgdG8NCj4gYWRkIHNv
bWV0aGluZyBtb3JlIHRvIGl0Lg0KPiA+Pg0KPiA+Pj4gSSBtZWFuIHlvdSd2ZSBwdXQgdGhhdCBj
b250cm9sbGVyIG9uIHlvdXIgU29DLCB5b3UgbXVzdCBoYXZlIHNvbWUNCj4gPj4+IGNvbnZpbmNp
bmcgYXJndW1lbnRzIHdoeSBhIGN1c3RvbWVyIHNob3VsZCB1c2UgaXQuDQo+ID4+DQo+ID4+IEkg
ZXhwZWN0IHJlY29tbWVuZGF0aW9uIGlzIHRvIHVzZSBzaW5nbGUgY29uZmlndXJhdGlvbiBidXQg
aWYgeW91DQo+ID4+IG5lZWQgYmlnZ2VyIHNwYWNlIGZvciB5b3VyIGFwcGxpY2F0aW9uIHRoZSBv
bmx5IHdheSB0byBleHRlbmQgaXQgaXMNCj4gPj4gdG8gdXNlIHN0YWNrZWQgY29uZmlndXJhdGlv
biB3aXRoIHR3byB0aGUgc2FtZSBmbGFzaGVzIG5leHQgdG8gZWFjaCBvdGhlci4NCj4gPj4gSWYg
eW91IHdhbnQgdG8gaGF2ZSBiaWdnZXIgc2l6ZSBhbmQgYWxzbyBiZSBmYXN0ZXIgYW5zd2VyIGlz
IHBhcmFsbGVsDQo+ID4+IGNvbmZpZ3VyYXRpb24uDQo+ID4NCj4gPiBCdXQgd2hvIGlzIHVzaW5n
IGV4cGVuc2l2ZSBOT1IgZmxhc2ggZm9yIGJ1bGsgc3RvcmFnZSBhbnl3YXk/DQo+IA0KPiBJIGV4
cGVjdCB5b3UgdW5kZXJzdGFuZCB0aGF0IGV2ZW4gaWYgSSBrbm93IGNvbXBhbmllcyB3aGljaCBk
b2VzIGl0IEkgYW0gbm90DQo+IGFsbG93IHRvIHNoYXJlIHRoZWlyIG5hbWVzLg0KPiANCj4gQnV0
IGN1c3RvbWVycyBkb24ndCBuZWVkIHRvIGhhdmUgb3RoZXIgZnJlZSBwaW5zIHRvIGNvbm5lY3Qg
Zm9yIGV4YW1wbGUNCj4gZW1tYy4NCj4gVGhhdCdzIHdoeSBhZGRpbmcgb25lIG1vcmUgImV4cGVu
c2l2ZSBmbGFzaCIgY2FuIGJlIGZvciB0aGVtIG9ubHkgb25lDQo+IG9wdGlvbi4NCj4gDQo+IEFs
c28gSSBiZXQgdGhhdCBwcmljZSBmb3Igb25lIG1vcmUgcXNwaSBmbGFzaCBpcyBub3RoaW5nIGNv
bXBhcmUgdG8gY2hpcCBpdHNlbGYNCj4gYW5kIG90aGVyIHJlbGF0ZWQgZXhwZW5zZXMgZm9yIGxv
dyB2b2x1bWUgcHJvZHVjdGlvbi4NCj4gDQo+ID4gWW91J3JlDQo+ID4gb25seSBtZW50aW9uaW5n
IHBhcmFsbGVsIG1vZGUuIEFsc28gdGhlIHBlcmZvcm1hbmNlIG51bWJlcnMgd2VyZSBqdXN0DQo+
ID4gYWJvdXQgdGhlIHBhcmFsbGVsIG1vZGUuIFdoYXQgYWJvdXQgc3RhY2tlZCBtb2RlPyBCZWNh
dXNlIHRoZXJlJ3MgYQ0KPiA+IGNoYW5jZSB0aGF0IHBhcmFsbGVsIG1vZGUgd29ya3Mgd2l0aG91
dCBtb2RpZmljYXRpb24gb2YgdGhlIGNvcmUgKD8pLg0KPiANCj4gSSB3aWxsIGxldCBBbWl0IHRv
IGNvbW1lbnQgaXQuDQoNClRoZSBwZXJmb3JtYW5jZSBvZiB0aGUgc3RhY2tlZCBjb25maWd1cmF0
aW9uIHdpbGwgYmUgdGhlIHNhbWUgYXMgdGhhdCBvZiANCnRoZSBzaW5nbGUgbW9kZS4gQXMgTWlj
aGFsIG1lbnRpb25lZCBlYXJsaWVyLCBzdGFja2VkIG1vZGUgaXMgdXNlZCBmb3IgDQpzY2VuYXJp
b3Mgd2hlcmUgdGhlIGN1c3RvbWVyIHJlcXVpcmVzIGxhcmdlciBmbGFzaCBzcGFjZSB3aGlsZSBt
YWludGFpbmluZyANCnRoZSBzYW1lIHBlcmZvcm1hbmNlLg0KDQpJIHdhbnQgdG8gcHJvdmlkZSBz
b21lIGJhY2tncm91bmQgb24gd2h5IEkgY2hvb3NlIHRvIGhhbmRsZSBzdGFja2VkIGFuZCANCnBh
cmFsbGVsIG1vZGVzIHRocm91Z2ggYW4gYWRkaXRpb25hbCBsYXllciBvciBmaWxlLCBzdWNoIGFz
IA0KL210ZC9zcGktbm9yL3N0YWNrZWQuYywgcmF0aGVyIHRoYW4gbXRkLWNvbmNhdC4gSW5pdGlh
bGx5LCB3aGVuIE1pcXVlbCANCmJlZ2FuIHVwc3RyZWFtaW5nIHN0YWNrZWQgc3VwcG9ydCBieSBl
eHRlbmRpbmcgdGhlIG10ZC1jb25jYXQgZHJpdmVyLCANCnRoZSBEVCBiaW5kaW5nIHdhcyBub3Qg
YWNjZXB0ZWQuIEhlIHByb3Bvc2VkIGEgY291cGxlIG9mIERUIGJpbmRpbmdzIA0KWzFdICYgWzJd
IHRvIHN1cHBvcnQgc3RhY2tpbmcgdGhyb3VnaCBtdGQtY29uY2F0LCBidXQgbm9uZSB3ZXJlIGFj
Y2VwdGVkLiANCkFkZGl0aW9uYWxseSwgYWZ0ZXIgcmV2aWV3aW5nIHRoZSBNVEQgY29yZSBjb2Rl
LCBoZSBmb3VuZCB0aGF0IGFkZGluZyANCnN0YWNrZWQgc3VwcG9ydCB0aHJvdWdoIG10ZC1jb25j
YXQgY291bGQgYmUgY29tcGxpY2F0ZWQgYW5kIGludm9sdmUgbWFueSANCmNvcm5lciBjYXNlcywg
d2hpY2ggaGUgbWVudGlvbmVkIGluIGhpcyBSRkMgWzNdLiBIZSB0aGVuIHN1Z2dlc3RlZCANCmNv
bmNhdGVuYXRpbmcgdGhlIGZsYXNoZXMgaW5zdGVhZCBvZiB0aGUgbXRkIHBhcnRpdGlvbnMsIGFu
ZCBldmVudHVhbGx5LCANCnRoZSBjdXJyZW50IERUIGJpbmRpbmdzIHdlcmUgYWRkZWQuIFRoaXMg
aXMgd2h5IEkgcHJvcG9zZSBoYW5kbGluZyB0aGUgDQpzdGFja2VkIGFuZCBwYXJhbGxlbCBjb25m
aWd1cmF0aW9ucyB0aHJvdWdoIGFuIGFkZGl0aW9uYWwgbGF5ZXIgb3IgZmlsZSwgDQphcyB0aGUg
bXRkLWNvbmNhdCBhcHByb2FjaCB3YXMgYWxyZWFkeSBkaXNjdXNzZWQgYW5kIHJlamVjdGVkLg0K
DQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMTkxMTEzMTcxNTA1LjI2MTI4LTQt
bWlxdWVsLnJheW5hbEBib290bGluLmNvbS8NClsyXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMjAxOTExMjcxMDU1MjIuMzE0NDUtNS1taXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tLw0KWzNd
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjExMTEyMTUyNDExLjgxODMyMS0xLW1pcXVl
bC5yYXluYWxAYm9vdGxpbi5jb20vDQoNClJlZ2FyZHMsDQpBbWl0DQoNCj4gDQo+IA0KPiA+DQo+
ID4+Pj4+IFRoZSBmaXJzdCByb3VuZCBvZiBwYXRjaGVzIHdlcmUgcmVhbGx5IGludmFzaXZlIHJl
Z2FyZGluZyB0aGUgY29yZQ0KPiA+Pj4+PiBjb2RlLiBTbyBpZiB0aGVyZSBpcyBhIGNsZWFuIGxh
eWVyaW5nIGFwcHJvYWNoIHdoaWNoIGNhbiBiZQ0KPiA+Pj4+PiBlbmFibGVkIGFzIGEgbW9kdWxl
IGFuZCB5b3UgYXJlIG1haW50YWluaW5nIGl0IEknbSBmaW5lIHdpdGggdGhhdA0KPiA+Pj4+PiAo
ZXZlbiBpZiB0aGUgY29yZSBjb2RlIG5lZWRzIHNvbWUgY2hhbmdlcyB0aGVuIGxpa2UgaG9va3Mg
b3Igc28sIG5vdA0KPiBzdXJlKS4NCj4gPj4+Pg0KPiA+Pj4+IFRoYXQgZGlzY3Vzc2lvbiBzdGFy
dGVkIHdpdGggTWlxdWVsIHNvbWUgeWVhcnMgYWdvIHdoZW4gaGUgd2FzDQo+ID4+Pj4gdHJ5aW5n
IHRvIHRvIHNvbHZlIGRlc2NyaXB0aW9uIGluIERUIHdoaWNoIGlzIG1lcmdlZCBmb3IgYSB3aGls
ZSBpbiB0aGUNCj4ga2VybmVsLg0KPiA+Pj4NCj4gPj4+IFdoYXQncyB5b3VyIHBvaW50IGhlcmU/
IEZyb20gd2hhdCBJIGNhbiB0ZWxsIHRoZSBEVCBiaW5kaW5nIGlzIHdyb25nDQo+ID4+PiBhbmQg
bmVlZHMgdG8gYmUgcmV3b3JrZWQgYW55d2F5Lg0KPiA+Pg0KPiA+PiBJIGFtIGp1c3Qgc2F5aW5n
IHRoYXQgdGhpcyBpcyBub3QgYW55IGFkaG9jIG5ldyBmZWF0dXJlIGJ1dA0KPiA+PiBjb25maWd1
cmF0aW9uIHdoaWNoIGhhcyBiZWVuIGFscmVhZHkgZGlzY3Vzc2VkIGFuZCBzb21lIHN0ZXBzIG1h
ZGUuDQo+ID4+IElmIERUIGJpbmRpbmcgaXMgd3JvbmcgaXQgY2FuIGJlIGRlcHJlY2F0ZWQgYW5k
IHVzZSBuZXcgb25lIGJ1dCBmb3IgdGhhdCBpdA0KPiBoYXMgYmUgY2xlYXIgd2hpY2ggd2F5IHRv
IGdvLg0KPiA+DQo+ID4gV2VsbCwgQU1EIGNvdWxkIGhhdmUgc2lkZSBzdGVwcGVkIGFsbCB0aGlz
IGlmIHRoZXkgaGFkIGp1c3QgaW50ZWdyYXRlZA0KPiA+IGEgbm9ybWFsIE9TUEkgZmxhc2ggY29u
dHJvbGxlciwgd2hpY2ggd291bGQgaGF2ZSB0aGUgc2FtZSByZXF1aXJlbWVudHMNCj4gPiByZWdh
cmRpbmcgdGhlIHBpbnMgKGlmIG5vdCBldmVuIGxlc3MpIGFuZCBpdCB3b3VsZCBoYXZlIGJlZW4g
KmVhc3kqIHRvDQo+ID4gaW50ZWdyYXRlIGl0IGludG8gdGhlIGFscmVhZHkgYXZhaWxhYmxlIGVj
b3N5c3RlbS4NCj4gPiBUaGF0IHdhcyB3aGF0IG15IGluaXRpYWwgcXVlc3Rpb24gd2FzIGFib3V0
LiBXaHkgZGlkIHlvdSBjaG9vc2UgdHdvDQo+ID4gUVNQSSBwb3J0cyBpbnN0ZWFkIG9mIG9uZSBP
U1BJIHBvcnQuDQo+IA0KPiBLZWVwIGluIHlvdXIgbWluZCB0aGF0IFp5bnFNUCBpcyA5eWVhcnMg
b2xkIFNvQy4gWnlucSAxMisgeWVhcnMgd2l0aCBhIGxvdCBvZg0KPiBpbnRlcm5hbCBkZXZlbG9w
bWVudCBoYXBwZW5pbmcgYmVmb3JlLiBOb3Qgc3VyZSBpZiBvc3BpIGV2ZW4gZXhpc3RzIGF0IHRo
YXQNCj4gdGltZS4gQWxzbyBpZiBhbnkgSVAgd2FzIGF2YWlsYWJsZSBmb3IgdGhlIHByaWNlIHdo
aWNoIHRoZXkgd2VyZSB0YXJnZXRpbmcuDQo+IEkgZG9uJ3QgdGhpbmsgbWFrZSBzZW5zZSB0byBk
aXNjdXNzIE9TUEkgaW4gdGhpcyBjb250ZXh0IGJlY2F1c2UgdGhhdCdzIG5vdCBpbg0KPiB0aGVz
ZSBTb0NzLg0KPiBJIGhhdmUgbmV2ZXIgd29ya2VkIHdpdGggc3BpIHRoYXQncyB3aHkgZG9uJ3Qg
a25vdyBoaXN0b3JpY2FsIGNvbnRleHQgdG8NCj4gcHJvdmlkZSBtb3JlIGRldGFpbHMuDQo+IA0K
PiBUaGFua3MsDQo+IE1pY2hhbA0KDQo=

