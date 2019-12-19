Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD6D126F52
	for <lists+linux-spi@lfdr.de>; Thu, 19 Dec 2019 22:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfLSVEU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Dec 2019 16:04:20 -0500
Received: from mail-eopbgr1410101.outbound.protection.outlook.com ([40.107.141.101]:33284
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726880AbfLSVET (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 19 Dec 2019 16:04:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V99mcXo4GQY8uWREo1QPSsY3UO5lsBfW+2462Nx8W+hZAst02dccRnetfvze+TAaXa8nGImKWWztla8+eynSt0KDd7uc9kmDXgcyAbbjGp8a5BeGxEa+vGhfB4YYuLA71lyVK8U86/51BXJDR1+u9V9XBRpTO1cN/+du9vJLKf+UQJXiouI/4BFXzUZ5O06mM6WTlPu3awEdNAKsSb4aW9BobIItChXinU742HsRvsME+yZa6sZn9MDvIfLDSrqZShzZss4t07RWxd9k7bIQv/aZsfORW3+jwJzXAZX9Hn6w/GgIxIS/dJJ0XNK9u+tRnL3fUXS3np4kNqt3DVkWsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHKIes1QBRpa4Z2C5P9EGE4vmvO1oqOWmP4wP0QEPqc=;
 b=GQUcQVzWyRjGbdfKzsFlKFNTwqHbCw29rjMBxtm8MUSoHXpXEVJUWa68W2OatoSmI4Wc0ZjIW8oKwnLJO+CX5hKhD66a0bXr0zBTpq7nziHt5IWSPoNqV4wzuOG2EUsV1WyOuJYNAdAhgAZjuN3v2ILN5h9Pu5oLFei25iubYc5kY7a/KtvQYwhc1SSQmvG3LfZ/yil/ajqjuvRztlYYo+yZeGwCSdPoRgd18iJYJfIHkmCTZxPLHh/hpGMMDxrnmFxk8TmLEEMpRVvKcz2p4BngJj327eKFUxx+ZcRmQ9hY5noQvWbDWQYvzfn3zDiWSurs5pI5EDotgpIWRCl2MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHKIes1QBRpa4Z2C5P9EGE4vmvO1oqOWmP4wP0QEPqc=;
 b=c3PM1XtzLVrbZeLnBcN7Grh830gLzPq9aaUXRpOtCYl8pJ1Q41Yo1hq0QM8BVf62GVXa6yhV555HAL5ZgJ+4d1R/LYWlqOYKJJzVpTRK/ECqVp9sAuNqV/AGFKgdlqMS6MnRdRfUQ8U0OJmft7yzKBxvMj85L5r9zxMhyn6zkj8=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1786.jpnprd01.prod.outlook.com (52.133.163.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Thu, 19 Dec 2019 21:04:12 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2538.019; Thu, 19 Dec 2019
 21:04:12 +0000
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
Subject: RE: [PATCH v2 0/6] spi: Add Renesas SPIBSC controller
Thread-Topic: [PATCH v2 0/6] spi: Add Renesas SPIBSC controller
Thread-Index: AQHVrDsFo/XrCnZmIE+HK5Vec6rH7qevIW6AgAK0x/CAA35sAIABOkowgAa4UICAABhMQIABaMMAgALzYFCAACk8AIAAH8tA
Date:   Thu, 19 Dec 2019 21:04:12 +0000
Message-ID: <TY1PR01MB1562A75F78A7877A733EEFFF8A520@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <922cfa46-efb5-9e6d-67ea-3ac505b8211c@cogentembedded.com>
 <TY1PR01MB156215E8668C0317FA0826B18A580@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <e6a73df5-31c4-3472-f7bc-a0984f1f5380@cogentembedded.com>
 <TY1PR01MB1562D343E1AB06DCA2973DAC8A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <590840ce-a250-2512-3d04-c2420d83f7da@cogentembedded.com>
 <TY1PR01MB1562B9EB96818DCA507079808A510@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <bb630141-021c-5618-f266-b98b29956fa8@cogentembedded.com>
 <TY1PR01MB1562E196AB1C582F186CC74B8A520@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <6f4c5d92-3ca4-2d1d-47c4-cbd52ad428b0@cogentembedded.com>
In-Reply-To: <6f4c5d92-3ca4-2d1d-47c4-cbd52ad428b0@cogentembedded.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMTlhMmE1NmMtMjJhMy0xMWVhLWFhNTgtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XDE5YTJhNTZkLTIyYTMtMTFlYS1hYTU4LTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iMTAzNSIgdD0iMTMyMjEyNjMwNTAzOTgzMjM5IiBoPSJqRHpwa0RzR2QwSmdUS1hoV0NZTnVyT0ZSZzg9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c895258c-2807-4e4d-877f-08d784c6ffc0
x-ms-traffictypediagnostic: TY1PR01MB1786:
x-microsoft-antispam-prvs: <TY1PR01MB17863505BEBF866827415C058A520@TY1PR01MB1786.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(189003)(199004)(64756008)(7416002)(66446008)(71200400001)(81166006)(81156014)(2906002)(33656002)(6506007)(8676002)(55016002)(66946007)(5660300002)(186003)(76116006)(9686003)(66556008)(26005)(66476007)(478600001)(8936002)(54906003)(110136005)(7696005)(86362001)(316002)(4744005)(4326008)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1786;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5MY1doASJNXwCbJKLST0rRdyx9XV6/FJbZiZh9fU6H7T0ZkjD0UxLwSx/dc1cwG8hASuxShRcLd8vFJ7J+/PI3VF0RA1PB8P0K1LZrK4uzeVq18qVEIg1o0qzdE1X6LnBU0uGEOGtyJUpxNh8TVCrDQ4qh0SD73QgWi9HNpZWNpQMRO4RoFbPlEcmmF2DkTuMf9uiColxv29+OGz6FPcgboGlw6utG7F7IM279s32OXOsRDslWxBAWyz7CPzt9HqVz/fJoOlghHY5BoqMgW+HAPUQtziW64FikAsDdKB31oiZOUM8t58RfibI01GnGk8bJ3dSwQ+rPM3kcQ2yLk1uNBQ3fGUM789QkSSDmeFvHkWg1RrY2a8t7rniX2RdTSD2eURrI/CxZOuXYEnghP8BCjCJ+kgoGRJI73f39DAkkkM/Fa5x61tNPURBbr9slxj
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c895258c-2807-4e4d-877f-08d784c6ffc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 21:04:12.3884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e84bpNODD2PAUXDxYPEiJ8948+GuZAH1dfSrXvX8MVDy83WZDW+6fq49+Izhmzh2hLHf5wVQNi5ExcOGXXaZfVI1kyquVJW8V7NSj97rP5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1786
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gVGh1LCBEZWMgMTksIDIwMTksIFNlcmdlaSBTaHR5bHlvdiB3cm90ZToNCj4gICAgQXBwYXJl
bnRseSB5b3UgaGF2ZSBtaXNzZWQgdGhlIHByZXZpb3VzIFJGQyBpdGVyYXRpb24sIHRoZSBNRkQv
U1BJIGRyaXZlcnMNCj4gcG9zdGVkDQo+IGF0IGVuZCBvZiBNYXk6DQoNCk9LLCB0aGFua3MuIEkn
bGwgZ28gZ2V0IHRoZW0uDQpFbmQgb2YgTWF5Li4uLnRoYXQgd2FzIGEgd2hpbGUgYmFjay4NCg0K
PiAgICBUaGUgTUZEIGRyaXZlciB3YXMgc2hvdCBkb3duIGJ5IExlZSBKb25lcyB3aG8gaGFzIGFk
dmlzZWQgcGxhY2luZyB0aGUNCj4gY29tbW9uDQo+IGNvZGUgaW50byBkcml2ZXJzL21lbW9yeS8g
aW5zdGVhZC4uLiBJIGRvbid0IHdhbnQgdG8gcmUtcG9zdCB0aGUgU1BJIGRyaXZlcg0KPiBhcw0K
PiBJIGhhdmVuJ3QgeWV0IGFkZHJlc3NlZCBhbGwgb2YgTWFyayBCcm93bidzIGNvbW1lbnRzLi4u
DQoNCkZvciBub3csIEkganVzdCB3YW50IHRvIGNoZWNrIGlmIGZ1bmN0aW9uYWxseSBpdCB3b3Jr
cyB0aGUgc2FtZSBmb3IgUlovQS4NCg0KPiAgICBQbGVhc2UgdHJ5IHRoZXNlIHBhdGNoZXMsIHRo
ZXJlJ3MgYSBiaWcgY2hhbmNlIHRoZXknbGwgd29yay4NCg0KSWYgaXQgZG9lcywgdGhhdCB3b3Vs
ZCBiZSBuaWNlLg0KVGhpcyBIVyBpcyBnb2luZyB0byBiZSBjb250aW51ZWQgdG8gYmUgdXNlZCBp
biBuZXcgU29Dcy4NCg0KDQo+IEhhdmUgaGFwcHkgaG9saWRheXMhIChPdXJzIGhhcHBlbiBvbiAx
LzEgYW5kIGxhc3QgdGlsbCAxLzggdGhpcw0KPiB5ZWFyLikNCg0KWW91IHRvbyENCg0KQ2hyaXMN
Cg0KICAgICAgICAgICAgICoNCiAgICAgICAgICAgIC8uXA0KICAgICAgICAgICAvLi4nXA0KICAg
ICAgICAgICAvJy4nXA0KICAgICAgICAgIC8uJycuJ1wNCiAgICAgICAgICAvLicuJy5cDQogICAg
ICAgICAvJy4nJy4nLlwNCiAgICAgICAgIF5eXltfXV5eXg0KDQoNCg==
