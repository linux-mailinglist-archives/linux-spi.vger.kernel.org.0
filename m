Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D8178DE05
	for <lists+linux-spi@lfdr.de>; Wed, 30 Aug 2023 20:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245600AbjH3S4w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 30 Aug 2023 14:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245314AbjH3PJN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Aug 2023 11:09:13 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3C8E8;
        Wed, 30 Aug 2023 08:09:11 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-58fc4d319d2so64959177b3.1;
        Wed, 30 Aug 2023 08:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693408150; x=1694012950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5k9P0qVTFYIfwM1/2tKE8Wk464EbVW1AN+obFoUzobM=;
        b=aMvmgiRuZJgilKapYAsqzLACdoeTHMenmNUI0RujRroaRxdQck9EF34b+3NQqYGIYi
         MKWupa78uoYhlnjfsQhX0fIi0aGbkM1MGC/OWiWl1aN3lmwzuI9m+P3657A9r7Os4rD1
         558SXwwW9sHSrWF2VTui87vXngwXUjTF+EqcGn8/DtNUQC7eOOqCSa1+NfxbDa+8ofgI
         o4pSXRnWojlFXVNPnJHjysjj57q1Pd8XupMyZMMKUdTDlxfGuQWuHwxat0UIKYlOLBvi
         yXULcy0prvoMSuMsCIjQbLFT+1Ih2xtXcKS9GEaIgkDn77cOIWPVcFDbWyohOwhQvn0S
         Wycw==
X-Gm-Message-State: AOJu0YzHLzOXzH5c4IunnoitQUBUjlp1lNA7qDaaXzJk6LTpZ26/RRi2
        SiYEGAr6x9BPj7Cc2loUg/sm+lZtoSB/fw==
X-Google-Smtp-Source: AGHT+IENzDaptivTtO50nH2NjnxvhTOMlnYNItXX96eHIVIxPfW1Ud6rdeoHGnCXKsL5oOdNPL5j9g==
X-Received: by 2002:a81:a057:0:b0:577:617c:8cd with SMTP id x84-20020a81a057000000b00577617c08cdmr2322252ywg.35.1693408150133;
        Wed, 30 Aug 2023 08:09:10 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id a5-20020a0dd805000000b00570589c5aedsm3359024ywe.7.2023.08.30.08.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 08:09:09 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d7d15e6884dso417374276.0;
        Wed, 30 Aug 2023 08:09:09 -0700 (PDT)
X-Received: by 2002:a25:e74a:0:b0:d4e:3ffe:79d4 with SMTP id
 e71-20020a25e74a000000b00d4e3ffe79d4mr2035879ybh.61.1693408149175; Wed, 30
 Aug 2023 08:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230830145835.296690-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230830145835.296690-1-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Aug 2023 17:08:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV1qvypo1XmHBXV5Q1SHEhksMN3SxgweYxPu+=ZeDmg1A@mail.gmail.com>
Message-ID: <CAMuHMdV1qvypo1XmHBXV5Q1SHEhksMN3SxgweYxPu+=ZeDmg1A@mail.gmail.com>
Subject: Re: [PATCH] memory: renesas-rpc-if: Fix IO state based on flash type
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Biju,

CC hyperbus, spi

On Wed, Aug 30, 2023 at 4:58 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Currently, RZ/G2L-alike SoCs use 2 different SPI serial flash memories
>  1) AT25QL128A  embedded in RZ/{G2UL,Five} SMARC EVKs
>  2) MT25QU512AB embedded in RZ/{G2L,G2LC,V2L} SMARC EVKs
>
> As per section 8.14 on the AT25QL128A hardware manual,
> IO1..IO3 must be set to Hi-Z state for this flash for fast read quad IO.
> Snippet from HW manual section 8.14:
> The upper nibble of the Mode(M7-4) controls the length of the next FAST
> Read Quad IO instruction through the inclusion or exclusion of the first
> byte instruction code. The lower nibble bits of the Mode(M3-0) are don't
> care. However, the IO pins must be high-impedance before the falling edge
> of the first data out clock.
>
> As per the Figure 20: QUAD INPUT/OUTPUT FAST READ on MT25QU512AB mentions
> IO1..IO2 to be in Hi-Z state and IO3 in '1' state
>
> Add a variable io3_fv to struct rpcif_priv and check the child
> node compatible value to detect micron flash and set IO1..IO3 states
> based on flash type.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

I guess this issue is not unique to Renesas platforms...

> --- a/drivers/memory/renesas-rpc-if.c
> +++ b/drivers/memory/renesas-rpc-if.c
> @@ -189,6 +189,7 @@ struct rpcif_priv {
>         u32 enable;             /* DRENR or SMENR */
>         u32 dummy;              /* DRDMCR or SMDMCR */
>         u32 ddr;                /* DRDRENR or SMDRENR */
> +       u32 io3_fv;
>  };
>
>  static const struct rpcif_info rpcif_info_r8a7796 = {
> @@ -367,7 +368,8 @@ int rpcif_hw_init(struct device *dev, bool hyperflash)
>                 regmap_update_bits(rpc->regmap, RPCIF_CMNCR,
>                                    RPCIF_CMNCR_MOIIO(3) | RPCIF_CMNCR_IOFV(3) |
>                                    RPCIF_CMNCR_BSZ(3),
> -                                  RPCIF_CMNCR_MOIIO(1) | RPCIF_CMNCR_IOFV(2) |
> +                                  RPCIF_CMNCR_MOIIO(1) | RPCIF_CMNCR_IO0FV(2) |
> +                                  RPCIF_CMNCR_IO2FV(3) | rpc->io3_fv |
>                                    RPCIF_CMNCR_BSZ(hyperflash ? 1 : 0));
>         else
>                 regmap_update_bits(rpc->regmap, RPCIF_CMNCR,
> @@ -774,6 +776,12 @@ static int rpcif_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> +       if (rpc->info->type == RPCIF_RZ_G2L &&

Wouldn't this apply to non-RZ/G2L systems, too?

> +           of_device_is_compatible(flash, "micron,mt25qu512a"))
> +               rpc->io3_fv = RPCIF_CMNCR_IO3FV(1);
> +       else
> +               rpc->io3_fv = RPCIF_CMNCR_IO3FV(3);
> +
>         return 0;
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
