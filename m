Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3905C2C24E7
	for <lists+linux-spi@lfdr.de>; Tue, 24 Nov 2020 12:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbgKXLqZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Nov 2020 06:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730158AbgKXLqZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Nov 2020 06:46:25 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991DEC0613D6;
        Tue, 24 Nov 2020 03:46:23 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id e8so6346941pfh.2;
        Tue, 24 Nov 2020 03:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=buSpzXUtIeL+McfJ1DEiPnWXeEXGUpNJL7/qNJJbAlM=;
        b=D998FmhjB5B2xDCDEp+JDjQ4K+8LlGNcsP7KY1R4aGtLT5O5/AalANKwy7SgHk3oik
         L6dPRBl4AM+SBPPdO0QY5T4TYirpzsACMs0PdXrKBoLRm3z1Y2xu8KpcHMsJLSxXUstr
         gK0nfZBbodDRAoz8cQITIZnAYdGYgbuSruQwugxBkGaoBGJYS7DwRtpdwOFov83q884V
         ZR0uJF5wn1JdOyYXs16rHt4znU/c5CHQ9lBRTQ7EzCeoF/a1bVZ+7BOyfnEYM/HlCEug
         wh8QJdT084iYhIGRhVuRRRslDyrdzfjoBi2CP16WqkYfldycfACc4SZdxX/GHXQ4hp/V
         2yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=buSpzXUtIeL+McfJ1DEiPnWXeEXGUpNJL7/qNJJbAlM=;
        b=I/5mPaL0m4GD2Y32Yl43ha6JK4j4CWopkNKsPqOLz7Rsfo8S92G0s/MrQtiTkBAZlj
         sKKsLsvJ++tp8alVSAbnOHC8xlKPpVlz+Kf+Ls3CtjOHS91uW7jIEo/N4kkOSMfuwGqb
         lkYa0Z7c7gpDjkI476uNzuPuDBftWglEGtpd1CCb81nqEZUypobiRWW+WV8RvQfpTXYS
         R66HH5/mpZ50or625XiF0P5llj5Z86Qv4EWYPsrEEJLMn00PjgJ7FXjFsHRjL03fAZ3A
         T2RpBZpNjrQoph7iAvJfqgoUDwAtUFToRDCRMw2T9XUqCRU79sHSmICYJQTiKD0cyVqe
         detw==
X-Gm-Message-State: AOAM531UiB8eNa7XDbzi94ve1jg7S5tLCIY3rFkmCWCR5mzAt1Ctr7tI
        dyXS+2lFOivC1qASzIS14MAU7TkwxweSk095bJQ=
X-Google-Smtp-Source: ABdhPJzR+obGqJHbf/7QR6fNR/gdfiVN9Mh5Mt0sU+CbWcmLeUuiLk5bTbOpVeqBvVl2sxeCyk42EFidoTKopj00iFo=
X-Received: by 2002:a17:90a:d90a:: with SMTP id c10mr4465704pjv.129.1606218382981;
 Tue, 24 Nov 2020 03:46:22 -0800 (PST)
MIME-Version: 1.0
References: <20201124102152.16548-1-alexandru.ardelean@analog.com>
In-Reply-To: <20201124102152.16548-1-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 24 Nov 2020 13:47:11 +0200
Message-ID: <CAHp75VeX8vRKzsE-GCMiDNcVnpXuQ2L2nJALvDyhVL9dO_JA-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] spi: convert to BIT() all spi_device flags
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Nov 24, 2020 at 12:16 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> This change converts all bit flags for the 'struct spi_device' mode to the
> BIT() macro. The change is mostly for readability. Since adding more bit
> fields, might as well convert it now.

...

#include <linux/bits.h>

And honestly I think the entire inclusion block with data type forward
declarations should be revisited here.

...

> +#define        SPI_CPHA        BIT(0)                  /* clock phase */
> +#define        SPI_CPOL        BIT(1)                  /* clock polarity */

-- 
With Best Regards,
Andy Shevchenko
