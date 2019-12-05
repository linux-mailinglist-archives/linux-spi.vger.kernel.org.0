Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 100C3114445
	for <lists+linux-spi@lfdr.de>; Thu,  5 Dec 2019 17:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbfLEQB3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Dec 2019 11:01:29 -0500
Received: from mail-eopbgr1410121.outbound.protection.outlook.com ([40.107.141.121]:59712
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfLEQB3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Dec 2019 11:01:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnk3Crce9P6qany17YUHIYp1NvuJPCJHUhTt1m5j8n9NpE9Y3ktwrL1rdLMdeyQMYWcH3Gi4BYkER5hPpERx9w/xhnMfNej31xsegIKv6joBQWJs9xzOz3EynmbKzDAkRE5vv4Ipd774dxBWfw8YcibluwhtCcq3XUKhcm5V5P6dhUUzd7STGd49Y5XHu/fzF20mwYBI82UYYSD6Iwy1Y92TZ3ha6hGnCuFyP2JWPOIuFrm/u8Q0/zcEC5b7dgXp9EjdXggQFO6fGzLK2dlhjmbnwt8po0l8ctoF+aCwd/PbDrOrVU5d2B6rhK4ojZGDVW6AuvqPInnCcHFexWXgEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIuoTkfGgMguFbVpOxGM0rTuGtgA/ynuG9+ZNQFXVPU=;
 b=MXX5278nXM+tV4NwGAqORcpGzP1NuMwrU90xG1o6qzSOUnz7MIrAOuBNpJWYDdyDeEzCzQJevPOnw4E1c80Z2m4zMGnnr+wCvD847Ej2NyNbGIbrJT9GHy0mCuOqjAQrfR8sN/edg1Vg/8teTxQZBKIlPmqETlKgAU7zxYIK8XS9V6XfUzH0hWjbnqMIZBUnjGllPegH20bM6RDHoCk2AwZKiZKXWV0YZKHPMtg46vj0z+1WCKOsEdCcAYbu//WpXMfaIgn3o941I9PrlXA2GcNiYfzWCSVUgUF8NepPWS2dqTGCF7nhyK3uyUHgLhSr6y5NnFux/45iqhQlorUcfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIuoTkfGgMguFbVpOxGM0rTuGtgA/ynuG9+ZNQFXVPU=;
 b=JmV9fvuWJXC0uN1Dv07e8Lx6qqFxhBySnhIPB5cxT6fxKe22iL/s54MEhQE+jZj6B9YldtZJP+etEwHCSeY+AaIzmYg3+pydPIqb1b9tYX745r5pLHM9G1Xl9/L+lXvXTnNsmA715BMJyB1qnH1XBnav88BNx37mMwd3e1JaGhM=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1819.jpnprd01.prod.outlook.com (52.133.160.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Thu, 5 Dec 2019 16:00:45 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2516.003; Thu, 5 Dec 2019
 16:00:45 +0000
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
Thread-Index: AQHVqYxRjjQT6EPsk0uhvsHduSJ+e6eow+OAgAAcgACAACHMAIAArCeAgABEDRCAAcFNgIAAAmFA
Date:   Thu, 5 Dec 2019 16:00:45 +0000
Message-ID: <TY1PR01MB1562F5908AC7A9643F51FEBE8A5C0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-7-chris.brandt@renesas.com>
 <CAMuHMdVBYpuoK7hcyNLK-mAdpTQz3ohTGXuYdFPHdpU5RoPr6Q@mail.gmail.com>
 <CAMuHMdV7XY7FB9pBsxuWxGsqYaD9n1Y+XZXEJO5OsuigjjUgpw@mail.gmail.com>
 <TY1PR01MB1562A6AFD8D0807B345B7A208A5D0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <CAMuHMdUn3h1VjYkARTFBqMij5aYg2mJSVErwceHc0NATBo+_hw@mail.gmail.com>
 <TY1PR01MB1562322613FC52617312F14E8A5D0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <CAMuHMdVy_0e5_94a-G83Tt14XsxmLFOpstvSP6Yw8m9oRW_eZg@mail.gmail.com>
In-Reply-To: <CAMuHMdVy_0e5_94a-G83Tt14XsxmLFOpstvSP6Yw8m9oRW_eZg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNjQxZTk4OTctMTc3OC0xMWVhLWFhNTEtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XDY0MWU5ODk5LTE3NzgtMTFlYS1hYTUxLTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iMTE2MCIgdD0iMTMyMjAwMzUyNDQxNzkxNzkyIiBoPSJicnY3dDh5dXZYWk5nNnpXOW5zNkhRWUZ0ZFE9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0d287452-7e54-476f-c3e3-08d7799c49c5
x-ms-traffictypediagnostic: TY1PR01MB1819:
x-microsoft-antispam-prvs: <TY1PR01MB1819612C0C87677138A233098A5C0@TY1PR01MB1819.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(189003)(199004)(66476007)(5660300002)(305945005)(66556008)(33656002)(4326008)(74316002)(76116006)(86362001)(14454004)(9686003)(25786009)(64756008)(8936002)(66946007)(478600001)(316002)(81156014)(7416002)(6506007)(54906003)(55016002)(26005)(186003)(99286004)(66446008)(71190400001)(81166006)(52536014)(102836004)(71200400001)(6916009)(8676002)(2906002)(76176011)(7696005)(11346002)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1819;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6kqotgeO8dJmxJDZTz5O2K1CAekRTEi9nJNqqjdA/xKtyAzukKuxxFHVHaEdJNtXis8tjT21Bt1AY68gZiuowAXxaFcsKMcMBbHcvrQfpAJG18LHMLSMWLYnDWYhZXqPNdm/V9IJiQAG3ASKPM83D8HP+EC6Hj7qwdRWgq26a3OXfiiHO7wvaNoq/J+Wx5t5MfRRvbYRxeDQyjl1Wzgv6AH9H83UvyC+N+Byc9KCk+PFrtrJ7XSsd9qkXeQnVX8zBmV/Qwl/CcQ9Blx9e8htsZbm1YWMlyZhlaJb+dpiqnaobhjX3UJZyzBIw/XjLwYDMGm67EneV75N9B63xZeioSg3S+F4ld1I5eSawXu2AVMyikmZmQ0UY629CvgrFnK1GrOIMlZpDGBqQTGVpp3FRAVanJW2TuXJ1Mui21QEA3qUMF9QTME3mGd28HSv7J7b
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d287452-7e54-476f-c3e3-08d7799c49c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 16:00:45.4381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 88YoFkb2+Bps2NGbj81HQ5JKTmUUOAx6tin3fX/lGzbAuzSeKqmidtwc2GVGfiDrPQvaxlD9nlEb3P9AOsACc5lFKLSOQ+xouFP/t1MOZhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1819
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIFRodSwgRGVjIDUsIDIwMTkgMSwgR2VlcnQgVXl0dGVyaG9ldmVuIHdy
b3RlOg0KPiBZb3VyIHNwaWJzYyBkcml2ZXIgZG9lczoNCj4gDQo+ICAgICBtYXN0ZXItPm1vZGVf
Yml0cyA9IFNQSV9DUE9MIHwgU1BJX0NQSEE7DQo+IA0KPiBpLmUuIFNQSV9bVFJdWF97UVVBRCxE
VUFMfSBhcmUgbm90IHNldCwgc28gaXQgc2hvdWxkIG5vdCB0cnkgdGhvc2UgbW9kZXMuDQoNCk9L
LCBUaGFuayB5b3UhDQogDQo+IEF0IGxlYXN0IG9uIFJTSytSWkExLCB0aGUgRkxBU0hlcyBhcmUg
d2lyZWQgaW4gcXVhZCBtb2RlLCBzbyB5b3Ugc2hvdWxkDQo+IGRlc2NyaWJlIHRoZSBoYXJkd2Fy
ZSBpbiBEVC4NCg0KT0suDQoNCj4gPiA+IEJUVywgd2hlbiB1c2luZyBzcGlic2MgaW4gZGlyZWN0
LW1hcHBlZCBtb2RlOiBpZiB5b3UgdHVybiBvZiBhbmQgb24NCj4gPiA+IGFnYWluIHRoZSBtb2R1
bGUgY2xvY2ssIGRvZXMgdGhlIHNwaWJzYyBuZWVkIHJlcHJvZ3JhbW1pbmc/DQo+ID4NCj4gPiBO
b3BlLiBFdmVyeXRoaW5nIHdpbGwgc3RheSB0aGUgc2FtZSAoanVzdCBsaWtlIGFsbCB0aGUgb3Ro
ZXIgcGVyaXBoZXJhbHMpLg0KPiBUaGUgb25seSB0aGluZyB5b3UgJ21pZ2h0JyB3YW50IHRvIGRv
IGlzIGZsdXNoIHRoZSByZWFkIGNhY2hlIChlc3BlY2lhbGx5IGlmDQo+IHlvdSBkaXNjb25uZWN0
ZWQgaXQgYmVjYXVzZSB5b3Ugd2VyZSBnb2luZyB0byBnbyBvdXQgYW5kIHJlLXdyaXRlIHNvbWUg
b2YgdGhlDQo+IGZsYXNoIGluIFNQSSBtb2RlKS4NCj4gDQo+IEdvb2QuIFNvIHRoYXQgbWVhbnMg
dGhlIE1URCBkcml2ZXIgY2FuIGJlIG1vZHVsYXIuICBVbnVzZWQgY2xvY2tzIGFyZSB0dXJuZWQN
Cj4gb2ZmIGF0IGJvb3QsIGFuZCBjYW4gYmUgdHVybmVkIG9uIHdoZW4gdGhlIG10ZC1yb20gZHJp
dmVyIGlzIGxvYWRlZCBhbmQNCj4gYWN0aXZhdGVkLg0KDQpJJ20gZ29pbmcgdG8gZG8gc29tZSB0
ZXN0aW5nIG5vdyBhbmQgdGhlbiBzZW5kIG91dCBhIFYyIHRvIHNlZSBpZiB3ZSBhcmUNCmdldHRp
bmcgY2xvc2VyIHRvIGEgY29uc2Vuc3VzLg0KDQpDaHJpcw0KDQo=
