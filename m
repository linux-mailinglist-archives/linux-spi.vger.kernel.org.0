Return-Path: <linux-spi+bounces-4184-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1358495150E
	for <lists+linux-spi@lfdr.de>; Wed, 14 Aug 2024 09:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 659B0B24476
	for <lists+linux-spi@lfdr.de>; Wed, 14 Aug 2024 07:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA6113A40C;
	Wed, 14 Aug 2024 07:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wW5sRDll"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9F6139D12;
	Wed, 14 Aug 2024 07:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723619620; cv=fail; b=pwKGWyQdzCoHA+KgFzhI1+TMvs/zXzVf3d9Ycpyp+d+fo5/pVndM16DkZsc8qXn212j9R3w7WAYyY7AeRbpyX7HCgNPpNrcvE5xgrBIkc4KhQT65118nlpjfPkQ8rRLehJjRFf9CmcGWFaRxAP9tjl4pcX9ZE9G4I/yA941E25o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723619620; c=relaxed/simple;
	bh=J4NRysPhnjm2OoMJJbVDwVdeEAOpC4PfuCMawqxcVnQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AVg5lBriW7DPJEXqgaksUBYqIgYFBg2THkiU//Ed3ET/I6FJV8z+qMp6wuXQw8p0MW7iM9F3is31c4qRKwwiAyXaN50BaJOor9gBmD/ZkWEqVC60TrsOnKnikZZMbBtZdY+uZwAIXqsmpg5MDDO7gVCijmwM6g5N1xGsE25u6Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wW5sRDll; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFLMqGdskKThpNLPjqz2AIuwj6Lof2B1AFJs6lt6FhPj4w0nV+k0hCfuh+sUliv8KOdRReaK1aS1IeTyowHqTb9LciEWLyNoJVGkho5oAPmPzUzs1B1Udj8aIo2TeNdvoCg0lnttDUfg+NzQDh9vCq6pYP/vgGADdmtF9tI2eDowEE2yEgD3+rY8jNpwY2aeLr0tqXX65ZpABCla8bHAVMk5wAwQmDoRduI+pg/PRx4W9kal91jkduC1odeQnC3SeOrhm8ahIN/sMP9gV6lfBHpaiMGPAeeiN4vmJka+z5O6WdT1u/WH4k0W2quRlaIONhuexIh5pwjQ7iGUXd1Ksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4NRysPhnjm2OoMJJbVDwVdeEAOpC4PfuCMawqxcVnQ=;
 b=hjl8V8YIOC43gPbIIawDgBIBYF5JwTfsdSfI4DuqgzLZ8rQsfPqPMyH0IOA7DCNJEmaCHemPFVBv5oorg++quM+AWohKxmTSOaevuPNdSIAALqPVNggurzYx6n7cbC49+TeKvpoW1tYzWi6llPeDFR5RXJsDjIq+eu2SICR4ByvVbl+echQcNlmP6CZwmeexWrJtpiPkyF3V0sv2hLhBPu7cYnOy8+jGXPJvELbbHF4pADu182lQGWev0r5wqVpRS8B5Q184gI0u/me99MiSGp+uCZtjl6nKJowjh5uyNvQ7eH3s+yERx0CcmtG4rGrTx/MDlwwR9tKXvQrjRSHFCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4NRysPhnjm2OoMJJbVDwVdeEAOpC4PfuCMawqxcVnQ=;
 b=wW5sRDllVsjLUiEk0F9yotUbyDQiJ04USjCdseJ4tKMk80+vm9PNQZshJEaUu/IBQKBTQSAU2NRaWVgq9BKqbwrehArGOYXNoih9LYhjgRcQlcL35bTSmUgMgan+zcDzzXT7FVpGEy0u3cJOwRHVwDXIbee72Qrmy21IvVzP4qE=
Received: from IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 by SJ0PR12MB7036.namprd12.prod.outlook.com (2603:10b6:a03:483::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Wed, 14 Aug
 2024 07:13:35 +0000
Received: from IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa]) by IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa%2]) with mapi id 15.20.7849.023; Wed, 14 Aug 2024
 07:13:35 +0000
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
 AQHaH4D9pFM5xtDoeEuMNIpXuxvtzbCcYmwAgAEJ+aCABhoaAIAAMcLwgAAzdICAADdZAIABtmWAgAQ4ECCAAAuVAIAAD5dQgAAYdQCAAAF/8IAGJHEAgAFe7KCAUIcDAIAAVewAgDPXogCA08cW0IAaoUUAgAL7ppA=
Date: Wed, 14 Aug 2024 07:13:35 +0000
Message-ID:
 <IA0PR12MB769997D5958C191215254983DC872@IA0PR12MB7699.namprd12.prod.outlook.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
	<BN7PR12MB28029EB1A7D09882878499A2DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
	<c3fa1e04-92ed-48ab-a509-98e43abd5cd6@linaro.org>
	<BN7PR12MB2802E87F1A6CD22D904CAEACDC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
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
In-Reply-To: <20240812103812.72763f69@xps-13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7699:EE_|SJ0PR12MB7036:EE_
x-ms-office365-filtering-correlation-id: 610a20a5-c485-4ea4-980d-08dcbc309ce8
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VXo0SUNMUmx6L0Y5TUMza2pKNkpaanB0YVlmZWtod0NqOGN6MitQWTlLMHdI?=
 =?utf-8?B?Z2VRZ1NrcDRTWVNGcjNleUduM2hlYXpDRUpHd3FibXlja3hoa2tBT0dEN2la?=
 =?utf-8?B?ZEFFQzh3NHozWHRjTExJdTJsOWUzZ0lMZEwzejNhS0dicDI0U0U3QkcxTUNN?=
 =?utf-8?B?MTdXZXFDM2VUdVR2eEc3aC85VWNQVHBCM3ZwYjRpV1JDQXptbEJnS0NHb0RE?=
 =?utf-8?B?OG1EcEhmdEJoMnV4Q0tuNWhMYW95RG5rOFlvaGcrQ0hMaDBoa3ZEMzJsdHZC?=
 =?utf-8?B?clE5ZXJKK3VaUjN1b08xcStNY1hUUjIrZGExdzBabEdGVjNSMDlFa2MrdGZy?=
 =?utf-8?B?R29nNmwrYVBjZkhrZ1J6QkhyNTVqWk9jVFpyZmsrVzBlaHpRMmJrT2E0QWJi?=
 =?utf-8?B?b2pXNzZ6RVYzY2NTVy9IcHNkODZUU0Y5aHJFc2pZTnNDVGYxdGtLaW44VHo3?=
 =?utf-8?B?OE5oeElVRWxsbU5FZ2liTEZEQnZHUnpYdWVTTWdGSlZJRG1iVEd1SkdUMk5n?=
 =?utf-8?B?TzNLdWhybEtIMWg3eFhMQjhnVWF4aytmNkpVVDJwVytQenJ5eU91MjhCWUJu?=
 =?utf-8?B?YXk3MFQyZmdvZHNrM0dKVk9ncWpGM2wxSlREMGhrYnBlTC9yN2RaQ1F3QUk5?=
 =?utf-8?B?bkpBVmdkL2NQVmRGaFlSNlg4dGpJbVFRdytIS3pGVkFqeHhiVlZzSFBMZXZu?=
 =?utf-8?B?SXlRM0VPb0xZYTd0TytmSW1EVDB2cC9Ta0JHcm16SmMrS2JvVUpkMnBDOElM?=
 =?utf-8?B?U1YzSHdjVkt3eDlReEsvcUN2bGZ3T0NZa1hCa1JTR3JCM0V0am50eVlIR2pM?=
 =?utf-8?B?M0NQcWpxM2NWLy9oNDZZcVgzSlFyYnF5bDhUdmVyY2h3d3ZINVUrL0Q3TkN0?=
 =?utf-8?B?aXIxb013S0R5UHBXL1hqYXZ6R3BnaDR2cWQ0aHJrbjBiazU4bFhpWFdCSVVO?=
 =?utf-8?B?aWdIcFhZNzJkRDdpdTlZNGI4SkN4MWloS0NnM1pOVmFSWlJVZ0xhVzQya0NH?=
 =?utf-8?B?T09SSU9wRlVXMDFNYTJmaHAyNzhkRlZzYk15clRtZ3F4a3IwcTJhY2x2ckFE?=
 =?utf-8?B?andxeFVhc1dOUkFiQlV5RU9KMGtiSi9RSkkvbzhFTXgwQXY5ZnZ2cHhPdFBu?=
 =?utf-8?B?U2xQN1dIcnNLNkRTbFFrSzlzZGVjMDluSHhEVlovUnkwRjVxRUgwWVc5OXpN?=
 =?utf-8?B?ZHlMeGxQd3RuV1JyY1lac3p0bkZKZm9MQUdvaXk4V2NoSUFSdkF6TkZqcGNN?=
 =?utf-8?B?MjYxclN0cGxWNXlmOFhOZDA5SStVTEx4empUb1hSajVaS3E2aFZvWlE4M0da?=
 =?utf-8?B?QUlxYVZhRlJZNk14Z2llR1crTmlnQmIwdHNneGlZTkM1OFZzbjI3MlFsR0lH?=
 =?utf-8?B?L2Y5QmtXMkNiNHk5cmM0Um9GS1l6R1RCZXE2cGpJNk9zWVBHTjErc2tNV0FT?=
 =?utf-8?B?eVVwOFVidXJqQjRzc2lOOUEwbFl1bi9DZGptVGNwNlB6TENYWnU1K1N3a3hy?=
 =?utf-8?B?T2REL1ZzU2t6cXdySGJtenJCR3BJVWZDYUx2TWJVWnlSUTJQQ2J3cXZYeXJq?=
 =?utf-8?B?bFBidktCY1BkOEMzaDdmenNkOUdGeWJRbk8reGJPRUNiVFBaR2gzNFkzT2c5?=
 =?utf-8?B?RHpsRHZDaHlqZVowdkp1TzNYZFFEcmMvSmxOY0YyR2lrTmU5VnVhSVhLeDlR?=
 =?utf-8?B?bVNPc1lPcGtyazR1ZnFmL2dsYnFBQ0xJTlArNmJxdmpXRUhZWlBrNWlMSXp4?=
 =?utf-8?B?b3IwMFVhWVhuZ1ZZNlg3M0Z0eW5PZ0lQelNTeGlaQ25MR3JvZXFYRzM5eWox?=
 =?utf-8?B?YVg5aGp0b2pFajFtMHFDZUtmZnJ5ZWZGVmhkTDhDU2Qya09MQkJybHJjdzVG?=
 =?utf-8?B?N05VMDRyeGZqMnNyeUdTbGw4dVlxdGtIbWNhL0JlSVAyNHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7699.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UnY0Y0lvTytxTVd1MittWlpMOFJLSG5ZeHFWdUJqcUFDZGpBSUxvUGxyWlJs?=
 =?utf-8?B?VWdnMmkzQXlVVnNRMGpSeTBBdnNHYUwramNVK3ZuZ1BrNEFMWjVSbHNZVU9n?=
 =?utf-8?B?NXBKcStxYjMyZWh1M2I0RkgrR0dqRFBsVGNRdjN1SEFVbTBuUlFOWE9EOFRx?=
 =?utf-8?B?MFQ2V0ljUzA0L0FnZnEwdGFEV2gwTVRCbEJ1dTMvbGVmMlJtYkVoWjFqS051?=
 =?utf-8?B?S1FvREdtSUhkZkdBSE5ad0ZvOGVHdW5rYllIOWFQTTBCRHkwclhQYlNrS3FE?=
 =?utf-8?B?MGpKV3BpWkc4cDh3cnByMkYrN25DZlpFQkp6Uk9LZncra0pQWmJMTGF4UUt1?=
 =?utf-8?B?RE1KNHpOK29JSVJwbUhlZTVqN3RSdTAvSmFVTTdUaTJ4T1oydXBBY3hWTHgz?=
 =?utf-8?B?Y3JHWVZoT3MvMnZRMVNROXdScnNocXViV3dRNHJIZHNPV2xXVG84cENyV1Ri?=
 =?utf-8?B?K2tYWkZMeWF3LzRIWmM1N0pESTFSTVM5RGJlVWZYWER6eUl1N0J6Y0FWRDZJ?=
 =?utf-8?B?V3NSUnpFRjVIcm9FbmFreTd5SHF2MENCZEwyblJCTzFXelBMV0c1eDQ2WkhM?=
 =?utf-8?B?T3QzUThPTkphK3NwUmZCaVFZWUVBRHEyNEJ3cVl3Q2RZN3ArMkJ4UUFJSW13?=
 =?utf-8?B?bkwveG4wZXVZVU83Z3h2THRlNkpOSld5bTFmTnFTaWo1Z3pXZ2RyazdwRkQx?=
 =?utf-8?B?MW50dmt0NDNVeGJlNTdCWGJDUzNHZXIwa3luNE1PWG1CSHhxN0tOOVQxRElo?=
 =?utf-8?B?d1pEb2o4dzlrRjVtZzROMDFydjFGbFozN1pPZTk5R2tHK1ZVc0s2L1FjbW1y?=
 =?utf-8?B?U1VMYlFLSFFvRmRrSzQxRDR4c0dTVkZMVmYveG9TYzZNUUZUZHNLY2pYdWR1?=
 =?utf-8?B?Z3hLbVUyY2p4TG84MG5IcVp3amdzc01WSGZQelhYcWRuZTFmNUluWTJ4dldq?=
 =?utf-8?B?am51TG5aeFpydjZSOFdkdWgxYVpxUE03MEpwbGFZTVVpVWIwVCtlaFR1bmxS?=
 =?utf-8?B?c0VyYTlMenRTOFUxdTdVb2RaRkg0SXZLTHVOMWp3SFNDcWRldU5JSFlPRjc5?=
 =?utf-8?B?SGNzVUw5ekhWaWZGdnhDUTlyeGZzMHZKYmxPY3FkT2p6NUpEU0ZnNnNPb0hB?=
 =?utf-8?B?TmhEZmdjWGc5UllmL1FLRUxSano5RitvSWhDZDhWbGJXZjRicTAvd0xkTHM5?=
 =?utf-8?B?RXB5OEtScEZwa0QyTVY5eGlQcG5LMjdQa2VFT1hyc09yblVkT1RQbGRsQ1ZQ?=
 =?utf-8?B?RE1XVmRncmxPblBnRlNlMTg5ZDVPTXNoWVNIWndqTEJVQnJKTzMxZUN2TzVu?=
 =?utf-8?B?U3dmTmFTckxZNmNNMmRmTEFaYVM3RTlpVHRjcHlwUGxhU3JWYlUzakdyMjF0?=
 =?utf-8?B?K1lLL3NrK3pwTVdhS0luWW93SytmcFVScVdtbWpGZ05STlJIMTI4Vzg1cW1V?=
 =?utf-8?B?a3U0M2gyd0JWS2ZuR055TXR3QitKc3hYVS9BREk0RFVrU21Jd1Y1Y3VTbENw?=
 =?utf-8?B?YVloMll5QzVwb1NOZHIrbG9ZcjRwRkdHeWE3TSt2ckJ6SmlISlBEN3ZqbWM4?=
 =?utf-8?B?YWtsOXhlQ0ViVmNNZ1VBNFF5VkFMVkhRVUFzVEd5dXU0OXRrTTEvNFk5NFFR?=
 =?utf-8?B?NXpRdGk1Tk0xdFhvRHE1UEwwSENXZmQxWnM3cWpKYmZkNnF1MDNYOGkvWWlz?=
 =?utf-8?B?TEhjTGJ4Z3pPd3VZWTNyWGtMYmd6cjF0QnI3dDlmVWlFMXhQNzdYQlovVTFR?=
 =?utf-8?B?T2FIaktrSDVRWGFZaEVPa0dBUDhoc2xMb0RPb0RJbnhaSG9yZGN5RnA5L0I0?=
 =?utf-8?B?UTd1TVB2b3d5S0YyT0NpMGUxNmMwYzFLcDNHWVFKejlXbzF3TVowNjFwbksw?=
 =?utf-8?B?NmV5b2o0VHRRV3dWcjNCMEZReHo1cEQ0UjU4bzNseG1LRGhQS0hSbDAvMnM3?=
 =?utf-8?B?QWhwYlplelBRWU11d3hSUzJMdWZkS3RGOWZaczEzdi9KeFg3T1pvY3NVRU9Q?=
 =?utf-8?B?L3R5a1g3ZUdXR3I5YzFldUxmeldFYitwSktIZ0pEa1hIOUVPbCtUZlVxSXZm?=
 =?utf-8?B?M2VtczBGRWd4cFNGTWNjZWJXclYxWFI1Z2J0UTl1My9mSExyOUtici81dmR1?=
 =?utf-8?Q?+zRs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 610a20a5-c485-4ea4-980d-08dcbc309ce8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 07:13:35.6593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3jJ3nQ2rYnowhpl6ez5q2hal3jWjEEl8o+1CyQhfUmPs1LnC/h0lK4faV8+Hry89JNS2qEtYKB6v9Cb9ccWJBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7036

SGVsbG8gTWlxdWVsLA0KDQo+ID4gQmFzZWQgb24gdGhlIGlucHV0cy9zdWdnZXN0aW9ucyBmcm9t
IFR1ZG9yLCBpIGFtIHBsYW5uaW5nIHRvIGFkZCBhIG5ldw0KPiA+IGxheWVyIGJldHdlZW4gdGhl
IFNQSS1OT1IgYW5kIE1URCBsYXllcnMgdG8gc3VwcG9ydCBzdGFja2VkIGFuZA0KPiA+IHBhcmFs
bGVsIGNvbmZpZ3VyYXRpb25zLiBUaGlzIG5ldyBsYXllciB3aWxsIGJlIHBhcnQgb2YgdGhlIHNw
aS1ub3INCj4gPiBhbmQgbG9jYXRlZCBpbiBtdGQvc3BpLW5vci8NCj4gDQo+IEZvciBub3cgSSBk
b24ndCB0aGluayB5b3UgbmVlZCBhIHRvdGFsbHkgZ2VuZXJpYyBpbXBsZW1lbnRhdGlvbi4gQXMg
bG9uZyBhcw0KPiB0aGVyZSBpcyBvbmx5IG9uZSBjb250cm9sbGVyIHN1cHBvcnRpbmcgdGhlc2Ug
bW9kZXMsIEknZCBzYXkgdGhpcyBpcyBub3Qgc3VwZXINCj4gcmVsZXZhbnQuDQoNCklNSE8sIHRo
ZXJlIHNob3VsZCBiZSBhIGdlbmVyYWwgc29sdXRpb24gc2luY2UgdGhpcyBpc24ndCBsaW1pdGVk
IHRvIGp1c3QgDQpvbmUgY29udHJvbGxlci4gQW55IGNvbnRyb2xsZXIgY2FuIHN1cHBvcnQgc3Rh
Y2tlZCBtb2RlIHdpdGggbXVsdGlwbGUgDQpuYXRpdmUtY3Mgb3IgbXVsdGlwbGUgZ3Bpby1jcywg
b3Igd2l0aCBhIGNvbWJpbmF0aW9uIG9mIGEgbmF0aXZlLWNzIGFuZCBhIA0KZ3Bpby1jcy4gRm9y
IHBhcmFsbGVsIGNvbmZpZ3VyYXRpb25zLCB0aGVyZSBhcmUgb3RoZXIgY29udHJvbGxlcnMgZnJv
bSANCk1pY3JvY2hpcCBhbmQgc29tZSBmbGFzaCBkZXZpY2VzIHRoYXQgb3BlcmF0ZSBzaW1pbGFy
bHkgdG8gQU1EJ3MgcGFyYWxsZWwgDQptb2RlLg0KDQo+IA0KPiA+IFRoaXMgbGF5ZXIgd291bGQg
cGVyZm9ybSB0aGUgZm9sbG93aW5nIHRhc2tzOg0KPiA+ICAtIER1cmluZyBwcm9iaW5nLCBzdG9y
ZSBpbmZvcm1hdGlvbiBmcm9tIGFsbCB0aGUgY29ubmVjdGVkIGZsYXNoZXMsDQo+ID4gICAgd2hl
dGhlciBpbiBzdGFja2VkIG9yIHBhcmFsbGVsIG1vZGUsIGFuZCBwcmVzZW50IGl0IGFzIGEgc2lu
Z2xlIGRldmljZQ0KPiA+ICAgIHRvIHRoZSBNVEQgbGF5ZXIuDQo+ID4gIC0gUmVnaXN0ZXIgY2Fs
bGJhY2tzIHRocm91Z2ggdGhpcyBuZXcgbGF5ZXIgaW5zdGVhZCBvZiBzcGktbm9yL2NvcmUuYyBh
bmQNCj4gPiAgICBoYW5kbGUgTVREIGRldmljZSByZWdpc3RyYXRpb24uDQo+ID4gIC0gSW4gc3Rh
Y2tlZCBtb2RlLCBzZWxlY3QgdGhlIGFwcHJvcHJpYXRlIHNwaS1ub3IgZmxhc2ggYmFzZWQgb24g
dGhlDQo+ID4gICAgYWRkcmVzcyBwcm92aWRlZCBieSB0aGUgTVREIGxheWVyIGR1cmluZyBmbGFz
aCBvcGVyYXRpb25zLg0KPiA+ICAtIE1hbmFnZSBmbGFzaCBjcm9zc292ZXIgb3BlcmF0aW9ucyBp
biBzdGFja2VkIG1vZGUuDQo+ID4gIC0gRW5zdXJlIGJvdGggY29ubmVjdGVkIGZsYXNoZXMgYXJl
IGlkZW50aWNhbCBpbiBwYXJhbGxlbCBtb2RlLg0KPiA+ICAtIEhhbmRsZSBvZGQgYnl0ZSBjb3Vu
dCByZXF1ZXN0cyBmcm9tIHRoZSBNVEQgbGF5ZXIgZHVyaW5nIGZsYXNoDQo+ID4gICAgb3BlcmF0
aW9ucyBpbiBwYXJhbGxlbCBtb2RlLg0KPiA+DQo+ID4gRm9yIGltcGxlbWVudGluZyB0aGlzIHRo
ZSBjdXJyZW50IERUIGJpbmRpbmcgbmVlZCB0byBiZSB1cGRhdGVkIGFzDQo+ID4gZm9sbG93cy4N
Cj4gDQo+IFNvIHlvdSB3YW50IHRvIGdvIGJhY2sgdG8gc3RlcCAxIGFuZCByZWRlZmluZSBiaW5k
aW5ncz8gSXMgdGhhdCB3b3J0aD8NCg0KVGhlIGN1cnJlbnQgYmluZGluZ3MgYXJlIGVmZmVjdGl2
ZSBpZiB3ZSBvbmx5IHN1cHBvcnQgaWRlbnRpY2FsIA0KZmxhc2ggZGV2aWNlcyBvciBmbGFzaGVz
IG9mIHRoZSBzYW1lIG1ha2UgYnV0IHdpdGggZGlmZmVyZW50IHNpemVzIA0KY29ubmVjdGVkIGlu
IHN0YWNrZWQgbW9kZS4gSG93ZXZlciwgaWYgd2Ugd2FudCB0byBleHRlbmQgc3RhY2tlZCBzdXBw
b3J0IA0KdG8gaW5jbHVkZSBmbGFzaGVzIG9mIGRpZmZlcmVudCBtYWtlcyBpbiBzdGFja2VkIG1v
ZGUsIHRoZSBjdXJyZW50IA0KYmluZGluZ3MgbWF5IG5vdCBiZSBhZGVxdWF0ZS4gVGhhdCdzIHdo
eSBJIHN1Z2dlc3RlZCB1cGRhdGluZyB0aGUgYmluZGluZ3MgDQp0byBhY2NvbW1vZGF0ZSBhbGwg
cG9zc2libGUgc2NlbmFyaW8uDQoNCj4gDQo+ID4gc3RhY2tlZC1tZW1vcmllcyBEVCBjaGFuZ2Vz
Og0KPiA+ICAtIEZsYXNoIHNpemUgaW5mb3JtYXRpb24gY2FuIGJlIHJldHJpZXZlZCBkaXJlY3Rs
eSBmcm9tIHRoZSBmbGFzaCwgc28gaXQNCj4gPiAgICBoYXMgYmVlbiByZW1vdmVkIGZyb20gdGhl
IERUIGJpbmRpbmcuDQo+ID4gIC0gRWFjaCBzdGFja2VkIGZsYXNoIHdpbGwgaGF2ZSBpdHMgb3du
IGZsYXNoIG5vZGUuIFRoaXMgYXBwcm9hY2ggYWxsb3dzDQo+ID4gICAgZmxhc2hlcyBvZiBkaWZm
ZXJlbnQgbWFrZXMgYW5kIHNpemVzIHRvIGJlIHN0YWNrZWQgdG9nZXRoZXIsIGFzIGVhY2gNCj4g
PiAgICBmbGFzaCB3aWxsIGJlIHByb2JlZCBpbmRpdmlkdWFsbHkuDQo+IA0KPiBBbmQgaG93IHdp
bGwgeW91IGRlZmluZSBwYXJ0aXRpb25zIGNyb3NzaW5nIGRldmljZSBib3VuZGFyaWVzPyBJIGJl
bGlldmUgdGhpcw0KPiBjb25zdHJhaW50IGhhcyBiZWVuIHRvdGFsbHkgZm9yZ290dGVuIGluIHRo
aXMgcHJvcG9zYWwuDQoNCkFjY29yZGluZyB0byB0aGUgbmV3IGJpbmRpbmcgcHJvcG9zYWwsIG9u
ZSBvZiB0aGUgdHdvIGZsYXNoIG5vZGVzIHdpbGwgDQpoYXZlIGEgcGFydGl0aW9uIHRoYXQgY3Jv
c3NlcyB0aGUgZGV2aWNlIGJvdW5kYXJ5Lg0KDQo+IFRoZSB3aG9sZSBpZGVhIG9mIHN0YWNraW5n
IHR3byBkZXZpY2VzIHRoaXMgd2F5IHdhcyB0byBzaW1wbGlmeSB0aGUgdXNlcidzIGxpZmUNCj4g
d2l0aCBhIHNpbmdsZSBkZXZpY2UgZXhwb3NlZCBhbmQgdGhlIGNvbnRyb2xsZXIgaGFuZGxpbmcg
aXRzZWxmIHRoZSBDUyBjaGFuZ2VzLg0KPiBUaGF0IGlzIHByZWNpc2VseSB3aGF0IHRoZSBjdXJy
ZW50IGJpbmRpbmcgZG8uDQoNClRoYXQncyB0cnVlLCBidXQgYXMgSSBtZW50aW9uZWQgZWFybGll
ciwgaWYgd2UncmUgbm90IGluY2xpbmVkIHRvIHN1cHBvcnQgDQpzdGFja2VkIG1vZGUgZm9yIGZs
YXNoZXMgb2YgZGlmZmVyZW50IG1ha2VzLCB0aGVuIHRoZSBjdXJyZW50IGJpbmRpbmdzIA0KYXJl
IHN1ZmZpY2llbnQuDQoNCj4gVGhlIGZpbmFsIGdvYWwgYmVpbmcgdG8gZG91YmxlIHlvdXIgc3Rv
cmFnZSB0cmFuc3BhcmVudGx5LiBJZiB5b3VyIGdvYWwgd2FzIHRvDQo+IHB1dCB0d28gY2hpcHMg
YXNpZGUsIHRoZW4gbm9uZSBvZiB0aGlzIHdhcyBhY3R1YWxseSBuZWVkZWQuIElmIHlvdSBkb24n
dCBjYXJlDQo+IGFib3V0IHRoYXQgYW55bW9yZSwgdGhlbiBhbGwgdGhlIGVuZXJneSBwdXQgaW50
byBkaXNjdXNzaW5nIHRoZSBiaW5kaW5ncw0KPiBpbml0aWFsbHkgd2FzIHVzZWxlc3MgYW5kIGEg
Y29udHJvbGxlciBwcm9wZXJ0eSBjb3VsZCBhbHNvIGhhdmUgbWFkZSB0aGUgdHJpY2suDQo+IA0K
PiA+ICAtIFRoZSBzdGFja2VkLW1lbW9yaWVzIERUIGJpbmRpbmdzIHdpbGwgY29udGFpbiB0aGUg
cGhhbmRsZXMgb2YgdGhlIGZsYXNoDQo+ID4gICAgbm9kZXMgY29ubmVjdGVkIGluIHN0YWNrZWQg
bW9kZS4NCj4gPg0KPiA+IHNwaUAwIHsNCj4gPg0KPiA+ICAgZmxhc2hAMCB7DQo+ID4gICAgIGNv
bXBhdGlibGUgPSAiamVkZWMsc3BpLW5vciINCj4gPiAgICAgcmVnID0gPDB4MDA+Ow0KPiA+ICAg
ICBzdGFja2VkLW1lbW9yaWVzID0gPCZmbGFzaEAwICZmbGFzaEAxPjsNCj4gPiAgICAgc3BpLW1h
eC1mcmVxdWVuY3kgPSA8NTAwMDAwMDA+Ow0KPiA+ICAgICAuLi4NCj4gPiAgICAgICAgICAgICAg
IHBhcnRpdGlvbkAwIHsNCj4gPiAgICAgICAgIGxhYmVsID0gInFzcGktMCI7DQo+ID4gICAgICAg
ICByZWcgPSA8MHgwIDB4ZjAwMDAwPjsNCj4gPiAgICAgfTsNCj4gPg0KPiA+DQo+ID4gICB9DQo+
ID4NCj4gPiAgIGZsYXNoQDEgew0KPiA+ICAgICBjb21wYXRpYmxlID0gImplZGVjLHNwaS1ub3Ii
DQo+ID4gICAgICAgICAgICAgICByZWcgPSA8MHgwMT47DQo+ID4gICAgIHNwaS1tYXgtZnJlcXVl
bmN5ID0gPDUwMDAwMDAwPjsNCj4gPiAgICAgLi4uDQo+ID4gICAgICAgICAgICAgICBwYXJ0aXRp
b25AMCB7DQo+ID4gICAgICAgICBsYWJlbCA9ICJxc3BpLTEiOw0KPiA+ICAgICAgICAgcmVnID0g
PDB4MCAweDgwMDAwMD47DQo+ID4gICAgIH07DQo+ID4gICB9DQo+ID4gfQ0KPiA+DQo+ID4gcGFy
YWxsZWwtbWVtb3JpZXMgRFQgY2hhbmdlczoNCj4gPiAgLSBGbGFzaCBzaXplIGluZm9ybWF0aW9u
IGNhbiBiZSByZXRyaWV2ZWQgZGlyZWN0bHkgZnJvbSB0aGUgZmxhc2gsIHNvIGl0DQo+ID4gICAg
aGFzIGJlZW4gcmVtb3ZlZCBmcm9tIHRoZSBEVCBiaW5kaW5nLg0KPiA+ICAtIEVhY2ggZmxhc2gg
Y29ubmVjdGVkIGluIHBhcmFsbGVsIG1vZGUgd2lsbCBoYXZlIGl0cyBvd24gZmxhc2ggbm9kZS4N
Cj4gPiAgICBUaGlzIGFsbG93cyB1cyB0byB2ZXJpZnkgdGhhdCBib3RoIGZsYXNoZXMgY29ubmVj
dGVkIGluIHBhcmFsbGVsIGFyZQ0KPiA+ICAgIGlkZW50aWNhbCwgYXMgZWFjaCBmbGFzaCBub2Rl
IHdpbGwgYmUgcHJvYmVkIHNlcGFyYXRlbHkuDQo+IA0KPiBXZWxsLCB5b3UgZG9uJ3QgaGF2ZSB0
byB2ZXJpZnkgdGhhdC4gSXQncyBhIGJhc2ljIGhhcmR3YXJlIGRlc2lnbiBjb25zdHJhaW50IGZv
cg0KPiB1c2luZyB0aGlzIG1vZGUuDQoNCkFncmVlDQoNClJlZ2FyZHMsDQpBbWl0DQoNCj4gDQo+
IE90aGVyd2lzZSBzYW1lIGNvbW1lbnQgYXMgYWJvdmUsIHRoaXMgZGVzY3JpcHRpb24gZG9lc24n
dCBhbGxvdyBjb3JyZWN0DQo+IHBhcnRpdGlvbmluZyBhbmQgdGhhdCB3YXMgb25lIG9mIHRoZSBt
YWluIGNvbnN0cmFpbnRzIGJhY2sgd2hlbiB3ZSBkaXNjdXNzZWQNCj4gdGhlc2UgbmVlZHMuDQo+
IA0KPiA+ICAtIFRoZSBwYXJhbGxlbC1tZW1vcmllcyBEVCBiaW5kaW5ncyB3aWxsIGNvbnRhaW4g
dGhlIHBoYW5kbGVzIG9mIHRoZQ0KPiA+ICAgIGZsYXNoIG5vZGVzIGNvbm5lY3RlZCBpbiBwYXJh
bGxlbC4NCj4gPg0KPiA+IHNwaUAwIHsNCj4gPg0KPiA+ICAgZmxhc2hAMCB7DQo+ID4gICAgIGNv
bXBhdGlibGUgPSAiamVkZWMsc3BpLW5vciINCj4gPiAgICAgcmVnID0gPDB4MDA+Ow0KPiA+ICAg
ICBwYXJhbGxlbC1tZW1vcmllcyA9IDwmZmxhc2hAMCAmZmxhc2hAMT47DQo+ID4gICAgIHNwaS1t
YXgtZnJlcXVlbmN5ID0gPDUwMDAwMDAwPjsNCj4gPiAgICAgLi4uDQo+ID4gICAgICAgICAgICAg
ICBwYXJ0aXRpb25AMCB7DQo+ID4gICAgICAgICBsYWJlbCA9ICJxc3BpLTAiOw0KPiA+ICAgICAg
ICAgcmVnID0gPDB4MCAweGYwMDAwMD47DQo+ID4gICAgIH07DQo+ID4NCj4gPg0KPiA+ICAgfQ0K
PiA+DQo+ID4gICBmbGFzaEAxIHsNCj4gPiAgICAgY29tcGF0aWJsZSA9ICJqZWRlYyxzcGktbm9y
Ig0KPiA+ICAgICAgICAgICAgICAgcmVnID0gPDB4MDE+Ow0KPiA+ICAgICBzcGktbWF4LWZyZXF1
ZW5jeSA9IDw1MDAwMDAwMD47DQo+ID4gICAgIC4uLg0KPiA+ICAgICAgICAgICAgICAgcGFydGl0
aW9uQDAgew0KPiA+ICAgICAgICAgbGFiZWwgPSAicXNwaS0xIjsNCj4gPiAgICAgICAgIHJlZyA9
IDwweDAgMHg4MDAwMDA+Ow0KPiA+ICAgICB9Ow0KPiA+ICAgfQ0KPiA+IH0NCj4gDQo+IFRoYW5r
cywNCj4gTWlxdcOobA0K

