Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5042D1453
	for <lists+linux-spi@lfdr.de>; Mon,  7 Dec 2020 16:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgLGPEn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Dec 2020 10:04:43 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:20945 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgLGPEn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Dec 2020 10:04:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1607353482; x=1638889482;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jm7lPEl6XDtZpqhCZwepktRBGxi9QhH6+ozywF7vTTI=;
  b=C4swdq5Ea9d0UQ2XYdyll/l4LQMYeuIKNoiQ7swOf76XgxJcIoPybKEX
   aYIfYqVbEKzHQj09OTO71Vm80IGc3NNRjesSMqPY13rleqvm/0n+i0k5o
   jwrdMbvoYi1E+uGGueDSVML/eSB+mGiJkMrRFwydiLM5h0RNYxmJaCG12
   ur2uOCFEu005MlMKmoWMtjLOSeIWA9G8E0vUn3Dd900U5mU0kfzADikDx
   +vnsEHld4Hbx3PoG3X3PJMczHu54h7Y3Dz6gYr2VM6Wu7jee8Ssg48Owf
   IG/u/AbZ3nbRGrVWBJe9J7BjEVMIp52CIWM4DqwOTxxU317buuMYb7pR0
   w==;
IronPort-SDR: CjGrnL1rsOCVkAb0pHiv+Tto6TbG3L8OG1X8p+58Z2/9ZUF8wEsaKzfTrw76ZIisoRNufybTVU
 JlxwvfsbhCNzhG4Hw05HkHgbgoxIhXyJBSaEQJ3hezxjwMr1BLA4O31Rcd2x+UOXTe1GfBE4Bk
 oyj8D34pysOU7YxQBJt0NaqC1V/p+5al8A7ru+J8jCU91XRFQhuFUax11xHkzi8P2woKbv9gK3
 ULP28THuC4Xjsh0kr2aruPPU9VPRo1Jh9rem60E6CxT0JPBy85OxD9IdOj+6jejMAEapGhua0R
 v20=
X-IronPort-AV: E=Sophos;i="5.78,399,1599548400"; 
   d="scan'208";a="106518386"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Dec 2020 08:03:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 7 Dec 2020 08:03:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 7 Dec 2020 08:03:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtLfZCvjIE88OBCtsX79I06ZBXtO2f9p87j19NKgGQys6DZ1FnlWORw+i1CgtsFcFbjKZs1a1UEKfDnJQIiuQ9d0vteoldoOgkTPCbXKkMDoWb/dA4gZOeN9a4JYmrmGdAv47mwas8Eb4dKpJUGM85C93ANTzGq+w7SO627EO1UfnSEhGWOy9y2urm0xmJbYUScCsIScFwblKr2YR4OrvHeZkYgi8t/L86uCzciFjkZHi4kF0n8QIVqBkYHulXYPOI16QlHqltkgKQ4uo5ZFUJGyjPg7hO55CcdYDWmFWSzQdKlLRkAq3ehw/KRabP5Cu9YTxaSTUZs2gOky8BJHxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jm7lPEl6XDtZpqhCZwepktRBGxi9QhH6+ozywF7vTTI=;
 b=I0D7U9DvryDX9kaoQe8+yzFJhE5W+Atvxm9Mha5ZDiehoov4eEcaGkgVclQJsXp8/t2vXdRp4vZvhBSx0CM6d4/p090WU4UeJ9V2pBaZ60u6Rwf2JyNP80e56Ekjt6edN2lEOPdSeAMc7NbR75Mw7mJKGPVlQ1WeR64oVW/kRVrQUTil1A7rwD01YOT43Y22+Nwo4GoYIZ/5qihnlo6XsRkqzk/eJYQuyC07fKO79yO1J1RPtXDqC/j/3jlqfPsQYtp1OI04pehMjv5retuXKRrpeN96S04LzPzA7aLzkkVKZVrQuG/cCLBRhlRESQCBTOSp+DaD74KpYIcJcJwpmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jm7lPEl6XDtZpqhCZwepktRBGxi9QhH6+ozywF7vTTI=;
 b=HLbcBf+G4N3j+qepqNbPr9B9KhksDiOykl0XgtvFovwSq2sNckZMJCY48Y/4+cfaaVE7URhRdQhJ3K84dnRzvqgEUo2UcXqiRxTV8qY4qR2ZbSOKzhVa7gkm9bNtdPg3M3LBeMXsaibT7hOXcb+iGV9W7jiBID2C5z8mNnS3DGs=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2879.namprd11.prod.outlook.com (2603:10b6:805:5c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Mon, 7 Dec
 2020 15:03:15 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761%7]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 15:03:14 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <lukas@wunner.de>, <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <bugalski.piotr@gmail.com>
Subject: Re: [PATCH 17/17] spi: atmel-quadspi: Fix use-after-free on unbind
Thread-Topic: [PATCH 17/17] spi: atmel-quadspi: Fix use-after-free on unbind
Thread-Index: AQHWzKoW4krOIzJ+8kqHM5RZ8hQ9rA==
Date:   Mon, 7 Dec 2020 15:03:14 +0000
Message-ID: <2e903538-d221-3f6b-cc46-3f4951ecbcdf@microchip.com>
References: <cover.1607286887.git.lukas@wunner.de>
 <4b05c65cf6f1ea3251484fe9a00b4c65478a1ae3.1607286887.git.lukas@wunner.de>
In-Reply-To: <4b05c65cf6f1ea3251484fe9a00b4c65478a1ae3.1607286887.git.lukas@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: wunner.de; dkim=none (message not signed)
 header.d=none;wunner.de; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [5.13.1.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f86512c3-1638-41cb-2210-08d89ac13909
x-ms-traffictypediagnostic: SN6PR11MB2879:
x-microsoft-antispam-prvs: <SN6PR11MB2879AA3117AF6DB86A5AFCE0F0CE0@SN6PR11MB2879.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OyNgCC7viJg+6ctf6gBO9sjhm562x2c3L20kswHrk6+7mEKMV/kyXV9BpSz8tEqhzEuBJXEC6Pu8E2ox+S1naY7eafNaXK2vXfZLmih6KowDh/pIGipdeTgv6i+VDXn+fNgVDH9zqCGI0Z/OxVZb6X5cZHZ+5GX4jW+81FmOa1c2O361ATRFd82Ibxb70G5vD7jNUojOVUqvYXX41Hcdl5nrSb0IIBiJBYI3IokfelPCclvdhZnkFqowJuBNxti0T3C6a8rg7xvo4U+eujFMxlyT4z8sdXSihhJsGkKOAVqVKqhG0QoRl4jcNdceeeHhet6IuGqHg5lg4i+mpWRsqwTmJmm89LCsSCWZNpABp2DlxEADSTqwwl29eBCUSIzvRBdMulNhV39C3CCpTXzNQm4KpVCrXFzDIeXT+vIoOPg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(53546011)(110136005)(26005)(54906003)(2906002)(8676002)(4326008)(498600001)(6486002)(186003)(8936002)(6512007)(31686004)(66946007)(76116006)(71200400001)(31696002)(86362001)(36756003)(2616005)(64756008)(83380400001)(66446008)(5660300002)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SThMU3dnUzIwRXQ2djJpdWx6VzR3ZVBGaE45ZFAzK3E4NDA0RWJlU3VQUGpp?=
 =?utf-8?B?NWtSUUwzcFlCVDM2QkIzbjF1b2o3aExzMk10eUJtYm9nMytZbm1yQXVmWnFO?=
 =?utf-8?B?Vml1RXRDUkVCTUNVUUZpZEphZ0tjWWdON01PdmJuSG5NcFQ1RStDT2laQkcw?=
 =?utf-8?B?dldSNVlWSHJ1azJmQ0R0UWFyMXBXQmI2UDVyQUxNbHZFWVB4aFJocmt1SnhL?=
 =?utf-8?B?U3JqekdOM0RoTDNMYm16K2hrV004MEFYejc3TFNCTzFQV3YwVkpoSHBBTHRn?=
 =?utf-8?B?OG9JSW94L0JnNUhxbE52NUxxRVI4ZFBnS0d0cU1sRzc3QldqUzNBc2ZvWFZE?=
 =?utf-8?B?TmdLRzFqTGV3ODFnZXBUYlNiUVJvUXVQcUtuUHNvOUZhWkZQMUdQeTJWSlY0?=
 =?utf-8?B?b1dlVy94S0JKcTQ4Q3Y5UkR5cFp4eWxpeEZoVng2aVpJUFpvRndWT3J4Uk1v?=
 =?utf-8?B?YUJyZC9WSnFHdGMxbTlBa0tQMWpvUWF4M1BZTHhUbnA2d2VGQmpxcEtDTzAv?=
 =?utf-8?B?ZnpmSi9CUFVQVFIrWkcyaTMyTXBidVY4OFphTHVkdEt1SE13dDdJaWdXSFNM?=
 =?utf-8?B?M2ozUkU4SFVDNlRlNUd3SFRJZ1BQcUhKOCsxTU04NXViU0xtYXd6NjluMEdy?=
 =?utf-8?B?SnFTa0hDcktDVXBrVkIweWx0Qk9NbXFOcmFvaWVJYkxndDRGdXFNM3FqeC9n?=
 =?utf-8?B?MEdMTUhSLzVDMVBzRWFvdDV4MXdBb3l4Q2d2VW9DM0xqaVVuUkp6S3BMTlFo?=
 =?utf-8?B?NXFHdU52cCt6R2tRYXFFZENGU2xwbXNWM3JjRXpOS0FLeFJ5cnBuVlZCeGtL?=
 =?utf-8?B?YzVvN2svZ2FYZDBZd2NkQXlLMVVCM2xlU25raitWZlhsMEl3TnB5ZGtVd3c0?=
 =?utf-8?B?ckJvWk1tMUxJeXZsZHo4MXZzT0ZkWEQ0VHh0Qzh5cVBzaFJJeVZ2TEl0czU0?=
 =?utf-8?B?VUI0VVJXZkZ4QjdXcThzVlhHYlQ2Ni9McnBCVTZsU1IwZVZ2ZGNkdXpiTU1j?=
 =?utf-8?B?M0h5WlNoQ1g0Ykc3VkhmSmlDRlkwQmt2eERzSXdITExNbkdxVk9sNjNRU0dN?=
 =?utf-8?B?QmdRL0EvT091aHY3bzFLZmdHWE9TZUt5SUNrQ3VPWEJoM0JPckJKMGVvM1lK?=
 =?utf-8?B?Z1ByVmVzMFBOOTR1TXBpUVhmNDZyMGRWUk9ZaWl0ZVdUNXR5TjZNcjQ2OTlD?=
 =?utf-8?B?dlk2dFdUQi8vbUk2SlNwU05aTUpDNWdtOVVtVElCMWhLR2daWWFVem5haVR5?=
 =?utf-8?B?MEhlRVdsWU1GTUc5dldBVzREd1puU0FFVjZHd2RnK3Y5SERXd1ZKUDZPZFpO?=
 =?utf-8?Q?aerothe+CAWdc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6589A1D48D799A4D9D9CCC8A8B2C8DE1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86512c3-1638-41cb-2210-08d89ac13909
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 15:03:14.8324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6DQFbn+DmJooEAL1soqN1IG3grvqV5qG6L/9nwC9Hfri80tUUn8esUjf2qCZVLL2TJ5+D/B13MSFSCfMrNFTJPpRdBx919kQl8is9QHiXQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2879
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gMTIvNy8yMCAxMDoxNyBBTSwgTHVrYXMgV3VubmVyIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IGF0bWVsX3FzcGlfcmVtb3ZlKCkgYWNjZXNzZXMg
dGhlIGRyaXZlcidzIHByaXZhdGUgZGF0YSBhZnRlciBjYWxsaW5nDQo+IHNwaV91bnJlZ2lzdGVy
X2NvbnRyb2xsZXIoKSBldmVuIHRob3VnaCB0aGF0IGZ1bmN0aW9uIHJlbGVhc2VzIHRoZSBsYXN0
DQo+IHJlZmVyZW5jZSBvbiB0aGUgc3BpX2NvbnRyb2xsZXIgYW5kIHRoZXJlYnkgZnJlZXMgdGhl
IHByaXZhdGUgZGF0YS4NCj4gDQo+IEZpeCBieSBzd2l0Y2hpbmcgb3ZlciB0byB0aGUgbmV3IGRl
dm1fc3BpX2FsbG9jX21hc3RlcigpIGhlbHBlciB3aGljaA0KPiBrZWVwcyB0aGUgcHJpdmF0ZSBk
YXRhIGFjY2Vzc2libGUgdW50aWwgdGhlIGRyaXZlciBoYXMgdW5ib3VuZC4NCj4gDQo+IEZpeGVz
OiAyZDMwYWM1ZWQ2MzMgKCJtdGQ6IHNwaS1ub3I6IGF0bWVsLXF1YWRzcGk6IFVzZSBzcGktbWVt
IGludGVyZmFjZSBmb3IgYXRtZWwtcXVhZHNwaSBkcml2ZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBM
dWthcyBXdW5uZXIgPGx1a2FzQHd1bm5lci5kZT4NCj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwu
b3JnPiAjIHY1LjArOiA1ZTg0NGNjMzdhNWM6IHNwaTogSW50cm9kdWNlIGRldmljZS1tYW5hZ2Vk
IFNQSSBjb250cm9sbGVyIGFsbG9jYXRpb24NCj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3Jn
PiAjIHY1LjArDQo+IENjOiBQaW90ciBCdWdhbHNraSA8YnVnYWxza2kucGlvdHJAZ21haWwuY29t
Pg0KDQpSZXZpZXdlZC1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAu
Y29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNwaS5jIHwgMTUgKysrKyst
LS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9hdG1lbC1xdWFkc3BpLmMgYi9k
cml2ZXJzL3NwaS9hdG1lbC1xdWFkc3BpLmMNCj4gaW5kZXggYjQ0NTIxZDRhMjQ1Li4xNzQyY2Nj
MWFkMGUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc3BpL2F0bWVsLXF1YWRzcGkuYw0KPiArKysg
Yi9kcml2ZXJzL3NwaS9hdG1lbC1xdWFkc3BpLmMNCj4gQEAgLTUzNSw3ICs1MzUsNyBAQCBzdGF0
aWMgaW50IGF0bWVsX3FzcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4g
ICAgICAgICBzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCj4gICAgICAgICBpbnQgaXJxLCBlcnIgPSAw
Ow0KPiANCj4gLSAgICAgICBjdHJsID0gc3BpX2FsbG9jX21hc3RlcigmcGRldi0+ZGV2LCBzaXpl
b2YoKmFxKSk7DQo+ICsgICAgICAgY3RybCA9IGRldm1fc3BpX2FsbG9jX21hc3RlcigmcGRldi0+
ZGV2LCBzaXplb2YoKmFxKSk7DQo+ICAgICAgICAgaWYgKCFjdHJsKQ0KPiAgICAgICAgICAgICAg
ICAgcmV0dXJuIC1FTk9NRU07DQo+IA0KPiBAQCAtNTU3LDggKzU1Nyw3IEBAIHN0YXRpYyBpbnQg
YXRtZWxfcXNwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgICAgICAg
IGFxLT5yZWdzID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKCZwZGV2LT5kZXYsIHJlcyk7DQo+ICAg
ICAgICAgaWYgKElTX0VSUihhcS0+cmVncykpIHsNCj4gICAgICAgICAgICAgICAgIGRldl9lcnIo
JnBkZXYtPmRldiwgIm1pc3NpbmcgcmVnaXN0ZXJzXG4iKTsNCj4gLSAgICAgICAgICAgICAgIGVy
ciA9IFBUUl9FUlIoYXEtPnJlZ3MpOw0KPiAtICAgICAgICAgICAgICAgZ290byBleGl0Ow0KPiAr
ICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoYXEtPnJlZ3MpOw0KPiAgICAgICAgIH0NCj4g
DQo+ICAgICAgICAgLyogTWFwIHRoZSBBSEIgbWVtb3J5ICovDQo+IEBAIC01NjYsOCArNTY1LDcg
QEAgc3RhdGljIGludCBhdG1lbF9xc3BpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ICAgICAgICAgYXEtPm1lbSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZSgmcGRldi0+ZGV2
LCByZXMpOw0KPiAgICAgICAgIGlmIChJU19FUlIoYXEtPm1lbSkpIHsNCj4gICAgICAgICAgICAg
ICAgIGRldl9lcnIoJnBkZXYtPmRldiwgIm1pc3NpbmcgQUhCIG1lbW9yeVxuIik7DQo+IC0gICAg
ICAgICAgICAgICBlcnIgPSBQVFJfRVJSKGFxLT5tZW0pOw0KPiAtICAgICAgICAgICAgICAgZ290
byBleGl0Ow0KPiArICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoYXEtPm1lbSk7DQo+ICAg
ICAgICAgfQ0KPiANCj4gICAgICAgICBhcS0+bW1hcF9zaXplID0gcmVzb3VyY2Vfc2l6ZShyZXMp
Ow0KPiBAQCAtNTc5LDE1ICs1NzcsMTQgQEAgc3RhdGljIGludCBhdG1lbF9xc3BpX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+IA0KPiAgICAgICAgIGlmIChJU19FUlIoYXEt
PnBjbGspKSB7DQo+ICAgICAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYsICJtaXNzaW5n
IHBlcmlwaGVyYWwgY2xvY2tcbiIpOw0KPiAtICAgICAgICAgICAgICAgZXJyID0gUFRSX0VSUihh
cS0+cGNsayk7DQo+IC0gICAgICAgICAgICAgICBnb3RvIGV4aXQ7DQo+ICsgICAgICAgICAgICAg
ICByZXR1cm4gUFRSX0VSUihhcS0+cGNsayk7DQo+ICAgICAgICAgfQ0KPiANCj4gICAgICAgICAv
KiBFbmFibGUgdGhlIHBlcmlwaGVyYWwgY2xvY2sgKi8NCj4gICAgICAgICBlcnIgPSBjbGtfcHJl
cGFyZV9lbmFibGUoYXEtPnBjbGspOw0KPiAgICAgICAgIGlmIChlcnIpIHsNCj4gICAgICAgICAg
ICAgICAgIGRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byBlbmFibGUgdGhlIHBlcmlwaGVy
YWwgY2xvY2tcbiIpOw0KPiAtICAgICAgICAgICAgICAgZ290byBleGl0Ow0KPiArICAgICAgICAg
ICAgICAgcmV0dXJuIGVycjsNCj4gICAgICAgICB9DQo+IA0KPiAgICAgICAgIGFxLT5jYXBzID0g
b2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKCZwZGV2LT5kZXYpOw0KPiBAQCAtNjM4LDggKzYzNSw2
IEBAIHN0YXRpYyBpbnQgYXRtZWxfcXNwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPiAgICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShhcS0+cXNwaWNrKTsNCj4gIGRp
c2FibGVfcGNsazoNCj4gICAgICAgICBjbGtfZGlzYWJsZV91bnByZXBhcmUoYXEtPnBjbGspOw0K
PiAtZXhpdDoNCj4gLSAgICAgICBzcGlfY29udHJvbGxlcl9wdXQoY3RybCk7DQo+IA0KPiAgICAg
ICAgIHJldHVybiBlcnI7DQo+ICB9DQo+IC0tDQo+IDIuMjkuMg0KPiANCg0K
