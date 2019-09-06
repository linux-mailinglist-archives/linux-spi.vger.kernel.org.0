Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84DE6AB73F
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2019 13:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390284AbfIFLh6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Sep 2019 07:37:58 -0400
Received: from mail-eopbgr1400123.outbound.protection.outlook.com ([40.107.140.123]:8464
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389929AbfIFLh6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 6 Sep 2019 07:37:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhYZglsJ40MXvxXA1KwSi8NWtz9cMxgO355oQ16E+xe4lf//aQYpAP75z6mcTtJj0Ljl29Z7WBhZF+1V2RP8xwkwNiDoxlKdWFHpH/726XUi/dq9Fu6XSH7LtwgPYi/kIIlq67AHyTXH5cMaHt5eJyOdzSCKktAvPEVjH61WQuSJr5KowHxxv84IuhrjKHZzl7wXaosFXdOG2mYfIc5NAbF8SH4iSGF3QQSRstiLrbnLWZbvF4SVrV2tBoIbBweYldxlGjL6lTI5/96Ow3RIMdFPcsmZRE2p0DgxR4DAklHVxpZoI2sn9GY+K8w3IC7Be0+oWcSZDwrhtoG/qJgd2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRaHOJgQZMlEH4KYhTGA0QAd7TEiPq3vvEmR2yzvQM8=;
 b=LygyeesZeCFgDUd1j84/sb6wFZNabGX0mcNlgk3yaM+vwP6mK0rxAuG3W4CQlxe+tT0fxdfMDFPP+ShPvEweqakWRNH8kbIl5xKehiPlJW++bxIQSgQPp5qYkc/K/kNc3yPUTD2H+BSu5HSiqJqAwRr0rTbhMQ2CaCC2Er2hHNnm6RjmKljwMjiTlMHLM2uYzMUm4vRIhIafbNp8guDTnV2ijl2Y3YUyMfLzoYaCw8ecXtNV5gvC7ahqAWkYn5YMTItFX3S+rF6zFlQSXdDCoEEEz3uT2hiJGF1DIKFKcP0TI94z3kkx8n2MAkQKJER54E5RbuwDHBw2EdYTgOcqeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRaHOJgQZMlEH4KYhTGA0QAd7TEiPq3vvEmR2yzvQM8=;
 b=lgrqG1Z6B+/lYQBiOdnJ9AqYsCZ1Mi5800+1ZHjogLOAT5PEMf03XESBPup1YTH8ibPB1w9HGrW39iLVHOUxSsi877QYfbWxo9ibr1VcO5qRKRrACJhreENvkmrzM3jyfaaCGXU92L7hZbboIMdz3S0xbFRhPwji0CbGFvpgmk0=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1753.jpnprd01.prod.outlook.com (52.133.160.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Fri, 6 Sep 2019 11:37:53 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::24ad:bfbf:53bc:f509]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::24ad:bfbf:53bc:f509%7]) with mapi id 15.20.2241.018; Fri, 6 Sep 2019
 11:37:53 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [RFC] Is runtime_pm in the RSPI driver broken?
Thread-Topic: [RFC] Is runtime_pm in the RSPI driver broken?
Thread-Index: AdVkC8Du3CsXm98ySyCQaW7xvH0UUgAmpn+AAAAcguA=
Date:   Fri, 6 Sep 2019 11:37:53 +0000
Message-ID: <TY1PR01MB15627ABF1BC36487F91A6DDD8ABA0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <TY1PR01MB1562DB9AB5D516662204C1CF8ABB0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <CAMuHMdWTHxYbx76fe2VEfBanZw-QmTsVQRRz2RGROm89FdMCJA@mail.gmail.com>
In-Reply-To: <CAMuHMdWTHxYbx76fe2VEfBanZw-QmTsVQRRz2RGROm89FdMCJA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYzEwNzg1M2ItZDA5YS0xMWU5LThkYTktNWNjNWQ0NjFlNzI0XGFtZS10ZXN0XGMxMDc4NTNjLWQwOWEtMTFlOS04ZGE5LTVjYzVkNDYxZTcyNGJvZHkudHh0IiBzej0iNzU2IiB0PSIxMzIxMjI0MzQ3MDY0NDk2MjEiIGg9InFkR09iOVV6OWhSSVRXZDRUc25kK2J0RzQvcz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa7aa74b-1439-4752-f6c0-08d732bea7c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TY1PR01MB1753;
x-ms-traffictypediagnostic: TY1PR01MB1753:
x-microsoft-antispam-prvs: <TY1PR01MB17536527921AC693B65C28E98ABA0@TY1PR01MB1753.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(446003)(55016002)(9686003)(256004)(26005)(11346002)(6436002)(53936002)(66556008)(6246003)(2906002)(3846002)(7696005)(74316002)(66946007)(64756008)(66446008)(76116006)(6116002)(71200400001)(71190400001)(316002)(305945005)(7736002)(54906003)(66476007)(102836004)(478600001)(6506007)(229853002)(81156014)(8676002)(66066001)(52536014)(33656002)(86362001)(4744005)(99286004)(486006)(186003)(4326008)(5660300002)(8936002)(476003)(14454004)(76176011)(6916009)(81166006)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1753;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OnBeTvNFQFmB2QWl10UUQiqAibMxQpSOBTBxToecXYS9szD6qmRbKIdGsLjtWZvLzc9K7V4Nu6i4PhD/kR2tEPGjP/ibHclYf6PauihNoiuJPD7ztISVSuw+jSgbG25qeJWPVCytl4h1Rkkz0Uo33O8VkzuFsFEUoW8dl17NbtkTupt+LHsMRJ5DV4dVqEcrzlEcIutoQu0T2Rbi0hWi0wg/DKeuPxzRWRzhzW1A0Ov9qfvqgxeyAhPtBQ5NmisnaTp5lnALcbgDh+GQG0CormRsiKKEtkj1m9F+w5oa6QB00vCSsn12eHigMbk2YLTQFMXtocBc+PN5pT1edrtCGhRQ/NcJeqdXfEHA7oAzOxCVtULURgcAeOakDErbvDXIqwWYpG0UJygAxjJ36qpzbfFJSUnwazorX/sC4nGmnEc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7aa74b-1439-4752-f6c0-08d732bea7c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 11:37:53.4695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qWvGLNWH0+gulhSrOnamazaAFVRq5Fr9Q3o7yWQYyCDCvDXVIEif+Gipvx8BftIFgztszjkyKdoddkLXZ+lNCQ+I1cop4kaQZ+HYm7WaZbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1753
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIEZyaSwgU2VwIDA2LCAyMDE5LCBHZWVydCBVeXR0ZXJob2V2ZW4gd3Jv
dGU6DQo+ID4gU28sIGFtIEkgbWlzc2luZyBzb21ldGhpbmc/IEl0IHNlZW1zIHRoYXQgdGhlIGRy
aXZlciBpcyBub3QgZ29pbmcgdG8NCj4gPiB3b3JrIGNvcnJlY3RseSB1bmxlc3MgcG1fcnVudGlt
ZV9nZXRfc3luYygpIGdldHMgY2FsbGVkLg0KPiANCj4gUVNQSSBvbiBLb2Vsc2NoLCB3aGljaCB1
c2VzIHRoZSBzYW1lIGRyaXZlciwgaXMgc3RpbGwgd29ya2luZyBmb3IgbWUsDQo+IHdpdGggZGVi
dWcgcGF0Y2hlcyB0byB0dXJuIG9mZiBhbGwgdW5uZWVkZWQgY2xvY2tzIGR1cmluZyBlYXJseSBi
b290Lg0KDQpUaGFuayB5b3UgZm9yIGNoZWNraW5nLg0KDQpBZnRlciBlbmFibGluZyB0aGUgZGVi
dWcgbWVzc2FnZXMgb24gbXkgYm9hcmQsIEkgY2FuIHNlZSB0aGF0IG15IGNsb2NrIA0KaXMgYmVp
bmcgZW5hYmxlZCBiZWZvcmUgdHJhbnNtaXNzaW9uLg0KSG93ZXZlciwgaXQgc2VlbSBsaWtlIGl0
IGlzIG5vdCB3b3JraW5nIGNvcnJlY3RseSBmb3IgUlovQTJNLg0KDQpTbywgSSB3aWxsIGNoYW5n
ZSBteSBmb2N1cyBmcm9tIHRoZSBSU1BJIGRyaXZlciB0byB0aGUgUlovQTJNIGNsb2NrDQpkcml2
ZXIuDQoNClRoYW5rIHlvdSBmb3IgdGhlIHN1Z2dlc3Rpb24hDQoNCkNocmlzDQoNCg==
