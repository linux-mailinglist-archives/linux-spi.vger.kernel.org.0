Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A501211047D
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 19:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfLCSuH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Dec 2019 13:50:07 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41397 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfLCSuG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Dec 2019 13:50:06 -0500
Received: by mail-ot1-f65.google.com with SMTP id r27so3875485otc.8;
        Tue, 03 Dec 2019 10:50:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n/IueF0tm7laF5bdHeLbJHAxC/4uhEXH1vv+M8nQhkE=;
        b=F38+S5iT4J9GBKYKcKfM4+A0DExOXNMblNe/XezDTqZ5KiY9lGLhSba9o2kh2Xsfpa
         bQrkWn7G9JVNLJZQ0Zhd1JTHxKITkZLR18nQW+V0cqBkk7lI34OgnciqM6WQHc80dq7P
         t61Stpj2MdYnnEfGCOO/TLbL/+n56aU/q+IaJMUKDigzubwj4MHJ9D8uUZ7e27gBIT8J
         pgdNg6deZjudDKTirGJPYiQSKSFK1HtoovwNtYpMRCMJS3DO+PdsvA5fI+gFjtkj4ZPd
         SBG6G7vFl00FiXq3Y9Gz/hO8F4bSmlE2PIvPhcJw5IKM9pGXoTGW782bJbprbWzUKtnX
         59xA==
X-Gm-Message-State: APjAAAWZE0smGLheJjdKG7BOjfJJmwqHvdGTC+DhkaFNMgJ0MrC/G2EC
        Dg15Y6YVwbwvTB27MibiJjmJYNVSfzsTv8XqVb0=
X-Google-Smtp-Source: APXvYqza72NR8nGtR50pASq1EjcexvthIv2CIbQlFhehlVIzVEJyemkXF/BVtU9aTdE7i/8wEqCSmF0I98WfG3Vf2dY=
X-Received: by 2002:a9d:5d10:: with SMTP id b16mr4316033oti.250.1575399005531;
 Tue, 03 Dec 2019 10:50:05 -0800 (PST)
MIME-Version: 1.0
References: <20191203034519.5640-1-chris.brandt@renesas.com> <20191203034519.5640-4-chris.brandt@renesas.com>
In-Reply-To: <20191203034519.5640-4-chris.brandt@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Dec 2019 19:49:54 +0100
Message-ID: <CAMuHMdUxCdJXyY15f6sr+QFNpg9FLsa5pL3171bm_meJcBNR2g@mail.gmail.com>
Subject: Re: [PATCH 3/6] clk: renesas: r7s9210: Add SPIBSC clock
To:     Chris Brandt <chris.brandt@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Chris,

On Tue, Dec 3, 2019 at 4:46 AM Chris Brandt <chris.brandt@renesas.com> wrote:
> The SPIBSC clocks are marked as critical because for XIP systems, the
> kernel will be running from QSPI flash and cannot be turned off.
>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/r7s9210-cpg-mssr.c
> +++ b/drivers/clk/renesas/r7s9210-cpg-mssr.c
> @@ -93,6 +93,7 @@ static const struct mssr_mod_clk r7s9210_mod_clks[] __initconst = {
>         DEF_MOD_STB("ether1",    64,    R7S9210_CLK_B),
>         DEF_MOD_STB("ether0",    65,    R7S9210_CLK_B),
>
> +       DEF_MOD_STB("spibsc",    83,    R7S9210_CLK_P1),

OK.

>         DEF_MOD_STB("i2c3",      84,    R7S9210_CLK_P1),
>         DEF_MOD_STB("i2c2",      85,    R7S9210_CLK_P1),
>         DEF_MOD_STB("i2c1",      86,    R7S9210_CLK_P1),
> @@ -112,6 +113,10 @@ static const struct mssr_mod_clk r7s9210_mod_clks[] __initconst = {
>         DEF_MOD_STB("vdc6",      81,    R7S9210_CLK_P1),
>  };
>
> +static const unsigned int r7s9210_crit_mod_clks[] __initconst = {
> +       MOD_CLK_ID_10(83),      /* SPIBSC */

This is only a critical clock if XIP is in use, right?
Can we do better, and only mark it critical if we detect the FLASH is
used in XIP mode?
E.g. by using for_each_compatible_node(..., "mtd-rom"), and checking if
any of the corresponding register blocks matches the SPIBSC FLASH
memory window?

> +};
> +
>  /* The clock dividers in the table vary based on DT and register settings */
>  static void __init r7s9210_update_clk_table(struct clk *extal_clk,
>                                             void __iomem *base)
> @@ -213,6 +218,10 @@ const struct cpg_mssr_info r7s9210_cpg_mssr_info __initconst = {
>         .num_mod_clks = ARRAY_SIZE(r7s9210_mod_clks),
>         .num_hw_mod_clks = 11 * 32, /* includes STBCR0 which doesn't exist */
>
> +       /* Critical Module Clocks */
> +       .crit_mod_clks = r7s9210_crit_mod_clks,
> +       .num_crit_mod_clks = ARRAY_SIZE(r7s9210_crit_mod_clks),
> +
>         /* Callbacks */
>         .cpg_clk_register = rza2_cpg_clk_register,

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
