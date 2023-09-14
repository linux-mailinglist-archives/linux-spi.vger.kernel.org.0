Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA86E79FFE5
	for <lists+linux-spi@lfdr.de>; Thu, 14 Sep 2023 11:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbjINJX5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 14 Sep 2023 05:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjINJX5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 Sep 2023 05:23:57 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E940CCF3;
        Thu, 14 Sep 2023 02:23:52 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-59bc97d7b3dso21031847b3.1;
        Thu, 14 Sep 2023 02:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694683432; x=1695288232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06DS2fR61f3yXke4mGJSuRI8ZLdRO6K9dsiHVcoB9lE=;
        b=kbu1CeiSYBBfWpwdAZGIUefHj247rVJslAGRtsofkswoG1I4y9T6vaarmYHz1icyyL
         WkwTq6qGwFjQ8tu3uAKoiTKvkCkfbBChUWdMfUmIkv9vfGhIs7hihNUq20VNyxGiODAc
         MNVbBQIjLFhNCKruEI7GTbWAuHrxuT9eZdrZsR3vH5xbT4h6lOdHq2KTGOJ7LeRw5dQP
         ShtYvUWhtNjdzUG3tcfRxUORMgYownkmB2qj+f6pGb9n9JiotouV3YwNER4M0uC6kI7x
         GJIbf3BaYHvPpkuIYkhy4m7nR8rNpJv16mabQ5jFmkVwnvQb78iLBWiS4D356rkdDfWr
         T66g==
X-Gm-Message-State: AOJu0YylbTvoJAQemmftxS+EQoBMF4l2pUAOh8tgc63qUCtLbUnBXZ1E
        sn0SlLc4DdxHlVvm8BCv5SzL6I6exY69hA==
X-Google-Smtp-Source: AGHT+IEPjyzdDVeaw1oh4eN80dkJ9mReVgs+4OufSpkVtwt0QNLOCT+P5+t1BhOr0T9GD0Ah5zW8eg==
X-Received: by 2002:a0d:d702:0:b0:570:2542:cc9b with SMTP id z2-20020a0dd702000000b005702542cc9bmr962602ywd.18.1694683431882;
        Thu, 14 Sep 2023 02:23:51 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id d194-20020a814fcb000000b0058fb9863fe7sm227564ywb.103.2023.09.14.02.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 02:23:49 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-58dfe2d5b9aso10820857b3.1;
        Thu, 14 Sep 2023 02:23:49 -0700 (PDT)
X-Received: by 2002:a81:8450:0:b0:59b:cfc1:8dfc with SMTP id
 u77-20020a818450000000b0059bcfc18dfcmr972705ywf.0.1694683429437; Thu, 14 Sep
 2023 02:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230830145835.296690-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdV1qvypo1XmHBXV5Q1SHEhksMN3SxgweYxPu+=ZeDmg1A@mail.gmail.com>
 <TYCPR01MB5933571F06789BFF27A8FCC786E6A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <502336e9-2455-f3f6-57d1-807bc4b71f7f@linaro.org> <CAMuHMdWO8EdbxXetmc9-2jhZWeX1b_J74O0exo1Q85X9Gbc_SA@mail.gmail.com>
 <20230914105937.4af00bf2@xps-13> <CAMuHMdX8Vg2M2K3U_sbAtVk+6VDvL+GNYtbs5FTTRZzRvVGPCQ@mail.gmail.com>
 <20230914111200.6e6832ca@xps-13>
In-Reply-To: <20230914111200.6e6832ca@xps-13>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Sep 2023 11:23:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVryt5bTk8HeFMS3NU-4EpQdU3Tf6LiGmGQQ5bVD-Emsg@mail.gmail.com>
Message-ID: <CAMuHMdVryt5bTk8HeFMS3NU-4EpQdU3Tf6LiGmGQQ5bVD-Emsg@mail.gmail.com>
Subject: Re: [PATCH] memory: renesas-rpc-if: Fix IO state based on flash type
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Miquel,

On Thu, Sep 14, 2023 at 11:12 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> geert@linux-m68k.org wrote on Thu, 14 Sep 2023 11:04:01 +0200:
> > On Thu, Sep 14, 2023 at 10:59 AM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote:
> > > geert@linux-m68k.org wrote on Thu, 14 Sep 2023 10:34:50 +0200:
> > > > On Thu, Sep 14, 2023 at 10:08 AM Krzysztof Kozlowski
> > > > <krzysztof.kozlowski@linaro.org> wrote:
> > > > > On 30/08/2023 17:18, Biju Das wrote:
> > > > > >>>                 regmap_update_bits(rpc->regmap, RPCIF_CMNCR, @@ -774,6
> > > > > >>> +776,12 @@ static int rpcif_probe(struct platform_device *pdev)
> > > > > >>>                 return ret;
> > > > > >>>         }
> > > > > >>>
> > > > > >>> +       if (rpc->info->type == RPCIF_RZ_G2L &&
> > > > > >>
> > > > > >> Wouldn't this apply to non-RZ/G2L systems, too?
> > > > > >
> > > > > > It applies, if the device uses the flash[1] or [2] and it needs
> > > > > > 4-bit tx support.
> > > > > >
> > > > > > [1] Figure 20: QUAD INPUT/OUTPUT FAST READ – EBh/ECh
> > > > > > https://media-www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-a/mt25q_qlks_u_512_aba_0.pdf?rev=3e5b2a574f7b4790b6e58dacf4c889b2
> > > > > >
> > > > > > [2] section 8.14
> > > > > >
> > > > > > https://www.renesas.com/eu/en/document/dst/at25ql128a-datasheet?r=1608586
> > > > >
> > > > > Geert,
> > > > >
> > > > > Does it answer your comment or do you expect here some changes?
> > > >
> > > > Well, now it has been confirmed this applies to non-RZ/G2L systems, too,
> > > > the check for RPCIF_RZ_G2L should probably be removed.  In upstream,
> > > > only arch/arm64/boot/dts/renesas/rzg2l{,c}-smarc-som.dtsi have devices
> > > > that are compatible with "micron,mt25qu512a", but obviously they can
> > > > appear elsewhere, too.
> > > >
> > > > Now, the presence of that compatible value in rzg2l{,c}-smarc-som.dtsi
> > > > currently causes a dtbs_check warning, as it is not documented.
> > > > However, there has been some pushback against adding more compatible
> > > > values, cfr. my patch to add mt25qu512a[1], and Miquel's commit [2].
> > >
> > > Just FYI, I sent [2] after an unsuccessful attempt to update that list
> > > too, see [3]. The idea is: if you don't have anything useful to add,
> >
> > Oh, I didn't know that.
> >
> > > just use the generic compatible. If you need specific changes, you can
> > > add an entry.
> >
> > The problem is that usually these things are discovered too late,
> > so the only prudent way is to be proactive, and always add them.
> > Initially I thought that the different handling on RZ/G2L was due
> > to a difference in the RPC-IF block.  But now we know it's due to the
> > type of FLASH attached.
>
> Actually what I say is wrong, we are not supposed to touch that list
> anymore and prefer to handle the issues in the drivers by
> auto-discovery. Can't we do that in your case?

I'm not sure we can do that, as this code is part of the hardware
initialization during probing.
Biju: is this needed that early, or can it be done later, after the connected
device has been identified?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
