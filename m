Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1EB79FF46
	for <lists+linux-spi@lfdr.de>; Thu, 14 Sep 2023 10:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbjINI7u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Sep 2023 04:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236624AbjINI7t (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 Sep 2023 04:59:49 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E330A1FC2;
        Thu, 14 Sep 2023 01:59:41 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B1746000F;
        Thu, 14 Sep 2023 08:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694681980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OJ4z2Gb0KptgoNfUT9OZZNooMDLvMmhtErYIxdhxYb8=;
        b=lnySrbnAZH83y3B6hI5qfEwR42Wat0GYBgiCKi8Ai3YXbPOC/m7mAR+9/wFBsbuQ9zhjWH
        m5HYL1/tTu5hqOikzBCl+OOViLmsh5IWkJXaeFhy53vUfuk74fENHKKH4J6TH9EQBxLvbR
        BOrcwpb17FTVQQG+MeB2S3kg+Pc6yiQR3SevphlU0IWig7aXOh8QIMxDOqTg8AqRH1gKoE
        ImYCsIp3YIbCI3Wj9WqefNYwvKz+57HrVhLkn39q/ILS5CFHC+lTviq4BlR8NIsIt09Oo8
        6k00RQNpTbgcLs3nXOB0guYkm9k83Cha+H5HsyDhgZCOwVlhbs9HLN0EzlHmww==
Date:   Thu, 14 Sep 2023 10:59:37 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH] memory: renesas-rpc-if: Fix IO state based on flash
 type
Message-ID: <20230914105937.4af00bf2@xps-13>
In-Reply-To: <CAMuHMdWO8EdbxXetmc9-2jhZWeX1b_J74O0exo1Q85X9Gbc_SA@mail.gmail.com>
References: <20230830145835.296690-1-biju.das.jz@bp.renesas.com>
        <CAMuHMdV1qvypo1XmHBXV5Q1SHEhksMN3SxgweYxPu+=ZeDmg1A@mail.gmail.com>
        <TYCPR01MB5933571F06789BFF27A8FCC786E6A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
        <502336e9-2455-f3f6-57d1-807bc4b71f7f@linaro.org>
        <CAMuHMdWO8EdbxXetmc9-2jhZWeX1b_J74O0exo1Q85X9Gbc_SA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Geert,

+ Michael Walle

geert@linux-m68k.org wrote on Thu, 14 Sep 2023 10:34:50 +0200:

> Hi Krzysztof,
>=20
> CC Rob, Miquel
>=20
> On Thu, Sep 14, 2023 at 10:08=E2=80=AFAM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> > On 30/08/2023 17:18, Biju Das wrote: =20
> > >>>                 regmap_update_bits(rpc->regmap, RPCIF_CMNCR, @@ -77=
4,6
> > >>> +776,12 @@ static int rpcif_probe(struct platform_device *pdev)
> > >>>                 return ret;
> > >>>         }
> > >>>
> > >>> +       if (rpc->info->type =3D=3D RPCIF_RZ_G2L && =20
> > >>
> > >> Wouldn't this apply to non-RZ/G2L systems, too? =20
> > >
> > > It applies, if the device uses the flash[1] or [2] and it needs
> > > 4-bit tx support.
> > >
> > > [1] Figure 20: QUAD INPUT/OUTPUT FAST READ =E2=80=93 EBh/ECh
> > > https://media-www.micron.com/-/media/client/global/documents/products=
/data-sheet/nor-flash/serial-nor/mt25q/die-rev-a/mt25q_qlks_u_512_aba_0.pdf=
?rev=3D3e5b2a574f7b4790b6e58dacf4c889b2
> > >
> > > [2] section 8.14
> > >
> > > https://www.renesas.com/eu/en/document/dst/at25ql128a-datasheet?r=3D1=
608586 =20
> >
> > Geert,
> >
> > Does it answer your comment or do you expect here some changes? =20
>=20
> Well, now it has been confirmed this applies to non-RZ/G2L systems, too,
> the check for RPCIF_RZ_G2L should probably be removed.  In upstream,
> only arch/arm64/boot/dts/renesas/rzg2l{,c}-smarc-som.dtsi have devices
> that are compatible with "micron,mt25qu512a", but obviously they can
> appear elsewhere, too.
>=20
> Now, the presence of that compatible value in rzg2l{,c}-smarc-som.dtsi
> currently causes a dtbs_check warning, as it is not documented.
> However, there has been some pushback against adding more compatible
> values, cfr. my patch to add mt25qu512a[1], and Miquel's commit [2].

Just FYI, I sent [2] after an unsuccessful attempt to update that list
too, see [3]. The idea is: if you don't have anything useful to add,
just use the generic compatible. If you need specific changes, you can
add an entry.

[3] https://lore.kernel.org/linux-mtd/d816499e-baab-6200-0780-17a8205b252e@=
linaro.org/

> But the issue Biju is seeing proves there is a need to add these.
>=20
> In addition, I had hoped to gather some feedback or guidance from the
> hyperbus and/or spi people, as issues w.r.t. pin states will eventually
> pop up on other systems, too, and thus may need handling in the core,
> instead of in each individual device driver.  But of course that can
> be done later, when the need arises.
>=20
> Thanks!
>=20
> [1] "[PATCH] dt-bindings: mtd: jedec,spi-nor: Document support for
> more MT25QU parts"
>     https://lore.kernel.org/all/363186079b4269891073f620e3e2353cf7d2559a.=
1669988238.git.geert+renesas@glider.be
> [2] 4b0cb4e7ab2f777c ("dt-bindings: mtd: spi-nor: clarify the need for
> spi-nor compatibles").
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds


Thanks,
Miqu=C3=A8l
