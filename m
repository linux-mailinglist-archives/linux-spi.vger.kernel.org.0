Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412557A00F5
	for <lists+linux-spi@lfdr.de>; Thu, 14 Sep 2023 11:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbjINJzt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 14 Sep 2023 05:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237501AbjINJzs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 Sep 2023 05:55:48 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A132EB;
        Thu, 14 Sep 2023 02:55:44 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-58dfe2d5b9aso11167807b3.1;
        Thu, 14 Sep 2023 02:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694685343; x=1695290143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dubvhEEU/vJD4l4Oom86kE1O6KwYjirs5KUVCSNEkoY=;
        b=CsUGYAyYjfVM3LZIGpi81Vs0qoPI3k27mV2M7RRoZbfUx2IJlCG23JAYRr3cO91SN1
         xVOO03V/Bswrgf46yyc8m/wQHcWGGgJ6N3f8CRck2+oMxA8jbWtQoeqwVJ3ryDB4Iuhg
         sMlOw3ikzxBAGFN5E0JnBnlTWQZcJc0ayJL3UeF3tkyeT0iZqYZBYzeTzDjU/8BpnC0K
         lr0OBCVCUK3sOcaIQqID61FNkXisjmGId8pCj1Mz1aOnHBX34/mMBOVweYLY47UphZrO
         ljh2excioTGz29vtZkKj8Tc0DQ60qVXVOLWpjge4ANPyx6S+Dab8un472jGLbclADoHS
         Fxnw==
X-Gm-Message-State: AOJu0Ywi1jm/GnFy0W7rsguXEJ4mLleEslouGcdit7ctipgiHhMSxVfa
        9CCwzhxoCn0CEyquET6jFd4K2oLjGfwhmg==
X-Google-Smtp-Source: AGHT+IHmsQvCoCNX7y4MVKaeixshDdB7KvYsthKaE5Nw6Mgup8zHgUhnSI8m+eKq9Z1/stYKNJvP2Q==
X-Received: by 2002:a0d:f803:0:b0:595:844a:364 with SMTP id i3-20020a0df803000000b00595844a0364mr848814ywf.17.1694685342978;
        Thu, 14 Sep 2023 02:55:42 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id s66-20020a0dd045000000b00589e68edac6sm245957ywd.39.2023.09.14.02.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 02:55:42 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-d819b185e74so427144276.0;
        Thu, 14 Sep 2023 02:55:42 -0700 (PDT)
X-Received: by 2002:a25:b34a:0:b0:d7b:a78e:6b2d with SMTP id
 k10-20020a25b34a000000b00d7ba78e6b2dmr939974ybg.20.1694685341843; Thu, 14 Sep
 2023 02:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230830145835.296690-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdV1qvypo1XmHBXV5Q1SHEhksMN3SxgweYxPu+=ZeDmg1A@mail.gmail.com>
 <TYCPR01MB5933571F06789BFF27A8FCC786E6A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <502336e9-2455-f3f6-57d1-807bc4b71f7f@linaro.org> <CAMuHMdWO8EdbxXetmc9-2jhZWeX1b_J74O0exo1Q85X9Gbc_SA@mail.gmail.com>
 <20230914105937.4af00bf2@xps-13> <CAMuHMdX8Vg2M2K3U_sbAtVk+6VDvL+GNYtbs5FTTRZzRvVGPCQ@mail.gmail.com>
 <20230914111200.6e6832ca@xps-13> <CAMuHMdVryt5bTk8HeFMS3NU-4EpQdU3Tf6LiGmGQQ5bVD-Emsg@mail.gmail.com>
 <OS0PR01MB5922B4BF11D1954DFBE2976F86F7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922B4BF11D1954DFBE2976F86F7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Sep 2023 11:55:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUA23VxkK-8CebyqiF=Oe81QZgpEmWmMrMGVd_+BXfsLA@mail.gmail.com>
Message-ID: <CAMuHMdUA23VxkK-8CebyqiF=Oe81QZgpEmWmMrMGVd_+BXfsLA@mail.gmail.com>
Subject: Re: [PATCH] memory: renesas-rpc-if: Fix IO state based on flash type
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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

Hi Biju,

On Thu, Sep 14, 2023 at 11:37 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Subject: Re: [PATCH] memory: renesas-rpc-if: Fix IO state based on flash
> > type
> > On Thu, Sep 14, 2023 at 11:12 AM Miquel Raynal <miquel.raynal@bootlin.com>
> > wrote:
> > > geert@linux-m68k.org wrote on Thu, 14 Sep 2023 11:04:01 +0200:
> > > > On Thu, Sep 14, 2023 at 10:59 AM Miquel Raynal
> > > > <miquel.raynal@bootlin.com> wrote:
> > > > > geert@linux-m68k.org wrote on Thu, 14 Sep 2023 10:34:50 +0200:
> > > > > > On Thu, Sep 14, 2023 at 10:08 AM Krzysztof Kozlowski
> > > > > > <krzysztof.kozlowski@linaro.org> wrote:
> > > > > > > On 30/08/2023 17:18, Biju Das wrote:
> > > > > > > >>>                 regmap_update_bits(rpc->regmap,
> > > > > > > >>> RPCIF_CMNCR, @@ -774,6
> > > > > > > >>> +776,12 @@ static int rpcif_probe(struct platform_device
> > > > > > > >>> +*pdev)
> > > > > > > >>>                 return ret;
> > > > > > > >>>         }
> > > > > > > >>>
> > > > > > > >>> +       if (rpc->info->type == RPCIF_RZ_G2L &&
> > > > > > > >>
> > > > > > > >> Wouldn't this apply to non-RZ/G2L systems, too?
> > > > > > > >
> > > > > > > > It applies, if the device uses the flash[1] or [2] and it
> > > > > > > > needs 4-bit tx support.
> > > > > > > >
> > > > > > >
> > > > > > > Geert,
> > > > > > >
> > > > > > > Does it answer your comment or do you expect here some changes?
> > > > > >
> > > > > > Well, now it has been confirmed this applies to non-RZ/G2L
> > > > > > systems, too, the check for RPCIF_RZ_G2L should probably be
> > > > > > removed.  In upstream, only
> > > > > > arch/arm64/boot/dts/renesas/rzg2l{,c}-smarc-som.dtsi have
> > > > > > devices that are compatible with "micron,mt25qu512a", but obviously
> > they can appear elsewhere, too.
> > > > > >
> > > > > > Now, the presence of that compatible value in
> > > > > > rzg2l{,c}-smarc-som.dtsi currently causes a dtbs_check warning, as
> > it is not documented.
> > > > > > However, there has been some pushback against adding more
> > > > > > compatible values, cfr. my patch to add mt25qu512a[1], and Miquel's
> > commit [2].
> > > > >
> > > > > Just FYI, I sent [2] after an unsuccessful attempt to update that
> > > > > list too, see [3]. The idea is: if you don't have anything useful
> > > > > to add,
> > > >
> > > > Oh, I didn't know that.
> > > >
> > > > > just use the generic compatible. If you need specific changes, you
> > > > > can add an entry.
> > > >
> > > > The problem is that usually these things are discovered too late, so
> > > > the only prudent way is to be proactive, and always add them.
> > > > Initially I thought that the different handling on RZ/G2L was due to
> > > > a difference in the RPC-IF block.  But now we know it's due to the
> > > > type of FLASH attached.
> > >
> > > Actually what I say is wrong, we are not supposed to touch that list
> > > anymore and prefer to handle the issues in the drivers by
> > > auto-discovery. Can't we do that in your case?
> >
> > I'm not sure we can do that, as this code is part of the hardware
> > initialization during probing.
> > Biju: is this needed that early, or can it be done later, after the
> > connected device has been identified?
>
> I need to check that.
>
> You mean patch drivers/spi/spi-rpc-if.c
> to identify the flash type from sfdp info and pass as a parameter to rpcif_hw_init??

Something like that.

That configuration should be saved somewhere, as rpcif_hw_init() is
also called from rpcif_resume(), and when recovering from an error
in rpcif_manual_xfer().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
