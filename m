Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8C2A127EC7
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2019 15:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfLTOuw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Dec 2019 09:50:52 -0500
Received: from mail-eopbgr1410122.outbound.protection.outlook.com ([40.107.141.122]:50752
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727452AbfLTOuv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 20 Dec 2019 09:50:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjAN9A4rgGbt/+t/HqZB4tF98cpNPlyT6YZAiN9Dfq/3iUtj0NNjKrlSbgTOznDR0SWFCBgM78S0eHKFmo1z0UPChuswDUSZF0JgqtLGnV0DxopNR+nVI7cJhSzsF8ej5PvbJZYxSq7FBxuyCxVoQKFPNE0g8py5JiIxlHWrYUXfRBQLQ/3RadnV1lVBhiiuUhlOuI3Hqf1/SN+SAoCSsx3Qk+P9YVW7EnCbhhRpwMjly9JRb48hG04liCPSgrIThjk4Htlj8m69k3v3L3FDGDplJ3eoVV8rqPg7Un0n1BbynsTVXUFPeeGpStXra0oLzOFCrDD0EOMlNmFYzG7Sjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fnMi/P8prNXkLYk9kOca0ZyvW+PhNx4L2RgbBBgEhs=;
 b=XG1fj4wp6FsZ4kNethFLUZtcZ7lpn8WM2+qYn+U0eo5/g3NKnLk/fqN83aRdS4ydxvx8ZNJ7T9Sp9rPWp0x5w03ftx8jJvcr4UwQTZVGw9omxbzhgIA8/bXgZe2PVR8OQf5ZfvySj77tsFOPVKW5CbRMyGZ90WmgMkEK/HYIIogij7BfEUOKu0+JDROOHFrIk/HaF+1/ZyEljNURgRGfb9B7hsaCWR86pZjWVNMAYFGSpvY45HSGIMwXMnHkgG2SlYPTeaNTmZNYz3+3PeefD2u74umeCngkTIYprGbHNefCA/Ftz8W87wjn+apmhmDkHphtsoSuJ5xDjOcnF5oEHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fnMi/P8prNXkLYk9kOca0ZyvW+PhNx4L2RgbBBgEhs=;
 b=CV6TGT6tg4QGL7Msk1bIIGKKx6HAbU1PcIebubnDyOf4hdpw0mLcN0OYo+ETKN/+ckUiZzO6dLgZBkjtK5CqlXRVCnO1/Zl8sw8fM4ZWsUWVD7HukDiornGY4YrDk5dVwFxrcl00MnQmxxM4Fzx1XYt4xOH5KLtDa/G2MWQALos=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1738.jpnprd01.prod.outlook.com (52.133.162.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Fri, 20 Dec 2019 14:50:47 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2538.019; Fri, 20 Dec 2019
 14:50:47 +0000
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
Subject: RE: [PATCH v2 3/6] clk: renesas: r7s9210: Add SPIBSC clock
Thread-Topic: [PATCH v2 3/6] clk: renesas: r7s9210: Add SPIBSC clock
Thread-Index: AQHVrDsZnI+SMLkmZkyW5+1FSLVd3qetcNKAgAAShiCAFapogIAAA00w
Date:   Fri, 20 Dec 2019 14:50:47 +0000
Message-ID: <TY1PR01MB1562F475C62C9E1823B47FC88A2D0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <20191206134202.18784-4-chris.brandt@renesas.com>
 <5644c687-7692-53f2-f01e-0e7bf62464ea@cogentembedded.com>
 <TY1PR01MB1562645184402F7C01CE36958A5F0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <CAMuHMdV40AVXf6NW-8AYtp0ZDM_aAe59z7G8XDR5R0tBk6v0YQ@mail.gmail.com>
In-Reply-To: <CAMuHMdV40AVXf6NW-8AYtp0ZDM_aAe59z7G8XDR5R0tBk6v0YQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMTliZDBmNzktMjMzOC0xMWVhLWFhNTgtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XDE5YmQwZjdiLTIzMzgtMTFlYS1hYTU4LTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iMjgzIiB0PSIxMzIyMTMyNzA0NTU3MjI1MjEiIGg9IjAvUXN4bitsak5ZSkM4T2RHanZncnR4aDhyUT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 305c4811-f569-4fba-866b-08d7855bffc4
x-ms-traffictypediagnostic: TY1PR01MB1738:
x-microsoft-antispam-prvs: <TY1PR01MB17384028DA888AA791EA2B128A2D0@TY1PR01MB1738.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(189003)(199004)(86362001)(8676002)(52536014)(55016002)(6916009)(558084003)(71200400001)(316002)(2906002)(81166006)(9686003)(76116006)(5660300002)(66946007)(54906003)(478600001)(66476007)(6506007)(8936002)(186003)(7416002)(64756008)(81156014)(33656002)(66556008)(66446008)(7696005)(26005)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1738;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VRF6xiLBFC/sgiV8D/oxmOCqduphFkUQ8scAbtgBzyrjiXqJXJvqIY7DZNCdl/a7ty9VzHb+2VLK7Ma46cpE4lZG7lUKbah2vctDw/7/onVNi7Ir/5egZy2Wl5RYD0ixNJ3Nen6vq4rzG8jU55dHtfwePyQjFnLt/5lg6VH6z/Pivt2iPxZiA1wU6l1E/vUuNIgUS+i8bPUWNr6237kF3bRmpMMWU757cbc+tVAMrrmi4VVG/GXr+f69cQEPYb2dBG7A8PbbgAA75jx00UGpZPYrpSlLav02KvYqutCIwxZIPTq27ri5IaFEDAiFSGZP0wrbmPfDKbTrd+Y+tvY7pwgqfSb4yO5ZXIwZMUMhCdJcZL4ZFheonEJOAtdVuGjOmc4sfbuPTfMLAX/d6BFE3CNwKtaWA+2R7iu81QX/diJ7vhMFyu088yMv8Q2RVFWj
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305c4811-f569-4fba-866b-08d7855bffc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 14:50:47.3533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T1WHM9/jDwNJyLAzkhs8P3jYdspFF06FhRyR3A/TbsXkTQ38cWnKz5b2YNuyGgS87EFeHo+gzAJYYht++gki4OuPiJxJIrYO7odf0rD4Dmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1738
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIEZyaSwgRGVjIDIwLCAyMDE5LCBHZWVydCBVeXR0ZXJob2V2ZW4gd3Jv
dGU6DQo+IGkuZS4gd2lsbCBxdWV1ZSBpbiBjbGstcmVuZXNhcy1mb3ItdjUuNiwgd2l0aCB0aGUg
ZGVzY3JpcHRpb24gY2hhbmdlZCB0bw0KPiAiQWRkIFNQSUJTQyBjbG9jayBmb3IgUlovQTIuIi4N
Cg0KVGhhbmsgeW91IQ0KDQpDaHJpcw0K
