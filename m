Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75C4EDC128
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2019 11:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfJRJfD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Oct 2019 05:35:03 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46873 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbfJRJfD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Oct 2019 05:35:03 -0400
Received: by mail-pl1-f196.google.com with SMTP id q24so2558877plr.13;
        Fri, 18 Oct 2019 02:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zr8X80FCYGX3NS6q9lz/ERKNDbQdTzcOLi07a/VkvfQ=;
        b=RAcZMOWD82a0s6I1gcxzhmBdLU4sVZdK3yGz6Jjs25y3EznSN5eVKpll2358Hrj84u
         APlxx26N4fwfgRJiFJ3sc5LoxBXcNQRTt/vElvG+W7kkosg66YwJWoZkFCz0xTfMvR6f
         Cbjd+SgRLI8/CUJ1oQ20/w7/U3I+PL006t8sQWvLz38Yc2tf9QieGrjd592HdCGX69Cg
         74loV0t60w65irSxdkjPdEWFSMhshoRMFOVGmFBnebKIMvqsp5MvdTjjjRGoCG0iFtiU
         h1wO5yRg6ve6/4y64whxVgtn/1JdbbSxx2ZSNWTw0Q0U4by3x1tJ6j6655oXad9I+dDE
         rJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zr8X80FCYGX3NS6q9lz/ERKNDbQdTzcOLi07a/VkvfQ=;
        b=sq22LqApW9FEsoqV0aGahv+YquuRg3W1xSqEhhMXOMX5agYTJQNmmFQOdlSDdhCi0I
         xKbXIpW27Mgev8H7nnuEVMScEK187JYnDnloD/EGGLmvGIHENDBn84SbQYnCzaUPjQIq
         IqclwSuVIW6ZVyDxBLNE1V1xQVHDJrLZCw3v/DpLqtKEB6QgspTSaXHo0PCc8HQ5ghgA
         M39wUSHe2JOJsCCxOYx0GkaAo/bvxtBZ/jw+2luwZmS/BFIo0Rt7q/caJDLUbh+JDb5Y
         jEoDXjyAu4quiWBwNIPImYbVk+mWcIBDm5JQE4hCghXKBkgBu6vb8KNCOrMkAxZuR4xt
         WD7A==
X-Gm-Message-State: APjAAAV13qLqKf5vpAkBg/2jm2C5/5EA5xJf9EPfGZM9svTPWWpNUtFZ
        2XVGAxOBXKbUI/p5LVpoiXxi1L5+qASpDRo0nmw=
X-Google-Smtp-Source: APXvYqw4nAZfs4DJx1QtvaqZHEiRDgYXllfSaC8wgJ0IuaKqJS3EAvQxq6VuFyH8PluuguPVcRUER8YMtjWt98dTnbE=
X-Received: by 2002:a17:902:b110:: with SMTP id q16mr8804423plr.262.1571391302793;
 Fri, 18 Oct 2019 02:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191017025058.31528-1-hslester96@gmail.com>
In-Reply-To: <20191017025058.31528-1-hslester96@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 18 Oct 2019 12:34:52 +0300
Message-ID: <CAHp75Vd2SMERjtvNumxAF1HSp8GSThmcyx96zkFzUXKwnD5d2Q@mail.gmail.com>
Subject: Re: [PATCH] spi: pxa2xx: Add missed security checks
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Oct 18, 2019 at 8:59 AM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> pxa2xx_spi_init_pdata misses checks for devm_clk_get and
> platform_get_irq.
> Add checks for them to fix the bugs.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/spi/spi-pxa2xx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index bb6a14d1ab0f..2e73d75a6ac5 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1565,7 +1565,13 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
>  #endif
>
>         ssp->clk = devm_clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(ssp->clk))
> +               return NULL;
> +
>         ssp->irq = platform_get_irq(pdev, 0);
> +       if (ssp->irq < 0)
> +               return NULL;

I'm not sure they are mandatory for all platforms.
To be on the safe side, you simple need to add _optional() to the both
call along with above change.

-- 
With Best Regards,
Andy Shevchenko
