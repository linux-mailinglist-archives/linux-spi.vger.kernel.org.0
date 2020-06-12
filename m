Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458021F7224
	for <lists+linux-spi@lfdr.de>; Fri, 12 Jun 2020 04:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgFLCSl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Jun 2020 22:18:41 -0400
Received: from mail-eopbgr50053.outbound.protection.outlook.com ([40.107.5.53]:39237
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbgFLCSj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Jun 2020 22:18:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlfcDQzOwnw8/G9zxETWMpGuZ9LBV9O/zoF4T9dqoKxoU29mhhepI9Befkq6nEQyS03KuG7b2CvG5ACSwGUgIux1a2caIzuyRfmOSC9qPOtl0zIttT9o9XZ4VyoM402eho6EvIBmQrlqXPcts8/n+QvGBTyp03fXaPQ18ewa2ImXmLSgZrx+2yanQLe23SR+ha4UvZ66byOxiqxhmIlWXo4AW4WDiJuBi2o49/DgMFGzaJMhD7iJ7T2to/UINgPaBEoiiKtm5Ir593U/v/itZ5UUYPg61fCO6s2dPL17LobpIdRLsmgH5oOf1drWza00r0mzg+TaR30FtEHhqumnmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHOoT8na1ffMKrVbK2XadykwDl7QE51+OUO8aCLZYI4=;
 b=nOfIA/iqe9wuuDWm6ej89VD9Cq6h6wnFRCDlweYBPzl2FlwPdbCp14smz7JF4I3WbsDtlBwnWuEt0OxCQHw2aLy04MOvnR6fW/G109p0VnlSMS8LkfzBUdBPuAnra+ln7pJIt9k/zo3uxGAijlncArD2AVGZZsURVxkIk2J/d+OTMqm1wWgPXebEWtSqkN460tS+oPe6pMNdUOL7XLkxWm+tVItwRkAqiGn+x+CDlas7y6Q9zXZNNsikHEt9wz9CUD7QOVpyqbqdpK6rtWNOkBRZCZ0T86X2iMvMjTOc2nB2gHJklj/XtUhzxPmhu3bKZ12QdgO1Vlq+HHyBLRu5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHOoT8na1ffMKrVbK2XadykwDl7QE51+OUO8aCLZYI4=;
 b=bFZo8Wo8+cVDZcGtYtmHWLaMDeHpuXn13IGKg6YzonqdF3Ya/rsYe/aueU09TA3ip3izGnl2TQXxjwkZHqb8MaZZtKzC3REKoyFA1OBXepvFRLh89oB25ohJ+tmEZfYIWbCbQP+ru9Ff4Le5qG3XEwf71HU+xDmZbvRxBIfRMKQ=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6352.eurprd04.prod.outlook.com (2603:10a6:803:129::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Fri, 12 Jun
 2020 02:18:32 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.023; Fri, 12 Jun 2020
 02:18:32 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
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
Thread-Index: AQHWP6z7CX2etPvPnk+oddH8JEW5FKjTbHIAgADDYUA=
Date:   Fri, 12 Jun 2020 02:18:32 +0000
Message-ID: <VE1PR04MB66383245FAD2AE33CFEA76F789810@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1591880310-1813-1-git-send-email-yibin.gong@nxp.com>
 <1591880310-1813-2-git-send-email-yibin.gong@nxp.com>
 <20200611134042.GG4671@sirena.org.uk>
In-Reply-To: <20200611134042.GG4671@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61648114-780b-475a-539d-08d80e76e7b3
x-ms-traffictypediagnostic: VE1PR04MB6352:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB63520D161E338E4F8C9BE9EE89810@VE1PR04MB6352.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0432A04947
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DEiW76s4wzi1S5XdKXAgF3akdk+z1jF9TMofHYZwidLFnYXML+TEL2FHyHM351GENSXmqwTraVpRddcikCIMakwS+18CIF/nbXlUexmyOiHYQL8bqpcPA7NON56YCaWiyDl5Mr5tMMwo1NIvdyjD93hReqhMXGmVKXHYCtgPKwAsJVNa5KTdmrxBma1I0B64GqiJwD0Lr5e+TNpZCE0V2pkaBF2Dt8EOEkrKM2z0D9S8lilCJne0XPzqQXaxfgUTnx0mmsiXkujUmvKvoOXV9K72ZMHL60znNWsBj7wTKgU1JoYLNQzAFsNfvFdtIZCcjelEd4vX6TZV7qTA7JrmgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(186003)(26005)(4326008)(83380400001)(86362001)(8936002)(7416002)(52536014)(8676002)(478600001)(66556008)(5660300002)(316002)(6916009)(2906002)(66446008)(66946007)(55016002)(54906003)(76116006)(33656002)(7696005)(71200400001)(6506007)(64756008)(66476007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: DV59bNnfLvJaTSGCQGmq+4gxb76h8zDXrr5V8GfMvWgWdpBsNLICs80/lnseTph8A+9FImLorC/R20JIbiuRdVRMlkotuA9tjn6LzJwoBgV3mUtzki4W56DvLJN6/yTdJs3LjTGfv3tP1RJoCaHTQmpNqV6vqpg3qDO35LuAYoAKC8RaplP1vv2R4OlGRyfkcZ7PZLQ+PqTG6L2sIodxO+ZsLHqjbUr38PCc+uqoa5uj+SCHqS9LXHLPsbDy7eQ+DoAFzIkWbgI9Vh9wcVFc2AS96fuLQe+KGoUuuYHY+B/I9TzurXwI6R9hP5Z899v8sLcof/rvwH+TAHMPmsiucQ46gQIbBrqm+b3shV7CwZXIC1CCyOSy7/72TxtE+5EnDT9PGpJzCuSW6wtU7Q1FL+WmVrnK9YgOLwIYwDk4iOTf5hdjBvmlYMJRPqtwr3sEFhLZf7fSyUbGO17ptLDBCI5nMy2Advaa4+0iH3/VrUU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61648114-780b-475a-539d-08d80e76e7b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2020 02:18:32.7785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9M6VJuoOCLXgwbt5zVjDPCaxBJG5y80jtihGJ8PM6XnMIu4pJpyftBeu9KG47Pb1NahhhiK24+W0kzNseJpqdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6352
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2020/06/11 21: 41 Mark Brown <broonie@kernel.org> wrote:
> On Thu, Jun 11, 2020 at 08:58:29PM +0800, Robin Gong wrote:
> > Add SPI_CONTROLLER_FALLBACK to fallback to pio mode in case dma
> > transfer failed.
> > If spi client driver want to enable this feature please set
> > master->flags with SPI_MASTER_FALLBACK and add master->fallback
> > checking in its can_dma() as spi-imx.c
>=20
> If we were going to do this I don't see why we'd have a flag for this rat=
her than
> just doing it unconditionally but...
What do you mean flag here, 'master->flags' or SPI_MASTER_FALLBACK? 'master=
->flags'
could let client fallback to PIO finally and spi core clear this flag once =
this transfer done,
so that DMA could be tried again in the next transfer. Client could enable =
this feature by choosing SPI_MASTER_FALLBACK freely without any impact on o=
thers.
>=20
> >  			ret =3D ctlr->transfer_one(ctlr, msg->spi, xfer);
> >  			if (ret < 0) {
> > +				if (ctlr->cur_msg_mapped &&
> > +				   (ctlr->flags & SPI_CONTROLLER_FALLBACK)) {
> > +					__spi_unmap_msg(ctlr, msg);
> > +					ctlr->fallback =3D true;
> > +					goto fallback_pio;
> > +				}
>=20
> ...I don't think this can work sensibly - this is going to try PIO if the=
re's *any*
> error.  We might have had some sort of issue during the transfer for exam=
ple
> so have some noise on the bus.  Like I said on a prior version of this I =
really
Any error happen in DMA could fallback to PIO , seems a nice to have, becau=
se it could
give chance to run in PIO which is more reliable. But if there is also erro=
r in PIO, thus may loop here, it's better adding limit try times here?   =20
> think that we need to be figuring out if the DMA controller can support t=
he
> transaction before we even map the buffer for it, having the controller j=
ust
> randomly fail underneath the consumer just does not sound robust.
But dmaengine_prep_slave_sg still may return failure even if anything about
DMA is ok before spi transfer start, such as dma description malloc failure=
. This
patch seems could make spi a bit robust...
