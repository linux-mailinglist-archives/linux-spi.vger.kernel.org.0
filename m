Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1943C121CA9
	for <lists+linux-spi@lfdr.de>; Mon, 16 Dec 2019 23:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfLPWWI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Dec 2019 17:22:08 -0500
Received: from mail-eopbgr1410117.outbound.protection.outlook.com ([40.107.141.117]:21568
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbfLPWWH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Dec 2019 17:22:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQ4mc0e9hk79Ho0knuzRD5mn4fR6wOt5IX3eoK8brUdmlXWBeg4QaJ9+Y7ptl7V/4OLaL/UOQj3OO8mC7vom3EuZGhlm3zR77sujV5gJyTkc6VelgCxQ4jPuHAbV1V5d67FHpXl6yZfD/wbaHXLTbiaSkpn6RtmSxs/tNkRuBmX1mxjuZKQiaHolM+o4Tma9kGzSpEexLsHWU0JtDl9SXlXl2L5F/zY93dsHC9F/E321Oz+DsGXwDQmmqwJb+oK8LidrTujLDy+VGlOSKQOlmDhcynE8VRbTQ4AWq9k9Fxewj79fJ4s8oiAGnvkbekaLtWdsbC/5D3j6aRW7F6nURw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZM7x4/dxpf2yVgpNms5omvMeZY1cUKJkl/IOnV+kAiw=;
 b=meNDZX5YNB0Uw2wv7Jv1MFEZQUyZ+d+ArNMoSx4TytMRMiP8CNQWvy28Hwf4vWz/5FW1JPSFT4FE2Oo+f0yAVSHQlJ/G5+u3iUAyrQClvikBeM8R4YCWLjsBROdYik1mNF9tgR8OS09bTs12vbyYyq7+Cj/f2HxCdyYb4w6Hl46So7Jr4RL1dW2E/ML5/CU06f4tKjF4eiS7XG1DIdNkB5lumElM3fJozVNM5AobOQQrAMYJNsbE7UQms4jNjO5BA5zowHF7/ZVfOctrTkB8aLahzo5ctub2XLd+DtJGqVWu6GRMfBPJZpgbRbPxWEziUZaMXLlw6+cFrezdUPLOMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZM7x4/dxpf2yVgpNms5omvMeZY1cUKJkl/IOnV+kAiw=;
 b=bjBTJeplLsg2noH7nEsgihncB1owFwjMRG2fCAB6lMUm9VcuvP9iHAgqlVtvwI0iUMacNz7db8JO31fukuCuvbrc7dC6S+ZUe9CqFgn7g5RXyDW1y1Cggcs7sLDe/FeUDcxr0hHf7/SZlmxRoZz4OEIVSpgcezwAwZ79m4sDkvo=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1596.jpnprd01.prod.outlook.com (52.133.162.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Mon, 16 Dec 2019 22:21:24 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 22:21:24 +0000
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
Thread-Index: AQHVrDsFo/XrCnZmIE+HK5Vec6rH7qevIW6AgAK0x/CAA35sAIABOkowgAa4UICAABhMQA==
Date:   Mon, 16 Dec 2019 22:21:23 +0000
Message-ID: <TY1PR01MB1562B9EB96818DCA507079808A510@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <922cfa46-efb5-9e6d-67ea-3ac505b8211c@cogentembedded.com>
 <TY1PR01MB156215E8668C0317FA0826B18A580@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <e6a73df5-31c4-3472-f7bc-a0984f1f5380@cogentembedded.com>
 <TY1PR01MB1562D343E1AB06DCA2973DAC8A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <590840ce-a250-2512-3d04-c2420d83f7da@cogentembedded.com>
In-Reply-To: <590840ce-a250-2512-3d04-c2420d83f7da@cogentembedded.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNjIyNzMwMDAtMjA1Mi0xMWVhLWFhNTYtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XDYyMjczMDAxLTIwNTItMTFlYS1hYTU2LTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iMjAzNiIgdD0iMTMyMjEwMDg0ODA1MTIxODc5IiBoPSJ6R3VaZys0bEgxNlZjNVgvcGk1T2ZJa3pxWmc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da50c817-175d-4d27-a896-08d782764924
x-ms-traffictypediagnostic: TY1PR01MB1596:
x-microsoft-antispam-prvs: <TY1PR01MB15964B0FD39AD7353DA111628A510@TY1PR01MB1596.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(199004)(189003)(7416002)(64756008)(76116006)(66946007)(66476007)(66556008)(2906002)(7696005)(86362001)(33656002)(478600001)(4326008)(316002)(8936002)(66446008)(6506007)(9686003)(81166006)(5660300002)(81156014)(26005)(186003)(8676002)(71200400001)(52536014)(54906003)(110136005)(55016002)(582214001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1596;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9UmYBD3CyCFznE6yCd4LwSw0KLfViR5WxXMCFHtw9/Ux4o2+mgTRMWFRyHcNfLlKm8kd+xZQ9nYoPrcAkRCSeDvVzLKTQCyGwBP9Fqeav9I33ikpBHLbZok3fBnRSRxrXZa2ZTTdSlOAmkH/cFQMtb1s+5UwbVj+5jE294CzVpe2NBUuSU4NWVpas9C9+eiZ3h7jFi1YoSHMrcyDeqkY2o2ATPfI0Nx2phblTYc0Z44faTEszijYfhGBO9OlnSfDt4YwTPnJz/xYOCljGDiNRiFitKfQQExYlOBUCLAJ+3D8n7S6BJUdRqDyJkrAry+EhEpaH2PCGowLslPwbzgpgnSdb/5DvwX/HFT4yXtHyWqHtj4VGYIPdSbWH3PzgU03VsJfCiHu+01RSqRNpXkg5iiPSnmySFvW3bUMbkMhrniCo0196K5pXBzGJaIyKwfacKTFB3//oUS5GJf8McXO4IOi0cANr5J4SvVvBW6RM1Yex4CkJX1pXqb9Y/zqmI5I
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da50c817-175d-4d27-a896-08d782764924
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 22:21:23.5029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ItarIGcZuAJKi+oYajFT2gmiUC71U8UwGW5tJEYescy00Z/KFfROUk+PnY6BK8bIFNGNNnN2Q4ZGnSP1B18X5p3qhf3cGqtLkmeLgWQZS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1596
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGVsbG8NCg0KT24gTW9uLCBEZWMgMTYsIDIwMTksIFNlcmdlaSBTaHR5bHlvdiB3cm90ZToNCj4g
PiBBcyBhIHNpZGUgbm90ZSwgdGhlcmUgaXMgYW5vdGhlciBIVyBibG9jayBpbiBSZW5lc2FzIHRo
YXQgZG9lcyB0aGUgc2FtZQ0KPiA+IHRoaW5nIGFzIHRoZSBTUEktQlNDIHRoYXQgdGhleSB1c2Ug
aW4gdGhlIE1DVSBkZXZpY2VzLiBUaGF0IG9uZSB0aGV5DQo+IA0KPiAgICBNQ1U/DQpZdXAuDQog
IEJ1dC4uLml0IGhhcyBubyBzaWduaWZpY2FuY2UgdG8gdGhpcyBkaXNjdXNzaW9uIHRob3VnaCA6
KQ0KDQoNCj4gPiBXaGVuIEkgZmlyc3Qgc2F3IHRoZSBzZXJpZXMgb24gdGhlIG1haWxpbmcgbGlz
dCwgbXkgcGxhbiB3YXMgdG8ganVzdCB3YWl0DQo+ID4gYW5kIHRoZW4gYWRkIFJaL0ExIGFuZCBS
Wi9BMiBzdXBwb3J0LiBCdXQuLi4uaXQgbG9va3MgbGlrZSBpdCBhbGwgZGllZC4NCj4gDQo+ICAg
IE5vLiA6LSkgSXQgd2FzIHdvcmtlZCBvbiBkdXJpbmcgYWxsIHRoZXNlIG1vbnRocy4uLiBJIGp1
c3QgZmluYWxseSBkZWNpZGVkDQo+IHRvIHN0b3AsIHRha2UgYSBkZWVwIGJyZWF0aCwgYW5kIHBv
c3Qgd2hhdCBwYXRjaGVzIEkgaGFkIGFjY3VtdWxhdGVkLCB3aXRob3V0DQo+IHRoZSB3aG9sZSBk
cml2ZXIgc3VpdGUgd29ya2luZyBmaXJzdC4uLiBJJ20gc29ycnkgaXQgdG9vayBzbyBsb25nLi4u
Lg0KDQpTbyBhdCB0aGUgbW9tZW50LCB0aGVyZSBpcyBub3RoaW5nIHlldCBmb3IgbWUgdG8gJ3Ry
eScgb24gdGhlIFJaL0Egc2VyaWVzLCBjb3JyZWN0Pw0KDQoNCj4gPiBNeSB1bmRlcnN0YW5kaW5n
IGlzIHRoYXQgSHlwZXJGbGFzaCB1c2VzIHN0YW5kYXJkIENGSSBjb21tYW5kcywgc28gYWxsDQo+
IA0KPiAgICBUaGUgQ0ZJIGNvbW1hbmQgc2V0IGRyaXZlciBuZWVkZWQgc29tZSBjaGFuZ2VzIHRv
byAoZS5nLiB1c2luZyB0aGUgc3RhdHVzDQo+IHJlZ2lzdGVyIHRvIGRldGVybWluZSBpZiBhIGNv
bW1hbmQgaXMgZG9uZSkuDQoNClNvIHRoZSBleGlzdGluZyBNVEQtU1BJIGxheWVyIGtub3dzIGhv
dyB0byB0YWxrIHRvIFNQSSBkZXZpY2VzLg0KQW5kLCB5b3UndmUgZml4ZWQgdXAgdGhlIGV4aXN0
aW5nIENGSSBsYXllciB0byB0YWxrIHRvIEh5cGVyRmxhc2ggZGV2aWNlcy4NCkJ1dCwgeW91IGRv
IG5vdCB3YW50IHRoZXNlIE1URCBsYXllciB0byB0YWxrIGRpcmVjdGx5IHRvIGEgUmVuZXNhcyBI
VyBkcml2ZXI/DQpZb3Ugd2FudCB0byBwdXQgYW5vdGhlciBzb2Z0d2FyZSBsYXllciBpbiBiZXR3
ZWVuPw0KDQoNCkknbSBndWVzc2luZyB0aGF0IGZyb20gdGhpcyBzdGF0ZW1lbnQuLi4uDQoNCj4g
Pj4+IGxpYnJhcnkgdGhhdCB5b3UgYXJlIHByb3Bvc2luZyBoYXZlIGEgdmVyeSBkaWZmZXJlbnQg
QVBJIHRoYW4ganVzdA0KPiA+Pj4gJ3NlbmQgYnl0ZXMnIGFuZCAncmVjZWl2ZSBieXRlcyc/DQo+
ID4+DQo+ID4+ICAgIFRoZXJlJ3MgInByZXBhcmUiIGFuZCAidHJhbnNmZXIiIEFQSXMgYW5kIGFs
c28gImRpcmVjdCBtYXAgcmVhZCIgQVBJLg0KPiANCj4gICBUaGUgMXN0IG9uZSBwcmVwYXJlcyB0
aGUgdmFsdWVzIHRvIGJlIHdyaXR0ZW4gaW4gZWl0aGVyIFNQSSBtb2RlIG9yIGRpcmVjdA0KPiBy
ZWFkIG1vZGUgcmVnaXN0ZXJzLiBUaGVuIHlvdSBjYW4gY2FsbCAidHJhbnNmZXIiIG9yICJkaXJl
Y3QgbWFvIHJlYWQiIHdoaWNoDQo+IHdvdWxkIHdyaXRlIG91dCB0aGUgcmVnaXN0ZXIgdmFsdWVz
IGludG8gZWl0aGVyIHNldC4uLg0KDQouLi50aGF0IHlvdSB3YW50IG1vcmUgY29udHJvbCBvZiB0
aGUgZGF0YSBzdHJlYW0gYmVpbmcgcGFzc2VkIHRvIHRoZSBSUEMtSUYgZHJpdmVyLg0KQ29ycmVj
dD8/DQoNCkl0IGFsbCBrZWVwcyBzb3VuZGluZyBjb21wbGljYXRlZCwgdW5sZXNzIEknbSBqdXN0
IG5vdCB1bmRlcnN0YW5kaW5nIHRoZSBjb2RlDQp5b3UgYXJlIHRyeWluZyB0byBpbXBsZW1lbnQu
DQoNCg0KQ2hyaXMNCg0K
