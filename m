Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584FF7337A8
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jun 2023 19:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjFPRx5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jun 2023 13:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjFPRx4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Jun 2023 13:53:56 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF471FF7
        for <linux-spi@vger.kernel.org>; Fri, 16 Jun 2023 10:53:54 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686938033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XmhN5JRzY69CGdUvuK+TfZcqXireG7UwM6MpdwGB5o8=;
        b=JymDD+gVHVkPb0shdZZH2+zOY35/cNke6JSaWPIPzdfP1IEa7ShSf4KkBxLj4HclKXsOOD
        Y1BuHgDiMLyVxxRaFs+ZpNdHUvSqdH2V0s2g2RoOiq9eXjOVyfpmqjYHydKSnt7p80y6aN
        FoaJOq6cl2lfBOQg6RfrF1T6PWiXEbhl9Bntxhw2EIEzf6vH8O/Sfw5nHAs9Jf8DNY5riV
        G3y7SrIMxZP29KqrDQapXZ+dDzO237kL5h5oeBWZ2a6L9+3ZDlCQQL7vzkaX34ysOEA/ZI
        jl3MJZt1tbZ07Epmr1FZSnfaFJpqykXxR9q79f2ZvW86y6br/t8qFJ3/4w3AGw==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D7514FF807;
        Fri, 16 Jun 2023 17:53:52 +0000 (UTC)
Date:   Fri, 16 Jun 2023 19:53:51 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        linux-spi@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] spi: atmel: Prevent false timeouts on long transfers
Message-ID: <20230616195351.4976b702@xps-13>
In-Reply-To: <71245a47-5c7e-4ff4-80c3-3b2b4d3642db@sirena.org.uk>
References: <20230616141225.2790073-1-miquel.raynal@bootlin.com>
        <89439569-4fc3-4f5e-9392-4ed92ecb62e5@sirena.org.uk>
        <20230616181535.032bf9de@xps-13>
        <4054360c-b942-4761-a03f-e4d50a328ec0@sirena.org.uk>
        <20230616185906.04c4a869@xps-13>
        <71245a47-5c7e-4ff4-80c3-3b2b4d3642db@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

broonie@kernel.org wrote on Fri, 16 Jun 2023 18:43:51 +0100:

> On Fri, Jun 16, 2023 at 06:59:06PM +0200, Miquel Raynal wrote:
> > broonie@kernel.org wrote on Fri, 16 Jun 2023 17:43:06 +0100: =20
> > > On Fri, Jun 16, 2023 at 06:15:35PM +0200, Miquel Raynal wrote: =20
> > > > broonie@kernel.org wrote on Fri, 16 Jun 2023 15:20:27 +0100:   =20
>=20
> > > Like I say we should know the transfer speed so we can do better than
> > > 4ms/10k - we know how long it takes to clock out each byte, we can ju=
st
> > > multiply that by the size of the transfer then add some fudge factor =
for
> > > setup/teardown overhead.  1s feels pretty generous too.  The sun6i
> > > driver for example does  =20
>=20
> > >    max(tfr->len * 8 * 2 / (tfr->speed_hz / 1000), 100U) =20
>=20
> > > and just doubles the length based timeout with a minimum of 100ms whi=
ch
> > > seems reasonable. =20
>=20
> > I already had issues with ~0.1s timeouts on NAND controllers, just
> > because the machine was heavily loaded. I believe we should avoid too
> > small timeouts, it does not make sense and make things worse under load=
. =20
>=20
> Well, we can raise that minimum if it's causing issues - 500ms say?  1s
> does feel a bit extreme for short transfers (and note that we'll use
> more than 100ms for long enough transfers).

Sounds reasonable. I believe it's worth the try.

Cheers,
Miqu=C3=A8l
