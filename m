Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012DE57A27F
	for <lists+linux-spi@lfdr.de>; Tue, 19 Jul 2022 16:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbiGSO5O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Jul 2022 10:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236084AbiGSO47 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Jul 2022 10:56:59 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2138.outbound.protection.outlook.com [40.107.114.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9083549B73;
        Tue, 19 Jul 2022 07:56:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHc6qdE/XvKibFc+AZR5SrZuke/vdhoRUxIQ8GyPiLA/X9hlh3b1dIggkLg6zMvC9MGOLjzfW3g9XA78qqULx6A1Nd5F4dPdiAWWI04nOy/IsgiH4EL0Ynkx9mHMP/cjSQ91dOwFENc0BAM4ROgsy2dS2pYJClxQDXC866TC9s8UD78QyYodAShSFcJTqfL7Er/ZI5zd5/VeD2y3Eir5kg91U5PM4RjaxIMcrmYPSyuVuJOBgEjWUMf5HqhpFOvfQGClylph70ixWQUSGkDiI7FAJZd32REwl35dII6/uEImozSOPmQpaQtcj1TRFYsF1B4pMdfA81u7vLiE3UJKfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgR1pddceAnX/tbVmSN/2YtRNWommPD15IAwQQe5qNk=;
 b=oNjqkE9nWqzsv8hbr6VQpBehtj2ieWBw+xbkHXF3yARRjiKz6jlnJIUrUSMBtdFX9QgmJSmSwSVtBuSNr4cT4bneDmJ+18zX/IfM8W5kYvB+9/z1TZEXWFwuBto0ipIl+eomRr7yQ3Q2OIvJbgu70XTiOXpm3XCfh/KtgeTpNVd/lD9I0mOmGHeycGS5S9BWqTTOGTc+95XCIQ5JyYIg2WICcFWvKg8RnBVSTVpP9Y9r3tde/an0oE+Pt/8D3OZJvfMoUynugZ60l8z8UZr7F1zmFEeQpOwsbOt6SDmU7NrXQ6KvT+JrJxjRT4BZ3tZZK7J9yvAWe6FWh1sMZ6O8Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgR1pddceAnX/tbVmSN/2YtRNWommPD15IAwQQe5qNk=;
 b=cHM8mUNPIvMWbiefbdLO0woLoxYkbDdcoSJo+jZ5fWL48YVrwplQKMfNuKKnZ59GzH2KxvJSAUpw9BpKa4Dd+MAj9Qu3W4GD3wguDCZCZrmcLmK2HCigOXXuYidfx+qTOyVbMs4uX758YrrLgtOGaqP/IROPQ8XzgaQv6oggFIs=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYYPR01MB7999.jpnprd01.prod.outlook.com (2603:1096:400:f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Tue, 19 Jul
 2022 14:56:56 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%4]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 14:56:56 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Mark Brown <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 2/2] spi: spi-rspi: Add need_dmar_clr to spi_ops
Thread-Topic: [PATCH 2/2] spi: spi-rspi: Add need_dmar_clr to spi_ops
Thread-Index: AQHYm36584WnMm0+xkG1WsPNz2Lyvq2FyEGw
Date:   Tue, 19 Jul 2022 14:56:56 +0000
Message-ID: <OS0PR01MB5922B83EE67A0ABFD063CA22868F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220719144906.382548-1-biju.das.jz@bp.renesas.com>
 <20220719144906.382548-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220719144906.382548-2-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df096de8-d7f2-4b88-45c0-08da6996eccb
x-ms-traffictypediagnostic: TYYPR01MB7999:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JSnEhaaUbFOmbkaR1E++P1Hu49ulIsdM6LuodI4BiflddL/MIwIvEskRov95tDuCUII01b/+wolDpR9/bZQrwncKEBOvlZiNNCzY+tsJF/wxl196PKl0+Lx/enotRAUoSKyACIS+w4/4KeP9Spl7hsEchzN/QmNCDL0g+BMveixTiVHOi6eHQTm2IC7FilQ0qf9chTbQGMhvMzyqf1zt9fHkMENG8z9dvF56YhFntVJL5C3doYGQxVuRZqbGVioir7lqUgbahA46pfnnYaRGQfj5OJHzGSdIjTFpZZ6AakqdJDQHW7vmm3mTaTTYggvELyrgfFkBb2mCx+EqNuf6SpuwYp/xzcSznqLLnph7wIj7qeHPU+Sf9ViRaFFpyfC6jKWuG3SbFIFWcxtsN6a0NO1VuCoKIxeSKrG6DA6iYvEDQHU8UPCaatURGhNUSLrzp9Z0nwZZEnH4pNZ6aCGimIpaXGqA5QJm32dDqie4WA/eL39ek4bs8vbpj3TMf1t5iLgRsqXAn+hUuwjg/1ws+wED6gFcZh1U6LQWKlvh/xO0UydjYWlrjtc+bBadyZnvKd2nTEU2oHqpoI3TO+bji6aYKOTR+1a7z9DPRGNV4gygV8Oie1xwRcb/198rdaJFQIgLADRwz8lCsBZCMAy0EJdfvDHXBft6EUOjUmnG+aGxKHgIniHRLrTbo16CC/g4z2kh4PGHmJm0tc6uRNjqtJ9LYBsDQ9yvqfjkE2P5Fn1akpfdPMPxXtfaQfokkRHFvzYAylQuPF5i7qPdXaTJtzyohKmcuF+UEk2GhKE8whI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(122000001)(9686003)(86362001)(8936002)(6506007)(316002)(41300700001)(7696005)(52536014)(2906002)(5660300002)(71200400001)(38100700002)(38070700005)(478600001)(83380400001)(110136005)(64756008)(33656002)(55016003)(76116006)(66446008)(26005)(66556008)(8676002)(66946007)(54906003)(4326008)(186003)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ucwVSmXkHgvAvVMdt+jLWC4VcAZPIDDdWYERr5X0zApqM5CEUcljFQdMrecd?=
 =?us-ascii?Q?KqysMn4EZoiaHEyhVHS3+envQrNQfhoRCMpRc+emoGLAik4EoyEdxKJQEmvn?=
 =?us-ascii?Q?GlJb7UC4oNeeUXIcHlBVpe9zG5va2lod/9I7Afqnxm+RYK4jT0EO6QzYnMj4?=
 =?us-ascii?Q?b1ZRminNa6z1+e6FskHEw3giSUGyZquF31HpnCkgonq44T+Rw3qEqSQq8GDN?=
 =?us-ascii?Q?04k1gSGM7xY34UBWUfSB18lAhHgk+P8qNj+z57wHyOj0Z4D7Wn9+G/fGO4+p?=
 =?us-ascii?Q?O5UTLIzQUFMM5P3H3keepA7eEbeH78IbpZLOwaXgs4WQbvtkmyCnWOmY6iOw?=
 =?us-ascii?Q?Pjy25ma8xCIeXutPLYOmJhQxwAsBnlFd08xhEPxdyE6vfCfSJ+Oay/gBalfA?=
 =?us-ascii?Q?bh9BRE5cyxiNoZMqjtchMzNye8J3qFPtS7x2evhZZDMjMDumaYBtPU8S2FUV?=
 =?us-ascii?Q?Yr25VeBnnDPRwIsVTupEvXoWBbSq198W0ODQJVF3Tv7Q6Cy1QpP3jGt4aj3M?=
 =?us-ascii?Q?hPOFFxhL6TvGP+MfAzuUftMO0tXCSQfKnius2iqrDXhzMq6vexT+AqWlP7Lb?=
 =?us-ascii?Q?jeypJqWyVaFqctGlreZikHE3G6SpygLPiPCIuhvu5Hz0OvJU2SlZonQLrwAd?=
 =?us-ascii?Q?P6Vj3KuwuYExNYNJUJ9mCadlfUgUZl9vkYQZaN4LVRre8/11JUAjCsF+cOVw?=
 =?us-ascii?Q?MtOWwHvTZBl53vie3iBEBHMypgBYu9SR8u4ciNalFZEs0UGSifIKJs9YElGO?=
 =?us-ascii?Q?sRQqQJsqlhaD8T+6/81O7MRkdUjckfi+FOpVM1H1VyGD/DQeE926ArcMhlXT?=
 =?us-ascii?Q?XGvqJBh94j/5Pac+7TtzaVeZKTM+kb3fYZBtK4izwLdPRrXPdADNp8XaMFp8?=
 =?us-ascii?Q?ZAz7AsncGq6Yj4ILJ6CuwTMVbH54jnQaJ55BbCx9+jNZbMWa/TqWVfXcg5Kf?=
 =?us-ascii?Q?JVDpOZfYFprBgSiO49wZpE1XBW/3pxZmUXSE1rE1ksSGDRrEHwkikGtycgqy?=
 =?us-ascii?Q?qHzTlcodo+sLuo7vcGuqJ0RS4/9J+GcIWBfITTkyn+amZ2kHFCrlfl9I3C6M?=
 =?us-ascii?Q?K0LuROPvgNv6xYnIOlArXr0YfEdvngBbmRA9Fy4rPEKuvgxI0PWGxOYgFKmo?=
 =?us-ascii?Q?aY3sfGkpc5bPWxPfZ0+qMKwbXoi0rkuPieuVNOmGHPpIGWW2LAd5e+15d/Ce?=
 =?us-ascii?Q?kEnkesIYxHJ6QQZXH7pBxnB2ScAb5LFPLZMidN9kZCpuAGgWbT6S0pXBkAZa?=
 =?us-ascii?Q?ftn2eVbX7tmtGvcG1fV1tTFK3ACJqXF9psVWPbuV5JbIKm7daYg+JKNJGjyE?=
 =?us-ascii?Q?7Pc14q1UhbtTA6pGVjtLsftpqsN+yr7vX8kS87+iC7fibVyctj0vfDpD8NbH?=
 =?us-ascii?Q?tb/6XDQmbxEmR2P8nGfWpDECGsvedmG6QU2RwDITmcCIdmvxFQnEmYPAZKpb?=
 =?us-ascii?Q?ChvS1f3R//yRR1w7SCXLhfYffqk1R5HCn1c0fiQnmhohxA+AI3c5Yd3gZVwg?=
 =?us-ascii?Q?wTZwUv1EdGMWxPubZuhUOGfMXuA779YQLIiio5m6gyy4HHAtMcnkpSn+Iqcw?=
 =?us-ascii?Q?44YnOUTBbnccRuKtZFs7RCItYT5MhNxnKhQEce3InbfFSziNzAbeh/V6kBda?=
 =?us-ascii?Q?sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df096de8-d7f2-4b88-45c0-08da6996eccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 14:56:56.4789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U8JJMZOwUZcU6Io+9EYEqR0IodSUZ1iISX8aD0G5i1dN48jIa2CoQLR8X4Lv2eUoSRDP1YEFyoIJbX672DqGWorZfjP/0NhMVF//AgxDvkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7999
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi All,

I would like to drop this patch as I have sent wrong one.

Cheers,
Biju

> Subject: [PATCH 2/2] spi: spi-rspi: Add need_dmar_clr to spi_ops
>=20
> RSPI IP on RZ/{A, G2L} SoC's has the same signal for both interrupt and D=
MA
> transfer request. Setting DMARS register for DMA transfer makes the signa=
l
> to work as a DMA transfer request signal and subsequent interrupt request=
s
> to the interrupt controller are masked.
>=20
> Currently, DMA to interrupt mode switching does not work because of this
> masking.
>=20
> This patch adds need_dmar_clr device configuration flag to spi_ops and it
> makes the signal to work as an interrupt request by clearing DMARS after =
DMA
> callback.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/spi/spi-rspi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c index
> 7a014eeec2d0..8637be53bb8d 100644
> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -249,6 +249,7 @@ struct spi_ops {
>  	u16 flags;
>  	u16 fifo_size;
>  	u8 num_hw_ss;
> +	bool need_dmar_clr;
>  };
>=20
>  static void rspi_set_rate(struct rspi_data *rspi) @@ -613,6 +614,12 @@
> static int rspi_dma_transfer(struct rspi_data *rspi, struct sg_table *tx,
>  					       rspi->dma_callbacked, HZ);
>  	if (ret > 0 && rspi->dma_callbacked) {
>  		ret =3D 0;
> +		if (need_dmar_clr) {
> +			if (tx)
> +				dmaengine_synchronize(rspi->ctlr->dma_tx);
> +			if (rx)
> +				dmaengine_synchronize(rspi->ctlr->dma_rx);
> +		}
>  	} else {
>  		if (!ret) {
>  			dev_err(&rspi->ctlr->dev, "DMA timeout\n"); @@ -1196,6
> +1203,7 @@ static const struct spi_ops rspi_rz_ops =3D {
>  	.flags =3D		SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX,
>  	.fifo_size =3D		8,	/* 8 for TX, 32 for RX */
>  	.num_hw_ss =3D		1,
> +	.need_dmar_clr =3D	true,
>  };
>=20
>  static const struct spi_ops qspi_ops =3D {
> --
> 2.25.1

