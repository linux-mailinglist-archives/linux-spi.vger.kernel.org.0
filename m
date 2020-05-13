Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966761D17FA
	for <lists+linux-spi@lfdr.de>; Wed, 13 May 2020 16:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389006AbgEMOz6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 May 2020 10:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388167AbgEMOz5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 May 2020 10:55:57 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FFCC061A0C;
        Wed, 13 May 2020 07:55:57 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t7so6925379plr.0;
        Wed, 13 May 2020 07:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q0we0+GBX6q0qsW/YELPh66cYe9GwOpY4tlrJBAC4pY=;
        b=dbVXtppEdGfbCzGErxALcHVIJjRBUe5SR4gI+aW8gGwrpxSLPy95nUwKeOViTlMJJa
         GetvmXVu6j1ZaiqMj4ZA0CI6ROcZ4mDH55B/Cfk2OA0nNVt4eZRRr7NsHAb4JkNqLgsK
         s51l3826ndpc6C7+MmyNtQ1Wh/8J8THb3G2oKksmFcptHgxpvbGiU8IyCfxSJWnKVpCz
         fv7pJ8FmzZMP268zQaGv/ASAnz/7NGa7D/v801KXMvnvuS+B35jW3K91J1C7mNBQpWKw
         6ShgfD4zx07M3n4f8Vthv8RuzRgKPSlm6+HfkQ/IfNJSjLB/xMotG+w5eSX0JME536PM
         GdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q0we0+GBX6q0qsW/YELPh66cYe9GwOpY4tlrJBAC4pY=;
        b=XvH4OvOcpX2NlsPRePUefcMn4jDXEpDXhXLJWKADIxgqy7Git5h6GqyoOZdkbyqxNn
         51s5DCZFwMLoKAyrbob7r78juY7Xsr2ybhrbWWNzgwZTHDlez6HSCShaEJBn9YvMsAi5
         drMLd3wMSuefS+LGTC4h7Fqsw/ViVjmK0El6bJVmvVtkjW9dhyoTRMi2E/+dyQ9BMiCZ
         6nnQR9GEiqefrlCG7W740EjJonqjIaqpADKZ3zb9JrOGYFmi90fEmmwlvPbsF8aBfzlw
         +wOCOoAAH+Lmwrf/356oNalZk/FccIWxuWCOvUtwilcNJWm/XresxNPf4PyB9HN16/nc
         bnrQ==
X-Gm-Message-State: AGi0PuZquY3O0/hGnXI/mDHc8xR5Efbmg4IdEpeyYlDKfoJPyAptWd+8
        nmIM7wKaqf3HIskZDMR3lFXuxn0mKdUJkHNq8dxx0SS4QPo=
X-Google-Smtp-Source: APiQypJStWKnwCbOzDaephSclhi7lT0hpHLD+NSnoaKCFmfLEuG9RPUzE+cPZl9AlTEKQ08Sn8uR/rwkx0DqCXY6/+w=
X-Received: by 2002:a17:902:7003:: with SMTP id y3mr25899813plk.18.1589381757070;
 Wed, 13 May 2020 07:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200513140031.25633-1-lars.povlsen@microchip.com> <20200513140031.25633-2-lars.povlsen@microchip.com>
In-Reply-To: <20200513140031.25633-2-lars.povlsen@microchip.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 May 2020 17:55:50 +0300
Message-ID: <CAHp75VcA-oDboufsDNx1ZR4+HBwYt7LdLOpbfs7-bM9ByucKJA@mail.gmail.com>
Subject: Re: [PATCH 01/10] spi: dw: Add support for polled operation via no
 IRQ specified in DT
To:     Lars Povlsen <lars.povlsen@microchip.com>
Cc:     Mark Brown <broonie@kernel.org>, SoC Team <soc@kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, May 13, 2020 at 5:03 PM Lars Povlsen <lars.povlsen@microchip.com> wrote:
>
> With this change a SPI controller can be added without having a IRQ
> associated, and causing all transfers to be polled. For SPI controllers
> without DMA, this can significantly improve performance by less
> interrupt handling overhead.

...

> +#define VALID_IRQ(i) (i >= 0)

drivers/rtc/rtc-cmos.c:95:#define is_valid_irq(n)               ((n) > 0)

Candidate to be in include/linux/irq.h ?

...

> +       if (VALID_IRQ(dws->irq))
> +               free_irq(dws->irq, master);

Isn't free_irq() aware of invalid ones (not found IRQ in the tree or
any other backend container won't do anything)?


>  err_free_master:
>         spi_controller_put(master);
>         return ret;
> --
> 2.26.2



--
With Best Regards,
Andy Shevchenko
