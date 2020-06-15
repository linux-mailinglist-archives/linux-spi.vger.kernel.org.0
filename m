Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BC01F9AF3
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 16:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbgFOOxe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 10:53:34 -0400
Received: from mail-vi1eur05on2059.outbound.protection.outlook.com ([40.107.21.59]:6211
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728304AbgFOOxe (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 10:53:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOKOwJuFJ6Ob2aVm4zLI7ttVBIEZbaVbqrBdiJGs/ub9+7/mYUIhou0WuMCCxpO/R2EtWnrjgF2C3/YDD+fISkKpfpPBtFGsqXYN2F7BeoZR4iMsrJ3XFnQcXr94bsisYgF/S0fL7X/TtyIlpY6JnnQ0JRSHykt2V1Z/sVGgeMVEfOsLzSXFCG753jiDHrWQo1ROag1CNnAPJnXhRoJK/FBYAuIIoPdtO0PyZzpI3em4AsDbpgSbROfWCxENCXsGmSf0dv1FDcJzdMd/ZQLWzJgoPYAyIycgQ7VgBCPdBJBEkNyzeh2AWHD/MhyQmtlfqWn8m+/zHya2qfbzxb6mBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Bc/Xhpc7c79ShuhNKagxGQHYTBvh9hkPN5apWBVGFs=;
 b=WR/kcVFRsvX+VoE9XEs/LKl+VPCSJseYbztI8W8s/ULjWgIaxT4UXPBfouOX0AOre5Mk2aBHK5bU93A19lqzPNA9n+Phm/EBXUaFUYsG7W1K1s+zwDXykVXT32jZydNVAeSp3CUfiBQIITd1Yg00YeeSzCUTvqC/Ism7YN1Gjp9zMv9EJIFnCdvveOdLF/2DN3udSNpzBCyXpNANKfPQ42xz/GfBtmQKVSXgtDqvBUTNWrM97mHO90bQlQIPWclmv1iK6at17usZDlycGrwjf67dY4ojyLzBs3ZK0qbJIkJmjmMU1WFJ1Ez/kqB0Tdr/WA3+yzL3w39e1krsROMpTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Bc/Xhpc7c79ShuhNKagxGQHYTBvh9hkPN5apWBVGFs=;
 b=shXgN8RlKI/KdlM0GGF5IaUaw9lQGRpDXtaptG7UkbcPvUGi7yQJILAzN6ohc4p63cE6NI1Jaq9uvAy/luWZIy5wqNGIbW18IX4ijddUEmjW1SxjHyjbiGHYpI3No4mNmrjgExWmWq8GaGGTQnnzmS+6+ZxxcDClxKihVE+OlZE=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6525.eurprd04.prod.outlook.com (2603:10a6:803:120::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Mon, 15 Jun
 2020 14:53:30 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3088.028; Mon, 15 Jun 2020
 14:53:30 +0000
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
Thread-Index: AQHWP6z7CX2etPvPnk+oddH8JEW5FKjTbHIAgADDYUCAAJUwgIAACjoQgAA5dICAAOmA8IADsXmAgAANH1CAAASJgIAACZlAgAAGaACAAAKk4A==
Date:   Mon, 15 Jun 2020 14:53:29 +0000
Message-ID: <VE1PR04MB6638D0C9FE0289FFE13ABA49899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20200611134042.GG4671@sirena.org.uk>
 <VE1PR04MB66383245FAD2AE33CFEA76F789810@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200612101357.GA5396@sirena.org.uk>
 <VE1PR04MB66384013797FE6B01943F2A889810@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200612141611.GI5396@sirena.org.uk>
 <VE1PR04MB6638B43E3AC83286946DABCD899F0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615123553.GP4447@sirena.org.uk>
 <VE1PR04MB6638C65257F41072C3D61583899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615133905.GV4447@sirena.org.uk>
 <VE1PR04MB6638793C00742D5BA72F8AC2899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615143622.GX4447@sirena.org.uk>
In-Reply-To: <20200615143622.GX4447@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.235.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 959003b8-59ff-4c32-64a0-08d8113bde29
x-ms-traffictypediagnostic: VE1PR04MB6525:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6525AA69BC7D7041FDDEE116899C0@VE1PR04MB6525.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m6KHG73sDXZAyWX49AlNpiK8HZSyGhBQDqrcCuQDMSiIzhE+0k/qgZ/OdPH+9m+Izv8MkfXQc4QAn5t55XPvWknFlKTrfEZmfIYr8FnboCZK0Dz/A7WzgyFlf2ldx80sY6eZLkZEdxdqgvFquoWPXUBini176OshB/906MuEEdiz55CJaz4SkSS5qyc7jjHgSvGsr55fS4GufguCJO4MnRXlEcPRpnyAGDb8yy7eUB/d1I5Nzk7/+1Pa84UVn6IGi7MWH6iZGWvMezAihEQxaiU1EzPRredkNZBE2viZyw/KZGm0PAp0igIa4Lahyb4N5VQtv1QGXJxPpmeKK9sWhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(71200400001)(52536014)(6916009)(8676002)(4326008)(86362001)(33656002)(26005)(4744005)(83380400001)(5660300002)(2906002)(54906003)(8936002)(478600001)(316002)(7416002)(66946007)(66476007)(66556008)(64756008)(66446008)(9686003)(6506007)(55016002)(7696005)(53546011)(186003)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ceA14vWNvicsfLKYk781BjrrUbx3D49V5FYqvkWaEoPdMZO70piURMUBvPcBtD3BKGQDeOcmo1NsdUHQzeX9rvTXBWlVsUg7Cb/JtkttEO0XgNrc7Dl9tF6t/YjQapc/nTUV+2TXYA7qpf4uwKfOcoMACS9eTfNbHcgg2D/jt/nZEtJ6pbbUX8/ia7xFL9H0Zu/bbzlbUUcwVe7FsDP5PDOLSJKxiilRuuXZvC7gSj55ZqJRihrXyRcBxg9B6HPf6Q6sisPMPX/JaZf0MhRZ+CqeNl4dtUE7mgNaD/1MBOR0nsbqq2+ANzG/dKxdD9ypH74IWtZO12UI1SLzWIp0Ycw4l7C4g/Fre/LCTSU3qp339A/q50FVv8AIOKmg4/YnPs60r5/dDYNsKn5REmWUrep2SZmdKO+oOnU7el5t9cGlVkzrMGJHlNR3S6W1PO7QgfhI+LyVCpZej0prAE11iLYe6YEiDsLqBz8dP83UeLybKWPdcr8/m4KddddGmxTo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 959003b8-59ff-4c32-64a0-08d8113bde29
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 14:53:29.8763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nbwsj8K9HOO5+HieE1raLiD/el0lQkCB81b2qhB5ncpYHZzYNdhAk15xoqFenontzxrESE/DlRdeq06D3IAXUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6525
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2020/06/15 22:36 Mark Brown <broonie@kernel.org> wrote:=20
> On Mon, Jun 15, 2020 at 02:18:54PM +0000, Robin Gong wrote:
> > Seems not easy to find a suitable error value, how about EBADR which
> > sounds like no any available dma_async_tx_descriptor got by calling
> dmaengine_prep_slave_sg?
>=20
> > #define EBADR           53      /* Invalid request descriptor */
>=20
> We could also pass in a flag that could be set separately to the error co=
de to
> indicate that nothing had happened to the hardware yet.
Do you mean spi-imx.c checking 'ctlr->flags' before return such error code?
Or just like below done in spi.c.
+fallback_pio:
                        ret =3D ctlr->transfer_one(ctlr, msg->spi, xfer);
                        if (ret < 0) {
+                               if (ret =3D=3D - EBADR && ctlr->cur_msg_map=
ped &&
+                                  (ctlr->flags & SPI_CONTROLLER_FALLBACK))=
 {
+                                       __spi_unmap_msg(ctlr, msg);
+                                       ctlr->fallback =3D true;
+                                       goto fallback_pio;
+                               }
+
