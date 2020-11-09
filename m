Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF572AC7D6
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 22:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgKIV7Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 16:59:16 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45622 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIV7Q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 16:59:16 -0500
Received: by mail-oi1-f194.google.com with SMTP id j7so11920002oie.12;
        Mon, 09 Nov 2020 13:59:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UVi7/sTYybgJh6ZYR3cD0TOWbRw3z1zGkLRVe5rvAZs=;
        b=Uis8XzcYo2lIRvSOYCAEFJUPaeet/6ZuqRTrI3WEZBSl6ItUVPpZzJESSRDSjS6bBR
         fEu5+dOq4XmSnbUlRY3RED0Z6SZo0gjcl+CzD5Lw6Br2vtQPJ3FMRrPY0Ibnglhg9VB0
         WaYlFKmfENF0c3Vr4TZejgGz74dIqoQOnygxHJF04HyVCJjx9bvww2aHrpo8woQ6WOBK
         INmPRUw07FPys1VH9Im4BhSuEgapbKqqm1yHwbIvKlgy7wh5AMOlfa2yawZfSM7BPiPZ
         36DG2zec+KpUiuqggWlT0RfD+g0/gywM/rM+ydf3tKPFLPV+Xh/jfMkxLkCrr6usA1JP
         80Fw==
X-Gm-Message-State: AOAM533bOhEwq6paA6bqfpJqa7nJdwjaEdeQSzRO9eCxkrU0dOQtNZV1
        H9bKJy1pMyS3k3XAIQCFIA==
X-Google-Smtp-Source: ABdhPJyWkgNEZxra4dYV7f+rOtkuIME4kqLOXZ8Ih+K/nSTDfKadg1ResptqO8GoV4nmSP59pNTN2A==
X-Received: by 2002:aca:7250:: with SMTP id p77mr860507oic.130.1604959155207;
        Mon, 09 Nov 2020 13:59:15 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b185sm2691837oif.5.2020.11.09.13.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:59:14 -0800 (PST)
Received: (nullmailer pid 1829665 invoked by uid 1000);
        Mon, 09 Nov 2020 21:59:13 -0000
Date:   Mon, 9 Nov 2020 15:59:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 15/32] dt-bindings: Define Kendryte K210 sysctl registers
Message-ID: <20201109215913.GA1828781@bogus>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-16-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107081420.60325-16-damien.lemoal@wdc.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Nov 07, 2020 at 05:14:03PM +0900, Damien Le Moal wrote:
> Introduce the dt-bindings file include/dt-bindings/mfd/k210_sysctl.h to
> define the offset of all registers of the K210 system controller.

We generally don't have defines for registers in DT.

> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  include/dt-bindings/mfd/k210-sysctl.h | 41 +++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 include/dt-bindings/mfd/k210-sysctl.h
> 
> diff --git a/include/dt-bindings/mfd/k210-sysctl.h b/include/dt-bindings/mfd/k210-sysctl.h
> new file mode 100644
> index 000000000000..5cc386d3c9ca
> --- /dev/null
> +++ b/include/dt-bindings/mfd/k210-sysctl.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2020 Sean Anderson <seanga2@gmail.com>
> + * Copyright (c) 2020 Western Digital Corporation or its affiliates.
> + */
> +#ifndef MFD_K210_SYSCTL_H
> +#define MFD_K210_SYSCTL_H
> +
> +/*
> + * Kendryte K210 SoC system controller registers offsets.
> + * Taken from Kendryte SDK (kendryte-standalone-sdk).
> + */
> +#define K210_SYSCTL_GIT_ID	0x00 /* Git short commit id */
> +#define K210_SYSCTL_UART_BAUD	0x04 /* Default UARTHS baud rate */
> +#define K210_SYSCTL_PLL0	0x08 /* PLL0 controller */
> +#define K210_SYSCTL_PLL1	0x0C /* PLL1 controller */
> +#define K210_SYSCTL_PLL2	0x10 /* PLL2 controller */
> +#define K210_SYSCTL_PLL_LOCK	0x18 /* PLL lock tester */
> +#define K210_SYSCTL_ROM_ERROR	0x1C /* AXI ROM detector */
> +#define K210_SYSCTL_SEL0	0x20 /* Clock select controller 0 */
> +#define K210_SYSCTL_SEL1	0x24 /* Clock select controller 1 */
> +#define K210_SYSCTL_EN_CENT	0x28 /* Central clock enable */
> +#define K210_SYSCTL_EN_PERI	0x2C /* Peripheral clock enable */
> +#define K210_SYSCTL_SOFT_RESET	0x30 /* Soft reset ctrl */
> +#define K210_SYSCTL_PERI_RESET	0x34 /* Peripheral reset controller */
> +#define K210_SYSCTL_THR0	0x38 /* Clock threshold controller 0 */
> +#define K210_SYSCTL_THR1	0x3C /* Clock threshold controller 1 */
> +#define K210_SYSCTL_THR2	0x40 /* Clock threshold controller 2 */
> +#define K210_SYSCTL_THR3	0x44 /* Clock threshold controller 3 */
> +#define K210_SYSCTL_THR4	0x48 /* Clock threshold controller 4 */
> +#define K210_SYSCTL_THR5	0x4C /* Clock threshold controller 5 */
> +#define K210_SYSCTL_THR6	0x50 /* Clock threshold controller 6 */
> +#define K210_SYSCTL_MISC	0x54 /* Miscellaneous controller */
> +#define K210_SYSCTL_PERI	0x58 /* Peripheral controller */
> +#define K210_SYSCTL_SPI_SLEEP	0x5C /* SPI sleep controller */
> +#define K210_SYSCTL_RESET_STAT	0x60 /* Reset source status */
> +#define K210_SYSCTL_DMA_SEL0	0x64 /* DMA handshake selector 0 */
> +#define K210_SYSCTL_DMA_SEL1	0x68 /* DMA handshake selector 1 */
> +#define K210_SYSCTL_POWER_SEL	0x6C /* IO Power Mode Select controller */
> +
> +#endif /* MFD_K210_SYSCTL_H */
> -- 
> 2.28.0
> 
