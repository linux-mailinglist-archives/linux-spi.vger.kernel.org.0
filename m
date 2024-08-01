Return-Path: <linux-spi+bounces-4118-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BECF944848
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2024 11:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B1671C2150E
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2024 09:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F84170A20;
	Thu,  1 Aug 2024 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wf9hDHpo"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55073170A14;
	Thu,  1 Aug 2024 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504542; cv=fail; b=kgVqtl8hBpk26tGzyXQxo58ixEjNIqx2g7QCErA26zk/t9f0KvaO3W/BWQiC41KCv9+6iaY4c7v8vRlBnDZS6uC+n+osK5cqwPYUNVeotAEwWPFgyOjXFW8TUsoz4aQJWUzV4K3iIQpK/sOElspdtrZQtHuEbeMMuirNlLBMAEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504542; c=relaxed/simple;
	bh=4yTwxZjqqKCwVAhfoxzraX2VmtjsROdKY8j4yd0IydY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AV4wI/DAmcn3sTOl5DwFqmjQNa9mqI1IjSSiguSPxSItf0hBtl1ldveoBSoZEV68ULRW37d4VfJLz/esK17jynmYlFT4fLoidHzyvZiOnEtQEyu9VS5G10u+rFs8Um44ic2RW2IpGRrfyMuffJgVa/i16WQS9XkII+7xEpnHxw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wf9hDHpo; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gxr9bufmguws7N32hTNnZY/GV8EAKqJxHoaS8dELEhaxzsaD9B48gjysmKHNKQVJSiwoYTiXKfYxWY8igdCuEl/WD/SIaWiDX6RFpT+RgYpl33IszH5AidvKpKNy+hcIRBIfIeYGyZfqwq+NwGlq+cEz2bcfhLD2ISqKRu7YCO8jsqwnI23P/51eUf12NQGhJLRpJ6jV3Tf5DquWSyslIqtdzK0qi+98S3RbVlhdUrVx91OkVceGDhA9stXPcBcb5z3Hbu9qiNx4aUn2ARjWF7dqAQryG06S1gdRpZ18ygZUD8HZ2UI2usKY0k6jWx9wNOO43v8OiFYOi38uOx1fbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yTwxZjqqKCwVAhfoxzraX2VmtjsROdKY8j4yd0IydY=;
 b=lBqQzkqkSdIBGfJeeCSR3UImhLJU1lj8kgdP8pHe7RyPb/sk22jfjOyPkiSCOMNIpF9ZrCdFMHeuCi+CaFNBcd4dE3QNWDtB6Fk4KFyvwdXGbsyL6nBAxdl58v7VQOa4Pmy/GaHS3M+KTB5ND9jc/m/cbPwRqqjx/IeqLRFIBPjZdyAKSw3WPmpCuoBqL2wJB9CfGjYH+VIORVAwUt4MmrK4iUJA9RY7LYYobRfQe8FiV6MbGI6rONpmxYsHsKVz+GD3IbRTZe3HzgPrHA8gChuozykpgpY9GfhcheZaMJNv9IiZqXsLJE7hYUxsPs8gM+w6wp6MU9V7y+o5XWBrhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yTwxZjqqKCwVAhfoxzraX2VmtjsROdKY8j4yd0IydY=;
 b=wf9hDHpo4cNL/0Pp6Sh3zb1sRbPCVACCqyUd5bTXfQicMyk9UAOTmg1sn2RMqszVVe5rjFA5MR48vV+BLUJ8AaSgDHx9D7falLp2QChu0tolAJHEzogXxSy6jAD2bXaXsokqWCWYk1dVE0ceyah6pvOUKoPKn5PPWkAzBy94yPA=
Received: from IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 by SA1PR12MB7245.namprd12.prod.outlook.com (2603:10b6:806:2bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 09:28:54 +0000
Received: from IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa]) by IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa%2]) with mapi id 15.20.7784.029; Thu, 1 Aug 2024
 09:28:54 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: "Frager, Neal" <neal.frager@amd.com>, "Simek, Michal"
	<michal.simek@amd.com>, Michael Walle <michael@walle.cc>, Tudor Ambarus
	<tudor.ambarus@linaro.org>, "broonie@kernel.org" <broonie@kernel.org>,
	"pratyush@kernel.org" <pratyush@kernel.org>, "miquel.raynal@bootlin.com"
	<miquel.raynal@bootlin.com>, "richard@nod.at" <richard@nod.at>,
	"vigneshr@ti.com" <vigneshr@ti.com>, "sbinding@opensource.cirrus.com"
	<sbinding@opensource.cirrus.com>, "lee@kernel.org" <lee@kernel.org>,
	"james.schulman@cirrus.com" <james.schulman@cirrus.com>,
	"david.rhodes@cirrus.com" <david.rhodes@cirrus.com>,
	"rf@opensource.cirrus.com" <rf@opensource.cirrus.com>, "perex@perex.cz"
	<perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>
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
 AQHaH4D9pFM5xtDoeEuMNIpXuxvtzbCcYmwAgAEJ+aCABhoaAIAAMcLwgAAzdICAADdZAIABtmWAgAQ4ECCAAAuVAIAAD5dQgAAYdQCAAAF/8IAGJHEAgAFe7KCAUIcDAIAAVewAgDPXogCA08cW0IAAMZYQgAeZXQCAAAXAgIAASRyAgAAIfoCAAQ9HgIAABEkAgAAvb2A=
Date: Thu, 1 Aug 2024 09:28:54 +0000
Message-ID:
 <IA0PR12MB7699BCDB5538F659F7D12CF9DCB22@IA0PR12MB7699.namprd12.prod.outlook.com>
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
 <D2ZHJ765LUGP.2KTA46P1BL75X@walle.cc>
 <e1587f61-f765-4a22-b06e-71387cc49c4d@amd.com>
 <D33M26RLVLHF.3Q5YARPBNSBOY@walle.cc>
 <9fb60743-3e89-49fa-a399-3cf2607a7e41@amd.com>
 <D33S9T73M6ND.G7CCJ4PDVYQU@walle.cc>
 <c01d048f-ad8b-417e-8ff0-96f9252c87f2@amd.com>
 <CH2PR12MB50044242FE253D7B0E3425ABF0B22@CH2PR12MB5004.namprd12.prod.outlook.com>
In-Reply-To:
 <CH2PR12MB50044242FE253D7B0E3425ABF0B22@CH2PR12MB5004.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7699:EE_|SA1PR12MB7245:EE_
x-ms-office365-filtering-correlation-id: 76c42393-6f04-4b37-3a22-08dcb20c5cd9
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OWF3RGdJa2FOS1E0VzcwM3cyMitHN0xoSC95a21nV3Zqb2w0L28wZFNBUWpT?=
 =?utf-8?B?YVc2WUJXMklNOXhqNi9jZDZwYU1ZZzlFV242enFUeVB2VWlCSzlDTm84VFA1?=
 =?utf-8?B?SkdZQ2FGMXNoU3kxVGFZMGFBL3IyMVlidjVlTlBXNjRDY1BVb2pKazg5UXVs?=
 =?utf-8?B?TGkwNHZtdHgwanhLQ2pra1dtMW0xYWYwbzZUa1BGTC9DKzZmQ2pZWXkydDVv?=
 =?utf-8?B?bUdkTGkwN1lVeWxHWW8vcVlaSTNaaTBidFdoZ1dLRktTWmdIQkdnMTJqbDVS?=
 =?utf-8?B?Tzl4dmVJQ3R2aWlITGljMGsrbG1OTnQ0VG51RWYwTmZtdm9WSVRmdXRUNlpD?=
 =?utf-8?B?djFiWXVoTzVtR2VxcFQ0ZU5WY3kvRSt5ajhRYTUwNi9vQnk3dXkwMVRueWNr?=
 =?utf-8?B?WXVrNW1jeG51SkJCWmlTdEFiRG1YTGFpWE4yTjVGTVIrd2svTDBYbisrSVZI?=
 =?utf-8?B?Y2Jod3BFSVVSZG9Fa3Z6dXRoeFlIcDNTVkU4eW1wMTZpazhUOW5TMHV2L2Nv?=
 =?utf-8?B?eWFtV2ZCOHlpUTFPTVBpK01ucGwxSlFrbnhsZDl6czI1dXA1YmdFdXREcWcx?=
 =?utf-8?B?OGk2blNaZDl2TkxxZU1KRCsxOUd4Q0dzQkhWWVBPRXhmbnNWdUxlQnJ0VXYz?=
 =?utf-8?B?RExodWQ1aVNOOWkydlJNUGNJQVpSK1FERTR5bjd5OHRjU1dHeU1nWEsxaVpp?=
 =?utf-8?B?cjI2aWxSV0hWcWhEeUcvOXBtMTIvVSt3WjdMWWR0dEI2Snh6M050VkVKSVU5?=
 =?utf-8?B?cDRQK3laTXEvSm1oSWYwaDQ5cnJKQllBY0lOcUd2ckR6eWxqbjZwbVBuY2Mv?=
 =?utf-8?B?R2p1N2s4Y0ZnWHZTSGRBRFk5NDVuRnU1dkNQMmRkd1RDVzVudGdXV053U2JF?=
 =?utf-8?B?VWFmVXpGTjJQY1JNdXdoWUxOOHVqSWdQa3Rqb3p6RUdiYWxUVmZ3aC83TFAv?=
 =?utf-8?B?cjhQUEM4ZTVuQ3puUE1PM2IvWXNtd2lkNmRmbXNSL3FqRUd0Nnh3OGFTSGcx?=
 =?utf-8?B?bHpWSmJpUmVFVzl4OFd1ZWVrYXV2RExDTy9zbm8rZXBPMERiclNCOGFDUnhT?=
 =?utf-8?B?TEZwVWZwcmpOVEs4TW5EeGlEdGdlaTV0dXdpTElSeWxIMnFxcTZRWjFGcTk4?=
 =?utf-8?B?ZER5bTFsZ3VsWmZjUDFYSzhnaU9oZm5ua1VLbHNpdXFvZGdOSTRPb05Xd0sr?=
 =?utf-8?B?d3p3TnFzczZwRk4zWjB2OUt1bEFHODZpVktZVS8zY2NVd1Z4VDgxdFBIblEx?=
 =?utf-8?B?Z1daOWpFOHJnaUdGYStYbFY0NG43cjNlaFYxVDYzaks4eHMxTWhBaURwZ0dR?=
 =?utf-8?B?eS9XLzRXR2ZIZ3RjQm1ldXh2RjlkL0trRkluSnVGMWNqS2RaNVpHdlhrSW5y?=
 =?utf-8?B?L083UEdmN2JvS21lSW54NDl0a0JYQVdIOWdpaklVS0NXeG5Sd05nbTdkSUZ6?=
 =?utf-8?B?SytDUlpVY0lEU2JlQ0x6WEp0K1FUUXdSYmF1MVlMMHR3SUNudU9aU2xGOXpv?=
 =?utf-8?B?Um91VCtwaEpvUFhDNjJsSUhhWi9rRjVCMGNKUENvZmhtY3ovT29qYkpFM3NL?=
 =?utf-8?B?em5sSXRoSWFtRStzazBDdDNSYkw5Umtrb3lzSmpuUWJoakRjdnRiRlJGZG5q?=
 =?utf-8?B?bjMzaEJMY1hxemRwUjdEWGZ3QTZIQUNDcEtVN05TdFBpOEEvQWZwb0RFNTBv?=
 =?utf-8?B?TnNOWE1KdU93aVdBbExtZ3BsWk91MXVaQzUweHhoSk8yZWIxUmEzVzNIdnR5?=
 =?utf-8?B?Wlh0TUZDZnZiZjFyc0ViekhGYm9Kc0Q2WkNGOGozWXRsSmxJSmIvc3Q1R3Vk?=
 =?utf-8?B?bFlHVm1FVTBVcE9qcGNSWXhpMWM0eVJjdTU0NTk5NDdjelY5YVJsNHM4ZGsw?=
 =?utf-8?B?R0NtVlltTmZVTFVnZ1pUTkNHbmErR2grY20vWmR6N3JvRk9venVwc3BaSTFU?=
 =?utf-8?Q?fv/CKlf0mZ0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7699.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dHJ2bzJYQlhXN05HQ1N6SXYrbENZK3JwVXU4MytyMEszNWRYSWpIMk9EQTdz?=
 =?utf-8?B?bDhKZG9xNzFrU2pVTGlGdkNSN0FBdDM0K3VQN3BkN3NuNFVxVk0zYWIvUFI4?=
 =?utf-8?B?elZrMFp4dTBPUjJRdVZ2Tll0S1dkYVhRbURDaDVUcUJQV2ZUQWJTbTdmZm4z?=
 =?utf-8?B?Vk1Wa3ZZM3F0TUtCalRBWWFpVUdBU2U0dldkVHRET1NTUlVOSEVIZGIvYkEr?=
 =?utf-8?B?QW81STEycDNYM3kxYlVCRDNKTGloSStlOWt5VytFWWRiODA4cHhhSXcrRW5y?=
 =?utf-8?B?QmttM2xjeFdSRWdxTHJWeWhTdFJaS2YycC9FY05FSHZiNzVWS2hhejVSdmNB?=
 =?utf-8?B?WURwOVp4dEpma0RsbTFUb3pRQlYvbG9JcXo1czc4dlp1SXNrTHBOZTFaY1R1?=
 =?utf-8?B?eE5MT0U1OHpwZ2pUUXNKRDB3NndzOFlIcWdlNGw2Q3haMUFMcWtkelNjTTcx?=
 =?utf-8?B?Y3hmakxVOHpGRFRnemQ2bDhIOWlmV01VZW0zZkRXdXpWR2tKaWNiNkVGU1hG?=
 =?utf-8?B?NmtlN2lJbTNVdU16RFEvb3gwZUhUSzdYa09JdzJTV0FnV3dUd1MwSXZreHJv?=
 =?utf-8?B?REowTmtST1haL0dOcVhDTE5RTWhlUi9vZG1iNXpLL3QySWRRN0l5c1JWd2dj?=
 =?utf-8?B?N0QzYjRDOEJpZFh3TnYxenNjQklsT2IxSHlEL29KUm1ObUNacU9PUzc4bHly?=
 =?utf-8?B?OWRpNmRmeEhsdlRrR2gxOHFRandQZmNFTUQ3T2E3dU81dlJyM2lhRC9XMnpU?=
 =?utf-8?B?U0ZFWmlmMEIvUXVGcW9qN3c3SEZJMmhnRWhmS3gvSnZyMXVOcXBhdWpseE1H?=
 =?utf-8?B?UHBINzRmb2dLdFl4cjJmclBGbnJBbkt1dHYwdE8wZEtIZUtVSmoycGtYYzhM?=
 =?utf-8?B?OGUxRWhxd1BUenhlRmFUS2tZZ0FxZHkybFhnK05oRW84T1Fqa3RCZEI1OE82?=
 =?utf-8?B?OEs3NEVSUi9LQ3J2VjFCZGhKMk1oZ25pSUNTVkl0NHRHYXlRcG5EUUFSN0Fx?=
 =?utf-8?B?eW9CRVhmeHFzbURpVEZrZXUraVA2b1Rib2hJRU5SZFZEeDB5OUgyU2dXd2ZG?=
 =?utf-8?B?c05EZjBvclJUelRIaWNXR2FTV0duQloyQ1Z6b2FhaDFKMGp2aUxZL1dGQUxP?=
 =?utf-8?B?RTlLcHRBSGlyWXFGZlBGeUZxWmozWHZhUDQrMm1mU3dUejR5NWRib0dXSkow?=
 =?utf-8?B?UldtUGNSU2FhNzZpSjVyM3Z5VkNVaE1SVC9MZ1dkMS85c25ITEs3VFFFMEZR?=
 =?utf-8?B?TXEra0hRc0w4RUhudThCdU8zMGIvd1Fvd2dYMUdMV2g1Si9TNDIxQ0U4RjhN?=
 =?utf-8?B?SG5wc0RZZXdrbkRYam1PSU5hR1lVTEw1dk1PWC9XaWxNYXUrU3J6eVhkd2My?=
 =?utf-8?B?WWpIcDlvaDlCRWNEZXU3d1FzSzA1NGhXRU9qK0xtWW9DTEVpMWU1R3JjK0N3?=
 =?utf-8?B?RDVtaFgrSWdBbjJURlpENUlrSDlCUDFFU2N3T1BwZjZMbUE3YVNvSkFYYW5v?=
 =?utf-8?B?Q2VIVzdYcWlkeTRPWVU2cVlPZkx6Z09kSHNXQlRDYmh1QUY4Qzg0NWprcGM5?=
 =?utf-8?B?NEtCNTA4eE1aQnY0MTdMNXZqK2hvNForQWxsTE4xc3NPZ1lPK3FCYkV0eGo0?=
 =?utf-8?B?eTZxeERCRklSdHVYNmErQjQrZ21JdEY4TUVPKzlWYjRpYUxObWFUcjhZTERX?=
 =?utf-8?B?S0s2RWZjOW0vMGNUTnJiZ1RFbVFvWmZZckhxc3ZPaTlTWWhYeFVtOGFBWlV5?=
 =?utf-8?B?cHpPRG9iTGVVL1hEc1ZBSGtwWFE0K2RKUDBJZUxFT2gvRWc1RzFtQVg5NGVP?=
 =?utf-8?B?K0RjQ2crVlJyTC9QaWNxa2liYU9DZTd6VFJGdGFBbHhmbG40cEp1TkdwdlJU?=
 =?utf-8?B?aG9TWmFORXpaNXcrL2J0STNUdkJiNy9OMk5qb3d0SlF2UWNtcTNZa0J0SVJ2?=
 =?utf-8?B?RGdPbnZlUlUyd2w3WlVJeUFIWWdkMkM2WEhSbE9PZzFOelFLdktiV1lpMHE0?=
 =?utf-8?B?dlR6a3VYb3BpQUl1S2RsZVQ0ajVqdTUya21yNEp5MTkyZmJEVXFpcVdNNnh6?=
 =?utf-8?B?SStSNTc2UWdmU1dWOVJ6VjQ3anFXMTJzTlRRc0VMTXdVdUVwMVdjSnU3T3Rj?=
 =?utf-8?Q?zFj8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c42393-6f04-4b37-3a22-08dcb20c5cd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 09:28:54.6819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GC4VMxc35i7OkVpeBqpY4LmeA5N1R9QDmtuUHlvqrntmaNweWC1alr1RiB5unkvt+QXgviqRK+xIXGfJedhuQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7245

SGVsbG8sDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFnZXIs
IE5lYWwgPG5lYWwuZnJhZ2VyQGFtZC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMSwg
MjAyNCAxMjowNyBQTQ0KPiBUbzogU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+
OyBNaWNoYWVsIFdhbGxlDQo+IDxtaWNoYWVsQHdhbGxlLmNjPjsgTWFoYXBhdHJhLCBBbWl0IEt1
bWFyIDxhbWl0Lmt1bWFyLQ0KPiBtYWhhcGF0cmFAYW1kLmNvbT47IFR1ZG9yIEFtYmFydXMgPHR1
ZG9yLmFtYmFydXNAbGluYXJvLm9yZz47DQo+IGJyb29uaWVAa2VybmVsLm9yZzsgcHJhdHl1c2hA
a2VybmVsLm9yZzsgbWlxdWVsLnJheW5hbEBib290bGluLmNvbTsNCj4gcmljaGFyZEBub2QuYXQ7
IHZpZ25lc2hyQHRpLmNvbTsgc2JpbmRpbmdAb3BlbnNvdXJjZS5jaXJydXMuY29tOw0KPiBsZWVA
a2VybmVsLm9yZzsgamFtZXMuc2NodWxtYW5AY2lycnVzLmNvbTsgZGF2aWQucmhvZGVzQGNpcnJ1
cy5jb207DQo+IHJmQG9wZW5zb3VyY2UuY2lycnVzLmNvbTsgcGVyZXhAcGVyZXguY3o7IHRpd2Fp
QHN1c2UuY29tDQo+IENjOiBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IG5pY29s
YXMuZmVycmVAbWljcm9jaGlwLmNvbTsNCj4gYWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb207
IGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldjsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgYWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnOw0KPiBwYXRjaGVzQG9wZW5z
b3VyY2UuY2lycnVzLmNvbTsgbGludXgtc291bmRAdmdlci5rZXJuZWwub3JnOyBnaXQgKEFNRC0N
Cj4gWGlsaW54KSA8Z2l0QGFtZC5jb20+OyBhbWl0cmtjaWFuMjAwMkBnbWFpbC5jb207IENvbm9y
IERvb2xleQ0KPiA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+OyBiZWFuaHVvQG1pY3Jvbi5j
b20NCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2MTEgMDcvMTBdIG10ZDogc3BpLW5vcjogQWRkIHN0
YWNrZWQgbWVtb3JpZXMgc3VwcG9ydA0KPiBpbiBzcGktbm9yDQo+IA0KPiBIaSBNaWNoYWVsLA0K
PiANCj4gPj4+IEFsbCBJJ20gc2F5aW5nIGlzIHRoYXQgeW91IHNob3VsZG4ndCBwdXQgYnVyZGVu
IG9uIHVzICh0aGUgU1BJIE5PUg0KPiA+Pj4gbWFpbnRhaW5lcnMpIGZvciB3aGF0IHNlZW1zIHRv
IG1lIGF0IGxlYXN0IGFzIGEgbmljaGUuIFRodXMgSSB3YXMNCj4gPj4+IGFza2luZyBmb3IgcGVy
Zm9ybWFuY2UgbnVtYmVycyBhbmQgdXNlcnMuIENvbnZpbmNlIG1lIHRoYXQgSSdtIHdyb25nDQo+
ID4+PiBhbmQgdGhhdCBpcyB3b3J0aCBvdXIgdGltZS4NCj4gPj4NCj4gPj4gTm8uIEl0IGlzIG5v
dCByZWFsbHkganVzdCBmZWF0dXJlIG9mIG91ciBldmFsdWF0aW9uIGJvYXJkcy4gQ3VzdG9tZXJz
DQo+ID4+IGFyZSB1c2luZyBpdC4gSSB3YXMgdGFsa2luZyB0byBvbmUgZ3V5IGZyb20gZmllbGQg
YW5kIGhlIGNvbmZpcm1zIG1lDQo+ID4+IHRoYXQgdGhlc2UgY29uZmlndXJhdGlvbnMgYXJlIHVz
ZWQgYnkgaGlzIG11bHRpcGxlIGN1c3RvbWVycyBpbiByZWFsDQo+IHByb2R1Y3RzLg0KPiA+DQo+
ID4gV2hpY2ggYmVncyB0aGUgcXVlc3Rpb24sIGRvIHdlIHJlYWxseSBoYXZlIHRvIHN1cHBvcnQg
ZXZlcnkgZmVhdHVyZSBpbg0KPiA+IHRoZSBjb3JlIChJJ2QgbGlrZSB0byBoZWFyIFR1ZG9ycyBh
bmQgUHJhdHl1c2ggb3BpbmlvbiBoZXJlKS4NCj4gPiBIb25lc3RseSwgdGhpcyBqdXN0IGxvb2tz
IGxpa2UgYSBjb25jYXRlbmF0aW9uIG9mIHR3byBRU1BJDQo+ID4gY29udHJvbGxlcnMuDQo+IA0K
PiA+IEJhc2VkIG9uIG15IHVuZGVyc3RhbmRpbmcgZm9yIHN0YWNrZWQgeWVzLiBGb3IgcGFyYWxs
ZWwgbm8uDQo+IA0KPiA+IFdoeSBkaWRuJ3QgeW91IGp1c3QgdXNlIGEgbm9ybWFsIG9jdGFsIGNv
bnRyb2xsZXIgd2hpY2ggaXMgYSBwcm90b2NvbA0KPiA+IGFsc28gYmFja2VkIGJ5IHRoZSBKRURF
QyBzdGFuZGFyZC4NCj4gDQo+ID4gT24gbmV3ZXIgU09DIG9jdGFsIElQIGNvcmUgaXMgdXNlZC4N
Cj4gPiBBbWl0IHBsZWFzZSBjb21tZW50Lg0KPiANCj4gPiBJcyBpdCBhbnkgZmFzdGVyPw0KPiAN
Cj4gPiBBbWl0OiBwbGVhc2UgcHJvdmlkZSBudW1iZXJzLg0KPiANCkhlcmUgYXJlIHNvbWUgUVNQ
SSBwZXJmb3JtYW5jZSBudW1iZXJzIGNvbXBhcmluZyBhIHNpbmdsZSBmbGFzaCBtb2RlIGFuZCAN
CnR3byBmbGFzaGVzIGNvbm5lY3RlZCBpbiBwYXJhbGxlbCBtb2RlLiBJIHJhbiB0aGUgdGVzdCBv
biBhIFZDSzE5MCBFdmFsIA0KQm9hcmQgaHR0cHM6Ly93d3cueGlsaW54LmNvbS9wcm9kdWN0cy9i
b2FyZHMtYW5kLWtpdHMvdmNrMTkwLmh0bWwsIA0KbWVhc3VyaW5nIHRoZSB0aW1pbmcgZm9yIG10
ZF9kZWJ1ZyBlcmFzZSwgd3JpdGUsIGFuZCByZWFkIG9wZXJhdGlvbnMuIA0KVGhlIFFTUEkgYnVz
IGNsb2NrIHdhcyBzZXQgdG8gMTUwTUh6LCBhbmQgdGhlIGRhdGEgc2l6ZSB3YXMgMzJNQiwgDQpj
b21wYXJpbmcgYSBzaW5nbGUgZmxhc2ggc2V0dXAgd2l0aCBhIHR3by1mbGFzaCBwYXJhbGxlbCBt
b2RlIHNldHVwLg0KDQpTaW5nbGUgRmxhc2ggbW9kZToNCg0KeGlsaW54LXZjazE5MC0yMDI0Mjov
aG9tZS9wZXRhbGludXgjIHRpbWUgbXRkX2RlYnVnIGVyYXNlIC9kZXYvbXRkMiAweDAwIDB4MWUw
MDAwMA0KRXJhc2VkIDMxNDU3MjgwIGJ5dGVzIGZyb20gYWRkcmVzcyAweDAwMDAwMDAwIGluIGZs
YXNoDQoNCnJlYWwJMG01NC43MTNzDQp1c2VyCTBtMC4wMDBzDQpzeXMJMG0zMi42MzlzDQp4aWxp
bngtdmNrMTkwLTIwMjQyOi9ob21lL3BldGFsaW51eCMgdGltZSBtdGRfZGVidWcgd3JpdGUgL2Rl
di9tdGQyIDB4MDAgMHgxZTAwMDAwIHRlc3QuYmluDQpDb3BpZWQgMzE0NTcyODAgYnl0ZXMgZnJv
bSB0ZXN0LmJpbiB0byBhZGRyZXNzIDB4MDAwMDAwMDAgaW4gZmxhc2gNCg0KcmVhbAkwbTMwLjE4
N3MNCnVzZXIJMG0wLjAwMHMNCnN5cwkwbTE2LjM1OXMNCnhpbGlueC12Y2sxOTAtMjAyNDI6L2hv
bWUvcGV0YWxpbnV4IyB0aW1lIG10ZF9kZWJ1ZyByZWFkIC9kZXYvbXRkMiAweDAwIDB4MWUwMDAw
MCB0ZXN0LXJlYWQuYmluDQpDb3BpZWQgMzE0NTcyODAgYnl0ZXMgZnJvbSBhZGRyZXNzIDB4MDAw
MDAwMDAgaW4gZmxhc2ggdG8gdGVzdC1yZWFkLmJpbg0KDQpyZWFsCTBtMC40NzJzDQp1c2VyCTBt
MC4wMDFzDQpzeXMJMG0wLjA0MHMNCg0KVHdvIGZsYXNoZXMgY29ubmVjdGVkIGluIHBhcmFsbGVs
IG1vZGU6DQoNCnhpbGlueC12Y2sxOTAtMjAyNDI6L2hvbWUvcGV0YWxpbnV4IyB0aW1lIG10ZF9k
ZWJ1ZyBlcmFzZSAvZGV2L210ZDIgMHgwMCAweDFlMDAwMDANCkVyYXNlZCAzMTQ1NzI4MCBieXRl
cyBmcm9tIGFkZHJlc3MgMHgwMDAwMDAwMCBpbiBmbGFzaA0KDQpyZWFsCTBtMjcuNzI3cw0KdXNl
cgkwbTAuMDA0cw0Kc3lzCTBtMTQuOTIzcw0KeGlsaW54LXZjazE5MC0yMDI0MjovaG9tZS9wZXRh
bGludXgjIHRpbWUgbXRkX2RlYnVnIHdyaXRlIC9kZXYvbXRkMiAweDAwIDB4MWUwMDAwMCB0ZXN0
LmJpbg0KQ29waWVkIDMxNDU3MjgwIGJ5dGVzIGZyb20gdGVzdC5iaW4gdG8gYWRkcmVzcyAweDAw
MDAwMDAwIGluIGZsYXNoDQoNCnJlYWwJMG0xNi41MzhzDQp1c2VyCTBtMC4wMDBzDQpzeXMJMG04
LjUxMnMNCnhpbGlueC12Y2sxOTAtMjAyNDI6L2hvbWUvcGV0YWxpbnV4IyB0aW1lIG10ZF9kZWJ1
ZyByZWFkIC9kZXYvbXRkMiAweDAwIDB4MWUwMDAwMCB0ZXN0LXJlYWQuYmluDQpDb3BpZWQgMzE0
NTcyODAgYnl0ZXMgZnJvbSBhZGRyZXNzIDB4MDAwMDAwMDAgaW4gZmxhc2ggdG8gdGVzdC1yZWFk
LmJpbg0KDQpyZWFsCTBtMC4yNjNzDQp1c2VyCTBtMC4wMDBzDQpzeXMJMG0wLjA0NHMNCg0KUmVn
YXJkcywNCkFtaXQNCg0KPiA+IERvIHlvdSBnZXQgbW9yZSBjYXBhY2l0eT8gRG9lcyBhbnlvbmUg
cmVhbGx5IHVzZSBsYXJnZSBTUEktTk9SDQo+ID4gZmxhc2hlcz8gSWYgc28sIHdoeT8NCj4gDQo+
ID4gWW91IGdldCB0d2ljZSBtb3JlIGNhcGFjaXR5IGJhc2VkIG9uIHRoYXQgY29uZmlndXJhdGlv
bi4gSSBjYW4ndA0KPiA+IGFuc3dlciB0aGUgc2Vjb25kIHF1ZXN0aW9uIGJlY2F1c2Ugbm90IHdv
cmtpbmcgd2l0aCBmaWVsZC4gQnV0IGJvdGggb2YNCj4gPiB0aGF0IGNvbmZpZ3VyYXRpb25zIGFy
ZSB1c2VkIGJ5IGN1c3RvbWVycy4gQWRkaW5nIE5lYWwgaWYgaGUgd2FudHMgdG8gYWRkDQo+IHNv
bWV0aGluZyBtb3JlIHRvIGl0Lg0KPiANCj4gSnVzdCB0byBhZGQgYSBjb21tZW50IGFzIEkgd29y
ayBkaXJlY3RseSB3aXRoIG91ciBjdXN0b21lcnMuICBUaGUgbWFpbg0KPiByZWFzb24gdGhpcyBz
dXBwb3J0IGlzIGltcG9ydGFudCBpcyBmb3Igb3VyIG9sZGVyIFNvQ3MsIHp5bnEgYW5kIHp5bnFt
cC4NCj4gDQo+IE1vc3Qgb2Ygb3VyIGN1c3RvbWVycyBhcmUgdXNpbmcgUVNQSSBmbGFzaCBhcyB0
aGUgZmlyc3QgYm9vdCBtZW1vcnkgdG8gZ2V0DQo+IGZyb20gdGhlIGJvb3QgUk9NIHRvIHUtYm9v
dC4gIFRoZXkgdGhlbiB0eXBpY2FsbHkgdXNlIG90aGVyIG1lbW9yaWVzLCBzdWNoDQo+IGFzIGVN
TUMgZm9yIHRoZSBMaW51eCBrZXJuZWwsIE9TIGFuZCBmaWxlIHN5c3RlbS4NCj4gDQo+IFRoZSBp
c3N1ZSB3ZSBoYXZlIG9uIHRoZSB6eW5xIGFuZCB6eW5xbXAgU29DcyBpcyB0aGF0IHRoZSBib290
IFJPTSAoY29kZQ0KPiB0aGF0IGNhbm5vdCBiZSBjaGFuZ2VkKSB3aWxsIG5vdCBib290IGZyb20g
YW4gT1NQSSBmbGFzaC4gIEl0IHdpbGwgb25seSBib290DQo+IGZyb20gYSBRU1BJIGZsYXNoLiAg
VGhpcyBpcyB3aGF0IGlzIGZvcmNpbmcgbWFueSBvZiBvdXIgY3VzdG9tZXJzIGRvd24gdGhlDQo+
IFFTUEkgcGF0aC4NCj4gU2luY2UgbWFueSBvZiB0aGVzZSBjdXN0b21lcnMgYXJlIGludGVyZXN0
ZWQgaW4gYWRkaXRpb25hbCBzcGVlZCBhbmQNCj4gbWVtb3J5IHNpemUsIHRoZXkgdGhlbiBlbmQg
dXAgdXNpbmcgYSBwYXJhbGxlbCBvciBzdGFja2VkIGNvbmZpZ3VyYXRpb24NCj4gYmVjYXVzZSB0
aGV5IGNhbm5vdCB1c2UgYW4gT1NQSSB3aXRoIHp5bnEgb3IgenlucW1wLg0KPiANCj4gQWxsIG9m
IG91ciBuZXdlciBTb0NzIGNhbiBib290IGZyb20gT1NQSS4gIEkgYWdyZWUgd2l0aCB5b3UgdGhh
dCBpZiBzb21lb25lDQo+IGNvdWxkIGNob29zZSBPU1BJIGZvciBwZXJmb3JtYW5jZSwgdGhleSB3
b3VsZCwgc28gSSBkbyBub3QgZXhwZWN0IHBhcmFsbGVsIG9yDQo+IHN0YWNrZWQgY29uZmlndXJh
dGlvbnMgd2l0aCBvdXIgbmV3ZXIgU29Dcy4NCj4gDQo+IEkgZ2V0IHdoeSB5b3Ugc2VlIHRoaXMg
Y29uZmlndXJhdGlvbiBhcyBhIG5pY2hlLCBidXQgZm9yIHVzLCBpdCBpcyBhIHZlcnkgbGFyZ2UN
Cj4gbmljaGUgYmVjYXVzZSB6eW5xIGFuZCB6eW5xbXAgYXJlIHR3byBvZiBvdXIgbW9zdCBzdWNj
ZXNzZnVsIFNvQyBmYW1pbGllcy4NCj4gDQo+ID4gSSBtZWFuIHlvdSd2ZSBwdXQgdGhhdCBjb250
cm9sbGVyIG9uIHlvdXIgU29DLCB5b3UgbXVzdCBoYXZlIHNvbWUNCj4gPiBjb252aW5jaW5nIGFy
Z3VtZW50cyB3aHkgYSBjdXN0b21lciBzaG91bGQgdXNlIGl0Lg0KPiANCj4gPiBJIGV4cGVjdCBy
ZWNvbW1lbmRhdGlvbiBpcyB0byB1c2Ugc2luZ2xlIGNvbmZpZ3VyYXRpb24gYnV0IGlmIHlvdSBu
ZWVkDQo+ID4gYmlnZ2VyIHNwYWNlIGZvciB5b3VyIGFwcGxpY2F0aW9uIHRoZSBvbmx5IHdheSB0
byBleHRlbmQgaXQgaXMgdG8gdXNlDQo+ID4gc3RhY2tlZCBjb25maWd1cmF0aW9uIHdpdGggdHdv
IHRoZSBzYW1lIGZsYXNoZXMgbmV4dCB0byBlYWNoIG90aGVyLg0KPiA+IElmIHlvdSB3YW50IHRv
IGhhdmUgYmlnZ2VyIHNpemUgYW5kIGFsc28gYmUgZmFzdGVyIGFuc3dlciBpcyBwYXJhbGxlbA0K
PiA+IGNvbmZpZ3VyYXRpb24uDQo+IA0KPiANCj4gPj4+IFRoZSBmaXJzdCByb3VuZCBvZiBwYXRj
aGVzIHdlcmUgcmVhbGx5IGludmFzaXZlIHJlZ2FyZGluZyB0aGUgY29yZQ0KPiA+Pj4gY29kZS4g
U28gaWYgdGhlcmUgaXMgYSBjbGVhbiBsYXllcmluZyBhcHByb2FjaCB3aGljaCBjYW4gYmUgZW5h
YmxlZA0KPiA+Pj4gYXMgYSBtb2R1bGUgYW5kIHlvdSBhcmUgbWFpbnRhaW5pbmcgaXQgSSdtIGZp
bmUgd2l0aCB0aGF0IChldmVuIGlmDQo+ID4+PiB0aGUgY29yZSBjb2RlIG5lZWRzIHNvbWUgY2hh
bmdlcyB0aGVuIGxpa2UgaG9va3Mgb3Igc28sIG5vdCBzdXJlKS4NCj4gPj4NCj4gPj4gVGhhdCBk
aXNjdXNzaW9uIHN0YXJ0ZWQgd2l0aCBNaXF1ZWwgc29tZSB5ZWFycyBhZ28gd2hlbiBoZSB3YXMg
dHJ5aW5nDQo+ID4+IHRvIHRvIHNvbHZlIGRlc2NyaXB0aW9uIGluIERUIHdoaWNoIGlzIG1lcmdl
ZCBmb3IgYSB3aGlsZSBpbiB0aGUga2VybmVsLg0KPiA+DQo+ID4gV2hhdCdzIHlvdXIgcG9pbnQg
aGVyZT8gRnJvbSB3aGF0IEkgY2FuIHRlbGwgdGhlIERUIGJpbmRpbmcgaXMgd3JvbmcNCj4gPiBh
bmQgbmVlZHMgdG8gYmUgcmV3b3JrZWQgYW55d2F5Lg0KPiANCj4gPiBJIGFtIGp1c3Qgc2F5aW5n
IHRoYXQgdGhpcyBpcyBub3QgYW55IGFkaG9jIG5ldyBmZWF0dXJlIGJ1dA0KPiA+IGNvbmZpZ3Vy
YXRpb24gd2hpY2ggaGFzIGJlZW4gYWxyZWFkeSBkaXNjdXNzZWQgYW5kIHNvbWUgc3RlcHMgbWFk
ZS4gSWYNCj4gPiBEVCBiaW5kaW5nIGlzIHdyb25nIGl0IGNhbiBiZSBkZXByZWNhdGVkIGFuZCB1
c2UgbmV3IG9uZSBidXQgZm9yIHRoYXQgaXQNCj4gaGFzIGJlIGNsZWFyIHdoaWNoIHdheSB0byBn
by4NCj4gDQo+IA0KPiA+PiBBbmQgQW1pdCBpcyB0cnlpbmcgdG8gZmlndXJlIGl0IG91dCB3aGlj
aCB3YXkgdG8gZ28uDQo+ID4+IEkgZG9uJ3Qgd2FudCB0byBwcmVkaWN0IHdoZXJlIHRoYXQgY29k
ZSBzaG91bGQgYmUgZ29pbmcgb3IgaG93IGl0DQo+ID4+IHNob3VsZCBsb29rIGxpa2UgYmVjYXVz
ZSBkb24ndCBoYXZlIHNwaS1ub3IgZXhwZXJpZW5jZS4gQnV0IEkgaG9wZSB3ZQ0KPiA+PiBmaW5h
bGx5IG1vdmUgZm9yd2FyZCBvbiB0aGlzIHRvcGljIHRvIHNlZSB0aGUgcGF0aCBob3cgdG8gdXBz
dHJlYW0NCj4gc3VwcG9ydCBmb3IgaXQuDQo+ID4NCj4gPiBZb3Ugc3RpbGwgZGlkbid0IGFuc3dl
ciBteSBpbml0aWFsIHF1ZXN0aW9uLiBXaWxsIEFNRCBzdXBwb3J0IGFuZA0KPiA+IG1haW50YWlu
IHRoYXQgY29kZT8gSSB3YXMgcHVzaGluZyB5b3UgdG93YXJkcyBwdXR0aW5nIHRoYXQgY29kZSBp
bnRvDQo+ID4geW91ciBvd24gZHJpdmVyIGJlY2F1c2UgdGhlbiB0aGF0J3MgdXAgdG8geW91IHdo
YXQgeW91IGFyZSBkb2luZw0KPiA+IHRoZXJlLg0KPiANCj4gPiBPZiBjb3Vyc2UuIFdlIGNhcmUg
YWJvdXQgb3VyIGNvZGUgYW5kIGFib3V0IHN1cHBvcnRpbmcgb3VyIFNPQyBhbmQNCj4gPiBmZWF0
dXJlcyB3aGljaCBhcmUgcmVsYXRlZCB0byBpdC4gSXQgbWVhbnMgeWVzLCB3ZSB3aWxsIGJlIHJl
Z3VsYXJseQ0KPiA+IHRlc3RpbmcgaXQgYW5kIHRha2luZyBjYXJlIGFib3V0IGl0Lg0KPiANCj4g
DQo+ID4gU28gaG93IGRvIHdlIG1vdmUgZm9yd2FyZD8gSSdkIGxpa2UgdG8gc2VlIGFzIGxpdHRs
ZSBhcyBjb3JlIGNoYW5nZXMNCj4gPiBwb3NzaWJsZSB0byBnZXQgeW91ciBkdWFsIGZsYXNoIHNl
dHVwIHdvcmtpbmcuIEknbSBmaW5lIHdpdGggaGF2aW5nIGENCj4gPiBsYXllciBpbiBzcGktbm9y
LyAobm90IHN1cmUgdGhhdCdzIGhvdyBpdCB3aWxsIHdvcmsgd2l0aCBtdGRjYXQgd2hpY2gNCj4g
PiBsb29rcyBsaWtlIGl0J3Mgc2ltaWxhciBhcyB5b3VyIHN0YWNrZWQgZmxhc2gpIGFzIGxvbmcg
YXMgaXQgY2FuIGJlIGENCj4gPiBtb2R1bGUgKHNlbGVjdGVkIGJ5IHRoZSBkcml2ZXIpLg0KPiAN
Cj4gPiBvay4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gTmVhbCBGcmFnZXINCj4gQU1EDQo=

