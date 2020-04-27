Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4D91B9525
	for <lists+linux-spi@lfdr.de>; Mon, 27 Apr 2020 04:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgD0Cfx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 26 Apr 2020 22:35:53 -0400
Received: from mail-db8eur05on2068.outbound.protection.outlook.com ([40.107.20.68]:51681
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726431AbgD0Cfx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 26 Apr 2020 22:35:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fiuk45+qOroCg8BGdIpZiKhmMGowWX7gONbA2iA5PWx5jvYiXDHAxoLyVslOPQNAYt8JE2Xs9wN1dTvoybIhcGOidkCz4Sj33oY4kYHLdccFk/PhqrWtog1bvyEeFaG1o8ZMmf0tr7a6xXChSvbLRtqtMoMnknDQDCFDSBpkk7EtjRLqf3qq3bl/Ke9sEIFCb2dNnDsIo/n0f/2jmZCyfYH5nodsGqaWx82s4XKk/M96h6Iw1dY/guXVtqJLX3S6yVQAnH4P1RJ3fdcFrYyGE9vqR6IbUy9uuhjMeOa6NY7rCPGk6SLp16nANiOxKFH2rqH17zQT+46LVPtPVncFvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxhX1nS1g6li4T6OFUAyI4lFgZCYU4gZXcHukkyIQtI=;
 b=KuH6wCwuca9faNh+lD3bm7++fzRTggRoPSgWMEik2S3qELVdsB9NvQRgg8eaz3lO/k4O78FUfO71TShTLZk1WBmpQTfV1VzK99Q+BMJmukN32n2m+REuc9wnv6oi3iCCg8h0YS0QPV/TjCTc2oDt3AfDX+66+qeEEZar3r+vOTnPyiYnVLdZYQOEnS+1kSsKbjrMqaIhh10eLA6k2JEHzLf7u0uxMnBLh1US3sFiS1aasJv5AVLwmCzmOw8pNex6uD5bJ5gjM5+jFxibntjY6kPF+wdDKTFibLkDI+KJFet6x3wlSjUtbDiWcNbpL37d93GUJd1GIEXY3tzq/MQA/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxhX1nS1g6li4T6OFUAyI4lFgZCYU4gZXcHukkyIQtI=;
 b=kNleaTSjjQjilqM+w/eYNAeEnF/PbN88h7C0U5pjmo0PgC8CxCalTf9u1oyKG7AubnwwQq/DGhRDR7euQXea/Mr6EcQQzXlbsRC3ZhCxZSxaCX/WlC43FN90g+RdbyGpjqhLo9/LCzVwO1H+SFYFt82T6DVqhIfmmJrgQgN5kyM=
Received: from AM7PR04MB7016.eurprd04.prod.outlook.com (2603:10a6:20b:11e::22)
 by AM7PR04MB7142.eurprd04.prod.outlook.com (2603:10a6:20b:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 02:35:49 +0000
Received: from AM7PR04MB7016.eurprd04.prod.outlook.com
 ([fe80::7dfb:6472:5abb:c5e0]) by AM7PR04MB7016.eurprd04.prod.outlook.com
 ([fe80::7dfb:6472:5abb:c5e0%3]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 02:35:49 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Mark Brown <broonie@kernel.org>, Leo Li <leoyang.li@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] spi: spi-fsl-dspi: Adding shutdown hook
Thread-Topic: [EXT] Re: [PATCH] spi: spi-fsl-dspi: Adding shutdown hook
Thread-Index: AQHWGf/rvE9wzqRJLEmuQo+oamp3cKiIO52AgAQJReA=
Date:   Mon, 27 Apr 2020 02:35:49 +0000
Message-ID: <AM7PR04MB7016C9550F95541971A7EE89EDAF0@AM7PR04MB7016.eurprd04.prod.outlook.com>
References: <20200424061216.27445-1-peng.ma@nxp.com>
 <158773300537.30241.1154325901954580764.b4-ty@kernel.org>
In-Reply-To: <158773300537.30241.1154325901954580764.b4-ty@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 894c44c9-b1bd-44a1-d8f0-08d7ea53b2a8
x-ms-traffictypediagnostic: AM7PR04MB7142:|AM7PR04MB7142:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB71421C41F9A1DEAE781AB2E3EDAF0@AM7PR04MB7142.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7016.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(66946007)(66446008)(66556008)(76116006)(6636002)(66476007)(110136005)(2906002)(64756008)(71200400001)(186003)(5660300002)(4326008)(86362001)(7696005)(83080400001)(26005)(54906003)(45080400002)(316002)(33656002)(478600001)(6506007)(52536014)(44832011)(8936002)(81156014)(55016002)(8676002)(9686003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ko+fitTywLkZvAAXzNIHnB35Fr1mYGYEx37Pzisy1vq65CevOYHvgxFWdklTotRkOFJBc/mjjwtN5o2RwN5iTr7MQcnzbVp8f5+DMjDS+5MdyAy9HNsSghiHi/JT5qaqf9FSXxzEx/BF8nRD0MFo+gbFH69AlpAuHpc7of+62AlpslEGeEiQvlrddwCrQZYONPpHdT87f1GfhAE+dSue8ictpIcl7AukhkSNKDYtZnP7Xm3yhwv3n+axjfNKFtq4Z9+2zBw4E4Q8NA38+0YJnB8Qg5MDI3B+q+5KkceiGyZVHmPXyY0Aqgaynq+OqGEQkJ3DYuuiwcJdXBUrOT7WQ+EyQxXHIprRtxvV3ZVCwto/hEE0A30Txd15gnT/nWhjicA4v3qEqoW7SMPoH9NrsszWdq+B0RMMxCfbvAWdf5vl8JdTBdlWUTl0augmd+sV//FYIt5Jc7sFJemJprpiJeZDJ9EFuOK5gbxJmUCXuQo2x0tdUWSeCdS+lWEFxnCR0eNfoNtdjBKaxFVOVJU8Yg==
x-ms-exchange-antispam-messagedata: HQcr9vSBDJItgKa9ChaU6vaNTALjpAj/3ez3QMwyBJPN9g+9o/2qcRywpyCPIiwP6/A5Y3fpY0aLMJ6lJfwjQMtp1nxA6yS8+DkA8zUrUyzof2olYvJqNvoXIYxAbLcDEuFoypyUTkevmITK2I79VZZI2ENgcZj92C4j6wja/IjmwHI5QdDRSncEW/2OtprOTfD8JPr7R+deVibViwab8fwSgaenV5cA76iA5QDd7JN7umMsyzZhw9uA3YxLo/AASbndo5jLtxaUVFdQqKSachilpLnLdkuXK6XJCtQ4tJLXOFeUIkMAT4rA/wyGUp0kqS+zMCXrrV/H0lQm1j7aB5QcWKsfMWvUAYHR/DVE9x7m00Pmuq0QujRJyN0A2n0vjZV4YqEE+gjjJ/LtA+rz5UH2J0GOUGVPWQKQKB0uK6bj8NmJ5PBqG9et2i+lLLF/jbvWzGlCIgPE9r27XgnEXJDXKbnAxc+/PTdxPJcsefMP0GeZHHbKJ+XqJsrIZ0w3oYxKahds4awpMKGlwEqwu2O3CfUz+lTM2vcNARt9f/25iVm6Z1YwpphgsgZUiPR726tOHYIie3b6LvWKgYx4sIpxXv75Lo8RJY8KWmjCee1ohfCYrQUJIVAyN9vsWL/rZJkYlRy+SEk3/k9MlAzVvlPUtCdbxpKHdfP8vc7j4Y5c+2a3Zb3xM2y17NhXgRRsKW7IqH+lEnW91SczUJ4vpqoHHk5kPfBHMuBieb24PYRabzExR76fp65DN8duInGP2jK9ckD9BtTDNpEc1vR68P9oB6qoe5G++7tuHetnMVE=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894c44c9-b1bd-44a1-d8f0-08d7ea53b2a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 02:35:49.5176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bTLHRSMtX50/G1QK/Vzmh85W3HkQzqwywXvw+LmZEoDV8xjvLTYu2ZZ908ZWexSf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7142
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgTWFyaywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTWFyayBCcm93
biA8YnJvb25pZUBrZXJuZWwub3JnPg0KPlNlbnQ6IDIwMjDE6jTUwjI0yNUgMjA6NTcNCj5Ubzog
TGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+OyBQZW5nIE1hIDxwZW5nLm1hQG54cC5jb20+DQo+
Q2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5v
cmcNCj5TdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIXSBzcGk6IHNwaS1mc2wtZHNwaTogQWRkaW5n
IHNodXRkb3duIGhvb2sNCj4NCj5DYXV0aW9uOiBFWFQgRW1haWwNCj4NCj5PbiBGcmksIDI0IEFw
ciAyMDIwIDE0OjEyOjE2ICswODAwLCBQZW5nIE1hIHdyb3RlOg0KPj4gV2UgbmVlZCB0byBlbnN1
cmUgZHNwaSBjb250cm9sbGVyIGNvdWxkIGJlIHN0b3BwZWQgaW4gb3JkZXIgZm9yIGtleGVjDQo+
PiB0byBzdGFydCB0aGUgbmV4dCBrZXJuZWwuDQo+PiBTbyBhZGQgdGhlIHNodXRkb3duIG9wZXJh
dGlvbiBzdXBwb3J0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFBlbmcgTWEgPHBlbmcubWFAbnhw
LmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvc3BpL3NwaS1mc2wtZHNwaS5jIHwgMjMgKysrKysr
KysrKysrKysrKysrKysrKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKQ0K
Pj4NCj4+IFsuLi5dDQo+DQo+QXBwbGllZCB0bw0KPg0KPg0KPmh0dHBzOi8vZXVyMDEuc2FmZWxp
bmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdpdC5rZXJuZQ0K
Pmwub3JnJTJGcHViJTJGc2NtJTJGbGludXglMkZrZXJuZWwlMkZnaXQlMkZicm9vbmllJTJGc3Bp
LmdpdCZhbXA7ZGF0YQ0KPj0wMiU3QzAxJTdDcGVuZy5tYSU0MG54cC5jb20lN0MxY2FlMzZhMTli
ZTc0MTcyNTAxYzA4ZDdlODRlZjQxOA0KPiU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAx
NjM1JTdDMCU3QzAlN0M2MzcyMzMyOTgxMTI2NjE4NTQNCj4mYW1wO3NkYXRhPTdXbGxTbHpsSDVB
dG9RNFQ4RHZ2STdHQ3lzUG1YaXZudTRBOGFnaFV4eXMlM0QmYW1wO3Jlc2VyDQo+dmVkPTAgZm9y
LTUuOA0KPg0KPlRoYW5rcyENCj4NCj5bMS8xXSBzcGk6IHNwaS1mc2wtZHNwaTogQWRkaW5nIHNo
dXRkb3duIGhvb2sNCj4gICAgICBjb21taXQ6IGRjMjM0ODI1OTk3ZWM2ZmYwNTk4MGNhOWUyMjA0
ZjRhYzNmOGQ2OTUNCj4NCj5BbGwgYmVpbmcgd2VsbCB0aGlzIG1lYW5zIHRoYXQgaXQgd2lsbCBi
ZSBpbnRlZ3JhdGVkIGludG8gdGhlIGxpbnV4LW5leHQgdHJlZQ0KPih1c3VhbGx5IHNvbWV0aW1l
IGluIHRoZSBuZXh0IDI0IGhvdXJzKSBhbmQgc2VudCB0byBMaW51cyBkdXJpbmcgdGhlIG5leHQg
bWVyZ2UNCj53aW5kb3cgKG9yIHNvb25lciBpZiBpdCBpcyBhIGJ1ZyBmaXgpLCBob3dldmVyIGlm
IHByb2JsZW1zIGFyZSBkaXNjb3ZlcmVkIHRoZW4NCj50aGUgcGF0Y2ggbWF5IGJlIGRyb3BwZWQg
b3IgcmV2ZXJ0ZWQuDQo+DQo+WW91IG1heSBnZXQgZnVydGhlciBlLW1haWxzIHJlc3VsdGluZyBm
cm9tIGF1dG9tYXRlZCBvciBtYW51YWwgdGVzdGluZyBhbmQNCj5yZXZpZXcgb2YgdGhlIHRyZWUs
IHBsZWFzZSBlbmdhZ2Ugd2l0aCBwZW9wbGUgcmVwb3J0aW5nIHByb2JsZW1zIGFuZCBzZW5kDQo+
Zm9sbG93dXAgcGF0Y2hlcyBhZGRyZXNzaW5nIGFueSBpc3N1ZXMgdGhhdCBhcmUgcmVwb3J0ZWQg
aWYgbmVlZGVkLg0KPg0KPklmIGFueSB1cGRhdGVzIGFyZSByZXF1aXJlZCBvciB5b3UgYXJlIHN1
Ym1pdHRpbmcgZnVydGhlciBjaGFuZ2VzIHRoZXkgc2hvdWxkDQo+YmUgc2VudCBhcyBpbmNyZW1l
bnRhbCB1cGRhdGVzIGFnYWluc3QgY3VycmVudCBnaXQsIGV4aXN0aW5nIHBhdGNoZXMgd2lsbCBu
b3QgYmUNCj5yZXBsYWNlZC4NCj4NCj5QbGVhc2UgYWRkIGFueSByZWxldmFudCBsaXN0cyBhbmQg
bWFpbnRhaW5lcnMgdG8gdGhlIENDcyB3aGVuIHJlcGx5aW5nIHRvIHRoaXMNCj5tYWlsLg0KPg0K
W1BlbmcgTWFdIE9LLCBHb3QgaXQsIHRoYW5rcyB2ZXJ5IG11Y2ghDQoNCkJlc3QgUmVnYXJkcywN
ClBlbmcNCj5UaGFua3MsDQo+TWFyaw0K
