Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B052A22FD
	for <lists+linux-spi@lfdr.de>; Mon,  2 Nov 2020 03:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgKBCTe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 1 Nov 2020 21:19:34 -0500
Received: from mail-eopbgr40059.outbound.protection.outlook.com ([40.107.4.59]:52910
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727498AbgKBCTd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 1 Nov 2020 21:19:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oq1IIWcMp59VjYrLFweJcTqr01gLKF6+kvNzciW8NjT5//Gx66SeyeeQbhgaIrks9EbyMVZHXw/+lKYhE7X6Pjx5Bm5CAOJdSdJ9Ad6fTf050xu2IaQygPD6RSMuY0CqCXmDNBqmF2psxm6DjVrUa+Usmis15cTaE0GQOXFb7oPxYb2K2ktAdLljOkXTOHRsKl2J/q34vxSX+P1wdjHbNm461K5B74+CKKLwN6kQN5GSLi0c8RtFkHdRMnFAl/Kw7mY2Xv+NxYYmAnyqdqfpHMOoCGgdaqnL/IkXlgqJAM0aqLN9+iccV0gsYQq+Q1P88DejqibhWPJ8iklKJLAuPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ffem3QRw9HxhCOPe0tuLIiCGizXtgMTTY1pv1xcXOcg=;
 b=VBPrvZVhWaoEmI9LlrLJIOP/VcHF9oq1CfVfx/V7B4BhQfYOOZ3LZNSKB7eqU+h8bJ6/QF2gUtPlSc9e/mavD1v3FWUNjOtpg4nHqJQw2GFMfke9wo9u/Qo7h9qXHZ1l8kYwWHMaYECCv3bENoOpT1tDkQ9riVJBGi2PHwiLu87Z8+CwjrgEgJtWpv4Aa4b02rf5+ioeUJs2rjiSQs51dRflN3brTNX9Vn/WRsYe/bsT5tfchm/vu5RZgOizwTjPiROf6XHgkKZ4EBOI5sn1tojVVxJRa0eexllMFbBueHnDOQ1Tg41HruEe6LiTTU+ZE8uTeOeBqFblCV9WRjPjww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ffem3QRw9HxhCOPe0tuLIiCGizXtgMTTY1pv1xcXOcg=;
 b=en+aNg923czt07bssjF0L/KblusrT5ajL/SkY3ZG0h+a3jyswA38u/4VwIXoHlSFRL+BWm9dY/J+qBIpsClEzUinWenekVcZb99z3u3I+HOqaod/DI0QzE5pv17lgOVfZ/uLU1/XXDYdUjsw8yrazFsHppXHxbBeDp0s2V6B5rs=
Received: from VE1PR04MB6768.eurprd04.prod.outlook.com (2603:10a6:803:129::26)
 by VI1PR04MB4144.eurprd04.prod.outlook.com (2603:10a6:803:45::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 02:19:28 +0000
Received: from VE1PR04MB6768.eurprd04.prod.outlook.com
 ([fe80::f16e:a79:2203:5d35]) by VE1PR04MB6768.eurprd04.prod.outlook.com
 ([fe80::f16e:a79:2203:5d35%6]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 02:19:28 +0000
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     Vladimir Oltean <olteanv@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] spi: fsl-dspi: fix NULL pointer dereference
Thread-Topic: [PATCH] spi: fsl-dspi: fix NULL pointer dereference
Thread-Index: AQHWrdB51nJYwHeGTEukPNQ8v2xIXamwIq4AgAP98WA=
Date:   Mon, 2 Nov 2020 02:19:28 +0000
Message-ID: <VE1PR04MB67686E6B184C4EC4076172AE91100@VE1PR04MB6768.eurprd04.prod.outlook.com>
References: <20201029084035.19604-1-qiang.zhao@nxp.com>
 <20201030131828.7h25eps7wuf655eh@skbuf>
In-Reply-To: <20201030131828.7h25eps7wuf655eh@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7acac0d7-d000-460c-7f4e-08d87ed5b9e5
x-ms-traffictypediagnostic: VI1PR04MB4144:
x-microsoft-antispam-prvs: <VI1PR04MB414424C165998C91EE85327291100@VI1PR04MB4144.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: srorWgCQzaOSbTAEmAGD0zxtoeLf9Rix1hdWBauy90nA6zkX/A30fYRsliqYbkYjMLI7p5lfZp6n8GjjplP5OtM5aITvqn6I/CGPE+jfpH+2ZYzRzj5I56J+pxJBRJmFbZC77Lvr9BZSSinMNh5Ug/FuCwfgdU8tuUURfLdKWJKp/paFEHs29ys8Cgs9klxYmD1l0i/9b+Bd4ze4eFZjiYXyAFu2XH8D/Ohq/UVfRuTV8BzS+995CIp0MrvjKt/JG/UYnA3cDx4EOgq4oAtQ7bMgevIrNBAPuX8YxAZTDxHiN0P+u/jXefo7Vcfe7pm3TBJQ5NVMhvvJD7MlikMncw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6768.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(44832011)(33656002)(26005)(53546011)(5660300002)(8676002)(478600001)(66946007)(110136005)(7696005)(316002)(2906002)(186003)(86362001)(71200400001)(76116006)(9686003)(54906003)(66476007)(55016002)(66556008)(66446008)(64756008)(8936002)(6506007)(52536014)(4326008)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: GRuoWXg/nbxqkko3y4MAkwgaJVasRizmvbJeg90X9jpjdELqAcR/4d89uZx9aMK4lg5HmUhaTR8AXpgxkaui2+s1E8c7ifhdPHulPEFMBbC+JIKmSGcfjimL9TkNCPGhWtts4CVUgxljgkrcjIwqkyhckxfAJaL2Scia4UO29b0i9GMdsFMx8n69IyfFH1+YEVWLSJorKewqHzN8p5sE7rMR91LSfyaBlDkd0EpoiR7fiw9IfbVqgEVhgpWwuMCM/4wOtFpaVNd+AA0b6aAlw0o11Ua2aBoYjHQps277r9sBdftcFwq+AIQV8OT5LHXzGtshkcopEnBlCSJGP+AiHA7AvDz4LxQYauLw7lgTd+7/4K4qBKEBXY3hfxkjPFmY8Hibwab7HEmkqObDnIzEcN2bXtGD6oJdPOMH/FxKwmizo0I8raaR5Ju9RnUoDKRN+HQBCgt+MvlN39J33y09r+CuqubWcqhugtgA4UUtFhZHklQTKg/6hzqqin+kwJk4wjZhDom4qAgCAdAkqnaDDRZtAv1TJn92FGSgb5yiHyTyG4wcyE8igx/SEZc2QMYC/7DQe0MImZFVBely0L26bwwAv5rz4oUG9jqYuJRNk4EUPNSRY6snIAaF7Gm/J6ysQMpuhKJK7A3a7IHZ+jcjrg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6768.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7acac0d7-d000-460c-7f4e-08d87ed5b9e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 02:19:28.4104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mL4WhRhvi7RzMVBvY0uym02jMgBsP+fW9ZicFVnbrNT8/X3CafwYDfsMyDBzyLLx9FxB6V3wpXoRhapsyBSUkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4144
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gVGh1LCBPY3QgMzAsIDIwMjAgYXQgMjE6MThQTSArMDgwMCwgVmxhZGltaXIgT2x0ZWFuIDxv
bHRlYW52QGdtYWlsLmNvbT4gd3JvdGU6DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogVmxhZGltaXIgT2x0ZWFuIDxvbHRlYW52QGdtYWlsLmNvbT4NCj4gU2VudDogMjAy
MMTqMTDUwjMwyNUgMjE6MTgNCj4gVG86IFFpYW5nIFpoYW8gPHFpYW5nLnpoYW9AbnhwLmNvbT4N
Cj4gQ2M6IGJyb29uaWVAa2VybmVsLm9yZzsgbGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsNCj4g
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBzcGk6
IGZzbC1kc3BpOiBmaXggTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlDQo+IA0KPiBPbiBUaHUsIE9j
dCAyOSwgMjAyMCBhdCAwNDo0MDozNVBNICswODAwLCBRaWFuZyBaaGFvIHdyb3RlOg0KPiA+IEZy
b206IFpoYW8gUWlhbmcgPHFpYW5nLnpoYW9AbnhwLmNvbT4NCj4gPg0KPiA+IFNpbmNlIGNvbW1p
dCA1MzBiNWFmZmM2NzUgKCJzcGk6IGZzbC1kc3BpOiBmaXggdXNlLWFmdGVyLWZyZWUgaW4NCj4g
PiByZW1vdmUgcGF0aCIpLCB0aGlzIGRyaXZlciBjYXVzZXMgYSBrZXJuZWwgb29wczoNCj4gPg0K
PiA+IFsgICA2NC41ODc0MzFdIFVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBk
ZXJlZmVyZW5jZSBhdA0KPiA+IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwMDAwMDAwMDIwDQo+ID4g
Wy4uXQ0KPiA+IFsgICA2NC43NTYwODBdIENhbGwgdHJhY2U6DQo+ID4gWyAgIDY0Ljc1ODUyNl0g
IGRzcGlfc3VzcGVuZCsweDMwLzB4NzgNCj4gPiBbICAgNjQuNzYyMDEyXSAgcGxhdGZvcm1fcG1f
c3VzcGVuZCsweDI4LzB4NzANCj4gPg0KPiA+IFRoaXMgaXMgYmVjYXVzZSBzaW5jZSB0aGlzIGNv
bW1pdCwgdGhlIGRyaXZlcnMgcHJpdmF0ZSBkYXRhIHBvaW50IHRvDQo+ID4gImRzcGkiIGluc3Rl
YWQgb2YgImN0bHIiLCB0aGUgY29kZXMgaW4gc3VzcGVuZCBhbmQgcmVzdW1lIGZ1bmMgd2VyZQ0K
PiA+IG5vdCBtb2RpZmllZCBjb3JyZXNwb25kbHkuDQo+ID4NCj4gPiBGaXhlczogNTMwYjVhZmZj
Njc1ICgic3BpOiBmc2wtZHNwaTogZml4IHVzZS1hZnRlci1mcmVlIGluIHJlbW92ZQ0KPiA+IHBh
dGgiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFpoYW8gUWlhbmcgPHFpYW5nLnpoYW9AbnhwLmNvbT4N
Cj4gPiAtLS0NCj4gDQo+IFJldmlld2VkLWJ5OiBWbGFkaW1pciBPbHRlYW4gPG9sdGVhbnZAZ21h
aWwuY29tPg0KPiANCj4gUGxlYXNlIHJlc2VuZCB3aXRoIE1hcmsncyBjb21tZW50LiBJIHdvdWxk
IHByZWZlciB0aGF0IHlvdSBldmVuIHJlbW92ZSB0aGUNCj4gc3RhY2sgdHJhY2UgY29tcGxldGVs
eSBhbmQgbWFrZSBpdCBtb3JlIG9idmlvdXMgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIGl0c2VsZg0K
PiB0aGF0IHRoZSBOVUxMIHBvaW50ZXIgb2NjdXJzIGR1cmluZyBzdXNwZW5kL3Jlc3VtZS4NCj4g
U29tZWhvdyB0aGF0IG1hbmFnZWQgdG8gZ2V0IG9ic2N1cmVkIGluIHlvdXIgY3VycmVudCB2ZXJz
aW9uLiBJdCBpcyBhbHNvIG5vdA0KPiBoZWxwZnVsIGF0IGFsbCB0aGF0IHRoZXJlIGFscmVhZHkg
ZXhpc3RzIGEgY29tbWl0IHRpdGxlZCAnc3BpOg0KPiBmc2wtZHNwaTogZml4IE5VTEwgcG9pbnRl
ciBkZXJlZmVyZW5jZScgb24gdGhpcyBkcml2ZXIuIFRoaXMgY2F1c2VzIGNvbmZ1c2lvbiBmb3IN
Cj4gYmFja3BvcnRlcnMuIFBsZWFzZSBwcm92aWRlIGEgdW5pcXVlIGNvbW1pdCBtZXNzYWdlLg0K
PiBUaGFua3MuDQoNCkhvdyBhYm91dCBpdCBsb29rcyBsaWtlIGJlbG93Og0KDQogICAgc3BpOiBm
c2wtZHNwaTogZml4IHdyb25nIHBvaW50ZXIgaW4gc3VzcGVuZC9yZXN1bWUNCg0KICAgIFNpbmNl
IGNvbW1pdCA1MzBiNWFmZmM2NzUgKCJzcGk6IGZzbC1kc3BpOiBmaXggdXNlLWFmdGVyLWZyZWUg
aW4NCiAgICByZW1vdmUgcGF0aCIpLCB0aGlzIGRyaXZlciBjYXVzZXMgYSAiTlVMTCBwb2ludGVy
IGRlcmVmZXJlbmNlIg0KICAgIGluIGRzcGlfc3VzcGVuZC9yZXN1bWUuDQogICAgVGhpcyBpcyBi
ZWNhdXNlIHNpbmNlIHRoaXMgY29tbWl0LCB0aGUgZHJpdmVycyBwcml2YXRlIGRhdGEgcG9pbnQg
dG8NCiAgICAiZHNwaSIgaW5zdGVhZCBvZiAiY3RsciIsIHRoZSBjb2RlcyBpbiBzdXNwZW5kIGFu
ZCByZXN1bWUgZnVuYyB3ZXJlDQogICAgbm90IG1vZGlmaWVkIGNvcnJlc3BvbmRseS4NCg0KDQpC
ZXN0IFJlZ2FyZHMsDQpRaWFuZyBaaGFvDQo=
