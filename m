Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE1711EC00
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2019 21:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfLMUnJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Dec 2019 15:43:09 -0500
Received: from mail-eopbgr1400119.outbound.protection.outlook.com ([40.107.140.119]:34016
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726382AbfLMUnJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 13 Dec 2019 15:43:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bd8iJrbICVVrlNIcflP671Ou+t2w4fEYabHjfO8xKFeCSyXEuxwaeBreqkYIf06/F0fj7iCT1W5TUA9qBakX6JH8nIOWP7j0CPBpUK/Fej+wqtZNvG6DgbO/I3lBvuil1NIY3PbXqf26TxokgW5BF4cUHuKjth+uvXdSzLwI+5fFvH4N1HKVHighXl+giGhA3hpp5gE50xNzdie9jQSKPvcAITLCPBTysIGrfURO5ZTAKPiDiWxRYijPA62zWPwIoShy5Z8ZLma0Ac8cRKxC3m1E6j2U38uOqwaIi29na6XLySr1YGtlLsO8t+ftFrMPyMNIU0/hL38EOh67ZmnM8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhJPmvzvRyTiOsK5TplbGSS7MXbi0JjowYOw1Kqd2sY=;
 b=E0l5PzYEnAGvab2ifRIdGtG0XncMC0eDy00YS9LkJc6M6Leneb5xOAUhEDcwcctb1m31Ksicpj9QgS4OrdlzQNPeZ0JjHObvE/EiqctXK6aENCC0f8+cYG7hQVvr4o6bRodI/uff6k2M8rOtlq5nBXVGjAVORmgxkVrA6gK7kgYtIK36JgaI8TQNHsbtSR12OniqWJ4zfVfTX7hXdoWvE1RVRyWuh8RB5DOmc9FEEVxcQQ3i3GbaDAfVwCdICyNDd2CUPSHYJgMWYqVAsFNWe7Pme7zOVIzp0jhhhe0LEAcBDkStyppGU7BXwWbEzZ3F8ucsYpxVzvZ7W1oJ11fTbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhJPmvzvRyTiOsK5TplbGSS7MXbi0JjowYOw1Kqd2sY=;
 b=MFKfwISedmS8K0M/8J8bh5H2xZNOoBrxvVT8XTtO/bFWtgzt32VPpTG3T0rzqtWgaNv77MOsJSMn9s3ASVprLTZl2IVp9RgvG8zE8i4GGd01fnKM9mwYcLTvD5Qu+24aNINGOh4OAirpOWRIOlwsOWUkqfrgRqo8Ni5r7430Ob4=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1658.jpnprd01.prod.outlook.com (52.133.162.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Fri, 13 Dec 2019 20:43:05 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2538.017; Fri, 13 Dec 2019
 20:43:05 +0000
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
Subject: RE: [PATCH v2 1/6] spi: Add SPIBSC driver
Thread-Topic: [PATCH v2 1/6] spi: Add SPIBSC driver
Thread-Index: AQHVrDsMpgzelIsB7UCp/Sk4dX5yJ6e27ngAgAAFoLCAAXvGAIAAEhqAgAAPbOA=
Date:   Fri, 13 Dec 2019 20:43:05 +0000
Message-ID: <TY1PR01MB1562F30F0B58465A6988F29C8A540@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <20191206134202.18784-2-chris.brandt@renesas.com>
 <37c13497-d20f-583f-72d7-1e3c8a241990@cogentembedded.com>
 <TYXPR01MB1568ED4D40CEC399E64F6A2B8A550@TYXPR01MB1568.jpnprd01.prod.outlook.com>
 <7386b38f-2f52-39cb-3887-e97b024ec563@cogentembedded.com>
 <2e3211c6-59e8-3057-66a2-29b89a353b8a@cogentembedded.com>
In-Reply-To: <2e3211c6-59e8-3057-66a2-29b89a353b8a@cogentembedded.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMjc5NjQ3OTctMWRlOS0xMWVhLWFhNTUtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XDI3OTY0Nzk4LTFkZTktMTFlYS1hYTU1LTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iNzgzIiB0PSIxMzIyMDc0MzM4MjgyNDM2MzciIGg9IjRjbFVOUFNjUksxTjJOZ2JzZmllbGlCaStBUT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4d8752f9-4a03-4174-c400-08d7800d0e24
x-ms-traffictypediagnostic: TY1PR01MB1658:
x-microsoft-antispam-prvs: <TY1PR01MB16587E13F2C66FF06B9C8B028A540@TY1PR01MB1658.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(376002)(346002)(39850400004)(396003)(189003)(199004)(5660300002)(110136005)(4326008)(9686003)(6506007)(186003)(4744005)(2906002)(55016002)(316002)(66476007)(66946007)(8936002)(33656002)(64756008)(81166006)(52536014)(66556008)(76116006)(66446008)(81156014)(8676002)(7696005)(26005)(478600001)(54906003)(7416002)(71200400001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1658;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mdtEqNVarSJHI9tdhCiAIMPPw08eOyMifUA8xOAotNV4rqgDKtBDIS65ZOAol+LlRv1AY4N6DUwd6Aa1Que1wpNblTcA62qqIc8xxYx/CCPm7J/TvS8zssn9JhCa318q1vsS3TEuC/Oz8k1DRBoknfNKO0eQ2wuXBb/LKB7Htgubiu59T/H2dxjZMhJh9RV2n8v9PgJ0dFbUO+0pkmcItPS3PQAQwCs8T7nW4VP3IKdvaOamNFiN47jmY+AbfMExEkXU++O5LyqTTo3Zh05D5+AD7BHICz5mNB68VrjFvZ+yWnMsyxjgI8zxxacxj+a2IRGm0RJfu+qjrjJ/abThJc8qqRw0mCrBf1wGwl2d6eATVB4NPbcErraqinarCsFp4eY5pVBKJhJ8Iu1TzguDzlh86N2VIgWR+96EOHcW9zDV5YAhwCd71H5W0tOrDw6I
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8752f9-4a03-4174-c400-08d7800d0e24
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 20:43:05.4596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 32sF5k+Gp1H1LzhHN4VRoOic2ztijQ1xoguQxY1RaHMNhZNa8OiC8V7pv36geNIxcrjqNwIxDj1rACX4/AmF9AtgiW//ng6pIX/+LMHAKvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1658
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gRnJpLCBEZWMgMTMsIDIwMTksIFNlcmdlaSBTaHR5bHlvdiB3cm90ZToNCj4gICAgVGhlIHBh
dGNoIGlzbid0IGFwcGxpY2FibGUgYXMgd2VsbCwgYW5kIHRoZSBiZWhhdmlvdXIgaXMgdGhlIHNh
bWUgYXMgaW4NCj4gNS4yLi1yYzYgYmFzZWQNCj4ga2VybmVsIC0tZGVsZXRlZCBmaWxlIGlzIGJh
Y2sgYWZ0ZXIgcmVtb3VudGluZywgc3luYyBvciBub3QuLi4NCg0KRG8gdGhlIGJhc2ljIFIvVyBv
cGVyYXRpb25zIHdvcmtzPw0KDQpIZXJlIGlzIHRoZSBmaXJzdCB0ZXN0IEkgZG8gb24gbXkgcGxh
dGZvcm1zLiBBZnRlciBJIHBhc3NlZCB0aGlzLCBldmVyeXRoaW5nDQplbHNlIHNlZW1zIHRvIHdv
cmtlZCBwcmV0dHkgZ29vZCAod3JpdGluZyBsYXJnZSBmaWxlcykuDQoNCiQgZmxhc2hfZXJhc2Vh
bGwgLWogL2Rldi9tdGQ0DQokIG1vdW50IC10IGpmZnMyIC9kZXYvbXRkYmxvY2s0IC9tbnQNCiQg
ZWNobyAiaGVsbG8iID4gL21udC9oZWxsby50eHQNCiQgc3luYw0KDQoNCklmIHRoZSBGbGFzaCB3
YXMgcmVjb2duaXplZCBhdCBib290LCB0aGVuIHdlIGtub3cgdGhhdCB0aGUgSUQgY29tbWFuZCAo
MHg5RikNCmF0IGxlYXN0IHdvcmtlZC4gTWVhbmluZyByZWFkIGNvbW1hbmRzIHdlcmUgYXQgbGVh
c3Qgd29ya2luZyAod2hpY2ggaXMgdGhlDQpkaWZmaWN1bHQgb25lIGZvciB0aGlzIEhXLi4ud3Jp
dGluZyBpcyBlYXNpZXIpDQoNCkNocmlzDQoNCg==
