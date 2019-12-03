Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C994110446
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 19:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfLCScu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Dec 2019 13:32:50 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45238 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLCScu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Dec 2019 13:32:50 -0500
Received: by mail-ot1-f67.google.com with SMTP id 59so3802595otp.12;
        Tue, 03 Dec 2019 10:32:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tBCIvdkJxp6Ju06Z1YC3daONhZ3tTdX5qgewE8IfeFo=;
        b=SB9bPqcUgAYCD9ZsVZIZc2zcLqAfloTPoJMuC/ARFH2Oom78lWr1/f1VvTz5x9WMXQ
         TLzgzen1PKwFDsJfvgdlEVgb9EyBqC17L1fNHocMkMbvu/EItT3OZ/vudYoEh4+XhuQ1
         ldpSAZneKguppkzHE2O/p0GTwha5inoXdpLDDcb8Ax7MBPej6Cui4p442XRUVzmXgqxo
         iKMhAg0O2Hqt2aeIsGhZuawhwqvKA6nyBaSmi6f4hHNokku0TunyYPjTPF5fbZVG2et7
         Ykbj/bx652XiI9p8v7oSqJWYj4vED9yAo9WA6PRHHcDFtPmWmmzahdDlb6eq7zrAuCvC
         QkGw==
X-Gm-Message-State: APjAAAVcbcOc+DfIgDnAxML9smVz0Qatn5M8tKH7p75shtlPj4MUbsRP
        URWs7m0Fa1ByPer40MbP9BYRpnR+nLWd11vr58aB2Q==
X-Google-Smtp-Source: APXvYqzFqyHL8s0QbfDc6IljVgq8V+SsDaJpqdU0rjAChfvUeVPx5BcA8nq51qeGdWH/2t9iDQGg2zyVVWWsJAwJYYs=
X-Received: by 2002:a05:6830:1047:: with SMTP id b7mr4047893otp.107.1575397968953;
 Tue, 03 Dec 2019 10:32:48 -0800 (PST)
MIME-Version: 1.0
References: <20191203034519.5640-1-chris.brandt@renesas.com> <20191203034519.5640-2-chris.brandt@renesas.com>
In-Reply-To: <20191203034519.5640-2-chris.brandt@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Dec 2019 19:32:37 +0100
Message-ID: <CAMuHMdU6NrAk-oeH_tR8Re7bz6HXednfaP=CGsyBt+M4_n95ow@mail.gmail.com>
Subject: Re: [PATCH 1/6] clk: renesas: mstp: Add critical clock from device
 tree support
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
> Allow critical clocks to be specified in the Device Tree.
>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Notes:
  1. Assumed we really need this,
  2. Minor nit below.

> --- a/drivers/clk/renesas/clk-mstp.c
> +++ b/drivers/clk/renesas/clk-mstp.c

> @@ -187,6 +187,7 @@ static void __init cpg_mstp_clocks_init(struct device_node *np)
>         const char *idxname;
>         struct clk **clks;
>         unsigned int i;
> +       unsigned long flags;

= 0 here...

>
>         group = kzalloc(struct_size(group, clks, MSTP_MAX_CLOCKS), GFP_KERNEL);
>         if (!group)
> @@ -239,8 +240,11 @@ static void __init cpg_mstp_clocks_init(struct device_node *np)
>                         continue;
>                 }
>
> +               flags = 0;

... instead of here?

> +               of_clk_detect_critical(np, i, &flags);
> +
>                 clks[clkidx] = cpg_mstp_clock_register(name, parent_name,
> -                                                      clkidx, group);
> +                                                      clkidx, group, flags);
>                 if (!IS_ERR(clks[clkidx])) {
>                         group->data.clk_num = max(group->data.clk_num,
>                                                   clkidx + 1);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
