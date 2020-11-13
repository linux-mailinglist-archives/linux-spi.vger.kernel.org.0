Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0DC2B1713
	for <lists+linux-spi@lfdr.de>; Fri, 13 Nov 2020 09:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgKMIRX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Nov 2020 03:17:23 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23578 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgKMIRW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Nov 2020 03:17:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605255441; x=1636791441;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=B1qOPJ93eu2DfcFCAsqtE2yC2b74c4kw8S7id5x1nss=;
  b=YLRLajyFkpaGEqzK64X//x0wxskK06Lz4XXy1iVGDQ4Q4DiDjfusV5sY
   tf68xN8tgvWuHqlfUmAX7EYX0GvKHs0fA0TK1BVXQM7XsAVsrWiNYLHZy
   03QvaqtewdF9Fvhb1jHAEF7iZxdHCWSExKwdjEU1zct+Yu37VKM+kicyK
   M1+PMehW0ZYwtD2odhCgHsHSt3zHI4u9Yzmagg/YTStl4Rbq4qELc4VP+
   oFf6+n5qeC7MhafmtSAB+liq3LXFcBWYmQHCU16B7SClwT7txLr0JMY6C
   AAL5hYWoCZLXEd32R6igZ+0PklV4Q0j6HnMgH0doU+qcZYATHJXlFJvNB
   A==;
IronPort-SDR: Abdgqh0AHD09BDAOi4v6xMgGR6PA5r3ijUttJbk5Nme0RHmkNOt8fF87ZkAUMB3pEBbIJCFFMm
 yAeHDnilFv8bYbSpg3IuFV65E60Rz4p9CDSlD4/nhWSD6TcOPKEFGMAUq6gDzB75IQh6PGD1VN
 uSRNz7aTqqOJyz6mio0Y0OVPxsctgEtbbJkIeRqKDK3s/h3HtG+bwCtkEkKZTauf/2tmjP3ub9
 mUJonsQKJOgAVUEansPZMLD2Nms8l9v4w1FFuDVnJk+iwJmrdK+J5ByPnfbcIEietQrVFchbu5
 a6s=
X-IronPort-AV: E=Sophos;i="5.77,475,1596470400"; 
   d="scan'208";a="152653323"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 13 Nov 2020 16:17:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5GyhdI8xwI6UR9HtqOBhK61oyE2YOmGW4Uq4668r+7R6chaRFin9Mc/kcucgOrGHtnebA+scUzM58gTBiqf9k0spzNBYqDIDN/wO70yS1PljsksBLRhIIPnAduUZ+Luk+LbSIc6i21XTmXxjAVUcPEshW92rn2EaD4lCt2uchjLO5g4i/H2SE/67lKDSKl1qBR5RxfNLwXi54Z1bO7h89yIlhd9YUMRhm67/BIHP4geDCZzuyU22EXwK+58nrAewN6SYoRjksIS5l0549sgvKb3vsFLOp1kG9fSuMg8eE16s+jRGF6blAD2zicJvCoBY6eJuevqB6qY3/RueYRO8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1qOPJ93eu2DfcFCAsqtE2yC2b74c4kw8S7id5x1nss=;
 b=hrJYx5I69kyesbqcUTm8uPW4MTaUoXPy0Hrwy/Wj4+mfPnVUqrMgr/76WtXR1D7WsuMfABlrcEiOYMeoqKyUD4AFz8oijP7N5GkhFHSd20PNXZj7q438mbMKmzOrbMF4TBBW4eUwzRVlgY860HFz+Fd9iGox21bT8AfEq2SwvSNyEl1rcay9iPPZAj9ps755i2s+5fVfJ8QNzE9EHUr87Sis4aMQim/5NxWHSAjaGxfUt35zAke+kfQVB0hrHNgUPytkYF2ysp+3bKAdO4lIKEMP3ZKOku7ojNZmLyyv7gZIweD54U6bhks9irrtVCLCDx/gpFH61jOGxDJMRClOqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1qOPJ93eu2DfcFCAsqtE2yC2b74c4kw8S7id5x1nss=;
 b=Z12agzjacZWACjfo8Nu9+AWeQCb0qH7As4BDlEGGI+rJRywqlZPlhvuJsVgtD15dn8tnvFjqL2rMPc8TPfZM15lZXjeBVllxDl7kZPIi+esV4M+AlJvmFGNpR2xAIUYOHoZYPZDa8cLzsIGvbUHmzgqqp92TO7c3OSs9raBPiIM=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6701.namprd04.prod.outlook.com (2603:10b6:208:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 08:17:19 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3499.032; Fri, 13 Nov 2020
 08:17:19 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "seanga2@gmail.com" <seanga2@gmail.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
Subject: Re: [PATCH 21/32] dt-bindings: Add Kendryte and Canaan vendor prefix
Thread-Topic: [PATCH 21/32] dt-bindings: Add Kendryte and Canaan vendor prefix
Thread-Index: AQHWtN4mKRuAhov4sUaXWKhVt6lq6qm8s7EAgAkNYAA=
Date:   Fri, 13 Nov 2020 08:17:19 +0000
Message-ID: <8b9468127b7b0cc447b6ae591047ab75f1b7bd07.camel@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
         <20201107081420.60325-22-damien.lemoal@wdc.com>
         <6fcfabd4-210a-c947-6151-4f8f3b3a9e25@gmail.com>
In-Reply-To: <6fcfabd4-210a-c947-6151-4f8f3b3a9e25@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.1 (3.38.1-1.fc33) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:8d3e:27aa:85c2:44b5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eab49cf4-54ef-4862-75c3-08d887ac8a26
x-ms-traffictypediagnostic: MN2PR04MB6701:
x-microsoft-antispam-prvs: <MN2PR04MB6701945C0BEE40CF848C18B4E7E60@MN2PR04MB6701.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rSPzmUBGizAHYZpGtTiKAvY1K/rTefL8MIbqdEWaMpkBqp3Vj77yr+MxXWMsodT2KGCJyPPuIlefLA6EpSbRPvMuq+ASBLUwnTKjm8l6Pv7cl2zaJthdvsOdgsVLfp0Uqgj4lbiDX0iOU/eBVMY+KagJVjPQxMy7JhYwpt98OU2oJXKzNGBxSPyyPQXUkdtnzC3n5atmZ+zno3aE7vpPeK4WcT0yhbyV6ImDSQNdccUT7rV2mUGyobiMCv8bdQAUZZsWnfWcGyJx/xIcYy44gwPdc89sJBe4S7/1bqNF9ExUQPsyF5pUJCaD262w0Ow85z1lrgRK2uhF2988YLu4o9JfqVM3PNQKYQtl5cE1K+DTtjF7U1FlzSUhMjRiU1Zy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(91956017)(83380400001)(64756008)(66946007)(186003)(76116006)(66446008)(5660300002)(66556008)(66476007)(8936002)(86362001)(316002)(6512007)(2906002)(6486002)(8676002)(53546011)(110136005)(36756003)(6506007)(7416002)(2616005)(71200400001)(921005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: yxdnDAXx4aeawyVDerOP7bT4iR7YM+U4PzHLlLFa4fYaEtQayl2cmoDN9JiOp+wL/iG77KBhwl1toTTqjnnoy+kZkNIUGpBD4jhLq5p9h68GfmHGdOLXp2nPmc7GSanD///dxD7fyObEyvEd8UmiPxsQ3pn0p9Ku0qekfqmPhpdUqSh5HQdiFKpBDHhGeNOoSTBfXkTUzzzg3OhPGQkq1j4Y8EM/nWrhlGq5GG26DUObzpwaNjBe4ZN6AhpTen/CtSyF8H+Pxa+Mnp7QUIBY67GFn+BAXuE1yJcdNsfaCIdwm/b1qR5Yddt1VtbnE4g2P1DVAqr7niVXZu948w6c6Nl9AFH7Wfvc0iX0/Ep7bfwFgQUt79tpeQBikONKy9b0W2rgDdtUp8m1cQl6fT/ebvFOJUOlkZh0jQxyR0uHRQOLTrUg3bYLU3pE0O7GtJ0WabmJI5qTB3T3OUeHYbOvn0VUjlfil7loUJedzTglyTx8qA1sdRG27PI5faNCN35m7E9W837FSQ0Kt0NLa3JkHCVfERuqJ5jlWIcYm5/MXEfsCy4v3dEzz/N5SojCN0ImudgX1z+AODYwsJex8m7YW7x1rDsTgH5UcXYz3zvAHvXFQTx4si9E1G5UDpIDBDuQmFKXFpTI/HTo7xIKN++8zwbYS88RSUJ2S5bqWwbvms+23T5eHIdOy92VjaCbwM3JjSlAOZ8Y/HgSreTy3Bc40g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C68AB59ADA8D6B4C80BA4E24E9D0C4A2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab49cf4-54ef-4862-75c3-08d887ac8a26
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2020 08:17:19.3188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bg3SCJbXUqNHnea6MRJbJZCUQs1uSOIHfXKDKfEpQQv4F6yE86Gt+q/3zb6IFCKOIY7GEYNwIFKEE//u5EA35A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6701
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gU2F0LCAyMDIwLTExLTA3IGF0IDA5OjAzIC0wNTAwLCBTZWFuIEFuZGVyc29uIHdyb3RlOg0K
PiBPbiAxMS83LzIwIDM6MTQgQU0sIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiA+IFVwZGF0ZSBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdmVuZG9yLXByZWZpeGVzLnlhbWwgdG8g
aW5jbHVkZQ0KPiA+ICJLZW5kcnl0ZSIgYW5kICJjYW5hYW4iIGFzIGEgdmVuZG9yIHByZWZpeCBm
b3IgIkNhbmFhbiBJbmMuIg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IERhbWllbiBMZSBNb2Fs
IDxkYW1pZW4ubGVtb2FsQHdkYy5jb20+DQo+ID4gLS0tDQo+ID4gwqBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvdmVuZG9yLXByZWZpeGVzLnlhbWwgfCA0ICsrKysNCj4gPiDCoDEg
ZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3ZlbmRvci1wcmVmaXhlcy55YW1sIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3ZlbmRvci1wcmVmaXhlcy55YW1sDQo+ID4g
aW5kZXggMjczNWJlMWE4NDcwLi5mNTNkNGQ4ZTdmMmEgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3ZlbmRvci1wcmVmaXhlcy55YW1sDQo+ID4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3ZlbmRvci1wcmVmaXhlcy55YW1s
DQo+ID4gQEAgLTE3OSw2ICsxNzksOCBAQCBwYXR0ZXJuUHJvcGVydGllczoNCj4gPiDCoMKgwqDC
oMKgZGVzY3JpcHRpb246IENBTEFPIFN5c3RlbXMgU0FTDQo+ID4gwqDCoMKgIl5jYWx4ZWRhLC4q
IjoNCj4gPiDCoMKgwqDCoMKgZGVzY3JpcHRpb246IENhbHhlZGENCj4gPiArICAiXmNhbmFhbiwu
KiI6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogQ2FuYWFuLCBJbmMuDQo+ID4gwqDCoMKgIl5jYW5p
bm9zLC4qIjoNCj4gPiDCoMKgwqDCoMKgZGVzY3JpcHRpb246IENhbmlub3MgTG91Y29zIFByb2dy
YW0NCj4gPiDCoMKgwqAiXmNhcGVsbGEsLioiOg0KPiA+IEBAIC01MzcsNiArNTM5LDggQEAgcGF0
dGVyblByb3BlcnRpZXM6DQo+ID4gwqDCoMKgwqDCoGRlc2NyaXB0aW9uOiBLYS1SbyBlbGVjdHJv
bmljcyBHbWJIDQo+ID4gwqDCoMKgIl5rZWl0aGtvZXAsLioiOg0KPiA+IMKgwqDCoMKgwqBkZXNj
cmlwdGlvbjogS2VpdGggJiBLb2VwIEdtYkgNCj4gPiArICAiXmtlbmRyeXRlLC4qIjoNCj4gPiAr
ICAgIGRlc2NyaXB0aW9uOiBDYW5hYW4sIEluYy4NCj4gPiDCoMKgwqAiXmtleW1pbGUsLioiOg0K
PiA+IMKgwqDCoMKgwqBkZXNjcmlwdGlvbjogS2V5bWlsZSBHbWJIDQo+ID4gwqDCoMKgIl5raGFk
YXMsLioiOg0KPiA+IA0KPiANCj4gU28gQUZBSUsgQ2FuYWFuIGlzIHRoZSBjb21wYW55LCBhbmQg
S2VuZHJ5dGUgaXMgdGhlIGJyYW5kLiBIb3dldmVyLCBJDQo+IHdhcyB1bmF3YXJlIG9mIHRoaXMg
d2hlbiBJIGRpZCBteSBpbml0aWFsIHBvcnRpbmcgd29yay4gU28gYWxsIHRoZQ0KPiBjb21wYXRp
YmxlIHN0cmluZ3MgbGlrZSAia2VuZHJ5dGUsazIxMC1mb28iIHNob3VsZCByZWFsbHkgYmUNCj4g
ImNhbmFhbixrZW5kcnl0ZS1rMjEwLWZvbyIuIFRoZXNlIF9zaG91bGRfIGFsbCBnZXQgZml4ZWQg
aW4gdGhlIGRldmljZQ0KPiB0cmVlLCBidXQgbm8gb25lIGhhcyBkb25lIGl0IHlldC4NCg0KSSBm
aXhlZCBldmVyeXRoaW5nIHVzaW5nICJjYW5hYW4sazIxMC1mb28iLCBhIGxpdHRsZSBzaG9ydGVy
IHRoYW4NCiJjYW5hYW4sa2VuZHJ5dGUtazIxMC1mb28iIChUaGUgImsiIGluIGsyMTAgYWxyZWFk
eSBwcm9iYWJseSBzdGFuZGluZyBmb3INCktlbmRyeXRlLi4uKS4gQnV0IEkgY2FuIHVzZSB0aGUg
bG9uZ2VyIHZlcnNpb24gdG9vLg0KDQpXaWxsIEkgd2FzIGF0IGl0LCBJIGFsc28gY2hhbmdlZCBk
aXJlY3RvcnkgbmFtZXMgYW5kIGNvbmZpZyBvcHRpb24gbmFtZXMgdG8NCmFsc28gdXNlIGNhbmFh
bi9DQU5BQU4gaW5zdGVhZCBvZiBrZW5kcnl0ZS9LRU5EUllURS4NCg0KDQo+IA0KPiAtLVNlYW4N
Cg0KLS0gDQpEYW1pZW4gTGUgTW9hbA0KV2VzdGVybiBEaWdpdGFsDQo=
