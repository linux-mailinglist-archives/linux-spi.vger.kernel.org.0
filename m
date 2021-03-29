Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA06834CE1D
	for <lists+linux-spi@lfdr.de>; Mon, 29 Mar 2021 12:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhC2KpV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Mar 2021 06:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhC2KpK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Mar 2021 06:45:10 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F915C061574;
        Mon, 29 Mar 2021 03:45:09 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id c204so9622193pfc.4;
        Mon, 29 Mar 2021 03:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=17mD/N+pfRdGqAXjZreT7ERVYLzrgDL4pkzCjHv2FHk=;
        b=NjcF+H6F89m+oC1rb8okcXNxFSNarVxUtJM13eV6dFF6t32uarJFCUirsN3XcPZhjm
         f+lYGA53V+7OMPjsIpw6EsccyM8QxXPK5ykZ7/SGqd8D/XxtpyMFJufPdJveDwn5jqhi
         FKQ/NyDLvVvABOtAE0IEZyzdlKsSb6E4KeqT1PH9Yd1efW/owjfA+UKHXvRnlcqyJ8qr
         ztQ9fiulSlx8pki8kl7+ceDYOA4wNtQXnbhxJepxOqVEJyQdWfkmX8kXz2FF9T/ZN7gQ
         JVfDzb2BfvrSqxR/Z0bbLp35ol58BdW+qTYR8ksngfEELPFgLrrvfFuLzCW1yCHwxny7
         y0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=17mD/N+pfRdGqAXjZreT7ERVYLzrgDL4pkzCjHv2FHk=;
        b=o5cTfijEtIrjKPfO/DoIiXFhOtsxtZ00yQjbrii2yCMfFjTZeOa6ty6It351W77Mam
         J4coHjFt/mnX7lDNQrxxHtieBe4+iDKkoJVIAfitS4/rxEJ7+qS8Y2dINFD9OuGSWPSS
         RSNRfk2B4rGVGQcJyjXACFqNKs5Snap+w1Qc461GnX1wcLcXpsEJuuGuFQXy3+wApzAF
         V2oYXlld+rMg/28Pq3pbd75N2GmIYxxywVAhHCLN/OSt5jrXL28b4gzFpqaoKjHUlTUg
         sdibkbq29ZfgJqU8Zjj3yJxlZYI9PydjNwcesxFRkSrEOUZ8cEfiWYhfk+bLhwuKnH3P
         OP0g==
X-Gm-Message-State: AOAM533Nop5MEfPg2nzb3k3DGl6WX4RaqaMwb7Z8278Ou5ZCh+7BKn7G
        xghTOS3b5CSplhM/J+3L+Em/d1OyTQbTDCO0/Jo=
X-Google-Smtp-Source: ABdhPJwHP92tSdGuwxvDa7ZvxKqFLAgsKmi0yOXZW1Io7claGA7iF/5M81+skP6F8dxf5Er/8ioTSsxl1BauSsg1VFQ=
X-Received: by 2002:a62:7c43:0:b029:1ef:20ce:ba36 with SMTP id
 x64-20020a627c430000b02901ef20ceba36mr25100902pfc.40.1617014709016; Mon, 29
 Mar 2021 03:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210329015938.20316-1-brad@pensando.io> <20210329015938.20316-5-brad@pensando.io>
In-Reply-To: <20210329015938.20316-5-brad@pensando.io>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Mar 2021 13:44:53 +0300
Message-ID: <CAHp75VeQmc5ZyQV9AHcq2wm0xxBXb7by7RhidrRyCzmtRkXBAg@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] spidev: Add Pensando CPLD compatible
To:     Brad Larson <brad@pensando.io>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Mar 29, 2021 at 5:01 AM Brad Larson <brad@pensando.io> wrote:
>
> Pensando Elba SoC platforms have a SPI connected CPLD
> for platform management.

And? It's not a good justification to spread the (debugging only)
spidev interface.

What tool is going to use it? Why can't you have a driver for that in
the kernel?

-- 
With Best Regards,
Andy Shevchenko
