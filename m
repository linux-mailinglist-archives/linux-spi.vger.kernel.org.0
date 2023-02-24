Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629BC6A1A8C
	for <lists+linux-spi@lfdr.de>; Fri, 24 Feb 2023 11:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjBXKsY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Feb 2023 05:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBXKsX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 Feb 2023 05:48:23 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4239D12F10
        for <linux-spi@vger.kernel.org>; Fri, 24 Feb 2023 02:48:22 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bt28so6797099wrb.8
        for <linux-spi@vger.kernel.org>; Fri, 24 Feb 2023 02:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HR0UWQKqPA3ewcsqzjhlOUtNlnfP6392kIgsSTEs7d8=;
        b=mFDonIVCSZ0rdWjYufm4eMvD1LnS53ToUl9EKyG7g8JO+Rw3SGGn2yjcH2XfVaI4jd
         XzYd933WnqWkKbOdDS9KEv4CdiagfLwwrTWFvUemRchLFrPChk2lmOAUY2VhL1HdsCrG
         iyBVb2K6+rbHWzjs0OjUtW2I84AZoHuiLNFxCVtCTJT77XWJPqsuv1GQeZpyPpp6Iy15
         l4MxJO+qfAmeD2MrXBiFD0dE0PejaR2H1f2M1GvTZ3+FqENUgZji00S4Se19dBrE4lYI
         DTkPhWeqLQAaaHHt0l1em42bfTMhEHBDeoAFM6vzL2aupPc8clHQmmJjWYSJ9asXu3ZY
         FMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HR0UWQKqPA3ewcsqzjhlOUtNlnfP6392kIgsSTEs7d8=;
        b=uZwY466E9Oa2K0xW/qcY/VUPIJgh1ZyfFHUMBHupkyL5I/M2qq//yWsxh7Wt68i0x6
         nJmUPC850n9sjQM9pxoy6XqvGyoFsGopFLWd0pF6Mxs4ulmH9QkTz6HHz6uE2ANDDLTp
         oEXDGEAByGmwChJC8CaewCtW+XfP/xw06t+uhA+g+AnbLPqs+InIztu7ywXKWM5oHWrd
         9ekIUvI7Xdr0AFEIitgkz8fudEjExrC+6uU9NS9MgNVHuCVAQMbo/48TMifU0Z1mWTOz
         UCev+HtKgHfcjpJY9Ocvw2NzZVgaFf8FN7x7B6Iy4VQzcga4Tuy2wrGpZ3Ejugdq3U9s
         OcQA==
X-Gm-Message-State: AO0yUKVwaFZp0kiPcKHcRNZ517gt0Nc/PUPexZANGVagfqeuWhUagbgt
        AW9E46I54iuD8sUqppKsgAVmsmCNrLWm69Q8QGu7SA==
X-Google-Smtp-Source: AK7set+t2ZMXxJdkymq/f433ab9d1M38NcOpbgsjxwuHP9yBszDXCzcxLzuD8X8eMuxSDUIbKIbUnFuGPUkJsIOSTvs=
X-Received: by 2002:a5d:59a9:0:b0:2c7:e48:8ca4 with SMTP id
 p9-20020a5d59a9000000b002c70e488ca4mr1099157wrr.2.1677235700730; Fri, 24 Feb
 2023 02:48:20 -0800 (PST)
MIME-Version: 1.0
References: <20230219183059.1029525-1-xiang.ye@intel.com> <20230219183059.1029525-3-xiang.ye@intel.com>
In-Reply-To: <20230219183059.1029525-3-xiang.ye@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 Feb 2023 11:48:08 +0100
Message-ID: <CACRpkdYdDE+B=SF+kAuQBiwUi31y_xELLXuDK+9G+rqD9MQBGg@mail.gmail.com>
Subject: Re: [PATCH 2/5] gpio: Add support for Intel LJCA USB GPIO driver
To:     Ye Xiang <xiang.ye@intel.com>
Cc:     Lee Jones <lee@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Tyrone Ting <kfting@nuvoton.com>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-gpio@vger.kernel.org, srinivas.pandruvada@intel.com,
        heikki.krogerus@linux.intel.com, andriy.shevchenko@linux.intel.com,
        sakari.ailus@linux.intel.com, zhifeng.wang@intel.com,
        wentong.wu@intel.com, lixu.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Ye,

thanks for your patch!

I think your colleague Andy Shevchenko will provide the most detailed
and deep feedback, but here are some things I spotted immediately:

On Sun, Feb 19, 2023 at 7:31 PM Ye Xiang <xiang.ye@intel.com> wrote:

> This patch implements the GPIO function of Intel USB-I2C/GPIO/SPI adapter
> device named "La Jolla Cove Adapter" (LJCA). It communicate with LJCA
> GPIO module with specific protocol through interfaces exported by LJCA USB
> driver.
>
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>
(...)

> +config GPIO_LJCA
> +       tristate "INTEL La Jolla Cove Adapter GPIO support"
> +       depends on MFD_LJCA

I would add

   default MFD_LJCA

so if you activate the MFD you get this subdriver by default
as module or built-in depending on what the MFD is built
as.

(Same goes for the other subdrivers I guess)

In addition you need:

select GPIOLIB_IRQCHIP

since you use this facility.

> +static struct irq_chip ljca_gpio_irqchip = {

static const ...

> +       .name = "ljca-irq",
> +       .irq_mask = ljca_irq_mask,
> +       .irq_unmask = ljca_irq_unmask,
> +       .irq_set_type = ljca_irq_set_type,
> +       .irq_bus_lock = ljca_irq_bus_lock,
> +       .irq_bus_sync_unlock = ljca_irq_bus_unlock,
> +       .flags = IRQCHIP_IMMUTABLE,
> +       GPIOCHIP_IRQ_RESOURCE_HELPERS,
> +};

Yours,
Linus Walleij
