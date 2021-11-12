Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEAD44EEAA
	for <lists+linux-spi@lfdr.de>; Fri, 12 Nov 2021 22:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbhKLVds (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Nov 2021 16:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbhKLVdr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 Nov 2021 16:33:47 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B730C061766;
        Fri, 12 Nov 2021 13:30:56 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id b15so42709075edd.7;
        Fri, 12 Nov 2021 13:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=upYLEdupDNox5jXdQKuYmxmwPj0sDE+nmNrr17J9jqA=;
        b=VB0tYNRuU9lbQ8MMvuXdWHThrt/oXTesahTbLyVqYQBbJum+fJW1UAX1Du9bqyXwb2
         IwY0hMijlCV9PGf9+abwSRj2HPIs78fcnBsmGOIqRPJuYXc+GtVA0cYN9q46md4At50X
         /Y+oEkUeWAQtojYVpk/JV4Huxr3NCBzZ61gzJ5Dz+HTO3NBB4DDWYXOHZQXGzhhiNvjr
         Cw8yoo0FWwOI4Z3cYSkjHonWgFbCSFPAAqvPcoCxe3NFy1zbqTJFG57VC/UyWEXPl43/
         ZdDtavFZ+FyCshDYsD9/8FL6nLmFIo3dzwxQqemrBY5MHJtERKYmZpgQApbeR6ANSm4B
         d9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upYLEdupDNox5jXdQKuYmxmwPj0sDE+nmNrr17J9jqA=;
        b=a7PXwWw1X8raF5iA06VovKRlRtizvXO7xDLJrVc5ed+pYdVpY3ksv1KtOHqe3DouX/
         C1Tt75WnK5EkvkWVV5vYcFuTYjQfVq+LuIAVENQCDkDPjuElGtQR8JG6HCItwgiiWf2I
         hqmMjIc27irTtJnl8vLQ8QOBdgyEeGuBeAgYv3J04HLo6o+pD/iJjM8FOozmRJ4+uXX8
         k10Mde0O4TJ0ck6y8n7eDDrMPqUjxVVcn21uuAFRjiGd76JSAG7T7i4DNRohXVU1Bl8P
         M8hRGwI7sk+Sep9MxLT9XvWIDM9gohoAyYPiZAX0qEKZrT0VjGBlyZpgHJLWwy7QiMS7
         rRGQ==
X-Gm-Message-State: AOAM531AogEE3S79gJCaPmlA46oRjZRA+1eChtumqAl4bFZkkCDn6zl/
        CaKTXdAqdpb4bbrqGVeC4IZ8pvsdmSJiLPWesTo=
X-Google-Smtp-Source: ABdhPJxzNRmZGjQS1v9Auo4i3LbNk0+fFO5gpXz85xy7BOE4e5XiO1wcFO5/V2PU4Iasqmv6Tj2yd+tMqFpsi5CHrSc=
X-Received: by 2002:a17:906:ecac:: with SMTP id qh12mr22607421ejb.377.1636752655134;
 Fri, 12 Nov 2021 13:30:55 -0800 (PST)
MIME-Version: 1.0
References: <20211112204927.8830-1-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20211112204927.8830-1-Sergey.Semin@baikalelectronics.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 12 Nov 2021 23:30:11 +0200
Message-ID: <CAHp75Vdi0p5v93pjMoMSRqi2Q3N5+Px2et0DAjFFofAgKykmZQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] spi: dw: Cleanup macros/funcs naming and add IP-core
 version support
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Nov 12, 2021 at 10:51 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> This patchset consists of the changes which I was going to introduce for a
> long time, but due to lack of free time couldn't make it so far.
> Nandhini's series [1] made me to proceed with this task so mate would
> finally have his patchset accepted and merged into the mainline kernel.
>
> There are three cleanup patches here and one feature patch. In framework
> of the former patches we suggest to better organize the code. In
> particular they concern the methods and macros naming unification (using a
> unified prefixes of the code object names) and CSR fields macro
> implementation using the bitfield helpers available in the kernel. The
> later patch introduces the Synopsys Component Version register parsing
> procedure so the corresponding data could be used for a version-specific
> features implementation.  Nandhini will be mostly interested in the later
> patch in the framework of his series [1].
>
> Nandhini, could you please test the patchset out on your DWC SSI hardware?
> After it's merged into the spi/for-next branch of the Mark' repository you
> will be able to rebase your series on top of it and use the last patch
> functionality for your benefit.

Thanks!
I have no objection to the series, just a few nit-picks here and
there. Most important one is 4cc usage.

On top of that, please consider switching to use
EXPORT_SYMBOL_GPL_NS() (in a separate patch, perhaps as a
prerequisite).

Nevertheless,
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

And with addressed above
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> [1] https://lore.kernel.org/linux-spi/20211111065201.10249-4-nandhini.srikandan@intel.com/
>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: linux-spi@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>
> Serge Semin (4):
>   spi: dw: Discard redundant DW SSI Frame Formats enumeration
>   spi: dw: Put the driver entities naming in order
>   spi: dw: Convert to using the Bitfield access macros
>   spi: dw: Add Synopsys Component version reading and parsing
>
>  drivers/spi/spi-dw-bt1.c  |   8 +-
>  drivers/spi/spi-dw-core.c | 165 ++++++++++++++++++++++----------------
>  drivers/spi/spi-dw-dma.c  |  50 ++++++------
>  drivers/spi/spi-dw-mmio.c |  20 ++---
>  drivers/spi/spi-dw-pci.c  |  59 +++++++-------
>  drivers/spi/spi-dw.h      | 150 +++++++++++++++++-----------------
>  6 files changed, 236 insertions(+), 216 deletions(-)
>
> --
> 2.33.0
>


-- 
With Best Regards,
Andy Shevchenko
