Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 554DFAA9AE
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2019 19:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732307AbfIERGd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Sep 2019 13:06:33 -0400
Received: from mail-eopbgr1410109.outbound.protection.outlook.com ([40.107.141.109]:44675
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730485AbfIERGd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Sep 2019 13:06:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1qXX3fzRnQuiqWmGbMI3bQ+2yTIGSEk1UXNoddKpWAQq3/RDnmPc2n2SudINvYselSGWo6GSkhd2BxCiEh78D4b70Qig1lR8UuVo3H6RGMVNhc85X0L2A7AaOigXonsW0PDb4Cn2MrvelO9QKEInZbcJyd54PbNucQW6tEqC7skvnTC6MiRUTwHNCQOP5Bm8UxuY21KE6IOrecMtOcei0QpHYmGb15WnLJbujuZcKGw0u7I7r3wjZa76QJLcpd1gJAEnORt61rEUlNLhmyvEIP5BSlg0kb3CNqCapiH2ynJV6t4Fv/3KnS4CudzabPX+HAWEFpU0ywGvFDv3Am4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUIuRaqJvGEob7n5Rgn9bGM9mt+vyeAUh1uVs9VP8P4=;
 b=GM5b3859nGs3uiI1ey0uVLG1pQNevf1Sbws4NfB8eNYqtJdMtLVzrfeTCXKMroIyMtfTSdL9rWk9BdpmnQII7re6aK66fK+Qu+5cWjMSK9FU3QfNZ6eDUtt0jWvEO94C38e7t1k7cCDg/GZX3UIqoB9OK6n9oM+5qSXGkWuK1wn2jv3IhhbFS/Ix1EHKYQiBbhhS1jJQbFzGhy6vo/RT1CKQ4fvwOpBrpT+m76mf0dAVi4wEJbhkhO1Mg0NTYQ29ALPyyX1iT6RncX2glLP6gh+VQJDQtlttYPBkIkc648shj41b6uVTr3I7tlxspk3uP2hB7iYN2tyyJc71QPj3Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUIuRaqJvGEob7n5Rgn9bGM9mt+vyeAUh1uVs9VP8P4=;
 b=MeeedePMr0d8TwJ/lo269EtCoB21JalkoDynlO3mX1Lygm+Umf5HWTnaMgF7k+8RAeeJ7hTwMFEz3Wpjo3O1pZQ9+YN6hvmYXfVv/ahJ3Om/xwbXJ/EgdqheEokObEI5c1x1wbOx4fatIFvZyGch6bocy0EBXp/dPJfrb3mI9tQ=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1625.jpnprd01.prod.outlook.com (52.133.162.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.22; Thu, 5 Sep 2019 17:06:30 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::24ad:bfbf:53bc:f509]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::24ad:bfbf:53bc:f509%7]) with mapi id 15.20.2241.014; Thu, 5 Sep 2019
 17:06:30 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [RFC] Is runtime_pm in the RSPI driver broken?
Thread-Topic: [RFC] Is runtime_pm in the RSPI driver broken?
Thread-Index: AdVkC8Du3CsXm98ySyCQaW7xvH0UUg==
Date:   Thu, 5 Sep 2019 17:06:29 +0000
Message-ID: <TY1PR01MB1562DB9AB5D516662204C1CF8ABB0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctN2ViZTE5NmMtY2ZmZi0xMWU5LThkYTktNWNjNWQ0NjFlNzI0XGFtZS10ZXN0XDdlYmUxOTZkLWNmZmYtMTFlOS04ZGE5LTVjYzVkNDYxZTcyNGJvZHkudHh0IiBzej0iNjQ1IiB0PSIxMzIxMjE3Njc4NzM1NDAwOTYiIGg9IlB2UXdWcVlIcFBUdWxHSnFBZlRmRUgrclh4ST0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [24.206.39.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95187b95-4921-4b6a-2756-08d732236545
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TY1PR01MB1625;
x-ms-traffictypediagnostic: TY1PR01MB1625:
x-microsoft-antispam-prvs: <TY1PR01MB1625D359529C5319E369E6F18ABB0@TY1PR01MB1625.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:663;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(199004)(189003)(74316002)(8936002)(9686003)(4744005)(53936002)(110136005)(55016002)(76116006)(66476007)(66556008)(8676002)(52536014)(66946007)(99286004)(81166006)(81156014)(6116002)(478600001)(3846002)(316002)(14454004)(5660300002)(102836004)(7736002)(71190400001)(71200400001)(305945005)(2906002)(6506007)(26005)(66066001)(86362001)(2501003)(64756008)(66446008)(33656002)(486006)(256004)(7696005)(186003)(476003)(6436002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1625;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vQrrxXKgpzGB6lfn/Pt6YmJd/2TULIi5UieKpH9Zi8Pa9i+3fhtEGwyt+Gf3tp+cypnqPnIr22qS9NbkYHaPowCnaKSDGm94dt26eQMXG9oc/h9yE56jg/OwOUBA3wevfyXBiMJyjh8GpTyBLQnJNS3FL3X5woePo/rKdH3F+Kxy01AGeaRStcoIgfDHQWftTFEhbs58yeRS/+iTR+8h4+Lq3VOK1jz6tsc9lxWeYcjmSUMT9StkkauuQXXk8pZVqV6QIj0G2S6dw9WGNu8VXaLmVhOjIa2Re3nB/leuQoeP5sFxXqns9AgSFKwxpOCAe1krRWq34QgytaYdRZKCSI91K1wfRiXeeNCUO5EjX8Rm8MQ+nHrXO9FlqkGsvQaX0YVBe/eo1bK6ryAKBj6XRdzp4BZWABt9h1O5bjtsIio=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95187b95-4921-4b6a-2756-08d732236545
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 17:06:29.9370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dNhWj5qYRYckU7wWRmOxsBTDhnmLcc3adP7VAS7qsv3yHmzAbLX6RjZEw5so8WwYC6JhNQwb3OfkDvV27p5yoSMFjSWUXsm1DjfMWc9dI/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1625
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello SPI and Renesas people (and Geert),

Before I submit a patch, is the rspi.c driver really broken or not?

I'm working with the RZ/A2M at the moment.

Runtime pm was added by Geert back in 2014. (commit 490c97747d5d)

But I'm noticing now that if I turn off all the clocks in u-boot before=20
I boot, SPI does not work.

However, if I add a pm_runtime_get_sync() call do the driver, it works=20
fine.

So, am I missing something? It seems that the driver is not going to=20
work correctly unless pm_runtime_get_sync() gets called.

Thank you,
Chris

