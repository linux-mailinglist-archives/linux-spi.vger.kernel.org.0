Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5083111E5CF
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2019 15:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfLMOpb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Dec 2019 09:45:31 -0500
Received: from mail-eopbgr1410132.outbound.protection.outlook.com ([40.107.141.132]:51084
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727619AbfLMOpb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 13 Dec 2019 09:45:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQ9Jbc6CVePKa53w/Ld0ryjEJdTv2TOSGzTZkoHo9CCcuVqwUYcEvdyRxLg+wz7vZ0YdE6R2iT538bjj+hLfZbWWq74omqKPW3HaGBdShakAhuD0mw6C2t6DZU9ga21nhCr2RQ6iGkD1ueyf3Dj7Pz/kzjy3DGR7btvudw7aUdWFHWnGMZHQt/xEAiWfJZfir0HW56nzPlcQkASmX1dPXLPoxscqHGog/s6VDb7dbBpZKLr8/NC1deYEiMSeJWYwDXljzdZaRU6Rc68kFRWRliHLPcqQUupLQGEq0+MevKKER3RNXqWhHXlKtcOHCVlYPn/GtCUvk6Cua56Uj6XNBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=187qFnMK3ew9xF+a54999YTDhE+t3QfTcicxJq3WiSM=;
 b=irs0oaB3P5F/9bSv3FWh282XPvoSzeZn4EOENPGo7uF6TJU9khaDqmewhOEvSNpL+aXpWlSDl+E5t5WUX8KcVXxd6lFpzplE8OvmEZSXSvOChK4fOCAQhWUhNmZGM3VduJoklkw//Z1JENhbhZTR4MEMQtlrLrvG1XXGWQkzC0aEmSC1X6f46zk8T5eXkz1iNseUaVIuUWEhAwoHmmWpOQspWQbXf/W0UbMsFRDs8vkrzcPmqCi+E9QVpS+LV34ZqWAmdQcNMRodKBzWwiW/s+bqqAGWDyOxPlPNgpLEoVcRst0qGmWckwnF31/WtpAnib/bnVcSB4ZKWhbC4QEwsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=187qFnMK3ew9xF+a54999YTDhE+t3QfTcicxJq3WiSM=;
 b=WCLffvB4TD5atrdzeXVU1sfClEQOOZFKVvoUX8YUyI08ZOx3ghsKrzzEwcXvMizz0LfXQoY3PiRHdoXaCAdblOJ3Kxha//ymBN2KFLRMwMF920Mx8M/AHwfqjw/eN/7v5j3zA0LbSGiXzY/zV0QAXOIg63IG8+TFwLGWt5ryong=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1499.jpnprd01.prod.outlook.com (52.133.161.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Fri, 13 Dec 2019 14:45:26 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2538.017; Fri, 13 Dec 2019
 14:45:26 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: RE: [PATCH v2 1/6] spi: Add SPIBSC driver
Thread-Topic: [PATCH v2 1/6] spi: Add SPIBSC driver
Thread-Index: AQHVrDsMpgzelIsB7UCp/Sk4dX5yJ6e27ngAgAAFoLCAAOwDgIAATQNQ
Date:   Fri, 13 Dec 2019 14:45:25 +0000
Message-ID: <TY1PR01MB15625260CB3CE48A3FBA11058A540@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <20191206134202.18784-2-chris.brandt@renesas.com>
 <37c13497-d20f-583f-72d7-1e3c8a241990@cogentembedded.com>
 <TYXPR01MB1568ED4D40CEC399E64F6A2B8A550@TYXPR01MB1568.jpnprd01.prod.outlook.com>
 <CAMuHMdWCgOsj_ZWF-+f-5XjZU9RSCm6Ww3gBmYQeSGz0B77_ig@mail.gmail.com>
In-Reply-To: <CAMuHMdWCgOsj_ZWF-+f-5XjZU9RSCm6Ww3gBmYQeSGz0B77_ig@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMzE5NGMzOGMtMWRiNy0xMWVhLWFhNTUtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XDMxOTRjMzhkLTFkYjctMTFlYS1hYTU1LTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iMTE3OCIgdD0iMTMyMjA3MjE5MjQ3NDAyMDcwIiBoPSJRY3VrVldLbnkzR3ZtV3kwWll2WFhVN1loZWc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7aaa84f3-c561-4ae2-c122-08d77fdb17bc
x-ms-traffictypediagnostic: TY1PR01MB1499:
x-microsoft-antispam-prvs: <TY1PR01MB1499AAFEA0A9F512511F6E128A540@TY1PR01MB1499.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(189003)(199004)(316002)(7696005)(66946007)(54906003)(4744005)(52536014)(64756008)(76116006)(66556008)(66446008)(2906002)(66476007)(5660300002)(6506007)(186003)(53546011)(8936002)(86362001)(81166006)(71200400001)(8676002)(478600001)(4326008)(55016002)(9686003)(33656002)(6916009)(7416002)(26005)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1499;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mFTOngM17cy6ahWtOUn6JF5AEvjPh4pDkKwYNkxMisCox65xzQLp7+UBl7IwARuQ4+OsxUwtZ68MsoFglcXX0IpbzfGbjq2PQi/AFMk50arSWTg2yCeEWnDdb2KG11Ra2f5rWbVnwbYqhgVQn+FnXxSL8ybR2HUWxGekuTXWCNWVrtacKH+h6dqDceTMqtf9m1zWBWfz8GCTHAKObTW+g25i5cZoZB9XLMozsFHeaH8k9TUiwqsQ7EYcF1zv7GT+WsWBm9eoHmc81CeTRLGCGNRfvQYd//36ddGpxOB35kFvlsmDqHUZpneJPGqKpnbQKAdfslvwUb7Y7KYdVO4zUqiIl0pDSvJ46gaDguj7827JgDiJ5bF22Wy4eMbqZJuTjXBsHjdAZmxDO5JaFam56M0b1atdLkUw6+4ZcVvAR+axoVKyCDl5GmxHYJJTQYVn
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aaa84f3-c561-4ae2-c122-08d77fdb17bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 14:45:26.4358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GX+L/bDXMnqasYlQPXTdt15bAoR3LP3dRW97Gjq9h03PfgbBKKJ/Z1SLXbHFGf3q1rhiSEvJ4MofewWMls0d3zr4hRFSDZ+/w4MHdy+JToo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1499
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIEZyaSwgRGVjIDEzLCAyMDE5LCBHZWVydCBVeXR0ZXJob2V2ZW4gd3Jv
dGU6DQo+IE9uIFRodSwgRGVjIDEyLCAyMDE5IGF0IDk6MTkgUE0gQ2hyaXMgQnJhbmR0IDxDaHJp
cy5CcmFuZHRAcmVuZXNhcy5jb20+DQo+IHdyb3RlOg0KPiA+IE9uIFRodSwgRGVjIDEyLCAyMDE5
LCBTZXJnZWkgU2h0eWx5b3Ygd3JvdGU6DQo+ID4gPiAgICBBcyB5b3UgY2FuIHNlZSwgdGhlIGRl
bGV0ZWQgZmlsZSBpcyBiYWNrIGFmdGVyIHVubW91bnQvcmUtbW91bnQuLi4NCj4gPg0KPiA+IERp
ZCB5b3UgZG8gYSAnc3luYycgYmVmb3JlIHlvdSB1bm1vdW50ZWQ/DQo+IA0KPiBEb2VzIGl0IGZh
aWwgd2l0aG91dD8gSWYgeWVzLCB0aGF0IG11c3QgYmUgYSBqZmZzMiBidWcuDQoNCkl0IGRvZXMg
bm90IGZhaWwgZm9yIG1lIHdpdGggb3Igd2l0aG91dCB0aGUgc3luYy4NCg0KJCBscyAtbCAvbW50
IDsgcm0gL21udC90ZXN0LnR4dCA7IHVtb3VudCAvbW50DQp0b3RhbCA2ODgNCi1yd3NyLXhyLXgg
ICAgMSByb290ICAgICByb290ICAgICAgICA3MDM0NDggT2N0IDMxIDA5OjA4IGJ1c3lib3gNCi1y
dy1yLS1yLS0gICAgMSByb290ICAgICByb290ICAgICAgICAgICAgNTggT2N0IDMxIDA5OjAwIHRl
c3QudHh0DQokIG1vdW50DQokDQokIG1vdW50IC9kZXYvbXRkYmxvY2szIC10IGpmZnMyIC9tbnQN
CiQgbHMgLWwgL21udA0KdG90YWwgNjg3DQotcndzci14ci14ICAgIDEgcm9vdCAgICAgcm9vdCAg
ICAgICAgNzAzNDQ4IE9jdCAzMSAwOTowOCBidXN5Ym94DQoNCg0KSSBhbHNvIHRyaWVkIHRoaXMu
Li4uYW5kIGl0IHdvcmtzIGZpbmQgYXMgd2VsbC4NCg0KJCBjcCAvYmluL2J1c3lib3ggL21udC9i
dXN5Ym94XzIgOyB1bW91bnQgL21udA0KDQpJIGp1c3QgSSB3YXMgcmVtZW1iZXJpbmcgdGhhdCB5
b3UgbmVlZCB0byBjYWxsIHN5bmMgYmVmb3JlIHlvdSBjYWxsIHJlYm9vdA0Kb3Igc2h1dGRvd24g
YmVjYXVzZSB0aG9zZSBkbyBub3Qgc3luYyBmaXJzdC4gVGhhdCdzIHdoYXQgSSByZW1lbWJlciBh
bnl3YXkuDQoNCkkgZ3Vlc3MgU2VyZ2VpIGlzIHVzaW5nIGFuIFItQ2FyIGJvYXJkIChJJ20gdXNp
bmcgUlovQTJNKS4NCg0KQ2hyaXMNCg0K
