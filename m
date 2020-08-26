Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D210F252C3F
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 13:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgHZLLJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 07:11:09 -0400
Received: from mail-eopbgr60059.outbound.protection.outlook.com ([40.107.6.59]:10880
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728605AbgHZLKy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 26 Aug 2020 07:10:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqbDMHOtXWw3yL89Ol7L8RfmHD7sVCvweC0LqHBjIrjkdOZs4hR1L+Y6coDtFx4Mw8YGK4XBafPftObWpSeGyHkYkR0lJFanrsSY6V/Plk6Z52jthpAsUMyy2ahGWVdmitRzjCqc/R9VXvaumaeoxDn2RB81lwGhkz8E1Ja3+ijmP1GU9Y+p7wTAApfJEB8sDJJi8IOG7xZtJXecZNZj5Fy2Ha1tAZuh6BP0uJClnAZuLf0TG2kvT2EQw3m1xfEg7fwB+QZvrmhdtJ5m+OWMdRnTUKSO+6rNeb8EAL9PnQNLk8JyX8WCJZsjVYC4F9yiiuirsfHlmRSzrmu5eHpqWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aShRtZ/i4a0JRQIZe1s1tTsfWNmLK1TBge2Ud4JUX8g=;
 b=knHIW6rSsXiwAXxg+pTwcyN9wN6MNHVxwahGvyle0YAYogOEO8mcu6aCBCsZO2InZzICZhIH+oy4qeDqP5NBOdyDVhzPNErfGqlK9ehGZewzLlV1nVV6EteyPWT1tQ5PbelSKdmUIcdefOyyU4uFZgWVAKQmIdkG+vMH8lkdl4ChMVB7cFCAfXKO8m1hK80UbyN+yy3dPkn19599RU2kR7mVpEuiiqjU0c4qkJHb0QqhNZQmY4N5HL8Mq5j5zlAVMeb7cKP9uZS6PIWUefUXMm5ZjdLvTrUqRmSERL2OaogjfdIsDysVTfJ8oC5i8Oe/EEon7KuyvR1IQ1rl8HHHhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aShRtZ/i4a0JRQIZe1s1tTsfWNmLK1TBge2Ud4JUX8g=;
 b=O8v0lHtvm4lK/qQlD5eh4y1AtkKunSGJNO/2eQC40PJP3igb19X+HnQPU8+JJ1Vipp2Ir+qy3mzVHcDWI+gFR8bD+oMLjesCE7mAA7kYRevzJSl9DaQzPO1YOYtagSpeEzeKp+b/0g6h5cGh0CgHLp7tO/oNAV/B16oP1YZWcEQ=
Received: from VE1PR04MB6768.eurprd04.prod.outlook.com (2603:10a6:803:129::26)
 by VI1PR04MB6336.eurprd04.prod.outlook.com (2603:10a6:803:f2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 26 Aug
 2020 11:10:49 +0000
Received: from VE1PR04MB6768.eurprd04.prod.outlook.com
 ([fe80::9149:1826:669a:4d6f]) by VE1PR04MB6768.eurprd04.prod.outlook.com
 ([fe80::9149:1826:669a:4d6f%7]) with mapi id 15.20.3305.026; Wed, 26 Aug 2020
 11:10:49 +0000
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     Vladimir Oltean <olteanv@gmail.com>,
        kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
CC:     Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Tanveer Alam <tanveer.alam@puresoftware.com>
Subject: RE: [PATCH] spi: spi-fsl-dspi: Add ACPI support
Thread-Topic: [PATCH] spi: spi-fsl-dspi: Add ACPI support
Thread-Index: AQHWd7yts7Mn+npl8U6aqlpS6I2eY6lCmUmAgAGSXICAABSlAIAGAgyQ
Date:   Wed, 26 Aug 2020 11:10:49 +0000
Message-ID: <VE1PR04MB6768699B6D7A507A5BF82F9191540@VE1PR04MB6768.eurprd04.prod.outlook.com>
References: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
 <20200821140718.GH4870@sirena.org.uk>
 <c810740d75f64e308fd362e6c6a5f437@mail.gmail.com>
 <20200822152118.rlwbcgfk4abjldtg@skbuf>
In-Reply-To: <20200822152118.rlwbcgfk4abjldtg@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [123.118.73.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8e197f9-2d1c-4a21-3c67-08d849b0b092
x-ms-traffictypediagnostic: VI1PR04MB6336:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB6336E61718ED2B2A507CAFFA91540@VI1PR04MB6336.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P7GQs4TpvcFWx1o44u/CV1Lpc1Xnu8YE1YhZmoYSqrHA32L1xNpH3AjFTx+tKPojSo9+LD3aiOfD8vwb+QkZtc2fsuE0l92oxdIOr3cMuWzreRufQDzEKeN03op6J5O+qN9XUKSBIm4B/ICwotH4nUHax5lHGN0NQPFb9x8bkIxr206BDfwyFPJ+zxmZL/q/HOgXACh1hf5nTT4sS8o3lPjfWtIPYwKACm4gbFZuo0OMdcGFWSJOwI0gVa09keAx8TIBogCNFXBMoOfxr0KXj0MvndNdEO6ixjlNBryIKV3TtCH3AFP5wtPwSq5xdl5LROB54wTgUAVVHeJwUQuPlP2zstNYBrpLbR2/tXRuVCjypa90Xm3oWoKydN1QgXOI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6768.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(83380400001)(66446008)(66476007)(66556008)(71200400001)(66946007)(76116006)(64756008)(6506007)(316002)(7696005)(26005)(54906003)(86362001)(110136005)(186003)(53546011)(2906002)(8936002)(4326008)(8676002)(478600001)(5660300002)(33656002)(9686003)(55016002)(52536014)(44832011)(9126004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: jxextnOvs6HZyZVxYf6/nARzWKJwF/M+UKdQKD3Ss7lmDY/dI508RwQag4ugSXPm4uVxP1v7AbQurl6+sIEkekv9G1W9+PUDvcwuYkt0b7aQfPRQbCSW/KITMw4zcVSrTdeK07ehlz2Xrjf3VaI0h0hMNvftRLzHxJprRqy2qoodwIW7XQrmg8ZyTdSDA0gOryb0eioOfYV3i6MCagB3mTIFKggdsZ7ezRqL9iP5ynbo3m6DVqrcJJPZNR66x+o+6uSDQZelwCWf774GFlpyXiXeYDqAQsE9qosXgApKjaRSAYR23/5NMf1Mc8ftxtYOO8nNBmCEO/tru2QJNulf3p+1mUsTEK86tdOhN/b+OzCR1XjxVYd3W+tIQBf2Joz/jhSjFS/oBaOsgy3NeWF5T8VmZno+RYTw3svmYAK0Z5lzzblG2Ea0c2qx0b5CXMa6rNzAxic8OOIzZRwywMG9P4s0i3YbJZ+rwDWLIs1C+RqMlaOwEW7z5dp9jxFs5UTXLLYEMDbRs7aiJRiT2pBFUDRYrS/1qBrp00TPJWh3vZXSAxddXJ1m53C+F8m7PzUZbntLG61I0W5bHR2Xl+jeopcUCcccA3fgULJf2wQFGqBw3VoHlrIYTgTvYTs0P1aqE+eE93qho3o4If2N2rqf5Q==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6768.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e197f9-2d1c-4a21-3c67-08d849b0b092
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 11:10:49.6611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jtn6iOHdXj0X9vYxicn932Zfs6WRw1cvQt12j5+yijR16BFDMbXIfoZJNB5910xti8j+nseDrO3u46wQOG4BHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6336
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gU2F0LCBBdWcgMjIsIDIwMjAgYXQgMjM6MjFQTSwgVmxhZGltaXIgT2x0ZWFuIDxvbHRlYW52
QGdtYWlsLmNvbT4gd3JvdGU6DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogVmxhZGltaXIgT2x0ZWFuIDxvbHRlYW52QGdtYWlsLmNvbT4NCj4gU2VudDogMjAyMMTqONTC
MjLI1SAyMzoyMQ0KPiBUbzoga3VsZGlwIGR3aXZlZGkgPGt1bGRpcC5kd2l2ZWRpQHB1cmVzb2Z0
d2FyZS5jb20+DQo+IENjOiBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+OyBsaW51eC1z
cGlAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBRaWFu
ZyBaaGFvIDxxaWFuZy56aGFvQG54cC5jb20+OyBQYW5rYWoNCj4gQmFuc2FsIDxwYW5rYWouYmFu
c2FsQG54cC5jb20+OyBWYXJ1biBTZXRoaSA8Vi5TZXRoaUBueHAuY29tPjsgVGFudmVlcg0KPiBB
bGFtIDx0YW52ZWVyLmFsYW1AcHVyZXNvZnR3YXJlLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SF0gc3BpOiBzcGktZnNsLWRzcGk6IEFkZCBBQ1BJIHN1cHBvcnQNCj4gDQo+IE9uIFNhdCwgQXVn
IDIyLCAyMDIwIGF0IDA3OjM3OjI1UE0gKzA1MzAsIEt1bGRpcCBEd2l2ZWRpIHdyb3RlOg0KPiA+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IE1hcmsgQnJvd24gPGJy
b29uaWVAa2VybmVsLm9yZz4NCj4gPiA+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDIxLCAyMDIwIDc6
MzcgUE0NCj4gPiA+IFRvOiBrdWxkaXAgZHdpdmVkaSA8a3VsZGlwLmR3aXZlZGlAcHVyZXNvZnR3
YXJlLmNvbT4NCj4gPiA+IENjOiBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBRaWFuZw0KPiA+ID4gWmhhbyA8cWlhbmcuemhhb0BueHAuY29t
PjsgUGFua2FqIEJhbnNhbCA8cGFua2FqLmJhbnNhbEBueHAuY29tPjsNCj4gPiA+IFZhcnVuIFNl
dGhpIDxWLlNldGhpQG54cC5jb20+OyB0YW52ZWVyDQo+ID4gPiA8dGFudmVlci5hbGFtQHB1cmVz
b2Z0d2FyZS5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBzcGk6IHNwaS1mc2wtZHNw
aTogQWRkIEFDUEkgc3VwcG9ydA0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgQXVnIDIxLCAyMDIwIGF0
IDA2OjQwOjI5UE0gKzA1MzAsIGt1bGRpcCBkd2l2ZWRpIHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4g
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgYWNwaV9kZXZpY2VfaWQgZnNsX2RzcGlfYWNwaV9pZHNbXSA9
IHsNCj4gPiA+ID4gKwl7ICJOWFAwMDA1IiwgLmRyaXZlcl9kYXRhID0NCj4gPiAoa2VybmVsX3Vs
b25nX3QpJmRldnR5cGVfZGF0YVtMUzIwODVBXSwgfSwNCj4gPiA+ID4gKwl7fSwNCj4gPiA+ID4g
K307DQo+ID4gPiA+ICtNT0RVTEVfREVWSUNFX1RBQkxFKGFjcGksIGZzbF9kc3BpX2FjcGlfaWRz
KTsNCj4gPiA+DQo+ID4gPiBEb2VzIE5YUCBrbm93IGFib3V0IHRoaXMgSUQgYXNzaWdubWVudCBm
cm9tIHRoZWlyIG5hbWVzcGFjZT8gIEFDUEkNCj4gPiA+IElEcyBzaG91bGQgYmUgbmFtZXNwYWNl
ZCBieSB3aG9ldmVyJ3MgYXNzaWduaW5nIHRoZSBJRCB0byBhdm9pZA0KPiA+ID4gY29sbGlzaW9u
cy4NCj4gPiBZZXMsIEkgZ290IEhJRCBmcm9tIE5YUCBvbmx5Lg0KPiA+ID4NCj4gPiA+ID4gLQkJ
cmV0ID0gb2ZfcHJvcGVydHlfcmVhZF91MzIobnAsICJzcGktbnVtLWNoaXBzZWxlY3RzIiwNCj4g
PiAmY3NfbnVtKTsNCj4gPiA+ID4gKwkJaWYgKGlzX2FjcGlfbm9kZShwZGV2LT5kZXYuZndub2Rl
KSkNCj4gPiA+ID4gKwkJCXJldCA9IGRldmljZV9wcm9wZXJ0eV9yZWFkX3UzMigmcGRldi0+ZGV2
LA0KPiA+ID4gPiArCQkJCQkic3BpLW51bS1jaGlwc2VsZWN0cyIsICZjc19udW0pOw0KPiA+ID4g
PiArCQllbHNlDQo+ID4gPiA+ICsJCQlyZXQgPSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihucCwNCj4g
PiA+ID4gKwkJCQkJInNwaS1udW0tY2hpcHNlbGVjdHMiLCAmY3NfbnVtKTsNCj4gPiA+DQo+ID4g
PiBUaGUgd2hvbGUgcG9pbnQgd2l0aCB0aGUgZGV2aWNlIHByb3BlcnR5IEFQSSBpcyB0aGF0IGl0
IHdvcmtzIHdpdGgNCj4gPiA+IGJvdGggRFQgYW5kIEFDUEkgd2l0aG91dCBuZWVkaW5nIHNlcGFy
YXRlIHBhcnNpbmcsIHRob3VnaCBpbiB0aGlzDQo+ID4gPiBjYXNlIEknbSB3b25kZXJpbmcgd2h5
IHdlJ2QgbmVlZCB0byBzcGVjaWZ5IHRoaXMgaW4gYW4gQUNQSSBzeXN0ZW0NCj4gPiA+IGF0IGFs
bD8NCj4gPiBVbmRlcnN0b29kLiBXaWxsIHRha2UgY2FyZSBpbiB2MiBQQVRDSA0KPiA+ID4NCj4g
DQo+IElNTyB0aGVyZSBpcyB6ZXJvIHJlYXNvbiBmb3IgdGhlIGV4aXN0ZW5jZSBvZiB0aGUgInNw
aS1udW0tY2hpcHNlbGVjdHMiDQo+IHByb3BlcnR5IGV2ZW4gZm9yIERULiBXZSBzaG91bGQgZGVw
cmVjYXRlIGl0IChzdGFydCBpZ25vcmluZyBpdCBpbiBleGlzdGluZyBkZXZpY2UNCj4gdHJlZSBk
ZXBsb3ltZW50cykgYW5kIHBvcHVsYXRlIHN0cnVjdCBmc2xfZHNwaV9kZXZ0eXBlX2RhdGEgd2l0
aCB0aGF0IGluZm8NCj4gYmFzZWQgb24gU29DIGNvbXBhdGlibGUgc3RyaW5nLg0KPiANCj4gPiA+
ID4gLQkJb2ZfcHJvcGVydHlfcmVhZF91MzIobnAsICJidXMtbnVtIiwgJmJ1c19udW0pOw0KPiA+
ID4gPiArCQlpZiAoaXNfYWNwaV9ub2RlKHBkZXYtPmRldi5md25vZGUpKSB7DQo+ID4gPiA+ICsJ
CQlyZXQgPSBkZXZpY2VfcHJvcGVydHlfcmVhZF91MzIoJnBkZXYtPmRldiwNCj4gPiA+ID4gKwkJ
CQkJCQkiYnVzLW51bSIsDQo+ID4gJmJ1c19udW0pOw0KPiA+ID4NCj4gPiA+IFRoaXMgaXMgYSBi
YWQgaWRlYSBmb3IgRFQgYW5kIEkgY2FuJ3QgdW5kZXJzdGFuZCB3aHkgeW91J2QgY2FycnkgaXQN
Cj4gPiA+IG92ZXIgZm9yIEFDUEkgLSB3aHkgd291bGQgYW4gQUNQSSBzeXN0ZW0gZXZlciBjYXJl
IGFib3V0IHRoaXM/ICBJdCdzDQo+ID4gPiBMaW51eCBpbnRlcm5hbCBhdCB0aGUgYmVzdCBvZiB0
aW1lcy4NCj4gPiBXaWxsIHRha2UgY2FyZSBpbiB2MiBQQVRDSA0KPiANCj4gWWVzLCBkZWZpbml0
ZWx5IGJsb2F0d2FyZSBmcm9tIHRoZSBvbGQgZGF5cy4gSSB0aGluayB0aGlzIGRyaXZlciBuZWVk
cyB0aGUgZXhpc3RpbmcNCj4gZGV2aWNlIHRyZWUgYmluZGluZ3MgcmV0aG91Z2h0IGEgbGl0dGxl
IGJpdCBiZWZvcmUgbWluZGxlc3NseSBwb3J0aW5nIHRoZW0gdG8NCj4gQUNQSS4NCg0KQ291bGQg
eW91IGdpdmUgbW9yZSBkZXRhaWxzPyAgDQoNCkJlc3QgUmVnYXJkcw0KUWlhbmcgWmhhbw0K
