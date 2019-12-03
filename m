Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5009711049E
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 19:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfLCS6A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Dec 2019 13:58:00 -0500
Received: from mail-eopbgr1410110.outbound.protection.outlook.com ([40.107.141.110]:1721
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbfLCS6A (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 3 Dec 2019 13:58:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeePHOqUAkvoxZnyvE8EnD0B1dXhpfzmKNI4Tkb2hsVdUFhGUVKv2M4oTMe551O3uaLxrf1jWMwLIZRD+Yy1+wOI5RWN8mXajIAxwAGIFLG9h99WtI7YS8+Dhb+P1Zy0ePQiluHGB4OmlrS8siaCn+5IzvrtAp8cbwdk5i9oVNyw5raTg+ozIrQYIQVexEUQA//Pe3I4552Bz9zbrWGHhOwe5TXKGd7DbJbXQcczOPdgDwIAq6eszeV+7vyZUlqBSc8T1ApigM4IFfcXd00Fi15MnsxxprvRV33IhU6lMNb0SV8ZM1hukHdUziA3RoKUfoijnqfPCjYEnc51C+D4WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/8ohLtdXwBOcW4VhCO1PdTBgvxqX22qEYXqGE0CDkA=;
 b=Tg4kE6dhCnwBIL8+S/Ko7A+y83SLYgWMMhwD2p0GjGNLKIra813AnwE/uLO/8Ug+QTBcl5cjVYewhovhuzws0k98K3KmhtOOgBq21NkeiqhsDsqchS5ZIIDmlwczgir6X0S3V4epicp8lAFnEGNZHJYAs4yuK5vWz2uoYhtC9dkvwKJYdB02ofoxzRtBRk8DBWt1cZBqsEAHx2AaEXs/yJBo20dbnyJ4JVmQtxmRIkLUIwSE+1EKSJhqeu4yreR02Ak3l0XKYXcc38tPoBlskTFccAoowEi5SAplesx6PfH/h1wCio3ggPdDRyd45TKgelUCW8p4e2e/ekgKBF3RdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/8ohLtdXwBOcW4VhCO1PdTBgvxqX22qEYXqGE0CDkA=;
 b=d56+TlXkCF2U7eN8u4dTxc8zUA7NBzz05kGuQIXt0I/gHrQy7fG+SHUfcL143nRyZyUIVzSihJu/COyCkewSoO/siOYYzLdCgV7NMVAbsx0ShU9wkIJwXtiUWp0MPyCTVy6KXl2ReEIs3HCbGepT9aOXJJgAOHDRqcLGE4OUAM4=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1868.jpnprd01.prod.outlook.com (52.133.164.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Tue, 3 Dec 2019 18:57:56 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2516.003; Tue, 3 Dec 2019
 18:57:56 +0000
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
Subject: RE: [PATCH 2/6] ARM: dts: r7s72100: Add SPIBSC clocks
Thread-Topic: [PATCH 2/6] ARM: dts: r7s72100: Add SPIBSC clocks
Thread-Index: AQHVqYw5ixK18pdXUUiJIFkvJ+Qioqeov9OAgAAB0RA=
Date:   Tue, 3 Dec 2019 18:57:56 +0000
Message-ID: <TY1PR01MB1562F44E4FB80788922CE9BE8A420@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-3-chris.brandt@renesas.com>
 <CAMuHMdXUVdG_PMQEpz=QWLCaabfK8Mc41zFiymXJ4Rx_C2gzdg@mail.gmail.com>
In-Reply-To: <CAMuHMdXUVdG_PMQEpz=QWLCaabfK8Mc41zFiymXJ4Rx_C2gzdg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctY2ZhMmUyOWItMTVmZS0xMWVhLWFhNTEtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XGNmYTJlMjljLTE1ZmUtMTFlYS1hYTUxLTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iMTA3MyIgdD0iMTMyMTk4NzMwNzQ4Mjc0NzY2IiBoPSI4aDloZ2RNbVVPUW05SGtZSjc5anlsREZnWkU9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1c9ae9c3-5287-443f-05c6-08d77822b577
x-ms-traffictypediagnostic: TY1PR01MB1868:
x-microsoft-antispam-prvs: <TY1PR01MB186850AE2AAEC316B512AC878A420@TY1PR01MB1868.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(189003)(199004)(66556008)(66476007)(9686003)(66946007)(64756008)(66446008)(256004)(4326008)(8676002)(6506007)(102836004)(76116006)(26005)(186003)(81156014)(81166006)(54906003)(86362001)(8936002)(6436002)(5660300002)(71200400001)(76176011)(71190400001)(55016002)(6916009)(52536014)(6246003)(99286004)(11346002)(478600001)(4744005)(7736002)(305945005)(14454004)(229853002)(25786009)(446003)(7696005)(316002)(7416002)(2906002)(33656002)(3846002)(6116002)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1868;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +NHffKZ+2A+bpQ2dMk0rFqj09ermuxpFZqxNxNfiDbzWsf/iQVzStJbVI1Qx/nysoCL4vekeW4pUf2TvVlUbYdgEcBqDyFBDmLDM+q+shEHhHirNUkCwSkwPjD/NyzoCH49GsaJec3zVs/U45NhytXspMrjkWbQGPLcBpbIQuXnIRxNX4vWFMZoBW3T3g2sGdeL9O8o04vLicO8F7Ko/r3PVJ36Tdc0FxNV5plP59l70T+HfsNUZpYybp4f+icuVk5SHqZk2XND7807/sAhbfTWc8S/757t0O2FV6r5sZ5p4+51ZVc+j07fTQuG372KoMOkFIGzmcLYljj7W7I51sF9HO3JhLGMJXLIN34UsZQ3mVJR/pPEZebz44YOVPZsgfj28350NF6Ln0ratIJFIG7BZv37v9o6/dRrAdIInwhQgtBZeHKtNfjUShcQref40
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9ae9c3-5287-443f-05c6-08d77822b577
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 18:57:56.3742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hcf07MMSee72A4i2fcv45ySsw+/DeBVIrlJjO+8cgR215ZjZt0ULfvqxTDh9KDu6y8W+KYCTcT+Czu+xme+HmykAQdpSWabXTCmQDQJKpDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1868
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIFR1ZSwgRGVjIDMsIDIwMTksIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90
ZToNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgzZmVmYTAwMCAweDEwMD4s
IDwweDE4MDAwMDAwDQo+ID4gKyAweDQwMDAwMDA+Ow0KPiANCj4gVGhlIHNlY29uZCByZWdpb24g
Y29uZmxpY3RzIHdpdGggdGhlIFhJUCBmbGFzaEAxODAwMDAwMCBpbg0KPiBhcmNoL2FybS9ib290
L2R0cy9yN3M3MjEwMC1nci1wZWFjaC5kdHMuDQo+IFllcywgSSBrbm93IGl0IGlzIHRoZSBzYW1l
IGRldmljZSA7LSkNCg0KSXMgdGhhdCBqdXN0IGFuIEZZST8/IE9yIGRvIHlvdSBoYXZlIHNvbWUg
c3VnZ2VzdGlvbj8/DQoNCg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrLWNyaXRp
Y2FsID0gPDQ+OyAvKiBzcGlic2MwICovDQo+IA0KPiBJZmYgd2UgZ28gdGhpcyBjbG9jay1jcml0
aWNhbCByb3V0ZSwgSSB0aGluayB0aGlzIHNob3VsZCBiZSBzcGVjaWZpZWQgaW4gdGhlDQo+IGJv
YXJkLXNwZWNpZmljIC5kdHMgaW5zdGVhZCBvZiBpbiB0aGUgU29DLXNwZWNpZmljIC5kdHNpLg0K
DQpPSywgdGhhdCdzIGZpbmUuIEl0IG1ha2VzIG1vcmUgc2Vuc2UgdG8gYmUgaW4gdGhlIC5kdHMg
YmVjYXVzZSBpdCdzIGEgYm9hcmQNCmRlc2lnbiBkZWNpc2lvbi4gSSB3aWxsIHJlbW92ZSBpdCBm
cm9tIHRoZSBwYXRjaC4NCg0KVGhlIG9uZSAndHJpY2t5JyB0aGluZyBpcyB0aGF0IHRoZSA8ND4g
aXMgdGhlIGluZGV4IGludG8gdGhlIG51bWJlciBvZiBjbG9ja3MuDQoNClNvIGluIHRoZSBSZW5l
c2FzIEJTUCB3aGVyZSBpdCBpbmNsdWRlcyB0aGUgVkRDNSBMQ0QgY29udHJvbGxlcnMsDQoNCmNs
b2NrLW91dHB1dC1uYW1lcyA9ICJpMmMwIiwgImkyYzEiLCAiaTJjMiIsICJpMmMzIiwgInZkYzUw
IiwgInZkYzUxIiwgInNwaWJzYzAiLCAic3BpYnNjMSI7DQoNCnRoZSA8ND4gbmVlZHMgdG8gYmVj
b21lIGEgPDY+Lg0KDQpDaHJpcw0K
