Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3657313596D
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jan 2020 13:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgAIMnA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jan 2020 07:43:00 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35216 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgAIMnA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Jan 2020 07:43:00 -0500
Received: by mail-oi1-f196.google.com with SMTP id k4so5739988oik.2;
        Thu, 09 Jan 2020 04:42:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5b8WOilK1IrwHRtFhRNVvo/rjsABUHvrgsqsBsmDLI4=;
        b=OpnSb96NqXphNgETqeDdw7kiNUT7Qh4gmVRUoVaBMHakM1XLYLIrHAJU+4g7NUMT2O
         i8xtERQ+yMnpxXMZnaF0Z+Wm488lEM+MgoU2/n8ZZaxW22Bf+Ia0ADVPodRgVc8fU+QS
         3+ZYY+sx4NyKrV23m71oNBw3zqL1KkUmrhCenYO/wiO134IeR1D5T3+Jofr4kDPz6A4R
         eP/K74Nz77ZIaV7OmlZr2pgyTwiSDkk7xJ7uDW+GL/WPm2aDj+Kenpbt6Rbc/MK8ie9W
         1fnt34gm1uFz5or7PbqczU1f4UV/9GsxdeZtPPG7OZFtr4IUK+usXsVvM/R81uV9mOPk
         H9Rg==
X-Gm-Message-State: APjAAAVcqipVa9BTyw7lvnhsjrBgDR13NxS8+gNKxyIzcOTuVqaJ5hWb
        KoSlN6giCZ8QPl57kygiB78PB/P/ZbrD51lHhaw=
X-Google-Smtp-Source: APXvYqyjPciL5ImdOhy2RbmXSWJK2wsv8b//9lehF3BjfcAPF2PyCJE2VWEqA3KnOaS4ZJpUqXiQ1hujiPrv9qZnE00=
X-Received: by 2002:aca:5905:: with SMTP id n5mr3014582oib.54.1578573779420;
 Thu, 09 Jan 2020 04:42:59 -0800 (PST)
MIME-Version: 1.0
References: <20200108194319.3171-1-krzk@kernel.org>
In-Reply-To: <20200108194319.3171-1-krzk@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 9 Jan 2020 13:42:48 +0100
Message-ID: <CAMuHMdWM97k7iG_Er=VCLF0EPo6R1sK7+ZsSwjQB0b4WO88U6A@mail.gmail.com>
Subject: Re: [PATCH v2] spi: sh-msiof: Do not redefine STR while compile testing
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Krzysztof,

On Wed, Jan 8, 2020 at 8:43 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> STR is a well-known stringify macro so it should be avoided in drivers
> to avoid warnings like this (MIPS architecture while compile testing):
>
>     drivers/spi/spi-sh-msiof.c:76:0: warning: "STR" redefined
>      #define STR 0x40 /* Status Register */
>     arch/mips/include/asm/mipsregs.h:30:0: note: this is the location of the previous definition
>      #define STR(x) __STR(x)
>
> To maintain consistency between all register names add a SI prefix to
> all of them.  This also matches register names in datasheet.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Changes since v1:
> 1. Use SI prefix,
> 2. Adjust all register names.

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

No changes in object file, so:
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
