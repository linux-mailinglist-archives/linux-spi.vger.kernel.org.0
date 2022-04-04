Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D014F15FC
	for <lists+linux-spi@lfdr.de>; Mon,  4 Apr 2022 15:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbiDDNge (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Apr 2022 09:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbiDDNgd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Apr 2022 09:36:33 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0623B57F;
        Mon,  4 Apr 2022 06:34:36 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id x131so5070185ybe.11;
        Mon, 04 Apr 2022 06:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YaTxLCUntWttTrySEX5v0WWGqUyOjlg+VT/NTYbEi1k=;
        b=XhW31WQQOkGD/WqzKYUh6DrLwiPMTC47Zm3P6AnIsAE4hVYbBQtmt0AzmS+qNT8x4f
         qzYoraXVz01ewciISt+1ftpiwzYFEgcVUEQDf+45O5ouJPNVC00wd/00bVh6GPsndgj/
         AzphLzXni/vxQleqvUQLfnBV7uc42FBqQ2Y3SAlwRNP7BQgNz9MBLtN9fjv059fWlS+f
         h2OxbFYZHvTKk+xPRW+HxVoN5vP5UQUBwT7XABsoYBTPr6C+r36nW+TFb7yIm8zSVnfS
         cz3NljZzji6hoFpTU7I7FSYNNX/c/ktjSGKWm47e50EUlnBUr3yWOy8kA5wiM+u8RDtK
         iNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YaTxLCUntWttTrySEX5v0WWGqUyOjlg+VT/NTYbEi1k=;
        b=Pc2YXpit9m4D3Pm7BkpQYGhCJzZ/pB4KiU1MMwbPsLvyyd1F1B1ne8U6EiFyI7qxAC
         5cakCATcSdqF6JTkUUab7RaziU5BNbStHDhb1NMYZbuchuSPz404DK06eLmipOwuQgFj
         kgc+gp2ewsI27afluPyA0cEz1OSG0TfDgdpTnGxFiEyeSNuzR6W9PuvTpuE/gxGMVDnD
         yQDxpo02Abynr6kL0ovYVRoMGEj/KVY+Vut1raAV2FYu7wHiKQJUdhcjg/G+vzZYZ3VD
         T++77hVr3FTvawYEkUTt+vMqkcd+JaSNh4uBLO+G08sN8y915HXi4qFvIH+htdDeD7KF
         u8Cg==
X-Gm-Message-State: AOAM5308Ean4wtyfdUyTClB2cZn2ub1Jq4JCzgkPqeg7ua6iEx/jwmos
        pZFRs7OAJA/Lo6tpjFRYGU1Gh06WlxlPnTUxVuE=
X-Google-Smtp-Source: ABdhPJxKtp10ufyLemxrLYs1Do/IZNZpDWiRF3iXVcHDtm+e+UdCgHS55mIXAUc3/LdnzK4WupgU7fiKHMOuZIjbuOU=
X-Received: by 2002:a25:374d:0:b0:63d:84a2:237d with SMTP id
 e74-20020a25374d000000b0063d84a2237dmr12786814yba.417.1649079276152; Mon, 04
 Apr 2022 06:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <d196bb5849843993557a9b10f3bd28a752e5e8e0.1648562287.git.geert+renesas@glider.be>
In-Reply-To: <d196bb5849843993557a9b10f3bd28a752e5e8e0.1648562287.git.geert+renesas@glider.be>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 4 Apr 2022 14:34:10 +0100
Message-ID: <CA+V-a8uiP8TX2MJs2cvMdxJCt5cSmvYTm3biQYmAg+TH=yw7ng@mail.gmail.com>
Subject: Re: [PATCH 1/2] mtd: hyperbus: rpc-if: Fix RPM imbalance in probe
 error path
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Mar 29, 2022 at 3:09 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> If rpcif_hw_init() fails, Runtime PM is left enabled.
>
> Fixes: b04cc0d912eb80d3 ("memory: renesas-rpc-if: Add support for RZ/G2L")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> For the mtd tree.
>
>  drivers/mtd/hyperbus/rpc-if.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar
