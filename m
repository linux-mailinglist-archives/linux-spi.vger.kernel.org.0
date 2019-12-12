Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0659211CFCC
	for <lists+linux-spi@lfdr.de>; Thu, 12 Dec 2019 15:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbfLLO3M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Dec 2019 09:29:12 -0500
Received: from mail-eopbgr1410123.outbound.protection.outlook.com ([40.107.141.123]:38456
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729611AbfLLO3L (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Dec 2019 09:29:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeZNpqDSqmTaiA81eZw42cp0b322Yq57egrc+DZTzBx0EWgqG5yLP7BBHG4lNZvHWXvl05OFzi18c+LG1JmO9h0Y8g1yS9vaKJ3HK0aGvYkuGS1MVG29Wo01JvVCyYkdsZTieFssadiZbfUSAZjcGq2YTg6jaz6AItddTYNNfQgKwEi6aZMz8yE1k/PdmKREem4U7jf8tVauHdtdbSTg2zxS9uKZJY7le1RXXvzx3VoLHHv9QVmXkk8riOyrrh60zdTUIzK0JUz21ey4mfRrpD4j0UkBN6WLutlP6i+wxbAbO+iPd4QJ9b9Ue9ib1wbJrby8gO46BvMZFi5cm4PFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeZ1a9Im1WbyCPr12Zc4qBhCePGHp8K/LJ7yKzheCGQ=;
 b=as0o7DKWT4A253ldAEnhIoe+30HoHghCad0Q8uKSDV3yTV+zSYipanFZ9TASnW3b5C/OPyVbdCv0kgobL4AncCjxPsarXv6tEWwnCd9Ob1LpKoNILWl/N5oV/x2w+siFQDsGTFQUCiCvp9rm5fVv4E5La7V4nE8nQxu6Pq6S6skJFkmy2tgxsxrTLJdOhJLdeblTxVaD1t6uyNyaOyG5QpPLuprx98/KAOAOHJ8sRjxr5elRGmWXgbrQ368WT2dGiyFt/KgNVDNCl3f9r9h97re2P6NcpjZuFBmmavW56fqjsKUZs1b+cGEDSjjDXIeU/vUokIdDjhmSVHXfudNDQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeZ1a9Im1WbyCPr12Zc4qBhCePGHp8K/LJ7yKzheCGQ=;
 b=Ms1msf5Bj/eXFdDKjJmU9nsbuTZLISHgzF1GEW/P3Rb0LR+bsPAEWI5WGPOGZhCxdEdAcM05d8inbe0gc+kY4fGC6A1oN0+1x88ovJj691HsJ4dJqYwha85BKl2gem1WdjmuXWMvIiyLVqaZtkNHoynzIbt5jVB6C3MYN0Gx08w=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1705.jpnprd01.prod.outlook.com (52.133.164.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Thu, 12 Dec 2019 14:29:07 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 14:29:07 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: RE: [PATCH v2 0/6] spi: Add Renesas SPIBSC controller
Thread-Topic: [PATCH v2 0/6] spi: Add Renesas SPIBSC controller
Thread-Index: AQHVrDsFo/XrCnZmIE+HK5Vec6rH7qevIW6AgAK0x/CAA35sAIABOkow
Date:   Thu, 12 Dec 2019 14:29:07 +0000
Message-ID: <TY1PR01MB1562D343E1AB06DCA2973DAC8A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <922cfa46-efb5-9e6d-67ea-3ac505b8211c@cogentembedded.com>
 <TY1PR01MB156215E8668C0317FA0826B18A580@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <e6a73df5-31c4-3472-f7bc-a0984f1f5380@cogentembedded.com>
In-Reply-To: <e6a73df5-31c4-3472-f7bc-a0984f1f5380@cogentembedded.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYmVkMTA4NWQtMWNlYi0xMWVhLWFhNTUtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XGJlZDEwODVlLTFjZWItMTFlYS1hYTU1LTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iMzYzNCIgdD0iMTMyMjA2MzQ1NDQzNjkwMjQ3IiBoPSJVMlJzTFducWJCbVBPVmhma3Q0WW5YZE1XYlE9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c199541c-7640-4802-3e48-08d77f0fa5a6
x-ms-traffictypediagnostic: TY1PR01MB1705:
x-microsoft-antispam-prvs: <TY1PR01MB1705C79BB4B99781BDCB1B998A550@TY1PR01MB1705.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(199004)(189003)(52536014)(7416002)(9686003)(2906002)(4326008)(5660300002)(54906003)(71200400001)(81156014)(81166006)(8676002)(8936002)(26005)(33656002)(186003)(55016002)(86362001)(110136005)(316002)(66946007)(66446008)(66476007)(66556008)(64756008)(76116006)(478600001)(966005)(6506007)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1705;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jln7POp5IvUxj3QxR0F/3Y+ZxhpJX/OFWYCiFVtLrfKw4nevzAxMhi2OqBITb3uXO1A9I8gL1mxdruIBtOP5TdPHFE4SQt0BUuI98mFXeipdYbzHhPDYUc3EYZ08MadDDQAWOuuhqdTK3Vi0ouw4lvFGt1NmYJYw2XBfTbylhXmJOL5cfsiLiw47fXwVBJeu1ZElOrbup3J9F2hgmv1so47DVRM+3M9UP01ppE/iqNCvTiEzM3OP+4H4zr5LuZ5yReF6wl0xdBkazRkWRoIaBewAjt6TgbYf310fbxhdAsa61ePLFKVjK0H4AcUl0AClOX1xGy2/c24d+WX8vEJB0Y0Rg/n8zD7n34+0jiguQoEa8MwpHFtyhGjeRctzWHl1uoQ7CxhyVxETPHHPUz/9ONPTcimR/5UyczVp1OKtsf2dcFyo9wttJX4mxey5LBCF
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c199541c-7640-4802-3e48-08d77f0fa5a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 14:29:07.5437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 42ZNXvaNlSPdW+qDnoeBE9J6KXQHacLLUnHjjihnzUntJS2eSXMv+JXTzs/ehiJu1aT253RCV3l5Lxx9TerCcmw8UFTaEfXgEmEe6LBPq7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1705
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gV2VkLCBEZWMgMTEsIDIwMTksIFNlcmdlaSBTaHR5bHlvdiB3cm90ZToNCj4gPiBTaW5jZSBR
U1BJLCBIeXBlckZsYXNoIGFuZCBPY3RhRmxhc2ggYXJlIGFsbCAnc2VyaWFsJyBGbGFzaA0KPiA+
IHRlY2hub2xvZ2llcywgSSB3b3VsZCBiZSBmaW5kIHdpdGggYSBkcml2ZXIgbmFtZSBvZiAiU0JT
QyIgKCJTZXJpYWwNCj4gPiBCdXMgU3BhY2UNCj4gPiBDb250cm9sbGVyIikgd2hpY2ggYXQgbGVh
c3QgbG9va3MgY2xvc2VyIHRvIHdoYXQgaXMgaW4gYWxsIHRoZQ0KPiA+IGhhcmR3YXJlIG1hbnVh
bHMuDQo+IA0KPiAgICBIb3cgYWJvdXQgIlNlcmlhbCBGbGFzaCBDb250cm9sbGVyIiBpbnN0ZWFk
Pw0KDQpJIHdvdWxkIGxpa2UgdGhhdCBiZXR0ZXIgdGhhbiAiUlBDIi4gQXQgbGVhc3QgaXQgZGVz
Y3JpYmVzIHdoYXQgaXQgaXMuDQpSUEMgc2VlbXMgbGlrZSBhIHN0dXBpZCBuYW1lIHRvIG1lIChi
dXQgbWF5YmUgdGhhdCdzIGp1c3QgYmVjYXVzZSBJIGtub3cNCmhvdyB0aGF0IG5hbWUgd2FzIGNo
b3Nlbi4uLikNCmh0dHBzOi8vd3d3LmN5cHJlc3MuY29tL25ld3MvY3lwcmVzcy1zaW1wbGlmaWVz
LWVtYmVkZGVkLXN5c3RlbS1kZXNpZ24tbmV3LWxvdy1waW4tY291bnQtaHlwZXJyYW0tbWVtb3J5
DQogIlRoZSBIeXBlclJBTSBhbmQgSHlwZXJGbGFzaCBzb2x1dGlvbiByZWR1Y2VzIHBpbiBjb3Vu
dCBieSBhdCBsZWFzdCAyOCBwaW5zLCAuLi4iDQoNCg0KQXMgYSBzaWRlIG5vdGUsIHRoZXJlIGlz
IGFub3RoZXIgSFcgYmxvY2sgaW4gUmVuZXNhcyB0aGF0IGRvZXMgdGhlIHNhbWUgDQp0aGluZyBh
cyB0aGUgU1BJLUJTQyB0aGF0IHRoZXkgdXNlIGluIHRoZSBNQ1UgZGV2aWNlcy4gVGhhdCBvbmUg
dGhleSANCmp1c3QgbmFtZWQgIlFTUEkiLg0KDQo+ID4+PiBUaGlzIGRyaXZlciBoYXMgYmVlbiB0
ZXN0ZWQgb24gYW4gUlovQTFIIFJTSyBhbmQgUlovQTJNIEVWQi4NCj4gPj4NCj4gPj4gICAgSW4g
dGhlIFNQSSBtb2RlIG9ubHksIEkgYXNzdW1lPw0KPiA+DQo+ID4gWWVzLiBBdCB0aGUgbW9tZW50
LCB0aGVyZSBhcmUgb25seSByZXF1ZXN0cyBmcm9tIHVzZXJzIGZvciBRU1BJIGZsYXNoDQo+ID4g
YWNjZXNzIChSWi9BIGFuZCBSWi9HIHVzZXJzKS4NCj4gDQo+ICAgIEkga2VlcCBiZWluZyB0b2xk
IGJ5IHRoZSBtYW5hZ2VtZW50IHRoYXQgd2UgbmVlZCBIeXBlckZsYXNoIHRvby4gOi0pIEluDQo+
IG91ciBCU1AgZGV2ZWxvcG1lbnQsIG91ciBlbmdpbmVlcnMgd2VudCAic2FtZSBoYXJkd2FyZSwg
MiBkcml2ZXJzIg0KPiB3YXkgKHdpdGggZGlmZmVyZW50ICJjb21wYXRpYmxlcyIgcGVyIGRyaXZl
cikuLi4NCg0KTXkgcGxhbiB3YXMgc2FtZSBIVywgc2FtZSAiY29tcGF0aWJsZXMiLCBzYW1lIGRy
aXZlci4uLmJ1dCB0aGUgZHJpdmVyIA0Kd291bGQgZWl0aGVyIHJlZ2lzdGVyIGEgU1BJIGNvbnRy
b2xsZXIgb3IgYSBIeXBlcmZsYXNoIGNvbnRyb2xsZXIuDQoNCk5vdGUgdGhhdCB0aGUgTU1DL1NE
SEkgaXMgdGhlIHNhbWUgSFcgYnV0IGNhbiBhY3QgbGlrZSAyIGRpZmZlcmVudCBwZXJpcGhlcmFs
cy4NCldlIGFsc28gaGF2ZSBVU0IgdGhhdCBjYW4gYmUgZWl0aGVyIGhvc3Qgb3IgcGVyaXBoZXJh
bC4NCg0KDQo+ID4+PiBUaGUgdGVzdGluZyBtb3N0bHkgY29uc2lzdGVkIG9mIGZvcm1hdHRpbmcg
YW4gYXJlYSBhcyBKRkZTMiBhbmQNCj4gPj4+IGRvaW5nIGNvcHlpbmcgb2YgZmlsZXMgYW5kIHN1
Y2guDQo+ID4+DQo+ID4+ICAgIERpZCB0aGUgc2FtZSAob3IgYXQgbGVhc3QgdHJpZWQgdG8gOi0p
IGFuZCBJIG11c3QgYWRtaXQgdGhhdA0KPiA+PiB3cml0aW5nIGRvZXNuJ3Qgd29yayB3aXRoIGFu
eSBvZiB0aGUgZnJvbnQgZW5kcy4uLiBJIHN0aWxsIG5lZWQgdG8gZ2V0DQo+IHRoaXMgZml4ZWQu
DQo+IA0KPiAgICBUaGUgbGFzdCB3b3JkIGZyb20gb3VyIEJTUCBwZW9wbGUgd2FzIHRoYXQgSkZG
UzIgZG9lc24ndCB3b3JrIHdpdGggdGhlDQo+IEh5cGVyRkxhc2ggZGVkaWNhdGVkIEJTUCBkcml2
ZXIuLi4gOi0vDQoNCklzIHRoYXQgd2h5IHRoaXMgIlJQQyIgcGF0Y2ggc2VyaWVzIGlzIHRha2lu
ZyBzbyBsb25nPw0KSXQncyBhIGZhaXJseSBzaW1wbGUgcGllY2Ugb2YgaGFyZHdhcmUuDQoNCldo
ZW4gSSBmaXJzdCBzYXcgdGhlIHNlcmllcyBvbiB0aGUgbWFpbGluZyBsaXN0LCBteSBwbGFuIHdh
cyB0byBqdXN0IHdhaXQNCmFuZCB0aGVuIGFkZCBSWi9BMSBhbmQgUlovQTIgc3VwcG9ydC4gQnV0
Li4uLml0IGxvb2tzIGxpa2UgaXQgYWxsIGRpZWQuDQoNClNvLCBJIHRob3VnaHQgSSB3b3VsZCBh
dCBsZWFzdCBwdXQgaW4gbXkgb3duIGRyaXZlciBmb3IgU1BJIGZsYXNoIG5vdywgDQphbmQgdGhl
biBnbyBiYWNrIGFuZCBhZGQgSHlwZXJGbGFzaC9PY3RhRmxhc2ggb25jZSBJIGdldCB0aGUgY2hp
cHMgDQpzd2FwcGVkIG91dCBvbiBvbmUgb2YgbXkgUlovQTIgYm9hcmRzLg0KDQoNCj4gPiBIb3dl
dmVyLCB0aGUgZHJpdmVyIEkgcG9zdGVkIGlzIHByZXR0eSBzaW1wbGUgYW5kIHdvcmtzLiBEb2Vz
IHRoZQ0KPiA+IEh5cGVyRmxhc2ggTVREDQo+IA0KPiAgICBUaGVyZSdzIG5vIEhGIGxpYnJhcnks
IG9ubHkgZnJvbnQgZW5kIGRyaXZlci4NCj4gICAgVGhlIHJlYWwgbGlicmFyeSBjb3ZlcnMgYm90
aCBTUEkgYW5kIEhGLiBUaGUgb25seSBkaWZmZXJlbmNlIGJldHdlZW4gdGhlDQo+IHR3byBpcyB0
aGUgaC93IHNldHVwIChtaW5vciBkaWZmZXJlbmNlKS4NCg0KQnV0IGlzIHRoaXMgImxpYnJhcnki
IHNvbWV0aGluZyBzcGVjaWZpYyB0byBSZW5lc2FzIGRldmljZXM/DQpUaGF0J3Mgd2hhdCBJJ20g
dHJ5aW5nIHRvIHVuZGVyc3RhbmQuDQoNCk15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBIeXBlckZs
YXNoIHVzZXMgc3RhbmRhcmQgQ0ZJIGNvbW1hbmRzLCBzbyBhbGwgDQp3ZSBuZWVkIHRvIGRvIGlz
IHJlZ2lzdGVyIGEgQ0ZJIGRldmljZSBpbiB0aGUgZHJpdmVyLCBqdXN0IGxpa2Ugd2UgDQpyZWdp
c3RlciBhIHNlcmlhbCBmbGFzaCBkZXZpY2UuDQoNCihJIGd1ZXNzIEkgY291bGQgZ28gbG9vayBh
dCB0aGUgc2FtcGxlIGNvZGUgZm9yIG91ciBSVE9TIHBhY2thZ2UgYW5kIGZpbmQgb3V0KQ0KDQoN
Cj4gPiBsaWJyYXJ5IHRoYXQgeW91IGFyZSBwcm9wb3NpbmcgaGF2ZSBhIHZlcnkgZGlmZmVyZW50
IEFQSSB0aGFuIGp1c3QNCj4gPiAnc2VuZCBieXRlcycgYW5kICdyZWNlaXZlIGJ5dGVzJz8NCj4g
DQo+ICAgIFRoZXJlJ3MgInByZXBhcmUiIGFuZCAidHJhbnNmZXIiIEFQSXMgYW5kIGFsc28gImRp
cmVjdCBtYXAgcmVhZCIgQVBJLg0KDQpJIHdvbmRlciB3aGF0IGlzIHRoZSB2YWx1ZSBvZiB0aGUg
ImRpcmVjdCBtYXAgcmVhZCIgKG90aGVyIHRoYW4gWElQIGluIA0KUlovQSBzeXN0ZW1zKS4gSWYg
eW91IHJlYWxseSB3YW50IHRvIGRpcmVjdGx5IGFjY2VzcyB0aGUgZmxhc2ggKG5vIA0KYnVmZmVy
aW5nIHRob3VnaCB0aGUgTVREIGxheWVyKSwgeW91IG5lZWQgdG8gcmVnaXN0ZXIgYXMgYSBtdGQt
cm9tIGRldmljZSwgDQphbmQgdGhlbiB5b3UgZG9uJ3QgcmVhbGx5IG5lZWQgYW4gQVBJIGF0IGFs
bC4NCg0KDQpDaHJpcw0KDQo=
