Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDA5221F78
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jul 2020 11:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgGPJOR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jul 2020 05:14:17 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:45059 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgGPJOQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Jul 2020 05:14:16 -0400
Received: by mail-oo1-f67.google.com with SMTP id a9so1028535oof.12;
        Thu, 16 Jul 2020 02:14:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/umvttECmco9Luei9fOhBDb0CHAUDRcdC1HwBC7Xg4E=;
        b=kcK/rJzXZxApDyoiZZuLljSHQyJy6/TNEQaX83+hCprbK/5ZufeOEeGEjRAB/iOX4a
         NAKzY5H5lm359QkCryq+oU9AriecinLxNTiJ58xH6N+w3YMzuq66S7gg7QAUBbSIeMbR
         NWmf7NNz8pIclCeX6e+RCIQ1GAhfc2/lIIOrOppvotaoLRxNL2mrQHxJa0nPNINlAGK2
         XjevoH2RJJt7qkQ1nZ92ae+w4195dB2aL1A0cX7IRaKzRXGIFzNAdZYWzrcMCe135MNM
         fd6bTv4u7CO6jc5lhkrd9brC8d9P2sWI02c1n7GIOFzS0xZwpkL8SNKBjkz/EF3LieTZ
         6sAQ==
X-Gm-Message-State: AOAM530AmqmbmZr/4eyQl4OZd1sqa8EomuRVApr6sVoza15kcwI86aDP
        X3jASDG7IRv+3mGmdj6zz8xbROTlhRg7mLXzMkmZaj3mWf4=
X-Google-Smtp-Source: ABdhPJwSf2fuE6pEHCZzLONiveYq+x9tlMeGbQ9HdE1AT+cLFo/TujheBOxkigYdt+PGgM07twKCCI9qaORXDl9PdEc=
X-Received: by 2002:a4a:675a:: with SMTP id j26mr268712oof.1.1594890855615;
 Thu, 16 Jul 2020 02:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <1594717754-25428-1-git-send-email-zhangqing@loongson.cn> <20200714094406.GA4900@sirena.org.uk>
In-Reply-To: <20200714094406.GA4900@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 16 Jul 2020 11:14:04 +0200
Message-ID: <CAMuHMdUDYpAvy3NLQGjM62pW35gorac7KZn3E9JnjSvREm5K0Q@mail.gmail.com>
Subject: Re: [PATCH] spi: Use clk_prepare_enable and clk_disable_unprepare
To:     Mark Brown <broonie@kernel.org>
Cc:     Qing Zhang <zhangqing@loongson.cn>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jul 14, 2020 at 11:45 AM Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jul 14, 2020 at 05:09:14PM +0800, Qing Zhang wrote:
> > Convert clk_enable/clk_disable to clk_prepare_enable/clk_disable_unprepare
> > calls as required by common clock framework.
> >
> > Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> > ---
> >  drivers/spi/spi-coldfire-qspi.c | 4 ++--
>
> Are you sure that ColdFire uses the common clock framework?

Should be fine, as per include/linux/clk.h:

    #ifdef CONFIG_HAVE_CLK_PREPARE
    int clk_prepare(struct clk *clk);
    int __must_check clk_bulk_prepare(int num_clks,
                                      const struct clk_bulk_data *clks);
    #else
    static inline int clk_prepare(struct clk *clk)
    {
            might_sleep();
            return 0;
    }

    static inline int __must_check
    clk_bulk_prepare(int num_clks, const struct clk_bulk_data *clks)
    {
            might_sleep();
            return 0;
    }
    #endif

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
