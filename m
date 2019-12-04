Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E011F1129FD
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2019 12:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfLDLTl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Dec 2019 06:19:41 -0500
Received: from mail-eopbgr1400118.outbound.protection.outlook.com ([40.107.140.118]:28696
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727331AbfLDLTl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Dec 2019 06:19:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViD9wf5OpjHIJAMd4kphMsj/YL0xgYwon0SLXTIYNBscmEdtHT/QF0WshNa8AhNJNWfHpuSeXxwmtWW1oRoZyeOdyW8KT7GQ3Te30YKD/QvoJq2n12V3EdStRvKABtu8IV0F/zrjH8LftmMkXnN+nHcF0s2eeLld3LstSDXPFtMa0K1MSOXfAyF5yswUU02YpSeJjfWx550zwvmnrm0APBIJjg5b4PqEikH+iyOajMb55nq2XKCV/o8OrQb1kdWrgJBwtIk0x9Vn8tQUcZ+BFJ5LKF/A9Sf2w1bOGdOjxqcv56guOC/c7l/ZBHbjS/G1wMCZm17ek2S0fono3ojl+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyKdiyNqxH3zx67eG4/38qfREyvzrMwO8HQSx9eQHvs=;
 b=dE8WvYYjPZ7TqdJOIoAxcvU36qKpwUGC2mETeeMXTNGxkAJvd78UoFvcBaa5onCvkwu5FvzzNiAL29Ra3K7dYYTPZfZFC7t39lIZ2emvCoOD63894Cq8qvp9VjJ8sqX3m1ivEZFfWsu9byC7SXkN1v1Iwl+igw9NeNG0/mbU23N7fp2IQi+qH/t0pRxqsn/VLyIIsZXhFrJus263+VSrJfzCELgxoaMGmNiCBSb/fztk0RXKfnmtWj+LLGRW8+/I/S9u+n0btuA9kQKo80rDK7kZ9AWZSJheJMEp3SCc0k38+sA6LXKKRTRbJ4NqRYyu2wz0uv2BUx38xtz9VBksOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyKdiyNqxH3zx67eG4/38qfREyvzrMwO8HQSx9eQHvs=;
 b=TcyxFCOCU6KSnjQ83qQw1Czv8rjVieczY8SNUp7n7v2ew+LVwN2i1aCFeUcEvGo5lRLReLU23CT7WD2fEVjq88Wiwcxw/LVPOlQYLR68Pp7nWgc54Kbkd4vyDIcdXZOtFRnkoUKEEsB7CcU8sZ4Nn1OqmC5XCl6D39ZVmo+jIxQ=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1658.jpnprd01.prod.outlook.com (52.133.162.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Wed, 4 Dec 2019 11:19:34 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2516.003; Wed, 4 Dec 2019
 11:19:34 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: RE: [PATCH 6/6] dt-bindings: spi: Document Renesas SPIBSC bindings
Thread-Topic: [PATCH 6/6] dt-bindings: spi: Document Renesas SPIBSC bindings
Thread-Index: AQHVqYxRjjQT6EPsk0uhvsHduSJ+e6eow+OAgAAQwHCAANYXAIAAKJ5w
Date:   Wed, 4 Dec 2019 11:19:34 +0000
Message-ID: <TY1PR01MB1562E541CEE3FB413CB5B1F08A5D0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-7-chris.brandt@renesas.com>
 <CAMuHMdVBYpuoK7hcyNLK-mAdpTQz3ohTGXuYdFPHdpU5RoPr6Q@mail.gmail.com>
 <TY1PR01MB15622365FCCC3C1CB052FD0E8A420@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <CAMuHMdXKSWeBdCDc6u5KWE67nD_9FStr9A_vb_5K=qpQ_y8bSw@mail.gmail.com>
In-Reply-To: <CAMuHMdXKSWeBdCDc6u5KWE67nD_9FStr9A_vb_5K=qpQ_y8bSw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZjFmMzU4MWMtMTY4Ny0xMWVhLWFhNTEtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XGYxZjM1ODFlLTE2ODctMTFlYS1hYTUxLTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iMTQzMCIgdD0iMTMyMTk5MzE5NzM0MTgzMTU2IiBoPSJFR1NjU0V3eXUydEllZHhtZUZQRnVES1pIazg9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c9313417-9f04-4d22-86a0-08d778abd769
x-ms-traffictypediagnostic: TY1PR01MB1658:
x-microsoft-antispam-prvs: <TY1PR01MB16583B725DF7DB63CC8BAF9F8A5D0@TY1PR01MB1658.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(189003)(199004)(6116002)(2906002)(55016002)(74316002)(8676002)(81156014)(102836004)(3846002)(8936002)(305945005)(7416002)(25786009)(81166006)(6246003)(33656002)(71190400001)(4326008)(26005)(71200400001)(14454004)(9686003)(5660300002)(6506007)(6916009)(7736002)(86362001)(99286004)(76116006)(11346002)(229853002)(66946007)(76176011)(66476007)(6436002)(478600001)(66556008)(66446008)(64756008)(54906003)(7696005)(52536014)(316002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1658;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HqKM4QwJ/j2+VHyAM0zbq4NLHcrqHuuqoqy6VBLW3eHL/wPk+E3F4hPXmIdFuPBBGgIg8iI3MxKu10ZRxwQnlvZKpWT1jT2DZVu8pszH+8MrZx0A1BHTdEkR5nqumCK9KiKeqEy9eE0wUe3/RbH8dLRfzMw+RLdHq+pRXlMp7xh/LFqHlG13+qtTQ/TAmQ0TcKA9wu9IWUgFicXGByVhPSNEO17tuKPrSgr99GrJGM5hz6nYalSRhKZMA06jWtE65KN1IdlEClpv2itXwX6twzFNyJJtxkfc7P0kB65lc0NpDHwKmD8Nz+/+CGKqnR/Ow+KEq1dH0cnxDzoKtFUUPQSePUz8cO/AnTsUf930rDSBh9BJmvFBzRQ+/pJq41hJdGHHbvlguPkBrXLNaqZtHb3LOvDZTkEVBWbr3EntziXlg7Ol8OabNivqEM+M9ChW
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9313417-9f04-4d22-86a0-08d778abd769
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 11:19:34.3733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M4KmJI74h78AEOxH8+rSC0OdzuuXNBEHiuLAY9EF7v1Jf6PY/pTEhliUVHcqBi7+6KXnhfnOdDbmnWEkSFKZ8I818v1vUvnDAMxn19ADqkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1658
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgR2VlcnQsDQoNCj4gPiBCdXQgIm10ZC1yb20iIGRvZXNuJ3QgcmVhbGx5IGhhdmUgYW55dGhp
bmcgdG8gZG8gd2l0aCB0aGUNCj4gPiBmdW5jdGlvbmFsaXR5IG9mIHRoZSBkcml2ZXIgd2hlbiBp
dCBpcyBiZWluZyB1c2VkIGluICJTUEkgbW9kZSIuDQo+IA0KPiBDb3JyZWN0LiBCdXQgRFQgZGVz
Y3JpYmVzIGhhcmR3YXJlLiAgSWYgdGhlIEZMQVNIIGlzIHVzZWQgaW4gZGlyZWN0IG1hcHBlZA0K
PiBtb2RlLCB0aGF0IHNob3VsZCBiZSBkZXNjcmliZWQgaW4gRFQuDQoNClNvIGl0IHNlZW1zIHdl
IGFyZSBnb2luZyBiYWNrIHRvIG15IG9yaWdpbmFsIHBsYW46DQpBbHdheXMgZW5hYmxlIHRoZSBT
UElCU0Mgbm9kZSBpbiB0aGUgLmR0cyB0byBlbnN1cmUgdGhlIGNsb2Nrcw0Kc3RheSBvbiBmb3Ig
dGhlIFhJUCBrZXJuZWwgY2FzZS4gQnV0LCBpZiB0aGVyZSBpcyBubyBzcGktbm9yIHBhcnRpdGlv
bnMgaW4NCnRoZSBub2RlLCB0aGVuIHNpbXBsZSBkcm9wIG91dCBhbmQgZG8gbm90IHJlZ2lzdGVy
IHRoZSBkZXZpY2UgYXMgYSBTUEkNCmNvbnRyb2xsZXIuDQpIb3dldmVyLCB5b3UgY2FuIGhhdmUg
bXRkLXJvbSBwYXJ0aXRpb25zIGluIHRoZXJlIHdoaWNoIGlzIHdoYXQgWElQIExpbnV4IHdpbGwN
CnVzZSwgYnV0IHdlIHN0aWxsIGRvbid0IG5lZWQgdG8gcmVnaXN0ZXIgYSBzcGkgY29udHJvbGxl
ciBmb3IgdGhhdC4NCg0KRG8geW91IGFncmVlPz8/Pz8NCg0KDQo+ID4gPiBpbnRlcnJ1cHRzPyBS
Wi9BMk0gc2VlbXMgdG8gaGF2ZSBhbiBTUElCU0MgaW50ZXJydXB0LCBSWi9BMSBoYXNuJ3QuDQo+
ID4NCj4gPiBUaGVyZSB3YXMgbmV2ZXIgYW55IGludGVycnVwdHMgaW4gdGhlIFNQSUJTQy4NCj4g
PiBCdXQgaXQgbG9va3MgbGlrZSB3aGVuIHRoZXkgYWRkZWQgSHlwZXJGbGFzaCBhbmQgT2N0YUZs
YXNoIHN1cHBvcnQsDQo+ID4gdGhleSBwdXQgaW4gc29tZSBpbnRlcnJ1cHRzIGZvciB0aGF0Lg0K
PiA+IEFuZCBub3cgdGhhdCBJIGxvb2sgYXQgaXQsIHRoZXkgYXJlIGZvciBwaW5zIGxhYmVsZWQg
UlBDX0lOVCwgUlBDX1dDLA0KPiBSUENfUkVTRVQuDQo+ID4gKEkganVzdCByZWFsaXplZCB0aGF0
ICJSUEMiIHN0YW5kcyBmb3IgIlJlZHVjZWQgUGluIENvdW50IikNCj4gPg0KPiA+IFNvLi4uLmFt
IEkgc3VwcG9zZWQgdG8gYWRkIGluIHRoYXQgaW50ZXJydXB0IGV2ZW4gdGhvdWdoIEknbSBub3QN
Cj4gPiBwbGFubmluZyBvbiB1c2luZyBpdD8/DQo+IA0KPiBEVCBkZXNjcmliZXMgaGFyZHdhcmUs
IG5vdCBkcml2ZXIgbGltaXRhdGlvbnMuDQoNCk9LLiBJIHdpbGwgYWRkIHRoZSBpbnRlcnJ1cHQg
dG8gdGhlIERULg0KDQpDaHJpcw0KDQo=
