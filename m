Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027192B556F
	for <lists+linux-spi@lfdr.de>; Tue, 17 Nov 2020 00:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgKPX7d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 18:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgKPX7d (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Nov 2020 18:59:33 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6D9C0613CF
        for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2020 15:59:33 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id l1so20932979wrb.9
        for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2020 15:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ip7pzwO/oZepntmcP1UnnfZv5FeIGf4UVJKD8XytUJg=;
        b=no2c23pZ4DqtDy6Xa3U91a1fLlAjbDWkWu1/9MlV9kLdRj46YhOKj8XjIjpt8gXD3L
         MIcj/ERM7jeNdYmD1J7fVegevHyWgMV+KHpsVXeLrN5bAdlr2AL/2Op9+tplCicaqMbp
         bZssH+X9Zv1lMwB03yIsituqvJ+TBCHdJNaPSZElmVNhWVEW/6/dffotYqcXp6EI6OA3
         kJFbDmhp4Ic6q3EVblW7wKAISjYE4ZeC1JCmpZGTCPcWMY/DFB+LEKgShSdZjd38Flyl
         H8VVPwXSbjdhi1R99rLKkWa+1yIZ6WYbpyCvLbDV34qu29oiIqRK91EenuO3nlJIMChK
         QX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ip7pzwO/oZepntmcP1UnnfZv5FeIGf4UVJKD8XytUJg=;
        b=LcJHqxPcWcu/+VMhoiDh2pnrdtFqHsKqcx6XonvHPD/M55E9n/dcq/A8NBDIaWZXoX
         FW5Lb57rDG2FF4rcPj1IZkrj1oQzr4AtJOpfEus8J8m58WOsKUIstGKwoIZDswtYRbgR
         5aNDCmgF3QAZ3SuBK/AIc1m9Ua/jwu/F/Ve0lLNPGlr0hCqZpbk4INAUVDwwIZzLlS6Q
         gQcDnV8C6+z86y2Jhrcbv5HpgJvRC0X6arw0nuQmNY5fzz53qTOyqiQ/pfLUTskRXhYw
         ENUMM/2/A2MIwDJnqmVnR3OISnpM0OBQeullP7zYhXFC/zRVKLF85Jgk3EmteMVS7Psw
         65Zw==
X-Gm-Message-State: AOAM531u3WByskgdYSBq4aDlqMIaQqaQxF158G7NVlNf7R07QDZHgG3l
        UYZdlmhxmcS5d9MorbhZnhsQhiKIqvgc+dkRkh4=
X-Google-Smtp-Source: ABdhPJzzyEwWIFQDB7JmSTtDLil6oEFxekybZsyRS+m3kMcidUhmHCifwvFc9UXIEyB9z83NXDVIycbZ1lPhfgabmgE=
X-Received: by 2002:a5d:698c:: with SMTP id g12mr21653489wru.36.1605571171621;
 Mon, 16 Nov 2020 15:59:31 -0800 (PST)
MIME-Version: 1.0
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
 <49102f5bbb3f1592d9cfd7b39ac5e131a031f950.1605512876.git.lukas@wunner.de>
 <CAHQ1cqHs+jTzp2dYx0cAosLaoBWXpmBivW5bPKbckS=un9k9SA@mail.gmail.com> <20201116230339.GA25992@wunner.de>
In-Reply-To: <20201116230339.GA25992@wunner.de>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 16 Nov 2020 15:59:20 -0800
Message-ID: <CAHQ1cqHx0Bq+g8qFK_QdjGHgKHyLgev_5EAwo3CAF9knGfNVSg@mail.gmail.com>
Subject: Re: [PATCH for-5.10] spi: gpio: Don't leak SPI master in probe error path
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 16, 2020 at 3:03 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Mon, Nov 16, 2020 at 11:23:43AM -0800, Andrey Smirnov wrote:
> > On Mon, Nov 16, 2020 at 12:44 AM Lukas Wunner <lukas@wunner.de> wrote:
> > > If the call to devm_spi_register_master() fails on probe of the GPIO SPI
> > > driver, the spi_master struct is erroneously not freed:
> > >
> > > After allocating the spi_master, its reference count is 1.  The driver
> > > unconditionally decrements the reference count on unbind using a devm
> > > action.  Before calling devm_spi_register_master(), the driver
> > > unconditionally increments the reference count because on success,
> > > that function will decrement the reference count on unbind.  However on
> > > failure, devm_spi_register_master() does *not* decrement the reference
> > > count, so the spi_master is leaked.
> >
> > Not sure I fully understand this. On failure
> > devm_spi_register_master() will return a negative error code which
> > should result in probe failure and release of devres resource, right?
>
> Yes, but that just decrements the refcount from 2 to 1:
>
>     /* refcount initialized to 1 */
>     master = spi_alloc_master(dev, sizeof(*spi_gpio));
>
>     ...
>
>     /* refcount incremented to 2 */
>     return devm_spi_register_master(&pdev->dev, spi_master_get(master));
>
>     ...
>
>     /* on failure of devm_spi_register_master(), refcount decremented to 1
>        by devres action */
>     spi_gpio_put()
>
>
> > > The issue was introduced by commits 8b797490b4db ("spi: gpio: Make sure
> > > spi_master_put() is called in every error path") and 79567c1a321e ("spi:
> > > gpio: Use devm_spi_register_master()"), which sought to plug leaks
> > > introduced by 9b00bc7b901f ("spi: spi-gpio: Rewrite to use GPIO
> > > descriptors") but missed this remaining leak.
> >
> > That extra spi_master_get() that might be problematic was present in
> > the code before 8b797490b4db ("spi: gpio: Make sure spi_master_put()
> > is called in every error path") and I think was first introduced in
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers?h=v5.9-rc4&id=702a4879ec337463f858c8ab467482cce260bf18
> >
> > Or am I missing something?
>
> The extra spi_master_get() was introduced by 79567c1a321e.
> I don't see it in spi-gpio.c before that commit.
>
> Its quite possible that I missed something myself, nobody's perfect.
> But just from code inspection it seems wrong the way it is right now.
>
> Shout if I failed to explain it properly and I'll try again. :)
>

Before 79567c1a321e extra spi_master_get() was a part of
spi_bitbang_start(). Ah, OK, it had it's own local spi_master_put() on
failure, which I lost when inlinging that function. My bad. Good to
see that the with devm_spi_alloc_master() cleanup path is sane and
easy to read once again.

> Thanks,
>
> Lukas
