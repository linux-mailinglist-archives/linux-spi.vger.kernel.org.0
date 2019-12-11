Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC8211AD8E
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2019 15:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbfLKOdq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Dec 2019 09:33:46 -0500
Received: from mail-eopbgr1410122.outbound.protection.outlook.com ([40.107.141.122]:20800
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727851AbfLKOdq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 11 Dec 2019 09:33:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qa9NpdJIlj8+QYR2fatOLUc22xZGqRpMcm2NDYYLokm6lVHzqWATpxTc6VVrKZFjJr7VFyCs0nlxQ9G7eT92OyRNM4V9j1g8SJxvS73mmSJ/M+yt4f/nTPXSvLn6m3OrcyxKri2YSoZrRb3+pCIfZ4zaND0R3YlHT2evToZTpu8etITV7Zhp/XvNorTI6j7I0+KPfAqk/CQ0Kd9aS8m3h+4xhowvrHfS0aYQTl8WfODJdRadoCRiZaKYcgm2XjsGno746Dc9nPRdeQUpeKB1muXKi9cjqul3xeh0sZQAiadrZvWSe/KWg/CIfWpFfPxAH3vn9bXcf35uNs6LCbGf9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCiYaYs17SNgi9hD2TFHPr2+81OR4b4KmX0T3q7puTE=;
 b=nCnEgR6UR/nMdSRd+NRuIIAIUrttf4H93+nn2zPn1wONuPGb5QDtIxaNrzoqLVUoLawiRkKpkaFPW5n6YO4qJeHsMXDq45RwWdCa2Haz+8MhvSH2Tm3ExKNUw3n/7MRe/EoXylJAVg/RZbv9nuhZrFVwC5jTuD+03hCXnhkjKIYlw5Pdy6ZH1Hq8uT6+v4qTlGcYDSotcBq2a+KA6kqh7PQvz5GmDD586YOPs3zneHyifQTwvVWfa8ZWDRStLnU1OC0R54JXGDje4IaKiGuRILySD8aWxkrf8eOOCAK0urJapFOmlno5IYLe3uPnTsUZz2vNTfH9F0brPi2lVFJLrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCiYaYs17SNgi9hD2TFHPr2+81OR4b4KmX0T3q7puTE=;
 b=oWc0VN2HM1a6Pm1yIQUOPL5TkWs1S5BNqzU/mftNJurWRr0WlyUqi8E3dMT1g1T7hD2Gsmq4k0ekmACrtXzOgg73czNUBh28Sy409E57pyBzD3t15/751MUky9HrMkkkRRBVlDz+rXYgozerP9LAFGcftqHjv2UqWJUq2U/4Dik=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1884.jpnprd01.prod.outlook.com (52.133.161.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 14:33:42 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 14:33:42 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Yang <masonccyang@mxic.com.tw>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [PATCH RFC 0/2] Add Renesas RPC-IF support
Thread-Topic: [PATCH RFC 0/2] Add Renesas RPC-IF support
Thread-Index: AQHVr5DrfsSVaoYrt0+i4lwRcJSZ16e0+/sQ
Date:   Wed, 11 Dec 2019 14:33:42 +0000
Message-ID: <TY1PR01MB156234F5B44BB43D3DCA98128A5A0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <cb7022c9-0059-4eb2-7910-aab42124fa1c@cogentembedded.com>
In-Reply-To: <cb7022c9-0059-4eb2-7910-aab42124fa1c@cogentembedded.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMzQ2MDhhZmYtMWMyMy0xMWVhLWFhNTUtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XDM0NjA4YjAwLTFjMjMtMTFlYS1hYTU1LTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iMTM1NSIgdD0iMTMyMjA1NDg0MTg4OTk0NTEwIiBoPSJuNTR4Mllldk14THdVcExGUCtLZnRySFRobDQ9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 67213fec-bd30-45af-2592-08d77e471f06
x-ms-traffictypediagnostic: TY1PR01MB1884:
x-microsoft-antispam-prvs: <TY1PR01MB188422D11ADAE26586F689478A5A0@TY1PR01MB1884.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(199004)(189003)(81156014)(9686003)(81166006)(7696005)(478600001)(8676002)(55016002)(33656002)(8936002)(316002)(76116006)(54906003)(66556008)(110136005)(86362001)(4326008)(66476007)(26005)(2906002)(66446008)(64756008)(5660300002)(66946007)(6506007)(52536014)(71200400001)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1884;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TGRdUNEUBneN4t9tTanNzHwRL9RDQjcF4ueNU4p7RVypxyqxvSU3HtNYNnDEv1vdG6B/zisvk9edceXde8F/mU21xMT7CXuxz0kcgFs7hSwZ9U8PGL8l0tD3/yn3nGnWMdIVAAd4NQAPNAdvjdLKPqRIPtFBxkdIK2QkANh3aagz3yQkzgOWdUYbZphgQAmo1QN11tqD9VB2qX7EVR1HKHzHW/EHs8lbe+cCV7RvYvyidubzNMMsU8+U1FQtU3zGXJQARU+NRPLr4gu/VEBpGFbYZp6YsDcJVJB+Bdxeq5SCnVpAovGjTh1gkagRX1Tr9K7PFKQOTXZR+jYcw641nPdorgGXx+ha+PFrwUgNP56okQ73290SF9ICNHcacQkrfFWFk/Sbkzsb/fIoPM9mYyNZJVEfW01aTgXfKeADOamASWiqqOSjOrIaOiGV+Ga+
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67213fec-bd30-45af-2592-08d77e471f06
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 14:33:42.2050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2dErImcX36TYAkpKCq8toTcX5On7u6G9K/UjhhkyDu7s6SdXWZt0551Tl3I0nfk8K39wX9983mKyAWgZ9H5954CdhttkbEoxMb9jpnfFGGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1884
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGVsbG8gU2VyZ2VpLA0KDQpPbiBUdWUsIERlYyAxMCwgMjAxOSwgU2VyZ2VpIFNodHlseW92IHdy
b3RlOg0KPiBIZXJlJ3MgYSBzZXQgb2YgMiBwYXRjaGVzIGFnYWluc3QgTGludXMnIHJlcG8uIFJl
bmVzYXMgUmVkdWNlZCBQaW4gQ291bnQNCj4gSW50ZXJmYWNlIChSUEMtSUYpIGFsbG93cyBhIFNQ
SSBmbGFzaCBvciBIeXBlckZsYXNoIGNvbm5lY3RlZCB0byB0aGUgU29DIHRvDQo+IGJlIGFjY2Vz
c2VkIHZpYSB0aGUgZXh0ZXJuYWwgYWRkcmVzcyBzcGFjZSByZWFkIG1vZGUgb3IgdGhlIG1hbnVh
bCBtb2RlLg0KDQpMb29raW5nIGF0IHRoaXMgZHJpdmVyLCBhbGwgaXQgaXMgYXJlIEFQSXMuIE1l
YW5pbmcgYW5vdGhlciBkcml2ZXIgaXMgDQpuZWVkZWQgdG8gc2l0IGluIGJldHdlZW4gdGhlIE1U
RCBsYXllciBhbmQgdGhpcyBIVyBkcml2ZXIgbGF5ZXIuDQoNCkluIHRoZSBkcml2ZXIgdGhhdCBJ
IGRpZCwgaWYgdGhlICJSUEMiIEhXIGlzIGdvaW5nIHRvIGJlIHVzZWQgdG8gY29udHJvbA0KYSBT
UEkgRmxhc2ggZGV2aWNlLCBpdCByZWdpc3RlcmVkIGEgc3BpIGNvbnRyb2xsZXIgYW5kIHRoZW4g
dGhlIE1URCANCmxheWVyIGNvdWxkIGFjY2VzcyB0aGUgZGV2aWNlIGp1c3QgbGlrZSBhbnkgb3Ro
ZXIgU1BJIGNvbnRyb2xsZXIgZHJpdmVyLiBObw0KYWRkaXRpb25hbCBkcml2ZXJzIGFyZSBuZWVk
ZWQuDQoNCkxvb2tpbmcgYXQgdGhlIGh5cGVyYnVzIGRyaXZlciB0aGF0IGlzIGluIGRyaXZlcnMv
bXRkL2h5cGVyYnVzLywgaXQgDQpzZWVtcyB0aGF0IGlmIHRoZSAiUlBDIiBIVyBpcyBnb2luZyB0
byBiZSB1c2VkIHRvIGNvbnRyb2wgSHlwZXJGbGFzaCwgdGhlbiANCmFsbCB5b3Ugd291bGQgbmVl
ZCB0byBkbyBpcyByZWdpc3RlciBhIGh5cGVyYnVzIGNvbnRyb2xsZXIgdXNpbmcgDQpoeXBlcmJ1
c19yZWdpc3Rlcl9kZXZpY2UoKS4gVGhlbiB0aGUgTVREIGxheWVyIGNvdWxkIHJlYWQvd3JpdGUg
dGhlIGZsYXNoIHVzaW5nIA0Kbm9ybWFsIE1URCBDRkkgaW50ZXJmYWNlLg0KDQpXaHkgZG8geW91
IHRoaW5rIHlvdSBuZWVkIGFub3RoZXIgbGF5ZXIgaW4gYmV0d2VlbiB0aGUgSFcgZHJpdmVyIGFu
ZCB0aGUNCk1URCBsYXllcj8NCklzIHlvdXIgZ29hbCB0byBtYWtlIGEgbXVsdGktbGF5ZXJlZCBz
eXN0ZW0gd2hlcmUgdGhlIEhXIGp1bXBzIGJhY2sgYW5kIGZvcnRoDQppbiBiZXR3ZWVuIG9wZXJh
dGluZyBtb2RlcyBhdCBydW50aW1lPyBJJ20gbm90IHN1cmUgb2YgdGhlIHVzZSBjYXNlIGZvciBh
bGwgb2YNCnRoaXMuDQoNCkNocmlzDQoNCg==
