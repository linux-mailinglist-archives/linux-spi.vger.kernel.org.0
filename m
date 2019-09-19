Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4EDFB7DE5
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2019 17:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390259AbfISPPA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Sep 2019 11:15:00 -0400
Received: from mail-eopbgr1400105.outbound.protection.outlook.com ([40.107.140.105]:7536
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388792AbfISPO7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 19 Sep 2019 11:14:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxJvXapZy82u/cW7L5URA1JOoKfiJZQYAOijxbWOaq8ngX8Fc4/mSj9MzertunKUJmfKGiaZGtRn/SvrQR1ct2+wrwVe7Roqg07sLE3S3HZpidJVTEhCpUC9uao9YGxJ7bs/7zc9qpukdxP+kaU6bO1VWQnSVkMpmD3ZZtQfw9jrAbwhbh2noXqqwfZ7lvo7QooGxKozUAC6+jlxfWDnt7qnTAgFD3+OfhiQ27uLNF3ZwJFFnlqVOe1AbfTGHx0J9Ksho902caf0jUoz47MMQE09oppBzu04twCmGhvCeppIGw6cs5Ct/Vph0WxWfFEvwKp0Kfp0jGFsEDX/kewHWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d54qF5KyRcFDMuU7uOvRwwg3QTwvNOI9J9LE1KUf8ig=;
 b=Z+F3rchv4KtIiqKtbQ3hrCwqAOo3AVyKrDXaW5V1W24Yl1JEyvoIAiFu8qOLi8fMdD8glMLbS22dLa7Wrih4xPtSfSHhV54vSHZWUp0ETJ3p/xLd6HaHyMTVcLd2Ma9QaivZTaY7U6M3vyiKTza+jmOi4++y3lQZps2ijaErzJCMzKGy7+vnLa74kUiyh8NKQdh+Pc4rA1e+sWNLg1ALU6hkyDq5qYyau49YL+buAut338+vHFRalzGESG6OrHJMlfDdxBi/QuyX2tP6t9zTua5mCpmDK/9sP7h6ouWNypA9OOE0jvP0nyKAlOXkDbGQM7uaTehMcOWDEZek50kFoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d54qF5KyRcFDMuU7uOvRwwg3QTwvNOI9J9LE1KUf8ig=;
 b=rfMB9jkL5eNxT/Im0eoB2vrkoFijMsB5jY16UbciWVbjXv0dlOSlVAgtgW4poCTCGAiOgtZyvLemEmbAZ9SXO1ZemlC05fj5wlANMTUU6OL1A1duHQfw4gMgOTEPiK+VHwy3WyXKA53DmbbgZaNMGMAUqNxNJ0P7zvvRLfL9FY0=
Received: from TYAPR01MB2925.jpnprd01.prod.outlook.com (20.177.103.14) by
 TYAPR01MB5295.jpnprd01.prod.outlook.com (20.177.105.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 19 Sep 2019 15:14:55 +0000
Received: from TYAPR01MB2925.jpnprd01.prod.outlook.com
 ([fe80::d81b:cb:a3b1:6ab6]) by TYAPR01MB2925.jpnprd01.prod.outlook.com
 ([fe80::d81b:cb:a3b1:6ab6%6]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 15:14:55 +0000
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/4] spi: dw: Add basic runtime PM support
Thread-Topic: [PATCH v2 0/4] spi: dw: Add basic runtime PM support
Thread-Index: AQHVbfe+ROhh0nvwh02I6bi+YHxnp6czAROAgAAX74A=
Date:   Thu, 19 Sep 2019 15:14:54 +0000
Message-ID: <TYAPR01MB292515FE4C74044CA53321C5DF890@TYAPR01MB2925.jpnprd01.prod.outlook.com>
References: <1568793876-9009-1-git-send-email-gareth.williams.jx@renesas.com>
 <20190919133113.GK3642@sirena.co.uk>
In-Reply-To: <20190919133113.GK3642@sirena.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gareth.williams.jx@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83651859-173a-4562-3aba-08d73d14209f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TYAPR01MB5295;
x-ms-traffictypediagnostic: TYAPR01MB5295:|TYAPR01MB5295:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB52958C88ADE8D211A3BC5F08DF890@TYAPR01MB5295.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(366004)(346002)(136003)(39850400004)(199004)(189003)(476003)(6116002)(26005)(66066001)(11346002)(99286004)(86362001)(71200400001)(71190400001)(6436002)(9686003)(55016002)(52536014)(25786009)(6246003)(446003)(186003)(6916009)(7736002)(81156014)(66446008)(305945005)(66556008)(486006)(6506007)(4744005)(33656002)(3846002)(8936002)(478600001)(64756008)(4326008)(102836004)(54906003)(74316002)(8676002)(81166006)(66476007)(7696005)(2906002)(5660300002)(229853002)(14454004)(66946007)(76176011)(256004)(316002)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB5295;H:TYAPR01MB2925.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1/7DCCHgx+sZEQD/074Pv78E6FTo1dMsQRdPNuKbyvI/poWOmBuqBJVHgFrYbLvKGOYC4czlI7xQJuWiKoVBvQ5+Qp+pVi+DceZ3SSg7Yy4hNYTfVX7Tm9jh7JwGL1xsawfr0eRXq7LEBsBppf1Y4KRZmaRImk8oizogyJMg1HgDaUk2jPn896Up27OYaC0GdXUyAR7lp9fpqkav+ZeEkKMwSjkGgf3vnAjFC/MfBkWh6/BaDbRT25Hp1rR949W24cGeLFqHix7kygSUqcNv6u8hsYQK0tiDQ5DdpobOIPfIRPK+Hv+towHOQeJ+XcavxGdRRUeuEfSnXHdQq2/BYjBR7omXgYwR8gTUdXOwd4MdQqNgF6KnrXoNIrYSK9zPU3swkNSkU42arLaCYwfh6kud4/0gV+BO+BJauCoX4t0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83651859-173a-4562-3aba-08d73d14209f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 15:14:54.9192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D2ZMCC4I/bVk3+RN0NxWcO3QpNPwdCQzx638vU+TuJMCx5LVhWGHwSh98SWyGYG8dfgkQBPK99mEwduc2pK+KH9wryWwFzqpMVfJoByT84w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5295
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On Wed, Sep 19, 2019 at 14:31:32AM +0100, Mark Brown wrote:

> On Wed, Sep 18, 2019 at 09:04:32AM +0100, Gareth Williams wrote:
>=20
> > Gareth Williams (1):
> >   dt-bindings: snps,dw-apb-ssi: Add optional clock domain information
> >
> > Phil Edworthy (3):
> >   dt: spi: Add Renesas RZ/N1 binding documentation
>=20
> Please use subject lines matching the style for the subsystem.  This make=
s it
> easier for people to identify relevant patches.  This isn't even consiste=
nt
> within the series :(
Sorry about that, I will correct the subject lines for V3.
Is there a set convention for the subsystem I should follow in future?
Or should I follow the style of the individual files I work on?

Kind Regards,

Gareth
