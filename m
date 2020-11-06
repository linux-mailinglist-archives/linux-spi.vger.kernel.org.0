Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC932A91E3
	for <lists+linux-spi@lfdr.de>; Fri,  6 Nov 2020 09:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgKFI6a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Nov 2020 03:58:30 -0500
Received: from mail-eopbgr1300131.outbound.protection.outlook.com ([40.107.130.131]:16267
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbgKFI6a (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 6 Nov 2020 03:58:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhbNSCF6C4l57PWS4I6M43nNKnxAHeCPEDndQOrA66imnmoyBzEXX1DAxHmr+ILOqlMjfDLU8O2QCmdTMBD18jIF8FcKdSkQ37VFtWjzaB0QTKWQT5z0gIR5L1xqYEtMeeZHneO3CvoE7rYUudWhSvljpvvtVgKv51OhLLmpN82dHCs8zr3NJVOlUl2RyY/IW8k/7hCpKdahjmAoeh0/abZ56hiDNIWf6LqfVgqpfQRbsiVLFQk/waVYsvkGmbj962cAM38ER4/NGIHGBK+T3hnOjaI0cHGfjxX5ARMIBQCKCRfTxhLQi/Lsff1bLaK75o3qfQKzFsS+UZFyoB+rMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFqPdJtxsGhj0JTtuUHKAAnbLvo+Dp55JgPnpe32yfc=;
 b=DLGTGcrF/UoGliEQ9u4EdaPATtfOa/QV6QvHmAqt6uJtl+T8A8/deow9UATCdUAwz+Frp8qRFCv8rc0e/t7A/Zgonp07JPnj5auF3bjZ/CtzurnBuR2bEEvnaG/HCJbJDSeddp+UYNwOgWlzM/CQJGRxHaDXmPGd2TW/H5TxVAXDPbmabQQ/ZRJyM9fhZmE7aSJGOFqTtGWJi41NSYNWyGuWeEn/mgDkRFaC1ezrPPb2ejhQhevj5LVwn2l85ZOoRVEDBNnkAzi4Z/nwCPDms+QRTMj+SLKcJ880ov6y6iVSffW2eYLVLJtLyB5INgESLZvS7verv9y9nDhlA3ylzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from HK0PR06MB2786.apcprd06.prod.outlook.com (2603:1096:203:5b::22)
 by HK2PR06MB3426.apcprd06.prod.outlook.com (2603:1096:202:38::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.28; Fri, 6 Nov
 2020 08:58:24 +0000
Received: from HK0PR06MB2786.apcprd06.prod.outlook.com
 ([fe80::c9cf:b4b1:3371:d532]) by HK0PR06MB2786.apcprd06.prod.outlook.com
 ([fe80::c9cf:b4b1:3371:d532%7]) with mapi id 15.20.3499.033; Fri, 6 Nov 2020
 08:58:24 +0000
From:   Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
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
Thread-Index: AQHWs2u0IlfHv/sBxE+PVdt+kUjCzqm5k6CAgAARawCAARRtAA==
Date:   Fri, 6 Nov 2020 08:58:23 +0000
Message-ID: <HK0PR06MB2786DAC99A56EA302EE969CAB2ED0@HK0PR06MB2786.apcprd06.prod.outlook.com>
References: <20201105120331.9853-1-chin-ting_kuo@aspeedtech.com>
        <20201105120331.9853-5-chin-ting_kuo@aspeedtech.com>
        <fd8fa472-53bb-c992-3dc2-5a984a439c07@kaod.org>
 <20201105161132.37eb3265@collabora.com>
In-Reply-To: <20201105161132.37eb3265@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: collabora.com; dkim=none (message not signed)
 header.d=none;collabora.com; dmarc=none action=none
 header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3306a213-ee16-4927-45cd-08d882321e3c
x-ms-traffictypediagnostic: HK2PR06MB3426:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK2PR06MB3426D15368E07625F42E9483B2ED0@HK2PR06MB3426.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uDSMZ8L4yq+YHUlOYBqM2SxV45ljI+GNxttBOtkT0Z4CpvChp+jTn3LtRVkKS9BwQejWEf4I++Yyk4YkFcIT14/Rz3O7shl+9czONsyNwfhS05WTzTGIUM+I+c/qv331ZDwdk54scHYv17q31n1exGYRS0tJqLPjARusUX49Z/YzEGRpBHuzx1VyPv9hm4+mmdo2OYknZUMHyS0wdKDrqCKoUwIm7DQhkNDc/UW+5zbgpiRfFtB3Iu2jdX3dptJf9CqAy34uI9jGJO3dlY8kTt+AbPQQOyLc4KyP3thJyp6tbYQHWfC+l0xCUc7TZzb0kKCLFhI4+Kn/ZD9HCV/shQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB2786.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39840400004)(376002)(346002)(396003)(7696005)(54906003)(55236004)(6506007)(8676002)(33656002)(66574015)(53546011)(55016002)(186003)(83380400001)(86362001)(5660300002)(9686003)(26005)(316002)(2906002)(7416002)(71200400001)(66476007)(64756008)(478600001)(107886003)(76116006)(52536014)(66556008)(66946007)(66446008)(8936002)(4326008)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Dh0EciNpj+6BNyzmKAOAIHwa+B+MmQsfqvNSW9Ac9kULLIpxcjOrhsi3+12XDQ2aI3quif7DdiUtN379u1AgIJe2skXxP9gLbqBUo5GipG2zgOlhJtoa01HaUwrSpzQmuqE0rdo2EGWA6MekqLc+LnOUrsWWyIwyrd+11DEjgnBMizMiMO5UVMMk1pYbUep0dtV03O6izXHUjSkHOqHZXjNvNYSzJKL3JzRo1kvO59K8sYpvpV8IzkFDD79X93/EAJkkyqTCBW4Y+5tZoe+LbuElr5PRXwSVejn+Jn/RBYsU3PMoBb7dHBMf+s6EeFccnLxyMJOaeesgDCgKEDk1XpvuZZbelvxPuZE7Spoz6/oXZr9QgbMn9oXf8ChtyJhTAS18UIfunFZSB/QA96d6anlTeUjhU8bg6fnCwMLg/GubClB2/UVdRCcg87LL/yqBTIh4nwtQmUFHFDMal1IR6+7in0IfmvCBo3moAXQgHLWZHXvEbcg90TPVFcd+FCS3jLy0CqFuV79vsUdw4HG+PvcpOwsmPBIGsT+0A+/cux3sPnGIGiUMNsySE6USHY4pdikBXsXDBWMJgRa0/yo0Y0gNx31RhgJrDsVreHEPIBvH/HPfyKXwuqIhFPLURGNMdOoUjmMxF/Bv/w4Vih/hRQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB2786.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3306a213-ee16-4927-45cd-08d882321e3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 08:58:23.9287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XhtAQzWSg2Co8LBi9xffNAPEt19Xt0QWyoMePljtsT+xEmz6gLKBM1Prsir2jbSShfYn72oz0qnDyVfZ3yWEYN/ry32TuomC0d/lVr4yZYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR06MB3426
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgQm9yaXMsDQoNClRoYW5rcyBmb3IgeW91ciBxdWljayByZXBseS4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3JpcyBCcmV6aWxsb24gPGJvcmlzLmJyZXppbGxv
bkBjb2xsYWJvcmEuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgNSwgMjAyMCAxMTox
MiBQTQ0KPiBUbzogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz47IHJvYmgrZHRAa2Vy
bmVsLm9yZw0KPiBDYzogQ2hpbi1UaW5nIEt1byA8Y2hpbi10aW5nX2t1b0Bhc3BlZWR0ZWNoLmNv
bT47IGJyb29uaWVAa2VybmVsLm9yZzsNCj4gam9lbEBqbXMuaWQuYXU7IGFuZHJld0Bhai5pZC5h
dTsgYmJyZXppbGxvbkBrZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXNwZWVkQGxpc3RzLm96bGFi
cy5vcmc7IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7IEJNQy1TVw0KPiA8Qk1DLVNXQGFzcGVl
ZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW3YzIDQvNF0gc3BpOiBhc3BlZWQ6IEFkZCBBU1BF
RUQgRk1DL1NQSSBtZW1vcnkgY29udHJvbGxlcg0KPiBkcml2ZXINCj4gDQo+IEhpLA0KPiANCj4g
T24gVGh1LCA1IE5vdiAyMDIwIDE1OjA5OjExICswMTAwDQo+IEPDqWRyaWMgTGUgR29hdGVyIDxj
bGdAa2FvZC5vcmc+IHdyb3RlOg0KPiANCj4gPiBIZWxsbyBDaGluLVRpbmcsDQo+ID4NCj4gPiBU
aGFua3MgZm9yIHRoaXMgZHJpdmVyLiBJdCdzIG11Y2ggY2xlYW5lciB0aGFuIHRoZSBwcmV2aW91
cyBhbmQgd2UNCj4gPiBzaG91bGQgdHJ5IGFkZGluZyBzdXBwb3J0IGZvciB0aGUgQVNUMjUwMCBT
b0MgYWxzby4gSSBndWVzcyB3ZSBjYW4NCj4gPiBrZWVwIHRoZSBvbGQgZHJpdmVyIGZvciB0aGUg
QVNUMjQwMCB3aGljaCBoYXMgYSBkaWZmZXJlbnQgcmVnaXN0ZXIgbGF5b3V0Lg0KPiA+DQo+ID4g
T24gdGhlIHBhdGNoc2V0LCBJIHRoaW5rIHdlIHNob3VsZCBzcGxpdCB0aGlzIHBhdGNoIGluIHRo
cmVlIDoNCj4gPg0KPiA+ICAtIGJhc2ljIHN1cHBvcnQNCj4gPiAgLSBBSEIgd2luZG93IGNhbGN1
bGF0aW9uIGRlcGVuZGluZyBvbiB0aGUgZmxhc2ggc2l6ZQ0KPiA+ICAtIHJlYWQgdHJhaW5pbmcg
c3VwcG9ydA0KPiANCj4gSSBkaWRuJ3QgbG9vayBjbG9zZWx5IGF0IHRoZSBpbXBsZW1lbnRhdGlv
biwgYnV0IGlmIHRoZSByZWFkIHRyYWluaW5nIHRyaWVzIHRvIHJlYWQNCj4gYSBzZWN0aW9uIG9m
IHRoZSBOT1IsIEknZCByZWNvbW1lbmQgZXhwb3NpbmcgdGhhdCBmZWF0dXJlIHRocm91Z2ggc3Bp
LW1lbQ0KPiBhbmQgbGV0dGluZyB0aGUgU1BJLU5PUiBmcmFtZXdvcmsgdHJpZ2dlciB0aGUgdHJh
aW5pbmcgaW5zdGVhZCBvZiBkb2luZyB0aGF0IGF0DQo+IGRpcm1hcCBjcmVhdGlvbiB0aW1lIChy
ZW1lbWJlciB0aGF0IHNwaS1tZW0gaXMgYWxzbyB1c2VkIGZvciBTUEkgTkFORHMNCj4gd2hpY2gg
dXNlIHRoZSBkaXJtYXAgQVBJIHRvbywgYW5kIHRoaXMgdHJhaW5pbmcgaXMgdW5saWtlbHkgdG8g
d29yayB0aGVyZSkuDQo+IA0KPiBUaGUgU1BJLU5PUiBmcmFtZXdvcmsgY291bGQgcGFzcyBhIHJl
YWQgb3AgdGVtcGxhdGUgYW5kIGEgcmVmZXJlbmNlIHBhdHRlcm4NCj4gc3VjaCB0aGF0IGFsbCB0
aGUgc3BpLW1lbSBkcml2ZXIgaGFzIHRvIGRvIGlzIGV4ZWN1dGUgdGhlIHRlbXBsYXRlIG9wIGFu
ZA0KPiBjb21wYXJlIHRoZSBvdXRwdXQgdG8gdGhlIHJlZmVyZW5jZSBidWZmZXIuDQo+IA0KDQpJ
IGFncmVlIGl0LiBCZWZvcmUsIEkgd2VyZSBub3QgYWJsZSB0byBmaW5kIGEgc3VpdGFibGUgbG9j
YXRpb24gdG8gaW1wbGVtZW50IHJlYWQgdHJhaW5pbmcgZmVhdHVyZS4NCkkgdGhpbmsgdGhhdCBJ
IGNhbiBhZGQgYSBTUEkgdGltaW5nIHRyYWluaW5nIGZ1bmN0aW9uIGluICJzcGlfY29udHJvbGxl
cl9tZW1fb3BzIiBzdHJ1Y3QgYW5kDQpjYWxsIGl0IGJ5IGEgd3JhcHBlciBmdW5jdGlvbiBjYWxs
ZWQgYXQgdGhlIGJvdHRvbSBvZiBzcGlfbm9yX3Byb2JlKCkgaW4gc3BpLW5vci5jLg0KTWF5YmUs
IFNQSS1OT1IgZnJhbWV3b3JrIGRvZXMgbm90IG5lZWQgdG8gcGFzcyByZWZlcmVuY2UgYnVmZmVy
IHNpbmNlIGNhbGlicmF0aW9uDQptZXRob2QgZGVwZW5kcyBvbiBlYWNoIFNvQyBpdHNlbGYgYW5k
IGJ1ZmZlciBzaXplIG1heSBiZSB2YXJpYW50Lg0KVGhlIGRldGFpbCBjYWxpYnJhdGlvbiBtZXRo
b2QgbWF5IGJlIGltcGxlbWVudGVkIGluIGVhY2ggU29DIFNQSSBkcml2ZXIuDQoNCkJlc2lkZXMs
IEkgYW0gdGhpbmtpbmcgYWJvdXQgdGhlIHBvc3NpYmlsaXR5IGZvciBhZGRpbmcgYSAic3BpX21l
bV9wb3N0X2luaXQiIGZ1bmN0aW9uIGluDQpzcGktbWVtIGZyYW1ld29yayBzaW5lIGZvciBzb21l
IFNvQ3MsIFNQSSBjb250cm9sbGVyIG5lZWRzIHRvIGFkanVzdCBzb21lIHNldHRpbmdzDQphZnRl
ciBnZXR0aW5nIFNQSSBmbGFzaCBpbmZvcm1hdGlvbi4NCg0KPiANCj4gPg0KPiA+IFdlIHNob3Vs
ZCBhdm9pZCBtYWdpYyB2YWx1ZXMgd2hlbiBzZXR0aW5nIHJlZ2lzdGVycy4gVGhpcyBpcyBjb25m
dXNpbmcNCj4gPiBhbmQgZGVmaW5lcyBhcmUgbXVjaCBiZXR0ZXIuDQo+ID4NCj4gPiBBU1QyNTAw
IHN1cHBvcnQgd2lsbCBiZSBhIGJpdCBjaGFsbGVuZ2luZyBiZWNhdXNlIEhXIGRvZXMgbm90IGFs
bG93DQo+ID4gdG8gY29uZmlndXJlIGEgMTI4TUIgQUhCIHdpbmRvdywgbWF4IGlzIDEyME1CIFRo
aXMgaXMgYSBidWcgYW5kIHRoZQ0KPiA+IHdvcmsgYXJvdW5kIGlzIHRvIHVzZSB1c2VyIG1vZGUg
Zm9yIHRoZSByZW1haW5pbmcgOE1CLiBTb21ldGhpbmcgdG8NCj4gPiBrZWVwIGluIG1pbmQuDQo+
IA0KPiBNb3N0IFNQSS1NRU0gY29udHJvbGxlcnMgZG9uJ3QgaGF2ZSBzdWNoIGEgYmlnIGRpcm1h
cCB3aW5kb3cgYW55d2F5LCBhbmQNCj4gdGhhdCBzaG91bGRuJ3QgYmUgYSBwcm9ibGVtLCBiZWNh
dXNlIHdlIGRvbid0IGV4cG9zZSB0aGUgZGlyZWN0IG1hcHBpbmcNCj4gZGlyZWN0bHkgKGFzIHdv
dWxkIGJlIGRvbmUgaWYgd2Ugd2VyZSB0cnlpbmcgdG8gc3VwcG9ydCBzb21ldGhpbmcgbGlrZSBY
SVApLg0KPiBUaGF0IG1lYW5zIHRoYXQsIGFzc3VtaW5nIHlvdXIgY29udHJvbGxlciBhbGxvd3Mg
Y29udHJvbGxpbmcgdGhlIGJhc2Ugc3BpLW1lbQ0KPiBhZGRyZXNzIHRoZSBkaXJlY3QgbWFwcGlu
ZyBwb2ludHMgdG8sIHlvdSBzaG91bGQgYmUgYWJsZSB0byBhZGp1c3QgdGhlIHdpbmRvdw0KPiBh
dCBydW50aW1lIGFuZCBtYWtlIGl0IHBvaW50IHdoZXJlIHlvdSByZXF1ZXN0ZWQuDQo+IA0KPiBO
b3RlIHRoYXQgZGlybWFwX3tyZWFkLHdyaXRlfSgpIGFyZSBhbGxvd2VkIHRvIHJldHVybiBsZXNz
IGRhdGEgdGhhbiByZXF1ZXN0ZWQNCj4gdGh1cyBzaW1wbGlmeWluZyB0aGUgY2FzZSB3aGVyZSBh
IHNwZWNpZmljIGFjY2VzcyByZXF1aXJlcyBhIHdpbmRvdw0KPiBhZGp1c3RtZW50IGluIHRoZSBt
aWRkbGUgb2YgYW4gcmVhZC93cml0ZSBvcGVyYXRpb24uDQoNClRoYW5rcyBmb3IgeW91ciByZW1h
aW5kZXIuDQoNCg0KQmVzdCBXaXNoZXMsDQpDaGluLVRpbmcNCg==
