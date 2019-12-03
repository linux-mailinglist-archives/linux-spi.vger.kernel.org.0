Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 517F0110472
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 19:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfLCSqU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Dec 2019 13:46:20 -0500
Received: from mail-eopbgr1400121.outbound.protection.outlook.com ([40.107.140.121]:44987
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726075AbfLCSqT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 3 Dec 2019 13:46:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mse5QMXWVm2TMEhXdxe1+SdN+vYHelC8b4C+QHwViBswmcAMPAJPyHbGLO6bJV/ZJNXOomf/rhwVI4zeXjudOe8kQ8NixPgY8wYjnwasuSxRn8pB3e9hFjw3Zbefx05ts0rN7CzEjCViB5McfgOVh8JVRIB7TDbJljUbgMBY9aGpJXOOFSocob5mwt1sUzswOwQiVJo8iGUsRPPJE5zpKsmRoPKYzdz4S+3UkNzXjhLyP0tUmzKSeEfZ4QbCdSrh4ItIlxnbQRGrc1z/Ws31aPUoo7u/NODNW1EIxc0rhhBtbMdhvDgshwsdAXPCj6EUERKZNWAD3Ehmg7YjC7LlPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dASyta/PFeM5WW4bHags2IiyDUlMiVe11RI53dTuz8I=;
 b=V8tm1WNWyv96BUVzGXr8z2zbKf/EbwBu0ylsgm63TamlUi8ugO9+96s26tPzgqG2UPRWcn2OzPUoqJi4vJmI9mbBVKodGgNXuySDBaTm2mbzxsqWXuAgwwckRUCClnS045YWgvKNbQ/D4/hf+9qzXpfm01ynSgdJeqCRZ3vuMyNG3MuVYGEGQWgewk1JJ+4w2j7rbc6TVYkA3Ak6b69Gic+Wkg+WwfxNpJh/jtWIHl3PbXzY0My6MHSI95EwDwm4rT0NEYH2o+i+Y3Jzti0g/MBaPix9V6jPnROwuXuTzpb5bc00jjF6/9ZQ2e0uanHS7hLAEJTNVHKX9UoaS9ensA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dASyta/PFeM5WW4bHags2IiyDUlMiVe11RI53dTuz8I=;
 b=l+juHeKu0bQPFjMX/riDKNms/WB0mnlZiQYtSQb5dZ3kLuis9cIB/U0FrPCIP2Wk45cs5wDgUg5zOmZYF1PatFleDkIV8pDWZj/t9bBEkiwiBi7Hv2iK6Tj7AOxFj0AsOMKxSpocLPN4f+jcrCTPLIbMQi5SR2Tczt7Ox32KZlg=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1642.jpnprd01.prod.outlook.com (52.133.164.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Tue, 3 Dec 2019 18:46:16 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2516.003; Tue, 3 Dec 2019
 18:46:16 +0000
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
Subject: RE: [PATCH 1/6] clk: renesas: mstp: Add critical clock from device
 tree support
Thread-Topic: [PATCH 1/6] clk: renesas: mstp: Add critical clock from device
 tree support
Thread-Index: AQHVqYwx69dMUxxqBUmN5xQmR8NWIKeovPqAgAABG4A=
Date:   Tue, 3 Dec 2019 18:46:16 +0000
Message-ID: <TY1PR01MB156288E89F0F845CDC3831FB8A420@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-2-chris.brandt@renesas.com>
 <CAMuHMdU6NrAk-oeH_tR8Re7bz6HXednfaP=CGsyBt+M4_n95ow@mail.gmail.com>
In-Reply-To: <CAMuHMdU6NrAk-oeH_tR8Re7bz6HXednfaP=CGsyBt+M4_n95ow@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMmU0NWU2ODMtMTVmZC0xMWVhLWFhNTEtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XDJlNDVlNjg0LTE1ZmQtMTFlYS1hYTUxLTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iNzI2IiB0PSIxMzIxOTg3MjM3NDYwOTIxNDkiIGg9ImJ5YzZGVm1KYWxsbzIySTlHMzlxVy9HQ3ZUYz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: afd85132-37d0-48b1-5d72-08d77821144b
x-ms-traffictypediagnostic: TY1PR01MB1642:
x-microsoft-antispam-prvs: <TY1PR01MB1642427C859B84052654F0BA8A420@TY1PR01MB1642.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(189003)(199004)(25786009)(7736002)(2906002)(186003)(54906003)(4326008)(256004)(71190400001)(66946007)(102836004)(14444005)(8676002)(55016002)(76116006)(9686003)(81156014)(229853002)(6436002)(33656002)(86362001)(6246003)(7416002)(14454004)(3846002)(6116002)(478600001)(66476007)(6916009)(316002)(5660300002)(66446008)(76176011)(7696005)(52536014)(4744005)(71200400001)(11346002)(446003)(66556008)(6506007)(64756008)(26005)(81166006)(74316002)(305945005)(99286004)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1642;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fRLYAd9aXkSolrFRcJeuwenScj3c3OYDDY6ZiwzY/IZo8P1Z0vF683R0LBQtrsWjaJSmuQF9jv5xaM6g7iK+TWJynztLc7rS3l4FIeIU1fcEjEFlnsms8UiP/QfQ1Ux9arIQPQPkk+uInVNSylrnKzm/m0wIxgsD5hfBYn+2YFk+F9YM20HZHwD4UzHoUy2EQIo6opdFTvagjhUuKY5Lkn37cUAiTwoHy/P4PhZCe3Fk3icFWRecf4HMso6KZms1OhFxujZdIxH0oT0+7AN7+hbDsFKCLPhwNrlFPMNtafOwVggaWtyapOseflo8i0O4r7aqu4A7GElN38QXUfKjdEYu4Qdlw05juAfDaA6neLhArBR4JlkmVzfyGieXuSEVO3WOQCO5irYpUG8QzSGVj26nYZtC8nD1W/2PRTKHox7zRZAhNM1X4krVO6NelJ3P
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd85132-37d0-48b1-5d72-08d77821144b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 18:46:16.4602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e7e/lkw3JskZGnJ2cTJWKnoiCax1kPVn47ScdTPuLeGereUrk9yMLS/vL8Nlc5P1K97JoGqVhcwF5OLrYD8+hpl6p8xJ3Nn+fq0zRLfbCIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1642
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXZpZXchDQoNCk9uIFR1ZSwgRGVjIDMs
IDIwMTksIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90ZToNCj4gPiArICAgICAgIHVuc2lnbmVkIGxv
bmcgZmxhZ3M7DQo+IA0KPiA9IDAgaGVyZS4uLg0KPiA+DQo+ID4gKyAgICAgICAgICAgICAgIGZs
YWdzID0gMDsNCj4gDQo+IC4uLiBpbnN0ZWFkIG9mIGhlcmU/DQoNClRoYXQgd2FzIG15IGZpcnN0
IHRob3VnaHQgdG9vLi4uYW5kIGl0IHdhcyB3cm9uZy4NCg0KSWYgb2ZfY2xrX2RldGVjdF9jcml0
aWNhbCBkb2VzIE5PVCBkZXRlY3QgYSBjcml0aWNhbCBjbG9jaywgaXQgZG9lcyBub3QgDQp0b3Vj
aCBmbGFncyBhdCBhbGwuDQpBbmQgc2luY2UgaXQgaXMgYSBsb29wLCB3aGF0IHlvdSBnZXQgaXMg
YWZ0ZXIgdGhlIGZpcnN0IGNsb2NrIGlzIG1hcmtlZCANCmFzIENSSVRJQ0FMLCBhbGwgdGhlIHJl
bWFpbmluZyBjbG9ja3MgYWxzbyBnZXQgbWFya2VkIENSSVRJQ0FMLiBJbiB0aGlzIA0KY2FzZSwg
Ym90aCBzcGlic2MwIGFuZCBzcGlic2MxIGdldCBtYXJrZWQgY3JpdGljYWwuIFRoYXQncyB3aHkg
SSBoYXZlIHRvDQpyZXNldCBpdCBmb3IgZWFjaCBsb29wLg0KDQpDaHJpcw0KDQo=
