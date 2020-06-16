Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8A91FB0B1
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 14:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgFPMaD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 08:30:03 -0400
Received: from mail-vi1eur05on2081.outbound.protection.outlook.com ([40.107.21.81]:6078
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726052AbgFPMaC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Jun 2020 08:30:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0m8UEHBgp3aj0ky4izuhQbbZYLArDkrEK1hfp7g7nwtE17xwomgjBBsdGdQphNSvOXCxWw13+5Bf2V9k6FTBj9eua8gXvnOQ0V0yOleFDmTNnM+8YILEck+hP0fXoTi+3nssqScTM56rA9uf6Tl54+6D+Dj4BsSygj6o5lLKwPPGXE8895DqxQfmlji3rBk3rHwLIqRB/sWoycUKSqrzayo0XIv9Lkuf4nfm1cJcqBRKlenFCqMIbVaxEYEsgN6SrltCNvLKi6v6+bA+YvcGWXX9PQCFPGNpSWaiKG2TjqpK3I15rtNb3eJLPE91/zExSD2RGk4fAZbLtpMaRad5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sVxqG14Wz23Ve98PNOWs+hUDuulFT7sSBxtQCOvTBI=;
 b=b1EI6XqgNGREBN1IU2guzfL3/2prttrxq1shTNW4FKjTVuEAievoiw41PJy4HnGYp5/s7kKyb+mY/sRQCNqIck1BM8Ydyvq5Rftsu15+fSyCibW0bHUysg+PbDPJfDg/hengnHu9kBblHaJ6pYnEEd06TqQZiOn8/dtxhZ9ZLUSet00aLd+7DmF+VGR+lhHOmSr99qgoLEUGr1emeLpB3Naq7xO55uKbrgkKJiB6ngl2pnyfbPK8kzA6qoGdWADt1mZ278LR24DJBOjB6ZJbRnVnT2c9pnrYFlgBeQiCNETqFeUrfD3LXamxV0ntbxnHr4QGQ2p2iFuH1+SvpcvnQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sVxqG14Wz23Ve98PNOWs+hUDuulFT7sSBxtQCOvTBI=;
 b=Ok+zdHUCj3sf5n0Ki5oPL7F4QXgOxkFp3V+yI82fUlSVix8LBUC9MdslQNBwvi92i6BnZkwK+IBLmp1sz6Y2ykNPcAWrs9r949FI03g+XK5SG82BBQskS3E5nlHDWtzA4tAqsOKyWixhgOYZheq6gWMQh7rqlPHrcs4P0ychRG4=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6509.eurprd04.prod.outlook.com (2603:10a6:803:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Tue, 16 Jun
 2020 12:29:57 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3088.028; Tue, 16 Jun 2020
 12:29:57 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "matthias.schiffer@ew.tq-group.com" 
        <matthias.schiffer@ew.tq-group.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 RFC 1/2] spi: introduce fallback to pio
Thread-Topic: [PATCH v1 RFC 1/2] spi: introduce fallback to pio
Thread-Index: AQHWP6z7CX2etPvPnk+oddH8JEW5FKjTbHIAgADDYUCAAJUwgIAACjoQgAA5dICAAOmA8IADsXmAgAANH1CAAASJgIAACZlAgAAGaACAAAKk4IAAAtQAgAC2bzCAAIkpAIAAAgdAgAAFkYCAAB+kcA==
Date:   Tue, 16 Jun 2020 12:29:57 +0000
Message-ID: <VE1PR04MB66381A584159BEF5450B4CCD899D0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20200615123553.GP4447@sirena.org.uk>
 <VE1PR04MB6638C65257F41072C3D61583899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615133905.GV4447@sirena.org.uk>
 <VE1PR04MB6638793C00742D5BA72F8AC2899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615143622.GX4447@sirena.org.uk>
 <VE1PR04MB6638D0C9FE0289FFE13ABA49899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615145556.GY4447@sirena.org.uk>
 <VE1PR04MB66380FD8FB7FCE79AF4B6CD4899D0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200616095948.GJ4447@sirena.org.uk>
 <VE1PR04MB66387499F9AF80A68F720529899D0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200616102659.GK4447@sirena.org.uk>
In-Reply-To: <20200616102659.GK4447@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8ae0c9ac-8def-4235-d4ed-08d811f0fb28
x-ms-traffictypediagnostic: VE1PR04MB6509:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB65092A75F2428B61091A09B3899D0@VE1PR04MB6509.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8E1xpVG9oy3KT4LZIStHjaKOL6rGKB55gaNj/rvCKYgOp+nHpLggikJE7hj9Ak2hH4AR0cSA65UchE0eGDK0Mo1q0m9Ylne0oB3/9NySnXwXfJnjY8vI3eoK11a05Cq3ji8BmdJe/yR5GNtM9KW9CIg5wP7dZgoC400mOb6/jA97QX7r+1yh6Lz6tB8iJCvkdtyejWEqT4mujrqyPXy0xlK7Uym3z0Mohvod1CuU7F3jrR5DEROCmoKphu2BxjTV+onOExnSdUcOhGRrMtO3b7GIzeE4VOy2OPvLIXvu/ZAndMICTZe5abnOhAxNysPt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(7416002)(6506007)(7696005)(9686003)(71200400001)(33656002)(66556008)(64756008)(76116006)(54906003)(55016002)(86362001)(4744005)(6916009)(66476007)(66946007)(66446008)(186003)(52536014)(5660300002)(8676002)(83380400001)(4326008)(498600001)(2906002)(26005)(8936002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: FoGBSC5YrHU2pEFKAno/aB7yV3Qz3NWuvrQ6zJTlAxS28majXcctRPgQWy1xDs5S7s1JJ2FhcS3DFFk3YuJAYnbiQ+gEReltXKFNy64xzLFLA9txV1KUFGiIn/Mx0lZa8O6ii60PYg5EeKJs6yoQpkhnDe5wZ2ACsmdLUqQSUEHVL9Nnab2yx6+ZXeRcmLeYjxT5r/RegH60/5vek/NEWc/ivL6KgK3eSEBWv8M5Qtbjg35cCScjvG/LzfQatj75vK0xKMd7h6zjfVsNU4aDZJdAIR65viV6GjWkkBuyq9e3ojtMqzlWcUwjBI34IqgiLgQvzarstzZ5Sy2CFgzfgDtlJFhX5f16efzc9WZHQUIuthz12YBPQLzR1AxSdgVZeJf/sGJpl+k4HHU+gSPziedB9pnwz1MRaSycs3luWNtCGqFZGaFRvy+ragZ0WbkduechhwGWGuY9xmPHHLl6Oo6OWd+23oiUoL4qR+DfyvtZRgTT8MMW2zWImzkgidaA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae0c9ac-8def-4235-d4ed-08d811f0fb28
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 12:29:57.2158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HpA2Ue4y7Pkz2HbLjEd4LRDBGRg69ZoBNfDcWDwrHOUMUDEp1Pg5/zi3RLrfz18hb57eNNNNXBBd7TDvWMX6XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6509
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2020/06/16 18:27 Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jun 16, 2020 at 10:13:08AM +0000, Robin Gong wrote:
> > So rename to SPI_TRANS_DMA_FAIL? I think at least DMA is MUST for
> > fallback case...
>=20
> This is not purely for DMA, it's just about the failure having occurred b=
efore the
> transfer started.  How about _FAIL_NO_START?
Okay, I'll use SPI_TRANS_FAIL_NO_START in v2. Thanks Mark for your kind sup=
port :)
