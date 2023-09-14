Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834487A003F
	for <lists+linux-spi@lfdr.de>; Thu, 14 Sep 2023 11:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbjINJh1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Sep 2023 05:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237020AbjINJh0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 Sep 2023 05:37:26 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2124.outbound.protection.outlook.com [40.107.113.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F29BBB;
        Thu, 14 Sep 2023 02:37:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lozWPPcbQRwiLp5Pgqa4lIbNx4g9tHH3tTDI9Qe7AIcUiFFlZhXYfQIZQJFKLiS17c7vTeNj1mx0wYUOnYSKFmsWANwpaIet5yxRfovPGqwxUhnariF5mQ41qtOhQjBVYb6F3vaawukwD0A5FGdl1BF8nhlYS2fxqCw9Po3e1LZbKYyVSSncDX9c2K79kIAvUDdEzR+VuQH8MnYZR7juoNM3CORx6PJfQ9RBCtRaXTbYco8tF7FAoh5StsKmJ/7kMBmnHzmOS/uza9YteJx8jheM6UBXL1Ls0hDv97PBR1d+/TyTHgxbF913oyXMAvR/20ndkDReaslI8LAiyk0c4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoOvW+1GQBFDj+wIOt0goCNngXg3S73j7kwdAsZJly8=;
 b=V/12jb7owksSS7RmFhfkqlfbkJXnpUyrj9qTmGY2gIzFdYpPAOQhyc4FZYYfvtD/tqI/Hs0kCWfum9KRfMBKQqOA0Xn0bhRfjerVWTZv+WlSK9m1b15dYi1vFeZnkGxZhfwIJT9G5mnWG2kg+Q783QWvXSxwMKa/IuwVH/d3OBVWF3Fcxo2yxPQrl/SWyNh8ncN3ClLwX+H4qgr8C7OO3K5XBrjWduYQz96zQP3MaGFAyxrVx7y0pBvd2D22CW2iPuTTPfPve84yrS0EQoaJG5KOM86xnwNGvOjVGmEKSXVui2+3sm2y80l5a3bwiDJK6jMgMl4TdrUMJGDxFkkQjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoOvW+1GQBFDj+wIOt0goCNngXg3S73j7kwdAsZJly8=;
 b=IFP4G9VT+DS8Y9a1aKs+1KMGkgQBtvQ54O/2fI9jDjuvwzvrxO7RUA4WyAgRIS7fPfPe4fDzTkY3+ADnj7jrJdM7kpq/JWtb7gm4FHwk2sx96e6iNN+as3TIs8y1WeiJE6IB3qDMWFzVx2ny7D0fw7hhJHuEAyXnEQcNGNze64A=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB11207.jpnprd01.prod.outlook.com (2603:1096:400:3bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 09:37:18 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 09:37:18 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: RE: [PATCH] memory: renesas-rpc-if: Fix IO state based on flash type
Thread-Topic: [PATCH] memory: renesas-rpc-if: Fix IO state based on flash type
Thread-Index: AQHZ21J3se5Zb26g9EyYNYpYnGOcfLAC8SaAgAAAdzCAFx0SAIAAB1IAgAAG7YCAAAE7gIAAAjsAgAADP4CAAAIPYA==
Date:   Thu, 14 Sep 2023 09:37:18 +0000
Message-ID: <OS0PR01MB5922B4BF11D1954DFBE2976F86F7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230830145835.296690-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdV1qvypo1XmHBXV5Q1SHEhksMN3SxgweYxPu+=ZeDmg1A@mail.gmail.com>
 <TYCPR01MB5933571F06789BFF27A8FCC786E6A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <502336e9-2455-f3f6-57d1-807bc4b71f7f@linaro.org>
 <CAMuHMdWO8EdbxXetmc9-2jhZWeX1b_J74O0exo1Q85X9Gbc_SA@mail.gmail.com>
 <20230914105937.4af00bf2@xps-13>
 <CAMuHMdX8Vg2M2K3U_sbAtVk+6VDvL+GNYtbs5FTTRZzRvVGPCQ@mail.gmail.com>
 <20230914111200.6e6832ca@xps-13>
 <CAMuHMdVryt5bTk8HeFMS3NU-4EpQdU3Tf6LiGmGQQ5bVD-Emsg@mail.gmail.com>
In-Reply-To: <CAMuHMdVryt5bTk8HeFMS3NU-4EpQdU3Tf6LiGmGQQ5bVD-Emsg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB11207:EE_
x-ms-office365-filtering-correlation-id: 002c43fa-2602-4a79-f2f9-08dbb5062fe6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wwQfhvhnOKRxoEgygKI+z7Xu1mP6UG2v8gc1Zb63mnrUYxcqZGI6ImS0J02qRjHkiczWYd7yAxMhWC95N/6Uii5SLFqLvpZjjSiZoJnXh75uFYE0x7sklJKJ1xtYwbFs5Ip0MKZ+U79MmxmjQvsbLHrNkmoNGBPiS+O5bliKPaSh9pSHBMuDcCMUShajRiWpTDSXW9fy/Wzf83YK4gDXLbBjj6p0y9fNN3RQEN9v/ZCbUUErtwsYS0rWb6wJtWlPLpiY5LnQWPueSYxa8rMALpEBcATrNnEy/8qp6LkiRMYGoytMr+Irp1U4NuU0aSuQM7IsuCCRn3eppdsTFgHIxLJsk7zdzsnbTUpNp7S9swK5e9fRUS1aRUMmAkSfrjmhZIPpr/EQ2zRQO8IoiX1YI4BGMQYVEaUKltk4z/JmcDJnVfus9XYTMXzCJeykrdq+URsDRkutLjcnTVQsGe2AyiR762zAzeyS0wE3e0LTWv3rNIxqoMqEd+ws1+zEoYVLZgdiy/ER6Fm9D6+KxA6Z0nTBLF96Gus+ekFRRgDkBMxqQZ2SqzGnJ53L+B01qrXF/xXuQLvyZjEmX++Rk3biL/yGG/zd3FS3yV4Xfmpx06qUtbaGHycazVwhjhKByl3Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(186009)(1800799009)(451199024)(83380400001)(53546011)(9686003)(86362001)(71200400001)(38100700002)(122000001)(38070700005)(7696005)(110136005)(76116006)(55016003)(6506007)(478600001)(26005)(8676002)(4326008)(52536014)(7416002)(316002)(66556008)(41300700001)(64756008)(5660300002)(54906003)(66446008)(66476007)(8936002)(33656002)(66946007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VThFZ3FmZlRkWkhISXZSbEdpWWtHalJSZ1kyeEtuK083NU1DWERJeUhNOUh3?=
 =?utf-8?B?d1V0eWhoa3ZjenJObU9EQ0tJUnFGM3RRSldkWlRxOWFNRkh3UmZaMTI5V3Bt?=
 =?utf-8?B?RmxhaTQ1TzBxdzdkbFQ1dnZFQnU1WFQ4YXNLT0R5MmRzQkZrYW1EKy9DUHRv?=
 =?utf-8?B?a1RIQjRReXJMTUlsUFM4N0VRcGNxYmpJUWJzRmVWRjI1Z0dwQTU1UENFbTY5?=
 =?utf-8?B?Mmt1QW5ybytxdGlvQVViSFJ3ZURVdFRIV1I5YmFIS1RQWCtieXFRZ21yY0Yz?=
 =?utf-8?B?bWFtNnIzVUlSb1U0Zi8yTStnak1pYjZITm1mRU5IdzBwemJHdTloSVh5QjFq?=
 =?utf-8?B?Q2dJL20yZUxDUVY1S1hObTBvOWN5ZWdvRkZoV1l1WldkOFpYTDRzSGZXVnB0?=
 =?utf-8?B?Yjdhd2FuL0JMamdiTFhkcWxNaGE3RmlvNlVDWnlDM3Zmak9vbHVWSWk0RzJI?=
 =?utf-8?B?M2pkM1YxWmVMREc0eHdCK3BmMCtKcjRhSHFWNDlTWjhXanJvdGxvN050NXVM?=
 =?utf-8?B?NkRjdjNjdG14S1NOZDFWRjdIdjE4STVHVTh5eEhSN1VJQU92YXMxRW5rVml5?=
 =?utf-8?B?QVZaaEJhYmdKSFdKV2RQdTljUHcreFlZRlpzdlY1ZjI5eFloRlZNRVlJeVNF?=
 =?utf-8?B?b2tBdHpzYWZqcHZjTk1uZFdsOGEyWVJoTng3T21TN0hsWnhDdXhJZk5LRzds?=
 =?utf-8?B?VSs4ZkhNU3g0MUtWOXVBUjZSV29RbEVqY0lVbGxaN0ZYMjIwQ2NIdzNtZFcv?=
 =?utf-8?B?U1F2MkJSNmJySENEMXFyYTdpTTU3V2VQZ2NXeUlGbU1Nb2RhWkFrSmZFNGRT?=
 =?utf-8?B?RWgyeWRDbVVkYjAwREswZEdISnlyN1FrQnBmMzJYQWZaRlBpMDd5RCt4T3ZP?=
 =?utf-8?B?U013bUw2T0dzd2ZtSFM0czIvMjJJTWlYbk52NHJwOVFoWmxtOXAza1JsN3lY?=
 =?utf-8?B?SXR6QmdOKytvZ1M5Y3AxdnZzbHgvUXRIZWY0eTlxbTgza2xEMmw0T3o3UjBx?=
 =?utf-8?B?VC9ZOVpZTmVFa1czNzVlRHdUZUlFbG9DUWF3MG5IMjZ3TlZ5RTBvdVp6bmpB?=
 =?utf-8?B?dzVsRkhOdlBiYUprMW5NWmNaOUU1OEt4S0FqVXUvUzBjUDdIQmdOSXZ4OEVo?=
 =?utf-8?B?cjNKTnZJVlJkSmVPQXhETkoxdzMxUUFXblBwOXFPd2dEeXo3c3diZ0ZiSGRv?=
 =?utf-8?B?bUpycUZFK1U3bjFsTlBHSjZGY1ZHVGdlNjBaRTFaK200STdwdVZMS0x6N2lu?=
 =?utf-8?B?WU9WQWIwL2ZXTm80dDFQRmxhUEc2OUwzam4wK1VtUEhjVUQ2RGVBdllWanlS?=
 =?utf-8?B?d1ZvWE1YbDZ5N0VhcVNoaTFJakwvMzVKTWJnM1RPT2tKWVQvU1pCVkVEOE9l?=
 =?utf-8?B?RFdIR2hDcWdnTlJMR2ZrUUwzWU9OWWtLOVVuRTBvSys4SGtteFQ4eXRWbmtZ?=
 =?utf-8?B?NjduNE5xMW85bUkrbzNoU2lBeTJ1VHd1WWdDcjFNeEFpZ1oycUlCejBqM3N5?=
 =?utf-8?B?cngyVi9JZE1qS3YybER4b1lRVnV2RHlta2djOU85NGhIRm9xRFFUZE51VVBw?=
 =?utf-8?B?MjBkdXc5eVg4SDF4TVFEazR5anZQczNHcThYLzM3VkRqb0pFYVpLSW5OKzY0?=
 =?utf-8?B?UWl4VkpOcE5KRmdiL0c4WlRnZkhmMWQrSU9aQUY0YWtBSk8zKzd0R21TWEYz?=
 =?utf-8?B?M0NzZFZ3cTdNbHVNdVdUZ00yOFd6emxTaHNudFMvMkxXZHk5bWNDVk56K3FR?=
 =?utf-8?B?VnNCbXpjWmVDU1VnREZKb01ienBkLzNzODR0VURiV3pwU2hYSUUzRm1LZ0gz?=
 =?utf-8?B?SFhMNGg4eUxlbEd0QlVCS3hwRitWcHhtOEdGZkhBbkpnbjlHQ2tpOU1GMVlD?=
 =?utf-8?B?cE4zMk80VXFEV3Ywc3JGTHlDVS9hNnhYQ3pIT05FQmpJRWIycVhQN28yVmNF?=
 =?utf-8?B?bmUzdVJpV3J3OW1Wa2NndnFkRWVERmtDZWlNcmVySUI0SVpBeUVTemsybDho?=
 =?utf-8?B?QkFFRXkxQmFOdGc2OHV4VHY2VVcxdTFoZ29VZkNpSkZ5TytyZjhlc0srS3VC?=
 =?utf-8?B?MDFJNXhpTndaaG4vOUtKRXZQc2xQcWV2bWZwVHZhY2pkbjFMV2xzdHhxbHZr?=
 =?utf-8?B?VCt6dDhHMkNTcGFpTHRLTGZwNFJNcEFDVllzNXQwNFdhUklZQTkrdkwxUnV4?=
 =?utf-8?B?cXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 002c43fa-2602-4a79-f2f9-08dbb5062fe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 09:37:18.1080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c6x+c74Vr/G+nRG5ZpYUxwrX3LxHikiccCLVPS0g99bjMS5MSL3kDvOqog5XeQz5RaxYKZtTFocY5xmDybxgJPFUbd55Ag1Obz+QeyHfwXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11207
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIG1lbW9yeTogcmVuZXNhcy1ycGMtaWY6IEZpeCBJTyBzdGF0ZSBiYXNlZCBvbiBmbGFz
aA0KPiB0eXBlDQo+IA0KPiBIaSBNaXF1ZWwsDQo+IA0KPiBPbiBUaHUsIFNlcCAxNCwgMjAyMyBh
dCAxMToxMuKAr0FNIE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+
IHdyb3RlOg0KPiA+IGdlZXJ0QGxpbnV4LW02OGsub3JnIHdyb3RlIG9uIFRodSwgMTQgU2VwIDIw
MjMgMTE6MDQ6MDEgKzAyMDA6DQo+ID4gPiBPbiBUaHUsIFNlcCAxNCwgMjAyMyBhdCAxMDo1OeKA
r0FNIE1pcXVlbCBSYXluYWwNCj4gPiA+IDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPiB3cm90
ZToNCj4gPiA+ID4gZ2VlcnRAbGludXgtbTY4ay5vcmcgd3JvdGUgb24gVGh1LCAxNCBTZXAgMjAy
MyAxMDozNDo1MCArMDIwMDoNCj4gPiA+ID4gPiBPbiBUaHUsIFNlcCAxNCwgMjAyMyBhdCAxMDow
OOKAr0FNIEtyenlzenRvZiBLb3psb3dza2kNCj4gPiA+ID4gPiA8a3J6eXN6dG9mLmtvemxvd3Nr
aUBsaW5hcm8ub3JnPiB3cm90ZToNCj4gPiA+ID4gPiA+IE9uIDMwLzA4LzIwMjMgMTc6MTgsIEJp
anUgRGFzIHdyb3RlOg0KPiA+ID4gPiA+ID4gPj4+ICAgICAgICAgICAgICAgICByZWdtYXBfdXBk
YXRlX2JpdHMocnBjLT5yZWdtYXAsDQo+ID4gPiA+ID4gPiA+Pj4gUlBDSUZfQ01OQ1IsIEBAIC03
NzQsNg0KPiA+ID4gPiA+ID4gPj4+ICs3NzYsMTIgQEAgc3RhdGljIGludCBycGNpZl9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ID4gPiA+ID4gPiA+Pj4gKypwZGV2KQ0KPiA+ID4gPiA+
ID4gPj4+ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ID4gPiA+ID4gPj4+ICAgICAg
ICAgfQ0KPiA+ID4gPiA+ID4gPj4+DQo+ID4gPiA+ID4gPiA+Pj4gKyAgICAgICBpZiAocnBjLT5p
bmZvLT50eXBlID09IFJQQ0lGX1JaX0cyTCAmJg0KPiA+ID4gPiA+ID4gPj4NCj4gPiA+ID4gPiA+
ID4+IFdvdWxkbid0IHRoaXMgYXBwbHkgdG8gbm9uLVJaL0cyTCBzeXN0ZW1zLCB0b28/DQo+ID4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEl0IGFwcGxpZXMsIGlmIHRoZSBkZXZpY2UgdXNlcyB0
aGUgZmxhc2hbMV0gb3IgWzJdIGFuZCBpdA0KPiA+ID4gPiA+ID4gPiBuZWVkcyA0LWJpdCB0eCBz
dXBwb3J0Lg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEdlZXJ0LA0K
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IERvZXMgaXQgYW5zd2VyIHlvdXIgY29tbWVudCBvciBk
byB5b3UgZXhwZWN0IGhlcmUgc29tZSBjaGFuZ2VzPw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gV2Vs
bCwgbm93IGl0IGhhcyBiZWVuIGNvbmZpcm1lZCB0aGlzIGFwcGxpZXMgdG8gbm9uLVJaL0cyTA0K
PiA+ID4gPiA+IHN5c3RlbXMsIHRvbywgdGhlIGNoZWNrIGZvciBSUENJRl9SWl9HMkwgc2hvdWxk
IHByb2JhYmx5IGJlDQo+ID4gPiA+ID4gcmVtb3ZlZC4gIEluIHVwc3RyZWFtLCBvbmx5DQo+ID4g
PiA+ID4gYXJjaC9hcm02NC9ib290L2R0cy9yZW5lc2FzL3J6ZzJseyxjfS1zbWFyYy1zb20uZHRz
aSBoYXZlDQo+ID4gPiA+ID4gZGV2aWNlcyB0aGF0IGFyZSBjb21wYXRpYmxlIHdpdGggIm1pY3Jv
bixtdDI1cXU1MTJhIiwgYnV0IG9idmlvdXNseQ0KPiB0aGV5IGNhbiBhcHBlYXIgZWxzZXdoZXJl
LCB0b28uDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBOb3csIHRoZSBwcmVzZW5jZSBvZiB0aGF0IGNv
bXBhdGlibGUgdmFsdWUgaW4NCj4gPiA+ID4gPiByemcybHssY30tc21hcmMtc29tLmR0c2kgY3Vy
cmVudGx5IGNhdXNlcyBhIGR0YnNfY2hlY2sgd2FybmluZywgYXMNCj4gaXQgaXMgbm90IGRvY3Vt
ZW50ZWQuDQo+ID4gPiA+ID4gSG93ZXZlciwgdGhlcmUgaGFzIGJlZW4gc29tZSBwdXNoYmFjayBh
Z2FpbnN0IGFkZGluZyBtb3JlDQo+ID4gPiA+ID4gY29tcGF0aWJsZSB2YWx1ZXMsIGNmci4gbXkg
cGF0Y2ggdG8gYWRkIG10MjVxdTUxMmFbMV0sIGFuZCBNaXF1ZWwncw0KPiBjb21taXQgWzJdLg0K
PiA+ID4gPg0KPiA+ID4gPiBKdXN0IEZZSSwgSSBzZW50IFsyXSBhZnRlciBhbiB1bnN1Y2Nlc3Nm
dWwgYXR0ZW1wdCB0byB1cGRhdGUgdGhhdA0KPiA+ID4gPiBsaXN0IHRvbywgc2VlIFszXS4gVGhl
IGlkZWEgaXM6IGlmIHlvdSBkb24ndCBoYXZlIGFueXRoaW5nIHVzZWZ1bA0KPiA+ID4gPiB0byBh
ZGQsDQo+ID4gPg0KPiA+ID4gT2gsIEkgZGlkbid0IGtub3cgdGhhdC4NCj4gPiA+DQo+ID4gPiA+
IGp1c3QgdXNlIHRoZSBnZW5lcmljIGNvbXBhdGlibGUuIElmIHlvdSBuZWVkIHNwZWNpZmljIGNo
YW5nZXMsIHlvdQ0KPiA+ID4gPiBjYW4gYWRkIGFuIGVudHJ5Lg0KPiA+ID4NCj4gPiA+IFRoZSBw
cm9ibGVtIGlzIHRoYXQgdXN1YWxseSB0aGVzZSB0aGluZ3MgYXJlIGRpc2NvdmVyZWQgdG9vIGxh
dGUsIHNvDQo+ID4gPiB0aGUgb25seSBwcnVkZW50IHdheSBpcyB0byBiZSBwcm9hY3RpdmUsIGFu
ZCBhbHdheXMgYWRkIHRoZW0uDQo+ID4gPiBJbml0aWFsbHkgSSB0aG91Z2h0IHRoYXQgdGhlIGRp
ZmZlcmVudCBoYW5kbGluZyBvbiBSWi9HMkwgd2FzIGR1ZSB0bw0KPiA+ID4gYSBkaWZmZXJlbmNl
IGluIHRoZSBSUEMtSUYgYmxvY2suICBCdXQgbm93IHdlIGtub3cgaXQncyBkdWUgdG8gdGhlDQo+
ID4gPiB0eXBlIG9mIEZMQVNIIGF0dGFjaGVkLg0KPiA+DQo+ID4gQWN0dWFsbHkgd2hhdCBJIHNh
eSBpcyB3cm9uZywgd2UgYXJlIG5vdCBzdXBwb3NlZCB0byB0b3VjaCB0aGF0IGxpc3QNCj4gPiBh
bnltb3JlIGFuZCBwcmVmZXIgdG8gaGFuZGxlIHRoZSBpc3N1ZXMgaW4gdGhlIGRyaXZlcnMgYnkN
Cj4gPiBhdXRvLWRpc2NvdmVyeS4gQ2FuJ3Qgd2UgZG8gdGhhdCBpbiB5b3VyIGNhc2U/DQo+IA0K
PiBJJ20gbm90IHN1cmUgd2UgY2FuIGRvIHRoYXQsIGFzIHRoaXMgY29kZSBpcyBwYXJ0IG9mIHRo
ZSBoYXJkd2FyZQ0KPiBpbml0aWFsaXphdGlvbiBkdXJpbmcgcHJvYmluZy4NCj4gQmlqdTogaXMg
dGhpcyBuZWVkZWQgdGhhdCBlYXJseSwgb3IgY2FuIGl0IGJlIGRvbmUgbGF0ZXIsIGFmdGVyIHRo
ZQ0KPiBjb25uZWN0ZWQgZGV2aWNlIGhhcyBiZWVuIGlkZW50aWZpZWQ/DQoNCkkgbmVlZCB0byBj
aGVjayB0aGF0LiANCg0KWW91IG1lYW4gcGF0Y2ggZHJpdmVycy9zcGkvc3BpLXJwYy1pZi5jIA0K
dG8gaWRlbnRpZnkgdGhlIGZsYXNoIHR5cGUgZnJvbSBzZmRwIGluZm8gYW5kIHBhc3MgYXMgYSBw
YXJhbWV0ZXIgdG8gcnBjaWZfaHdfaW5pdD8/DQoNCkNoZWVycywNCkJpanUNCg==
