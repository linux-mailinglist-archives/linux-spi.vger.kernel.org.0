Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D05E158209
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2020 19:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgBJSGl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 Feb 2020 13:06:41 -0500
Received: from mail-eopbgr1400111.outbound.protection.outlook.com ([40.107.140.111]:64870
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726816AbgBJSGl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 10 Feb 2020 13:06:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUhyqpiWGc1TXMbjbUS6zU2mazLBW2f7ME4F+oGyfdO0lQH3O6az/VsHHxbR5Wav+Xe6mAjfh22blfp6h7BmTaDr5sdXMdoD2dqSNoFURxB5xYxrrwWdkYatl7qOGwp3TOkDftHGIMQKYHiIq3LKdarX+8azRJiQqQjdn+C99A1RV1WeG1zp1WWSn48MmlSJB4R1N/233TIBbMu7Knw58oBpbTJUYHfp9jVXIvtl3PAvsmKlKzFIiCDsXebXhGDYMOQ62q90uyfDLR13yBZEUMJbDfzVuV8pFxxBzQai3srOxuN49/QaCEIYg0bfh1FPBq2jHF6IZMg4Hc7yFbzpqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gB3IjAHtqIczuOBREvQvbQezH9w9RbRjoFESk8jKqm0=;
 b=Zxr1mEy0NexYFjCo8Yks1SKja+AjQcIIEeeULl4hCYKfIupVKhmCLzc32u2wwDmSIKEQ7ujwLiq00QE+mpDFgkCKmOZPlfNz1dbP7qLwPUY/lxadwxxEWij/UAuzjpVWPiBB8yQIb7ukMdqDiiAYZAsyCuEZS8qm5JzZAxHKUTDGmKsiWN6EkmiDe3xTuYNt+24e5pccITSj5ogDi2fWgiK6Pb3qU/5+WmwqYtzIRt+Ddz1dC9aiDidOSuG1ZCFFq3oSa2ymFHmpdvDLB5+z8/jwrBXEzkmJCVR/5bwXh1BUWlf+0pVZKxW/dzJQqEGCk7xZAMGUE8IyGh78TTwGvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gB3IjAHtqIczuOBREvQvbQezH9w9RbRjoFESk8jKqm0=;
 b=BWF4Z3sUl+B+KQYcRe45yXh48PEw71oh3RY4bd4L8emXJqVrSTG65sq3A8B7YcKIZHu/iJ/vIv9hoWGoQxwhH3gHafPLtbfBgsxKX+9W9TWLzhiAu7WhphNlgVigZaJaPGXL35MF9pZCKvLz5LmNUkabPln93L0wyHx64VWRfCM=
Received: from TYXPR01MB1568.jpnprd01.prod.outlook.com (52.133.166.145) by
 TYXPR01MB1712.jpnprd01.prod.outlook.com (52.133.168.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Mon, 10 Feb 2020 18:06:37 +0000
Received: from TYXPR01MB1568.jpnprd01.prod.outlook.com
 ([fe80::e9ac:8933:9767:9c69]) by TYXPR01MB1568.jpnprd01.prod.outlook.com
 ([fe80::e9ac:8933:9767:9c69%2]) with mapi id 15.20.2707.030; Mon, 10 Feb 2020
 18:06:37 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
CC:     Mason Yang <masonccyang@mxic.com.tw>
Subject: RE: [PATCH v2] spi: add Renesas RPC-IF driver
Thread-Topic: [PATCH v2] spi: add Renesas RPC-IF driver
Thread-Index: AQHVy+TviPn/l/o2I0KvRtYPATdXYagU2jRQ
Date:   Mon, 10 Feb 2020 18:06:37 +0000
Message-ID: <TYXPR01MB1568E8BCB6B80A77C91D98998A190@TYXPR01MB1568.jpnprd01.prod.outlook.com>
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
 <6515c5ec-8432-0b20-426d-0428bbdf3712@cogentembedded.com>
In-Reply-To: <6515c5ec-8432-0b20-426d-0428bbdf3712@cogentembedded.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMTI4ODdjNjktNGMzMC0xMWVhLWFhNWItOTRlNmY3Njc5M2FlXGFtZS10ZXN0XDEyODg3YzZhLTRjMzAtMTFlYS1hYTViLTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iMTc5NSIgdD0iMTMyMjU4MzE1OTUyOTY4MjE1IiBoPSJtVmJMTTRkMHE2Z1FWakhvRU1WZVlMUWdDRGM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9c3f9cf8-5d9e-403f-6dd1-08d7ae53f8d7
x-ms-traffictypediagnostic: TYXPR01MB1712:
x-microsoft-antispam-prvs: <TYXPR01MB17121F774F03C5DF8114EC078A190@TYXPR01MB1712.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 03094A4065
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(189003)(199004)(7696005)(478600001)(86362001)(71200400001)(4326008)(8936002)(6506007)(76116006)(9686003)(110136005)(66446008)(66556008)(55016002)(52536014)(66946007)(316002)(66476007)(64756008)(8676002)(26005)(186003)(2906002)(5660300002)(33656002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:TYXPR01MB1712;H:TYXPR01MB1568.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x/irt1LTmvMp9NujoGLEIDCBb/4plB6ibyBWr/1L0nTm+zCMIXst0Ms72IZFsJoyc00ig/IUmJZmTeFm2JXkXiXY8gW5y+bPOTTDZs08gMlHt1L9Cnc2MlHmh7SLeOtQuR4gAR5Mq26cVFOom2vv5hK9k5+650DkiCHo9fV6RQueFSOeC0/Oi2M6xhdkPjUAlOTJiaF/U+GCwr2vH5nPGGVAqO8znb1iNCUXqX6TyWNGPJC9Vq3VjjepcvL9Dzbb3XT3gv5cc/IxOFenP6DTIYIWhyYLgXEbU2eqW7rmKZnUicfywfziOB/X3KbzLrHABlGKcYl3qLPWkyaFlIUTi+GjGnhDwGmvsm60SLg7aAAl0D3eprb1Ukc1PB13rYy9cdL9s8GnTpo6CCrtpHh7px08fio3tovp7s1nfMC5sQRrwQvDUEMa8L7PDVndFTeO
x-ms-exchange-antispam-messagedata: LtBwlFtZ69NOidzD5x//RSu3SPP3qdraOw+w1dqdfyIZsqynIXOgWkJOp9e1QL72c+rSvAc/gKTDlwlVyygYRX2F/OROBI7RTjxKQ/+Lxv5s7q9ZBp1u8EpfEpmabOIgH+eVJHe3bOnZ3SSPqGdleA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3f9cf8-5d9e-403f-6dd1-08d7ae53f8d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2020 18:06:37.3512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zp5cyHm6eweKpceL46/TTuz0UUq8qa2rjqnMb9tUaerPGKLhG4U5Uqrjra66Rjq+nu/f6jtFIUMA6CuIMdiuKHiVD0yF0Uj1aJrZzmmZc+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1712
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgU2VyZ2VpLA0KDQpBcyBJIG1lbnRpb25lZCwgd2hlbiB0ZXN0aW5nIG9uIFJaL0ExLCBzb21l
IGNvbW1hbmRzIGFyZSBub3QgdHJhbnNtaXR0ZWQuDQoNCkJhc2ljYWxseSBhbmQgU1BJIGNvbW1h
bmQgdGhhdCBkaWQgbm90IGhhdmUgJ2RhdGEnIHBheWxvYWQ6DQoJMHgwNjogV3JpdGUgRW5hYmxl
DQoJMHhEQzogRXJhc2UgMjU2IGtCICg0LWJ5dGUgYWRkcmVzcykNCgkweDA0OiBXcml0ZSBEaXNh
YmxlDQoNClRoZSByZWFzb24gc2VlbXMgdG8gYmUgdGhlcmUgaXMgbm8gY2FzZSB0byBzZXQgcnBj
LT5kaXIgd2hlbiB0aGVyZSBpcyBubyBkYXRhLg0KU28sIGl0IGp1c3QgZ2V0cyBsZWZ0IGF0IHdo
YXRldmVyIHRoZSBsYXN0IHRyYW5zZmVyIHdhcy4NCg0KSSBhZGRlZCB0aGlzIGZpeCBhbmQgbm93
IGl0IHNlZW1zIHRvIHdvcmsgZmluZS4NCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3NwaS1y
cGMtaWYuYyBiL2RyaXZlcnMvc3BpL3NwaS1ycGMtaWYuYw0KaW5kZXggMGZmMWE1MzhiYmQ1Li4y
MTY1YTA3NjE4NDQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NwaS9zcGktcnBjLWlmLmMNCisrKyBi
L2RyaXZlcnMvc3BpL3NwaS1ycGMtaWYuYw0KQEAgLTUzLDYgKzU0LDkgQEAgc3RhdGljIHZvaWQg
cnBjaWZfc3BpX21lbV9wcmVwYXJlKHN0cnVjdCBzcGlfZGV2aWNlICpzcGlfZGV2LA0KICAgICAg
ICAgICAgICAgIGRlZmF1bHQ6DQogICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCiAgICAg
ICAgICAgICAgICB9DQorICAgICAgIH0gZWxzZSB7DQorICAgICAgICAgICAgICAgcnBjX29wLmRh
dGEuZGlyID0gUlBDSUZfTk9fREFUQTsNCisgICAgICAgICAgICAgICBycGMtPmRpciA9IFJQQ0lG
X05PX0RBVEE7DQogICAgICAgIH0NCiANCiAgICAgICAgcnBjaWZfcHJlcGFyZShycGMsICZycGNf
b3AsIG9mZnMsIGxlbik7DQoNCg0KVGhpcyBzZWVtcyBsaWtlIGEgYnVnIHRoYXQgd291bGQgZWZm
ZWN0IGFkZCBkZXZpY2VzLCBub3QganVzdCB0aGUgUlovQTEuDQoNCg0KDQpTaWRlIG5vdGUsIGVy
YXNlIHNlZW1zIE9LLi4uYnV0IHdyaXRpbmcgZGF0YSBzZWVtcyB0byBnZXQgbWVzc2VkIHVwLg0K
QXMgeW91IGNhbiBzZWUgYmVsb3csIGl0J3MgYWRkaW5nIDIgYnl0ZXMgb2YgMDAgaW50byB0aGUg
d3JpdGUgc3RyZWFtLg0KDQokIGZsYXNoX2VyYXNlYWxsIC9kZXYvbXRkMw0KRXJhc2luZyAyNTYg
S2lieXRlIEAgMTAwMDAwMCAtIDEwMCUgY29tcGxldGUuDQokIGhleGR1bXAgLUMgLW4xMDAgL2Rl
di9tdGQzDQowMDAwMDAwMCAgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgIGZmIGZmIGZmIGZmIGZm
IGZmIGZmIGZmICB8Li4uLi4uLi4uLi4uLi4uLnwNCioNCjAwMDAwMDYwDQokIGhleGR1bXAgLUMg
LW4xMDAgL2Rldi9tdGQzDQowMDAwMDAwMCAgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgIGZmIGZm
IGZmIGZmIGZmIGZmIGZmIGZmICB8Li4uLi4uLi4uLi4uLi4uLnwNCioNCjAwMDAwMDYwDQokIGVj
aG8gImhlbGxvIiA+IC9kZXYvbXRkMw0KJCBoZXhkdW1wIC1DIC1uMTAwIC9kZXYvbXRkMw0KMDAw
MDAwMDAgIDY4IDY1IDZjIDZjIDAwIDAwIDZmIDBhICBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiAg
fGhlbGwuLm8uLi4uLi4uLi58DQowMDAwMDAxMCAgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgIGZm
IGZmIGZmIGZmIGZmIGZmIGZmIGZmICB8Li4uLi4uLi4uLi4uLi4uLnwNCioNCjAwMDAwMDYwDQoN
Cg0KQ2hyaXMNCg==
