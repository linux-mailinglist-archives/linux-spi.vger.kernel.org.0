Return-Path: <linux-spi+bounces-4218-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C488F956881
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 12:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1431F211BE
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 10:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A508C1607B4;
	Mon, 19 Aug 2024 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HRKqFYLe"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDEB16087B;
	Mon, 19 Aug 2024 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724063342; cv=fail; b=FvuYUWzwRpGl9lcmGBaC2KT9u0HmYi/XfZYJcBDpTjA4G6nkvxA5raOU2FFNsDCyH+vfCCa2BnGBlayuBI8Or64IrTDLt2E4w3dAPiXuOesRFcLmtuPmFRu9dlHHyz8rqFr1ZdM5AJh4+CyqJ/GJiFHHHHnP5YS5qJUQmpkfO0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724063342; c=relaxed/simple;
	bh=zKTKsySsG1xQIH5A0TE/b5pMpimOUtW+h1BLG7dhF7c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hc8MMOZjXAZWgfSvgrzJ4eDbdHmGfPX8C/wxYSt/HXP+ETjWlwZ+cLZ419lHW2La9+eK4Vr6aA1fb0HKgtKO94UpFNEz4pUvwLK3TH906iZt1aWq9atCqX6+/zgJ4VO4ZJm8d2tam3vef6gXvYuoclMy2c6OEFrjn0rPQMUW6wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HRKqFYLe; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTUKaIDIfIaStfqxhrFQu6zs/i3tG0/lzzB0urjzWvjiIyGrYiUEZcOsBBh6NozDGAIOUUFHedNVCUZDsu8FRPM3vn1WF2rkbEPWfUMVWXHonaCRk5WO/u67lVkKBEE6bqo0sIEfjrwwfngeBFivd0yE6jZUOXoOq6BNCCwVguoYXMC5MdaIntmQl5Zg3MwdEjeXP0OR5XunRhecVATsHl99kyHf8IGZiYW0FMSwFUSInm+Dw+Cuy+Qcu2LSOMMHKkAna6J/qzlGmrD/dgfayJHy9N1oLmxVLoiBiE6BFt1mse5afhJsrXdf9cdY6R4erS28Pn0sZhvOMnnaZcfCrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKTKsySsG1xQIH5A0TE/b5pMpimOUtW+h1BLG7dhF7c=;
 b=PNvwXPXEX1Z7hcUve5Xz3y9Ua8CJBS0hrJZtQPI+KUM8aIW9KcTyM1c95YOwWJhAqtdE8pXY5kLV066sZHnPA6NkPTth+7LcO4UnysnRQGazX0l/IO8AwiMHKIUobW594dBYZ4PBChPmDyra+YqV6Ye9PjBtozUeJWxD1uK+o8x0unH5bpyDODmYqsJvd9SFcFTqobXxhfUz3a+v1umuvugdOveTJP7xWPi5FntcrPSE9Jprj4PLxLxNqzdN45lg81zGDqDbiK0ZBKcaBEpo1n9ou50E9SccFJ92RBmnuUAXABU3XTepu3bM3cxD11K6WdpNUFBMUXC/2/lEE3rDqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKTKsySsG1xQIH5A0TE/b5pMpimOUtW+h1BLG7dhF7c=;
 b=HRKqFYLeH4KSr8shj1oU9jRiXXB6pxYOwemQ7lv5H03jesBczYhbRIUJYHjyB+RbZ5ccvg2bVayAs+cTVjNa0aTB5gSpUXs/0vRFdGveOE1OYp7HgyLZSThEU/LlctAuGvvkAU2NyQZ7HiHcugX8yfTjM5hcSCB5wdlBEK41QBo=
Received: from IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 10:28:58 +0000
Received: from IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa]) by IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa%2]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 10:28:57 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: Tudor Ambarus <tudor.ambarus@linaro.org>, "broonie@kernel.org"
	<broonie@kernel.org>, "pratyush@kernel.org" <pratyush@kernel.org>,
	"richard@nod.at" <richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>,
	"sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
	"lee@kernel.org" <lee@kernel.org>, "james.schulman@cirrus.com"
	<james.schulman@cirrus.com>, "david.rhodes@cirrus.com"
	<david.rhodes@cirrus.com>, "rf@opensource.cirrus.com"
	<rf@opensource.cirrus.com>, "perex@perex.cz" <perex@perex.cz>,
	"tiwai@suse.com" <tiwai@suse.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "michael@walle.cc" <michael@walle.cc>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>, "Simek, Michal"
	<michal.simek@amd.com>, "linux-arm-kernel@lists.infradead.org"
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
 AQHaH4D9pFM5xtDoeEuMNIpXuxvtzbCcYmwAgAEJ+aCABhoaAIAAMcLwgAAzdICAADdZAIABtmWAgAQ4ECCAAAuVAIAAD5dQgAAYdQCAAAF/8IAGJHEAgAFe7KCAUIcDAIAAVewAgDPXogCA08cW0IAaoUUAgAL7ppCAACtNgIAAD4YQgABVJgCAB12zMA==
Date: Mon, 19 Aug 2024 10:28:57 +0000
Message-ID:
 <IA0PR12MB7699ECBE6F803B2DEF33D633DC8C2@IA0PR12MB7699.namprd12.prod.outlook.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
	<b3d3c457-a43b-478a-85b3-52558227d139@linaro.org>
	<BN7PR12MB28027E62D66460A374E3CFEADC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
	<e212f9fa-83c5-4b9e-8636-c8c6183096ab@linaro.org>
	<BN7PR12MB280237CDD7BB148479932874DC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
	<576d56ed-d24b-40f9-9ae4-a02c50eea2ab@linaro.org>
	<BN7PR12MB2802F288C6A6B1580CF07959DC95A@BN7PR12MB2802.namprd12.prod.outlook.com>
	<c6f209c8-47da-4881-921d-683464b9ddd5@linaro.org>
	<9cdb7f8b-e64f-46f6-94cb-194a25a42ccd@linaro.org>
	<BN7PR12MB28028B63E69134094D50F3E4DC2A2@BN7PR12MB2802.namprd12.prod.outlook.com>
	<IA0PR12MB769944254171C39FF4171B52DCB42@IA0PR12MB7699.namprd12.prod.outlook.com>
	<20240812103812.72763f69@xps-13>
	<IA0PR12MB769997D5958C191215254983DC872@IA0PR12MB7699.namprd12.prod.outlook.com>
	<20240814104623.72eef495@xps-13>
	<IA0PR12MB7699670B7EE37C60C672FC5EDC872@IA0PR12MB7699.namprd12.prod.outlook.com>
 <20240814164642.24705f18@xps-13>
In-Reply-To: <20240814164642.24705f18@xps-13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7699:EE_|DM6PR12MB4121:EE_
x-ms-office365-filtering-correlation-id: 9ae89355-a366-4929-618e-08dcc039bbe1
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RVY2S3BwVW1EeWhKMXpkZkkyZjNZRG81dkF0L1pVUi9taVhhZTN1d0xJc0NW?=
 =?utf-8?B?STN1dmV5MVFkTU5vRTRMWkdHMVNWaHRLRC9OZFZVUXVEWW1sYUdtdy9wWk96?=
 =?utf-8?B?Mkt3VUVabjlxdHhqWEZPOThKb3ZHT0V6K0VwMFliUTRpVS9kMm1KREVlTitY?=
 =?utf-8?B?V0NZaXZvUEVzeWlwOUN2djREcVhkYytGbU15QjZIUFl5MFlmZmlYVkVPUW9a?=
 =?utf-8?B?OGtXejlDQ0VxbWxLN3cyMnFqZisySEY3Y2lmNUdZMjd0UnF1ZkFSbFl6VTBp?=
 =?utf-8?B?RUlEUnFjY2hWdUtkUTZpTWZlS1hNdGtNZ2ZnN2JiL3llNU5LU2loeDczSlgz?=
 =?utf-8?B?VnNuM0w0YitQQ3k1dFRXbnMrZnpodTFUWVVIQnFSc2l5TEFqQVNCNmpGODBS?=
 =?utf-8?B?MGNHSkdZNGNPcEs3K0MxYkZPMGpEQ1o0RTc0bENHZS9uSUNiRjB0a1Z6Znlv?=
 =?utf-8?B?V2tZVWpNVTBUNDBWV01YaFQ4UWFVUmhRbmlDdFl5amY3R3JMZTZKTFR3ZDZ5?=
 =?utf-8?B?VnpLRGJmeWI1enlvSENHaGFwanBVdEIxV0lrSzJlZFZlM2RseVl1Y1VMU3Iv?=
 =?utf-8?B?WERiRTIrcXZISk4rSGdsZE1wZG5pb0E0NTVNVTAxOU1BV0x6Ni80dE5DUHg0?=
 =?utf-8?B?RHQ0UDlydFFMdVRBalVtN3h3YlI4cHNwYXlaK3lkWVIzV2k0b3Z5YmJwb01E?=
 =?utf-8?B?TnRsb2xVNkJXOEZlai8wenJld0pqMVBnNU9NdkFQZG5HVExVWnZxNGx6czMr?=
 =?utf-8?B?TWF0TGx2SmlGQ0M0cVROSnYvWngrd2piZXlKZGlqOFdhbkx1clZsdjdKd3NS?=
 =?utf-8?B?NlYvQTU0NlAvRnJqYU1wTUdTZ1FvcldtWFlOaFFKSWI5MlR2SkV5dXlreHF2?=
 =?utf-8?B?WUwyd3U1SE1GUGc3czVRQWZ4OW5TTENIRDRsbkZ4L3A0ck93eWFYVDA5bmg4?=
 =?utf-8?B?dGNJR1pNb3NtdjZPeU11ZkVMQkVSQ0lHQTBjZnQ2S3J4c0hUck15cWNNbWVn?=
 =?utf-8?B?UFdjSGlXTFBVd1dpZCtUYUNrZ3k1bExhSjQ4dno2YnByUEVvLzFSZk1SZWdP?=
 =?utf-8?B?Y3lFcG5BV1crZ0V1MnUwUHg4NFE2N0R3bkRIelBjd3B3R3k0cXpSRXlXUHVR?=
 =?utf-8?B?N2RzMTdlMTRMU1BoT3BvSE5XWnREdXFIRWUxN1grcWRDaWw2by85eDA5R2pR?=
 =?utf-8?B?cWdYNSs5TFRZQ2RYeEE3V0ttWHh0dVByMXRHcEZpZ1JmRDRDQUEraDcyNHlz?=
 =?utf-8?B?UldET2piMzBCZEV1ekpoekFJL2FZV3lya1grcDFwaGo5a2lMY3oxV25OSXlx?=
 =?utf-8?B?M3JWMG9VYkgyU3o4OEU3bjRCOFp4VGxzTlowb0hUdDJuUlJiK0k3TGtScWQz?=
 =?utf-8?B?d3FBaFRZR2xQQTQxOHBJcjFrc2lhSEJ2bFBMQUpURE1mc2V4MXRyU3lBSkQ1?=
 =?utf-8?B?QUd6S0tCUWE5QXkzcGRvZkVRNU9ZWFJCWTViL25vUEdRVThqTzNkK1h4SUVV?=
 =?utf-8?B?aVlHcCtxTDVoRHFra2xMaW5NTmt3TnNaVy9WVENTTXRlem8rRmVEN01ndXVG?=
 =?utf-8?B?aTgwWGx6UmgxZ3JNV0ZRblM4T0grbHVnQ2d3eVlXaCtYMyt6UEl1V293U2dG?=
 =?utf-8?B?SWJkbFM4T3c1c3A5dHZpOU0vWktaREN5ckpnVStXSVZwc2M0Q3ZSUVNyU2Jz?=
 =?utf-8?B?U1NwTHEvdGdnSFBESTdRWlRqNmp3NEU2MDA2MnJtQlQzZVJsNGdobkdmWFZS?=
 =?utf-8?B?TXF4Z3hqSXB2YlBwZVZqNVBrSDRXNUNSL3ZDdGNxZ1FCZG5sMjJnNGhnd292?=
 =?utf-8?Q?PnjnS9meQVJ9XYbsCTrcU5T9XK7npdFpIWUfQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7699.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y1BiSEsxSmdOQWlzZDkrOFNxY2FoV2dockZOcU1DRnY5b1ROeDZBUC8zQ0R2?=
 =?utf-8?B?d3QzOUVBbWNGZzVRWTZzNTV3TjFZWTV6M3I4OUllUDNkWkQ2TFFrL2xFSUhP?=
 =?utf-8?B?K3NCc25kb3NURU1sd0RTcGtOQnhaQTdDQTZzOExVTkFTTjNiK3BzQ2dMRGNB?=
 =?utf-8?B?ME5GNVFkQ0FXSEJaYi82c2Nlei9OL3BHaTc3OWhCWjlSRnkwYjFJQXZOSXBB?=
 =?utf-8?B?K1I1MDZPSzBNUzJ2ZkMwaGRMMDBKTkRvbEVIcGhwRjd5VjdJbjQ0SGc0ZkxU?=
 =?utf-8?B?OWNDMmV5M0l1bytydHUxUEovS2Z4RVIyTEovdnlTaWE4SE5QRFcxckFobDVx?=
 =?utf-8?B?UXVjcWdFbCsrSHVTYTZDeUMxZGxwdnZoTFlQQ1RZcTlyNjV3Mm5kWHJOZFND?=
 =?utf-8?B?MGh0Yi9OL1hUeEg3OFBoanhYeWNJMTlLWnVzeXFLemJlRVk1UXJYT3FCMGZG?=
 =?utf-8?B?aHFZUkNGd2VwRk5ueCtvc2Q3NFBESnRlNmg1NFdOc09MSHV4MWVTSm85S1Ev?=
 =?utf-8?B?TXNuMXhCVlVqbFVxcXgyRlU4VDhCSkptWHZBdlJ3R0VWOGRsMC82NjBGWEV1?=
 =?utf-8?B?WFYwOGZSenlaM0k1ZlhYSFZ5ODJmZURORUQ2eFE4cWtNOGY2MUVUVGZNeWtM?=
 =?utf-8?B?RkdBTHF3MC9renNyMEMzZWpRMEtMZU4wWWNmWnNKTExxYktrRWNSbTMzWmZk?=
 =?utf-8?B?cVBEZ0M5ZFFEaEp4OGZaUkU1QlNOdmM1TWdFREtySTg1bWtWZkduS1VTeUtk?=
 =?utf-8?B?RzhLaHpxWTdWbzZ5VjBqSWFtYlBEcE8zbWJkd25vVjNndDJZZU9TRkxKaXMv?=
 =?utf-8?B?Z3FPYXdhWkVWelNBRXBoOXk2M2VNVlJrbFR2UVh5M3BCRlNIaXRhR21reER3?=
 =?utf-8?B?Z21XMGlMeGlMczJmVytHdDRjOGNid21IdFQ3QTd5dHg0c0Q3eGp3dVUxTmtk?=
 =?utf-8?B?NERXS0FBejVzMVUwSFZRbHZXODkvNDFrVllnbC8xeFord243RGwxSHhJb3dx?=
 =?utf-8?B?eG5UMVJVODg1bnRKN3BDV1U5VzZ4RmlGSUtaaXozTlZzZWcwKzc5bENJR0Fa?=
 =?utf-8?B?V294WlJoZzBSd1YxdmVyaWtOWTFJb002ZG1VSnNnV0FVaEdRUmp4cTV3M3g4?=
 =?utf-8?B?ekFlVkpqUmRLQ2ZSSWFpV0tjZjZrbnB4WHYrMDJnNkRTU0wzM242UTFta24y?=
 =?utf-8?B?WW9GSVQyMUgrZG9UMk5sZXJ4bG1rZlVuTytJbm1kTVBBQ0pUSVpZZjJtY0Zr?=
 =?utf-8?B?a2dMbEZleEZmcGw4N2c5V2ZpT2RReTJnNHBrSFc3UDcwZmtVNGd0MlFRNnVR?=
 =?utf-8?B?N1IxN0xRSHpLVHI4ZjhTS1RUYWxCTHcxdThMUEdIbTM5Mlo1RVIrMzBndkVm?=
 =?utf-8?B?NHFrYldxT21RcXpGaEhDZ3J4aXJDVmFSUWx3NXVyd3F5VG5xTVN6VEVsb1Bm?=
 =?utf-8?B?c0R2MEM4VVNCMnlQSllPdXhtQVVMM2hJQW5aY3docHFlWkN1QVVFQlB2a2tI?=
 =?utf-8?B?TVUzNDhQa0s0Sk9PN3MvQWR0VGVidkFYWFN6QklIejlkTzZZMWJ0MUpCYmZ0?=
 =?utf-8?B?L1Y3QjhpUVovcitMQzlqR3FQV3hJelMyTDNVSWF6MnppOTRoenlOSC9zRysw?=
 =?utf-8?B?NWpxSERpVnRzM0wrT0tCSXF0R1A0RnRzSnM5Z3M3NWtraS95RG1PZEp1K0Za?=
 =?utf-8?B?TDN4b1M3TmhWUXV2Y1RuT0tOZEF3L3gxTE9ydFpUY0Q3N2hLb1NoNkVCRGpn?=
 =?utf-8?B?NzNpSVJtRUFiMXZNbFFxSlNGU1I1U0dPS0RGMlNzeXNITU85RnQvK2s0SGFR?=
 =?utf-8?B?YXgyU2JXYStaaldJK1FuSkZKeWVUUk5DL0JNdXA1clpZWlpFZndNcE12M09E?=
 =?utf-8?B?Q25XYTBkeWdIKzZGS3VBUEFnS3BuRWZFSDZMZjhWdlRwYTNaS2lVd3Q4RnFU?=
 =?utf-8?B?aTZzRytQbDUrRUgyRHZLU0VIaXhYcW8rQURFTnF4bTQybzltQTJlZEl6WXNo?=
 =?utf-8?B?RWI4K3hyMTduZmZjRXZydllGbWRVWjVRYTZRcXljTS9XVjNjM003dUdHZTdN?=
 =?utf-8?B?NEgzOHJ1dWt6ajhtZlFUcjZwaTFucHkyYTF2YUtCVG5LUU0zYWZScDRPY1pS?=
 =?utf-8?Q?ZF8k=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae89355-a366-4929-618e-08dcc039bbe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 10:28:57.7460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mxSnfZC++pYxTe6oim+rVrrcTVl8Pvqtyvk/YR54sK2cO9vgEjoZwiAznDaqw7D36mKFIVgwxukR9BLiWlVDxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121

SGVsbG8gTWlxdWVsLA0KDQo+IEhpIEFtaXQsDQo+IA0KPiA+ID4gPiA+ID4gRm9yIGltcGxlbWVu
dGluZyB0aGlzIHRoZSBjdXJyZW50IERUIGJpbmRpbmcgbmVlZCB0byBiZQ0KPiA+ID4gPiA+ID4g
dXBkYXRlZCBhcyBmb2xsb3dzLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gU28geW91IHdhbnQgdG8g
Z28gYmFjayB0byBzdGVwIDEgYW5kIHJlZGVmaW5lIGJpbmRpbmdzPyBJcyB0aGF0IHdvcnRoPw0K
PiA+ID4gPg0KPiA+ID4gPiBUaGUgY3VycmVudCBiaW5kaW5ncyBhcmUgZWZmZWN0aXZlIGlmIHdl
IG9ubHkgc3VwcG9ydCBpZGVudGljYWwNCj4gPiA+ID4gZmxhc2ggZGV2aWNlcyBvciBmbGFzaGVz
IG9mIHRoZSBzYW1lIG1ha2UgYnV0IHdpdGggZGlmZmVyZW50IHNpemVzDQo+ID4gPiA+IGNvbm5l
Y3RlZCBpbiBzdGFja2VkIG1vZGUuIEhvd2V2ZXIsIGlmIHdlIHdhbnQgdG8gZXh0ZW5kIHN0YWNr
ZWQNCj4gPiA+ID4gc3VwcG9ydCB0byBpbmNsdWRlIGZsYXNoZXMgb2YgZGlmZmVyZW50IG1ha2Vz
IGluIHN0YWNrZWQgbW9kZSwNCj4gPiA+DQo+ID4gPiBUaGUgb25seSBhY3R1YWwgZmVhdHVyZSB0
aGUgc3RhY2tlZCBtb2RlIGJyaW5ncyBpcyB0aGUgYWJpbGl0eSB0bw0KPiA+ID4gY29uc2lkZXIg
dHdvIGRldmljZXMgbGlrZSBvbmUuIFRoaXMgaXMgYWJzdHJhY3RlZCBieSBoYXJkd2FyZSwgdGhp
cyBpcyBhDQo+IGNvbnRyb2xsZXIgY2FwYWJpbGl0eS4NCj4gPg0KPiA+IFN0YWNrZWQgbW9kZSBp
cyBhIHNvZnR3YXJlIGFic3RyYWN0aW9uIHJhdGhlciB0aGFuIGEgY29udHJvbGxlcg0KPiA+IGZl
YXR1cmUgb3IgY2FwYWJpbGl0eS4gQXQgYW55IGdpdmVuIHRpbWUsIHRoZSBjb250cm9sbGVyIGNv
bW11bmljYXRlcw0KPiA+IHdpdGggb25lIG9mIHRoZSB0d28gY29ubmVjdGVkIGZsYXNoIGRldmlj
ZXMsIGFzIGRldGVybWluZWQgYnkgdGhlDQo+ID4gcmVxdWVzdGVkIGFkZHJlc3MgYW5kIGRhdGEg
bGVuZ3RoLiBJZiBhbiBvcGVyYXRpb24gc3RhcnRzIG9uIG9uZSBmbGFzaA0KPiA+IGFuZCBlbmRz
IG9uIHRoZSBvdGhlciwgdGhlIGNvcmUgbmVlZHMgdG8gc3BsaXQgaXQgaW50byB0d28gc2VwYXJh
dGUNCj4gPiBvcGVyYXRpb25zIGFuZCBhZGp1c3QgdGhlIGRhdGEgbGVuZ3RoIGFjY29yZGluZ2x5
Lg0KPiANCj4gSSdtIHNvcnJ5LCB0aGF0IHdhcyBub3QgbXkgdW5kZXJzdGFuZGluZywgY2YgdGhl
IGluaXRpYWwgUkZDOg0KPiANCj4gCVN1YmplY3Q6IFtSRkMgUEFUQ0ggMC8zXSBEdWFsIHN0YWNr
ZWQvcGFyYWxsZWwgbWVtb3JpZXMgYmluZGluZ3MNCj4gCURhdGU6IEZyaSwgMTIgTm92IDIwMjEg
MTY6MjQ6MDggKzAxMDANCj4gDQo+IAkiWy4uLl0gc3VwcG9ydGluZyBzcGVjaWZpYyBTUEkgY29u
dHJvbGxlciBtb2RlcyBsaWtlIFhpbGlueCdzDQo+IAl3aGVyZSB0aGUgY29udHJvbGxlciBjYW4g
aGlnaGx5IGFic3RyYWN0IHRoZSBoYXJkd2FyZSBhbmQNCj4gCXByb3ZpZGUgYWNjZXNzIHRvIGEg
c2luZ2xlIGJpZ2dlciBkZXZpY2UgaW5zdGVhZCBbLi4uXSINCj4gDQo+IEZ1cnRoZXJtb3JlLCBJ
IHJhcGlkbHkgY2hlY2tlZCB0aGUgWnlucTcwMDAgVFJNLCBpdCBzdWdnZXN0cyB0aGF0IHRoZQ0K
PiBjb250cm9sbGVyIGlzIGNhcGFibGUgb2YgYWRkcmVzc2luZyB0aGUgcmlnaHQgbWVtb3J5IGl0
c2VsZiBiYXNlZCBvbiB0aGUNCj4gYWRkcmVzcywgZXNwZWNpYWxseSBpbiBsaW5lYXIgbW9kZT8N
Cg0KWWVzLCB0aGlzIGlzIHRydWUgb25seSB3aGVuIG9wZXJhdGluZyBpbiBMaW5lYXIgTW9kZS4g
SW4gdGhpcyBtb2RlLCB0aGUgDQpaeW5xIDcwMDAgY2FuIG9ubHkgcGVyZm9ybSByZWFkIG9wZXJh
dGlvbnMuIEVyYXNlIGFuZCB3cml0ZSBvcGVyYXRpb25zIA0KYXJlIHBvc3NpYmxlIG9ubHkgaW4g
SS9PIG1vZGUsIHNvIHdoaWxlIG9wZXJhdGluZyBpbiBJL08gbW9kZSB0aGUgQ1MgcGlucyANCm11
c3QgYmUgbWFudWFsbHkgYXNzZXJ0ZWQgYnkgdGhlIGRyaXZlciBhY2NvcmRpbmcgdG8gdGhlIGFk
ZHJlc3MgYW5kIGRhdGEgDQpsZW5ndGgNCj4gDQo+IAlodHRwczovL2RvY3MuYW1kLmNvbS9yL2Vu
LVVTL3VnNTg1LXp5bnEtNzAwMC1Tb0MtVFJNL0R1YWwtU1MtDQo+IDQtYml0LVN0YWNrZWQtSS9P
DQo+IA0KPiAJIlRoZSBsb3dlciBTUEkgZmxhc2ggbWVtb3J5IHNob3VsZCBhbHdheXMgYmUgY29u
bmVjdGVkIGlmIHRoZQ0KPiAJbGluZWFyIFF1YWQtU1BJIG1lbW9yeSBzdWJzeXN0ZW0gaXMgdXNl
ZCwgYW5kIHRoZSB1cHBlciBmbGFzaA0KPiAJbWVtb3J5IGlzIG9wdGlvbmFsLiBUb3RhbCBhZGRy
ZXNzIHNwYWNlIGlzIDMyIE1CIHdpdGggYSAyNS1iaXQNCj4gCWFkZHJlc3MuIEluIElPIG1vZGUs
IHRoZSBNU0Igb2YgdGhlIGFkZHJlc3MgaXMgZGVmaW5lZCBieQ0KPiAJVV9QQUdFIHdoaWNoIGlz
IGxvY2F0ZWQgYXQgYml0IDI4IG9mIHJlZ2lzdGVyIDB4QTAgLiBJbiBMaW5lYXINCj4gCWFkZHJl
c3MgbW9kZSwgQVhJIGFkZHJlc3MgYml0IDI0IGRldGVybWluZXMgdGhlIHVwcGVyIG9yIGxvd2Vy
DQo+IAltZW1vcnkgcGFnZS4gQWxsIG9mIHRoZSBjb21tYW5kcyB3aWxsIGJlIGV4ZWN1dGVkIGJ5
IHRoZSBkZXZpY2UNCj4gCXNlbGVjdGVkIGJ5IFVfUEFHRSBpbiBJL08gbW9kZSBhbmQgYWRkcmVz
cyBiaXQgMjQgaW4gbGluZWFyDQo+IAltb2RlLiINCj4gDQo+IEFueXdheSwgeW91IG1heSBkZWNp
ZGUgdG8gZ28gZG93biB0aGUgInB1cmUgc29mdHdhcmUiIHJvdXRlLCB3aGljaCBpcw0KPiBwcm9i
YWJseSBlYXNpZXIgZnJvbSBhbiBpbXBsZW1lbnRhdGlvbiBwZXJzcGVjdGl2ZSwgYnV0IG1lYW5z
IHlvdSdyZQ0KPiBnb25uYSBoYXZlIHRvIGFyZ3VlIC1hZ2Fpbi0gaW4gZmF2b3Igb2YgdGhlIHJl
cHJlc2VudGF0aW9uIG9mIGEgcHVyZWx5IHZpcnR1YWwNCj4gZGV2aWNlIHRoYXQgaXMgbm90IGhh
cmR3YXJlLg0KDQpZZXMsIHRoYXQncyBjb3JyZWN0LCBidXQgSSB3YXMgcGxhbm5pbmcgdG8gbWFu
YWdlIGl0IHRocm91Z2ggYSBuZXcgbGF5ZXIgcmF0aGVyIA0KdGhhbiB1c2luZyBtdGQtY29uY2F0
LiBBcyBUdWRvciBtZW50aW9uZWQsIEkgd2lsbCBzdGFydCBhIG5ldyBlbWFpbCB0aHJlYWQgDQpv
dXRsaW5pbmcgbXkgcHJvcG9zYWwgc28gd2UgY2FuIHJlc3VtZSB0aGUgZGlzY3Vzc2lvbiBvbiB0
aGUgcGF0Y2ggbW92aW5nIA0KZm9yd2FyZC4NCg0KUmVnYXJkcywNCkFtaXQNCj4gDQo+IENoZWVy
cywNCj4gTWlxdcOobA0K

