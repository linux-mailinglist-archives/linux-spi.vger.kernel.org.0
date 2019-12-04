Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE8E8112CA1
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2019 14:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfLDNbZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Dec 2019 08:31:25 -0500
Received: from mail-eopbgr1400107.outbound.protection.outlook.com ([40.107.140.107]:6127
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727850AbfLDNbY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Dec 2019 08:31:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y60DW9zXDUiHyPVK4J90b4ka8oKyDkBLySTJBGGXaksmv4h9F0r5tiUKrHU5RpKGXD5fqS6jFJR4idlLUU5fqbFxJ3/Q5pPrRba+P91EyX/SUAGsXMbcA8MlC/KZ5w1LR+/yfmzoSYgNP8bai3Pdfio0fXdFvDcym93miNQfwt/jpleybI98PZWcrFUWTvRLBvJTi9zIqmA/x2qVtigTH0Nemmrcgx2g/kgzH1niiqDf5dgHyhNXqQ/aHZ67/9S7U2K/HAvJFHrv6qEonNKaO49BZbdpoDYJiZ47MYzXe+Cjmov5IlYm7S8GKygyylmkCKYQzqgYdu+YN+s7xcnzYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwH9zS6s9FTL0up9iZv9OXp7e7Js2qdzAmQLOEVwZU4=;
 b=SrKiYMKgrLWdv04YtKTiJ64TyENz0OWAqJ/BzwOfKXBPCQwOVgGTBPNyMpT5vIeQUDR8x4mly2HU7ZxeJ3Bt0ZEP0JRmlpAicI58xUDXoV9QNvy0qtZVwwwUGW9hSXYF7s6vXhJL/qOK1C/OG9n66X7rqEU81ed/Pc7d5Ar4FVIX1indGXDsFGPy1tOE2rWE9sfoWmH851LlWjV3wIjZhbsKK0U2hn3e9PnNxxrknuPuRy5X1KLf8FYkTw/ePa4a/H8Bqmb0Kv0ey7oYd0wlilxfP5VBI+tb1hDVTlEv5p5eRQcDr2ZxaGl/kJhtoYfMio9bmoZUxDqTXKMLZe9Olg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwH9zS6s9FTL0up9iZv9OXp7e7Js2qdzAmQLOEVwZU4=;
 b=Iy++PkfakTpbhgRzRPmQN0SNvD7pHDgLA/0dnX99zBEqHLVsi8u3mY0ruyxmfoYBZnt+wldBx7XVzSFJMsDsZwJ6bBS0t/+f3msauAuPeKC+J65lneXa3U+S4fzshlY6a0qKyFTsRL6Vv6mWIsXi7HrkP/l2t/+yOgqbgq9BuRc=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1465.jpnprd01.prod.outlook.com (52.133.160.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Wed, 4 Dec 2019 13:31:19 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2516.003; Wed, 4 Dec 2019
 13:31:19 +0000
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
Thread-Index: AQHVqYxRjjQT6EPsk0uhvsHduSJ+e6eow+OAgAAcgACAACHMAIAArCeAgABEDRA=
Date:   Wed, 4 Dec 2019 13:31:18 +0000
Message-ID: <TY1PR01MB1562322613FC52617312F14E8A5D0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-7-chris.brandt@renesas.com>
 <CAMuHMdVBYpuoK7hcyNLK-mAdpTQz3ohTGXuYdFPHdpU5RoPr6Q@mail.gmail.com>
 <CAMuHMdV7XY7FB9pBsxuWxGsqYaD9n1Y+XZXEJO5OsuigjjUgpw@mail.gmail.com>
 <TY1PR01MB1562A6AFD8D0807B345B7A208A5D0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <CAMuHMdUn3h1VjYkARTFBqMij5aYg2mJSVErwceHc0NATBo+_hw@mail.gmail.com>
In-Reply-To: <CAMuHMdUn3h1VjYkARTFBqMij5aYg2mJSVErwceHc0NATBo+_hw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNTk0ZjFhOGUtMTY5YS0xMWVhLWFhNTEtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XDU5NGYxYThmLTE2OWEtMTFlYS1hYTUxLTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iMzgzMyIgdD0iMTMyMTk5Mzk4Nzc3OTQwOTI0IiBoPSJLc2JLQnNYVTh1TWc1ZEM5OEx0eWF4VE80UXc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 37db6f0f-5585-46e7-350b-08d778be3eec
x-ms-traffictypediagnostic: TY1PR01MB1465:
x-microsoft-antispam-prvs: <TY1PR01MB146569DB8B6D8296D102184D8A5D0@TY1PR01MB1465.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(199004)(189003)(6246003)(9686003)(76176011)(6436002)(86362001)(186003)(14444005)(26005)(4326008)(66446008)(5660300002)(316002)(6916009)(54906003)(55016002)(76116006)(102836004)(7696005)(7736002)(66556008)(14454004)(66476007)(66946007)(64756008)(52536014)(6506007)(33656002)(229853002)(8676002)(3846002)(99286004)(74316002)(11346002)(25786009)(8936002)(305945005)(81166006)(6116002)(478600001)(7416002)(71190400001)(71200400001)(81156014)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1465;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YF6Fl9x3faw8tkoMJx+L6aGdacc9XOXNgV8aCo11WwIasuz8X/F0rWL4goQA13Mg7lcU1spvEZwFW7MDOByJlbut9f+/1BP1MrzukFd28EbOTQ72ITjO7dOXauGUB0kQzEL5QT+AiYmi6FkSkgXYdB1o2K2S3sz/QavTaRcRKt6Q82oL/WjlKpzK8jS9waL5bDfceUp3o1BYToV+Ie/ZMkkucbMooBSAwOMbDrh0HZB27jirdk5QthIuVCGzChE2ir/UBWREvRZmvyZKPJfeZyMKAfsKLLfxa/Wtp1eIpmnkJCYxAvHIHjhsWGw5swbhvn/D3EQlDgUBoChegfj+1H0vRgKF+kV1Qo0Wla1C4c2NFUj2KTnGqMbjk+tSgwBEaQaTT1uIP2zYdLYTOBjPAD8K7IqmwJYAr2d5yFF1m6pNXDApZsH74ilCeAIsCDs1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37db6f0f-5585-46e7-350b-08d778be3eec
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 13:31:18.9832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LXNffY+Y6CL0Y+eM+0xcWKTGSNg42Uw4lvwIMO21wPgJLndDHLvyxhUjUcrrP5St/admAhHqGQ5nBkfqj0ek+0ikzQw1Vsp20qxONTVeGo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1465
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgR2VlcnQsDQoNCj4gVG8gYXZvaWQgZnV0dXJlIHByb2JsZW1zLCB5b3UgcHJvYmFibHkgZG8g
d2FudCB0byBzcGVjaWZ5IHNwaS10eC1idXMtd2lkdGggPQ0KPiA8ND4gYW5kIHNwaS1yeC1idXMt
d2lkdGggPSA8ND4gaW4gRFRTIG5vdy4NCg0KSSBkaWRuJ3QgZG8gdGhhdCBiZWNhdXNlIGlmIHRo
ZSBNVEQgbGF5ZXIgdGhlbiB0aGlua3MgSSAnd2FudCcgdG8gZG8gNC1iaXQgYWNjZXNzLCB0aGVu
IHRoYXQgaW50cm9kdWNlcyBhIG5ldyBwcm9ibGVtIHRoZSBzb2x2ZS4NClRoZSBNVEQgbGF5ZXIg
bWlnaHQgc3RhcnQgc2VuZGluZyBkb3duIFFVQUQgUkVBRCBjb21tYW5kcyB0byB0aGUgZXh0ZXJu
YWwgU1BJIGFuZCB0aGVuIHRoZSBTUEkgRmxhc2ggd2lsbCBzdGFydCBzZW5kaW5nIGJhY2sgZGF0
YSBvbiBhbGwgNCBsaW5lcywgYnV0IHRoZSBjb250cm9sbGVyIGlzIG9ubHkgY29uZmlndXJlZCBm
b3IgMS1iaXQgdHJhbnNmZXJzLg0KDQpJIGhvbmVzdGx5IGRvbid0IGtub3cgd2hlbi93aHkgdGhl
IE1URCBsYXllciBkZWNpZGVzIG9uIHN3aXRjaCBmcm9tIDEtYml0IHRvIDQtYml0IG1vZGUsIHNv
IHdoaWxlIHRoZSBib2FyZCBoYXJkd2FyZSBpcyB3aXJlZCBmb3IgNC1iaXQgKGFzIHRoZSBEVCB3
b3VsZCBkb2N1bWVudCksIHdlIGFyZSBub3QgcmVhZHkgdG8gYmUgZG9pbmcgNC1iaXQganVzdCB5
ZXQuDQpJIGp1c3Qgd2FudCB0byB0cnkgYW5kIGdldCB0aGUgZHJpdmVyIGluIGF0IGZpcnN0Li4u
LnRoZW4gd2UgY2FuIG1ha2UgaXQgZG8gZmFuY3kgc3R1ZmYgbGF0ZXIuDQoNCklmIHNvbWVvbmUg
Y2FuIHRlbGwgbWUgdGhhdCBldmVuIGlmICJzcGktcngtYnVzLXdpZHRoID0gPDQ+IiBpcyBwdXQg
SSB0aGUgYm9hcmQgRFRTLCB0aGUgc3BpIHdpbGwgc3RpbGwgb25seSBkbyAxLWJpdCB0cmFuc2Zl
cnMgdW50aWwgdGhlIGFwcGxpY2F0aW9uIHNwZWNpYWxseSBlbmFibGVzIDQtYml0IG1vZGUsIHRo
ZW4gSSdtIGZpbmUgd2l0aCBhZGQgYnVzLXdpZHRoPTw0PiBpbiB0aGUgRFRTLg0KDQpVbmxlc3Mu
Li4uSSBkaWQgbm90IHVuZGVyc3RhbmQgeW91IG1lYW5pbmcuLi4uDQoNCkRpZCB5b3UgbWVhbiBw
dXQgJ3NwaS1yeC1idXMtd2lkdGggPSA8ND4nIGluIHRoZSAuZHRzaT8/Pz8gICh0aGVuIEkgY2Fu
IG92ZXJyaWRlIGl0IGJhY2sgdG8gPDE+ICB0aGF0IGluIHRoZSBib2FyZCAuZHRzKT8/Pw0KDQoN
Cg0KPiA+IEJhc2ljYWxseSwgaXQncyBsaWtlIHRoZSAncm9sZSBzd2l0Y2gnIGluIHRoZSBVU0Ig
T1RHIGRyaXZlcnMuDQo+IA0KPiBJZiB5b3Ugd2FudCB0byBkbyB0aGF0LCBib3RoIGNvbmZpZ3Vy
YXRpb25zIHNob3VsZCBiZSBkZXNjcmliZWQgaW4gRFQsIGFuZCB3ZQ0KPiBuZWVkIGEgd2F5IHRv
IHNwZWNpZnkgd2hhdCdzIGJlaW5nIHVzZWQuDQo+IEkgZ3Vlc3MgaWYgdGhlIGRpcmVjdCBtYXBw
ZWQgbW9kZSBpcyB1c2VkLCB5b3UgYWx3YXlzIHdhbnQgdG8gYm9vdCB0aGUga2VybmVsDQo+IHVz
aW5nIHRoYXQgbW9kZSwgYW5kIG9ubHkgc3dpdGNoIHRvIFNQSSBtb2RlIHRlbXBvcmFyaWx5IGFm
dGVyIGJvb3Q/ICBTbyB0aGF0DQo+IGNvdWxkIGJlIGhhbmRsZWQgYnkgbWFudWFsbHkgdW5iaW5k
aW5nIHRoZSBkcml2ZXIgZnJvbSBwaHlzbWFwLWZsYXNoLCBhbmQNCj4gZm9yY2luZyBhIGJpbmQg
dG8gc3BpYnNjLCBhbGwgZnJvbSBzeXNmcy4NCg0KWWVzLCBJIGFncmVlLiBUaGF0IGlzIHdoYXQg
SSB3b3VsZCBzdWdnZXN0IHRvIHNvbWVvbmUuIChJIHN1Z2dlc3QgdW5iaW5kL2JpbmQgZm9yIGEg
bG90IG9mIHNpdHVhdGlvbnMgdGhhdCBwZW9wbGUgYXNrIG1lIHdoYXQgdG8gZG8pLg0KDQo+IChX
aGljaCBjdXRzIHRoZSBicmFuY2ggdGhlIGtlcm5lbCBpcyBzaXR0aW5nIG9uIGluIHRoZSBjYXNl
IG9mIFhJUC4uLikNClhJUCBpcyBhIHNwZWNpYWwgY2FzZSBhbGwgaW4gaXQncyBvd24uLi4uLndo
aWNoIGlzIHdoeSB3ZSB1c2VzIGEgY29tcGxldGVseSBzcGVjaWFsIGRyaXZlciBmb3IgUi9XIGlu
IFhJUCBtb2RlLi4ud2hpY2ggaXMgb3V0IG9mIHNjb3BlIGZyb20gbWFpbmxpbmUuDQpUaGUgY2Fz
ZSBJJ20gdGFsa2luZyBhYm92ZSB3b3VsZCBwcm9iYWJseSBiZWZvcmUgYW4gUi1DYXIgb3IgUlov
RyB1c2UgY2FzZS4gQnV0LCBzaW5jZSBubyBvbmUgaGFzIHN0YXRlZCBhIHVzZSBjYXNlIGxpa2Ug
dGhhdCwgaXQncyB2ZXJ5IGxvdyBvbiB0aGUgcHJpb3JpdHkgbGlzdC4NCg0KDQo+ID4gU28gbXkg
c3VnZ2VzdGlvbiBpcyB0byBmb3JnZXQgYWJvdXQgdHJ5aW5nIHRvICdzdXBwb3J0JyBkaXJlY3Qg
bW9kZSBpbg0KPiA+IHRoaXMgZHJpdmVyIGF0IHRoZSBtb21lbnQuIElmIHlvdSdyZSB1c2luZyB0
aGlzIEhXIGZvciBzb21ldGhpbmcgbGlrZQ0KPiA+IFhJUCwgdGhlbiBkb24ndCBlbmFibGUgdGhp
cyBkcml2ZXIgYXQgYWxsICh3aGljaCBpcyB3aGF0IHdlIGhhdmUgYmVlbg0KPiA+IGRvaW5nKS4N
Cj4gDQo+IFN0aWxsLCB0aGUgZGlyZWN0LW1hcHBlZCBtb2RlIHNob3VsZCBiZSBkZXNjcmliZWQg
aW4gRFQsIHdoZW4gdXNlZC4NCj4gYXJjaC9hcm0vYm9vdC9kdHMvcjdzNzIxMDAtZ3ItcGVhY2gu
ZHRzIGRvZXMgZGVzY3JpYmUgdGhlIEZMQVNILCBidXQgZmFpbHMgdG8NCj4gZGVzY3JpYmUgdGhl
IGV4YWN0IHRvcG9sb2d5IChmbGFzaCBpcyBhIGNoaWxkIG9mIHNwaWJzYywgYW5kIHRodXMgcmVs
aWVzIG9uDQo+IHRoZSBzcGlic2MgbW9kdWxlIGNsb2NrIGJlaW5nIHR1cm5lZCBvbikuDQoNCkkg
Y2FuIGFncmVlIHdpdGggdGhhdC4uLi5hbmQgd2UgZ28gYmFjayB0byBteSBmaXJzdCBpZGVhOiBJ
ZiB5b3UgYXJlICd1c2luZycgdGhlIFNQSUJTQyBmb3IgYW55dGhpbmcgKFhJUCBvciBTUEkgbW9k
ZSkgdGhlbiB5b3UgZGVzY3JpYmUgdGhhdCBpbiBEVC4gQW5kIHdoZW4gdGhlIGRyaXZlciBwcm9i
ZXMsIGlmIGl0IGRvZXMgbm90IHNlZSBhICdzcGktbm9yJyBwYXJ0aXRpb24sIGl0IGRvZXMgbm90
IHJlZ2lzdGVyIGEgc3BpLWNvbnRyb2xsZXIsIGJ1dCBpdCBkb2VzIGtlZXAgdGhlIGNsb2NrIChw
b3dlcikgb24gdGhlIGVudGlyZSB0aW1lICh1bnRpbCByZW1vdmVkKS4NCg0KRm9yIEdSLVBFQUNI
LCB3ZSB3b3VsZCBqdXN0IGhhdmUgdG8gZ28gYmFjayBhbmQgcHV0IHRoZSBxc3BpQDE4MDAwMDAw
ICh3aGljaCBpcyBjdXJyZW50bHkgYXQgdGhlIHJvb3QpIG5vZGUgdW5kZXIgYSBzcGlic2Mgbm9k
ZS4NCg0KT2YgY291cnNlIGFsc28gaWYgd2UgZG8gYWxsIHRoaXMsIHdlIGNvdWxkIGRyb3AgYWxs
IHRoZSBwYXRjaGVzIGZvciBlbmFibGluZyAnY3JpdGljYWwgY2xvY2tzJyB0aGF0IHdlcmUgbmVl
ZGVkIHRvIGNvdmVyIHRoZSBYSVAgY2FzZXMuDQoNCg0KPiBCVFcsIHdoZW4gdXNpbmcgc3BpYnNj
IGluIGRpcmVjdC1tYXBwZWQgbW9kZTogaWYgeW91IHR1cm4gb2YgYW5kIG9uIGFnYWluIHRoZQ0K
PiBtb2R1bGUgY2xvY2ssIGRvZXMgdGhlIHNwaWJzYyBuZWVkIHJlcHJvZ3JhbW1pbmc/DQoNCk5v
cGUuIEV2ZXJ5dGhpbmcgd2lsbCBzdGF5IHRoZSBzYW1lIChqdXN0IGxpa2UgYWxsIHRoZSBvdGhl
ciBwZXJpcGhlcmFscykuIFRoZSBvbmx5IHRoaW5nIHlvdSAnbWlnaHQnIHdhbnQgdG8gZG8gaXMg
Zmx1c2ggdGhlIHJlYWQgY2FjaGUgKGVzcGVjaWFsbHkgaWYgeW91IGRpc2Nvbm5lY3RlZCBpdCBi
ZWNhdXNlIHlvdSB3ZXJlIGdvaW5nIHRvIGdvIG91dCBhbmQgcmUtd3JpdGUgc29tZSBvZiB0aGUg
Zmxhc2ggaW4gU1BJIG1vZGUpLg0KDQpDaHJpcw0KDQo=
