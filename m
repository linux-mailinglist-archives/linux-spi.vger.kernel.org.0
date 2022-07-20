Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A6857B03E
	for <lists+linux-spi@lfdr.de>; Wed, 20 Jul 2022 07:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiGTFOD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Jul 2022 01:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGTFOC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Jul 2022 01:14:02 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2129.outbound.protection.outlook.com [40.107.114.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114E44AD65;
        Tue, 19 Jul 2022 22:14:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2MvdCNAZBNC+A2bQeSe5Uav6pG0oYEdljH6vLQDkdQRrimc/+7nJ3bCN6xJpBL6kp9h/xwG9A/xtnyUZptKZUxgr5SR+JEY/VyksautMJQ6AbDkEmv495+3kQyZRoi84NNVQBY3wlIb6HFRBURrWibmXRYCGyrUKb3IQO9SD/YmfyyLEFjX252NNnnQy70uy1kC4SABrshyuUh5+8YYnGtsO/AhaUj55IYoJpNIR9/I1+yRvQBNs8dJRMLCwFkvBhyq0dsxc7Pxyleh2c7mhoHWbh3Y+Lu8OCVG+QSRb72bo4FZnhQURTCDhEXkV8cYr+fMNJbcG02ouMhE85jUow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHKRuYhKW4n/712ZB3k58dTyB9VwpU60GO+peKgiaZc=;
 b=EG592+XIdfoDFKi/MksL45UTeXuRt2IjmcZYuPzQExnSnzLG8IPwfcySECOqVEcz2R/sa7vX2Puwl+AqR1y/4dTeo1xS3pznrjkhiZSAoH5gtDxNUZTuj26Hpgw/cOki42++WxrFlU7tyCUww6DlfUuuvvfaMLfUGdlEMNPFRaJU5QftaEOgAmyAedkh8TN0lfuWw7mLmGgCt6TzzWO6CkYp+DszRTLnjgrMrEGoQVn244Oj50mhrUv5pCTLBd3nlVcqDvc+R39+Uaq2UwIhnYBp7S6j5KNWFnlYiS4uue+1RLwEyJqMAw6Nhug7p4QAEB+37nnSQrsdyrQGUQxaNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHKRuYhKW4n/712ZB3k58dTyB9VwpU60GO+peKgiaZc=;
 b=vYE7ZEFG8bylEmufgYLL0uOw87K0XloFzNCLTX2WUz98PnMb6Hqo3CwX8T7Jks10VgKM57shXRhVa+w7XIlUBoki0hEriscRG0Ds8OgyhmYYGM7rboM71TPswa8DkELWx9R8zcNERmvkDRGRvGx+3xXotRt3EtkOhFc5rT0jveg=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYYPR01MB7711.jpnprd01.prod.outlook.com (2603:1096:400:119::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Wed, 20 Jul
 2022 05:13:57 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%4]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 05:13:57 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>
Subject: RE: [PATCH] spi: spi-rspi: Add force_dma variable to spi_ops
Thread-Topic: [PATCH] spi: spi-rspi: Add force_dma variable to spi_ops
Thread-Index: AQHYmSpFDIO6jbtkAU6yW6fT0KKX0K2FW9cAgAAB/jCAAAZhAIAAK6zggAEqbgCAAABdIA==
Date:   Wed, 20 Jul 2022 05:13:57 +0000
Message-ID: <OS0PR01MB592241E22FCEA9084FAAD24C868E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220716153934.292311-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdWqfnpN_FWyLVb+KGmgR+VY4GJ67Sk2xSAb18HK_B7WZw@mail.gmail.com>
 <OS0PR01MB5922FC0E3C336E727084C96B868F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdUJzNkf+n5VLzEZTzUpChz9T4Yn-Hpq01sVBRMk3-c2CQ@mail.gmail.com>
 <OS0PR01MB59220A67C039CCBF7D4D4AFE868F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YteNFrNSsEfLDHR/@matsya>
In-Reply-To: <YteNFrNSsEfLDHR/@matsya>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df0278bd-5786-4141-23a6-08da6a0ea61e
x-ms-traffictypediagnostic: TYYPR01MB7711:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 03L7AnPy0+D3m4Wr0r0TzRLc/LFqKkABYrfDIxn6gy4zjp0SWYDfWC711GcVL8lkOeDLogEg2GXzvysj+leetWl7AF003M/FJINXtWadD09YI73kntS9kcB13xa3gxJhzxhz3ZXYxVN8hrtcEBP8QKCigmRumtTChhinjmJe3LuoRPm/7Fq7TzsUCw/5YmBGNsgcur7qVGGCzLUBpYwbxdVcvcjPxGtgPQDZ8ugNC25/xqAIoMEXEKLKT46np9YmS1EqbFj+dTY8l0sexNPqK7Whf0lhM2kbqko5hjfWeizn7kmlhEcufoZ7Y19QgUBIP5zU5m0B5ycdginuvkagnzmI+PVwzfCEBZ4VUQmRX1+1N5HHRn941lHaNpIEU4nKbIuLZzf+lkbVHfTmVXsX2fppLQ+qDGzc6WpJHN+4F4RdlqCHee0DSH0G9oYnrN7BvXIZOJ8e75hzKipFjf8Hq+ufxfDS+OL47YXEEkIicAp6md75ox9PJ+BT7ML2jB4TfT2hkKclFYCcta8iSNxAMrkkaiE7k5WAI+mZUS5G6CQOnBhbCvV9RGqKi8kWs9/FpACcCh2u1yIgVLNDLr1rt8EFp4IfSbtYT/6r0CMbRI1awzW7PzING/Dl52CPKH0DjcBIZFDyarmYyzNrS0AklBTXB5PRt0kZNhNI/27b3LTyVrZfu/2KY9TmJzpRkEE+s1iaHeIo/Yjtgdr1pFdm+n67YUvpJ4tR0N1Zqynxwl+UxFWKznYOgS2SzrGVMJzuiRj3w1Sdng8Ufjdq4WqjtxdKPDT1aotZySxKGX9MDhtj9DLXHCDptqTAsXrWtGU5jB1rKYmjPyHNcY4Fbqb4Pd0rVNIpeV4pcXPJqjt0/vGTYM2TEKYZdCUeupW3oa/S
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(83380400001)(5660300002)(38100700002)(8936002)(38070700005)(52536014)(71200400001)(478600001)(122000001)(2906002)(66446008)(54906003)(66946007)(8676002)(76116006)(316002)(6916009)(66556008)(64756008)(107886003)(186003)(4326008)(53546011)(6506007)(26005)(9686003)(41300700001)(55016003)(86362001)(33656002)(66476007)(7696005)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WCbyZkUO/yD8ejBUl7SG39+mgXrdu90Afjg562xjQHMp1Tqkr9Nm1LTqxfrJ?=
 =?us-ascii?Q?fNj3NIwfNueFxUk+MEPlFOWq2/TnNCp4zRCcxVTgD267VRPjIKxp22Nhdg0x?=
 =?us-ascii?Q?UsVWvBQsolJ8M/tgBWp6BZ5V87DY5epS/slISzMyOKL0Zf+C1UIH7gzSxY7a?=
 =?us-ascii?Q?ZzUZaiiGvbF91Qt355awAgfuTQOj0APK/CE7kqOWVQOhpojNbz6S0iA9KWrF?=
 =?us-ascii?Q?t8sV6GsEOAz6R9U5HsWwLpiPFgrRQdNE03+75xymwtr4sVV3L3mIbyQW6GCk?=
 =?us-ascii?Q?IXxEKNPY5JDr9oUbrV1fuauKJd6O1m4GqgIq3nlLbSRzeKKcNFRJbEvV4fRN?=
 =?us-ascii?Q?AK8DMmOcuER+gkwt4xfZkho3UDNkkKCCaizdgHVm7Kw4zI3hEt3p/Kt6Nh83?=
 =?us-ascii?Q?b5cz5Ut052osAyu9oKWeArzswSScEdpEUygaij2az0+BcqINayRQax7DSI5H?=
 =?us-ascii?Q?p6SIO4XfVQ7LoYD1uiJHYaZr88xviEXHSFA50yr+Ai9ZzBQ1eUubCqmlMUTv?=
 =?us-ascii?Q?HH82LaHJD/stwy1O52+DF3dnn3MUy2dy7866m6LWMLp3fiMAmbFmarvqlPjP?=
 =?us-ascii?Q?gVieFP6djvmcmr/c0FKMyHZSbZPr2jxAwnxgAY6OY6yRwdMHR9yFPt3VdVSp?=
 =?us-ascii?Q?pXaT49d4oBD9uG/gLKaD0RA7d4j5PbmeEb3MjtnF2F7cQKyS0lU+AwOU/wFg?=
 =?us-ascii?Q?W/lC7tz7NLxgIaLiVa4wyo1yL21CUjVt+hmT0KgAGOtpksk27rOzGykUVP00?=
 =?us-ascii?Q?tWVYQAqC8h0bpK7/zqhdBXeXQUD5dB+3NPAGWW3xGBbSKcO3f7XsOTqJPMzg?=
 =?us-ascii?Q?az6uTaQpDXGSwRT/x0FoD88DHMfqd5tmftQSNjhO/IXbsWO8NzaSIanaDD5f?=
 =?us-ascii?Q?YZT+H4M0uP9Av2lLgiwjgS9vSiLjWewgCW1I1JJfrCEAMv8Kl2ZrBi2PvjIX?=
 =?us-ascii?Q?b9QmEbr9xBg8ALUvLJPmx89RmSgj8JrDr/8Ufn4QbcAKEnWR9mP1v+hEkNK5?=
 =?us-ascii?Q?bqvMoz/M4kGCV9pRrbNe4e6siq70b4xFXLGWk4VEblx5gQCBs9Ig3tOd1azq?=
 =?us-ascii?Q?b4dmPPtRg4awKlMJKj8DI0p48z4FxNFc3nWcMnLzq4La8if5kCDs50HWZGQ0?=
 =?us-ascii?Q?E8P9aJsHZrVy3AdkR3Yv3aDuvPmwYIj/RsH0ukWVweAznpOcaEa28kAowMYF?=
 =?us-ascii?Q?h+kJx1lk3+ujU7l2ix2AWVXAovEVFwmlJuJsYlMvu1GArYJYp2QsNGZJkF2H?=
 =?us-ascii?Q?RD4qyEwgMfoweoOrJ1FcQ/eLdO8OisbytN/wr+GMdkJ3W4EwgDrV8iI5c7Oj?=
 =?us-ascii?Q?JrgFA4jW9xKqTdWjLidazbuOqs0VFWiDSBcpPG1zjNZtxr2uJdTJwzQ/9luw?=
 =?us-ascii?Q?5dDRHDLeUVnvIw4LWdc6ZRblDOf8bT2V//9e9AoE0TeFWP1yDe2hAgZw+ma7?=
 =?us-ascii?Q?Ts1OHxEhTrh0r6zFpc4FhXsRXP4auzytOdFmfP/9ZTSdVXkiNAoSHHPmHyZs?=
 =?us-ascii?Q?3FZT4gUuJz5QcA08bbXFCqNzPkBTFtlotYYLOQ2XsNTwuIFwOt5h5JS0HAX4?=
 =?us-ascii?Q?NBVr0TNplMLbzic7/HJ4qwQRCTt2rQSDXyuMohFoCG8uVd57fvboQjqd3Fse?=
 =?us-ascii?Q?OQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0278bd-5786-4141-23a6-08da6a0ea61e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 05:13:57.4957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5jxi0VwMGlw5Iklv3xNvSor9SUCIJqWWjr58rfpOWqoqkDG9pL/A1wsl8LRYoMKe1uecY0VO7rj3Td+FTXej5K27MSVoI73CH3R5J1K/APA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7711
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Vinod,

> Subject: Re: [PATCH] spi: spi-rspi: Add force_dma variable to spi_ops
>=20
> On 19-07-22, 11:28, Biju Das wrote:
> > Hi Geert,
> >
> > +Vinod
> >
> > > Subject: Re: [PATCH] spi: spi-rspi: Add force_dma variable to
> > > spi_ops
> > >
> > > Hi Biju,
> > >
> > > On Tue, Jul 19, 2022 at 10:29 AM Biju Das
> > > <biju.das.jz@bp.renesas.com>
> > > wrote:
> > > > > Subject: Re: [PATCH] spi: spi-rspi: Add force_dma variable to
> > > > > spi_ops On Sat, Jul 16, 2022 at 5:39 PM Biju Das
> > > <biju.das.jz@bp.renesas.com> wrote:
> > > > > > On RZ/G2L SoCs switching from DMA to interrupt mode, causes
> > > > > > timeout issue as we are not getting Rx interrupt even though
> > > > > > SPRF bit is set in the status register.
> > > > > >
> > > > > > But there is no issue if we don't switch between interrupt to
> > > > > > DMA mode or vice versa.
> > > > > >
> > > > > > Performance comparison between interrupt and DMA mode on
> > > > > > RZ/Five SMARC platform connected to a display module shows
> > > > > > that performance and CPU utilization is much better with DMA
> > > > > > mode compared to interrupt mode
> > > > > > (1->65 fps) and (98->8%).
> > > > > >
> > > > > > This patch introduces a variable force_dma to avoid switching
> > > > > > between DMA to interrupt mode for RZ platforms.
>=20
> Why do you need a variable for that, if DMA is availble (you were able to
> allocate channels) then use DMA, otherwise fall back to PIO..

I was using DMA. We are not getting rspi interrupts after the DMA to PIO sw=
itch
because of [1]. ie, we are not clearing DMAR in DMA driver
and interrupt requests to the interrupt controller are masked.

[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/2022071915=
0000.383722-2-biju.das.jz@bp.renesas.com/

>=20
> Or anything missing from context which I am not aware of?

After this discussion, I have posted [1] and [2] to fix this issue.

[2] https://patchwork.kernel.org/project/linux-renesas-soc/patch/2022071915=
0000.383722-1-biju.das.jz@bp.renesas.com/

Cheers,
Biju


>=20
> > > > > >
> > > > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > >
> > > > > Thanks for your patch!
> > > > >
> > > > > > @@ -1196,6 +1197,7 @@ static const struct spi_ops rspi_rz_ops =
=3D {
> > > > > >         .flags =3D                SPI_CONTROLLER_MUST_RX |
> > > > > SPI_CONTROLLER_MUST_TX,
> > > > > >         .fifo_size =3D            8,      /* 8 for TX, 32 for R=
X */
> > > > > >         .num_hw_ss =3D            1,
> > > > > > +       .force_dma =3D            true,
> > > > > >  };
> > > > >
> > > > > Do you know if this is needed on RZ/A series, too?
> > > >
> > > > I guess it is needed?? I may be wrong. I got a link from Chris
> > > > [1]. As per this still We haven't found a solution. May be the
> > > > priority is changed for this activity and no one looked after this.
> > > >
> > > > [1]
> > >
> > > Daniel said he found the issue, i.e. the dmac driver never resetting
> DMARS?
> >
> > Currently DMARS set during prepare and it never cleared. So I added
> > device_synchronize callback in DMA driver to clear the DMARS. RSPI
> > client driver after synchronizing DMA callback, calls
> dmaengine_synchronize which clears DMARS.
> >
> > With this DMA to interrupt mode switching is working fine.
> >
> > Cheers,
> > Biju
> >
>=20
> --
> ~Vinod
