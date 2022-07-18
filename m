Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B5A578326
	for <lists+linux-spi@lfdr.de>; Mon, 18 Jul 2022 15:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbiGRNG0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 Jul 2022 09:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbiGRNGY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 Jul 2022 09:06:24 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2119.outbound.protection.outlook.com [40.107.113.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFFB26110;
        Mon, 18 Jul 2022 06:06:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqWDQFm6yDCKlzXAbWDEr67/7oCaa+/zky95wizA7O0vUNKI4yrPE0lLvUNu/J8Dij5Nz3+OMYcZkj/Muf4X5WY9uwXNFBMWBxhTPhyZCYljsGwiyialznQGg46aJI+Xo7PWrZ9DfbuYYwG0dnfWqWBJsWJgBF8pNUVOoxpM6rmNsZzzTZsJEsZwjTCNrhHdzTRL4tLXdeTMA3Rfp+t5eCV12Pi6n91FzlX26I0N1FR4blbqJwK9lFwh04/GBkrrx6lEc105EgHfGYZM0i32Elw7aSwReBlbVbY3x9XFhVybUrIxYI7B4nE1ATwFKTAutInX6mQISnBmvDut717tVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qi9aNF5xlOixbM2EWSjblTtWFX0c3SQCe3sv/GzMk4U=;
 b=CJ3p9hi/i55hOMMV/kmXEl/vGZAyx7n3nC1fjtFKiyWGrJBvpMg9T4Cf2Z2oIiUM8vDGoQ+hXA3+CmnhOi8cqmFW/Dvbjjtd4dznGeb1ztD6pm/nZz0UdKEzFDtuZe8cZ7EHaX0ZXZ0KSLU7l2A7c3gvMKO8x5GTxkOZpw10c0WpjlZPMPEFGCeGiNgnqHRvwI8KUS8oUmhbQxaAh0KaokayABdRj8qs2m5QQmkadnqPspNhxPtNgaXo0Lgw1GNhJ5tsqpjYiG+N5HtsagbQ3K6aMPvsP4Z91Q08OmZVp2BqRaq82t8LK+/WC0tdELMAsmV27oFkYm5enM2LBARohg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qi9aNF5xlOixbM2EWSjblTtWFX0c3SQCe3sv/GzMk4U=;
 b=vIfN03kBgBqFEuPaV0CLGj/VdB5J3tUMyZhPOlefylk6nLY/pn5fYh5fRstuaW8I2ZtWf43oQ2HgfrJWGvbo1A8pQdSBIz7Dwtn4PZpMrIf33GSd8xHJ7xVdduMxM3U7d2O0gzrSE7NS/hJCAlvTKoHV7xGj/vwk3yfW7louUCc=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB2816.jpnprd01.prod.outlook.com (2603:1096:404:84::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 13:06:12 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%4]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 13:06:12 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] spi: spi-rspi: Add force_dma variable to spi_ops
Thread-Topic: [PATCH] spi: spi-rspi: Add force_dma variable to spi_ops
Thread-Index: AQHYmSpFDIO6jbtkAU6yW6fT0KKX0K2EEuuAgAABL5A=
Date:   Mon, 18 Jul 2022 13:06:12 +0000
Message-ID: <OS0PR01MB5922E766D98E351A679863CC868C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220716153934.292311-1-biju.das.jz@bp.renesas.com>
 <YtVTK6Y9QRBuJPr9@sirena.org.uk>
In-Reply-To: <YtVTK6Y9QRBuJPr9@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c58560b-8208-4b24-7417-08da68be4a2c
x-ms-traffictypediagnostic: TYAPR01MB2816:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JDaqVdqkNJahSCeg7abAI78rEKp9FHxs80mltA//yhkwCmH4/5KvW5IZwtzBo6uDkl4s7MjOkJO1lNtVKPrbdpPxfQAmlSXseyGo2grshA7onbO5Pvknt2v7GwblegGWXsMi5fzm2zJWBrrkSDO4Z0JqEfMlSS2tYamvAgA50+hzMG45pBKBel5/mDhUzhZP8zziYL/YfGWJJVFKKyAcc8y7LrLt79woENqVAYpZryvyPADEWxnH7edbOKASPIPcXY+JcDaBFmNPUaomd66Iho4LuJOUYYRptKIHdFaA4IHoiIIFmI3CqQ4GczclkE3oj8JIUORMFYbKIFVwbMlr589C8GepbVUFwcYRsGzBOwAqmHVEqcPOKpXhUboxnmcXCLWd9uTH101r018v6YOLNVDpIa0KS//vyfGEawrMRjP9gssbQTYF+aheusIupH9jTwWXHfByHmB0EBIcUFXdujvbd+XBUFmWy3ApAVgwKS9wL+aUklUTNEJdJQGVy0qaHYR6D42E/bwuWy/SUNRYI66S+CpIFiLWcpV0KNofP0kdd/K0eD7bXJjSfT9FzJzv1Qd2ny1VRqRX+X8nPR6zoqyn2vmV1xnDMK0OPkxnWNsnY538oqp4Z1E+gel9DuB2097VbaCCC+Ws5cptT+QeyAP6XcJhuCEoJaOKGHYJHE0p7gnMRN7igg4mdd8EO71q5Pd2yYNfGvoE1qW9E+DYvDZi7AoZBOCJ1aNpFpLlYfXe8gc78MB7VQss1P6CoRKCfY2rImXlRjZSvEFkAYPvk3i8WSE4fcpDbDHnFrUNjAFM/m/TxkzAkQuXZNUM0e5h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(83380400001)(186003)(38100700002)(26005)(478600001)(122000001)(9686003)(6506007)(7696005)(41300700001)(71200400001)(38070700005)(66946007)(64756008)(8936002)(2906002)(52536014)(5660300002)(33656002)(55016003)(8676002)(316002)(76116006)(6916009)(86362001)(54906003)(66476007)(66556008)(66446008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+7ujwCWyGhcVjQarC7UABxP5ZIc8Wh7M+Bkc4AFpBmAga5AjnEEtcYHyvv3o?=
 =?us-ascii?Q?NIRBQvM0nZGbJlBC02SVNXeQg3di59UuMM0FduXB51VCU3HsR/XCED+hkdCz?=
 =?us-ascii?Q?jcWBm2Rj70m7OATYCxoHv/6oQ8Q5VysELBbKF1wwsoNEkn5gH9mlRdH1/+M9?=
 =?us-ascii?Q?Nol6J0JT8SuoKYY8LceuMQdvfjv9Hky7eyRWsD18Wx2EsY9feMAfLdxiNHsx?=
 =?us-ascii?Q?Aritr83bXLL7WpxLUnygcgOImMR+i2pxRHtb+p/gOZ8NuN3Sjd4GTms3qS5J?=
 =?us-ascii?Q?hcHp1NQUb4VRjJCYN76oIKsI4pUCEEUleWid/yUwYpKWzEMb+QkbZbKgLcsj?=
 =?us-ascii?Q?cqeIKOzGYtoZETkZCzbrn3wAZUgypXCHiE34iLrbJtXhPvirrPTuLce0rM/M?=
 =?us-ascii?Q?Q6lWPNPrZxpPuEf+d1urWw3q9PnulQOx/FcapRK4Ns4VaIWIFKy0NH8LQA4R?=
 =?us-ascii?Q?ktSyqmz9n1Ku8ZM0JwH7zDdTmswvS5XGfSH3GqMRAFpkPvd09YXFUY9Ol9vn?=
 =?us-ascii?Q?7hYSOQv8IEcAMqnW25cWRUOvNl+dnUwU/ejQnOvrGJMSKA3KCL5zlrYMsSin?=
 =?us-ascii?Q?f/m/Zi41IZTGnj+4EHCVseL33TzyvuwoNEb8tEsCHhA1jyZ+3UX2/vbUpoZq?=
 =?us-ascii?Q?y5qL1ml7fuL/B57ZmPiriUBnCu9VqpHF/n17kj8okBObSGUTQIigwRb1kbtT?=
 =?us-ascii?Q?nJBh/T3FKqOIDd8g01fiiYe0i3vSBsWwTBK9/pyJeRhp+rBpfy2kHBMCQc3h?=
 =?us-ascii?Q?Kk3If+KXQQJcNgq+nP7gMVR1tVwNbxShCVLrbNQozzHU4uvbkF/x6EK5Iykp?=
 =?us-ascii?Q?Kxsx1NT3wSeJ0QcJ440BBoLDqOnIXPR8f3KiUeDod2VNMDnAtfEJSnUoRk8x?=
 =?us-ascii?Q?PGoulnxKOxIe7KvYvU/PDmEtHu+yfShLMhYMVGMmwZ1dasuFr0ArCikxSmhi?=
 =?us-ascii?Q?wJ5U4USAm2g44CvJbv2lgvdTlE9oipJEFbvZDnR/17bXDVj9d/qIpWjFdSo5?=
 =?us-ascii?Q?h8MNCIJt02+CYUAlPHPyL2ZxiTPsdK6CoWpIBOEIbPKv4AusGC8PYXjkON4E?=
 =?us-ascii?Q?JAo9SIHKAIIjirTUUT/IdedMLfd3rW5k7oo7cmqByiFybDJUqR7c0GuKk9Wp?=
 =?us-ascii?Q?QLgOLwmCBBU7EMlc+oRBLRBKweDGf00l+YcMzCT9lHGuWuik/RC2QISZtIEW?=
 =?us-ascii?Q?65nHDKns5L/CXoeo3ftjVaLJaT0K2xEEbGT7AIY46HoaWhAMQ4SGNaWBDHBu?=
 =?us-ascii?Q?+2jNHeouGsTSISIZ61l1SoP9sXTOoDt82USi5k8N9LTfMhSWDL8vak9cEAhS?=
 =?us-ascii?Q?mde9dw5u93+s+E8m37byEpTXuubUgbchndnbqojHE34Zv6YA1dz4i2pDQs4l?=
 =?us-ascii?Q?PjCOmCBUyn1SQj+2fBySa8AmX2NAFD3O1ZaCK7ah+efQFQDL364+pORlbnas?=
 =?us-ascii?Q?JZSNWdo7s62E3wGvmM8YqMKqIW5cadkniZjiqucFvHlDqSH/ryANu/NdzDtJ?=
 =?us-ascii?Q?Eb440x5+eRokczyzzR6YLHGDdySU9kbtZp9Eak9MMN23BUa+clDUf3+n/cHI?=
 =?us-ascii?Q?G/59ZtbOFeXceQvNhvF0hvvUJKaU5thFNNemkNhNkGRZUFh2zZrohxosudDU?=
 =?us-ascii?Q?/w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c58560b-8208-4b24-7417-08da68be4a2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 13:06:12.3223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JiHFw4GTeRLBs1+xoetF4Xsx+9E+XqPktF5Geufo6JzKQ9gUB2fyMWb5xEOmU1wU884Nd2zbujnf3GCpEAuClYP6ZrX0UoyV2twuwFwxnns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2816
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

Thanks for the feedback.

> Subject: Re: [PATCH] spi: spi-rspi: Add force_dma variable to spi_ops
>=20
> On Sat, Jul 16, 2022 at 04:39:34PM +0100, Biju Das wrote:
> > On RZ/G2L SoCs switching from DMA to interrupt mode, causes timeout
> > issue as we are not getting Rx interrupt even though SPRF bit is set
> > in the status register.
> >
> > But there is no issue if we don't switch between interrupt to DMA mode
> > or vice versa.
>=20
> So we need this for correctness until someone can figure out what goes
> wrong :/

Yes, I am in touch with our HW engineers for the missing interrupt when
we switch from DMA to interrupt mode. I will update you once, I receive the
feedback from them.

>=20
> > Performance comparison between interrupt and DMA mode on RZ/Five SMARC
> > platform connected to a display module shows that performance and CPU
> > utilization is much better with DMA mode compared to interrupt mode
> > (1->65 fps) and (98->8%).
>=20
> How does that look for something doing lots of short transfers (like
> register I/O for example), and what's the throughput like?  DMA probably
> is the most sensible default even so since the impact of doing PIO for
> large transfers tends to be so bad, you have to be doing a *lot* of small
> I/O before it gets to be a problem whereas basically any large transfer
> will notice PIO.

Basically, this performance measurement done by running LVGL on RZ/Five
Connected to display module ili9341 by SPI interface.

Currently we are switch to DMA mode for transfer length greater than 8 byte=
s.=20
Since we have an issue with DMA to interrupt mode switching, initially we t=
ried with PIO mode and fps was very low 1 fps. So we switched to DMA mode a=
nd it shoots up the fps to 65.

Similar experiment done on RZ/G2UL connected to PMOD spi flash. In this cas=
e

1) The number of interrupts with PIO mode is 6 times greater than that of D=
MA.

2) The rd/wr test with DMA mode takes 3 minutes to finish whereas with PIO
mode it takes 4 minutes to finish.

>=20
> > This patch introduces a variable force_dma to avoid switching between
> > DMA to interrupt mode for RZ platforms.
>=20
> Not that it really matters but it's not a variable, it's a flag in the
> device configuration. =20
OK.

> I'm wondering if we might want a way to override
> this at runtime in case someone does have an application that suffers
> badly from being forced into DMA (eg, some IIO thing), that could be done
> incrementally though.

OK. Sure.=20

Cheers,
Biju


