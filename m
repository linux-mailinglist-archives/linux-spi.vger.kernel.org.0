Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1202B737C
	for <lists+linux-spi@lfdr.de>; Wed, 18 Nov 2020 02:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbgKRBIV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Nov 2020 20:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgKRBIU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Nov 2020 20:08:20 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69020C061A48
        for <linux-spi@vger.kernel.org>; Tue, 17 Nov 2020 17:08:20 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id o24so470220ljj.6
        for <linux-spi@vger.kernel.org>; Tue, 17 Nov 2020 17:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CC35HEt4K1i1sTZSdlQEvHPbxlvjssojhb57sLmWSqo=;
        b=rKGJVPa7DwJOFwfSACzIV6e22jkz5jIRar9MWLIEUTQnSSbIu/Wjb91gOHuyCGfgvt
         CEpmbYMpgFo03i1LDoK+MBBnL+EuVwMWdW4lkp2mEndc4PoFYAXDtt9sQHCYKcstiaTB
         3z7fdaHMwf3fSRiy+kZPT1b8rexk44hWqBqsPo8YI/DejBVmMWxfAHPVOG/YV9rCrSC3
         zNGydyAeNj8sZh7t1BUnlGsrojl9ciR/fwNd1CF7YUTMVasyJGoOgySEtDwjU7aw4BbH
         QmKfp/Mm2+pe4tCMKRUvsata4lzUBFf6Rc7AiB5VnAvSF3vcEWK8NaTAw8W627y9EgoG
         VoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CC35HEt4K1i1sTZSdlQEvHPbxlvjssojhb57sLmWSqo=;
        b=CVWOyTcHmzahXCQdtCwd1TZXouKQzE3nN7YhYmKKUlmRCnK7xlDM+I+7/M0JYk1D01
         7p8YXMwWaSQkSnokSzHP5zbw9HnanRUYy2AEtsPaLA3p9jST0vRdleZmS4GpeRK9fAzh
         4+ABFxQ7FHcRGivw+bfMXOSgvkBwB//wvWPmNCrQBeD287W3S7sFoHgMCoEHiUGfEC3j
         MrG/zGQN7N/n/XDOG9FR8yclEWl/zvMCKv1QBWRdYpZIhzLQ4/UVAW8Jo3Z1xZECVpxO
         d3afNVIieYtqPIuBfYqsf3DfU9e4ARJhBgAsJIdqG63n9W1PJiKlmICaIOsj8ryNpViY
         G6iA==
X-Gm-Message-State: AOAM53018jlNEYMr4xzRPjxRd75HeoJQYEXuue4x7B6yiwH13UcDdIO4
        bE7iPtJcKrS+z7DXKhav88n159177sfNTEsHPyn2AysCpkcmNw==
X-Google-Smtp-Source: ABdhPJyJMKk2p5bN0BYKZFVDSwE/NRYLgfbKHWTwwD2/xXErDhUwukZfqHAG9Jz7L5vbAwqkipmnJNt3Usgke4LdymI=
X-Received: by 2002:a05:651c:c2:: with SMTP id 2mr2741494ljr.104.1605661697461;
 Tue, 17 Nov 2020 17:08:17 -0800 (PST)
MIME-Version: 1.0
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
 <49102f5bbb3f1592d9cfd7b39ac5e131a031f950.1605512876.git.lukas@wunner.de>
In-Reply-To: <49102f5bbb3f1592d9cfd7b39ac5e131a031f950.1605512876.git.lukas@wunner.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Nov 2020 02:08:05 +0100
Message-ID: <CACRpkdZeLvNz+b5K3iXMOTk=2JciFco5emhYEA_oeG73t=xdhw@mail.gmail.com>
Subject: Re: [PATCH for-5.10] spi: gpio: Don't leak SPI master in probe error path
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 16, 2020 at 9:44 AM Lukas Wunner <lukas@wunner.de> wrote:

> If the call to devm_spi_register_master() fails on probe of the GPIO SPI
> driver, the spi_master struct is erroneously not freed:
>
> After allocating the spi_master, its reference count is 1.  The driver
> unconditionally decrements the reference count on unbind using a devm
> action.  Before calling devm_spi_register_master(), the driver
> unconditionally increments the reference count because on success,
> that function will decrement the reference count on unbind.  However on
> failure, devm_spi_register_master() does *not* decrement the reference
> count, so the spi_master is leaked.
>
> The issue was introduced by commits 8b797490b4db ("spi: gpio: Make sure
> spi_master_put() is called in every error path") and 79567c1a321e ("spi:
> gpio: Use devm_spi_register_master()"), which sought to plug leaks
> introduced by 9b00bc7b901f ("spi: spi-gpio: Rewrite to use GPIO
> descriptors") but missed this remaining leak.
>
> The situation was later aggravated by commit d3b0ffa1d75d ("spi: gpio:
> prevent memory leak in spi_gpio_probe"), which introduced a
> use-after-free because it releases a reference on the spi_master if
> devm_add_action_or_reset() fails even though the function already
> does that.
>
> Fix by switching over to the new devm_spi_alloc_master() helper.
>
> Fixes: 9b00bc7b901f ("spi: spi-gpio: Rewrite to use GPIO descriptors")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: <stable@vger.kernel.org> # v4.17+: 5e844cc37a5c: spi: Introduce device-managed SPI controller allocation
> Cc: <stable@vger.kernel.org> # v5.1-: 8b797490b4db: spi: gpio: Make sure spi_master_put() is called in every error path
> Cc: <stable@vger.kernel.org> # v5.1-: 45beec351998: spi: bitbang: Introduce spi_bitbang_init()
> Cc: <stable@vger.kernel.org> # v5.1-: 79567c1a321e: spi: gpio: Use devm_spi_register_master()
> Cc: <stable@vger.kernel.org> # v5.4-: d3b0ffa1d75d: spi: gpio: prevent memory leak in spi_gpio_probe
> Cc: <stable@vger.kernel.org> # v4.17+
> Cc: Navid Emamdoost <navid.emamdoost@gmail.com>
> Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

That's a really good fix. Thanks to looking into this!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
