Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94B02B1677
	for <lists+linux-spi@lfdr.de>; Fri, 13 Nov 2020 08:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgKMHbB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Nov 2020 02:31:01 -0500
Received: from mail-eopbgr1300138.outbound.protection.outlook.com ([40.107.130.138]:22943
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbgKMHbB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 13 Nov 2020 02:31:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfOH8HDIbL4gD8LHMpiTplXtVxuYJt9N3t0/daLDe6P6PqBAPSrz/Xwt4yLhCYV0oTxxOpppuB/PDjhkw+yDNfNANC0Z1VLsOgrBClf3zLcOnQY1+W3qeti0ektSY7xUYOhuwHcEmAuslFGIqxweJe7d3RnyZ7IBFmq3mhqNvAfOEUDhwZQ813d0QEk3l0CdaCPgpregfJfk/w01SR0AwloG78aFnlnSA30/l05WXhV36qzxQkf8P7SIjeY+4DBIHx5yXKU9UllBEmH/10JCfL7Yw0liejMk6YkKaIvXkkF0cYZCtwN8G+yuePUI95QHGdfOGc+J7W3hM1KP2z7GHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+B5tWd4XK+k+BFq7xwBvPGwYQqHxVrqQvskJt2jufsU=;
 b=LZu7KUuLTGeSsTjXxzZrzxAs3flgyFB4cB5xxpn2Vkma003l2tQUTudvVdH2cBF0tZ2GSEYG2eHv58NCPY1sh0CRJJPBvOCS41B6TZAvLGkSUrvWnlmbgFvISGVrN9JyVpwsVYW/P4EVGqdEykFjy7jvUQIAt580Os9CZOrrHzQbh3iKu/BNFemnxAOJzx+IvoSCt8Kl0i+uo3w1jCmT2Sv+DYUSBXf9jwk/dRktx0x5Fn7AEVrfZ2y2rZmXkyzvPP6EEIXtOt3zoICkAF5CuNslfV3ZfYr6OSLM4J7fu4qK80O0vnvMXzmpgTK6nVDASIoqgdr8AXAcFqhOaGhL2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from SG2PR06MB2794.apcprd06.prod.outlook.com (2603:1096:4:24::9) by
 SG2PR06MB2411.apcprd06.prod.outlook.com (2603:1096:4:e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.22; Fri, 13 Nov 2020 07:30:51 +0000
Received: from SG2PR06MB2794.apcprd06.prod.outlook.com
 ([fe80::5d40:df17:3fb9:fefd]) by SG2PR06MB2794.apcprd06.prod.outlook.com
 ([fe80::5d40:df17:3fb9:fefd%6]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 07:30:51 +0000
From:   Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
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
        BMC-SW <BMC-SW@aspeedtech.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: RE: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller driver
Thread-Topic: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller
 driver
Thread-Index: AQHWs2u0IlfHv/sBxE+PVdt+kUjCzqm5k6CAgAARawCAARRtAIAAF66AgAAC9KCAACVzgIAANNawgAdGNICAAy3f8A==
Date:   Fri, 13 Nov 2020 07:30:51 +0000
Message-ID: <SG2PR06MB2794BD0696B575E1E2D0A50FB2E60@SG2PR06MB2794.apcprd06.prod.outlook.com>
References: <20201105120331.9853-1-chin-ting_kuo@aspeedtech.com>
 <20201105120331.9853-5-chin-ting_kuo@aspeedtech.com>
 <fd8fa472-53bb-c992-3dc2-5a984a439c07@kaod.org>
 <20201105161132.37eb3265@collabora.com>
 <HK0PR06MB2786DAC99A56EA302EE969CAB2ED0@HK0PR06MB2786.apcprd06.prod.outlook.com>
 <20201106100539.62fc5249@collabora.com>
 <HK0PR06MB27865F0C5B2A4F680ED0D400B2ED0@HK0PR06MB2786.apcprd06.prod.outlook.com>
 <20201106123015.3248d478@collabora.com>
 <HK0PR06MB2786AE097106FC322D625BBFB2ED0@HK0PR06MB2786.apcprd06.prod.outlook.com>
 <7e959d0d-1626-9816-c5cb-1b16c5ffba25@ti.com>
In-Reply-To: <7e959d0d-1626-9816-c5cb-1b16c5ffba25@ti.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91316786-2df3-4e66-d4af-08d887a60c3f
x-ms-traffictypediagnostic: SG2PR06MB2411:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR06MB2411ECEBD03518E3EC00A223B2E60@SG2PR06MB2411.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n5Xi1t962EN+OESkPR83aAvhqLyJlOLEBKxJqCByYAULdNiUivB8J4gWCTagT0613XuWd3GcLG1IgMwKldHLMst9Ptc72toPRqYRzxWibBUXxkRnEhcv2eeMWMwDuDbMtIR82vuOaqdB3RMrlWnVUvjqf+d0FoYM6AdZFX5xbQBT95yj+5q6VLo65nX45NNuVpckgaOaE+R5ch33djmQxWC5vr0OVLKIh1grl/pusg8hJwp6lMNYUG4hcV3XFl8Xl0HQPdqt81h40bDEjobPgwvJ2Yx56XCUwOIVkhU9SAwUcbHgSAZEgl9II3Ub0yfZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB2794.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(366004)(136003)(39840400004)(54906003)(30864003)(2906002)(316002)(55236004)(66556008)(33656002)(66946007)(26005)(8676002)(55016002)(83380400001)(7416002)(71200400001)(64756008)(9686003)(110136005)(6506007)(66574015)(66446008)(66476007)(478600001)(7696005)(4326008)(53546011)(86362001)(186003)(8936002)(52536014)(5660300002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: oYHfs6ucMDDDbPy+zWLlVyvI2zBzkuUjke5raQF8JsWdLQh/0rBn/z7vTygLGaPHFQpgq8g6VdBSBzs2H6kUPjd4ySi1pLjznnjkZd8+/9480wAIK+R8QEpCvEcS3rEikcQ8ZBwy7SPEE66mwzmoJfL0RmQQyMYw10PK0sJEZPBOvFV8U6eN+ip8+KYQi2K5Rjt7L6zpbxzVZTFoe9Z0eSj3hJUzB13GLqGp5XAnbK3Ob/X5F+MD7IRa5sEsJyU6VtAT0pOcMIcMk5iH7G+iW0KKS9CMYolcOeiX0CGpn7t2AAZxnvQJj9wBCk5z8854sDtK/TO8TJafd1opVHal9JPp2xxlBBjL93PX4jM+aI3HcHVFlGbJym+C9EPibbR1m/1tmU/B1hSY4zZtoUhBy3/gcxSrvAcIwbHrL1HAVg2CiNnry1BNnrDcmyhx0hVsR+KuaL322dk6u/XbR1nryuVm0/M2CdyFwBLcbPPyhC5i002gFzEUeRlXM/D+beXbYLfoWvUZeWbtEiAOW3niTL3QUWDcBz9e0qQwGA/Ccn9QCFmmKdtA4UJDusmA9gB/QxWeYm5wp47+dH6offLcIBKKZ5xz/eUEw65zcCWqKleAVm2n0hv/VekMSx7GxVfKl/64MWT59fpXK0eDJq958g==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB2794.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91316786-2df3-4e66-d4af-08d887a60c3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2020 07:30:51.0856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7sYzb5dJ5h1sEHP67/Ic4lIfFsAZcueD2+hBGzpvv1G2wdmo4fxQah6z1n+F9FrQQa9lZD8bmFONmwMNfkFKY1G95V+8xWPTv0LghhrzRyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2411
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgVmlnbmVzaCwNCg0KVGhhbmtzIGZvciB5b3VyIGluZm9ybWF0aW9uLg0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpZ25lc2ggUmFnaGF2ZW5kcmEgPHZpZ25lc2hy
QHRpLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAxMSwgMjAyMCAxOjQ0IFBNDQo+
IFRvOiBDaGluLVRpbmcgS3VvIDxjaGluLXRpbmdfa3VvQGFzcGVlZHRlY2guY29tPjsgQm9yaXMg
QnJlemlsbG9uDQo+IDxib3Jpcy5icmV6aWxsb25AY29sbGFib3JhLmNvbT4NCj4gU3ViamVjdDog
UmU6IFt2MyA0LzRdIHNwaTogYXNwZWVkOiBBZGQgQVNQRUVEIEZNQy9TUEkgbWVtb3J5IGNvbnRy
b2xsZXINCj4gZHJpdmVyDQo+IA0KPiBIaSBDaGluLVRpbmcsDQo+IA0KPiBPbiAxMS82LzIwIDEx
OjU3IFBNLCBDaGluLVRpbmcgS3VvIHdyb3RlOg0KPiA+IEhpIEJvcmlzLA0KPiA+DQo+ID4+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEJvcmlzIEJyZXppbGxvbiA8Ym9y
aXMuYnJlemlsbG9uQGNvbGxhYm9yYS5jb20+DQo+ID4+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIg
NiwgMjAyMCA3OjMwIFBNDQo+ID4+IFRvOiBDaGluLVRpbmcgS3VvIDxjaGluLXRpbmdfa3VvQGFz
cGVlZHRlY2guY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW3YzIDQvNF0gc3BpOiBhc3BlZWQ6IEFk
ZCBBU1BFRUQgRk1DL1NQSSBtZW1vcnkNCj4gPj4gY29udHJvbGxlciBkcml2ZXINCj4gPj4NCj4g
Pj4gK1R1ZG9yIGFuZCBWaWduZXNoDQo+ID4+DQo+ID4+IE9uIEZyaSwgNiBOb3YgMjAyMCAxMDoy
MTowNiArMDAwMA0KPiA+PiBDaGluLVRpbmcgS3VvIDxjaGluLXRpbmdfa3VvQGFzcGVlZHRlY2gu
Y29tPiB3cm90ZToNCj4gPj4NCj4gPj4+IEhpIEJvcmlzLA0KPiA+Pj4NCj4gPj4+IFRoYW5rcyBm
b3IgeW91ciBjb21tZW50cyBhbmQgc3VnZ2VzdGlvbnMuDQo+ID4+Pg0KPiA+Pj4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4gRnJvbTogQm9yaXMgQnJlemlsbG9uIDxib3Jpcy5i
cmV6aWxsb25AY29sbGFib3JhLmNvbT4NCj4gPj4+PiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDYs
IDIwMjAgNTowNiBQTQ0KPiA+Pj4+IFRvOiBDaGluLVRpbmcgS3VvIDxjaGluLXRpbmdfa3VvQGFz
cGVlZHRlY2guY29tPg0KPiA+Pj4+IFN1YmplY3Q6IFJlOiBbdjMgNC80XSBzcGk6IGFzcGVlZDog
QWRkIEFTUEVFRCBGTUMvU1BJIG1lbW9yeQ0KPiA+Pj4+IGNvbnRyb2xsZXIgZHJpdmVyDQo+ID4+
Pj4NCj4gPj4+PiBPbiBGcmksIDYgTm92IDIwMjAgMDg6NTg6MjMgKzAwMDANCj4gPj4+PiBDaGlu
LVRpbmcgS3VvIDxjaGluLXRpbmdfa3VvQGFzcGVlZHRlY2guY29tPiB3cm90ZToNCj4gPj4+Pg0K
PiA+Pj4+PiBIaSBCb3JpcywNCj4gPj4+Pj4NCj4gPj4+Pj4gVGhhbmtzIGZvciB5b3VyIHF1aWNr
IHJlcGx5Lg0KPiA+Pj4+Pg0KPiA+Pj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
Pj4+Pj4+IEZyb206IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9uQGNvbGxhYm9yYS5j
b20+DQo+ID4+Pj4+PiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgNSwgMjAyMCAxMToxMiBQTQ0K
PiA+Pj4+Pj4gVG86IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+OyByb2JoK2R0QGtl
cm5lbC5vcmcNCj4gPj4+Pj4+IENjOiBDaGluLVRpbmcgS3VvIDxjaGluLXRpbmdfa3VvQGFzcGVl
ZHRlY2guY29tPjsNCj4gPj4+Pj4+IGJyb29uaWVAa2VybmVsLm9yZzsgam9lbEBqbXMuaWQuYXU7
IGFuZHJld0Bhai5pZC5hdTsNCj4gPj4+Pj4+IGJicmV6aWxsb25Aa2VybmVsLm9yZzsgZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+Pj4+PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1hc3BlZWRAbGlzdHMub3psYWJzLm9yZzsNCj4gPj4+Pj4+IGxpbnV4LXNwaUB2
Z2VyLmtlcm5lbC5vcmc7IEJNQy1TVyA8Qk1DLVNXQGFzcGVlZHRlY2guY29tPg0KPiA+Pj4+Pj4g
U3ViamVjdDogUmU6IFt2MyA0LzRdIHNwaTogYXNwZWVkOiBBZGQgQVNQRUVEIEZNQy9TUEkgbWVt
b3J5DQo+ID4+Pj4+PiBjb250cm9sbGVyIGRyaXZlcg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IEhpLA0K
PiA+Pj4+Pj4NCj4gPj4+Pj4+IE9uIFRodSwgNSBOb3YgMjAyMCAxNTowOToxMSArMDEwMCBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiA+Pj4+Pj4gd3JvdGU6DQo+ID4+Pj4+Pg0K
PiA+Pj4+Pj4+IEhlbGxvIENoaW4tVGluZywNCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IFRoYW5rcyBm
b3IgdGhpcyBkcml2ZXIuIEl0J3MgbXVjaCBjbGVhbmVyIHRoYW4gdGhlIHByZXZpb3VzIGFuZA0K
PiA+Pj4+Pj4+IHdlIHNob3VsZCB0cnkgYWRkaW5nIHN1cHBvcnQgZm9yIHRoZSBBU1QyNTAwIFNv
QyBhbHNvLiBJIGd1ZXNzDQo+ID4+Pj4+Pj4gd2UgY2FuIGtlZXAgdGhlIG9sZCBkcml2ZXIgZm9y
IHRoZSBBU1QyNDAwIHdoaWNoIGhhcyBhDQo+ID4+IGRpZmZlcmVudCByZWdpc3RlciBsYXlvdXQu
DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBPbiB0aGUgcGF0Y2hzZXQsIEkgdGhpbmsgd2Ugc2hvdWxk
IHNwbGl0IHRoaXMgcGF0Y2ggaW4gdGhyZWUgOg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gIC0gYmFz
aWMgc3VwcG9ydA0KPiA+Pj4+Pj4+ICAtIEFIQiB3aW5kb3cgY2FsY3VsYXRpb24gZGVwZW5kaW5n
IG9uIHRoZSBmbGFzaCBzaXplDQo+ID4+Pj4+Pj4gIC0gcmVhZCB0cmFpbmluZyBzdXBwb3J0DQo+
ID4+Pj4+Pg0KPiA+Pj4+Pj4gSSBkaWRuJ3QgbG9vayBjbG9zZWx5IGF0IHRoZSBpbXBsZW1lbnRh
dGlvbiwgYnV0IGlmIHRoZSByZWFkDQo+ID4+Pj4+PiB0cmFpbmluZyB0cmllcyB0byByZWFkIGEg
c2VjdGlvbiBvZiB0aGUgTk9SLCBJJ2QgcmVjb21tZW5kDQo+ID4+Pj4+PiBleHBvc2luZyB0aGF0
IGZlYXR1cmUgdGhyb3VnaCBzcGktbWVtIGFuZCBsZXR0aW5nIHRoZSBTUEktTk9SDQo+ID4+Pj4+
PiBmcmFtZXdvcmsgdHJpZ2dlciB0aGUgdHJhaW5pbmcgaW5zdGVhZCBvZiBkb2luZyB0aGF0IGF0
IGRpcm1hcA0KPiA+Pj4+Pj4gY3JlYXRpb24gdGltZSAocmVtZW1iZXIgdGhhdCBzcGktbWVtIGlz
IGFsc28gdXNlZCBmb3IgU1BJIE5BTkRzDQo+ID4+Pj4+PiB3aGljaCB1c2UgdGhlIGRpcm1hcA0K
PiA+Pj4+IEFQSSB0b28sIGFuZCB0aGlzIHRyYWluaW5nIGlzIHVubGlrZWx5IHRvIHdvcmsgdGhl
cmUpLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IFRoZSBTUEktTk9SIGZyYW1ld29yayBjb3VsZCBwYXNz
IGEgcmVhZCBvcCB0ZW1wbGF0ZSBhbmQgYQ0KPiA+Pj4+Pj4gcmVmZXJlbmNlIHBhdHRlcm4gc3Vj
aCB0aGF0IGFsbCB0aGUgc3BpLW1lbSBkcml2ZXIgaGFzIHRvIGRvIGlzDQo+ID4+Pj4+PiBleGVj
dXRlIHRoZSB0ZW1wbGF0ZSBvcCBhbmQgY29tcGFyZSB0aGUgb3V0cHV0IHRvIHRoZSByZWZlcmVu
Y2UNCj4gPj4gYnVmZmVyLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4NCj4gPj4+Pj4gSSBhZ3JlZSBpdC4g
QmVmb3JlLCBJIHdlcmUgbm90IGFibGUgdG8gZmluZCBhIHN1aXRhYmxlIGxvY2F0aW9uIHRvDQo+
ID4+Pj4+IGltcGxlbWVudA0KPiA+Pj4+IHJlYWQgdHJhaW5pbmcgZmVhdHVyZS4NCj4gPj4+Pj4g
SSB0aGluayB0aGF0IEkgY2FuIGFkZCBhIFNQSSB0aW1pbmcgdHJhaW5pbmcgZnVuY3Rpb24gaW4N
Cj4gPj4+Pj4gInNwaV9jb250cm9sbGVyX21lbV9vcHMiIHN0cnVjdCBhbmQgY2FsbCBpdCBieSBh
IHdyYXBwZXIgZnVuY3Rpb24NCj4gPj4+Pj4gY2FsbGVkIGF0DQo+ID4+Pj4gdGhlIGJvdHRvbSBv
ZiBzcGlfbm9yX3Byb2JlKCkgaW4gc3BpLW5vci5jLg0KPiA+Pj4+PiBNYXliZSwgU1BJLU5PUiBm
cmFtZXdvcmsgZG9lcyBub3QgbmVlZCB0byBwYXNzIHJlZmVyZW5jZSBidWZmZXINCj4gPj4+Pj4g
c2luY2UgY2FsaWJyYXRpb24gbWV0aG9kIGRlcGVuZHMgb24gZWFjaCBTb0MgaXRzZWxmIGFuZCBi
dWZmZXINCj4gPj4+Pj4gc2l6ZSBtYXkgYmUNCj4gPj4+PiB2YXJpYW50Lg0KPiA+Pj4+PiBUaGUg
ZGV0YWlsIGNhbGlicmF0aW9uIG1ldGhvZCBtYXkgYmUgaW1wbGVtZW50ZWQgaW4gZWFjaCBTb0Mg
U1BJDQo+ID4+IGRyaXZlci4NCj4gPj4+Pg0KPiA+Pj4+IFRoYXQncyBhIHJlYWwgcHJvYmxlbSBJ
TU8uIFdoYXQgbWFrZXMgdGhpcyBwYXR0ZXJuIFNvQyBzcGVjaWZpYz8gSQ0KPiA+Pj4+IGNhbiBz
ZWUgd2h5IHRoZSBsb2NhdGlvbiBpbiBmbGFzaCBjb3VsZCBiZSAqYm9hcmQqIHNwZWNpZmljLCBi
dXQNCj4gPj4+PiB0aGUgcGF0dGVybiBzaG91bGQgYmUgcHJldHR5IGNvbW1vbiwgcmlnaHQ/IEFz
IGZvciB0aGUgc3BpLW1lbQ0KPiA+Pj4+IG9wZXJhdGlvbiB0byBiZSBleGVjdXRlZCwgaXQncyBk
ZWZpbml0ZWx5IG1lbW9yeSBzcGVjaWZpYyAoSSBjYW4NCj4gPj4+PiBpbWFnaW5lIHNvbWUgZmxh
c2ggdmVuZG9ycyBwcm92aWRpbmcgYSBzcGVjaWZpYyBjb21tYW5kIHJldHVybmluZyBhDQo+ID4+
Pj4gZml4ZWQgcGF0dGVybiB0aGF0J3Mgbm90IGFjdHVhbGx5IHN0b3JlZCBvbiBhIHZpc2libGUg
cG9ydGlvbiBvZiB0aGUgZmxhc2gpLg0KPiA+Pj4NCj4gPj4+IFlvdSBhcmUgcmlnaHQsIHRoZSBw
YXR0ZXJuIHNob3VsZCBiZSBwcmV0dHkgY29tbW9uLiBUaGUgdGhpbmcgSSB3YXMNCj4gPj4+IHdv
cnJpZWQgYWJvdXQgaXMgdGhlIHNpemUgb2YgdGhhdCBidWZmZXIgc2luY2UsIG1heWJlLCBzb21l
DQo+ID4+PiBjb250cm9sbGVycyBuZWVkIHRvIHJlYWQgbW9yZSBkYXRhIHRoYW4gb3RoZXJzIGlu
IG9yZGVyIHRvIGdldCBnb29kDQo+ID4+PiB0cmFpbmluZw0KPiA+PiByZXN1bHQuDQo+ID4+DQo+
ID4+IEl0IHdvdWxkIGJlIGdvb2QgdG8gc2VlIGhvdyBvdGhlciBjb250cm9sbGVycyBpbXBsZW1l
bnQgdGhhdC4gSSBrbm93DQo+ID4+IHRoYXQgdGhlIENhZGVuY2UgY29udHJvbGxlciBoYWQgc29t
ZXRoaW5nIHNpbWlsYXIuIFZpZ25lc2ggbWlnaHQgYmUNCj4gPj4gYWJsZSB0byBzaGFyZSBoaXMg
dGhvdWdodHMgb24gdGhpcy4NCj4gPg0KPiANCj4gQ2FkZW5jZSBjb250cm9sbGVycyByZXF1aXJl
cyB0byByZWFkIGZpeGVkIGxlbmd0aCBjYWxpYnJhdGlvbiBwYXR0ZXJuIG11bHRpcGxlDQo+IHRp
bWVzICh3aGlsZSB0dW5pbmcgUEhZIHJlZ2lzdGVycykgZnJvbSBub24gemVybyBhZGRyZXNzIGxv
Y2F0aW9uLiBQYXR0ZXJuIGlzDQo+IEZsYXNoIGluZGVwZW5kZW50IGFuZCBTb0MgaW5kZXBlbmRl
bnQuIEhlbmNlLCBjYW4gYmUgaGFyZCBjb2RlZCBpbiBkcml2ZXINCj4gKG5vIG5lZWQgdG8gcmVh
ZCBhdCBzbG93ZXIgc3BlZWQpLg0KPiANCg0KVGhpcyBtZXRob2QgaXMgbW9yZSBzdWl0YWJsZS4N
Cg0KPiA+IE9oLCBtYXliZSwgSSBtaXN1bmRlcnN0b29kIHlvdXIgbWVhbmluZyBhbmQgSSBkaWQg
bm90IGRlc2NyaWJlIGNsZWFybHkNCj4gZWFybHkuDQo+ID4gQXMgeW91IG1lbnRpb25lZCBiZWZv
cmUsIGZvciBzb21lIFNQSS1OT1IgZmxhc2hlcywgdGhlcmUgaW5kZWVkIGV4aXN0cw0KPiA+IGEg
Y29tbWFuZCB1c2VkIGZvciByZWFkIHRpbWluZyB0cmFpbmluZyB3aXRoIGhpZ2ggU1BJIGNsb2Nr
IGZyZXF1ZW5jeS4NCj4gPiBXaGVuIHRoaXMgc3BlY2lmaWMgY29tbWFuZCBpcyBzZW50LCBhbiBh
bG1vc3QgY29tbW9uIHBhdHRlcm4gd2l0aCBmaXhlZA0KPiBsZW5ndGggd2lsbCBiZSBvdXRwdXR0
ZWQgdG8gY29udHJvbGxlci4NCj4gPiAoVGhpcyBwYXR0ZXJuIGlzIG5vdCBzdG9yZWQgb24gYSBu
b3JtYWwgcmVhZC93cml0ZSBhcmVhLikNCj4gPg0KPiA+IEJ1dCwgdW5mb3J0dW5hdGVseSwgbWFu
eSBmbGFzaCBwYXJ0cyB3ZSB1c2VkIGRpZCBub3Qgc3VwcG9ydCB0aGlzIGZlYXR1cmUuDQo+IFRo
dXMsIG91ciByZWFkIHRpbWluZyB0cmFpbmluZyBzdHJhdGVneSBpczoNCj4gPiBTdGVwIDE6IFVz
ZSB0aGUgbG93ZXN0IFNQSSBjbG9jayBmcmVxdWVuY3kgdG8gcmVhZCBub3JtYWwgZmxhc2ggY29u
dGVudCB3aXRoDQo+IHNwZWNpZmljIGxlbmd0aCBhcyByZWZlcmVuY2UgZGF0YS4NCj4gPiBTdGVw
IDI6IFdpdGggYSBmaXhlZCBoaWdoIFNQSSBjbG9jayBmcmVxdWVuY3ksIGFkanVzdCBkaWZmZXJl
bnQgdGltaW5nIGRlbGF5DQo+IGN5Y2xlLCB0aGVuLCByZWFkIHRoZSBzYW1lIGZsYXNoIHJlZ2lv
biBmb3IgZWFjaCB0aW1pbmcgZGVsYXkuDQo+ID4gU3RlcCAzOiBDb21wYXJlIGVhY2ggZGF0YSBy
ZWFkIGZyb20gc3RlcCAyIHRvIHRoZSByZWZlcmVuY2UgZGF0YSBnb3R0ZW4NCj4gZnJvbSBzdGVw
IDEuIFRoZW4sIHdlIHdpbGwgZ2V0IGEgc3VpdGFibGUgdGltaW5nIGRlbGF5IHdpbmRvdy4NCj4g
Pg0KPiANCj4gVXNpbmcgZGlybWFwX2NyZWF0ZSgpIHRvIGFjdHVhbGx5IGNhbGlicmF0ZSBjb250
cm9sbGVyIGlzIGFidXNpbmcgdGhlIGludGVyZmFjZQ0KPiBJTU8uICBJdCBpcyBub3QgZ3VhcmFu
dGVlZCB0aGF0IGZsYXNoIGlzIGNvbmZpZ3VyZWQgdG8gdXNlIHJpZ2h0IG51bWJlciBvZg0KPiBk
dW1teSBjeWNsZXMgdmFsdWVzIGFuZCBtb2RlIGZvciBoaWdoIHNwZWVkIG9wZXJhdGlvbiBiZWZv
cmUgY2FsbCB0bw0KPiBkaXJtYXBfY3JlYXRlKCkuIFRoaXMgaXMgdHJ1ZSB0b2RheSBidXQgbWF5
IGNoYW5nZSBpbiB0aGUgZnV0dXJlLiBTbywgdGhlcmUNCj4gc2hvdWxkIGF0IGxlYXN0IGJlIGEg
c2VwYXJhdGUgY2FsbGJhY2sgZGVkaWNhdGVkIGZvciBjYWxpYnJhdGlvbiBhbG9uZyB0aGUgbGlu
ZXMNCj4gQm9yaXMgc3VnZ2VzdGVkLg0KPiANCg0KWWVzLCBpdCBpcyBpbmFwcHJvcHJpYXRlIHRv
IGxvY2F0ZSBjYWxpYnJhdGUgcGFydCBpbiBkaXJtYXBfY3JlYXRlKCkuIEkgZGlkIHRoaXMgYmVj
YXVzZSB0aGVyZSB3YXMgbm8gZ29vZCBwbGFjZSBhdCB0aGF0IHRpbWUuDQpUaGlzIHByb2JsZW0g
d2lsbCBiZSBtaXRpZ2F0ZWQgYnkgdXNpbmcgQm9yaXMgc3VnZ2VzdGlvbi4NCg0KPiBNYXggZnJl
cXVlbmN5IHRoYXQgcmVhZCBjbWQgbWF5IHN1cHBvcnQgd291bGQgbm90IGJlIHN1cHBvcnRlZCBi
eSBvdGhlcg0KPiBjbWRzIHN1Y2ggYXMgd3JpdGUgb3IgcmVhZCBTRkRQLiBUaGlzIHdvdWxkIG5l
ZWQgdG8gYmUgdGFrZW4gaW50byBhY2NvdW50DQo+IGJlZm9yZSBhbmQgcG9zdCBjYWxpYnJhdGlv
biBwcm9iYWJseSBieSBleHRlbmRpbmcgc3BpX21lbV9vcCB0byBzcGVjaWZ5IGZyZXENCj4gb2Yg
b3BlcmF0aW9uIHBlciBvcC4NCj4gDQoNClllcywgbm90IGFsbCBjb21tYW5kcyBjYW4gc3VwcG9y
dCB0aGUgc2FtZSBmcmVxdWVuY3kgKGhpZ2hlciBmcmVxdWVuY3kpLg0KQnV0LCBpdCBpcyBpbXBv
c3NpYmxlIHRvIHJlY29yZCB3b3JrYWJsZSBmcmVxdWVuY3kgZm9yIGVhY2ggb3Bjb2RlLCBkaWZm
ZXJlbnQgcGFydHMgb3IgZm9yIGRpZmZlcmVudCBmbGFzaCB2ZW5kb3JzLg0KTWF5YmUsIG9ubHkg
cmVhZC9wcm9ncmFtIGNvbW1hbmRzIG5lZWQgaGlnaGVyIGZyZXF1ZW5jeSBmb3Igc3lzdGVtIHBl
cmZvcm1hbmNlIGltcHJvdmVtZW50IHB1cnBvc2UuIE90aGVyIGNvbW1hbmRzIGNhbiB1c2UgZGVm
YXVsdCBmcmVxdWVuY3kuDQpBZnRlciBmbGFzaCBpcyBwcm9iZWQgKHNwaV9ub3Jfc2NhbiksIHJl
YWQvd3JpdGUgb3Bjb2RlIGFuZCBkdW1teSBjeWNsZXMgYXJlIGRlY2lkZWQsIHdlIGNhbiB1c2Ug
dGhpcyBpbmZvcm1hdGlvbiBmb3IgcmVhZCB0cmFpbmluZyBmb3Igc3BlY2lmaWMgcmVhZCBvcGNv
ZGUgd2l0aCBpdHMgZHVtbXkgY3ljbGVzLg0KVGhhbmtzIGZvciB5b3VyIHJlbWFpbmRlci4NCg0K
QmVzdCBXaXNoZXMsDQpDaGluLVRpbmcNCg0KPiBJIHNlZSB0aGF0IGNhbGlicmF0aW9uIHBhdHRl
cm4gaXMgYXNzdW1lZCB0byBiZSBhdCBvZmZzZXQgMCBpbiB0aGUgZmxhc2guIFRoaXMgbWF5DQo+
IG5vdCBiZSB0aGUgaWRlYWwgcG9zaXRpb24gYXMgb2Zmc2V0IDAgaXMgdHlwaWNhbGx5IHVzZWQg
dG8gc3RvcmUgYm9vdGxvYWRlci4gU28sDQo+IHRoZXJlIHNob3VsZCBiZSBhIHdheSB0byBzcGVj
aWZ5IG9mZnNldCBhdCB3aGljaCBjYWxpYnJhdGlvbiBwYXR0ZXJuIGlzIHByZXNlbnQuDQo+IA0K
PiBSZWdhcmRzDQo+IFZpZ25lc2gNCj4gDQo+IA0KPiA+Pg0KPiA+Pj4NCj4gPj4+Pj4NCj4gPj4+
Pj4gQmVzaWRlcywgSSBhbSB0aGlua2luZyBhYm91dCB0aGUgcG9zc2liaWxpdHkgZm9yIGFkZGlu
ZyBhDQo+ID4+Pj4+ICJzcGlfbWVtX3Bvc3RfaW5pdCIgZnVuY3Rpb24gaW4gc3BpLW1lbSBmcmFt
ZXdvcmsgc2luZSBmb3Igc29tZQ0KPiA+Pj4+PiBTb0NzLCBTUEkgY29udHJvbGxlciBuZWVkcyB0
byBhZGp1c3Qgc29tZSBzZXR0aW5ncyBhZnRlciBnZXR0aW5nDQo+ID4+Pj4+IFNQSSBmbGFzaA0K
PiA+Pj4+IGluZm9ybWF0aW9uLg0KPiA+Pj4+DQo+ID4+Pj4gSSBkb24ndCB0aGluayB0aGF0J3Mg
YSBnb29kIGlkZWEuIFRoZSBzcGktbWVtIGludGVyZmFjZSBzaG91bGQgc3RheQ0KPiA+Pj4+IG1l
bW9yeS10eXBlIGFnbm9zdGljIGFuZCBkb2luZyB0aGF0IG1lYW5zIHdlIHNvbWVob3cgcGFzcyBO
T1INCj4gPj4+PiBzcGVjaWZpYyBpbmZvLiBXaGF0IGlzIGl0IHRoYXQgeW91IG5lZWQgZXhhY3Rs
eSwgYW5kIHdoeT8NCj4gPj4+DQo+ID4+PiBZZXMsIGFzIHlvdSBtZW50aW9uLCB0aGUgc3BpLW1l
bSBpbnRlcmZhY2Ugc2hvdWxkIHN0YXkgbWVtb3J5LXR5cGUNCj4gPj4gYWdub3N0aWMuIFRodXMs
IGN1cnJlbnRseSwgSSBqdXN0IHRoaW5rIGFib3V0IHRoaXMsIG5vdCBpbXBsZW1lbnRhdGlvbi4N
Cj4gPj4+DQo+ID4+PiBXaHkgZGlkIEkgbmVlZCB0aGlzIGV4YWN0bHk/DQo+ID4+PiBUYWtlIEFT
UEVFRCBTUEkgY29udHJvbGxlciBmb3IgZXhhbXBsZSwgQVNQRUVEIFNQSSBjb250cm9sbGVyIGlz
DQo+ID4+PiBkZXNpZ25lZA0KPiA+PiBmb3IgU1BJIE5PUiBmbGFzaCBlc3BlY2lhbGx5Lg0KPiA+
Pj4gV2hlbiBBU1BFRUQgU29DIHBvd2VycyBvbiBvciByZXNldCwgTUNVIFJPTSB3aWxsIGZldGNo
IFNQSSBOT1IgZmxhc2gNCj4gPj4gdGhyb3VnaCBTUEkgY29udHJvbGxlci4NCj4gPj4+IEJ1dCwg
TUNVIFJPTSBkb2VzIG5vdCBrbm93IHRoZSBjdXJyZW50IGFkZHJlc3MgbW9kZSBvZiBTUEkgTk9S
IGZsYXNoDQo+ID4+IHdoZW4gU29DIHdhcyByZXNldCAoU1BJIGZsYXNoIGlzIG5vdCByZXNldCku
DQo+ID4+PiBUaGVyZWZvcmUsIFNQSSBmbGFzaCBkcml2ZXIgbmVlZHMgdG8gc2V0IHJlbGF0ZWQg
ZmxhZyB0byBub3RpZnkgTUNVDQo+ID4+PiBST00gd2hlbg0KPiA+PiBmbGFzaCBpcyBzZXQgdG8g
NEIgYWRkcmVzcyBtb2RlIGFuZCA0QiByZWFkIG9wY29kZSBpcyB1c2VkLg0KPiA+Pg0KPiA+PiBP
aCwgdGhhdCdzIHVnbHkhIFRoZSBTUEkgTk9SIGZyYW1ld29yayB0cmllcyBoYXJkIHRvIG5vdCBj
aGFuZ2UgdGhlDQo+ID4+IGFkZHJlc3NpbmcgbW9kZSBleGFjdGx5IGZvciB0aGlzIHJlYXNvbi4g
T24gbW9zdCBOT1JzIHRoZXJlIHNob3VsZA0KPiA+PiBub3cgYmUgUkVBRC9XUklURSB2YXJpYW50
cyBhbGxvd2luZyB5b3UgdG8gYWRkcmVzcyBtb3JlIHRoYW4gMl4yNA0KPiA+PiBieXRlcyB3aXRo
b3V0IGNoYW5naW5nIHRoZSBhZGRyZXNzaW5nIG1vZGUuIFRoaXMgYmVpbmcgc2FpZCwgdGhvc2UN
Cj4gPj4gcHJvYmxlbSBleGlzdHMgb24gb3RoZXIgcGxhdGZvcm0gd2hpY2ggY2FuJ3QgZXZlbiBs
ZXQgdGhlIGJvb3QgUk9NDQo+ID4+IGtub3cgdGhhdCBhZGRyZXNzaW5nIG1vZGUgY2hhbmdlZC4g
SSBkb24ndCBoYXZlIGEgcHJvcGVyIHNvbHV0aW9uIGZvcg0KPiA+PiB5b3VyIHVzZSBjYXNlLCBi
dXQgSSBkZWZpbml0ZWx5IGRvbid0IGxpa2UgdGhlIGlkZWEgb2YgZXhwb3Npbmcgc3VjaCBkZXRh
aWxzIHRvDQo+IHNwaS1tZW0gY29udHJvbGxlcnMuLi4NCj4gPj4NCj4gPg0KPiA+IENlcnRhaW5s
eSwgbW9zdCBvZiBuZXcgU1BJIE5PUiBmbGFzaGVzIGxhcmdlciB0aGFuIDE2TUIgc3VwcG9ydA0K
PiA+IGRlZGljYXRlZCA0QiBjb21tYW5kIHdpdGhvdXQgY2hhbmdlIGZsYXNoIGFkZHJlc3MgbW9k
ZS4gT3JpZ2luYWxseSwgSQ0KPiA+IHdhbnQgdG8gdGFrZSBhbGwgZmxhc2hlcyBpbnRvIGNvbnNp
ZGVyYXRpb24uIEJ1dCwgbm93LCB0aGUgbnVtYmVyIG9mDQo+ID4gZmxhc2hlcywgbGFyZ2VyIHRo
YW4gMTZNQiBhbmQgd2l0aG91dCA0QiBkZWRpY2F0ZWQgY29tbWFuZCwgZGVjcmVhc2VzLg0KPiBQ
ZXJoYXBzLCBJIGNhbiBpZ25vcmUgdGhlbSBjdXJyZW50bHkuDQo+ID4NCj4gPj4gV2UgdXN1YWxs
eSByZWNvbW1lbmQgdG8gY29ubmVjdCB0aGUgTk9SIHJlc2V0IHBpbiB0byB0aGUgZ2xvYmFsIHJl
c2V0DQo+ID4+IHRvIGFkZHJlc3NpbmcgbW9kZSBnZXRzIGJhY2sgdG8ga25vd24gc3RhdGUgd2hl
biB5b3UgcmVib290IHRoZSBib2FyZA0KPiA+PiBhbmQgbmVlZCB0byBnbyBiYWNrIHRvIHRoZSBi
b290IFJPTS4NCj4gPg0KPiA+IEkgYWdyZWUgd2l0aCB0aGlzLg0KPiA+DQo+ID4+DQo+ID4+Pg0K
PiA+Pj4gQmVzaWRlcywgZm9yIG90aGVyIFNvQ3MgY29ubmVjdGVkIHRvIEFTUEVFRCBTb0MsIHRo
ZXkgY2FuIHJlYWQvd3JpdGUNCj4gPj4+IFNQSQ0KPiA+PiBOT1IgZmxhc2ggY29ubmVjdGVkIHRv
IEFTUEVFRCBTb0MgYnkgYSBwdXJlIEhXIGNoYW5uZWwgd2l0aG91dCBhbnkNCj4gPj4gaW50ZXJh
Y3Rpb24gb2YgU1cgZHJpdmVyLg0KPiA+Pj4gQnV0LCBiZWZvcmUgdHJpZ2dlciB0aGlzIGZlYXR1
cmUsIGZsYXNoIHJlYWQvd3JpdGUvZXJhc2Ugb3Bjb2RlLA0KPiA+Pj4gZHVtbXkgY3ljbGUgYW5k
IG90aGVyIGluZm9ybWF0aW9uIHNob3VsZCBiZSBmaWxsZWQgaW4gdGhlIHJlbGF0ZWQNCj4gPj4+
IHJlZ2lzdGVycyBpbg0KPiA+PiBhZHZhbmNlIGJlY2F1c2UgdGhhdCBIVyBjaGFubmVsIGRvZXMg
bm90IGtub3cgYWNjdXJhdGUgaW5mb3JtYXRpb24NCj4gPj4gYWJvdXQgY29ubmVjdGVkIFNQSSBO
T1IgZmxhc2guDQo+ID4+DQo+ID4+IFdoaWxlIEkgY2FuIHNlZSBhIHZhbGlkIHJlYXNvbiB0byBh
bGxvdyB0aGF0IGZvciBSRUFEcyAoaWYgd2UgZGVjaWRlDQo+ID4+IHRvIHN1cHBvcnQgWElQKSwg
SSByZWFsbHkgZG9uJ3QgbGlrZSB0aGUgaWRlYSBvZiBhbGxvd2luZyBkZXN0cnVjdGl2ZQ0KPiA+
PiBvcGVyYXRpb25zDQo+ID4+IChXUklURS9FUkFTRSkgb24gdGhlIGZsYXNoIHRoYXQgZG9uJ3Qg
Z28gdGhyb3VnaCB0aGUgTVREIGxheWVyLiBUaGlzDQo+ID4+IHNvdW5kcyBsaWtlIHJpc2t5IGJ1
c2luZXNzIHRvIG1lLCBzbyBJJ2QganVzdCBmb3JnZXQgYWJvdXQgdGhhdCBpZiBJDQo+ID4+IHdl
cmUgeW91LiBSZWdhcmRpbmcgdGhlIFhJUCB1c2UgY2FzZSwgd2h5IG5vdCwgYnV0IHdlJ2xsIG5l
ZWQgdG8gZXh0ZW5kIHRoZQ0KPiBkaXJtYXAgQVBJIHRvIHN1cHBvcnQgaXQ6DQo+ID4+IG1hcHBp
bmdzIG5lZWQgdG8gc3RheSBhcm91bmQgYW5kIHlvdSBuZWVkIHRvIHJldHVybiBhIHBvaW50ZXIg
dG8gdGhlDQo+ID4+IG1hcHBlZCBtZW1vcnkgcmVnaW9uLCB3aGljaCB3ZSBkb24ndCBhbGxvdyBy
aWdodCBub3cgKGJlY2F1c2Ugd2Ugd2FudA0KPiA+PiB0byBsZXQgY29udHJvbGxlcnMgbW92ZSB0
aGVpciBkaXJtYXAgd2luZG93IGlmIHRoZXkgaGF2ZSB0bykuDQo+ID4NCj4gPiBZZXMsIGZvciBT
UEkoLWZsYXNoKSBkcml2ZXIsIEkgdGhpbmsgSSBqdXN0IG5lZWRzIHRvIGZvY3VzIG9uIHRoZSBz
Y2VuYXJpbyB3aGVyZQ0KPiBhbGwgZmxhc2ggb3BlcmF0aW9ucyBnbyB0aHJvdWdoIE1URCBsYXll
ci4NCj4gPiBPdGhlciBhcHBsaWNhdGlvbiBtYXkgYmUgaW1wbGVtZW50ZWQgb24gdGhlIG90aGVy
IGRyaXZlciwgbm90IGhlcmUuDQo+ID4NCj4gPg0KPiA+IEJlc3QgV2lzaGVzLA0KPiA+IENoaW4t
VGluZw0KPiA+DQo+ID4NCg==
