Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB751CA7D8
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 12:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgEHKDU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 06:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgEHKDT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 May 2020 06:03:19 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89582C05BD43;
        Fri,  8 May 2020 03:03:18 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a7so4043473pju.2;
        Fri, 08 May 2020 03:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Fg0tqQ7YdDHVvpo6cAydXlG7VoLZVAf5Pe+YX8RF1U=;
        b=u/NCyVG6CzWS7pw0cVQAQnsq+Lf6SFeLH7drFG01yY59AfQ7lMhouQ3Pg2ToMqbJQL
         2POW+E2A5sROd3nUY8fmotQr5FoH2M/JlcIIkysWB8eO8ogi6JXo+H56/wpD4EfUJ5n0
         994SFeBIX7AJ1nG1Rz3CwPP4hoUHla1nDCpFo5RAE0ekzm6MAYZJjxK+jSvng+sF9HIt
         6KNmn+2qIDY410kZd7xhCIb0cmC+ipwD+fjNCWAnw2dujVHotaxpAsxRwA9IEcOHukpk
         Rn/FzsDrK+46oQqBtt24AOFdR1meEYkGeqetdSO0HNrJ15VPF76HEodrshyYicE1r7o5
         nEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Fg0tqQ7YdDHVvpo6cAydXlG7VoLZVAf5Pe+YX8RF1U=;
        b=T6gt70RpdDsVNPB6O4FYQ5/iIhlaaAnkiay+/BqubM/Guxtx6S+k7J4YJ/IlMznogY
         2iOWZTj9Qbllq1PSOXLyrkzq8SNE6BrnMZCWUXlI22iEDhul58bJOcRu+mQ6hZQwFQcq
         eeLhBIkaN36NgCJ2MMaYj4DcjGp3Nl8z9Qcm9+rvYcSfAiMDhN1h3GcniBoXs1mwIQV6
         lXv8wXGxo/7Ci1N/zVP+UfVqLOhjuZ4ZuIVXhbTKXos2MdOL3iSiJjQSiTRAG966Crbx
         jqL9VigZvBmN7iG6Nyol7ACB8SP/N+S4+d7oMq9IO1v77NFLUDlFBht/qSv9FOI/TYQ1
         YqDw==
X-Gm-Message-State: AGi0PuZ4eswVW4llvECyxkmHKW+X7cuThYPTi/yQa0b6kyW1N8rzlbGI
        nDJy5ibOMZIFsedyZeXAEI49Nf3dlY6vebqd7Uk=
X-Google-Smtp-Source: APiQypIYSY85bDmuNcTHocu/ewpdNMG8j/aKGbo5ccq1Q5fhJ062xJSYj+xkopkvK/UvMdGwbYVbRLif6bs3S8dCqrc=
X-Received: by 2002:a17:902:6901:: with SMTP id j1mr1688511plk.255.1588932198001;
 Fri, 08 May 2020 03:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200508093621.31619-1-Sergey.Semin@baikalelectronics.ru> <20200508093621.31619-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200508093621.31619-3-Sergey.Semin@baikalelectronics.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 May 2020 13:03:11 +0300
Message-ID: <CAHp75VdtzdX-sOvq2cZdXqGUmU=0rdzQW_USGD_q0D59pUMTWg@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: Add Baikal-T1 System Boot SPI Controller driver
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Eddie James <eajames@linux.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 8, 2020 at 12:37 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> This SPI-controller is a part of the Baikal-T1 System Controller and
> is based on the DW APB SSI IP-core, but with very limited resources:
> no IRQ, no DMA, only a single native chip-select and just 8 bytes Tx/Rx
> FIFO available. In order to provide a transparent initial boot code
> execution this controller is also utilized by an vendor-specific block,
> which provides an CS0 SPI flash direct mapping interface. Since both
> direct mapping and SPI controller normal utilization are mutual exclusive
> only a one of these interfaces can be used to access an external SPI
> slave device. Taking into account the peculiarities of the controller
> registers and physically mapped SPI flash access, very limited resources
> and seeing the normal usecase of the controller is to access an external
> SPI-nor flash, we decided to create a dedicated SPI driver for it.

It seems a lot of code.
Why can't you use spi-dw-mmio.c et al.?

> The driver provides callbacks for native messages-based SPI interface,
> SPI-memory and direct mapping read operations. Due to not having any
> asynchronous signaling interface provided by the core we have no choice
> but to implement a polling-based data transmission/reception algorithm.
> In addition to that in order to bypass the automatic native chip-select
> toggle the driver disables the local interrupts during the memory-based
> transfers if no complementary GPIO-based chip-select detected in the
> platform.



-- 
With Best Regards,
Andy Shevchenko
