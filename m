Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7359C167DA4
	for <lists+linux-spi@lfdr.de>; Fri, 21 Feb 2020 13:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgBUMnZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Feb 2020 07:43:25 -0500
Received: from mail-db8eur05on2112.outbound.protection.outlook.com ([40.107.20.112]:50560
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727137AbgBUMnZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 21 Feb 2020 07:43:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NM5XacJHoFKMGkxxXdFiQzpYOQ8Zlgy6kjs/WGlnuRUQF0rMfF1I9fHIOXR5ORSBgd69tEBtsVUpGanE/jGXYLRSERKV34JSVx9iBooa1AxGH8odch+UJ57mZTVI3q9s2PhV8GhFpC0TXeaKXo1TicGJXQZ8amAti9URq6w70ltaQ2yY6p5uYK+BkxZJsat5OH2L1b2B61HqbKVb7Pvfe0XbQhp2IdA4qJ07KZWAmjRq99PmomZ3E2FuwuJF89jomI2XfZFAJmtKH0R1GO4RdT1EbUCtEAw/d+2lUCRz+c3DEbOvu/dRZKhP7Zf6k36rGPOv2ylZEEC/y2n22P8awg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jjQQnwoXgoOJTOhj5JaAmWSQqs74qwS0z7zf4lcT30=;
 b=ElCu/hcdcTgUq7jmH51A5PQ44L3BoHlsHuv6V9x454unM7lZ3pC9haFaPvaEUsyYkHhZnVYRWhLjJfp4dGHPSM6dRbe8eT0HBXWXCCb5w6ccTpYSh8D+4phJktZE+hY8JsH0j6sIcoXNkaK7Gv5edJDVHo0DQgTwtm6LZrWtmYoaTFJu6/UIOR++d/Kn+X+D2SEnzwN4m9VupIy4wEeTJ8qOwyjXAg73PgS8FaQJYJWWz7xYnN+FFI0fkvk6KttvQ69aesHUIuX5Eyl5+X+mgZIR7MG8tyuq/awXhueb587RmmoRWLjpaOQBW9okFNrWFiP73xxQw8CE0YUlke4E9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jjQQnwoXgoOJTOhj5JaAmWSQqs74qwS0z7zf4lcT30=;
 b=iYDhN99debFP3gUrjtSnVqpVbajxTNLya6Z4jB7e2xPGLHpoKAv03oGRyaYOov3GfV3Y7qzwJ2noLmYptf8Xo5Bnb9cM79uvfHsR8rKzjwV05pPfiwz8wqQx5OfXru6Bh7szOJ0TBzsj8oHPKp6Xjn4Vm2ADZHmZOnd5+awZ3ss=
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB5293.eurprd05.prod.outlook.com (20.178.10.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Fri, 21 Feb 2020 12:43:21 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 12:43:21 +0000
Received: from mail-qv1-f49.google.com (209.85.219.49) by MN2PR01CA0005.prod.exchangelabs.com (2603:10b6:208:10c::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Fri, 21 Feb 2020 12:43:20 +0000
Received: by mail-qv1-f49.google.com with SMTP id dc14so901520qvb.9;        Fri, 21 Feb 2020 04:43:20 -0800 (PST)
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opanyuk <igor.opanyuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: Re: [PATCH 2/2] spi: spidev: fix a max speed setting
Thread-Topic: [PATCH 2/2] spi: spidev: fix a max speed setting
Thread-Index: AQHV5/eyaAawrcInZ0K6xjw9t46TKKgkavCAgAEuCwA=
Date:   Fri, 21 Feb 2020 12:43:20 +0000
Message-ID: <CAGgjyvGQ3edNcBUUpcBmTaaNcYA3yvx19m+6MVyKMWgWPVabKQ@mail.gmail.com>
References: <20200220141143.3902922-1-oleksandr.suvorov@toradex.com>
 <20200220141143.3902922-3-oleksandr.suvorov@toradex.com>
 <20200220184201.GE3926@sirena.org.uk>
In-Reply-To: <20200220184201.GE3926@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR01CA0005.prod.exchangelabs.com (2603:10b6:208:10c::18)
 To VI1PR05MB3279.eurprd05.prod.outlook.com (2603:10a6:802:1c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-gm-message-state: APjAAAVbcpPlAq5qohv0NxwVxLRlq+k7pCULNOVWJ44swAmmBVl1cbK0
        C1ap3NrtzY5OBn6ngfIRrmvCeVFGNAv3QMp3ChQ=
x-google-smtp-source: APXvYqyOxswAGfQkBDx/uNztdcp7pODg4kMi2X/YzILLjBU3w9CQPr/D0dBqvpU+BbwcOFcGENpots/B/MPsTUQ3kR0=
x-received: by 2002:a05:6214:1253:: with SMTP id
 q19mr29816072qvv.75.1582288996029; Fri, 21 Feb 2020 04:43:16 -0800 (PST)
x-gmail-original-message-id: <CAGgjyvGQ3edNcBUUpcBmTaaNcYA3yvx19m+6MVyKMWgWPVabKQ@mail.gmail.com>
x-originating-ip: [209.85.219.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e339085-a0cb-4e75-465a-08d7b6cba186
x-ms-traffictypediagnostic: VI1PR05MB5293:
x-microsoft-antispam-prvs: <VI1PR05MB5293F447B4AE418D42E61EC3F9120@VI1PR05MB5293.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(346002)(376002)(396003)(39850400004)(189003)(199004)(450100002)(8936002)(2906002)(54906003)(55446002)(64756008)(71200400001)(53546011)(478600001)(55236004)(26005)(66556008)(66476007)(66446008)(52116002)(8676002)(42186006)(4326008)(6862004)(81156014)(81166006)(9686003)(44832011)(86362001)(5660300002)(186003)(316002)(66946007)(107886003)(67856001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5293;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vf7hj3i/98yKUMLLL2YTIn3VdNbS/5nODKg115giAuAaAApNowdK1FK2OdU6SK7oxjn8Xp2B3IcMDYbPLP3r4HOoM29YnX5AQH6qohgRuxHZAQo4WNtSZuxkqKU+u2sc5ZY0MsOas0ZIniSw0Eh4fBc4ReqhrguOepNrgsfKmyc0BA5SdufdISAoRrrkaCYmsECoydFtjKzyGPaEV5E+E/tTX0wQNzgoUNxEJQ0NMBPeuHgnbR0dzIYqqUSuCmPvHomSb0EcMVOzVzXGFtz8fAmsxINHiv13hV5BOhNQGn37GnSQou139KnuqAcz4Oq6uLTfDw4wEEwgBnUHp6bjpPiPAsIHPJlZ6VMUL96CBeprK/wGtcQoWcx67yEZ2Pj3g0yvr+jVMNTUtPp3YNizWkTyf04kUasRHDH7M4BNJHKbF0gvKU7RxdkdLa+oEq49+JXooNTE8TpzeKaZD/vV8KTtzAAbad2WY9Ps858MQEnqyI61Xa2YpnL61gVEnpbS
x-ms-exchange-antispam-messagedata: WYaApfq5CILskdoNw0gW4l05CAC+WIyfNw/9EcBO0liyL5yimVugrvtHzxg89oer0iU9klG3sgvzuYPS6ycK5pbrgSn0hdKr61s5fc6Tms1X6vH8rSuvywkp7eR+nxezPWWrvTagq9OujJtslDbIhA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BD65D70FEA0414785663F93A5CC5F7B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e339085-a0cb-4e75-465a-08d7b6cba186
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 12:43:20.3450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ezS1lJksCO4MZNVfEmBBHvmq9PVYeNL1xvJDlYvDxlbZhj9UjFkLQB0bCibL/tLxcdZWuzja5IreNY8D3kosnb4pw/9pfsyXie8GFqmNKPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5293
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgTWFyaywNCg0KT24gVGh1LCBGZWIgMjAsIDIwMjAgYXQgODo0MiBQTSBNYXJrIEJyb3duIDxi
cm9vbmllQGtlcm5lbC5vcmc+IHdyb3RlOg0KPg0KPiBPbiBUaHUsIEZlYiAyMCwgMjAyMCBhdCAw
MjoxMTo1MVBNICswMDAwLCBPbGVrc2FuZHIgU3V2b3JvdiB3cm90ZToNCj4gPiBTUElfSU9DX1dS
X01BWF9TUEVFRF9IWiBjb21tYW5kIGFsd2F5cyBzZXRzIHNwaS0+bWF4X3NwZWVkX2h6DQo+ID4g
dGhlIGluaXRpYWwgdmFsdWUgY29tZSBmcm9tIERULg0KPg0KPiBUaGlzIGlzIGludGVudGlvbmFs
LiAgSXQncyBkb2luZyBhIGNhbGwgdG8gc3BpX3NldHVwKCkgdGhlbiByZXN0b3JpbmcNCj4gdGhl
IG9yaWdpbmFsIHZhbHVlLCB0aGUgZ29hbCBiZWluZyBqdXN0IHRvIHJ1biBzcGlfc2V0dXAoKSB3
aXRoIHRoZSBuZXcNCj4gdmFsdWUgLSBpdCdzIG5vdCByZWFsbHkgYSBnb29kIGlkZWEgdG8gY2hh
bmdlIHRoZSBtYXhpbXVtIHNwZWVkIGluIHRoZQ0KPiBmaXJzdCBwbGFjZS4NCg0KTm93IEkgc2Vl
IGl0Lg0KPg0KPiA+IEl0IGxlYWRzIHRvIHNldCBhIHdyb25nIG1heCBzcGVlZCB3aXRoIElPQ1RM
IGNhbGwuDQo+IEluIHdoYXQgd2F5IGRvZXMgaXQgbGVhZCB0byB0aGUgd3Jvbmcgc3BlZWQgYmVp
bmcgc2V0Pw0KDQpBZnRlciBhbGwsIEkgcmV2aWV3ZWQgdGhlIGNvZGUgYW5kIGZvdW5kIG91dCB0
aGF0IHRoZSBwcm9ibGVtIGlzIG5vdA0KaW4gc3BpZGV2X2lvY3RsLA0KdGhlIHByb2JsZW0gaXMg
aW4gc3BpZGV2X21lc3NhZ2UoKSdzIGRlYnVnIG1lc3NhZ2UgOikNClRoZSByZWFsIGNvZGUgaXMg
b2s6DQoNCmRyaXZlcnMvc3BpL3NwaWRldi5jOiBzcGlkZXZfbWVzc2FnZSgpOg0KLi4uDQogICAg
ICAgICAgICAgICAgIGtfdG1wLT5zcGVlZF9oeiA9IHVfdG1wLT5zcGVlZF9oejsNCiAgICAgICAg
ICAgICAgICAgaWYgKCFrX3RtcC0+c3BlZWRfaHopDQogICAgICAgICAgICAgICAgICAgICAgICBr
X3RtcC0+c3BlZWRfaHogPSBzcGlkZXYtPnNwZWVkX2h6Ow0KLi4uDQoNCmJ1dCB0aGUgZGVidWcg
bWVzc2FnZSB0YWtlcyB3cm9uZyB2YWx1ZToNCmRyaXZlcnMvc3BpL3NwaWRldi5jOiBzcGlkZXZf
bWVzc2FnZSgpOg0KLi4uDQogICAgICAgICAgICAgIGRldl9pbmZvKCZzcGlkZXYtPnNwaS0+ZGV2
LA0KICAgICAgICAgICAgICAgICAgICAgICIgIHhmZXIgbGVuICV1ICVzJXMlcyVkYml0cyAldSB1
c2VjICV1SHoNCihzcGVlZF9oej0lZCBtYXhfc3BlZWRfaHo9JWQpXG4iLA0KICAgICAgICAgICAg
ICAgICAgICAgICAgdV90bXAtPmxlbiwNCiAgICAgICAgICAgICAgICAgICAgICAgIHVfdG1wLT5y
eF9idWYgPyAicnggIiA6ICIiLA0KICAgICAgICAgICAgICAgICAgICAgICAgdV90bXAtPnR4X2J1
ZiA/ICJ0eCAiIDogIiIsDQogICAgICAgICAgICAgICAgICAgICAgICB1X3RtcC0+Y3NfY2hhbmdl
ID8gImNzICIgOiAiIiwNCiAgICAgICAgICAgICAgICAgICAgICAgIHVfdG1wLT5iaXRzX3Blcl93
b3JkID8gOiBzcGlkZXYtPnNwaS0+Yml0c19wZXJfd29yZCwNCiAgICAgICAgICAgICAgICAgICAg
ICAgIHVfdG1wLT5kZWxheV91c2VjcywNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgIHVfdG1w
LT5zcGVlZF9oeiA/IDogc3BpZGV2LT5zcGktPm1heF9zcGVlZF9oeik7DQouLi4NCkl0IGxlYWRz
IHRvIGRlYnVnIG1lc3NhZ2VzIGxpa2U6DQoNClsgMTIyNy41MTI4MDZdIHNwaWRldiBzcGkwLjA6
IHNldHVwIG1vZGUgMCwgMzIgYml0cy93LCAxMDAwMDAwIEh6IG1heCAtLT4gMA0KWyAxMjI3LjU0
MTc0OV0gc3BpZGV2IHNwaTAuMDogICB4ZmVyIGxlbiA0MDk2IHR4IDMyYml0cyAwIHVzZWMgMTAw
MDAwMDBIeg0KLi4NClsgMTIyNy42MTYxNjVdIHNwaWRldiBzcGkwLjA6IHNldHVwIG1vZGUgMCwg
MzIgYml0cy93LCAyMDAwMDAwIEh6IG1heCAtLT4gMA0KWyAxMjI3LjY0NTA5NV0gc3BpZGV2IHNw
aTAuMDogICB4ZmVyIGxlbiA0MDk2IHR4IDMyYml0cyAwIHVzZWMgMTAwMDAwMDBIeg0KLi4uDQpb
IDEyMjcuNzAyNzE0XSBzcGlkZXYgc3BpMC4wOiBzZXR1cCBtb2RlIDAsIDMyIGJpdHMvdywgMjAw
MDAwMDAgSHogbWF4IC0tPiAwDQpbIDEyMjcuNzMxODAxXSBzcGlkZXYgc3BpMC4wOiAgIHhmZXIg
bGVuIDQwOTYgdHggMzJiaXRzIDAgdXNlYyAxMDAwMDAwMEh6DQouLi4NClNvIGlmIG9uZSBwYXNz
ZXMgdGhlIG1lc3NhZ2UgKHVzaW5nIGlvY3RsIGluc3RlYWQgb2Ygd3JpdGUgdG8gZmQpIHdpdGgN
CmVtcHR5IHNwZWVkX2h6LA0KdGhlIGRlYnVnIG1lc3NhZ2UgdGVsbHMgdGhlIHdyb25nIHJlYWwg
c3BlZWQuIEl0IGZvcmNlZCBtZSB0byB0aGluayBpbg0KdGhlIHdyb25nIGRpcmVjdGlvbi4NCg0K
PiA+IEZpeCB0aGUgbG9naWMgb2YgYSBtYXggc3BlZWQgYXNzaWdubWVudC4NCj4NCj4gSWYgdGhl
IGV4cGVjdGF0aW9uIGlzIHRoYXQgdGhlIGRlZmF1bHQgc3BlZWQgc2hvdWxkIGJlIGNoYW5nZWQg
Zm9yIHRoZQ0KPiBkZXZpY2UgdGhpcyBzaG91bGQgYmUgaGFuZGxlZCBhdCB0aGUgc3BpZGV2IGxl
dmVsIHJhdGhlciB0aGFuIGluIHRoZQ0KPiBjb3JlLg0KDQpBZ3JlZS4gSSBmaXhlZCB0aGUgd3Jv
bmcgcGxhY2UgOikNCkknbGwgcmVwbGFjZSB0aGlzIHBhdGNoIHdpdGggYmV0dGVyIG9uZS4NCg0K
VGhhbnghDQoNCi0tIA0KQmVzdCByZWdhcmRzDQpPbGVrc2FuZHIgU3V2b3Jvdg0KDQpUb3JhZGV4
IEFHDQpBbHRzYWdlbnN0cmFzc2UgNSB8IDYwNDggSG9ydy9MdXplcm4gfCBTd2l0emVybGFuZCB8
IFQ6ICs0MSA0MSA1MDANCjQ4MDAgKG1haW4gbGluZSkNCg==
