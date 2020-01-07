Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3136113305D
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2020 21:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgAGUKu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Jan 2020 15:10:50 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40203 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGUKu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Jan 2020 15:10:50 -0500
Received: by mail-oi1-f196.google.com with SMTP id c77so588301oib.7;
        Tue, 07 Jan 2020 12:10:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mMtlIZa0y1wMWULM7T02c5kOQ94NS/LmFmoyuL6SjJE=;
        b=ipo6xBhH2acKVHlyYxdHQkoQUg0JzAd0C9+knqbtGYJgdFxy+T6uAn/caDhJJSsyoF
         VXywa6NXM/0REB8YYUsjzOfiAckbNoKjyGUrPFKzCV0d11p5A9Plu1QkJaGjafgRnSlC
         /nq4IZEUknC02QVqmjYx6x2dfkUEuNbF75dgT4CFQ5caCT9hzs5/lAOU7SkohzMIoahr
         1m+1Wd7agbbRI06G5l1KPpufYXEFhIQhcEEFanJxVx4posJeSVLGYq3q5SRLg3BJ3utS
         A8XJQK1+ZKNDCSCIz6JCZX3d5hYLhYLl8Wbdm0jnjRNzGFJRtOjYmhvGlNFFNVqUx1Sf
         lLcQ==
X-Gm-Message-State: APjAAAWqRv7H+3LRRlF76uAKlidJt5X/cHfPMjaI6QekXh0VZNyTnFZV
        YOsr1LRy5XbKEvu9vWb3X5nmG8Eq1JKzMjlhab60O4GD
X-Google-Smtp-Source: APXvYqww2ga10axfUo/emP70OkVnz0TJIWK5SEU2uk8Z5LVrQZkcf7+zP/6NaIsVAXw4xlVpv6qLj27XkqQVtBBmf70=
X-Received: by 2002:aca:1a06:: with SMTP id a6mr138816oia.148.1578427849295;
 Tue, 07 Jan 2020 12:10:49 -0800 (PST)
MIME-Version: 1.0
References: <1578416218-11112-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1578416218-11112-1-git-send-email-krzk@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Jan 2020 21:10:37 +0100
Message-ID: <CAMuHMdXZGqqu+rWmemzxYtSNXofeCwLwerCeb-hEoubTvBqwXw@mail.gmail.com>
Subject: Re: [PATCH] spi: sh-msiof: Do not redefine STR while compile testing
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Krzysztof,

On Tue, Jan 7, 2020 at 5:57 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> STR is a well-known stringify macro so it should be avoided in drivers
> to avoid warnings like this (MIPS architecture while compile testing):
>
>     drivers/spi/spi-sh-msiof.c:76:0: warning: "STR" redefined
>      #define STR 0x40 /* Status Register */
>     arch/mips/include/asm/mipsregs.h:30:0: note: this is the location of the previous definition
>      #define STR(x) __STR(x)
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks for your patch!

> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -73,7 +73,7 @@ struct sh_msiof_spi_priv {
>  #define RSCR   0x22    /* Receive Clock Select Register (SH, A1, APE6) */
>  #define CTR    0x28    /* Control Register */
>  #define FCTR   0x30    /* FIFO Control Register */
> -#define STR    0x40    /* Status Register */
> +#define STATR  0x40    /* Status Register */

The datasheets call this register "SISTR", so I prefer to use that instead.
Actually all registers have this "SI" ("Serial Interface"?) prefix.
Shall I add this to my TODO-list?

>  #define IER    0x44    /* Interrupt Enable Register */
>  #define TDR1   0x48    /* Transmit Control Data Register 1 (SH, A1) */
>  #define TDR2   0x4c    /* Transmit Control Data Register 2 (SH, A1) */
> @@ -161,19 +161,19 @@ struct sh_msiof_spi_priv {
>  #define FCTR_RFUA_SHIFT        4
>  #define FCTR_RFUA(i)   ((i) << FCTR_RFUA_SHIFT)
>
> -/* STR */
> -#define STR_TFEMP      BIT(29) /* Transmit FIFO Empty */
> -#define STR_TDREQ      BIT(28) /* Transmit Data Transfer Request */
> -#define STR_TEOF       BIT(23) /* Frame Transmission End */
> -#define STR_TFSERR     BIT(21) /* Transmit Frame Synchronization Error */
> -#define STR_TFOVF      BIT(20) /* Transmit FIFO Overflow */
> -#define STR_TFUDF      BIT(19) /* Transmit FIFO Underflow */
> -#define STR_RFFUL      BIT(13) /* Receive FIFO Full */
> -#define STR_RDREQ      BIT(12) /* Receive Data Transfer Request */
> -#define STR_REOF       BIT(7)  /* Frame Reception End */
> -#define STR_RFSERR     BIT(5)  /* Receive Frame Synchronization Error */
> -#define STR_RFUDF      BIT(4)  /* Receive FIFO Underflow */
> -#define STR_RFOVF      BIT(3)  /* Receive FIFO Overflow */
> +/* STATR */
> +#define STATR_TFEMP    BIT(29) /* Transmit FIFO Empty */
> +#define STATR_TDREQ    BIT(28) /* Transmit Data Transfer Request */
> +#define STATR_TEOF     BIT(23) /* Frame Transmission End */
> +#define STATR_TFSERR   BIT(21) /* Transmit Frame Synchronization Error */
> +#define STATR_TFOVF    BIT(20) /* Transmit FIFO Overflow */
> +#define STATR_TFUDF    BIT(19) /* Transmit FIFO Underflow */
> +#define STATR_RFFUL    BIT(13) /* Receive FIFO Full */
> +#define STATR_RDREQ    BIT(12) /* Receive Data Transfer Request */
> +#define STATR_REOF     BIT(7)  /* Frame Reception End */
> +#define STATR_RFSERR   BIT(5)  /* Receive Frame Synchronization Error */
> +#define STATR_RFUDF    BIT(4)  /* Receive FIFO Underflow */
> +#define STATR_RFOVF    BIT(3)  /* Receive FIFO Overflow */

[...]

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
