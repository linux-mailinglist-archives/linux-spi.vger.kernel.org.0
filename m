Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6C02DBCA6
	for <lists+linux-spi@lfdr.de>; Wed, 16 Dec 2020 09:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgLPI0X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Dec 2020 03:26:23 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:45611 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgLPI0X (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Dec 2020 03:26:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1608107182; x=1639643182;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3sRuO2VxQpoDD40IxFKyGCahCk/nGOxjtYiWiXXhiC4=;
  b=O8xaJDDunRE6YPD1rcGYvvmdD8nczOYuI2gYdRfExt585AQsUrdo26nI
   cDqRwWtcFXWmbgTIs9XmU/OTEyLAhsfR2XG7vIgloWXbTrDHcm+XfgZWU
   1BAESkVlZP5vtSGzGEdQt2T0LtJilCiYeNOLhcBaztxUA/DnvJL/lUCmN
   JVaTtGZe/y+N3W7NSs3n/n6IVO5LYyXDqc5aYZytVt87ZZANZ/03XsWmI
   G8iLgELZ73evn8923grze3TCdRgn7TljuXE8KMAaQGJdtey1ln1RgrJwp
   F0LXRfqq5q8dkTkmQ5/YqwSBdkIIuFj/F5LRrm2w/lvkUp4hpuq5xADFQ
   w==;
IronPort-SDR: pwoVg/gH0ru+GwBGgGHebCxzax1KUzEoVWfPrKbjMdTpq6dpwIdtWyyD/vTourWTuCdR3VEu6m
 TUnjfCZb7JBJRxZO67dUyuuxZFkkAMLoybwtBdRxwAuU7Oq3Ot0EpMllmzyUYZOeZcRqr1E1Kk
 4ggL3AtKLYHMs+yOaD09SATeq4mDZvKrbPDzwLQLzY2UxsFoq8Z/egPqREIbtbiUmNTCAM+dOs
 AZ9PjqHdJGrqOjWpUYoFsLURy3HhNKGP7U01GLdGpDrSgXUB3iWTtd43PHMO6HImXqoA5ZPahq
 huE=
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="102967404"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2020 01:25:07 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 16 Dec 2020 01:25:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 16 Dec 2020 01:25:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeIBOP8jkP1vNruv+f96aX9UL0i73t6SV59Nzp5U1PKHOzhjz4U21r4XS3h7FLl0XQ1FGLQRpLq32o+rITnOEIZJXZjawmqYoxO9njB8J+cCxwPi2xhubDeuI/f/Fm2QBpzmCKjGr7Y1ryRUK98qDl7UDYdOrjKzWlmLLEm9EUaJHO40a7RyidxRjnzxWK1tBujoEj73FGeM7HmB184Gxp6G80kK25F0YCXWfJTCXHi8Jf2/SDfWfvCe+J9COro40IIKeBIbMTaC3RsbvL5oDIQiuFA9MZD0YHwMn+FceR4yfW02z7EgDMFVaYBNCCoUU9exQq97e245HuFzU8RoAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sRuO2VxQpoDD40IxFKyGCahCk/nGOxjtYiWiXXhiC4=;
 b=gINOFwuOV4oiYgNqxc9x25V5RLTet12LhrpDc5bZEpAGjtlDJbRkxHeXNrx+uYxfbcZr7l/NGDspvc6y+WnKM4YvB3ozmc8Di/Z8Ag/XcwAPz3MvpYRZeRhSFDPqaZRZMixfMtj7tIEF7gng5hHgQpHRSxiPMdiqrpSVkGO1W5SEyn3Nr5MFS/k8txB6Z5A/nqGDedRSrKHTu7gA+iqH84Hxu7uqHR52uG5UQcf9Yo5O5rnCaAc9le7rS8zqWdMVEuLHjbO/GNrE6UxAwQs/1MEvc3AiF5JCz0qk2Ci9glA0EqUVJ5fHJ6GjERNEeP6P2/VkFS/5ZXkUuEYmFy5zlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sRuO2VxQpoDD40IxFKyGCahCk/nGOxjtYiWiXXhiC4=;
 b=R8qzj4Y4pWFSDJ8Qok3qlIoyOx5kRsDQJPYLwkyDtFH4Wsvs2Co+HYbH2sAtIh1VvkBtx7f1hEnaQBDIuMo8LBbw2C4l2rbg2Ar0ubP0MlCweVS+6Cc27hrBdz1THp3KcRqPKdmdV+Mcw+rRi38mOI/yxn2tULEJpJDftuawq4Q=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2783.namprd11.prod.outlook.com (2603:10b6:805:5a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 16 Dec
 2020 08:25:04 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761%7]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 08:25:04 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <geert@linux-m68k.org>, <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: Limit the spi device max speed to controller's max
 speed
Thread-Topic: [PATCH] spi: Limit the spi device max speed to controller's max
 speed
Thread-Index: AQHW04TzmHDw6aLncEO1O0nh7I/99A==
Date:   Wed, 16 Dec 2020 08:25:04 +0000
Message-ID: <b1b385eb-15f7-8347-a5e2-0a711937c879@microchip.com>
References: <20201209173514.93328-1-tudor.ambarus@microchip.com>
 <160770909978.26609.5466191880976694172.b4-ty@kernel.org>
 <CAMuHMdU+heMQKLZR15g5s5Ad-H8cDeFeM+7Wh=45PFqQhyfjOA@mail.gmail.com>
In-Reply-To: <CAMuHMdU+heMQKLZR15g5s5Ad-H8cDeFeM+7Wh=45PFqQhyfjOA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [79.115.63.137]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73c42cc9-447e-46dd-32a5-08d8a19c16b4
x-ms-traffictypediagnostic: SN6PR11MB2783:
x-microsoft-antispam-prvs: <SN6PR11MB278386A534C096A6DDE41A0CF0C50@SN6PR11MB2783.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CwC3TiBDe1wQTAdYrUXzpFgpAa5iwTJrJV7A+8oShdlX7ZpvbeqUFae7DpSw58cHJg8FGOy57chK6Fgmi9h5aW5RG5LJA6t2um54uu+qdLKCjFjWp2eE5jdoqt6eawBQmtBKYbD4Hhtr8AlfeUrR7KVNt12K6T+yb4EDDqat98fY+8/exSLN9a0dnHH8Wb4F7ZB8u/jZNv18bnApZTuBSPj1aAX1PeO2SGNRZxYAdviF99Ubr6E0nE/U/YHLzxGLoOmQnISfdmoL67dVGIuoL3FLu3yziO2+U0zbcM1mCtgUa3dUNqmAvRYGBVXs9E7aO3aVgSi3ewcGAMzsKb2nKkBHBov2VViCZW5sc65OEXkU1t8Vhqvq99TQPJgW/uLONjg52y4M8MW0U4JKzKxXQ2evD/9T5NScOgmdvQYxG50eaXjltrpcnFSVdEpbsSsfdnCadNH+CPJC0z0/RehKPRKM8DiqdV6pgDzuhA2n3VM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(39860400002)(136003)(376002)(478600001)(6486002)(2906002)(91956017)(8936002)(66476007)(110136005)(316002)(4326008)(26005)(5660300002)(31686004)(36756003)(71200400001)(8676002)(966005)(186003)(31696002)(54906003)(83380400001)(66446008)(6506007)(2616005)(53546011)(6512007)(86362001)(64756008)(66556008)(66946007)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?enU5aU5BQUlYcnNQU3FLTTZYWGtNU1liVEpDQ2ZIMys2T052MDBLeUNDMnJG?=
 =?utf-8?B?eHlNbTJCNjYvMXhlaXAreWEvZkZQWGZqdGhlUlF1azk3Zkx2Qi9lbnZTU2dE?=
 =?utf-8?B?N0NIdVpxS2dkVnF4ek8rNXdQSVoyQ0Joc1cvZWZ0WmwwdXJWZjV6anQzcDNq?=
 =?utf-8?B?YzlIVkVhTHdpZ3JEdUdrNTJLK2w2dTY1d3dWR1kya2s1TDdHV2ZJVmc1WXNT?=
 =?utf-8?B?L1FxMDZTSGVzQityTERob3hEQlFQYldDblRVK0p3Sy8rVVcvQ0grTmxwWVps?=
 =?utf-8?B?ZzR4OW1reUJ5SXlZd3gycXY5WEVTU21oNmZkQjJkUk5pZjFKUk1lMWY3VG1X?=
 =?utf-8?B?KzAvcmkrVS9qbDJaZ0hFVnVrMElBRzkvcUt0K2JBc1FlYkNhU0lMeUtDUG10?=
 =?utf-8?B?c2IxbTVNTmxIaUpmVDZPL0phRUx2SnAybTdGQ25GbzhhN2hkSDVLRHJGKys4?=
 =?utf-8?B?ZkZLNHZRSU02QWdCR3dSM2svczVhbjZIUzMyZHBFWjZBRDh4Z0tNcnVpa2du?=
 =?utf-8?B?aFJDWkVtWmladFNOU3NaZTBwVy9kNVRhdm9XQWFKOGcvSmI1TjVEaENaUzFk?=
 =?utf-8?B?cFdiQktkZ01zRnpneHM4b0xKRnphNU1hL29xMVV2R2k2aHR5SEQzSUdON2pz?=
 =?utf-8?B?YzBoZThPd0lJRDZCVXNIWURpRHZqMGlLNFdDODhKSkJjQUdHSGRjenRHcUhE?=
 =?utf-8?B?ZXFUVmloaFFTQkZSWWM5MkVYSjlwYnU5SHlvaDh1TGlYNWg0UDRJbTZ6ZmxI?=
 =?utf-8?B?eDlrUkpmQlBVMCs4Wno2MHhUaVFpSENIY0lENXJsQTEyVitnbXJRRUZhb2c0?=
 =?utf-8?B?eitCeHoxbzE1UytCczhvZmlydndQRWx1THI5anJXVGpVRENPTFczVUNaYjVH?=
 =?utf-8?B?Qm9BcU5FQkdkeldpMHFhWHRqWkNKRGp1d09tSzVuWmV5ZG1jZnBxVGVBL0da?=
 =?utf-8?B?S0t3ckttaFhJbXN4aG1ZaTFnc3ZFZlUzWFVoWVFYZkpsZ084VVZHd040a1A1?=
 =?utf-8?B?TTlqcmZodldEODl5aWd5L0NGcExUWmkwbkZXenNYUzBCakNRNG4rRlJCRDRX?=
 =?utf-8?B?dFk1ZGpaWmk3Mm9URzhiOHU1LzJ2MVlHVDRyQ21kb1EvaUxuVnhhMnViMXJX?=
 =?utf-8?B?RXpwRjV1Yi9XUzlYZVJwL1YxVjN2eEgvSmc3elJPSi9BQkJKdXY1WDZXd3Zo?=
 =?utf-8?B?MndoQ1dMVTlXbnY1NDQySzduc28xU2Y3NTdReS9qNWRjU3VnakdZaUV0d0pC?=
 =?utf-8?B?MDB1ckNuZU0rN0ZhM1lzVlFxbElrTnQxWjZYVy94VzRvcFE1TzBQSHd3bDRJ?=
 =?utf-8?Q?ZLzQgeWN8Z2iY=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4F667D68952D34A894B4FB16F6088C6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c42cc9-447e-46dd-32a5-08d8a19c16b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2020 08:25:04.0116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5s9MnQPizp+CwMhVWV06x/LfTUBgWu6+X1hkRp3WH+6crgLfl1ze1/xf1hJsmOCz8uTUAqwd556X17sbU+gJBHLnefKyYV0VrkOaPaQhnc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2783
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gMTIvMTUvMjAgNDoyNCBQTSwgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOg0KPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpIE1hcmssIFR1ZG9yLA0KDQpIaSwg
R2VlcnQsDQoNCj4gDQo+IE9uIEZyaSwgRGVjIDExLCAyMDIwIGF0IDg6MDIgUE0gTWFyayBCcm93
biA8YnJvb25pZUBrZXJuZWwub3JnPiB3cm90ZToNCj4+IE9uIFdlZCwgOSBEZWMgMjAyMCAxOToz
NToxNCArMDIwMCwgVHVkb3IgQW1iYXJ1cyB3cm90ZToNCj4+PiBNYWtlIHN1cmUgdGhlIG1heF9z
cGVlZF9oeiBvZiBzcGlfZGV2aWNlIGRvZXMgbm90IG92ZXJyaWRlDQo+Pj4gdGhlIG1heF9zcGVl
ZF9oeiBvZiBjb250cm9sbGVyLg0KPj4NCj4+IEFwcGxpZWQgdG8NCj4+DQo+PiAgICBodHRwczov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9icm9vbmllL3NwaS5naXQg
Zm9yLW5leHQNCj4+DQo+PiBUaGFua3MhDQo+Pg0KPj4gWzEvMV0gc3BpOiBMaW1pdCB0aGUgc3Bp
IGRldmljZSBtYXggc3BlZWQgdG8gY29udHJvbGxlcidzIG1heCBzcGVlZA0KPj4gICAgICAgY29t
bWl0OiA5MzI2ZTRmMWU1ZGQxYTQ0MTBjNDI5NjM4ZDNjNDEyYjZmYzE3MDQwDQo+IA0KPj4gLSAg
ICAgICBpZiAoIXNwaS0+bWF4X3NwZWVkX2h6KQ0KPj4gKyAgICAgICBpZiAoIXNwaS0+bWF4X3Nw
ZWVkX2h6IHx8DQo+PiArICAgICAgICAgICBzcGktPm1heF9zcGVlZF9oeiA+IHNwaS0+Y29udHJv
bGxlci0+bWF4X3NwZWVkX2h6KQ0KPj4gICAgICAgICAgICAgICAgIHNwaS0+bWF4X3NwZWVkX2h6
ID0gc3BpLT5jb250cm9sbGVyLT5tYXhfc3BlZWRfaHo7DQo+IA0KPiBJZiBzcGktPmNvbnRyb2xs
ZXItPm1heF9zcGVlZF9oeiBpcyB6ZXJvLCBhIG5vbi16ZXJvIHNwaS0+bWF4X3NwZWVkX2h6DQo+
IHdpbGwgYmUgb3ZlcndyaXR0ZW4gYnkgemVyby4NCj4gDQoNCm9oLCB5ZXMsIHlvdSdyZSByaWdo
dC4NCg0KPiBIZW5jZSB0aGlzIGJyb2tlIHNwaS1zaC1tc2lvZiwgd2hpY2ggaGFzIHRoZSBmb2xs
b3dpbmcgY2hlY2sgaW4NCj4gc2hfbXNpb2Zfc3BpX3NldF9jbGtfcmVncygpOg0KPiANCj4gICAg
ICAgICBpZiAoIXNwaV9oeiB8fCAhcGFyZW50X3JhdGUpIHsNCj4gICAgICAgICAgICAgICAgIFdB
Uk4oMSwgIkludmFsaWQgY2xvY2sgcmF0ZSBwYXJhbWV0ZXJzICVsdSBhbmQgJXVcbiIsDQo+ICAg
ICAgICAgICAgICAgICAgICAgIHBhcmVudF9yYXRlLCBzcGlfaHopOw0KPiAgICAgICAgICAgICAg
ICAgcmV0dXJuOw0KPiAgICAgICAgIH0NCj4gDQo+IFdpdGhvdXQgdGhpcywgdGhlIGRyaXZlciB3
b3VsZCB0cmlnZ2VyIGEgZGl2aXNpb24tYnktemVybyBsYXRlci4uLg0KPiANCj4gQXJndWFibHkg
YWxsIFNQSSBjb250cm9sbGVyIGRyaXZlcnMgc2hvdWxkIGZpbGwgaW4NCj4gc3BpX2NvbnRyb2xs
ZXIue21pbixtYXh9X3NwZWVkX2h6LCBidXQgYXMgbG9uZyBhcyB0aGF0IGlzIG5vdCB0aGUgY2Fz
ZSwNCj4gSSB0aGluayB0aGlzIHBhdGNoIHNob3VsZCBiZSByZXZlcnRlZCwgb3IgdGhlIGNoZWNr
IHNob3VsZCBiZSBlbmhhbmNlZA0KPiB0byBtYWtlIHN1cmUgc3BpLT5jb250cm9sbGVyLT5tYXhf
c3BlZWRfaHogaXMgbm9uLXplcm8uDQo+IA0KDQpJJ20gZmluZSBib3RoIHdheXMsIHNpbmNlIHRo
aXMgc2hvdWxkIGJlIGltcHJvdmVkIGFueXdheS4gV2lsbCBzZW5kIGEgcGF0Y2gNCndpdGggdGhl
IG5vbi16ZXJvIGNoZWNrIGFuZCBhZGQgeW91ciBSZXBvcnRlZC1ieSwgU3VnZ2VzdGVkLWJ5IHRh
Z3MsIGluIGNhc2UNCk1hcmsgZGVjaWRlcyB0byBrZWVwIGl0Lg0KDQpDaGVlcnMsDQp0YQ0KDQo+
IEdye29ldGplLGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQN
Cj4gDQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXgg
YmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNvbmFsIGNv
bnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2Vy
LiBCdXQNCj4gd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9n
cmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzDQo+IA0KDQo=
