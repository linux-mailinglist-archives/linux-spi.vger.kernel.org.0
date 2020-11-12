Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF212B0043
	for <lists+linux-spi@lfdr.de>; Thu, 12 Nov 2020 08:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgKLHV3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Nov 2020 02:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgKLHV3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 12 Nov 2020 02:21:29 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9536C0613D6
        for <linux-spi@vger.kernel.org>; Wed, 11 Nov 2020 23:21:28 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id a20so4319975ilk.13
        for <linux-spi@vger.kernel.org>; Wed, 11 Nov 2020 23:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ab2X7D8rQV+rUh3MG2vmCj3eeC4kvsZIlLSd9hzapi4=;
        b=o695KMSlvlKK8s2nZB3RnNNjASazEvqZxx7SlWDLIfkA7DjvTGHQKtr7OeUjA+JK/W
         6AsWT7BcKyt6qJFEm42kuZq/NhNqqk+O/5M33EKitgOxYwwKwIv4xVOTPW0KtSDKxWoi
         N/WtmAKQP0MX+WWeb1AnqArll7M6n1MD4y/2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ab2X7D8rQV+rUh3MG2vmCj3eeC4kvsZIlLSd9hzapi4=;
        b=WiilN/ULoadMTFhnC6oCCPx0kogr5q3n/zXuRNy6yVvc/PZLYKF1l6blDNo6hIk2IH
         Q88enG54CSJiG1/SsikJlVXi4i4IeSHtA2fb/UBsxBF9FTT2yvxX9lkZtQ+YnbIz1S3R
         yvNh1Yk++EmSg5um1E3cpWqFaEanUdHYsK0wii5kJ4FG2okW1go8SldHL6ta4WG8UiHB
         4NzEyH+HgdNQ6cSd7g4d6KgFbWgyrrL62tC8tTF913B56PHK5r9DQKr15++f2Espbyvp
         KhpwTbllAPqBxBpTz7SS84HqWlSuBqqDOz9ynEE2OppVewFHoOc971GSPW289U3YHB4n
         BveQ==
X-Gm-Message-State: AOAM533dCim50Fkm1vwaOs38+SAxxcA7kgzXgqjwJ65qTB0z9gfJpoal
        pzBmZd8gOQ/K02YSGqVEWGPavpNsFn37a2dUuHdW
X-Google-Smtp-Source: ABdhPJwG3l0icsmB1IU32yQpvlFd8k79z2GNzpvnNWW307BnW87hWqYbQJNHXepVhLwR9j1SCouAAn38lAiRUpIrLCw=
X-Received: by 2002:a92:512:: with SMTP id q18mr20861835ile.147.1605165688041;
 Wed, 11 Nov 2020 23:21:28 -0800 (PST)
MIME-Version: 1.0
References: <20201107081420.60325-1-damien.lemoal@wdc.com> <20201107081420.60325-9-damien.lemoal@wdc.com>
In-Reply-To: <20201107081420.60325-9-damien.lemoal@wdc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 11 Nov 2020 23:21:17 -0800
Message-ID: <CAOnJCUJO3Oqy94MbT-eV+xaJn9obE0H=zpvuJuch-aY5e9bfgQ@mail.gmail.com>
Subject: Re: [PATCH 08/32] riscv: Fix kernel time_init()
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Anderson <seanga2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Nov 7, 2020 at 12:15 AM Damien Le Moal <damien.lemoal@wdc.com> wrote:
>
> If of_clk_init() is not called in time_init(), clock providers defined
> in the system device tree are not initialized, resulting in failures for
> other devices to initialize due to missing clocks.
> Similarly to other architectures and to the default kernel time_init()
> implementation, call of_clk_init() before executing timer_probe() in
> time_init().
>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  arch/riscv/kernel/time.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
> index 4d3a1048ad8b..8a5cf99c0776 100644
> --- a/arch/riscv/kernel/time.c
> +++ b/arch/riscv/kernel/time.c
> @@ -4,6 +4,7 @@
>   * Copyright (C) 2017 SiFive
>   */
>
> +#include <linux/of_clk.h>
>  #include <linux/clocksource.h>
>  #include <linux/delay.h>
>  #include <asm/sbi.h>
> @@ -24,6 +25,8 @@ void __init time_init(void)
>         riscv_timebase = prop;
>
>         lpj_fine = riscv_timebase / HZ;
> +
> +       of_clk_init(NULL);
>         timer_probe();
>  }
>
> --
> 2.28.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


Reviewed-by: Atish Patra <atish.patra@wdc.com>

-- 
Regards,
Atish
