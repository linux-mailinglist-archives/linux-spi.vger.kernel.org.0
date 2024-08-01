Return-Path: <linux-spi+bounces-4117-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1798944494
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2024 08:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE3F1F2557F
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2024 06:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91A0157A55;
	Thu,  1 Aug 2024 06:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4z1X+6zC"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D7213DDD3;
	Thu,  1 Aug 2024 06:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722494247; cv=fail; b=AVNTcCjrXkll+ItjstMUDaTnryhX66JU/iq8KQWXzHSBd6Gyn16KmSgJ4iVys6u+P7VLHS8fJZ8I2HhbYkhTYl8xMZmCJdUH7YoEicD7vvyK4c7THDsKQOM0vHmkYo41f1P1hn1c7GeSQy1/CCwgH7RuXup1J98I8Rvu6UFNT+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722494247; c=relaxed/simple;
	bh=l9F9UYzCTtG5EX5AieUq0hJRAmiLRG9x9ngo5NRePfw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DP+fQOb7XgKPCbj6Ojd+PRxcZWmGVmxmtjjVNJdnwaIhQrs+BAA2WeX3Fscq57YAmxvwoXlDSc9XivgKWK8V+gjxZ91wOQxYejICHo1CiHIUmswCOtsE8jnn4raHr3+FFPs8Wmb/9jdAj9dNMSBaFzTKPFew0fdYphIo4eSZLR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4z1X+6zC; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTe4qUAf5qiIBL09BcewcbpzQDMtUaK89NFesB7TaB7HlMfc0RDUdhcZeIrEvSkslzpl/HKaoTqIH2Q1B+i9W938FBlJTbgeNf0NpED3eHxgbgYCAbq7vns2HB95VL9B/w+k5iGirVhjZ3tc+LmDT5PjCXECkFDU++nGuIDy7x8242cjuciA9MJBWeDeDLbAtiJOWafly6wbsH7Xu/4bZOxbgQgS/bmuqUG0EStO9DRAWVugHsQasLIuhjddsEx1Q/KcmHSqrLkQPjDZZ3xU2sbha7/YNVQVopEOe5w855oAXxQZl8LMtp1fCOpc/DKrXhzHTOvxUAeNZZkClxEsZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9F9UYzCTtG5EX5AieUq0hJRAmiLRG9x9ngo5NRePfw=;
 b=coHT3JIUcSxEMhP9CPUtUFaPO66y9p2QkuERVpGYI8UHimd7zW8w231Qpw5JQnzYvT9cS6RrIsUDOaNObR8EgYkUe2S6HgcMTZOaiEgP+8kh16qPZfetYAglcpL0cffj0JDbjzee3ZYRPreZ5aCiGUBCZip3g9+cK6oIBrVGyCMlH2EZ8sBOanD5607qXdxpBvAs9ghqibmT77Y2P2XYN1TvKrzU3F0ae49GxcThH0XK6ZUTo45JxR0XBWrXU4niQdO4wWLDWhB0jpAkCrhN7AmDQqSifv4uCUyr/llNnOu3wFOONkg0rat0cUXmVcdPozdjlytDAR5tv67oxn35FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9F9UYzCTtG5EX5AieUq0hJRAmiLRG9x9ngo5NRePfw=;
 b=4z1X+6zChqk8m74uTIe8ui0agi5PmuhRdhI1TsVZF7+qOfIzrQlzuW2MF2Ajp3nN7XBbJg/9TliRY2jYemw5G/3S1HDKz5obNJGKKUnHZ/CEzDS0rcZDoNjRR2vDczM7bDflcfoC8rRNMVY3p5SWpLWCBWaz5HvFUYIbnfbb5D0=
Received: from CH2PR12MB5004.namprd12.prod.outlook.com (2603:10b6:610:62::16)
 by SN7PR12MB7024.namprd12.prod.outlook.com (2603:10b6:806:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 06:37:22 +0000
Received: from CH2PR12MB5004.namprd12.prod.outlook.com
 ([fe80::e6c1:191b:641d:4d1b]) by CH2PR12MB5004.namprd12.prod.outlook.com
 ([fe80::e6c1:191b:641d:4d1b%5]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 06:37:22 +0000
From: "Frager, Neal" <neal.frager@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, Michael Walle <michael@walle.cc>,
	"Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>, Tudor Ambarus
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
Thread-Index: AQHa4yfe/U7Ow8+2J0mIWqJxfdRalrIQjwyAgABRsUmAAQ8wgIAAAQbw
Date: Thu, 1 Aug 2024 06:37:22 +0000
Message-ID:
 <CH2PR12MB50044242FE253D7B0E3425ABF0B22@CH2PR12MB5004.namprd12.prod.outlook.com>
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
In-Reply-To: <c01d048f-ad8b-417e-8ff0-96f9252c87f2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB5004:EE_|SN7PR12MB7024:EE_
x-ms-office365-filtering-correlation-id: 2282c68a-7317-45a3-c1a2-08dcb1f46620
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TXBXRUliOUsvUnlEUGJRdXVmWWtuYStDbkUwVXFsTmYxbW9zS1Z4SVpSOXJl?=
 =?utf-8?B?aTlTTVJQTVp5N3E5RHRRZmNtQU5NenlHSXBVQWdZYTRTZW9TYTA5dDNqc1ZD?=
 =?utf-8?B?d01ZQ0tzb2U2YytUTWo3ZXZ3QldTT1RaS0tKK3NsQUxJamxCOE90VkNidUFt?=
 =?utf-8?B?RUFZRkxhT3ZFRGtDS3V0TTVqcTZBWENFYjdxTElnWkZoazdJS21IcC8yM0pk?=
 =?utf-8?B?eWJmZDY0SmVjMHpSem0wSFNvZFYrbW90aEEyQ3VtbGhmQmVKQkJ6UHE4cFpp?=
 =?utf-8?B?cjVnOUx4VE05YVJmekM3UHA2RlRGWTVPeHBYemNIOEFueGRpclgxYjFJQVpv?=
 =?utf-8?B?K1ltYzc4dUpXdlVyZFBzZkpjVG1lZlJQZmJQY3ZxQUl3Uk9zUGIzTTlRMXI3?=
 =?utf-8?B?Q05HQWFuT0NYR3JEZTFiU2laMjBQMzBuOVY3NXlSVUV5WkNiMWdhSkNuOVAx?=
 =?utf-8?B?RzR0elIwYkdwaFpJamdGdDJWWXZva0ROUXpXNTFtTmdrRWdxNURLbzBmaVlt?=
 =?utf-8?B?NXVqSlBmM2l5VmdvMFFudElhMHRXN1FEZWtWSGtKK21WZ2d2Z3QyTVdwWkIw?=
 =?utf-8?B?YUN2cS9EOWo4Um01VytialdoVE9LQm5IR3l6ZzljWDgzSzBlVDVIMHhDcjhu?=
 =?utf-8?B?RGYyRXN4L0hlZnpPRWFIS2c1anU2R3RIR3Z6RFIvek40c3luSG9qVkw1Ynpo?=
 =?utf-8?B?UE5DNnlOSlVUeWhxZEVZQ1VrR1hIemluU0ptSnBLcjQ5cUdsSWlrMi9SQ1py?=
 =?utf-8?B?VGdJR2FmcWdGVWZ0cUtuYXVnWHk1dmQ3SHFSd2ZORFJnVGQ3eVpIZGxxQTFE?=
 =?utf-8?B?bGRTbHhZTDZ2MlM4akpGN2xUeWNkUXVqMHFVd0luVTAyZStrUitZU1poVHRi?=
 =?utf-8?B?eU5XTE1mcFpKUHdWd3dmQTRmTE1CL2RVRmlmdllxVXA4RTBWUXNvRnpUNE5S?=
 =?utf-8?B?Zitlb3YxNWYzOXE5N01EWTk4eGdWQW1vQUNibm5wZFVlK1FkSUliaGppRUxs?=
 =?utf-8?B?L1J3OUZHVnYxQTFYdHYxL1k3Z3NEbmhOTjA5RzdGUWU5QWxCeG9hdkE0a1Ba?=
 =?utf-8?B?eW9McTIvZmU0c2J5T2lpbWc4aUdNcHJoRDhTNnBIaU1vam9ocEdvZ3FPRC9s?=
 =?utf-8?B?YXgwWC9wb3JBeERxNjdxUFl4eE9zcmc1NWh4SW5Db3RaZ3ZOZkMwSk1TYkd3?=
 =?utf-8?B?dDhvbE4wSyt1R1ErakhLcEY4RUlvN1JmOE9oSkFjQis0TWhUYzVDejdEQlRz?=
 =?utf-8?B?YzRLM1NxYzZLL2x1cEo0cXk2U1pmTWRtUTh0MWVvTG1UeDBVdjNEOGVqam9C?=
 =?utf-8?B?L21VM1FCbExGS3g5M1ZzbTJvRFh0cjNsUzI3RTZpVDRYTkVTZk5rcm5BSU1m?=
 =?utf-8?B?WWwxYjFsa0NZb0UwYkFVK3FEbU5mR3JwdExoUjhkcHRWa2ZlOG16dy9jUUt2?=
 =?utf-8?B?UXNxbGRvdFVhQUtjRVhyMGYxV0Y5eGxHTG4ydGpYRjBENE0wakMvWkw3UGtI?=
 =?utf-8?B?Y29oUGJNQ2thT0IrSEFTUHRBQTJHK2t4WlhpcUNGTnl1NllmaVl6RnZwc1Nx?=
 =?utf-8?B?bGRjZnNhWVkwUHI5WVJnRmcwZldCbHRqZ2QzWTdwWHptM3pucURtVzFQaU9Z?=
 =?utf-8?B?Q0FpWXdseDhKbCthbXBjMjhBTTBLdmFrQzR6RGM0UFI5ZGJpbzJiZEdLYjJ3?=
 =?utf-8?B?NVJIWW9LbXo5OGh4WFNIUkw3QjNUMnB2b3B1MytsZ0RNVW10M2E5TGliVmJF?=
 =?utf-8?B?YngxZDZCNDRVTUNzN2NwcFlxMnRQYllrWUdwbk5Ob3ArazhXc0t0d3N6MHNx?=
 =?utf-8?B?ek9LeTVDMXVCb2kzcFF3OVpCSnVuYy92MjZwQjI3Sk9iR25NUkg0cTNxeXVr?=
 =?utf-8?B?WVpTOGNQUnEwRzUrZXpzclVXbWp3NHk2TUk5S01mZVRaTXJkNFhpNlIwQ0Uv?=
 =?utf-8?Q?WRKeZIiksjw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB5004.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEQ2STd3czFORU50YWVSL01uU000NVNVaDg0VGJVc1ZWTHZKcVVSeStCcFRv?=
 =?utf-8?B?c2JiYkJWVTNCUUJ4d21ZTlBLUHR4eTNKYmRCNEt6Qm94SEhlTDRDWU9DUi9P?=
 =?utf-8?B?MFFPdUlsUkRXOW9nNWNmNTlFWjVYL2EwQmJxUkdJekRvQ3N2eUxDV0NLOWpk?=
 =?utf-8?B?Rm4zdThWRyt0ZlZwUmxTdEpDcklQUUlibmpVTW1vT1JFKzNjSkNlS2FtK3Ju?=
 =?utf-8?B?a1JrZ0tIc2krcFQyWXY1SjJYTjRoN3dsSW5FdUFGUHZFNGNHZ0hNSTRlalE4?=
 =?utf-8?B?eERUa3RJOUh0UWZFR2orYjJBTm9PbnFYbGFlRmFyN2dWSnR1bCtzZzc5bk83?=
 =?utf-8?B?bG1mVzZBUHJhLy95Y1UzSnFoTks2WE94T050Uy9EelVPUXk3aW9lODl1SlZr?=
 =?utf-8?B?aGxWNDRaTnIwWE44NGZuYnYyM3dzSUw2Q3Z5QWl5RkRyZE1qb2VDaWx2MHNo?=
 =?utf-8?B?T0VkbXB6T1JmbnVEbS9CYXdlc1F4cEdYNXAzWFlwWWd2VVo0Ym9Ua3hTak82?=
 =?utf-8?B?QmVaZjJPUTFwejR6R1FESFR3bWRPNTR4endlOW16TWVqKzlNaVBqa2pHd1RC?=
 =?utf-8?B?U3Zudm5iY0QyRExvNCtQN3dEcmVZeURmSWJmYk1CWTBVU0FHRU95aGxaUTcx?=
 =?utf-8?B?dWN6WXpPSGErUmsvNUp6Qkg5Zmh1cFZzeGtxcExvRVhyYk16SHl3a1dLeWd3?=
 =?utf-8?B?TDd2aHNCcjhLdTlObGZEQm9JeXlIZzd3QXhFNWxXYlN4U0ZpUXZBellGU2Q0?=
 =?utf-8?B?MytiT0c5SWVDeFk2WDJvTERKVTZDcEJudlpSbFU4SHBCRWtpZnZCV1ZuN3Mx?=
 =?utf-8?B?WkpqZDNGVXdVcHEwdC9kL1lGNDZ5dllHOUhxdTY1ZkhqV1B0c1Z0a0lHUUc4?=
 =?utf-8?B?NWhpV1ZhdTdtQmpoMVRkQzFFQmswS2h2TUwwT2pJVDl0M0dwZkhidm5pSUN2?=
 =?utf-8?B?NjhsZmZVRGl4NEV2dTMxK0RNelh6UENBdEx1L2h0TXZPR0pVUzhRRTlZMGov?=
 =?utf-8?B?NE51UDdnVVlTSmlubDZxL3VrTWdDZWVubnZwM0l5cVNvZytTTEV4dzQ0dGV0?=
 =?utf-8?B?SjkwWk9hellYNDZaTVE1aGovREFrQVdLY3ZJakNBWHQyT2J0eWwwcFpnQXNl?=
 =?utf-8?B?UVJjV1IxYys0UnJOQnJEZlBJbFcxcUxRYU1Mb29hUmdLWnhkY3pQcHhZb1l0?=
 =?utf-8?B?SitUbUhMUHVpOWh0UEM0RWlJWTRzSWNzd3llUzQwYlc5aGhSWDA1V2Y5a3Fj?=
 =?utf-8?B?ZWl1Ujl1R1d4ejQ4bHh5c2ViYWVuSU5pWktkT0VHNHQzWmtDNVNjWGxWOFZs?=
 =?utf-8?B?TmlHR1ZpMVRmN3NhM21OeUVzaHczdFlwakVnTUs5N0FUZkZaeCtVMVhjYzdH?=
 =?utf-8?B?TS82OXZDdHVER3FYVU1QcUR0WkIvMzk1dUhmQStrY1VQMnZDSGgwTmt5VER2?=
 =?utf-8?B?czF5Q2ZMUCtwUmk3NHpBa0JhZWZTMUh5T1l2cEUwRzdoTG01ellFaXltVFZ5?=
 =?utf-8?B?ZXcreVVrOEJLZmNKazB6N2lNZlV6cUR0dEl3WkZlV3A3bHd6WUYwMDN6b2xo?=
 =?utf-8?B?cG9kdENXN0J1NURLampqdldoR2FRZXFTYXNuVE1jT3FPbUg1Qm5aWk9pakdX?=
 =?utf-8?B?eW0xdzNEZk1YNnVVcm9GRC9uZUpSYzVZeE5tRStieDhPOFNUOHdBZ2l4NSto?=
 =?utf-8?B?bVpTaXNvQ3ArQU9hZEdsNDFDYm9NZEIwNVNPeW43bStNS3BQYWNSclpvNTZh?=
 =?utf-8?B?V0owcXZLUFFiaHYxM0N3ZFZFZUNkZitGZFhVaVVoUjQ1cWZ3UTM4b2RHQWF1?=
 =?utf-8?B?eml1OTBIQ0lnYmlCYjhhV2paUDBhdVhaZ2M5aHdlZnBOdkNFRFR0cnZCWlJp?=
 =?utf-8?B?TlBKY2NMNnZFQklhWE15U2hHWVhCMHpWVGRBVFNoTzg0VHZ2WmtFRmN6dWtu?=
 =?utf-8?B?aWprQk4xVk9XYVIwZE5iTEs4cFJYYkZmLyswZUk0TElLSzErT2twTnk2S0Zh?=
 =?utf-8?B?Uy92RzQ4T0piUjlzVTAyZEgvVWVqcS9ZaUJIMExyZm1RSlhCMEkyR2NjL09m?=
 =?utf-8?B?bmVreWx5ZkJwbFJWV0VRbU10TnBrSCszTnRXMjF6MVcvWnU2Y2gvSFNXeGpn?=
 =?utf-8?Q?OsDA=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5004.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2282c68a-7317-45a3-c1a2-08dcb1f46620
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 06:37:22.2754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dB5oC58sMO1Xy1kg6kbsLSCltt27rRaqpaFOPE/Vt5Jh2UENhPx/OeCaNs97L4RU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7024

SGkgTWljaGFlbCwNCg0KPj4+IEFsbCBJJ20gc2F5aW5nIGlzIHRoYXQgeW91IHNob3VsZG4ndCBw
dXQgYnVyZGVuIG9uIHVzICh0aGUgU1BJIE5PUg0KPj4+IG1haW50YWluZXJzKSBmb3Igd2hhdCBz
ZWVtcyB0byBtZSBhdCBsZWFzdCBhcyBhIG5pY2hlLiBUaHVzIEkgd2FzDQo+Pj4gYXNraW5nIGZv
ciBwZXJmb3JtYW5jZSBudW1iZXJzIGFuZCB1c2Vycy4gQ29udmluY2UgbWUgdGhhdCBJJ20NCj4+
PiB3cm9uZyBhbmQgdGhhdCBpcyB3b3J0aCBvdXIgdGltZS4NCj4+DQo+PiBOby4gSXQgaXMgbm90
IHJlYWxseSBqdXN0IGZlYXR1cmUgb2Ygb3VyIGV2YWx1YXRpb24gYm9hcmRzLiBDdXN0b21lcnMg
YXJlIHVzaW5nDQo+PiBpdC4gSSB3YXMgdGFsa2luZyB0byBvbmUgZ3V5IGZyb20gZmllbGQgYW5k
IGhlIGNvbmZpcm1zIG1lIHRoYXQgdGhlc2UNCj4+IGNvbmZpZ3VyYXRpb25zIGFyZSB1c2VkIGJ5
IGhpcyBtdWx0aXBsZSBjdXN0b21lcnMgaW4gcmVhbCBwcm9kdWN0cy4NCj4gDQo+IFdoaWNoIGJl
Z3MgdGhlIHF1ZXN0aW9uLCBkbyB3ZSByZWFsbHkgaGF2ZSB0byBzdXBwb3J0IGV2ZXJ5IGZlYXR1
cmUNCj4gaW4gdGhlIGNvcmUgKEknZCBsaWtlIHRvIGhlYXIgVHVkb3JzIGFuZCBQcmF0eXVzaCBv
cGluaW9uIGhlcmUpLg0KPiBIb25lc3RseSwgdGhpcyBqdXN0IGxvb2tzIGxpa2UgYSBjb25jYXRl
bmF0aW9uIG9mIHR3byBRU1BJDQo+IGNvbnRyb2xsZXJzLiANCg0KPiBCYXNlZCBvbiBteSB1bmRl
cnN0YW5kaW5nIGZvciBzdGFja2VkIHllcy4gRm9yIHBhcmFsbGVsIG5vLg0KDQo+IFdoeSBkaWRu
J3QgeW91IGp1c3QgdXNlIGEgbm9ybWFsIG9jdGFsIGNvbnRyb2xsZXIgd2hpY2gNCj4gaXMgYSBw
cm90b2NvbCBhbHNvIGJhY2tlZCBieSB0aGUgSkVERUMgc3RhbmRhcmQuIA0KDQo+IE9uIG5ld2Vy
IFNPQyBvY3RhbCBJUCBjb3JlIGlzIHVzZWQuDQo+IEFtaXQgcGxlYXNlIGNvbW1lbnQuDQoNCj4g
SXMgaXQgYW55IGZhc3Rlcj8NCg0KPiBBbWl0OiBwbGVhc2UgcHJvdmlkZSBudW1iZXJzLg0KDQo+
IERvIHlvdSBnZXQgbW9yZSBjYXBhY2l0eT8gRG9lcyBhbnlvbmUgcmVhbGx5IHVzZSBsYXJnZSBT
UEktTk9SDQo+IGZsYXNoZXM/IElmIHNvLCB3aHk/DQoNCj4gWW91IGdldCB0d2ljZSBtb3JlIGNh
cGFjaXR5IGJhc2VkIG9uIHRoYXQgY29uZmlndXJhdGlvbi4gSSBjYW4ndCBhbnN3ZXIgdGhlIA0K
PiBzZWNvbmQgcXVlc3Rpb24gYmVjYXVzZSBub3Qgd29ya2luZyB3aXRoIGZpZWxkLiBCdXQgYm90
aCBvZiB0aGF0IGNvbmZpZ3VyYXRpb25zIA0KPiBhcmUgdXNlZCBieSBjdXN0b21lcnMuIEFkZGlu
ZyBOZWFsIGlmIGhlIHdhbnRzIHRvIGFkZCBzb21ldGhpbmcgbW9yZSB0byBpdC4NCg0KSnVzdCB0
byBhZGQgYSBjb21tZW50IGFzIEkgd29yayBkaXJlY3RseSB3aXRoIG91ciBjdXN0b21lcnMuICBU
aGUgbWFpbiByZWFzb24NCnRoaXMgc3VwcG9ydCBpcyBpbXBvcnRhbnQgaXMgZm9yIG91ciBvbGRl
ciBTb0NzLCB6eW5xIGFuZCB6eW5xbXAuDQoNCk1vc3Qgb2Ygb3VyIGN1c3RvbWVycyBhcmUgdXNp
bmcgUVNQSSBmbGFzaCBhcyB0aGUgZmlyc3QgYm9vdCBtZW1vcnkgdG8gZ2V0DQpmcm9tIHRoZSBi
b290IFJPTSB0byB1LWJvb3QuICBUaGV5IHRoZW4gdHlwaWNhbGx5IHVzZSBvdGhlciBtZW1vcmll
cywgc3VjaCBhcw0KZU1NQyBmb3IgdGhlIExpbnV4IGtlcm5lbCwgT1MgYW5kIGZpbGUgc3lzdGVt
Lg0KDQpUaGUgaXNzdWUgd2UgaGF2ZSBvbiB0aGUgenlucSBhbmQgenlucW1wIFNvQ3MgaXMgdGhh
dCB0aGUgYm9vdCBST00gKGNvZGUgdGhhdA0KY2Fubm90IGJlIGNoYW5nZWQpIHdpbGwgbm90IGJv
b3QgZnJvbSBhbiBPU1BJIGZsYXNoLiAgSXQgd2lsbCBvbmx5IGJvb3QgZnJvbSBhDQpRU1BJIGZs
YXNoLiAgVGhpcyBpcyB3aGF0IGlzIGZvcmNpbmcgbWFueSBvZiBvdXIgY3VzdG9tZXJzIGRvd24g
dGhlIFFTUEkgcGF0aC4NClNpbmNlIG1hbnkgb2YgdGhlc2UgY3VzdG9tZXJzIGFyZSBpbnRlcmVz
dGVkIGluIGFkZGl0aW9uYWwgc3BlZWQgYW5kIG1lbW9yeQ0Kc2l6ZSwgdGhleSB0aGVuIGVuZCB1
cCB1c2luZyBhIHBhcmFsbGVsIG9yIHN0YWNrZWQgY29uZmlndXJhdGlvbiBiZWNhdXNlIHRoZXkN
CmNhbm5vdCB1c2UgYW4gT1NQSSB3aXRoIHp5bnEgb3IgenlucW1wLg0KDQpBbGwgb2Ygb3VyIG5l
d2VyIFNvQ3MgY2FuIGJvb3QgZnJvbSBPU1BJLiAgSSBhZ3JlZSB3aXRoIHlvdSB0aGF0IGlmIHNv
bWVvbmUNCmNvdWxkIGNob29zZSBPU1BJIGZvciBwZXJmb3JtYW5jZSwgdGhleSB3b3VsZCwgc28g
SSBkbyBub3QgZXhwZWN0IHBhcmFsbGVsIG9yDQpzdGFja2VkIGNvbmZpZ3VyYXRpb25zIHdpdGgg
b3VyIG5ld2VyIFNvQ3MuDQoNCkkgZ2V0IHdoeSB5b3Ugc2VlIHRoaXMgY29uZmlndXJhdGlvbiBh
cyBhIG5pY2hlLCBidXQgZm9yIHVzLCBpdCBpcyBhIHZlcnkNCmxhcmdlIG5pY2hlIGJlY2F1c2Ug
enlucSBhbmQgenlucW1wIGFyZSB0d28gb2Ygb3VyIG1vc3Qgc3VjY2Vzc2Z1bCBTb0MNCmZhbWls
aWVzLg0KDQo+IEkgbWVhbiB5b3UndmUgcHV0IHRoYXQgY29udHJvbGxlciBvbiB5b3VyIFNvQywN
Cj4geW91IG11c3QgaGF2ZSBzb21lIGNvbnZpbmNpbmcgYXJndW1lbnRzIHdoeSBhIGN1c3RvbWVy
IHNob3VsZCB1c2UNCj4gaXQuDQoNCj4gSSBleHBlY3QgcmVjb21tZW5kYXRpb24gaXMgdG8gdXNl
IHNpbmdsZSBjb25maWd1cmF0aW9uIGJ1dCBpZiB5b3UgbmVlZCBiaWdnZXIgDQo+IHNwYWNlIGZv
ciB5b3VyIGFwcGxpY2F0aW9uIHRoZSBvbmx5IHdheSB0byBleHRlbmQgaXQgaXMgdG8gdXNlIHN0
YWNrZWQgDQo+IGNvbmZpZ3VyYXRpb24gd2l0aCB0d28gdGhlIHNhbWUgZmxhc2hlcyBuZXh0IHRv
IGVhY2ggb3RoZXIuDQo+IElmIHlvdSB3YW50IHRvIGhhdmUgYmlnZ2VyIHNpemUgYW5kIGFsc28g
YmUgZmFzdGVyIGFuc3dlciBpcyBwYXJhbGxlbCANCj4gY29uZmlndXJhdGlvbi4NCg0KDQo+Pj4g
VGhlIGZpcnN0IHJvdW5kIG9mIHBhdGNoZXMgd2VyZSByZWFsbHkgaW52YXNpdmUgcmVnYXJkaW5n
IHRoZSBjb3JlDQo+Pj4gY29kZS4gU28gaWYgdGhlcmUgaXMgYSBjbGVhbiBsYXllcmluZyBhcHBy
b2FjaCB3aGljaCBjYW4gYmUgZW5hYmxlZA0KPj4+IGFzIGEgbW9kdWxlIGFuZCB5b3UgYXJlIG1h
aW50YWluaW5nIGl0IEknbSBmaW5lIHdpdGggdGhhdCAoZXZlbiBpZg0KPj4+IHRoZSBjb3JlIGNv
ZGUgbmVlZHMgc29tZSBjaGFuZ2VzIHRoZW4gbGlrZSBob29rcyBvciBzbywgbm90IHN1cmUpLg0K
Pj4NCj4+IFRoYXQgZGlzY3Vzc2lvbiBzdGFydGVkIHdpdGggTWlxdWVsIHNvbWUgeWVhcnMgYWdv
IHdoZW4gaGUgd2FzIHRyeWluZyB0byB0bw0KPj4gc29sdmUgZGVzY3JpcHRpb24gaW4gRFQgd2hp
Y2ggaXMgbWVyZ2VkIGZvciBhIHdoaWxlIGluIHRoZSBrZXJuZWwuDQo+IA0KPiBXaGF0J3MgeW91
ciBwb2ludCBoZXJlPyBGcm9tIHdoYXQgSSBjYW4gdGVsbCB0aGUgRFQgYmluZGluZyBpcyB3cm9u
Zw0KPiBhbmQgbmVlZHMgdG8gYmUgcmV3b3JrZWQgYW55d2F5Lg0KDQo+IEkgYW0ganVzdCBzYXlp
bmcgdGhhdCB0aGlzIGlzIG5vdCBhbnkgYWRob2MgbmV3IGZlYXR1cmUgYnV0IGNvbmZpZ3VyYXRp
b24gd2hpY2ggDQo+IGhhcyBiZWVuIGFscmVhZHkgZGlzY3Vzc2VkIGFuZCBzb21lIHN0ZXBzIG1h
ZGUuIElmIERUIGJpbmRpbmcgaXMgd3JvbmcgaXQgY2FuIGJlIA0KPiBkZXByZWNhdGVkIGFuZCB1
c2UgbmV3IG9uZSBidXQgZm9yIHRoYXQgaXQgaGFzIGJlIGNsZWFyIHdoaWNoIHdheSB0byBnby4N
Cg0KDQo+PiBBbmQgQW1pdCBpcyB0cnlpbmcgdG8gZmlndXJlIGl0IG91dCB3aGljaCB3YXkgdG8g
Z28uDQo+PiBJIGRvbid0IHdhbnQgdG8gcHJlZGljdCB3aGVyZSB0aGF0IGNvZGUgc2hvdWxkIGJl
IGdvaW5nIG9yIGhvdyBpdCBzaG91bGQgbG9vaw0KPj4gbGlrZSBiZWNhdXNlIGRvbid0IGhhdmUg
c3BpLW5vciBleHBlcmllbmNlLiBCdXQgSSBob3BlIHdlIGZpbmFsbHkgbW92ZSBmb3J3YXJkDQo+
PiBvbiB0aGlzIHRvcGljIHRvIHNlZSB0aGUgcGF0aCBob3cgdG8gdXBzdHJlYW0gc3VwcG9ydCBm
b3IgaXQuDQo+IA0KPiBZb3Ugc3RpbGwgZGlkbid0IGFuc3dlciBteSBpbml0aWFsIHF1ZXN0aW9u
LiBXaWxsIEFNRCBzdXBwb3J0IGFuZA0KPiBtYWludGFpbiB0aGF0IGNvZGU/IEkgd2FzIHB1c2hp
bmcgeW91IHRvd2FyZHMgcHV0dGluZyB0aGF0IGNvZGUgaW50bw0KPiB5b3VyIG93biBkcml2ZXIg
YmVjYXVzZSB0aGVuIHRoYXQncyB1cCB0byB5b3Ugd2hhdCB5b3UgYXJlIGRvaW5nDQo+IHRoZXJl
Lg0KDQo+IE9mIGNvdXJzZS4gV2UgY2FyZSBhYm91dCBvdXIgY29kZSBhbmQgYWJvdXQgc3VwcG9y
dGluZyBvdXIgU09DIGFuZCBmZWF0dXJlcyANCj4gd2hpY2ggYXJlIHJlbGF0ZWQgdG8gaXQuIEl0
IG1lYW5zIHllcywgd2Ugd2lsbCBiZSByZWd1bGFybHkgdGVzdGluZyBpdCBhbmQgDQo+IHRha2lu
ZyBjYXJlIGFib3V0IGl0Lg0KDQoNCj4gU28gaG93IGRvIHdlIG1vdmUgZm9yd2FyZD8gSSdkIGxp
a2UgdG8gc2VlIGFzIGxpdHRsZSBhcyBjb3JlIGNoYW5nZXMNCj4gcG9zc2libGUgdG8gZ2V0IHlv
dXIgZHVhbCBmbGFzaCBzZXR1cCB3b3JraW5nLiBJJ20gZmluZSB3aXRoIGhhdmluZyBhDQo+IGxh
eWVyIGluIHNwaS1ub3IvIChub3Qgc3VyZSB0aGF0J3MgaG93IGl0IHdpbGwgd29yayB3aXRoIG10
ZGNhdA0KPiB3aGljaCBsb29rcyBsaWtlIGl0J3Mgc2ltaWxhciBhcyB5b3VyIHN0YWNrZWQgZmxh
c2gpIGFzIGxvbmcgYXMgaXQNCj4gY2FuIGJlIGEgbW9kdWxlIChzZWxlY3RlZCBieSB0aGUgZHJp
dmVyKS4NCg0KPiBvay4NCg0KQmVzdCByZWdhcmRzLA0KTmVhbCBGcmFnZXINCkFNRA0K

