Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB282A9404
	for <lists+linux-spi@lfdr.de>; Fri,  6 Nov 2020 11:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgKFKVP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Nov 2020 05:21:15 -0500
Received: from mail-eopbgr1320124.outbound.protection.outlook.com ([40.107.132.124]:6167
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726646AbgKFKVO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 6 Nov 2020 05:21:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRtxju3HDST9jf7Md2whnS1fwp+J8IlgNneL+z5RRDlyZifNhGLwNFfcwAqQf6ikby49b8ptIOUzk/TvSTPwMAGXr/3A1a8/oPpUzL9GhKAzpOlvC8xbWZxA+3HcTKMS9zA62y8wFB4eUqT76BP5EtBvvi3XqNYOnWg2WkS9+JFAkVGqnpuFuhUgdEVaWcncdkFWI1v/qfp6Vaz+aXUBcBmmXQy4DEviBBaIyozdLepavecd5mbDHiJKnDgCBtMv9L2sNyqO1uEXpsy7jeLdafH0hza+eRNIp7uSoFb154He7IyZ6xHclmnySjuOUpkz+rB0rkUWe4oXCu5LADRQyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GBrQ7m+w6b4uupWDcfQUQqFmFAXf/4aQX6o4Xuasbo=;
 b=GB+vQ8RKiS5pWdVpZxo5trM8IHG5KxAdCfRYjnrumo0pj5c7yLugs3b8SJ/ll3d5ZeGEZ7eZxGfhgyGY6v0mjRUxufIYTM02dbUfH2B+nz0ijUmdViWiC10ury3lYtkcjkqGoOUk2t4jDfN7/FNZvjEpHCyLAiyB3I6MVEc2KWPAoyrW1m2eiQfh7TH3MdmZZFlDVaij8G/GrrAh7YhJN1k2ep8H1MxB+7KTlHyn4plCdt/u/H/ZQG4yuZ+S2NYnZXCO/jDy9mIlJ0wEzW3ND3wx0X8cbn2jSg0L5mZO62JK1ENA2VNAHjJUUyRfbfBDk4liO65e2KjNmToLZvEF/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from HK0PR06MB2786.apcprd06.prod.outlook.com (2603:1096:203:5b::22)
 by HK0PR06MB2196.apcprd06.prod.outlook.com (2603:1096:203:4b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 6 Nov
 2020 10:21:07 +0000
Received: from HK0PR06MB2786.apcprd06.prod.outlook.com
 ([fe80::c9cf:b4b1:3371:d532]) by HK0PR06MB2786.apcprd06.prod.outlook.com
 ([fe80::c9cf:b4b1:3371:d532%7]) with mapi id 15.20.3499.033; Fri, 6 Nov 2020
 10:21:06 +0000
From:   Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller driver
Thread-Topic: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller
 driver
Thread-Index: AQHWs2u0IlfHv/sBxE+PVdt+kUjCzqm5k6CAgAARawCAARRtAIAAF66AgAAC9KA=
Date:   Fri, 6 Nov 2020 10:21:06 +0000
Message-ID: <HK0PR06MB27865F0C5B2A4F680ED0D400B2ED0@HK0PR06MB2786.apcprd06.prod.outlook.com>
References: <20201105120331.9853-1-chin-ting_kuo@aspeedtech.com>
        <20201105120331.9853-5-chin-ting_kuo@aspeedtech.com>
        <fd8fa472-53bb-c992-3dc2-5a984a439c07@kaod.org>
        <20201105161132.37eb3265@collabora.com>
        <HK0PR06MB2786DAC99A56EA302EE969CAB2ED0@HK0PR06MB2786.apcprd06.prod.outlook.com>
 <20201106100539.62fc5249@collabora.com>
In-Reply-To: <20201106100539.62fc5249@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: collabora.com; dkim=none (message not signed)
 header.d=none;collabora.com; dmarc=none action=none
 header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67f6d1aa-891d-484a-030b-08d8823dac43
x-ms-traffictypediagnostic: HK0PR06MB2196:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB2196BB18DB0CBF056097FB90B2ED0@HK0PR06MB2196.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vfMMLjP2Dn1H1pUjqV2bBzLDG7+r/8JMz683wk6GC6HfupRkuYJEo92Hf0w2qlHC0OdWQEG/RIXRArpwS+3IGK60eVLpC/GD4NIAhesU+o4TGBcpYY2kINkmMS5u6zi9+u7L9AgdPOdRPQoIUnVN9SnHfHLXmhuziftGbS6Z/NZo7w6phJ0uFyeNtEG6XQ0KI6A8EiKKpb0IKu0n+esWEQ11Rm27kju0BRE47rqwYMokygMiZvHe7XUl9aQvscN3KAL9z8AKKpyNSteXqXzhxfmGQEHfZlqimTqG+t83PuwDt940P6N7FcSdctw+A7LSA3h8Bvia75AIdrLawRbmKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB2786.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(366004)(376002)(39840400004)(7696005)(52536014)(186003)(64756008)(66476007)(66446008)(55236004)(66946007)(66556008)(76116006)(71200400001)(6506007)(2906002)(6916009)(86362001)(8936002)(5660300002)(9686003)(7416002)(54906003)(478600001)(55016002)(8676002)(33656002)(316002)(83380400001)(4326008)(53546011)(66574015)(107886003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: X0ClNOuxu94ZgZvucjHFJxG6llaPePLE/Fw2zrEf8aRwnqn/QJhz1QPL9SlSwSP+sjAgI/86Lp09ibDBkunwD1YNoDCBivCWj/Rs9AH9Dm5uR/BI5OGCrQlcdYOWchPEFNIMNZ/Y79VLkN2sAPvJrnV3ucGUVS+J6Cppr+qgQtF5Yv5JNgYp2uCoYEALZCjhlpRqUzh4NFWkprU8Q2n/MrqxPJlyGn7fyYBF1I0yI+Cl8Y8P69xH5N2bNKPf2n7IqO7VjG6emi0xkPtEQ442Cm7ALi/L3gWJuzIZBgxc/4r510PNgY9BhkSDulL8xx8/QJRwfjkWOzw9Xgt5TVuh2VMA83g7TGYNG8sFhO7DlP5IAb37Wj8+bLcoZ0wqORgOmrf8jSusA4ifq0W1yv5Q1GmghbHUoPW8QYv5+xrhMbk3NqaBR43aFbrJ/+pkU8g1cj9pl39y+EPW7XZFz3CkSv7uDbT8Ok1U1o7ZY5dY4uesiHTomMLS77Wt67PRPFZHRnn6QsO6A8g8jAaUSqP4B4WS7VHsv61dgTwQwY1wMCogdwg19D11UAOpZ6OGRKc+GZEnbthsdKsYFP96QNIdlRVbqPZ2Xb2Ew9FAOJTYUXlyYs+aL7QibykdVAM9FErNCrIxxce6Hss+PwLu5EBprQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB2786.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f6d1aa-891d-484a-030b-08d8823dac43
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 10:21:06.6384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CCxE3OT/LzV6BZv3SZK0h5SXOu+JxnvqH5wXojkmr4RdmJZRw/PGOk+hPVJ+d+7GmAaHmtoUbbucDBlpYd+sDfzeyFUVF/PocKckQaX++lk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2196
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgQm9yaXMsDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cyBhbmQgc3VnZ2VzdGlvbnMuDQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXMgQnJlemlsbG9uIDxi
b3Jpcy5icmV6aWxsb25AY29sbGFib3JhLmNvbT4NCj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciA2
LCAyMDIwIDU6MDYgUE0NCj4gVG86IENoaW4tVGluZyBLdW8gPGNoaW4tdGluZ19rdW9AYXNwZWVk
dGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbdjMgNC80XSBzcGk6IGFzcGVlZDogQWRkIEFTUEVF
RCBGTUMvU1BJIG1lbW9yeSBjb250cm9sbGVyDQo+IGRyaXZlcg0KPiANCj4gT24gRnJpLCA2IE5v
diAyMDIwIDA4OjU4OjIzICswMDAwDQo+IENoaW4tVGluZyBLdW8gPGNoaW4tdGluZ19rdW9AYXNw
ZWVkdGVjaC5jb20+IHdyb3RlOg0KPiANCj4gPiBIaSBCb3JpcywNCj4gPg0KPiA+IFRoYW5rcyBm
b3IgeW91ciBxdWljayByZXBseS4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPiA+IEZyb206IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9uQGNvbGxhYm9y
YS5jb20+DQo+ID4gPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgNSwgMjAyMCAxMToxMiBQTQ0K
PiA+ID4gVG86IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+OyByb2JoK2R0QGtlcm5l
bC5vcmcNCj4gPiA+IENjOiBDaGluLVRpbmcgS3VvIDxjaGluLXRpbmdfa3VvQGFzcGVlZHRlY2gu
Y29tPjsNCj4gPiA+IGJyb29uaWVAa2VybmVsLm9yZzsgam9lbEBqbXMuaWQuYXU7IGFuZHJld0Bh
ai5pZC5hdTsNCj4gPiA+IGJicmV6aWxsb25Aa2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc7DQo+ID4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hc3Bl
ZWRAbGlzdHMub3psYWJzLm9yZzsNCj4gPiA+IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7IEJN
Qy1TVyA8Qk1DLVNXQGFzcGVlZHRlY2guY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFt2MyA0LzRd
IHNwaTogYXNwZWVkOiBBZGQgQVNQRUVEIEZNQy9TUEkgbWVtb3J5DQo+ID4gPiBjb250cm9sbGVy
IGRyaXZlcg0KPiA+ID4NCj4gPiA+IEhpLA0KPiA+ID4NCj4gPiA+IE9uIFRodSwgNSBOb3YgMjAy
MCAxNTowOToxMSArMDEwMA0KPiA+ID4gQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz4g
d3JvdGU6DQo+ID4gPg0KPiA+ID4gPiBIZWxsbyBDaGluLVRpbmcsDQo+ID4gPiA+DQo+ID4gPiA+
IFRoYW5rcyBmb3IgdGhpcyBkcml2ZXIuIEl0J3MgbXVjaCBjbGVhbmVyIHRoYW4gdGhlIHByZXZp
b3VzIGFuZCB3ZQ0KPiA+ID4gPiBzaG91bGQgdHJ5IGFkZGluZyBzdXBwb3J0IGZvciB0aGUgQVNU
MjUwMCBTb0MgYWxzby4gSSBndWVzcyB3ZSBjYW4NCj4gPiA+ID4ga2VlcCB0aGUgb2xkIGRyaXZl
ciBmb3IgdGhlIEFTVDI0MDAgd2hpY2ggaGFzIGEgZGlmZmVyZW50IHJlZ2lzdGVyIGxheW91dC4N
Cj4gPiA+ID4NCj4gPiA+ID4gT24gdGhlIHBhdGNoc2V0LCBJIHRoaW5rIHdlIHNob3VsZCBzcGxp
dCB0aGlzIHBhdGNoIGluIHRocmVlIDoNCj4gPiA+ID4NCj4gPiA+ID4gIC0gYmFzaWMgc3VwcG9y
dA0KPiA+ID4gPiAgLSBBSEIgd2luZG93IGNhbGN1bGF0aW9uIGRlcGVuZGluZyBvbiB0aGUgZmxh
c2ggc2l6ZQ0KPiA+ID4gPiAgLSByZWFkIHRyYWluaW5nIHN1cHBvcnQNCj4gPiA+DQo+ID4gPiBJ
IGRpZG4ndCBsb29rIGNsb3NlbHkgYXQgdGhlIGltcGxlbWVudGF0aW9uLCBidXQgaWYgdGhlIHJl
YWQNCj4gPiA+IHRyYWluaW5nIHRyaWVzIHRvIHJlYWQgYSBzZWN0aW9uIG9mIHRoZSBOT1IsIEkn
ZCByZWNvbW1lbmQgZXhwb3NpbmcNCj4gPiA+IHRoYXQgZmVhdHVyZSB0aHJvdWdoIHNwaS1tZW0g
YW5kIGxldHRpbmcgdGhlIFNQSS1OT1IgZnJhbWV3b3JrDQo+ID4gPiB0cmlnZ2VyIHRoZSB0cmFp
bmluZyBpbnN0ZWFkIG9mIGRvaW5nIHRoYXQgYXQgZGlybWFwIGNyZWF0aW9uIHRpbWUNCj4gPiA+
IChyZW1lbWJlciB0aGF0IHNwaS1tZW0gaXMgYWxzbyB1c2VkIGZvciBTUEkgTkFORHMgd2hpY2gg
dXNlIHRoZSBkaXJtYXANCj4gQVBJIHRvbywgYW5kIHRoaXMgdHJhaW5pbmcgaXMgdW5saWtlbHkg
dG8gd29yayB0aGVyZSkuDQo+ID4gPg0KPiA+ID4gVGhlIFNQSS1OT1IgZnJhbWV3b3JrIGNvdWxk
IHBhc3MgYSByZWFkIG9wIHRlbXBsYXRlIGFuZCBhIHJlZmVyZW5jZQ0KPiA+ID4gcGF0dGVybiBz
dWNoIHRoYXQgYWxsIHRoZSBzcGktbWVtIGRyaXZlciBoYXMgdG8gZG8gaXMgZXhlY3V0ZSB0aGUN
Cj4gPiA+IHRlbXBsYXRlIG9wIGFuZCBjb21wYXJlIHRoZSBvdXRwdXQgdG8gdGhlIHJlZmVyZW5j
ZSBidWZmZXIuDQo+ID4gPg0KPiA+DQo+ID4gSSBhZ3JlZSBpdC4gQmVmb3JlLCBJIHdlcmUgbm90
IGFibGUgdG8gZmluZCBhIHN1aXRhYmxlIGxvY2F0aW9uIHRvIGltcGxlbWVudA0KPiByZWFkIHRy
YWluaW5nIGZlYXR1cmUuDQo+ID4gSSB0aGluayB0aGF0IEkgY2FuIGFkZCBhIFNQSSB0aW1pbmcg
dHJhaW5pbmcgZnVuY3Rpb24gaW4NCj4gPiAic3BpX2NvbnRyb2xsZXJfbWVtX29wcyIgc3RydWN0
IGFuZCBjYWxsIGl0IGJ5IGEgd3JhcHBlciBmdW5jdGlvbiBjYWxsZWQgYXQNCj4gdGhlIGJvdHRv
bSBvZiBzcGlfbm9yX3Byb2JlKCkgaW4gc3BpLW5vci5jLg0KPiA+IE1heWJlLCBTUEktTk9SIGZy
YW1ld29yayBkb2VzIG5vdCBuZWVkIHRvIHBhc3MgcmVmZXJlbmNlIGJ1ZmZlciBzaW5jZQ0KPiA+
IGNhbGlicmF0aW9uIG1ldGhvZCBkZXBlbmRzIG9uIGVhY2ggU29DIGl0c2VsZiBhbmQgYnVmZmVy
IHNpemUgbWF5IGJlDQo+IHZhcmlhbnQuDQo+ID4gVGhlIGRldGFpbCBjYWxpYnJhdGlvbiBtZXRo
b2QgbWF5IGJlIGltcGxlbWVudGVkIGluIGVhY2ggU29DIFNQSSBkcml2ZXIuDQo+IA0KPiBUaGF0
J3MgYSByZWFsIHByb2JsZW0gSU1PLiBXaGF0IG1ha2VzIHRoaXMgcGF0dGVybiBTb0Mgc3BlY2lm
aWM/IEkgY2FuIHNlZQ0KPiB3aHkgdGhlIGxvY2F0aW9uIGluIGZsYXNoIGNvdWxkIGJlICpib2Fy
ZCogc3BlY2lmaWMsIGJ1dCB0aGUgcGF0dGVybiBzaG91bGQgYmUNCj4gcHJldHR5IGNvbW1vbiwg
cmlnaHQ/IEFzIGZvciB0aGUgc3BpLW1lbSBvcGVyYXRpb24gdG8gYmUgZXhlY3V0ZWQsIGl0J3MN
Cj4gZGVmaW5pdGVseSBtZW1vcnkgc3BlY2lmaWMgKEkgY2FuIGltYWdpbmUgc29tZSBmbGFzaCB2
ZW5kb3JzIHByb3ZpZGluZyBhDQo+IHNwZWNpZmljIGNvbW1hbmQgcmV0dXJuaW5nIGEgZml4ZWQg
cGF0dGVybiB0aGF0J3Mgbm90IGFjdHVhbGx5IHN0b3JlZCBvbiBhDQo+IHZpc2libGUgcG9ydGlv
biBvZiB0aGUgZmxhc2gpLg0KDQpZb3UgYXJlIHJpZ2h0LCB0aGUgcGF0dGVybiBzaG91bGQgYmUg
cHJldHR5IGNvbW1vbi4gVGhlIHRoaW5nIEkgd2FzIHdvcnJpZWQgYWJvdXQgaXMgdGhlIHNpemUg
b2YNCnRoYXQgYnVmZmVyIHNpbmNlLCBtYXliZSwgc29tZSBjb250cm9sbGVycyBuZWVkIHRvIHJl
YWQgbW9yZSBkYXRhIHRoYW4gb3RoZXJzIGluIG9yZGVyIHRvIGdldCBnb29kDQp0cmFpbmluZyBy
ZXN1bHQuDQoNCj4gPg0KPiA+IEJlc2lkZXMsIEkgYW0gdGhpbmtpbmcgYWJvdXQgdGhlIHBvc3Np
YmlsaXR5IGZvciBhZGRpbmcgYQ0KPiA+ICJzcGlfbWVtX3Bvc3RfaW5pdCIgZnVuY3Rpb24gaW4g
c3BpLW1lbSBmcmFtZXdvcmsgc2luZSBmb3Igc29tZSBTb0NzLA0KPiA+IFNQSSBjb250cm9sbGVy
IG5lZWRzIHRvIGFkanVzdCBzb21lIHNldHRpbmdzIGFmdGVyIGdldHRpbmcgU1BJIGZsYXNoDQo+
IGluZm9ybWF0aW9uLg0KPiANCj4gSSBkb24ndCB0aGluayB0aGF0J3MgYSBnb29kIGlkZWEuIFRo
ZSBzcGktbWVtIGludGVyZmFjZSBzaG91bGQgc3RheQ0KPiBtZW1vcnktdHlwZSBhZ25vc3RpYyBh
bmQgZG9pbmcgdGhhdCBtZWFucyB3ZSBzb21laG93IHBhc3MgTk9SIHNwZWNpZmljDQo+IGluZm8u
IFdoYXQgaXMgaXQgdGhhdCB5b3UgbmVlZCBleGFjdGx5LCBhbmQgd2h5Pw0KDQpZZXMsIGFzIHlv
dSBtZW50aW9uLCB0aGUgc3BpLW1lbSBpbnRlcmZhY2Ugc2hvdWxkIHN0YXkgbWVtb3J5LXR5cGUg
YWdub3N0aWMuIFRodXMsIGN1cnJlbnRseSwgSSBqdXN0IHRoaW5rIGFib3V0IHRoaXMsIG5vdCBp
bXBsZW1lbnRhdGlvbi4NCg0KV2h5IGRpZCBJIG5lZWQgdGhpcyBleGFjdGx5Pw0KVGFrZSBBU1BF
RUQgU1BJIGNvbnRyb2xsZXIgZm9yIGV4YW1wbGUsIEFTUEVFRCBTUEkgY29udHJvbGxlciBpcyBk
ZXNpZ25lZCBmb3IgU1BJIE5PUiBmbGFzaCBlc3BlY2lhbGx5Lg0KV2hlbiBBU1BFRUQgU29DIHBv
d2VycyBvbiBvciByZXNldCwgTUNVIFJPTSB3aWxsIGZldGNoIFNQSSBOT1IgZmxhc2ggdGhyb3Vn
aCBTUEkgY29udHJvbGxlci4NCkJ1dCwgTUNVIFJPTSBkb2VzIG5vdCBrbm93IHRoZSBjdXJyZW50
IGFkZHJlc3MgbW9kZSBvZiBTUEkgTk9SIGZsYXNoIHdoZW4gU29DIHdhcyByZXNldCAoU1BJIGZs
YXNoIGlzIG5vdCByZXNldCkuDQpUaGVyZWZvcmUsIFNQSSBmbGFzaCBkcml2ZXIgbmVlZHMgdG8g
c2V0IHJlbGF0ZWQgZmxhZyB0byBub3RpZnkgTUNVIFJPTSB3aGVuIGZsYXNoIGlzIHNldCB0byA0
QiBhZGRyZXNzIG1vZGUgYW5kIDRCIHJlYWQgb3Bjb2RlIGlzIHVzZWQuDQoNCkJlc2lkZXMsIGZv
ciBvdGhlciBTb0NzIGNvbm5lY3RlZCB0byBBU1BFRUQgU29DLCB0aGV5IGNhbiByZWFkL3dyaXRl
IFNQSSBOT1IgZmxhc2ggY29ubmVjdGVkIHRvIEFTUEVFRCBTb0MgYnkgYSBwdXJlIEhXIGNoYW5u
ZWwgd2l0aG91dCBhbnkgaW50ZXJhY3Rpb24gb2YgU1cgZHJpdmVyLg0KQnV0LCBiZWZvcmUgdHJp
Z2dlciB0aGlzIGZlYXR1cmUsIGZsYXNoIHJlYWQvd3JpdGUvZXJhc2Ugb3Bjb2RlLCBkdW1teSBj
eWNsZSBhbmQgb3RoZXIgaW5mb3JtYXRpb24gc2hvdWxkIGJlIGZpbGxlZCBpbiB0aGUgcmVsYXRl
ZCByZWdpc3RlcnMgaW4gYWR2YW5jZSBiZWNhdXNlIHRoYXQgSFcgY2hhbm5lbA0KZG9lcyBub3Qg
a25vdyBhY2N1cmF0ZSBpbmZvcm1hdGlvbiBhYm91dCBjb25uZWN0ZWQgU1BJIE5PUiBmbGFzaC4N
Cg0KDQpCZXN0IFdpc2hlcywNCkNoaW4tVGluZw0KDQoNCg0KDQo=
