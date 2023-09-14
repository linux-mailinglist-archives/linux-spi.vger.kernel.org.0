Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB5F79FF73
	for <lists+linux-spi@lfdr.de>; Thu, 14 Sep 2023 11:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbjINJEU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 14 Sep 2023 05:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236454AbjINJEU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 Sep 2023 05:04:20 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB357A8;
        Thu, 14 Sep 2023 02:04:15 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-59bdad64411so7956837b3.3;
        Thu, 14 Sep 2023 02:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694682255; x=1695287055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9a0Jqp0D2IpesFGOA6dYiH9gV5DAqCzpujbuRfGHv2E=;
        b=Pph6truW13DshDAOBzg4tvqIumpH0FPu7WGBS4yUfxjhN2fd1hIK2o74ySuy/Z/+Iz
         NYeih675S/vIJxiDBUMGj4booY2TDYn+WGmRXJH3Ml4xBJQJWa+HWVhukkGEdNkC1InN
         FG3TDIfsy+2aLyODMRXFYijPVeN275n6H3PjW+2M4uTVtHBpbpxpFX0gFbsUUDfq7DS5
         gHu3IWBsqxCXAKSyv2HGcnT91D9JEaZir+aJMiu6ToMq1Y3W4XFCNOFCScXlVwe5j2Z2
         vVpDp1R03MnGsOU7ti/jp+F0Xs1FCLOLEdVpFqakaVmBPX/+AIreH0Dm7tS+xoEQKm1U
         Yoaw==
X-Gm-Message-State: AOJu0YxX3hPWjQffXM8xwEuc/rmFMSQ1igsQeW6lo818NOx+6gAxiun/
        dgC4CN0xtRv3XCCntb7yl/3bOSf9ae7Org==
X-Google-Smtp-Source: AGHT+IHjFY7pfSNXkdH9RIXH7fSQiwXjHOd1IlN5JZle6lt0ZusAuQAdc5RncCqCAMGa7dmrvSWNAw==
X-Received: by 2002:a0d:d854:0:b0:59b:5ce0:381e with SMTP id a81-20020a0dd854000000b0059b5ce0381emr4870525ywe.8.1694682254987;
        Thu, 14 Sep 2023 02:04:14 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id n124-20020a817282000000b0059b17647dcbsm224088ywc.69.2023.09.14.02.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 02:04:14 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d7b79a4899bso725809276.2;
        Thu, 14 Sep 2023 02:04:14 -0700 (PDT)
X-Received: by 2002:a25:820a:0:b0:d11:2a52:3f35 with SMTP id
 q10-20020a25820a000000b00d112a523f35mr5026791ybk.20.1694682253700; Thu, 14
 Sep 2023 02:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230830145835.296690-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdV1qvypo1XmHBXV5Q1SHEhksMN3SxgweYxPu+=ZeDmg1A@mail.gmail.com>
 <TYCPR01MB5933571F06789BFF27A8FCC786E6A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <502336e9-2455-f3f6-57d1-807bc4b71f7f@linaro.org> <CAMuHMdWO8EdbxXetmc9-2jhZWeX1b_J74O0exo1Q85X9Gbc_SA@mail.gmail.com>
 <20230914105937.4af00bf2@xps-13>
In-Reply-To: <20230914105937.4af00bf2@xps-13>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Sep 2023 11:04:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX8Vg2M2K3U_sbAtVk+6VDvL+GNYtbs5FTTRZzRvVGPCQ@mail.gmail.com>
Message-ID: <CAMuHMdX8Vg2M2K3U_sbAtVk+6VDvL+GNYtbs5FTTRZzRvVGPCQ@mail.gmail.com>
Subject: Re: [PATCH] memory: renesas-rpc-if: Fix IO state based on flash type
To:     Miquel Raynal <miquel.raynal@bootlin.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Miquel,

On Thu, Sep 14, 2023 at 10:59 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> geert@linux-m68k.org wrote on Thu, 14 Sep 2023 10:34:50 +0200:
> > On Thu, Sep 14, 2023 at 10:08 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > > On 30/08/2023 17:18, Biju Das wrote:
> > > >>>                 regmap_update_bits(rpc->regmap, RPCIF_CMNCR, @@ -774,6
> > > >>> +776,12 @@ static int rpcif_probe(struct platform_device *pdev)
> > > >>>                 return ret;
> > > >>>         }
> > > >>>
> > > >>> +       if (rpc->info->type == RPCIF_RZ_G2L &&
> > > >>
> > > >> Wouldn't this apply to non-RZ/G2L systems, too?
> > > >
> > > > It applies, if the device uses the flash[1] or [2] and it needs
> > > > 4-bit tx support.
> > > >
> > > > [1] Figure 20: QUAD INPUT/OUTPUT FAST READ – EBh/ECh
> > > > https://media-www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-a/mt25q_qlks_u_512_aba_0.pdf?rev=3e5b2a574f7b4790b6e58dacf4c889b2
> > > >
> > > > [2] section 8.14
> > > >
> > > > https://www.renesas.com/eu/en/document/dst/at25ql128a-datasheet?r=1608586
> > >
> > > Geert,
> > >
> > > Does it answer your comment or do you expect here some changes?
> >
> > Well, now it has been confirmed this applies to non-RZ/G2L systems, too,
> > the check for RPCIF_RZ_G2L should probably be removed.  In upstream,
> > only arch/arm64/boot/dts/renesas/rzg2l{,c}-smarc-som.dtsi have devices
> > that are compatible with "micron,mt25qu512a", but obviously they can
> > appear elsewhere, too.
> >
> > Now, the presence of that compatible value in rzg2l{,c}-smarc-som.dtsi
> > currently causes a dtbs_check warning, as it is not documented.
> > However, there has been some pushback against adding more compatible
> > values, cfr. my patch to add mt25qu512a[1], and Miquel's commit [2].
>
> Just FYI, I sent [2] after an unsuccessful attempt to update that list
> too, see [3]. The idea is: if you don't have anything useful to add,

Oh, I didn't know that.

> just use the generic compatible. If you need specific changes, you can
> add an entry.

The problem is that usually these things are discovered too late,
so the only prudent way is to be proactive, and always add them.
Initially I thought that the different handling on RZ/G2L was due
to a difference in the RPC-IF block.  But now we know it's due to the
type of FLASH attached.

> [3] https://lore.kernel.org/linux-mtd/d816499e-baab-6200-0780-17a8205b252e@linaro.org/
>
> > But the issue Biju is seeing proves there is a need to add these.
> >
> > In addition, I had hoped to gather some feedback or guidance from the
> > hyperbus and/or spi people, as issues w.r.t. pin states will eventually
> > pop up on other systems, too, and thus may need handling in the core,
> > instead of in each individual device driver.  But of course that can
> > be done later, when the need arises.
> >
> > Thanks!
> >
> > [1] "[PATCH] dt-bindings: mtd: jedec,spi-nor: Document support for
> > more MT25QU parts"
> >     https://lore.kernel.org/all/363186079b4269891073f620e3e2353cf7d2559a.1669988238.git.geert+renesas@glider.be
> > [2] 4b0cb4e7ab2f777c ("dt-bindings: mtd: spi-nor: clarify the need for
> > spi-nor compatibles").

-- 
Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
