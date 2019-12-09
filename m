Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E22D21170CA
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2019 16:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfLIPpP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Dec 2019 10:45:15 -0500
Received: from mail-eopbgr1400137.outbound.protection.outlook.com ([40.107.140.137]:14624
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726197AbfLIPpO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Dec 2019 10:45:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFNnSNN6r8yXuQuj6eSCjOLwUOed3TLo84nvXLk5JWZFF1lxaFIqfPi9jEhxsCocqN96I3294djZ97EZrCEWuLq5GgeZLCjAZ852g7PL54eIGc0PQmJN+vqbpd/kFB49zSqvDEt9Oq9CBzZRU7RPx4K74guK+Ht9qapI7JGTz83JFIFAjXAgGSVwJskTVgTzx88HDF6PYnuhQ2f09vQ6gG8QPkUICthdbu5p7UOGjhQP975pPa+XYegcrGRmWXdjHt4u6X8NsLeTfamcqzPOC8kZPgyNdFdBLCHKsJNd2It+0rS2qLq91EN8nvKJIlqwBWqfpMyA0loR+kdvD19jtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=453Izz16sVVzR3SB1Q3rp17mLUDpKDLyJK4NQbUedX0=;
 b=AhedxbqpGxs4N5wY62GWdcPD7u3nCx6S90OfjqmFND78vwP557BJ/5BLO4zx8D+dqjmiL3Ub1uW6fVyR9SRkdelxWRmfa9xwBgSWgBCjvC1mvmSWpkyMk7RVkcg+BAQAQcXxpqJxoBaYaRK11EL86CJ9cbBZXbJuMSE4pbQPhCrk08UBkEglqQr9tnqi66Q0HJZtpqbuYl3HEWxO0qGGumya4LC2OrYQrYePjAyHAQNjtpLB0++tDdJ8EAXwvJPuOO62BRKt5yo9SKVPos8BM5tBeLBYqN/wphcOrF4QQmAPYpDUhXCk/UMEobK132oVK36exkTaoRXbbtQF2bvWrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=453Izz16sVVzR3SB1Q3rp17mLUDpKDLyJK4NQbUedX0=;
 b=APUJMIOkiYfuJSO4jBHaAyj2BXhkVbg9X0dIXDRP0qIwPsPCql0Y6Vgd6A8YNlsCJiG+k9qiXf4HDNCt2pmpz39iUmCExIpm44jPEe0Lvpqm39JlC+nF2aCc2Agn/06utTrBu7UZfw/P1X8l7U62QeTgRCF/nHO8ZSbuX/OW+Ik=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1852.jpnprd01.prod.outlook.com (52.133.164.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Mon, 9 Dec 2019 15:45:09 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 15:45:09 +0000
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
Subject: RE: [PATCH v2 2/6] dt-bindings: spi: Document Renesas SPIBSC bindings
Thread-Topic: [PATCH v2 2/6] dt-bindings: spi: Document Renesas SPIBSC
 bindings
Thread-Index: AQHVrDsTjXSeF7WhuEKgUGoi0guPiaex3BKAgAAR69A=
Date:   Mon, 9 Dec 2019 15:45:08 +0000
Message-ID: <TY1PR01MB1562BC84E2ECF81487A780D38A580@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <20191206134202.18784-3-chris.brandt@renesas.com>
 <CAMuHMdXW6_tCcx_DE66qBSTK8XmWyWm82ZD6h-N5YX_+xcvBtw@mail.gmail.com>
In-Reply-To: <CAMuHMdXW6_tCcx_DE66qBSTK8XmWyWm82ZD6h-N5YX_+xcvBtw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZGZhNzVkODYtMWE5YS0xMWVhLWFhNTQtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XGRmYTc1ZDg3LTFhOWEtMTFlYS1hYTU0LTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iMjQwNSIgdD0iMTMyMjAzNzk5MDc4NDYwNDEzIiBoPSJoODdXcE5SdDBMMC9CSDE2czFOYW1BWFZrWTQ9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1780d1a-be85-4da8-6088-08d77cbec544
x-ms-traffictypediagnostic: TY1PR01MB1852:
x-microsoft-antispam-prvs: <TY1PR01MB18527A6FA7BEDDDD9A0223938A580@TY1PR01MB1852.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(366004)(396003)(39840400004)(136003)(199004)(189003)(7696005)(52536014)(229853002)(7416002)(33656002)(26005)(186003)(305945005)(9686003)(64756008)(5660300002)(55016002)(71190400001)(71200400001)(478600001)(66446008)(6506007)(66556008)(54906003)(76116006)(66946007)(81166006)(81156014)(4326008)(316002)(8676002)(8936002)(86362001)(66476007)(2906002)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1852;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1TvaLUqQEbg0P+wkw7fzToEjyHU5YoOxZXP33eyxSaR4bIXBgIzCwp013urHcDLV5ktuDImozKtYG1nzeqEgagOWTVsh+vsTa9k/zDz0lfgWpZyhhunbUolMTYeZYlGgDMiq0b+hhmwskPo3iAEf/XmDIapqnedbKoLGhRgUOCXhd6PkVNmaGtAr0ACviPw2dazWIO48TglWwP8BsaXFTKQlJMY92xPhYtKj3VXK50Nd6LIfVCvZvoNwCawtY1R7WtT2NBFZnau3YuewP7cnK0EFv/bxSe55vW+odofnwD3N2ml/ItRKdW7hF3m8iDAMgijXPvR6VeW4PAAoJh1Fnv+1HC52JFKt88hHzmIzw50Wo8MIcT5oUhUtNw9/SsXt2q9u2jE0VvECbFGcJYWra9Wwqnfdt07JNAXC+kKPIrPfPAjWcDcsEa2xFNvayC+z
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1780d1a-be85-4da8-6088-08d77cbec544
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 15:45:08.9179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Pn/a8YNK8t1FYbI7bVlcFb+Ok3dqY7h4Zu9fa7uLviJif/OVo1B4MiN+cU9rtYxLXkLm86Yuioc7mxPH5N1qVx9n9pQPxdtnsYXgujGB7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1852
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIE1vbiwgRGVjIDksIDIwMTksIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90
ZToNCj4gPiArICByZWc6DQo+ID4gKyAgICBtaW5JdGVtczogMg0KPiA+ICsgICAgbWF4SXRlbXM6
IDINCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBSZWdpc3RlcnMN
Cj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogTWVtb3J5IE1hcHBlZCBBZGRyZXNzIFNwYWNlDQo+
IA0KPiBUaGUgc2Vjb25kIG9uZSBpcyBub3QgbmVlZGVkLCBpZiB5b3Ugd291bGQgYWRkICJyYW5n
ZXMiIGZvciB0aGUgbWVtb3J5LW1hcHBlZA0KPiBtb2RlLg0KDQoNClNvIGZvciBSWi9BMk06DQog
IHJhbmdlcyA9IDwweDAgMHgyMDAwMDAwMCAweDEwMDAwMDAwPjsNCg0KDQo+ID4gKyAgICAjIFRo
aXMgZXhhbXBsZSBpcyBmb3IgIkV4dGVybmFsIEFkZHJlc3MgU3BhY2UgUmVhZCBNb2RlIg0KPiA+
ICsgICAgc3BpYnNjOiBzcGlAMWY4MDAwMDAgew0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAi
cmVuZXNhcyxyN3M5MjEwLXNwaWJzYyI7DQo+ID4gKyAgICAgICAgcmVnID0gPDB4MWY4MDAwMDAg
MHgxMDA+LCA8MHgyMDAwMDAwMCAweDEwMDAwMDAwPjsNCj4gPiArICAgICAgICBjbG9ja3MgPSA8
JmNwZyBDUEdfTU9EIDgzPjsNCj4gPiArICAgICAgICBwb3dlci1kb21haW5zID0gPCZjcGc+Ow0K
PiA+ICsgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSA0NDUgSVJRX1RZUEVfTEVWRUxfSElH
SD47DQo+ID4gKyAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gKyAgICAgICAgI3Np
emUtY2VsbHMgPSA8MD47DQo+ID4gKyAgICB9Ow0KPiA+ICsgICAgZmxhc2hAMjAwMDAwMDAgew0K
PiANCj4gVGhpcyBkb2VzIG5vdCBkZXNjcmliZSB0aGUgaGFyZHdhcmUgdG9wb2xvZ3k6IHRoZSBm
bGFzaCBub2RlIHNob3VsZCBiZSBhDQo+IHN1Ym5vZGUgb2YgdGhlIHNwaWJzYyBub2RlLCBhcyBp
dCByZWxpZXMgb24gdGhlIHNwaWJzYyBiZWluZyBjbG9ja2VkLg0KDQpTbyBmb3IgdGhlICJYSVAi
IGNhc2UsIEkgb3JpZ2luYWxseSB0cmllZCBhZGRpbmcgYW4gIm10ZC1yb20iIGZsYXNoIG5vZGUN
CnVuZGVyIHRoZSBzcGlic2Mgbm9kZSwgYnV0IHRoZW4gdGhlIG10ZC1yb20gcGFydCBuZXZlciBn
b3QgcHJvYmVkLiBJIA0KZ3Vlc3MgdGhhdCB3YXMgYmVjYXVzZSBpdCBkaWRuJ3QgcmVnaXN0ZXIg
YSBTUEkgY29udHJvbGxlci4NCg0KDQpCdXQsIEkgZ3Vlc3MgaWYgd2UgZ28geW91ciBtZXRob2Qu
Li4NCj4gICAgIHNwaWJzYzogc3BpQDFmODAwMDAwIHsNCj4gICAgICAgICAgICAgICAgIGNvbXBh
dGlibGUgPSAicmVuZXNhcyxyN3M5MjEwLXNwaWJzYyIsICJzaW1wbGUtcG0tYnVzIjsNCg0KVGhl
biBhZnRlciB0aGUgc3BpYnNjIGRyaXZlciBmYWlscyBhbmQgdGhlICJzaW1wbGUtcG0tYnVzIiBk
cml2ZXIgdHJpZXMsDQppdCB3aWxsIHN1Y2NlZWQgYW5kIHRoZSBzaW1wbGUtcG0tYnVzIGRyaXZl
ciB3aWxsIHN0YXJ0IHByb2JpbmcgdGhlIA0Kc3Vibm9kZXMgKGluIG15IGNhc2UsIHRoZSBtdGQt
cm9tKS4NCg0KDQo+IGFuZCBhcHBseWluZyAiW1BBVENIXSBtdGQ6IG1hcHM6IHBoeXNtYXA6IEFk
ZCBtaW5pbWFsIFJ1bnRpbWUgUE0gc3VwcG9ydCJbMV0sDQo+IHRoZSBtZW1vcnktbWFwcGVkIGNh
c2Ugc2hvdWxkIHdvcmssIHdpdGhvdXQgeW91ciBzcGlic2MgZHJpdmVyLg0KDQpHb29kLg0KU28g
d2UgY2FuIGFkZCB0aGUgU1BJLUJTQyBjbG9ja3MgZm9yIFJaL0ExIGFuZCBSWi9BMiAoZXZlbiB3
aXRob3V0IHRoZSANClNQSS1CU0MgZHJpdmVyKSBhbmQgc3RpbGwgaGF2ZSBhIHdvcmtpbmcgc29s
dXRpb24gZm9yIFhJUF9LRVJORUwuDQoNCg0KDQpTbyBpbiB0aGUgZW5kLCB0aGlzIGFsbCBzZWVt
cyBsaWtlIGEgdmVyeSBzaW1wbGUgc29sdXRpb24gdG8gZ2V0IA0KZXZlcnl0aGluZyBJIHdhbnRl
ZCB3aXRoIG1pbmltYWwgY29tcGxleGl0eS4NCg0KQnV0LCBpZiBTZXJnZWkgaXMgZ29pbmcgYSBj
b21wbGV0ZWx5IGRpZmZlcmVudCByb3V0ZSBmb3IgUi1DYXIsIEkgZ3Vlc3MgDQpJIG5lZWQgdG8g
dW5kZXJzdGFuZCB0aGF0IGZpcnN0IHdoYXQgaGUgaXMgdHJ5aW5nIHRvIGRvIGJlZm9yZSBJIHJl
YWxseQ0KcHVzaCBmb3IgdGhpcyBkcml2ZXIgZ2V0dGluZyBpbi4NCkFnYWluLCB0aGlzIGRyaXZl
ciB3YXMgb25seSB3aGVuIHVzaW5nIHRoZSBTUEktQlNDIEhXLCBub3QgdGhlIGZ1bGwgDQooZGlm
ZmVyZW50KSBSL1cgSHlwZXJGbGFzaCBjb250cm9sbGVyIEhXLiBUaGF0IHdvdWxkIGJlIGEgc2Vw
YXJhdGUgZHJpdmVyLg0KDQpDaHJpcw0KDQo=
