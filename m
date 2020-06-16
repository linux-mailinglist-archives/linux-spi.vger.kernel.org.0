Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7E41FA63A
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 04:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgFPCDq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 22:03:46 -0400
Received: from mail-eopbgr30070.outbound.protection.outlook.com ([40.107.3.70]:21890
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbgFPCDp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 22:03:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRZYnSYYT5v+vhelPLp8X5oH4yKY+CbSjdNClb0hToGHBzQw6yI/XHBfHyBH++5umIGoF23bk18hpKekMDETCbMpw0Ptg467fWr2urtHbP/1SHQSbA/TneVcmrCvTv6+PX/o/AL/SnatGYX3dI4rLRTQ6F+iexkX0ZaUdAy3yJ01qLxLqoW5xVGSkvnj5Bkbk+PvzRqLapamqTASmRtiV/UIzdn8wIb4aiZVIj9aOVS0rPs10O7DK+IDmdYglm4Y1W1zFOv1WaczAEcV1ocy5UrH7s8AXVGjYb+pHq731qvFBWUmry8rTBnq+N6UhLnQ8cQgOy3PcBgs6Syb8EMDCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24UyItPKLQcpO1fIYulCToIRjAlklD5MWYk79VuOHSI=;
 b=h/Q0CdVf36/LD3GBtyYOA0jqLlywMjdfE7bn6GSD9sgQ32mDL9S2OzfDz274ekM+Av0SreYyWKFBiU/cZSkOoBTSTSgLUP2hETRjS53ycgbTJDm51GwC9cpHDMSMehabF8FrcNjAtaE/aduidDTgamxc/ZvNQ9udk8bKC0TZAhfn2POcRfx5oU45Gjgk4vjBC+lO0nsaBDzenrNEn3g783NwiEXa+rJf/jW3pI5M4HQsbTLTi7NmSGUb6G6EW/2X0zwkp6FgNDuGZOo0w/xJU46twP8fQxN8uCoYcbY5lZvcWO2XTyl90z+AIK4yaMIwNkJWG5T4IVNhFCOfEF53RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24UyItPKLQcpO1fIYulCToIRjAlklD5MWYk79VuOHSI=;
 b=dQXk1/FhByX0cTRpG/0BD7DCYl1Z7kuoCV83ulahQsq0t8obO6QgV9AIlRz24ksx8Nphpd2VSrIMpangZjdFL/BhD7hPsWOPxUanplwcYCwq92nV+ja6fyG9gpPiroUWBHJ3Vp9itdEoO6F9IETMean+AyHodLg9Lmgzim8/2yQ=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Tue, 16 Jun
 2020 02:03:40 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3088.028; Tue, 16 Jun 2020
 02:03:40 +0000
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
Thread-Index: AQHWP6z7CX2etPvPnk+oddH8JEW5FKjTbHIAgADDYUCAAJUwgIAACjoQgAA5dICAAOmA8IADsXmAgAANH1CAAASJgIAACZlAgAAGaACAAAKk4IAAAtQAgAC2bzA=
Date:   Tue, 16 Jun 2020 02:03:40 +0000
Message-ID: <VE1PR04MB66380FD8FB7FCE79AF4B6CD4899D0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20200612101357.GA5396@sirena.org.uk>
 <VE1PR04MB66384013797FE6B01943F2A889810@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200612141611.GI5396@sirena.org.uk>
 <VE1PR04MB6638B43E3AC83286946DABCD899F0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615123553.GP4447@sirena.org.uk>
 <VE1PR04MB6638C65257F41072C3D61583899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615133905.GV4447@sirena.org.uk>
 <VE1PR04MB6638793C00742D5BA72F8AC2899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615143622.GX4447@sirena.org.uk>
 <VE1PR04MB6638D0C9FE0289FFE13ABA49899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615145556.GY4447@sirena.org.uk>
In-Reply-To: <20200615145556.GY4447@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d0105a4-525f-4a7e-1acb-08d811997d9e
x-ms-traffictypediagnostic: VE1PR04MB6589:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6589429F1F40273870EBE67A899D0@VE1PR04MB6589.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GOm02js58CpSU2qvycC8VCkxday+sgeXzSOy9nN6Q1zUIjRwrBsOlOFOEFW1Mq+5Qs9psI5hWAkCAN+Ze3gJDGkqb1eWi1xOAxw0zCORfoWqjbjYntoZJ2pQJCbQda304OJnklAu34UC5a1ATft6faCnvSlzC/6XnwxrkC6q2MTMPitQkCmqjhetO1oUmXxpqF0qTVGE8DAh7vHlEIImEXpj3IcJ8iMjxVWYFbUgKMvvVrrFWKe2Xc8YGd3F9ubkWUiYj9Yp/icW5DIIROILT3fXeu1rJ1p/JTFrYRfCEg1qOu3Lk1w37uRGUJeeGO2X/lUhbJBUbka0Tk1l6jMvyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(76116006)(66946007)(2906002)(8936002)(8676002)(6916009)(52536014)(9686003)(33656002)(71200400001)(64756008)(55016002)(5660300002)(66476007)(66556008)(66446008)(6506007)(478600001)(316002)(7696005)(7416002)(4326008)(53546011)(54906003)(186003)(86362001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 576+yUVGI1WXwULXu8FIYJchB6mbyj4kufABhehIEG4U8ddQD9A77yXdL8jdTdZn8DGQ/Qge6YWk1IT1JElaQgIp67fCV+y7KU8uQF0HF6JmcVDhBeHfOzQhQyRXMPs+YVw/iPpYFUz6usRWc0shM/oo5Rcp1hLaf/RaI84BCavKeHyjQbUQVJsL5t82tUWAgCVQklkX3tshCZSECHp4GzPLKW3m+x0Uyp6jLAXPt9zWgMDB+z6FOYtP6zlaEsLrJ11Yqik2QxLa23B0BDaTrW1XJK7InCQNW80RZJIDA56k9k29YxQ2mqvj7BBGv6MnEKbVvJkJDnXfGY96rBBl3oO4ath9HbWlYp7FZTlh5Tj2AlwtIooDvrmTwGyIl5jXKSGQOIuvyhoILzFDUWA96HZabxcFgMZR+esWxbGR/bR2Fg715jk54tHaZivP0CNTPDVHoexd3nWasMZbG7rT6ET7ILlO+lD2OMuGRAYp+bg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0105a4-525f-4a7e-1acb-08d811997d9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 02:03:40.7467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XWT+s3ttJHkWKRCup6lp6qyhadjQAS1b5rXSz891ZmMITVSHGRatfQaR4Sns1GGnzOOGlOITnNVynmuKoR3GBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6589
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2020/06/15 22:56 Mark Brown <broonie@kernel.org> wrote:=20
> On Mon, Jun 15, 2020 at 02:53:29PM +0000, Robin Gong wrote:=20
> > Do you mean spi-imx.c checking 'ctlr->flags' before return such error c=
ode?
> > Or just like below done in spi.c.
>=20
> No, I mean passing in an additional argument which can provide richer dat=
a
> than trying to smash things into the return value.
Okay, how about adding this additional argument in struct spi_transfer like=
 below?
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 95291fe4..7c19099 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -943,6 +943,9 @@ struct spi_transfer {
        bool            timestamped;

        struct list_head transfer_list;
+
+#define        SPI_TRANS_DMA_PREP_FAIL BIT(3)  /* prepare dma failed */
+       u16             flags;
 };

While spi core checking it as below after it set in spi-imx.c:
fallback_pio:
        ret =3D ctlr->transfer_one(ctlr, msg->spi, xfer);
        if (ret < 0) {
                 if (ctlr->cur_msg_mapped &&
                   (xfer->flags & SPI_TRANS_DMA_PREP_FAIL)) {
                   __spi_unmap_msg(ctlr, msg);
                   ctlr->fallback =3D true;
                   xfer->flags &=3D ~SPI_TRANS_DMA_PREP_FAIL;
                   goto fallback_pio;
                 }

