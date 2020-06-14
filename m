Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623111F88D7
	for <lists+linux-spi@lfdr.de>; Sun, 14 Jun 2020 15:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgFNNFD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 14 Jun 2020 09:05:03 -0400
Received: from mail-eopbgr150078.outbound.protection.outlook.com ([40.107.15.78]:43015
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726925AbgFNNFC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 14 Jun 2020 09:05:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJQrEynNskBdV2fad5mN0T7eBgqANFxyRlXEuI6giJMxj10OV1jXrN3Tp8U4PpdaEzIiYiIdeA6TEEZh0k74jAJIyHlnVkjFg75K4Nt4CvqobxECJJr7UTsLcN0vLhPgUp2YBviCbJl3tCb1GbStWbkYe6N0+hcV7Fyre7UtuzYTxuoIQu7ZUDM6GTJg4q8hUfKdIShvmwKUYMtdFi03Vb9nrfkZXye4x1oT/1uIfQqAWIF6OC8D6vmgmpB2BWIMAbEi8SAy8PG7wsxNH860wGOgfYTxl0vzvF3/ndamJxCnnhAK3Aj15nTjg1fh6g+9fZAX2+dC3FMPnqAVbJzvLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shAuxshqLV/5jVunuGkkf9gL6Ck71ggWjzcCIxlwE9E=;
 b=jyi7FhxpvDak3TGKGoHC3RE7OYgtXakCFNEgRdaZevebdedrIuM6/X0wW0uctDQEk4UGq5ZbN1MxGmaXANUk72twkklBjaL4W/qwxn7eSLbxPXJm9+R43/VdyF3ueCyhJBBJXhixElVzUSO3AtyEJ93mprzoPq9EL6aKMF4lmKMafccj9uJaz2JxF3jNKgv3mBFdppUxv//zKcokvmC0/EP9bDfnJD+iHb35y+oluaHpIVZqZ0S8PyHc/qF7VFtiMdp0U+gTonL79U3LNUpCbte9PeNfji4gbW0g0lJko48EYyv9K1bLsUH5stWWtCFPwbAAJh+QfIoZQQZmh9HK2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shAuxshqLV/5jVunuGkkf9gL6Ck71ggWjzcCIxlwE9E=;
 b=iOrpHeefjzfQb4tJr6gB1iSxKOBg5I7Ex1YYmQqTOk2vcWT1W1ffF22Vs6GEmRzDQPnJdkkivYfwYnnygBHOfSdokQV/PxPxlPwJS5+I8rFsTa9JRE937PjGN7yORDfB570LoaaaAXUy+VfL5iMciPWP0Kr5vRhA9wKiVVQAAmk=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6365.eurprd04.prod.outlook.com (2603:10a6:803:120::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.23; Sun, 14 Jun
 2020 13:04:58 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3088.028; Sun, 14 Jun 2020
 13:04:57 +0000
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
Thread-Index: AQHWP6z7CX2etPvPnk+oddH8JEW5FKjTbHIAgADDYUCAAJUwgIAACjoQgAA5dICAAOmA8A==
Date:   Sun, 14 Jun 2020 13:04:57 +0000
Message-ID: <VE1PR04MB6638B43E3AC83286946DABCD899F0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1591880310-1813-1-git-send-email-yibin.gong@nxp.com>
 <1591880310-1813-2-git-send-email-yibin.gong@nxp.com>
 <20200611134042.GG4671@sirena.org.uk>
 <VE1PR04MB66383245FAD2AE33CFEA76F789810@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200612101357.GA5396@sirena.org.uk>
 <VE1PR04MB66384013797FE6B01943F2A889810@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200612141611.GI5396@sirena.org.uk>
In-Reply-To: <20200612141611.GI5396@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.235.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 20e42814-dd67-4257-dc3b-08d810638a3c
x-ms-traffictypediagnostic: VE1PR04MB6365:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6365AB9B5DD121A0F1BF1BDE899F0@VE1PR04MB6365.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04347F8039
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: adNTOvM2ROwkPGgCrHepMHc4wuEAvWfQNGV6VSmnyLARil0cTfvqDZ9DKLgRbubr1froxtqw8Np3nFZEClBWOPq1JKUZIEpe8YyDHKri79Zmf8WOHQ5q2PzQIeZkBxavVIUSaR57qwhcSFbO3flbPO/vKTeiOC2YrmqU94iFCf0P3OFDNxdsZCN4kFIWwa4xPRHImoOknqgqtc8O2FqsjmfoUfzmiYWeMMPSfG5is8rkBhrw9Ojw7+j4MGUOZxxqSCvuGAWX4XZDXlwShgC+wfAJpPrffUZRmdOhxKioVFUCm7Jo6ZSZTweenzqg1lsEerpT6tv6EzNYTOjOZ1JNl7XfwmgwN9QKUO9XDJH+3+ZrZ6Xz/mfy+MOctSDOICGA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39850400004)(376002)(136003)(346002)(396003)(76116006)(2906002)(8676002)(6916009)(52536014)(66446008)(83380400001)(64756008)(8936002)(66476007)(66556008)(9686003)(5660300002)(55016002)(71200400001)(33656002)(66946007)(6506007)(7696005)(316002)(7416002)(53546011)(186003)(4326008)(54906003)(86362001)(45080400002)(26005)(478600001)(2004002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Q5gOLL8oj/Y/fmfohULLOG/KaMa2TMIyKDa0ieYaXSAkRKby51qz6aSTA54nLbw6bBvzdRuKGDWWokFsfPoSSoCKy2U9l6r5PTtSePPeR7vR37FYpJYIc9V7KQLsKirWudLYRi9fqzopGamRdPr0y7rxIMFqJmMRBpHr1dPN4xzjFAba67vsTxFKQW3y2cfjih4Y5WojoRdF4nMI03D+Vrpg3lMANZZNNVWKPlWpbwib1dsLnxr7GebVKWr2WgaxMKLW9pO/LnNUftrSF12eJp082Zs0parwyU+pYE4pNUktjhnDDg8gS8RgdYheOqtZjhbFX72wrjFo2ef4FQtwMnzuCZgx7rfsLS8Jn3lbxg6ucQ4Aano5JIDHzmU61udctiNcPJQDPb4jBfVb00CxQbvMeH38VGluAGQwNnMhvn9RiVoY7+9KvCR4fdJ4XNFFz4pvs6KrSrpDBm26/6AGSx6nYhzY4W/y3avZ83zc1A4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e42814-dd67-4257-dc3b-08d810638a3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2020 13:04:57.8287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RrpdPdsrC09ZxJ0RTJGN15XZELcMyglqDYack75/UUs+gqOJ25LLW61D5gwF2LCfTUO5oRrzt44VTBE0Igag1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6365
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2020/06/12 22:16 Mark Brown <broonie@kernel.org> wrote:=20
> On Fri, Jun 12, 2020 at 01:48:41PM +0000, Robin Gong wrote:
> > On 2020/06/12 18:14 Mark Brown <broonie@kernel.org> wrote:
>=20
> > > Please look at the formatting of your e-mails - they're really hard
> > > to read.  The line length is over 80 columns and there's no breaks be=
tween
> paragraphs.
>=20
> > Sorry for that, seems my outlook format issue, hope it's ok now this
> > time :)
>=20
> Yes, looks good thanks!
>=20
> > > Client could enable this feature by choosing SPI_MASTER_FALLBACK
> > > freely without any impact on others.
>=20
> > > SPI_MASTER_FALLBACK.  If this works why would any driver not enable
> > > the flag?
>=20
> > Just make sure little impact if it's not good enough and potential
> > issue may come out after it's merged into mainline. TBH, I'm not sure
> > if it has taken care all in spi core. Besides, I don't know if other sp=
i client need
> this feature.
>=20
> It's not something that's going to come up a lot for most devices, it'd b=
e a
> mapping failure due to running out of memory or something, but your point
> about that being possible is valid.
>=20
> > > > Any error happen in DMA could fallback to PIO , seems a nice to
> > > > have,
> > > because it could
> > > > give chance to run in PIO which is more reliable. But if there is
> > > > also error in
>=20
> > > PIO, thus may loop here, it's better adding limit try times here?
>=20
> > > An error doesn't mean nothing happened on the bus, an error could
> > > for example also be something like a FIFO overrun which corrupts data=
.
>=20
> > Do you mean fallback to PIO may cause FIFO overrun since some latency
> > involved so that this patch seems not useful as expected?
>=20
> No, I mean that the reason the DMA transfer fails may be something that
> happens after we've started putting things on the bus - the bit about FIF=
Os is
> just a random example of an error that could happen.
>=20
Sorry Mark for that I can't get your point... The bus error such as data co=
rrupt
seems not the spi core's business since it can only be caught in spi contro=
ller
driver or upper level such as mtd driver (spi-nor) which know what's the fa=
ilure
happen at spi bus HW level or what's the correct data/message. In other wor=
ds,
spi core can't detect such error by transfer_one().

> > > It *could* but only in extreme situations, and again this isn't just
> > > handling errors from failure to prepare the hardware but also
> > > anything that happens after it.
>=20
> > Okay, understood your point. You prefer to some interface provided by
> > dma engine before dmaengine_prep_slave_sg so that can_dma() can know
> > if this dma channel is ready indeed. But unfortunately, seems there is =
no
> one....
>=20
> Well, this is free software and everything can be modified!  The other op=
tion
> would be framework changes in SPI that allowed us to indicate from the dr=
iver
> that an error occured before we started doing anything to the hardware (l=
ike
> happens here) through something like a special error code or splitting up=
 the
> API.
Yes, but both assume spi controller driver could detect such dma failure be=
fore
dmaengine_prep_*(). Let's wait Vinod's comment for that if dmaengine_slave_=
config
could keep direction.
But despite of that case, do you think this patch is valid for transfer_one=
() failue
in dma and fallback to pio?
