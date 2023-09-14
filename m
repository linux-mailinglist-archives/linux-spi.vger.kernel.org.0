Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E313D79FE83
	for <lists+linux-spi@lfdr.de>; Thu, 14 Sep 2023 10:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbjINIfN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 14 Sep 2023 04:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbjINIfM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 Sep 2023 04:35:12 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0FE1BFC;
        Thu, 14 Sep 2023 01:35:08 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-59be9a09c23so6781087b3.1;
        Thu, 14 Sep 2023 01:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694680504; x=1695285304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sl16OfOFb3HtkUKJC91et4gKnDzDImEPUR7e/fEk9N0=;
        b=cHo3SHzkVuoDadec0+6FxSz4erdzh6PKJzwC18XhB+0M8bjl9I/IsJjQkboHTCfmqh
         jIIWtvPS3Ojx6j0TzD1R5bi0A0wsZ7TrQKudfXE3rRkVYCOsbBQA/G55KBGJ8UpSVbrC
         gsLdLqANDFlZcOuukQXV6ZPAjCp4Cp1SVWb5gIVMj+It45GvfIaWgYQrV8PPriUnaRLJ
         Om28GnDoGwuarrqPPUFRJjH2X2OjUBIaH0yp/m67JMNn63tluEXx0YjHobZ7hmg+LlBb
         osxlBwfF/B2zyBqMnwjfuzlKalNLrZM30/Q/6Dd3odpZZSUyXv0sjWzgkt70d9uAui9H
         pT9Q==
X-Gm-Message-State: AOJu0YyZDhN1R4JGvJa2wXnNyML/mrFPYuUCRY160Za6sAEetfGYeueq
        QhSgilWNTGpVzl37Ov6H7+JglsvPqKNreg==
X-Google-Smtp-Source: AGHT+IGhsAZG8CmxPAdMfWtRiSAm1x6233SZ0ahARHeMO3FKhnJx81lrhX3C7q7j047tWkUGsu906w==
X-Received: by 2002:a0d:cc06:0:b0:579:f5c2:b16e with SMTP id o6-20020a0dcc06000000b00579f5c2b16emr5151321ywd.31.1694680504449;
        Thu, 14 Sep 2023 01:35:04 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id e184-20020a8169c1000000b0057042405e2csm219082ywc.71.2023.09.14.01.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 01:35:03 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d7b79a4899bso704343276.2;
        Thu, 14 Sep 2023 01:35:03 -0700 (PDT)
X-Received: by 2002:a25:810c:0:b0:d7b:9a33:4c69 with SMTP id
 o12-20020a25810c000000b00d7b9a334c69mr4086889ybk.58.1694680503603; Thu, 14
 Sep 2023 01:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230830145835.296690-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdV1qvypo1XmHBXV5Q1SHEhksMN3SxgweYxPu+=ZeDmg1A@mail.gmail.com>
 <TYCPR01MB5933571F06789BFF27A8FCC786E6A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <502336e9-2455-f3f6-57d1-807bc4b71f7f@linaro.org>
In-Reply-To: <502336e9-2455-f3f6-57d1-807bc4b71f7f@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Sep 2023 10:34:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWO8EdbxXetmc9-2jhZWeX1b_J74O0exo1Q85X9Gbc_SA@mail.gmail.com>
Message-ID: <CAMuHMdWO8EdbxXetmc9-2jhZWeX1b_J74O0exo1Q85X9Gbc_SA@mail.gmail.com>
Subject: Re: [PATCH] memory: renesas-rpc-if: Fix IO state based on flash type
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Krzysztof,

CC Rob, Miquel

On Thu, Sep 14, 2023 at 10:08 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 30/08/2023 17:18, Biju Das wrote:
> >>>                 regmap_update_bits(rpc->regmap, RPCIF_CMNCR, @@ -774,6
> >>> +776,12 @@ static int rpcif_probe(struct platform_device *pdev)
> >>>                 return ret;
> >>>         }
> >>>
> >>> +       if (rpc->info->type == RPCIF_RZ_G2L &&
> >>
> >> Wouldn't this apply to non-RZ/G2L systems, too?
> >
> > It applies, if the device uses the flash[1] or [2] and it needs
> > 4-bit tx support.
> >
> > [1] Figure 20: QUAD INPUT/OUTPUT FAST READ – EBh/ECh
> > https://media-www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-a/mt25q_qlks_u_512_aba_0.pdf?rev=3e5b2a574f7b4790b6e58dacf4c889b2
> >
> > [2] section 8.14
> >
> > https://www.renesas.com/eu/en/document/dst/at25ql128a-datasheet?r=1608586
>
> Geert,
>
> Does it answer your comment or do you expect here some changes?

Well, now it has been confirmed this applies to non-RZ/G2L systems, too,
the check for RPCIF_RZ_G2L should probably be removed.  In upstream,
only arch/arm64/boot/dts/renesas/rzg2l{,c}-smarc-som.dtsi have devices
that are compatible with "micron,mt25qu512a", but obviously they can
appear elsewhere, too.

Now, the presence of that compatible value in rzg2l{,c}-smarc-som.dtsi
currently causes a dtbs_check warning, as it is not documented.
However, there has been some pushback against adding more compatible
values, cfr. my patch to add mt25qu512a[1], and Miquel's commit [2].
But the issue Biju is seeing proves there is a need to add these.

In addition, I had hoped to gather some feedback or guidance from the
hyperbus and/or spi people, as issues w.r.t. pin states will eventually
pop up on other systems, too, and thus may need handling in the core,
instead of in each individual device driver.  But of course that can
be done later, when the need arises.

Thanks!

[1] "[PATCH] dt-bindings: mtd: jedec,spi-nor: Document support for
more MT25QU parts"
    https://lore.kernel.org/all/363186079b4269891073f620e3e2353cf7d2559a.1669988238.git.geert+renesas@glider.be
[2] 4b0cb4e7ab2f777c ("dt-bindings: mtd: spi-nor: clarify the need for
spi-nor compatibles").

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
