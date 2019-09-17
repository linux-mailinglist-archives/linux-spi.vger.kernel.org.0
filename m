Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14258B500D
	for <lists+linux-spi@lfdr.de>; Tue, 17 Sep 2019 16:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfIQOLV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Sep 2019 10:11:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41003 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfIQOLV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Sep 2019 10:11:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id h7so3318863wrw.8
        for <linux-spi@vger.kernel.org>; Tue, 17 Sep 2019 07:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Z6VrYNesVKMXJ+ulzIbEsB6YF+R/fyaC0hYVzmRgjEU=;
        b=TYmeD0Xlf52MIkWG8R8WIJ7lZz9MwhhLj+MT1AJ8zWHj9x1B+ORaEdI11YZB1cV/KP
         Q43MgenEWbllJFTHX/xauVLsvP2zqxkJXxjK+m3iYnul8QTD6Xq/RpNrgbQmHMGK3Bly
         fWs/YCjsvy55FV7DMdlA5l1TE1Rbj7CChd/0uBsSxBPiGV5viVDgTK4R5EjIIFlGlSnC
         Jsw9uCVAS8CNYfk9RbRdwon/Ssof/GXNeYwZIsMrfJ8I6HYeGN2EGVZZ/OKflbvY3m/E
         Fqq2RpyO7FDMAqnU06Zb/PtQ5hcexCpnLCllq2OwkwCH3DUuLA4ya2v36P7TncDMrKfj
         hXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Z6VrYNesVKMXJ+ulzIbEsB6YF+R/fyaC0hYVzmRgjEU=;
        b=R+nM6rysLuC3BGa+A7/1LAcppMJLJCstakJ2wwTfVRPXcwuNEEdfqHwaC6iTadZADc
         14RDsJU80n+PFvptPx3ES6JF/UAAg/oac9IfT6NLimOf77F8XndDiSkDZRGYnOPgxkUf
         9ENRfhtsUyERIl3Fx9IEYM0SSpknq5975jBvUAxsjz2H/BDLksuJmoKeANTGXygVKuzp
         vCDhEMB3fNnF2xBNuar8scMWdtEYreUyUpSaxjujKVqwXv2ZM46NIc4hqpg4yrcOsPSm
         MAnMcZMT1daYxKnfs0guUeeQVhVp6v0Kn8aSA83DBDVl6mOyqL8EkJdgvchmckjo3U2m
         WArA==
X-Gm-Message-State: APjAAAVJSQFeEhBC9GTS41SO3SMir5GbO1edKhxFJ7iRqlcqWNbZiqx9
        OC2QsGmykdaHd8BbMQRluKj5zw==
X-Google-Smtp-Source: APXvYqybEIGjc3b1spUt+GGCetbHRNtPijTdAl9qvfY4a2Gv0hS2ZMdtaN0aUZ9iyLtr+zebc9MUzA==
X-Received: by 2002:adf:fc0e:: with SMTP id i14mr3303400wrr.302.1568729477864;
        Tue, 17 Sep 2019 07:11:17 -0700 (PDT)
Received: from localhost ([195.200.173.126])
        by smtp.gmail.com with ESMTPSA id r18sm3800225wme.48.2019.09.17.07.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 07:11:17 -0700 (PDT)
Date:   Tue, 17 Sep 2019 07:11:16 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Aurabindo Jayamohanan <mail@aurabindo.in>
cc:     Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: sifive: check return value for
 platform_get_resource()
In-Reply-To: <ij_UksEXUomr_L7KQam02lHBryAppgwKDjG90VbVcRRUeXlKU8TAiBWc3aU8vt20Wvlwt_6NDgz5fuMSwwP1mm-1eP6GYWoR1Kbr0y0ElRk=@aurabindo.in>
Message-ID: <alpine.DEB.2.21.9999.1909170709070.8198@viisi.sifive.com>
References: <20190917085627.4562-1-mail@aurabindo.in> <CAMz4kuJczzjTPSohQ=kbZ0Pr7U_9-hzXk-jPgKk79PENOM1-dA@mail.gmail.com> <alpine.DEB.2.21.9999.1909170514130.11980@viisi.sifive.com>
 <ij_UksEXUomr_L7KQam02lHBryAppgwKDjG90VbVcRRUeXlKU8TAiBWc3aU8vt20Wvlwt_6NDgz5fuMSwwP1mm-1eP6GYWoR1Kbr0y0ElRk=@aurabindo.in>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1565122568-1568729476=:8198"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1565122568-1568729476=:8198
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Aurobindo,=20

On Tue, 17 Sep 2019, Aurabindo Jayamohanan wrote:

> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original =
Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> On Tuesday, September 17, 2019 5:45 PM, Paul Walmsley <paul.walmsley@sifi=
ve.com> wrote:
>=20
> > On Tue, 17 Sep 2019, Baolin Wang wrote:
> >
> > > On Tue, 17 Sep 2019 at 17:12, Aurabindo Jayamohanan mail@aurabindo.in=
 wrote:
> > >
> > > > platform_get_resource() may return NULL. If it is so, return -ENXIO
> > > >
> > > > Signed-off-by: Aurabindo Jayamohanan mail@aurabindo.in
> > > >
> > > > -------------------------------------------------------
> > > >
> > > > drivers/spi/spi-sifive.c | 6 ++++++
> > > > 1 file changed, 6 insertions(+)
> > > > diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
> > > > index 93ec2c6cdbfd..67485067a694 100644
> > > > --- a/drivers/spi/spi-sifive.c
> > > > +++ b/drivers/spi/spi-sifive.c
> > > > @@ -308,6 +308,12 @@ static int sifive_spi_probe(struct platform_de=
vice *pdev)
> > > > platform_set_drvdata(pdev, master);
> > > >
> > > >         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > >
> > > >
> > > > -         if (!res) {
> > > >
> > > >
> > > > -                 dev_err(&pdev->dev, "no IOMEM resource found\\n")=
;
> > > >
> > > >
> > > > -                 ret =3D -ENXIO;
> > > >
> > > >
> > > > -                 goto put_master;
> > > >
> > > >
> > > > -         }
> > > >
> > > >
> > >
> > > Seems unnecessary, the devm_ioremap_resource() already validated if
> > > the resource is available.
> >
> > Just doublechecked lib/devres.c and I agree with you.
> >
> > Aurobindo, is this a patch for a real problem that you've encountered?
> >
> > -   Paul
>=20
> Geert is right. I was just breezing through the source and found it odd s=
ince
> I noticed other instances checking for return value. Apparently none of t=
hose
> use the managed api.
>=20
> If you didnt already do Geert's suggestion,

Mark Brown is the maintainer, so he'd be the one to apply anything=20
touching these drivers.

> here is a patch:

Could you please send this as a separate E-mail?

> ____
>=20
> spi: sifive: use device managed api to get plaform resource

"platform resource"

>=20
> calls to devm_ioremap_resource() preceeded by platform_get_resource()

"Calls"

"preceded"

> may be replaced by devm_platform_ioremap_resource().

Please explain why.  In this case "removing boilerplate from the code"=20
seems like a reasonable explanation.

>=20
> Signed-off-by: Aurabindo Jayamohanan <mail@aurabindo.in>
> ---
>  drivers/spi/spi-sifive.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
> index 93ec2c6cdbfd..c0925aa98aad 100644
> --- a/drivers/spi/spi-sifive.c
> +++ b/drivers/spi/spi-sifive.c
> @@ -292,7 +292,6 @@ sifive_spi_transfer_one(struct spi_master *master, st=
ruct spi_device *device,
>  static int sifive_spi_probe(struct platform_device *pdev)
>  {
>  =09struct sifive_spi *spi;
> -=09struct resource *res;
>  =09int ret, irq, num_cs;
>  =09u32 cs_bits, max_bits_per_word;
>  =09struct spi_master *master;
> @@ -307,8 +306,7 @@ static int sifive_spi_probe(struct platform_device *p=
dev)
>  =09init_completion(&spi->done);
>  =09platform_set_drvdata(pdev, master);
>=20
> -=09res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -=09spi->regs =3D devm_ioremap_resource(&pdev->dev, res);
> +=09spi->regs =3D devm_platform_ioremap_resource(pdev, 0);
>  =09if (IS_ERR(spi->regs)) {
>  =09=09ret =3D PTR_ERR(spi->regs);
>  =09=09goto put_master;
> --
> 2.23.0
>=20


- Paul
--8323329-1565122568-1568729476=:8198--
