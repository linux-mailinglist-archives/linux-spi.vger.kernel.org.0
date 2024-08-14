Return-Path: <linux-spi+bounces-4186-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC67951B34
	for <lists+linux-spi@lfdr.de>; Wed, 14 Aug 2024 14:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E641C2285F
	for <lists+linux-spi@lfdr.de>; Wed, 14 Aug 2024 12:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BC61B0133;
	Wed, 14 Aug 2024 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vCU2fUfa"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EA41B0128;
	Wed, 14 Aug 2024 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640034; cv=fail; b=Vjejbpx1FAO6ndu5shB5z6ABnpxwKxESgBBER5mJrsjwbTjbNMJYyzlUS4j5jKctiFdJQ7HSUPQ64XB642r6SCVUzRLK+yPVRVq5MBmAuumbcSJ9SGW+tDQEGPQBMeSaNbe8knzz6v0paPZXRGToNZAStg+/CQPVtshglp2cHuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640034; c=relaxed/simple;
	bh=qF5n6YeC5jiLoJVjNaBepC4OpZ6+TvSlZRR+7slqzlg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sQAlSWA7G/z4RuApC7SXNShCr5SpOAhZEEzImTP37zFvihUnu3LK/zTc1goFDqZ2RHVhs5PlDSqQtECIOT5tBpR6L9OMfE/loSTVXJ1Tvt8atQPwHeJMX6MFODm0FpOF7gBmXBNgQ3nQw9j1vLftQ6xYXFYIuzujJ4E8+KJTch8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vCU2fUfa; arc=fail smtp.client-ip=40.107.96.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flR4NbVqQuAOrgsX+pk3aSUZ5UnrVlCxn2sPMQVHui8oXT1o9WrBea4XEXAaLoyMweGrApEjpzSG+DPMQGRtJxOvEL+ao8OGVgV0tlpw1qsihya427oVsklXnU5XiRx9CoxwoGOf7h6/7OFdiW25/kbX96YvFjRI7ytpHKMoBT30WFuGMsQi1mY10LTjW2KTtEMxSmc0I7vi9INgulPosF9aiQGXJHVfN4RoTLOL3fynGZVwnTGslhiPePMgbWrevAe1uQl4L9/cWbEnqBkHSALZsTIouSwHsmthzQicL7JpBu6JVeus7+2mmcGQE3hiinzbH3NbykXSQ3DwTAxWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qF5n6YeC5jiLoJVjNaBepC4OpZ6+TvSlZRR+7slqzlg=;
 b=d4YuDP+MYQGGbHykrBpgrqcrWCV8dgfGvEp70YZBQLl24hcPB774hoiR/AF0SQtnqPHIMnrqr7YEWwLUivHGdjlrQXKYnX43CAQVDUob1SyewvUgG0hAzvboIdWa+tSlfDw4WKtcqAfb3N1PJAJobHDQt7sc00BJzMPZj3SaT5NIe83LTiTt44LGXlz4JN+8zJJHBzUXmkyegr8gwnxDR7Rppw3Q623umdY9AvcKh7ZWcLglLiGkYxOm+hJg7laiyl3Vo++wQ8aoL++Mz8DEPf0dfJgirnMS48gmDReYMVJP4On+dmWXGgDWXbau01Vpn+Fo2c0691+tc3T5pwUnlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qF5n6YeC5jiLoJVjNaBepC4OpZ6+TvSlZRR+7slqzlg=;
 b=vCU2fUfa444MjO3akhG/K8pRo2QPx5ep+hd9uMjzgq7nRyVYb0Rn+8Sm9ywBpTrsSmbCZiwnM0sV265mmsRMrs8exNjTNR2DXl9L9xP/tCxD8IEL65sOYdn0MOVWA+JRrkXHRbsAFRT84xBdB216q5ZmYJPfhZz+u37yCd+dcXM=
Received: from IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 by PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19; Wed, 14 Aug
 2024 12:53:49 +0000
Received: from IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa]) by IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa%2]) with mapi id 15.20.7849.023; Wed, 14 Aug 2024
 12:53:49 +0000
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
 AQHaH4D9pFM5xtDoeEuMNIpXuxvtzbCcYmwAgAEJ+aCABhoaAIAAMcLwgAAzdICAADdZAIABtmWAgAQ4ECCAAAuVAIAAD5dQgAAYdQCAAAF/8IAGJHEAgAFe7KCAUIcDAIAAVewAgDPXogCA08cW0IAaoUUAgAL7ppCAACtNgIAAD4YQ
Date: Wed, 14 Aug 2024 12:53:49 +0000
Message-ID:
 <IA0PR12MB7699670B7EE37C60C672FC5EDC872@IA0PR12MB7699.namprd12.prod.outlook.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
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
	<IA0PR12MB769997D5958C191215254983DC872@IA0PR12MB7699.namprd12.prod.outlook.com>
 <20240814104623.72eef495@xps-13>
In-Reply-To: <20240814104623.72eef495@xps-13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7699:EE_|PH8PR12MB7184:EE_
x-ms-office365-filtering-correlation-id: 671058d4-fa23-4117-20dd-08dcbc60247d
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K1YvTW5pMjBrUzlDdGhxNlRCejRwRVdXM09UakQ3UGVzTUpta2o0TUNDaysv?=
 =?utf-8?B?TmNVUXg3OVA1eUhmblNQZ1p6RVRseUk1bEtpOUpRM0NiRTJYbWJQOHh6dHRt?=
 =?utf-8?B?eENjVkF4R0N5R1pDK0tKSThzWjR6eUo3RGwyVEkyVXdRcDBlalFVcWgzTGll?=
 =?utf-8?B?bjVZN2hyUko0bXNheHl5aHZsWXZQRWVodm5YUVpVM0xIZHhZTzJQQWdJeGFF?=
 =?utf-8?B?V1dKRVA2R0ZGcHlIZTRFUWE1cWlKZ0pmQ3hOdWFIa0Z6dkhVRnpvZ1lVZ2Fn?=
 =?utf-8?B?cWRMZGFpcDJXSFE1QzJDNFVBYXIrWjhaM2ZRaHFvOVU3T1NXZ05LNW41OUFm?=
 =?utf-8?B?QVhKczkrYkVrZmp1RXZxRHcySTROQWRsZmZZSzAyVmVmeS9UZ2NIZ1pUSGZE?=
 =?utf-8?B?ZUdQTEdTVCtTODgwN2ZhWlhNclVna1ArUkUrMHhFSXZubjB1eG84UksxNTlm?=
 =?utf-8?B?TlZyU1lVV1FTcHhDK0FlbmFwbG9qb3NmWE1tbUdrd2xic1ZTei9uQTgzbnF3?=
 =?utf-8?B?c210am83ZDErMzFOTGtFVzFJR2REMnlNdUZkRWtTRHcrVW9leElCclhEY2Ja?=
 =?utf-8?B?RGFlYlB5b0RINHVHRThqd2tjTW5IaGdsM1pESGkvMFlwZ283dlpsWjFIbjYw?=
 =?utf-8?B?STBjZ2RWeHNoY1YrNnNpdytZNTJVZGFONmt5YSsrSVU5QUova3R3OElJeDZW?=
 =?utf-8?B?cVczQ09tem1WeDFyTGZNRkp3QWtwSlhPSnpVMCs5K2VjcVBBd09PZmZqc1Bj?=
 =?utf-8?B?OXZJSTFlNkRORTdVdGVMT1EzK2VhTEVZUzR0V210QlRXMnd3cmdDWnB3S1RL?=
 =?utf-8?B?NjVTamg3OU5sS1Y1ZUJHbDRJMHBrRjByYUkvYVNrK25EM2JwVWl0Qk9DVlFp?=
 =?utf-8?B?eXFNWUlVWWZkNlE5N2JjajhwY2tRR2ZXdFhkR2pBMUpLOHdCZ1dBMGpuNUdW?=
 =?utf-8?B?d2gzUDZvNE1tWW1LTnNjWWNxZmVubHNFcE1hb2ZaM1poL2dmcGQvM0ZURCtv?=
 =?utf-8?B?K3R1bklwSFhaTm16K1Mxd2xNYnpCelZIN2dMUm43NlRFUjBXcW9kMithb3JI?=
 =?utf-8?B?NkhBbTk5SWgrZXNLT00rNzk4R3BGd0pTRHZqajZsTTMwM01IdDZXbDVuNlBD?=
 =?utf-8?B?RjJRQjd1MlBPYUlPSEg2TUhGWVhVKzBuNloxMWhaMEtidnBvdEc5Ujd2OTd1?=
 =?utf-8?B?d0FnU3F2bWhwNy9ldmZkaDJ5MFJCdUVxM0c2Z25ZMDVRelZ2Ylh4WW9OWFFJ?=
 =?utf-8?B?a3ZSRWJ2RXBtYzJOUkxCeVpBcnYwR2tKT2ZvTkVjVzNOMG5YaXJHZFJUUU8v?=
 =?utf-8?B?SWMyKzB0NEZjbUlSVWdsV3BMakM0bmk5VFdmODNvRVZNZWNsMDN0eTRURmw3?=
 =?utf-8?B?RlBxY3ZCWWlDakp6MUhKTDRqN3ZyanRIWVhibVhKMk1GalIwTjhjYjRHdzhT?=
 =?utf-8?B?YXc2SEZZZWwxM0Y1OHloVUZqSWxBbFYwY05RODdUdHBRYXhKSHpFQzJ0MjBq?=
 =?utf-8?B?UG1xY2tNVXZpRmNRcnJTa2x4NWcvZ3YrN0RIM1BUYjcrK2U0azZkZm1RTmgx?=
 =?utf-8?B?eU9OckdrVmJyaE12a01lK2xkTHQxdDNnK2o0WHEzQXk3Rk1ubDY3L0dycmdI?=
 =?utf-8?B?eTA2OHRrMldHamN3RSsvZUJCT3Y3Qm55eURQRFE4WHZKMXNMYlc2R2NlZDNh?=
 =?utf-8?B?MzY4QXdxU1gxMHZSSEFNZ08zd05QRXY3WCtXZnppVkFTQXZiRDN1cnlZZ2tM?=
 =?utf-8?B?bGVhQTVKcEZkekNaTkxycnFIWUhYSUxvemQyRFU2enJ2UUcyS3l3dzYySGJF?=
 =?utf-8?B?eFptODA3YVR4SElTRnprNHJjRFE0NTVUUUpGUTVNTEhVeHVIdllET0RBeDZO?=
 =?utf-8?B?SjdVZktmaGVycmhQVnBKdjVnV2piMEhDVEd6a0pRRC9YK3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7699.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S29jWmkwaUNOZjNjSG52eGx5ZmRWYzZkZXpoOEdzS3RqUW9DSitudlpqSnF3?=
 =?utf-8?B?bWZLUzdBWTNYemhRdUpvZ2oyWU94TmgvWU5Cd3IzZ3BXV1RZVkZnTHpPREF0?=
 =?utf-8?B?aGE1QWtpVkExVmtyVWtsbDBuY003anJVMi9PcjNNSXV6bzlMdm1qV2t4UzlR?=
 =?utf-8?B?YmZ6QnpyM29hZGh5VDA4S0dzNVBEWWtkOVlzVkc0MHk3NW93WmdqTTRXblRZ?=
 =?utf-8?B?a2FncGw0ZnlYL3hjWVJ2dWxVRkxRQVZscmYyYzVPai9VY0ZsRFZ6UEVqekhp?=
 =?utf-8?B?SVRVOEtrbVdhQ3F0cHAzUzQ5SElTQ0Y3YTZpMDhSSUpqM0I4RSt0bk1HeGRw?=
 =?utf-8?B?VGYxd09hWlBET1A1bkg0K1RBb0JpNEZMZGROQ3hjL2F4eXJjNEJPOWtjVDZs?=
 =?utf-8?B?U2RDUDdQMW9aamJLcVQyWHRKR2p2VC9nMkR3QTRSWE5ITU96U1dDcG15R3NK?=
 =?utf-8?B?UkR3VUppdkxzSEpiZDM2cHhzSWNWZ3JUcDJ2QWd6ekxLRDJ1TkdtWkthMG9L?=
 =?utf-8?B?VSt5KzY3T2RNV3IyWUZOa0lySTZ1K0wvZ0ZTc1ZHdzVkOGZCTE81dzRCZ2xT?=
 =?utf-8?B?MngrY3Nna3BUdCtWTUlMSWNrbkdvNVRJZmthUm0xalFFYkU0QzE2dWhiK0d3?=
 =?utf-8?B?eWcwTER2WVBpVzk1SXBKN3cyYnRxOHFNSmN6L0d5dlFaSVY4T2pvRWZUeDI3?=
 =?utf-8?B?ZVkxSDNJcDhRTzFOWEoyZHVmanhUWVNnTncvSGdhQ2dZZGlGZXd4VWJHdXJp?=
 =?utf-8?B?VDk5Ky8wVTRyZ2ZGTzhvQTFEcUN1eFdZTzZRVTF2cmNMZldsejFBam5zcEtu?=
 =?utf-8?B?cmFUcE1rNjlnZkcyTW1wYlBaN0Jlcjdna1BpbW8yUFpsbjZyN2hGUDQ1RlRL?=
 =?utf-8?B?cWZyNGhiSDVsNmtmbXBWNUdYYnB0Uy84NUdqc0JCUm8zKzdHT0lpWVVJRjZk?=
 =?utf-8?B?TndGUTlwaHI2YnI0bHhzQVY1eWtFa1ZkTk9QN0JVM1U3T0FjSm5ZV1p3OTNZ?=
 =?utf-8?B?M1VyNTZMQzRqZVFOVnN6N2h5SEpBVWpVRWRxQ2VWeWVTMDNpa2dFK29XZ2h0?=
 =?utf-8?B?NGtORm1yVVhDWXZoWWdrSmIwMkNYMzUySW41cFNXdlNVMmQ0aTR4cUcyUFNH?=
 =?utf-8?B?SitoaUZNc05aRXJzUm5ZQlNGYTlJbUozNWtmciswcmkxc3l2OWhLMnN3REN6?=
 =?utf-8?B?MURiSUpWMzZmWDBIdjQ1UTlCU0ZLVXFibVg4OHhpbVV3cVdQRTdoZVdpeVVX?=
 =?utf-8?B?MzJzd0VBak9UcHZhT0V6SjkxMGRzajhiKzJ6V1hxeFhZUHZSSTJkT2VRSndF?=
 =?utf-8?B?SWwrTnpTR0h0d2VJaW9aZEM5RTVzVFF3dEg1K3RvTk9XR2ZMM1J0RkZXZ0hG?=
 =?utf-8?B?ZEdnQUI5R3VPRUV3dzdIQyswU09rWU41V1VNVGplTTVvZ0NVamdYRzZVcndn?=
 =?utf-8?B?TTdGb0FyelZoMWtDNk10SVRDQ3pBMUlqZFdPV2x4K2xqdHZ3Wm9wd3cwN1hh?=
 =?utf-8?B?K2VEaW5WTWxXK09ZaWhDZHl4azVCbGZKT1pab1Y5K0N5WDRDNElpemN2NFp6?=
 =?utf-8?B?K3VPOW93MnpNN1d4Y0lnUzVGWnZRYkRVWXdldkJaaHYzTDZpZGgwcWpzMFVl?=
 =?utf-8?B?bGZVSVlXQis1Q29TOW1Fclk4cW9DU05taSsrd01YeUI0cG5melNLZlhiSHpS?=
 =?utf-8?B?cFdIbXhpT3psbzdqV2REOG5rNUZoRFArVmJpVnFaSTN0Wmt1MHZZZEZVMTUw?=
 =?utf-8?B?eDUyZjFaZTdUZ0M2Vlp6Ym5qUkdTbnJab3pYRFVuSnRFNmpOa3JMbFd4djV6?=
 =?utf-8?B?bjJwMzhBaE04YUZpYUxJK2dxSTdWMlpJUm9MNUpaT2FSaUNCdXlBUE0rSzl2?=
 =?utf-8?B?dkZEQ3lDYnIyT2lvYlBiUmRzOGozRjZqRkNnVGpFNTg5bFg4bzByUnNZa1c4?=
 =?utf-8?B?SXFrR2o0bmxWekR6YjZmR3JXVGdMUFVTL3hwQjVhT1ZnazZFcC9BaVd1eG9l?=
 =?utf-8?B?QXVSSno3TWRONDdXRkN1cHcvS3NsNUZsT2gzelZFSE5XV1Q2eTRWYStER2NB?=
 =?utf-8?B?UzBvQ1habnRwNDVMVnRSQkNES0NaVTVnRTJoRkZSNlNFeXNOSTBVVkRhZkRh?=
 =?utf-8?Q?xNTM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 671058d4-fa23-4117-20dd-08dcbc60247d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 12:53:49.4218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fbiRFIPKol5ds3QoiRNxrrvX0K5x+frxK/KeJAnQIfUOhAsiYO5eMk69+1nejquNfJox8SXJHNbV31kN8dL9Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7184

SGVsbG8gTWlxdWVsLA0KDQo+IFRoYXQncyBub3Qgd2hhdCB3YXMgaW5pdGlhbGx5IGRpc2N1c3Nl
ZC4gVGhlIFhpbGlueCB1c2UgY2FzZSB3YXM6DQo+IGEgY29udHJvbGxlciBpcyBtYW5hZ2luZyB0
d28gZGV2aWNlcyAiYXQgdGhlIHNhbWUgdGltZSIgdHJhbnNwYXJlbnRseSBmcm9tDQoNClllcywg
YnV0IGluIHN0YWNrZWQgbW9kZSwgdGhlIGNvbnRyb2xsZXIgY29tbXVuaWNhdGVzIHdpdGggb25l
IG9mIHRoZSB0d28gDQpjb25uZWN0ZWQgZmxhc2ggZGV2aWNlcyBhdCBhbnkgZ2l2ZW4gdGltZSwg
YmFzZWQgb24gdGhlIGFkZHJlc3MgYW5kIGRhdGEgDQpsZW5ndGguIEl0IGRvZXNuJ3QgYXNzZXJ0
IGJvdGggY2hpcCBzZWxlY3RzIHNpbXVsdGFuZW91c2x5Lg0KDQo+IHRoZSBob3N0LiBTbyB0aGUg
dHdvIGZsYXNoZXMgYXBwZWFyIGxpa2UgYSBzaW5nbGUgb25lIGFuZCB0aHVzLCBhcmUgZGVzY3Jp
YmVkDQo+IGxpa2UgYSBzaW5nbGUgb25lLg0KPiANCj4gWW91IGRvbid0IG5lZWQgYW55dGhpbmcg
aW4gdGhlIGJpbmRpbmdzIG5vciBpbiB0aGUgY29yZSB0byBtYW5hZ2UgdHdvDQo+IGZsYXNoZXMg
Y29ubmVjdGVkIHRvIHRoZSBzYW1lIGNvbnRyb2xsZXIgb3RoZXJ3aXNlLiBUaGUgb25seSB1c2Ug
Y2FzZSB0aGUNCj4gWGlsaW54IG1vZGVsIHdhcyBicmluZ2luZywgd2FzIHRvIGNvbnNpZGVyIHRo
ZSBzdG9yYWdlIGJpZ2dlciBmcm9tIGEgaG9zdA0KPiBwZXJzcGVjdGl2ZSBhbmQgdGh1cyBiZSBh
YmxlIHRvIHN0b3JlIGZpbGVzIGFjcm9zcyB0aGUgZGV2aWNlIGJvdW5kYXJ5DQo+IG5hdGl2ZWx5
Lg0KDQpXaGVuIGFkZGluZyBzdGFja2VkIHN1cHBvcnQgdG8gdGhlIFNQSSBjb3JlLCBNYXJrIGFs
c28gYXNrZWQgdXMgdG8gc3VwcG9ydCANCnRoZSBHUElPIGNoaXAgc2VsZWN0IHVzZSBjYXNlLCBz
byBpdCBpcyBub3Qgb25seSByZXN0cmljdGVkIHRvIG5hdGl2ZSBjcy4NCg0KPiANCj4gPiBGb3Ig
cGFyYWxsZWwgY29uZmlndXJhdGlvbnMsIHRoZXJlIGFyZSBvdGhlciBjb250cm9sbGVycyBmcm9t
DQo+ID4gTWljcm9jaGlwIGFuZCBzb21lIGZsYXNoIGRldmljZXMgdGhhdCBvcGVyYXRlIHNpbWls
YXJseSB0byBBTUQncw0KPiA+IHBhcmFsbGVsIG1vZGUuDQo+IA0KPiBZZXMsIFR1ZG9yIHJlbWlu
ZGVkIG1lIGFib3V0IHRoZXNlLg0KPiANCj4gPiA+ID4gVGhpcyBsYXllciB3b3VsZCBwZXJmb3Jt
IHRoZSBmb2xsb3dpbmcgdGFza3M6DQo+ID4gPiA+ICAtIER1cmluZyBwcm9iaW5nLCBzdG9yZSBp
bmZvcm1hdGlvbiBmcm9tIGFsbCB0aGUgY29ubmVjdGVkIGZsYXNoZXMsDQo+ID4gPiA+ICAgIHdo
ZXRoZXIgaW4gc3RhY2tlZCBvciBwYXJhbGxlbCBtb2RlLCBhbmQgcHJlc2VudCBpdCBhcyBhIHNp
bmdsZSBkZXZpY2UNCj4gPiA+ID4gICAgdG8gdGhlIE1URCBsYXllci4NCj4gPiA+ID4gIC0gUmVn
aXN0ZXIgY2FsbGJhY2tzIHRocm91Z2ggdGhpcyBuZXcgbGF5ZXIgaW5zdGVhZCBvZiBzcGktbm9y
L2NvcmUuYyBhbmQNCj4gPiA+ID4gICAgaGFuZGxlIE1URCBkZXZpY2UgcmVnaXN0cmF0aW9uLg0K
PiA+ID4gPiAgLSBJbiBzdGFja2VkIG1vZGUsIHNlbGVjdCB0aGUgYXBwcm9wcmlhdGUgc3BpLW5v
ciBmbGFzaCBiYXNlZCBvbiB0aGUNCj4gPiA+ID4gICAgYWRkcmVzcyBwcm92aWRlZCBieSB0aGUg
TVREIGxheWVyIGR1cmluZyBmbGFzaCBvcGVyYXRpb25zLg0KPiA+ID4gPiAgLSBNYW5hZ2UgZmxh
c2ggY3Jvc3NvdmVyIG9wZXJhdGlvbnMgaW4gc3RhY2tlZCBtb2RlLg0KPiA+ID4gPiAgLSBFbnN1
cmUgYm90aCBjb25uZWN0ZWQgZmxhc2hlcyBhcmUgaWRlbnRpY2FsIGluIHBhcmFsbGVsIG1vZGUu
DQo+ID4gPiA+ICAtIEhhbmRsZSBvZGQgYnl0ZSBjb3VudCByZXF1ZXN0cyBmcm9tIHRoZSBNVEQg
bGF5ZXIgZHVyaW5nIGZsYXNoDQo+ID4gPiA+ICAgIG9wZXJhdGlvbnMgaW4gcGFyYWxsZWwgbW9k
ZS4NCj4gPiA+ID4NCj4gPiA+ID4gRm9yIGltcGxlbWVudGluZyB0aGlzIHRoZSBjdXJyZW50IERU
IGJpbmRpbmcgbmVlZCB0byBiZSB1cGRhdGVkIGFzDQo+ID4gPiA+IGZvbGxvd3MuDQo+ID4gPg0K
PiA+ID4gU28geW91IHdhbnQgdG8gZ28gYmFjayB0byBzdGVwIDEgYW5kIHJlZGVmaW5lIGJpbmRp
bmdzPyBJcyB0aGF0IHdvcnRoPw0KPiA+DQo+ID4gVGhlIGN1cnJlbnQgYmluZGluZ3MgYXJlIGVm
ZmVjdGl2ZSBpZiB3ZSBvbmx5IHN1cHBvcnQgaWRlbnRpY2FsIGZsYXNoDQo+ID4gZGV2aWNlcyBv
ciBmbGFzaGVzIG9mIHRoZSBzYW1lIG1ha2UgYnV0IHdpdGggZGlmZmVyZW50IHNpemVzIGNvbm5l
Y3RlZA0KPiA+IGluIHN0YWNrZWQgbW9kZS4gSG93ZXZlciwgaWYgd2Ugd2FudCB0byBleHRlbmQg
c3RhY2tlZCBzdXBwb3J0IHRvDQo+ID4gaW5jbHVkZSBmbGFzaGVzIG9mIGRpZmZlcmVudCBtYWtl
cyBpbiBzdGFja2VkIG1vZGUsDQo+IA0KPiBUaGUgb25seSBhY3R1YWwgZmVhdHVyZSB0aGUgc3Rh
Y2tlZCBtb2RlIGJyaW5ncyBpcyB0aGUgYWJpbGl0eSB0byBjb25zaWRlciB0d28NCj4gZGV2aWNl
cyBsaWtlIG9uZS4gVGhpcyBpcyBhYnN0cmFjdGVkIGJ5IGhhcmR3YXJlLCB0aGlzIGlzIGEgY29u
dHJvbGxlciBjYXBhYmlsaXR5Lg0KDQpTdGFja2VkIG1vZGUgaXMgYSBzb2Z0d2FyZSBhYnN0cmFj
dGlvbiByYXRoZXIgdGhhbiBhIGNvbnRyb2xsZXIgZmVhdHVyZSBvciANCmNhcGFiaWxpdHkuIEF0
IGFueSBnaXZlbiB0aW1lLCB0aGUgY29udHJvbGxlciBjb21tdW5pY2F0ZXMgd2l0aCBvbmUgb2Yg
dGhlIA0KdHdvIGNvbm5lY3RlZCBmbGFzaCBkZXZpY2VzLCBhcyBkZXRlcm1pbmVkIGJ5IHRoZSBy
ZXF1ZXN0ZWQgYWRkcmVzcyBhbmQgZGF0YSANCmxlbmd0aC4gSWYgYW4gb3BlcmF0aW9uIHN0YXJ0
cyBvbiBvbmUgZmxhc2ggYW5kIGVuZHMgb24gdGhlIG90aGVyLCB0aGUgY29yZSANCm5lZWRzIHRv
IHNwbGl0IGl0IGludG8gdHdvIHNlcGFyYXRlIG9wZXJhdGlvbnMgYW5kIGFkanVzdCB0aGUgZGF0
YSBsZW5ndGggDQphY2NvcmRpbmdseS4NCg0KPiBUaGUgb25seSB3YXkgdGhpcyBjYW4gd29yayBp
cyBpZiB0aGUgdHdvIHN0b3JhZ2UgZGV2aWNlcyBhcmUgb2YgdGhlIHNhbWUga2luZA0KPiBhbmQg
YWNjZXB0IHRoZSBzYW1lIGNvbW1hbmRzL2luaXQgY3ljbGVzLg0KPiANCj4gSWYgeW91IGNvbnNp
ZGVyIHR3byBkaWZmZXJlbnQgZGV2aWNlcywgdGhlbiB0aGVyZSBpcyBubyBoYXJkd2FyZSBhYnN0
cmFjdGlvbg0KPiBhbnltb3JlLCB0aGUgY29udHJvbGxlciBpcyBubyBsb25nZXIgInNtYXJ0IiBl
bm91Z2ggYW5kIHlvdSBhcmUgYmFjayB0byB0aGUNCj4gc3RhbmRhcmQgc2l0dWF0aW9uIHdpdGgg
dHdvIGRldmljZXMgY29ubmVjdGVkIHVzaW5nIHRoZWlyIG93biBpbmRlcGVuZGVudA0KPiBDUywg
a25vd24gYnkgdGhlIGhvc3QuIEluIHRoaXMgY2FzZSB0aGUgInN0YWNrZWQtbW9kZSIgYmluZGlu
Z3Mgbm8gbG9uZ2VyDQo+IGFwcGx5LiBZb3UgbmVlZCB0byBkZXNjcmliZSB0aGUgdHdvIGNoaXBz
IGluZGVwZW5kZW50bHkgaW4gdGhlIERULCBhbmQgeW91cg0KPiBzdGFja2VkIGZlYXR1cmUgaW4g
dGhlIGNvbnRyb2xsZXIgY2FuIG5vIGxvbmdlciBiZSB1c2VkLg0KDQpBcyBzdGF0ZWQgZWFybGll
ciBzdGFja2VkIGlzIG5vdCBhIGNvbnRyb2xsZXIgZmVhdHVyZSBidXQgcmF0aGVyIGEgc29mdHdh
cmUgDQphYnN0cmFjdGlvbiB0byBhc3NlcnQgdGhlIGFwcHJvcHJpYXRlIGNzIGFzIHBlciB0aGUg
cmVxdWVzdGVkIGFkZHJlc3MgJiBkYXRhIA0KbGVuZ3RoLg0KDQpSZWdhcmRzLA0KQW1pdA0KPiAN
Cj4gWW91IG5lZWQgb3RoZXIgYmluZGluZ3MgdG8gc3VwcG9ydCB0aGlzIGNhc2UgYmVjYXVzZSBp
dCBpcyBhIGRpZmZlcmVudA0KPiBzaXR1YXRpb24uIEZvciB0aGlzIGNhc2UsIHRoZXJlIHdhcyBh
IG10ZC1jb25jYXQgYXBwcm9hY2ggKHdoaWNoIHdhcyBuZXZlcg0KPiBtZXJnZWQpLiBCdXQgdGhp
cyBpcyByZWFsbHkgc29tZXRoaW5nIGRpZmZlcmVudCB0aGFuIHRoZSBzdGFja2VkIG1vZGUgaW4g
eW91cg0KPiBjb250cm9sbGVyIGJlY2F1c2UgdGhlcmUgaXMgbm8gc3BlY2lmaWMgaGFyZHdhcmUg
ZmVhdHVyZSBpbnZvbHZlZCwgaXQncyBqdXN0IHB1cmUNCj4gc29mdHdhcmUuDQo+IA0KPiA+IHRo
ZSBjdXJyZW50DQo+ID4gYmluZGluZ3MgbWF5IG5vdCBiZSBhZGVxdWF0ZS4gVGhhdCdzIHdoeSBJ
IHN1Z2dlc3RlZCB1cGRhdGluZyB0aGUNCj4gPiBiaW5kaW5ncyB0byBhY2NvbW1vZGF0ZSBhbGwg
cG9zc2libGUgc2NlbmFyaW8uDQo+ID4NCj4gPiA+DQo+ID4gPiA+IHN0YWNrZWQtbWVtb3JpZXMg
RFQgY2hhbmdlczoNCj4gPiA+ID4gIC0gRmxhc2ggc2l6ZSBpbmZvcm1hdGlvbiBjYW4gYmUgcmV0
cmlldmVkIGRpcmVjdGx5IGZyb20gdGhlIGZsYXNoLCBzbyBpdA0KPiA+ID4gPiAgICBoYXMgYmVl
biByZW1vdmVkIGZyb20gdGhlIERUIGJpbmRpbmcuDQo+ID4gPiA+ICAtIEVhY2ggc3RhY2tlZCBm
bGFzaCB3aWxsIGhhdmUgaXRzIG93biBmbGFzaCBub2RlLiBUaGlzIGFwcHJvYWNoIGFsbG93cw0K
PiA+ID4gPiAgICBmbGFzaGVzIG9mIGRpZmZlcmVudCBtYWtlcyBhbmQgc2l6ZXMgdG8gYmUgc3Rh
Y2tlZCB0b2dldGhlciwgYXMgZWFjaA0KPiA+ID4gPiAgICBmbGFzaCB3aWxsIGJlIHByb2JlZCBp
bmRpdmlkdWFsbHkuDQo+ID4gPg0KPiA+ID4gQW5kIGhvdyB3aWxsIHlvdSBkZWZpbmUgcGFydGl0
aW9ucyBjcm9zc2luZyBkZXZpY2UgYm91bmRhcmllcz8gSQ0KPiA+ID4gYmVsaWV2ZSB0aGlzIGNv
bnN0cmFpbnQgaGFzIGJlZW4gdG90YWxseSBmb3Jnb3R0ZW4gaW4gdGhpcyBwcm9wb3NhbC4NCj4g
Pg0KPiA+IEFjY29yZGluZyB0byB0aGUgbmV3IGJpbmRpbmcgcHJvcG9zYWwsIG9uZSBvZiB0aGUg
dHdvIGZsYXNoIG5vZGVzIHdpbGwNCj4gPiBoYXZlIGEgcGFydGl0aW9uIHRoYXQgY3Jvc3NlcyB0
aGUgZGV2aWNlIGJvdW5kYXJ5Lg0KPiANCj4gRnJvbSBhIGJpbmRpbmdzIHBlcnNwZWN0aXZlLCBp
dCBmZWVscyB2ZXJ5IGF3a3dhcmQgYW5kIEkgZG91YnQgaXQgd2lsbCBiZQ0KPiBhY2NlcHRlZC4g
RnJvbSBhIGNvZGUgcGVyc3BlY3RpdmUsIHlvdSdyZSBnb25uYSBuZWVkIHRvIGJ1dGNoZXIgdGhl
IGNvcmUuLi4NCj4gDQo+ID4gPiBUaGUgd2hvbGUgaWRlYSBvZiBzdGFja2luZyB0d28gZGV2aWNl
cyB0aGlzIHdheSB3YXMgdG8gc2ltcGxpZnkgdGhlDQo+ID4gPiB1c2VyJ3MgbGlmZSB3aXRoIGEg
c2luZ2xlIGRldmljZSBleHBvc2VkIGFuZCB0aGUgY29udHJvbGxlciBoYW5kbGluZyBpdHNlbGYN
Cj4gdGhlIENTIGNoYW5nZXMuDQo+ID4gPiBUaGF0IGlzIHByZWNpc2VseSB3aGF0IHRoZSBjdXJy
ZW50IGJpbmRpbmcgZG8uDQo+ID4NCj4gPiBUaGF0J3MgdHJ1ZSwgYnV0IGFzIEkgbWVudGlvbmVk
IGVhcmxpZXIsIGlmIHdlJ3JlIG5vdCBpbmNsaW5lZCB0bw0KPiA+IHN1cHBvcnQgc3RhY2tlZCBt
b2RlIGZvciBmbGFzaGVzIG9mIGRpZmZlcmVudCBtYWtlcywgdGhlbiB0aGUgY3VycmVudA0KPiA+
IGJpbmRpbmdzIGFyZSBzdWZmaWNpZW50Lg0KPiANCj4gVGhhbmtzLA0KPiBNaXF1w6hsDQo=

