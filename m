Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE5341191CD
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2019 21:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLJUXK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Dec 2019 15:23:10 -0500
Received: from mail-eopbgr1410121.outbound.protection.outlook.com ([40.107.141.121]:6126
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726071AbfLJUXK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Dec 2019 15:23:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkpRJefb7RqJjCJjr7D5slHiod3rLU1JGevgbK/3z0HeQ/sL+4Penn3B8BMToNZ1CRiPm+IrZ+GeNIWdcSuKZJo1Oa1VwOI9DfWF56aW575NniyBAaTqBEkHcBvzedF+IpVjzHI6nSNqZsDa68rQCKxGH5vrKQUXgJ4DRIfnBd/zHrYZNrFOhe+Mw8hS9fTyJjsUwapJGN68JNOEMuttNkZsA/98uI+QZ9AJW/2NpMtfG87WE1PwTaCCZxkM9Rgxh1yRhK7tjzpDC5osU23Anx1/utsf/kkBdBpDhe8nODXnDO+cYHOKMu9wCDFiQEzlTwyOBCnDGU3MYVlTQYC/XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7Doyo0wIKXe8OsB6ha5jZsxDePONE6U+brJEd4r3iQ=;
 b=gKkyaTfy1mwyswbLDD2bWSPdJ+XaZb9nDP9DdYi7AveLNREzpZTD6uEvv6AfEwragFQxv8BB2Vk8M4daJ6akH1OyNtxA2CZAjO3wIjB2zv4LYBssBwXo3zcDHXC4nAghqGPF+A+H1M+ifTb20KQBVD+fGDSpxTgSik7bK3i5eeGwg65AKGV2H7IJ8e16Q6UQONe7k03dcOQq+O8Sym7KuDuZGybaWkDAoY7xQ1oFSJEv83j7f0GIAX5kjMEFlfsrnO3yiGS/UzRTZW0HkjSIrTTgX7KlcSRl506/oJQCqFaeeylOC/E3+FgxcMw6br68ER7WpwJ3DWXjFYPlAHrSFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7Doyo0wIKXe8OsB6ha5jZsxDePONE6U+brJEd4r3iQ=;
 b=SRpwNQ++dkfce1weGHU4xO1LbPNqvJDJj8ft/0eWr0x68humAEp+LR22Mmoc4sGmlijz05NBnCNfyt3m6UsACoxZeXBbaH07UDypsLBYf9RH3k+/3d7vV0j+JX4Wa8ujkV3JpmBtuYAdKFQFyVvfdEgfPkZtiPf/1ZjaYE4T01w=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1833.jpnprd01.prod.outlook.com (52.133.163.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Tue, 10 Dec 2019 20:23:06 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 20:23:06 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
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
        Mason Yang <masonccyang@mxic.com.tw>
Subject: RE: [PATCH v2 2/6] dt-bindings: spi: Document Renesas SPIBSC bindings
Thread-Topic: [PATCH v2 2/6] dt-bindings: spi: Document Renesas SPIBSC
 bindings
Thread-Index: AQHVrDsTjXSeF7WhuEKgUGoi0guPiaex3BKAgAH2T4CAAAFh0A==
Date:   Tue, 10 Dec 2019 20:23:06 +0000
Message-ID: <TY1PR01MB15628EA9B46BD12B9D2AAD6F8A5B0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <20191206134202.18784-3-chris.brandt@renesas.com>
 <CAMuHMdXW6_tCcx_DE66qBSTK8XmWyWm82ZD6h-N5YX_+xcvBtw@mail.gmail.com>
 <0cbd8556-cf17-7d6b-5c12-e8d663a39cfa@cogentembedded.com>
In-Reply-To: <0cbd8556-cf17-7d6b-5c12-e8d663a39cfa@cogentembedded.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZGUwNjI3ZDYtMWI4YS0xMWVhLWFhNTUtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XGRlMDYyN2Q4LTFiOGEtMTFlYS1hYTU1LTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iMTIwOSIgdD0iMTMyMjA0ODI5ODQyODkzMDg3IiBoPSI3andkaEMvMUYxQUtXVnF4TGoxYWNJWXVqUE09IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [24.206.39.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 710b691b-79fb-4c58-1d35-08d77daec46e
x-ms-traffictypediagnostic: TY1PR01MB1833:
x-microsoft-antispam-prvs: <TY1PR01MB18333E1F7ACB1604CC3B9E8C8A5B0@TY1PR01MB1833.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(81156014)(33656002)(54906003)(81166006)(186003)(55016002)(26005)(316002)(8676002)(6506007)(7416002)(2906002)(110136005)(76116006)(66946007)(9686003)(66446008)(52536014)(5660300002)(66556008)(66476007)(8936002)(4326008)(7696005)(71200400001)(478600001)(86362001)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1833;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: stXlkYcSbY8piAXiDMMAZzibBofka9cunnqxGqDb6F2FHPlacaex8VZn1XJWUwBXtyBGRANCJj4ljsOw+oQD6wEUS6Q2kjjh8/RWjexCAppC1mGsPZ5zWxXAZxMbrOm29fSpRR1vtmCCZaL39mhDLAi72TItxKiuFpjdQ44gB6jLiQQ66evi2mEFZ8RcJIQHfKLtOnZTcZdw15N7fj0WkWCktplQtC/0iRokpH1xglu+eUjJXRGru0n65kS8p7oDftmnv0jXqUKehXdOc0CoTYXifQvpy9g8V/UoITA5v5+EszewQVuPItF0KzQ1bzJ4aqjzsPfXFnN339UKhIlRnW9pWzwOL8XWgDmgO0pIZL4MvggI0ng/TWlD5SckXmK9JZDR8o0ENyBy3rcE05mo/LXjvv7LPW7eg6kB+zd97ofmJYJlJmmnzHpiCdA4C5ST
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 710b691b-79fb-4c58-1d35-08d77daec46e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 20:23:06.8387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kNv0EVnU5oheIeaFm+VYOzhZPgH9W8E76/iI7L2i3a+SZBV5I/srG+4fjLyoAbOwYuwToHyjaDQJXgi0FQE/7yZ6i7ihEf+wzL1jBhtmsco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1833
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gVHVlLCBEZWMgMTAsIDIwMTksIFNlcmdlaSBTaHR5bHlvdiB3cm90ZToNCj4gPj4gKyAgICBp
dGVtczoNCj4gPj4gKyAgICAgIC0gZGVzY3JpcHRpb246IFJlZ2lzdGVycw0KPiA+PiArICAgICAg
LSBkZXNjcmlwdGlvbjogTWVtb3J5IE1hcHBlZCBBZGRyZXNzIFNwYWNlDQo+ID4NCj4gPiBUaGUg
c2Vjb25kIG9uZSBpcyBub3QgbmVlZGVkLCBpZiB5b3Ugd291bGQgYWRkICJyYW5nZXMiIGZvciB0
aGUNCj4gPiBtZW1vcnktbWFwcGVkIG1vZGUuDQo+IA0KPiAgICBJJ20gbm90IHN1cmUgd2UgY2Fu
IGRvIHRoYXQuIFRoZSBmbGFzaCBidXMgaXMgYWNjZXNzZWQgdmlhIGEgd2luZG93IHdpdGgNCj4g
dGhlIGhpZ2ggYml0cyBpbiB0aGUgRFJFQVIgcmVnLCBldmVuIGluIHRoZSBkaXJlY3QgcmVhZCBt
b2RlLi4uDQoNClRoZSBwdXJwb3NlIG9mIHRoaXMgZHJpdmVyIHdhcyB0byBhbGxvdyBSL1cgYWNj
ZXNzIHVzaW5nIHRoZSBleGlzdGluZyANCk1URC9TUEkgbGF5ZXIuDQpXaGVuIHRoZSBIVyBpcyBv
cGVyYXRpbmcgaW4gdGhpcyBtb2RlLCB0aGUgZHJpdmVyIGJhc2ljYWxseSBqdXN0IG5lZWRzIA0K
dG8gcmVhZCB0aGUgdmFsZSBvZiAicmFuZ2VzIiBpbiB0aGUgRFQgdG8ga25vdyB0aGUgYmFzZSBh
ZGRyZXNzLCBhbmQgDQp0aGF0J3MgYWxsIGl0IHVzZXMgaXQgZm9yLg0KDQpJZiB0aGUgSFcgaXMg
Z29pbmcgdG8gYmUgdXNlZCBpbiAnZGlyZWN0IHJlYWQgbW9kZScsIHRoZW4gdGhlIE1URC9TUEkg
DQpsYXllciB3aWxsIG5vdCBiZSB1c2VkLiBJbnN0ZWFkIHRoZSBNVEQvUk9NIGRyaXZlciB3aWxs
IGJlIHVzZWQuDQpDb25maWd1cmluZyB0aGUgSFcgZm9yIHRoaXMgbW9kZSBpcyBvdXQgb2Ygc2Nv
cGUgYXQgdGhlIG1vbWVudCBhbmQgDQpzaG91bGQgYmUgZG9uZSBpbiB0aGUgYm9vdCBsb2FkZXIg
KGp1c3QgbGlrZSBERFIgb3IgU0RSQU0gaXMgY29uZmlndXJlZCBieSANCnRoZSBib290IGxvYWRl
cikuDQpUaGUgTVREL1JPTSBkcml2ZXIgd2lsbCBhbHNvIGhhbmRsZSBhbGwgdGhlIGlvcmVtYXBw
aW5nIGJhc2VkIG9uIHRoZSANCnZhbHVlcyBpbiB0aGUgcGFydGl0aW9uIHZhbHVlcyB1bmRlciB0
aGUgZmxhc2ggbm9kZS4NCg0KQ2hyaXMNCg0K
