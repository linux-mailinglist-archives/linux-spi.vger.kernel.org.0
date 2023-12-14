Return-Path: <linux-spi+bounces-269-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5607E81250F
	for <lists+linux-spi@lfdr.de>; Thu, 14 Dec 2023 03:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673E21C20B83
	for <lists+linux-spi@lfdr.de>; Thu, 14 Dec 2023 02:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203B57F9;
	Thu, 14 Dec 2023 02:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QpExS+1l"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2084.outbound.protection.outlook.com [40.107.7.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A576F7
	for <linux-spi@vger.kernel.org>; Wed, 13 Dec 2023 18:10:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEf27kbw6Ep25IdRj94jYZ6q9DaLt3Bkq8gYgo6ZYwzMq4HX/4GP6kMd7GshapZrDeKLg23KCQvDYvr1YxdSK2X6tu+OHPOFA3Zfum6xwTmQcYXtmyLmHIvahKW5sV7cKXeW34T2Q4/jrjAo6YOJIZItP6aP50FEsDHJK2N6FHkt3kzpZy2oka5MY5BcxuzQpiA/wWjsKg1zukxkRSDd6IjcHHZ4voNYrAJzBMsRhKKsIev3uzg3PXplKlRdoxvsxmxLjHUjwnYBe1LOXlQPGwBcFJQtIabI8Qz59EEp6/3+7OhQ8rutqZcx4JevTfD59u2k1IbfuFtrqhhTZAzJFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7niPibLBFgTEeC3psKioNcfDmE3BQja83ogqxXi/nE=;
 b=VifLWlChw6zb4RgNgBg9PGlhKyc1VEyc+JWIRxaGoOvwaUTgADPjs+R0QP+QD/qT2Yv09Pxyqike2sFTzMmUcW8xBO6G38nk8dGgh7NEmPWbOlEwfnFps0X7CCyifTWfPYDoSvmJnyyLnhkTfjJnczgnFZlczKDRE5aBy6Gfxa9vaKkCEcdefVA5dB+0JuN0OxKk5KY7Y8muvqz8yRaUlQ5dU48UxUIleu5xgKJgOR50lDvPj7ie/4Zecbi6w6FpAaxf98R7RZz+uLytFxUIgXJY4koRHIHC2vxKavUTreMiHSc3GnUWDB4cEaSFskx0YD4IT98UeT2YH3c6gAeeiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7niPibLBFgTEeC3psKioNcfDmE3BQja83ogqxXi/nE=;
 b=QpExS+1lSrWEdbTT8I5TBIpHkBfA+V402NASp0n68UJwl813d5EjmTvVehxgVL0nSEV8HIQZmGwRqRioHT95sFHVAizffbPJ4/bNVbp2cW/uZYYE3qIZZoxM42V2ac9OACXwLkFHk4zDy/CPJ+1KV5H4gJbn8v0ocHVS3ye3sqc=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 DB8PR04MB6905.eurprd04.prod.outlook.com (2603:10a6:10:113::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26; Thu, 14 Dec 2023 02:10:18 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::f008:81ba:6172:d79]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::f008:81ba:6172:d79%6]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 02:10:18 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Michael Walle <mwalle@kernel.org>
CC: "broonie@kernel.org" <broonie@kernel.org>, Han Xu <han.xu@nxp.com>,
	dl-linux-imx <linux-imx@nxp.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "yogeshgaur.83@gmail.com"
	<yogeshgaur.83@gmail.com>
Subject: RE: [PATCH 2/5] spi: spi-nxp-fspi: change the default lut index
Thread-Topic: [PATCH 2/5] spi: spi-nxp-fspi: change the default lut index
Thread-Index: AQHaLaP2wzhi5TR1c06pjVU5onkOhbCnZnEAgACjdKA=
Date: Thu, 14 Dec 2023 02:10:17 +0000
Message-ID:
 <DB7PR04MB4010F28F911AB66680E4226E908CA@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20231213091346.956789-2-haibo.chen@nxp.com>
 <20231213162436.2770068-1-mwalle@kernel.org>
In-Reply-To: <20231213162436.2770068-1-mwalle@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|DB8PR04MB6905:EE_
x-ms-office365-filtering-correlation-id: 594e3afe-aa43-4a10-e265-08dbfc49d17c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 92VOBsgjiPLspU+IBubG8bxNkzpvX4DOMmoxEo9AfuA+pT1O6Mb2wOsp0spzZFyf/2NCatE86CLfpDePCIOpLvrUtAc1rCH8iOFzbYPOdX9hOoDQ2VPN+tjxWof3mAco+3OXOBN6MVbLQyICWZe4tFOgRYTRJN++tCbWq6VBBV+n+6RJjc+6e7IEs061w4TiWH5kb3uUVLf4nKF4Z+LXNwS3Xw7YUF5AUGEm1aRkuT0xGBI7+B8qTXMENNVtz1OtQJckBh+zgUsU8CeSdB3JMlPJhAznTTXYDl56eZEWbSfniW7cTqH+g1fiItZ+J2cxg0hZ5ZTU+YmfKmEpreBU7jre17cJ+C/i21q9rIDYhgfIYWfv8ygH89dQDPJAhCluC6JXHKNNiZIK1o/EV+zNCgeVYPywoWkNP6yokNfkCX5aXAbxfeVium384QFGdP8BxP8SrF8CgyPilWwTtuHixoJHQuh4kHYo69rnwTTBQdrXQMCg+9duqVDys3GV7HuhLNHs55+TmmKBonWKtAfdBecwIezju824CHZUM8bS2sD09jl+uJ42nZrB85wVu5VbtXrzhFfl1oAz4jziav/PvkzvLgmswg+9NxOLOPx0CsFx2EA4hizfWSERbE+mhhRn
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(41300700001)(26005)(83380400001)(86362001)(38070700009)(33656002)(38100700002)(122000001)(5660300002)(53546011)(6916009)(316002)(4326008)(8936002)(8676002)(52536014)(2906002)(7696005)(6506007)(9686003)(71200400001)(76116006)(66946007)(66476007)(66446008)(64756008)(54906003)(66556008)(478600001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?S2d1SGxwNGxoZ0Z1TllQajE0YWZ6dWdnQWwxNFh2NCtUSHkveVZ6WmZJTHVm?=
 =?gb2312?B?UFZwRy9QR3JpQ00wZUQ5ZnZGRXd2Y0RrWkRqNlFTNXpNN3M3MEF0Y1VRcU91?=
 =?gb2312?B?K0w1WWZJcWJsM0s3TjlaUHpUWmlLTjJjNEFBU3k4b0p3WURUWFVqTzFxSGtS?=
 =?gb2312?B?L0FXeTlyVVByMkphL2FoL3lXUGNuZDZBMkxxVkpUcnJiYVVsY0RCMjFKMjll?=
 =?gb2312?B?TkxxVFgzTzJtNnptNThrczV2aWJGeUNrOE04cnhkM2dQNU5zZmVWZkUwTjVQ?=
 =?gb2312?B?MkVFcEh1aCtDUXBaRXNPcGgrdWpYYW9VcmFyNm5tWVgrU3IwUkZUNy9JSy9I?=
 =?gb2312?B?RjQvRjc3emRWdmpXanJxNS9RSVBzZC9xanBMQVZ3SytPOUROQmY2YjRFWk4r?=
 =?gb2312?B?WU5BbDdscUh6b1oyVG9qR0EvOXhYSVZ6V0RxTlhWNTlwVHptakpYY3hkNFNF?=
 =?gb2312?B?S0pNaEdEdEtVbWdWR0kveHRYbSt4U0taeC9wZmZaMXc0VUVqUmU5WFpSd2l2?=
 =?gb2312?B?OU9DOGRRTzE5Y2QxeUtoTXlHbGpkNVgxdTFqV0IvSThhU2hMWS9kRTlUdzFB?=
 =?gb2312?B?eVlYUlVGSW5aNGpSUnY5Nnl2UDlvR2puMEhLZEF2eERBTU44aHJ3MmJWcldE?=
 =?gb2312?B?L0thc2o4RS9iM0kzZmpRQnRUVGM2U3o4bm5MYmJHTE1BaHJTeDA1Y0gxVnpT?=
 =?gb2312?B?QVljZzQxbHVndS9RckxpMFlNVHFpMDB5a3pvLzZiUXEvR21uay81YVU1UzNx?=
 =?gb2312?B?NnM3dFJnSjVtbTB6QkFRK0I0bzJITHptMDJITlBkbDNqUXBtNlNkejBnbDJL?=
 =?gb2312?B?K1gza2hNQnBJTDJwMHk5aDQ5Sk5jY1lDM3Q2bDZOQ3p3YURZQU1hV1VPNHZO?=
 =?gb2312?B?VkdGTy9vNWR5anZnOTQ0aDhqcXo5VzYrSFRRd0wvOUM3cnhqY1RiQUJyKy9T?=
 =?gb2312?B?YkF0ZTJ3L3dsVStSU01NUHJpWjlZVTBiZENjbzFoaUF2ZXpNNGU2eFdUcHkv?=
 =?gb2312?B?a3AxNTU4bVBPVCtPV29mWlI0Y2pHN1pyOUwyZlBBckNvUUF3M1pkSUthMFRX?=
 =?gb2312?B?NU94dk5JRkZ1SVA4KzR1RHpIWUFVYTBkRzJRYlgwcnVUY1RvN0R3ZnFMNWs3?=
 =?gb2312?B?cUlRM2NnVE9wK2FrQWxNVUJTQlo2bDUyMG91UjJGTy9Ua3VsQVlOc081U0Np?=
 =?gb2312?B?VU4zR0h6WkxaMUloaUFUYld2ZW9LV09aUWtHcHpzUVViNk5yYjZ1emR6RmxS?=
 =?gb2312?B?d1ZCM01qdEUvOUY5dFY2ZkY5WHdOWThlWDRGR3NpK29QSTZ2VFhYOXhrYTlT?=
 =?gb2312?B?Q0ptd1VncG9EVUlacENMcm1zR01DT1U5YVV5TWY2bmVRRGsrL1B3V00xekNZ?=
 =?gb2312?B?cWJXN3haeDkxZGd3ZXVhUWNhV1RkQUIrZEM5WVRWL3JtdXpPamdscFVJR3B0?=
 =?gb2312?B?eHlmV2VFZXpDcjJ2UVdKVlhPYVZVSFNrS1BBL2N2cHdHckVobGVwUmc2OVhY?=
 =?gb2312?B?N1pyQk42enU1aVJZVmt3eDN3RVNIVFRZY093dW5haHJZbjNheVNqWmI3dnF0?=
 =?gb2312?B?MVJFVEdtY1hqemFkV1E4UnVtTzNlMk93TFIrMnc1RWZBU0M1aitjeUtxU1NG?=
 =?gb2312?B?VFBLZUhUNTV5S1Y5STZadUNjbnRsMVBrdnl5QlM0b2NncndjZEZFeCtpMDNZ?=
 =?gb2312?B?cHVOak5sc2grMzZTNXFLQVU1Ymx0djY1WGpCRkpsc0FWczJxaWYzYzBHbk85?=
 =?gb2312?B?SXIwN0dxNEZ3S3JDeHFKSFFUVGRYUDFva1ZVWmgyaDRXNXdCdGVoWnpIZ0Ji?=
 =?gb2312?B?Y3JvWFlCWmwvRGtlc3NUTCtpaEQrZmZ3YisrQU1OUVVQU3JVTFdVT2NQTTdw?=
 =?gb2312?B?NlJ5MnA0WXZ0Unp6enhKZjdnN1hSdllUUFpEMUErVkkySzNHKzF1dmR3VEJq?=
 =?gb2312?B?RjBtQXlXY0h0a2xSVXc2Z0xWTERRa1YxcEhVKzBuK2FMT1p6RXZpaERlUGRt?=
 =?gb2312?B?SDI3YWY5bll1TTV3YnZ0R3hqZU5MSlJXblRLekhXLzAzR01DVEZ3dFJqQmZa?=
 =?gb2312?B?cy9ZSlRWcXpwRi81WmJ6Mkd2WndsaEpzZGZmdnJOSjVVZm9iaVRVaDhRRXlh?=
 =?gb2312?Q?2mHU=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 594e3afe-aa43-4a10-e265-08dbfc49d17c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 02:10:18.0092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nxeFJGEjAHS4NZ/l7euzvdJG6rtNTpJoMwHYtLhIuJlva/ZKK9anvfsMB9lPO2I8oeX6aLwhAeofqCQqCW+eAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6905

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoYWVsIFdhbGxlIDxtd2Fs
bGVAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyM8TqMTLUwjE0yNUgMDoyNQ0KPiBUbzogQm91Z2gg
Q2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiBDYzogYnJvb25pZUBrZXJuZWwub3JnOyBIYW4g
WHUgPGhhbi54dUBueHAuY29tPjsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT47
IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7IHlvZ2VzaGdhdXIuODNAZ21haWwuY29tOw0KPiBN
aWNoYWVsIFdhbGxlIDxtd2FsbGVAa2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAy
LzVdIHNwaTogc3BpLW54cC1mc3BpOiBjaGFuZ2UgdGhlIGRlZmF1bHQgbHV0IGluZGV4DQo+IA0K
PiA+IFRoZSBmc3BpIGR5bmFtaWMgbHV0IHVzZSB0aGUgbGFzdCBsdXQgZm9yIGFsbCBJUFMgb3Bl
cmF0aW9ucywgdGhlDQo+ID4gaW14OHVscCBvbmx5IHN1cHBvcnRzIDE1IGx1dHMsIHNvIGNoYW5n
ZSB0aGUgbGFzdCBsdXQgaW5kZXggZnJvbQ0KPiANCj4gSXQncyAxNiBMVVRzLCBubz8gVGhlcmUn
cyBhbHNvIGluZGV4IDAuDQoNClllcywgc2hvdWxkIGJlIDE2IExVVHMuDQoNCj4gDQo+ID4gMzEg
dG8gMTUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIYW4gWHUgPGhhbi54dUBueHAuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9zcGkvc3BpLW54cC1mc3BpLmMgfCA0ICsrLS0NCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3NwaS9zcGktbnhwLWZzcGkuYyBiL2RyaXZlcnMvc3BpL3NwaS1ueHAt
ZnNwaS5jDQo+ID4gaW5kZXggMGZlZWNmNWJhMDEwLi45ZDZiNGQyMjI2M2MgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9zcGkvc3BpLW54cC1mc3BpLmMNCj4gPiArKysgYi9kcml2ZXJzL3NwaS9z
cGktbnhwLWZzcGkuYw0KPiA+IEBAIC02NCw5ICs2NCw5IEBADQo+ID4gIC8qDQo+ID4gICAqIFRo
ZSBkcml2ZXIgb25seSB1c2VzIG9uZSBzaW5nbGUgTFVUIGVudHJ5LCB0aGF0IGlzIHVwZGF0ZWQg
b24NCj4gPiAgICogZWFjaCBjYWxsIG9mIGV4ZWNfb3AoKS4gSW5kZXggMCBpcyBwcmVzZXQgYXQg
Ym9vdCB3aXRoIGEgYmFzaWMNCj4gPiAtICogcmVhZCBvcGVyYXRpb24sIHNvIGxldCdzIHVzZSB0
aGUgbGFzdCBlbnRyeSAoMzEpLg0KPiA+ICsgKiByZWFkIG9wZXJhdGlvbiwgc28gbGV0J3MgdXNl
IHRoZSBsYXN0IGVudHJ5ICgxNSkuDQo+IA0KPiBQbGVhc2UgYWRkIHRoZSBpbmZvcm1hdGlvbiBh
Ym91dCB0aGUgaW14OG11bHAgdG8gdGhlIGNvbW1lbnQuDQo+IE90aGVyd2lzZSwgdGhlIGNvbW1l
bnQgd2lsbCBiZSBjb25mdXNpbmcgZm9yIFNvQ3Mgd2hlcmUgdGhlcmUgYXJlIDMyIExVVHMuDQoN
Clllcywgd2lsbCBhZGQuDQoNCkJlc3QgUmVnYXJkcw0KSGFpYm8gQ2hlbg0KPiANCj4gLW1pY2hh
ZWwNCj4gDQo+ID4gICAqLw0KPiA+IC0jZGVmaW5lCVNFUUlEX0xVVAkJCTMxDQo+ID4gKyNkZWZp
bmUJU0VRSURfTFVUCQkJMTUNCj4gPg0KPiA+ICAvKiBSZWdpc3RlcnMgdXNlZCBieSB0aGUgZHJp
dmVyICovDQo+ID4gICNkZWZpbmUgRlNQSV9NQ1IwCQkJMHgwMA0KPiA+IC0tDQo+IDIuMzQuMQ0K
PiANCg0K

