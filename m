Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715412A22DC
	for <lists+linux-spi@lfdr.de>; Mon,  2 Nov 2020 03:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgKBCBX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 1 Nov 2020 21:01:23 -0500
Received: from mail-eopbgr40068.outbound.protection.outlook.com ([40.107.4.68]:52380
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727409AbgKBCBX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 1 Nov 2020 21:01:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I179Mt8D3ClxN2EsfRFMgQ2w1gjcd3Siyp6u4Uuvikzik5PZbMSXF+oYOl1eA95k/tP4zZjXtCOWrBRUhpOZCQURspfEymIVLCd/7WWH6+Mya8VrNIJBLeK/25bJMIeV/S1oXAmEGV+3+EbWHNWHhNQ8e8oLzpHM5qWE6vuJ2fvdbNyfF4Xo2DYWHCsovlciAXMEmJpSzvE4snKbWfBQywvLOX6f8J3JfnO1qa7QfFgqWjL5WBRW8WNhTxG7yTDhNRHPjyhJUd95LxQWBYzzFUKiGQhmEgm6DiXljap65eCa42zNp6JG4cXd6pNEAKnBBUF4/q0xw65oto85uehSZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Enl4G4oAjM5vmHmgGqgj4rCCy6ZcdFBBIcZYgNnKerU=;
 b=ZWayv5EbBjKfRp0fTUgpkAVw3ROnG3LE8GHa0TVohRAstyn2lGmtCFtsgYDI2WIwE6CKV0w1hsBfYYgECRfJbYws+WVFNRzaj6aABEcPkXqgb2G1IHekmoPzRZsfOEUZLylPN2qMXy1zDb4WLY7havQ8n2u4hN/gbfEMThsXpmSyqdK9OHTSfNpG65IY7gIN2ig/zwm0IrGsjALhqWBiLNlG4YOwnRaT+3SAyDxbrL9CdnoaB+q0hwYTSlRyFnM1LPCUrg6htu0reFwrELNryvD5QxN7FJDZaVKJBYR3CUj8i6WwnOIsWALLik3e3VoHslP0z3Ecc+UI5Ptz5syx1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Enl4G4oAjM5vmHmgGqgj4rCCy6ZcdFBBIcZYgNnKerU=;
 b=ZAnqRp1W02Kio0qcZgo7LRNSe6o6Qd9sATYS89IEO/0/LjSypSty1mRWw90EbUy/08OTt9k5iJnXDlKcOyZCuqb3R6Ibqrc7B24MF7LdNxJ30pynbXM5rcVHx5swfO7ZR8PLAAx4OGIm2sLnuFjwahI5hSPniXHpKuuhH5XM5Is=
Received: from VE1PR04MB6768.eurprd04.prod.outlook.com (2603:10a6:803:129::26)
 by VE1PR04MB6432.eurprd04.prod.outlook.com (2603:10a6:803:122::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Mon, 2 Nov
 2020 02:01:19 +0000
Received: from VE1PR04MB6768.eurprd04.prod.outlook.com
 ([fe80::f16e:a79:2203:5d35]) by VE1PR04MB6768.eurprd04.prod.outlook.com
 ([fe80::f16e:a79:2203:5d35%6]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 02:01:19 +0000
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "olteanv@gmail.com" <olteanv@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] spi: fsl-dspi: fix NULL pointer dereference
Thread-Topic: [PATCH] spi: fsl-dspi: fix NULL pointer dereference
Thread-Index: AQHWrdB51nJYwHeGTEukPNQ8v2xIXamwHjEAgAP949A=
Date:   Mon, 2 Nov 2020 02:01:19 +0000
Message-ID: <VE1PR04MB6768AD4A197FB94209D63C0991100@VE1PR04MB6768.eurprd04.prod.outlook.com>
References: <20201029084035.19604-1-qiang.zhao@nxp.com>
 <20201030130224.GA8802@sirena.org.uk>
In-Reply-To: <20201030130224.GA8802@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b0b010a2-7246-4387-0745-08d87ed330ee
x-ms-traffictypediagnostic: VE1PR04MB6432:
x-microsoft-antispam-prvs: <VE1PR04MB6432B6164E3EDA0B9FFD363991100@VE1PR04MB6432.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ugMuRWo+dA5Zw5VQ4HhMvka5UTPPj4HDvqRf6NRelCCVA2UTa6m4NlJ9/B2xDilRHsN15hWQJRhTtPzq2yWUDeLfoQhCywAcoycujS9++LRjKRllQ2ya/tazXn+Y/Tr3+ktbtRijhWLfHnsY7Pa6FeNEwUmU+LZh8wBeoBpHKuA7YPKkcVEn9/QtV5aqSQJVeXlNjmp2A856dVQY4N0peXWNfFEMrcERZrY8xB3q5YDoYeU+iKhXU200zD/7mCcR0JRfWHjoI9poCeKxBbyFnpvBp44Iw8vUvAhkr3XNwXYu/yq0BZJNubC44ijgILoW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6768.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(6916009)(26005)(186003)(8676002)(478600001)(5660300002)(8936002)(52536014)(6506007)(53546011)(55016002)(9686003)(83380400001)(76116006)(2906002)(66446008)(64756008)(7696005)(66556008)(4326008)(66476007)(54906003)(44832011)(66946007)(316002)(86362001)(33656002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 1gSlOQ2htyyIWomA371IdCJ/NKJWr2kFSQM9FxAshTkuKS/HxYFwPcMbbrtlyNY7ZCUhdzXZA4xzQflYSTZDhGrLJvbD5fPua0eYhYuyr+2aI2+xwIP6D5852Fl17PvSCsXVfhknLTih7lfc+lmH4afef7AqzJ7E7wtxA9AkywgcvUIi0xC3GxEF+Z+stheJ2ngggpLRFgaKwHtslZAiPN825Rl9TVctAyVrCjpg0XRsCDzmuLrWZMpgJJM4tEzrH6fsvpIs3uAJ6skUBOEpQCOY+QSzWoy1lLRCcNQF5Olt5Ppm8a4G0Hq1po1c4ZJv0TO5/kTZJrWErTJ5fCnOnY5NDYvo6FJCVdT5GwtWjFNZTYmaQ0MUXwijBjE84Ptoa1K29RkK37SUAbN7TCiff0ibWjM9Z16j4tJRP75ll+M/vCfDei39anzxDPeA3vVFnKUrfY3uy/sUr2JY77yorsgdI/JwyKbOeV70XIzg0T8Uvaego9/TxqWqwYOGO4T3OIXSraw1yszVhD5Mzx62fc4WXiGYlngGTOA0GQu9WVv6dX1pz2EjnJi6zBJwgCFROEzar+I+uZWT5AUpfiOXyCPkS/+vHTtNe4q+z/pMeX0on9/dRcp0MMOanf51oXBE7/1FpK4/Y+robNYEWwtBbw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6768.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b010a2-7246-4387-0745-08d87ed330ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 02:01:19.5890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: REJlzsUpQrXzI/dGLIruIEuwlOIXWfzHJObchdR747+uBaOYob8AyXAaiqHE0JdQKXdFwl0xFGeepBLElf5zrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6432
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gVGh1LCBPY3QgMzAsIDIwMjAgYXQgMjE6MDJQTSwgTWFyayBCcm93biA8YnJvb25pZUBrZXJu
ZWwub3JnPiB3cm90ZToNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBN
YXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjDE6jEw1MIzMMjVIDIx
OjAyDQo+IFRvOiBRaWFuZyBaaGFvIDxxaWFuZy56aGFvQG54cC5jb20+DQo+IENjOiBvbHRlYW52
QGdtYWlsLmNvbTsgbGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBzcGk6IGZzbC1kc3BpOiBmaXgg
TlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlDQo+IA0KPiBPbiBUaHUsIE9jdCAyOSwgMjAyMCBhdCAw
NDo0MDozNVBNICswODAwLCBRaWFuZyBaaGFvIHdyb3RlOg0KPiANCj4gPiBbICAgNjQuNTg3NDMx
XSBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQNCj4g
PiB2aXJ0dWFsIGFkZHJlc3MgMDAwMDAwMDAwMDAwMDAyMA0KPiA+IFsuLl0NCj4gPiBbICAgNjQu
NzU2MDgwXSBDYWxsIHRyYWNlOg0KPiA+IFsgICA2NC43NTg1MjZdICBkc3BpX3N1c3BlbmQrMHgz
MC8weDc4DQo+ID4gWyAgIDY0Ljc2MjAxMl0gIHBsYXRmb3JtX3BtX3N1c3BlbmQrMHgyOC8weDcw
DQo+ID4gWyAgIDY0Ljc2NjEwN10gIGRwbV9ydW5fY2FsbGJhY2suaXNyYS4xOSsweDI0LzB4NzAN
Cj4gPiBbICAgNjQuNzcwNjM1XSAgX19kZXZpY2Vfc3VzcGVuZCsweGY0LzB4MmYwDQo+ID4gWyAg
IDY0Ljc3NDU1M10gIGRwbV9zdXNwZW5kKzB4ZWMvMHgxZTANCj4gPiBbICAgNjQuNzc4MDM2XSAg
ZHBtX3N1c3BlbmRfc3RhcnQrMHg4MC8weGEwDQo+ID4gWyAgIDY0Ljc4MTk1N10gIHN1c3BlbmRf
ZGV2aWNlc19hbmRfZW50ZXIrMHgxMTgvMHg0ZjANCj4gPiBbICAgNjQuNzg2NzQzXSAgcG1fc3Vz
cGVuZCsweDFlMC8weDI2MA0KPiA+IFsgICA2NC43OTAyMjddICBzdGF0ZV9zdG9yZSsweDhjLzB4
MTE4DQo+ID4gWyAgIDY0Ljc5MzcxMl0gIGtvYmpfYXR0cl9zdG9yZSsweDE4LzB4MzANCj4gPiBb
ICAgNjQuNzk3NDU5XSAgc3lzZnNfa2Zfd3JpdGUrMHg0MC8weDU4DQo+ID4gWyAgIDY0LjgwMTEx
OF0gIGtlcm5mc19mb3Bfd3JpdGUrMHgxNDgvMHgyNDANCj4gPiBbICAgNjQuODA1MTI2XSAgdmZz
X3dyaXRlKzB4YzAvMHgyMzANCj4gPiBbICAgNjQuODA4NDM2XSAga3N5c193cml0ZSsweDZjLzB4
MTAwDQo+ID4gWyAgIDY0LjgxMTgzM10gIF9fYXJtNjRfc3lzX3dyaXRlKzB4MWMvMHgyOA0KPiA+
IFsgICA2NC44MTU3NTNdICBlbDBfc3ZjX2NvbW1vbi5jb25zdHByb3AuMysweDY4LzB4MTcwDQo+
ID4gWyAgIDY0LjgyMDU0MV0gIGRvX2VsMF9zdmMrMHgyNC8weDkwDQo+ID4gWyAgIDY0LjgyMzg1
M10gIGVsMF9zeW5jX2hhbmRsZXIrMHgxMTgvMHgxNjgNCj4gPiBbICAgNjQuODI3ODU4XSAgZWww
X3N5bmMrMHgxNTgvMHgxODANCj4gDQo+IFBsZWFzZSB0aGluayBoYXJkIGJlZm9yZSBpbmNsdWRp
bmcgY29tcGxldGUgYmFja3RyYWNlcyBpbiB1cHN0cmVhbSByZXBvcnRzLA0KPiB0aGV5IGFyZSB2
ZXJ5IGxhcmdlIGFuZCBjb250YWluIGFsbW9zdCBubyB1c2VmdWwgaW5mb3JtYXRpb24gcmVsYXRp
dmUgdG8gdGhlaXINCj4gc2l6ZSBzbyBvZnRlbiBvYnNjdXJlIHRoZSByZWxldmFudCBjb250ZW50
IGluIHlvdXIgbWVzc2FnZS4gSWYgcGFydCBvZiB0aGUNCj4gYmFja3RyYWNlIGlzIHVzZWZ1bGx5
IGlsbHVzdHJhdGl2ZSAoaXQgb2Z0ZW4gaXMgZm9yIHNlYXJjaCBlbmdpbmVzIGlmIG5vdGhpbmcg
ZWxzZSkNCj4gdGhlbiBpdCdzIHVzdWFsbHkgYmV0dGVyIHRvIHB1bGwgb3V0IHRoZSByZWxldmFu
dCBzZWN0aW9ucy4NCg0KT2ssIHdpbGwgbW9kaWZpZWQgaW4gbmV4dCB2ZXJzaW9uLg0KDQpCZXN0
IFJlZ2FyZHMsDQpRaWFuZyBaaGFvDQo=
