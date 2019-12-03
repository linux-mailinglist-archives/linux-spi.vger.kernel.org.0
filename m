Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7613311026E
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 17:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfLCQfn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Dec 2019 11:35:43 -0500
Received: from mail-eopbgr1400117.outbound.protection.outlook.com ([40.107.140.117]:11489
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726105AbfLCQfn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 3 Dec 2019 11:35:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJ+jjv5wxr78SOOkKxCOAbRApNa5QmWb2dVI52+RQzVMcW4yBLxroztel0Qz/xwHs7KqXOk6R6Vn/lH4cxo3dUUReuZMNSDsWCS7yftVU7/TG2HcUt2c7yKJmBBYjGjmskKufd7mhbF2sjP694A/0aZ5Lxcvc+6zJKbf/96ppslWNPm8BAn95O+MzP/rso3Mv/5svhdiWZPa3ZKllGm+zA2k1D2SQx6s0uVmS9+N20iy2G1olGOqj53feMnE1Ug9pkQqwAYzTQ/5XWsk/5H9mR11WOIZDbANX2N58JGv1s12kbSthr/oIqjZMFPvnQ2S1n/odR4ZmQPDIesarqTrqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rx1i0f/Bqyc/K8pskulnB02d9PcGtshw0+86LciV2xI=;
 b=KE9Gh2ru0ryYDwBwn2Tu65Ys8pgAIzHBVb9/Mqsidy6UyNR5Wlr3UvZ07Cm1Z2+dspIr9hysYomwG3vDwO91yVgecy+hr9Ncs89J1IHrFeAsIiOzfEzLoX/gFH9kRWTozWZzvmG6IxSPOygjt/pt+XEmXzcdpR8/r27PZubla7pzoaTT2Pjmx0Gysfzq83q15XGy9GWrCWMu0M3sTCPGtlifAoslm8BM0gWCFYR1tb6mdYT0GEif6fzmoOAriK4MX4b9F8ZpZBMB1WDxWkcEqyyCUbsiT0MqjQVdLk7IObp4aaL8qO4omkHQo1FW3gVBCqbuBIYVYPV8UG2f8/XGVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rx1i0f/Bqyc/K8pskulnB02d9PcGtshw0+86LciV2xI=;
 b=ni8lmd5KjCtLOiuXl/+PTDaEdQu0xZFbUAMbhjxFLRoNpCJnEuKzmlChPuIYysR0PMBFkcbDErYsYqhkI1axyt+uVRyvcvj3+LwquegRKbo9Q8JGkBP4ECpflyWcJ21mxWsdl6CtjK3MOi9c68OWLXKJELRyrCsxqgaU+BLVhv0=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1658.jpnprd01.prod.outlook.com (52.133.162.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Tue, 3 Dec 2019 16:35:40 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2516.003; Tue, 3 Dec 2019
 16:35:40 +0000
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
Subject: RE: [PATCH 6/6] dt-bindings: spi: Document Renesas SPIBSC bindings
Thread-Topic: [PATCH 6/6] dt-bindings: spi: Document Renesas SPIBSC bindings
Thread-Index: AQHVqYxRjjQT6EPsk0uhvsHduSJ+e6eoIQoAgAA7ZYCAADdKAIAABRSg
Date:   Tue, 3 Dec 2019 16:35:40 +0000
Message-ID: <TY1PR01MB156225E0916668BA4F05F2948A420@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-7-chris.brandt@renesas.com>
 <17e66541-41fb-26ed-c87b-15c59ab57bef@cogentembedded.com>
 <TY1PR01MB156262E8D33A0624457CAE248A420@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <6c2cb15b-896c-e749-8b33-02da46fbc222@cogentembedded.com>
In-Reply-To: <6c2cb15b-896c-e749-8b33-02da46fbc222@cogentembedded.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZWY5YmMyODktMTVlYS0xMWVhLWFhNTEtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XGVmOWJjMjhhLTE1ZWEtMTFlYS1hYTUxLTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iNjE2IiB0PSIxMzIxOTg2NDUzODUzNDI4MDIiIGg9IlBxSituRHNvKzdrQXdSam04MkQ1QUxvNWNNOD0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ccb9904e-b360-40d3-298b-08d7780ed576
x-ms-traffictypediagnostic: TY1PR01MB1658:
x-microsoft-antispam-prvs: <TY1PR01MB165839652C96C2945C2EF26C8A420@TY1PR01MB1658.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(199004)(189003)(99286004)(66946007)(86362001)(256004)(229853002)(76176011)(478600001)(54906003)(7696005)(186003)(316002)(52536014)(110136005)(6436002)(446003)(66556008)(64756008)(66446008)(76116006)(11346002)(66476007)(25786009)(7416002)(6246003)(4744005)(102836004)(6116002)(8936002)(81166006)(81156014)(26005)(3846002)(2906002)(8676002)(7736002)(305945005)(33656002)(74316002)(9686003)(55016002)(14454004)(5660300002)(6506007)(71190400001)(71200400001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1658;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vut12ucPpQ0beKwrTh0mRAaFewua5KOoN9wQBip+XsxX8csXE2S49eOLtw0BR6Rp3w34K5tffa14JpMqRDaKNOa3v0aEUVDniJ8VuQcwF8dF3U+nm5C+dEaKR09ikNmwg0ExqUAjfb/W21WzDjfzoBVY1RT8HP4ZaCZyGuUlRA27Kl3auNeh9ZfRsxdG2FF+RPIqSnMDTOjiLRyzlrzguO2XqAw2ozxSumhkM+o2bENvlenN5Ku/JdMrZ5wTNcurMwIuxyVSHE/AkTWg+K6+5xAOZwqat72kYtQB9TgYyy8l1THYl5DHdYtzrAwIvtUhyFUlyx/PVyEfbPm+7TwtQHVRoE5CTCHGUhR5kVkZnMflMt4ycwMwfLLeEA4POlsva452CgrIJLX3aPE71KyjxpJHlbdc4+pyYwbgCGf0nj1yj+6CCRXvZHjBCc3mgfig
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb9904e-b360-40d3-298b-08d7780ed576
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 16:35:40.0471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VfnDTXM0ZDarLJYneKu9PSMR+RKIJlVxciYAucGM+WsjTnWdaUd7G0JY9dgypljIufwgyACHSwKKVJNm/Z5IbrrHzbh5Wp5rKF93wjvak+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1658
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gVHVlLCBEZWMgMywgMjAxOSAxLCBTZXJnZWkgU2h0eWx5b3Ygd3JvdGU6DQo+ID4gRG8geW91
IG1lYW4gb3RoZXIgdHlwZXMgb2YgU1BJIGZsYXNoPw0KPiANCj4gICAgTm8sIEkgbWVhbiBmbGFz
aGVzIGNvbm5lY3RlZCB2aWEgZGlmZmVyZW50IGJ1c2VzLCBsaWtlIEh5cGVyQnVzIHdpdGggdGhl
DQo+IGdlbjMgU29DIFJQQy1JRi4NCj4gSWYgU1BJJ3MgdGhlIG9ubHkgYnUgc3VwcG9ydGVkLCB0
aGVyZSdzIG5vIHBvaW50IHNheWluZyAiaWYgU1BJIGlzIHVzZWQiLg0KDQpPSywgSSBzZWUgeW91
ciBwb2ludC4gSSB3aWxsIHJlbW92ZSB0aGUgJ2lmJy4NCg0KVGhlIGhhcmR3YXJlIGluIFJaL0Ey
IGFsc28gc3VwcG9ydHMgSHlwZXJGbGFzaCBhbmQgT2N0YUZsYXNoIChzYW1lIGFzIGdlbjMpLCBi
dXQNClJaL0ExIG9ubHkgc3VwcG9ydHMgU1BJIGZsYXNoLg0KVGhlcmVmb3JlIHRoaXMgZHJpdmVy
IGRvZXMgbm90IHRvdWNoIFBIWUNOVC5QSFlNRU0gYW5kIGFzc3VtZXMgaXQgaXMgYXQgMC4NCg0K
Q2hyaXMNCg==
