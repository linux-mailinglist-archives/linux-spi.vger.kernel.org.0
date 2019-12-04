Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 182721121A6
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2019 03:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfLDCzD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Dec 2019 21:55:03 -0500
Received: from mail-eopbgr1400134.outbound.protection.outlook.com ([40.107.140.134]:54752
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbfLDCzC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 3 Dec 2019 21:55:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0P6Yk/aqtvprczokOqe/u6u6/zjBY+dI8EdXkkeC0xqpwnUfSVZn+EHh5bOaFXf7tkiWE40qfPPAZxye5dMqrAzgGtTmKJqxqo4OBRl+wvah7RV4jxocg+Iq3iJfC+UtM5YteRkwrjH+6IS6aseVAPA9UrnzSAwjh3t3m6q7lC7OzJybM6N2CS0oBBN+89648f7ctEVatYLSQxoy4hah58EhauL60kXC33Q5U1Ax0ujrDSglckkPAELkThVbVgDY8FRX75ScIQFpIiNndSpMdzknoZ03Q4wRIdpuyIhLN7UGFGIxZhwiYZxqoYOA5rTk1/qJKxtCyIvcwt4lpj0/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/bhdnwNImrqcuWIU8y5gMX1WvVCn4Lw1hW8cc0KXYg=;
 b=IpXkDXI1L1WAyJCKMv8j5h0oH7hahbYA9j8p4T9CYrnZdudL8LYNjfe0jKqB55aLHQ//hxhXkggigcGd1u3O520UHOJC46CpZgSufuOPpAM+U00zuDFVHTgGoFjmvhpM7DtwY/2BSCHPT8Whd0Uob52CDAJjFMy1pnvbqBL0Gm0sXQAY9Uz20nln2MJDkc4tRc4dVw1NwIJ6SMVZfB967RyKrOuzxA/KtuRQyuseV/L5g94CPIs+Vc1eeLL5+rZxWr6bHbfmAcYtUc/EQLQkjPmGBrs+b2sn/fklWwxSYgmab1idJguoZqcaU0VGUF8numNK2lkpf0rRkRJm+I3NYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/bhdnwNImrqcuWIU8y5gMX1WvVCn4Lw1hW8cc0KXYg=;
 b=ZSlOnhxywHMgEG7PeUfQCuh3N+31osh9ZisCiDwSVJH43BGdSk+exDh6MxBLwdoNmQOv77uQ1x6xDXaglhSroTow04Q2GbCrcOOGYvTZ7ZYKhv/OiYFmJQc4ZgR0P0gG0KBs1rJueyAAftZKgKu+MMX3QsurILQyqt7VpnYc4Yk=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1593.jpnprd01.prod.outlook.com (52.133.163.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Wed, 4 Dec 2019 02:54:58 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2516.003; Wed, 4 Dec 2019
 02:54:58 +0000
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
Thread-Index: AQHVqYxRjjQT6EPsk0uhvsHduSJ+e6eow+OAgAAcgACAACHMAA==
Date:   Wed, 4 Dec 2019 02:54:57 +0000
Message-ID: <TY1PR01MB1562A6AFD8D0807B345B7A208A5D0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-7-chris.brandt@renesas.com>
 <CAMuHMdVBYpuoK7hcyNLK-mAdpTQz3ohTGXuYdFPHdpU5RoPr6Q@mail.gmail.com>
 <CAMuHMdV7XY7FB9pBsxuWxGsqYaD9n1Y+XZXEJO5OsuigjjUgpw@mail.gmail.com>
In-Reply-To: <CAMuHMdV7XY7FB9pBsxuWxGsqYaD9n1Y+XZXEJO5OsuigjjUgpw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNzMyMjZjMDEtMTY0MS0xMWVhLWFhNTEtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XDczMjI2YzAyLTE2NDEtMTFlYS1hYTUxLTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iMjE2OCIgdD0iMTMyMTk5MDE2OTU5MjAwNjk3IiBoPSJoYmhUNkVpWDBGbUJFcDY3YWgzM0lNdHBRaTg9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04e07cc7-ab2a-4631-45f6-08d778655955
x-ms-traffictypediagnostic: TY1PR01MB1593:
x-microsoft-antispam-prvs: <TY1PR01MB15939D9DEC21D7591E241D318A5D0@TY1PR01MB1593.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(199004)(189003)(76176011)(2906002)(99286004)(52536014)(316002)(33656002)(256004)(5024004)(7696005)(66556008)(66476007)(66446008)(54906003)(11346002)(446003)(229853002)(478600001)(66946007)(6506007)(76116006)(6436002)(86362001)(186003)(64756008)(26005)(102836004)(6116002)(9686003)(14454004)(7416002)(55016002)(6916009)(8676002)(7736002)(81166006)(81156014)(6246003)(5660300002)(8936002)(3846002)(71190400001)(25786009)(4326008)(74316002)(71200400001)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1593;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ERuiCWUUOiVRDRXkPoWLnBwT7Gf04CSu/Q/l+IcOtSfWR10Ycr6XB/EVSsdQDtUfQ46q3LYpb1kcUa4BZcxI4yCe0C/UA9HmFogTubmSCqBceShC25yqTEfQbAF0YQd7BDC/mUTSxZo1OsFe7Yzh3m/Wks/rwniUN/jYt6oyr3RaDJ34p5eLqInkLea0NJX/hFcKRfOd63G2ZDcp1HetS4+3CaSE1N1CQUlrtm9D5T7DI1lezAJFzCWl/6sx6XDYFYZ48ts4RE5r0qyhwt6vgYRXWFDsmW+Eqn5LfTwDLUzhdr3t4FdtCq1meIa1PCcq4omhf/uO5jACAiSMAvaxVEnN9DniLhvEcDiw4zr1rMdpelkdWPm0w7jgPpez0fC5i4T0ZZ9sV8A2+RtIAFqYh7FygJua/huq2/yHJOp2fXMwrEXMW7zJ3PaHNSWTehJv
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e07cc7-ab2a-4631-45f6-08d778655955
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 02:54:58.0246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xgj5ZyctljKgCzM004kckOu3vKK2C7ALlftHYUE/TA4RpgZpDAGiUaBNp5UnzSJycWymlqmfSZf8BFBUmsqYkbiES8Qihva2Sv9NP5LDzqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1593
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIFR1ZSwgRGVjIDMsIDIwMTksIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90
ZToNCj4gPiBXaGF0IGFib3V0IHRoZSAibXRkLXJvbSIgdXNlIGZvciBlLmcuIFhJUD8NCj4gDQo+
IEkgZ2F2ZSB0aGlzIHNvbWUgbW9yZSB0aG91Z2h0LiBCYXNpY2FsbHkgdGhlcmUgYXJlIHR3byBt
b2RlczogU1BJIEZMQVNIIGFuZA0KPiBkaXJlY3QgbWFwcGVkIGVtdWxhdGlvbiAoSHlwZXJGTEFT
SCBjb3VsZCBiZSBhIHRoaXJkIG1vZGUpLg0KPiBUaGUgYmluZGluZ3MgZGVzY3JpYmVkIGFib3Zl
IGFyZSBmb3IgdGhlIFNQSSBGTEFTSCB1c2UtY2FzZS4NCg0KSSB3b3VsZCBzYXkgaW4gZ2VuZXJh
bCwgdGhlcmUgYXJlIGp1c3QgdHdvIG1vZGVzICJTUEkgTW9kZSIgd2hpY2ggd2FzIA0KaW50ZW5k
ZWQgdG8gZG8gdGhpbmdzIGxpa2UgZGlzY292ZXIgdGhlIGF0dGFjaGVkIGZsYXNoIGFuZCBlcmFz
ZS93cml0aW5nLg0KQW5kIGRpcmVjdCBtYXBwZWQgd2hpY2ggd2FzIGludGVuZGVkIG9ubHkgZm9y
IHJlYWRpbmcuIEJvdGggb2YgdGhvc2UgDQptb2RlcyB3ZXJlIGludGVuZGVkIHRvIGJlIHVzZWQg
Zm9yIFFTUEkgZmxhc2gsIEh5cGVyRmxhc2ggb3IgT2N0YUZsYXNoLiANClRoZXJlJ3MgYSByZWdp
c3RlciBiaXQgeW91IHNldCB0byB0ZWxsIHRoZSBQSFkgd2hhdCB5b3UgYXJlIHRhbGtpbmcgdG8u
DQoNCg0KPiBPbiB0aGUgZHJpdmVyIHNpZGUsIGlmIHlvdXIgc3BpYnNjIGRyaXZlciBkb2VzIG5v
dCBmaW5kIGEgZmxhc2ggc3Vibm9kZSB0aGF0DQo+IGlzIGNvbXBhdGlibGUgd2l0aCAiamVkZWMs
c3BpLW5vciIsIGl0IHNob3VsZCByZXR1cm4gLUVOT0RFViwgc28NCj4gZHJpdmVycy9idXMvc2lt
cGxlLXBtLWJ1cy5jIGNhbiB0YWtlIG92ZXIgZm9yIHRoZSBzZWNvbmQgbW9kZSwgaWYgbmVlZGVk
Lg0KDQpJIHRoaW5rIGhlcmUgaXMgdGhlIGJpZ2dlciBpc3N1ZS9xdWVzdGlvbi9kZWNpc2lvbi4N
Cg0KVGhpcyBvbmUgSVAgYmxvY2sgc3VwcG9ydHMgMyBkaWZmZXJlbnQgdHlwZXMgb2YgRmxhc2g6
IFFTUEksIEh5cGVyLCBPY3RhLg0KQWxzbywgaXQgcnVucyBpbiAyIG1vZGU6DQogIlNQSSBNb2Rl
IiBmb3Igd3JpdGluZyBhbmQgb3RoZXIgc3R1ZmYNCiAiRGlyZWN0IE1vZGUiIFJlYWQgb25seSwg
YnV0IGZhc3RlciBhbmQgZGlyZWN0bHkgYWNjZXNzaWJsZS4NCg0KIChRU1BJIGFsc28gc3VwcG9y
dHMgMS1iaXQsMi1iaXQsNC1iaXQsIGFuZCA4LWJpdChkdWFsKS4uLi5idXQgd2UnbGwNCiAgZm9y
Z2V0IGFib3V0IHRoYXQgZm9yIG5vdyApDQoNClNvIHRoZSBxdWVzdGlvbiBpcyBpZiBzb21lb25l
IHJlYWxseSB3YW50cyB0byB1c2UgaXQgaW4gImRpcmVjdCBtb2RlIiANCm1vc3Qgb2YgdGhlIHRp
bWUsIGJ1dCBhbHNvIG5lZWQgdG8gc3dpdGNoIGJhY2sgaW50byAiU1BJIG1vZGUiIHRvIHJld3Jp
dGUgDQp0aGUgZmxhc2gsIHNob3VsZCB0aGlzIGRyaXZlciBoYW5kbGUgYm90aCBjYXNlcz8NCg0K
QmFzaWNhbGx5LCBpdCdzIGxpa2UgdGhlICdyb2xlIHN3aXRjaCcgaW4gdGhlIFVTQiBPVEcgZHJp
dmVycy4NCg0KVGhpcyBkcml2ZXIgSSBjcmVhdGVkIHdhcyBqdXN0IGF0dGVtcHRpbmcgdG8gY292
ZXIgdGhlICJTUEkgbW9kZSIgY2FzZSANCmZvciB0aG9zZSB0aGF0IHdhbnQgdG8gYmUgYWJsZSB0
byByZS13cml0ZSB1LWJvb3QgYXQgcnVuLXRpbWUuIEFuZCwgaXQgDQpjb3VsZCBiZSBleHRlbmRl
ZCB0byBzdXBwb3J0IEh5cGVyRmxhc2ggYW5kIE9jdGFGbGFzaCBpbiBTUEkgbW9kZSBhcyB3ZWxs
IA0KKHlvdSB1c2UgdGhlIHNhbWUgcmVnaXN0ZXJzLCBidXQgdGhlIGNvbW1hbmRzIGFyZSBkaWZm
ZXJlbnQpLg0KDQpTbyBteSBzdWdnZXN0aW9uIGlzIHRvIGZvcmdldCBhYm91dCB0cnlpbmcgdG8g
J3N1cHBvcnQnIGRpcmVjdCBtb2RlIGluIA0KdGhpcyBkcml2ZXIgYXQgdGhlIG1vbWVudC4gSWYg
eW91J3JlIHVzaW5nIHRoaXMgSFcgZm9yIHNvbWV0aGluZyBsaWtlIA0KWElQLCB0aGVuIGRvbid0
IGVuYWJsZSB0aGlzIGRyaXZlciBhdCBhbGwgKHdoaWNoIGlzIHdoYXQgd2UgaGF2ZSBiZWVuIA0K
ZG9pbmcpLg0KDQpDaHJpcw0KDQo=
