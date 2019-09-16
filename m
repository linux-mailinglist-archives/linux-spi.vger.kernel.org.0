Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B431B3E85
	for <lists+linux-spi@lfdr.de>; Mon, 16 Sep 2019 18:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfIPQO0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Sep 2019 12:14:26 -0400
Received: from mail-eopbgr1310108.outbound.protection.outlook.com ([40.107.131.108]:12288
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727296AbfIPQOZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Sep 2019 12:14:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKYrZqDbAJKl3u8l80cyTY6oLZjuADl9849ybqHgcP6EKtE9wA0eyZnD3nYbENvp071KwjG4RhjSeYI29WTjYbxhoynx8/0o5Nbxm98rANrc2w6FwQfROMeukjsLA0Ke1FxSBIVfHpc7je10IqUU59RLjssbKGMuntj2Ha5qE44DH/Xsp5SHcShAXyTkhJnrDpK74KMQRbew+jFql5vFtPqw8UgiSbp3qotDj/S5wVcJCc3IAAje5jyUEh2JbsX8sTloY5TIFdVGTfFzsUj5oHZ66IjFhBFq28hBtFUAqahmyJfzE8JIkjBThUUGK31QxjuwsiNwTL6Ks3QbM6trbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycEPsitl+OnSYfPfmYEkvvLV31pXrYu7RxIeKo1AIF4=;
 b=Ibu6EEv1qLiWeY6DwtU1Zx7WBkX1b7GzzUzRC0stdJqnWLcMcRHP7CSiPH8jAj6a1NJ/siBVD0OFQ0XHC4jr8qry570pUOcdiRvRsNk3e+vgQf7aIrik2wZGjcMln+MbGQUX66yrFrl4To7cLBAF+lLHEZ7m+ZmJ8+E4auwLhgAhrFjZHAM2R1x7qnddvZ9nc6GyMKiTb384PwbukiabYZqmNngOeFHT7N7ehXlXF6WnyqNCXgILMsZFpab7BZyv0mxK4ISYuEVy/g8nliBoewBtY6+K870xHgh4u+EVnIA8kO8khY2aHwebZVKBV+abFM+CgSJr9Job2HmYYOaSrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycEPsitl+OnSYfPfmYEkvvLV31pXrYu7RxIeKo1AIF4=;
 b=c/76u5Nmh8kr63VjzvtiR8FoKvXEAN0SdMPH3B/LzMq4v3nrr2Ie2meI3zbfFGEst0uTTm8UnGXtVE6Bv9aVZkhBRNGppzDhlSpIQeeoesuPLApDBBIDLg+QXz2WIOujrm/ZEAJwwAfJEd8E4wgy8amlW8W4o17M2nfZ1a50a/o=
Received: from TY2PR01MB2924.jpnprd01.prod.outlook.com (20.177.98.81) by
 TY2PR01MB2172.jpnprd01.prod.outlook.com (52.133.184.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.14; Mon, 16 Sep 2019 16:14:14 +0000
Received: from TY2PR01MB2924.jpnprd01.prod.outlook.com
 ([fe80::7ce4:f502:8430:51a]) by TY2PR01MB2924.jpnprd01.prod.outlook.com
 ([fe80::7ce4:f502:8430:51a%7]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 16:14:14 +0000
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Mark Brown <broonie@kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] spi: dw: Add basic runtime PM support
Thread-Topic: [PATCH 2/3] spi: dw: Add basic runtime PM support
Thread-Index: AQHVaiyPrIzLbApuDUKmNvonSB+n+KcuY8iAgAAXkJA=
Date:   Mon, 16 Sep 2019 16:14:13 +0000
Message-ID: <TY2PR01MB2924AA1B012C2D305EE5C9B7DF8C0@TY2PR01MB2924.jpnprd01.prod.outlook.com>
References: <1568376720-7402-1-git-send-email-gareth.williams.jx@renesas.com>
 <1568376720-7402-3-git-send-email-gareth.williams.jx@renesas.com>
 <CAMuHMdUnzmYEcp0B5MG7itB1JHtNL7Stj9S2EFB0U0y_naQVBQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUnzmYEcp0B5MG7itB1JHtNL7Stj9S2EFB0U0y_naQVBQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gareth.williams.jx@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6682273f-73d3-4e36-3f55-08d73ac0ea9f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:TY2PR01MB2172;
x-ms-traffictypediagnostic: TY2PR01MB2172:|TY2PR01MB2172:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB2172865EA5028D11D800F071DF8C0@TY2PR01MB2172.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(199004)(189003)(11346002)(9686003)(71200400001)(4326008)(478600001)(71190400001)(5660300002)(74316002)(6436002)(316002)(33656002)(66066001)(476003)(6916009)(305945005)(76116006)(66946007)(66556008)(66476007)(3846002)(186003)(55016002)(66446008)(64756008)(6116002)(7696005)(81156014)(8936002)(102836004)(2906002)(81166006)(76176011)(86362001)(52536014)(8676002)(25786009)(7736002)(26005)(54906003)(446003)(14454004)(14444005)(99286004)(6246003)(6506007)(53936002)(229853002)(256004)(486006)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR01MB2172;H:TY2PR01MB2924.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KMNujQD5rdd7p6+Jl1QMPeinsLgetXiCGvMQ72DOOAIaVONRC86EbZSsfTFNZdzRP92ni8bYeKaGlrAnayscE6RKE3s67YZjjS8vxJ+KJPZQmxtkG1tILiKzuxfl+iRtP+fz9SodMUOUo4UiqtdVtpWRtoP+c2tGlIrhjGGggSbA7ucsxe/JKPBDAwGZIQseydaXtwudz5h8CwmHgi74w2sP9y2b3wIicPG8grMEg8OE61Ju6Vm/Y8zWHmEYbjWuVdIeeSB0bgCaYetfLQBmE5CK2rzu4q/McxsHElxc1CB1p3h2YJw3UvzubGkIYCi95DJkCNpRzNTLSg824CYFSAZ2o94J+BuQgHe8hQ4F8Vx70Yo6ozyUvEJjmBOlbxnTUHO17nOPlp+JubmQRIWpu/ISAs29KUVQaH8K57V6Jz8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6682273f-73d3-4e36-3f55-08d73ac0ea9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 16:14:13.4474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JLAWeSxQSutpudYeY/rrdBiHm45ZiOp1jl7UVL/AKL42E6mUoMc+GM+NLRCW0A3hsDrp4/MQfj7pgctLm967sbxSFSbtj+iWd3fVPbpyDGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2172
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgR2VlcnQsDQoNCkkgYXBwcmVjaWF0ZSB0aGUgZmVlZGJhY2suDQoNCj4gT24gTW9uLCBTZXAg
MTYsIDIwMTkgYXQgMTU6MzYgUE0gR2VlcnQgVXl0dGVyaG9ldmVuDQo+IDxnZWVydEBsaW51eC1t
NjhrLm9yZz4gd3JvdGU6DQo+IEhpIEdhcmV0aCwNCj4gDQo+IE9uIEZyaSwgU2VwIDEzLCAyMDE5
IGF0IDI6MTMgUE0gR2FyZXRoIFdpbGxpYW1zDQo+IDxnYXJldGgud2lsbGlhbXMuanhAcmVuZXNh
cy5jb20+IHdyb3RlOg0KPiA+IEZyb206IFBoaWwgRWR3b3J0aHkgPHBoaWwuZWR3b3J0aHlAcmVu
ZXNhcy5jb20+DQo+ID4NCj4gPiBFbmFibGUgcnVudGltZSBQTSBzbyB0aGF0IHRoZSBjbG9jayB1
c2VkIHRvIGFjY2VzcyB0aGUgcmVnaXN0ZXJzIGluDQo+ID4gdGhlIHBlcmlwaGVyYWwgaXMgdHVy
bmVkIG9uIHVzaW5nIGEgY2xvY2sgZG9tYWluLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGhp
bCBFZHdvcnRoeSA8cGhpbC5lZHdvcnRoeUByZW5lc2FzLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBHYXJldGggV2lsbGlhbXMgPGdhcmV0aC53aWxsaWFtcy5qeEByZW5lc2FzLmNvbT4NCj4gDQo+
IFRoYW5rcyBmb3IgeW91ciBwYXRjaCENCj4gDQo+ID4gLS0tIGEvZHJpdmVycy9zcGkvc3BpLWR3
LmMNCj4gPiArKysgYi9kcml2ZXJzL3NwaS9zcGktZHcuYw0KPiA+IEBAIC0xMCw2ICsxMCw3IEBA
DQo+ID4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2hp
Z2htZW0uaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+ID4gKyNpbmNsdWRlIDxs
aW51eC9wbV9ydW50aW1lLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+ID4gICNp
bmNsdWRlIDxsaW51eC9zcGkvc3BpLmg+DQo+ID4NCj4gPiBAQCAtNDk3LDYgKzQ5OCw5IEBAIGlu
dCBkd19zcGlfYWRkX2hvc3Qoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QNCj4gZHdfc3BpICpk
d3MpDQo+ID4gICAgICAgICBpZiAoZHdzLT5zZXRfY3MpDQo+ID4gICAgICAgICAgICAgICAgIG1h
c3Rlci0+c2V0X2NzID0gZHdzLT5zZXRfY3M7DQo+ID4NCj4gPiArICAgICAgIHBtX3J1bnRpbWVf
ZW5hYmxlKGRldik7DQo+ID4gKyAgICAgICBwbV9ydW50aW1lX2dldF9zeW5jKGRldik7DQo+IA0K
PiBUaGUgc2Vjb25kIGxpbmUga2VlcHMgdGhlIGRldmljZSBwb3dlcmVkIGFsbCB0aGUgdGltZS4N
Cj4gV2hhdCBhYm91dCBzZXR0aW5nIHNwaV9jb250cm9sbGVyLmF1dG9fcnVudGltZV9wbSA9IHRy
dWUsIHNvIHRoZSBTUEkgY29kZQ0KPiBjYW4gbWFuYWdlIGl0cyBSdW50aW1lIFBNIHN0YXR1cz8N
ClRoYXQgbWFrZXMgc2Vuc2UgYW5kIHdvcmtzIG9uIHRhcmdldCwgSSB3aWxsIGNoYW5nZSB0aGlz
IGZvciBWMi4NCg0KPiANCj4gPiArDQo+ID4gICAgICAgICAvKiBCYXNpYyBIVyBpbml0ICovDQo+
ID4gICAgICAgICBzcGlfaHdfaW5pdChkZXYsIGR3cyk7DQo+ID4NCj4gDQo+IFdoYXQgYWJvdXQg
dGhlIGVycm9yIHBhdGg/DQo+IERvbid0IHlvdSBuZWVkIHRvIGRpc2FibGUgUnVudGltZSBQTSBh
Z2FpbiBpbiBkd19zcGlfcmVtb3ZlX2hvc3QoKT8NCkkgd2lsbCBhZGQgYSBjYWxsIHRvIGRpc2Fi
bGUgcG0gaW4gZHdfc3BpX3JlbW92ZV9ob3N0KCkgYW5kIHRoZSBlcnIgcGF0aCBpbg0KZHdfc3Bp
X2FkZF9ob3N0IGZvciB2Mi4gDQoNCj4gDQo+IEkgYXNzdW1lIHRoaXMgd2lsbCBiZSBjYWxsZWQg
ZnJvbSBkcml2ZXJzL3NwaS9zcGktZHctbW1pby5jLCB3aGljaCBhbHJlYWR5DQo+IGVuYWJsZXMg
dGhlIGNsb2NrIGV4cGxpY2l0bHkgYWxsIHRoZSB0aW1lcj8NClllcywgc3BpLWR3LW1taW8uYyBh
bHJlYWR5IGVuYWJsZXMgdGhlIGJ1cyBjbG9jaywgaG93ZXZlciB3ZSB3YW50IHRvIHVzZSBjbG9j
ayANCmRvbWFpbiB0byBlbmFibGUgdGhlIGNsb2NrIGFuZCBub3QgZXhwbGljaXRseSBwcm92aWRl
IHBjbGsgaW4gdGhlIGR0cy4gSWYgdGhlcmUgYXJlIA0Kbm8gb3RoZXIgdXNlcyBvZiB0aGF0IHBj
bGssIHdlIGNhbiByZW1vdmUgdGhhdCBsYXRlciBvbi4gDQoNCj4gDQo+IEdye29ldGplLGVldGlu
Z31zLA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdl
ZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0g
Z2VlcnRAbGludXgtDQo+IG02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25z
IHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0DQo+IHdo
ZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Ig
c29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAt
LSBMaW51cyBUb3J2YWxkcw0KDQoNCktpbmQgUmVnYXJkcywNCg0KR2FyZXRoDQo=
