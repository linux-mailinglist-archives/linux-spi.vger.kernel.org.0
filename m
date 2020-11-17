Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E838B2B589E
	for <lists+linux-spi@lfdr.de>; Tue, 17 Nov 2020 05:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgKQEDD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 23:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgKQEDD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Nov 2020 23:03:03 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74432C0613CF
        for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2020 20:03:03 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id i13so15156334pgm.9
        for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2020 20:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OnFWkKbgTPSKzkcbDYVmQtyHgS5LWlDndIFMAevZ/z8=;
        b=dc1Oq66d8WGN6+JfFt5BcEZu6VpwkJB5j1q5uN8XpT4D77j8GlKE0GVrQhqOwIVYMM
         tn2bWeY0wvlM8x7htFJTWKWREvBdC17iQBj1vZqqcW/7qA3VdmCGPuOJDHyQNcwhXcW/
         W6cTdueOC4Zx1zbNRLVppm0tNJM88OuCcHjFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OnFWkKbgTPSKzkcbDYVmQtyHgS5LWlDndIFMAevZ/z8=;
        b=dAE5tXjICCBfX5xkSPGHuytTg59U9n7G4dkF3JBS8oCsGaN6qhuhl/E0XDl2dewR5+
         2EdMwr9UA9gkbUtlPz5s75U+nZ+hHKsnirNAis4kBDFwd0bHO18yRkm2Fi3wF3eTDr0B
         G81+dsbNgS1GjalvLAItjJLsT0buBvD4QmXscs4ONXgdBWin+pbBjIq37RGVGVqIjMnj
         5VIkX6/vmShxVIly4Eux917tAHrGGNTK+7TBlg/h17vKt7/KI8YXNOWPkLFtV5SgqPjb
         8AEi0AY+f2dvTK75b6uZToM2yYR5wpVNczALpxIZvxbm1yTMW7J3r13Lx6DC5OyxFxBt
         q0WA==
X-Gm-Message-State: AOAM532PDhbTeXCP1FEE+SMQc5JDE8LWjZ9Q9keD8zp2QVuj8zfyBYIC
        SpeHj8q5wwMfQ+Ul7nOEetE/n82wjFKMo8jGkDWLqQ==
X-Google-Smtp-Source: ABdhPJxcg1BHjkmJYhVuw5GKqadsRfQsH9+pXy3+fwE6jh2NqvFO5cA1IdMIB25qOvMd03chZ7S/85g9faTYWE13vM0=
X-Received: by 2002:a17:90b:30d0:: with SMTP id hi16mr2427876pjb.144.1605585783014;
 Mon, 16 Nov 2020 20:03:03 -0800 (PST)
MIME-Version: 1.0
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
 <a203c24658b7d70ddb27bf1f9898fe6f896fead5.1605512876.git.lukas@wunner.de>
In-Reply-To: <a203c24658b7d70ddb27bf1f9898fe6f896fead5.1605512876.git.lukas@wunner.de>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Tue, 17 Nov 2020 12:02:51 +0800
Message-ID: <CAATdQgDi_AfRvQ5Qe9yjU5xZHPm3CcVXyAd5EX4M824sg4ZDtw@mail.gmail.com>
Subject: Re: [PATCH for-5.10] spi: spi-mtk-nor: Don't leak SPI master in probe
 error path
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Chuanhong Guo <gch981213@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 16, 2020 at 4:43 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> If the call to devm_spi_register_controller() fails on probe of the
> MediaTek SPI NOR driver, the spi_controller struct is erroneously not
> freed.
>
> Since commit a1daaa991ed1 ("spi: spi-mtk-nor: use dma_alloc_coherent()
> for bounce buffer"), the same happens if the call to
> dmam_alloc_coherent() fails.
>
> Since commit 3bfd9103c7af ("spi: spi-mtk-nor: Add power management
> support"), the same happens if the call to mtk_nor_enable_clk() fails.
>
> Fix by switching over to the new devm_spi_alloc_master() helper.
>
> Fixes: 881d1ee9fe81 ("spi: add support for mediatek spi-nor controller")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

> Cc: <stable@vger.kernel.org> # v5.7+: 5e844cc37a5c: spi: Introduce device-managed SPI controller allocation
> Cc: <stable@vger.kernel.org> # v5.7+
> Cc: Chuanhong Guo <gch981213@gmail.com>
> Cc: Ikjoon Jang <ikjn@chromium.org>
> ---
>  drivers/spi/spi-mtk-nor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
> index b97f26a60cbe..288f6c2bbd57 100644
> --- a/drivers/spi/spi-mtk-nor.c
> +++ b/drivers/spi/spi-mtk-nor.c
> @@ -768,7 +768,7 @@ static int mtk_nor_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         }
>
> -       ctlr = spi_alloc_master(&pdev->dev, sizeof(*sp));
> +       ctlr = devm_spi_alloc_master(&pdev->dev, sizeof(*sp));
>         if (!ctlr) {
>                 dev_err(&pdev->dev, "failed to allocate spi controller\n");
>                 return -ENOMEM;
> --
> 2.28.0
>
