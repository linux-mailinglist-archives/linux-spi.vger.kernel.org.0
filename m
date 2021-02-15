Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF3D31BBA2
	for <lists+linux-spi@lfdr.de>; Mon, 15 Feb 2021 15:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhBOO5f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Feb 2021 09:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhBOO5V (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Feb 2021 09:57:21 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6742EC061574;
        Mon, 15 Feb 2021 06:56:05 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id t11so4338623pgu.8;
        Mon, 15 Feb 2021 06:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TC76k1Y6MEUMK5bwvqZnuZ4cNnJ6i3Vn0Cs2byfJ32g=;
        b=j6DeoGWARdpxArhNU0TsAnh8ZO1FyY4F3L8CA5ZLX5E2YTmMTCl+nduZBB/20quxel
         ogChmfFYU6Z/L+4U5WxhGnOTmTIFi4jX6JrThPMmhCzzgcbdwCokAUioqVFbC+Hxi7tg
         cra9whC14u/kPo7P80dbNs5frpyTGeNrkkPY4iCINCzRfEiIe88zUcu4H29N4n0BiSda
         tgymyKZ2UV93Qgx8L0BwdjX9CE7soahwKI/f7kAs6vqLtgbdDjMV3vB4fpovwtbtW9VL
         GIbg0fEKDnZQcl5wferHr9NtkSo0hEJcsbMnCKG3+w3/dE6VjucSpETZOqz3mzjy7TFk
         ubcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TC76k1Y6MEUMK5bwvqZnuZ4cNnJ6i3Vn0Cs2byfJ32g=;
        b=QN6TO5P0N69iE9/TMjMrx0bmG33rxnmubPwQIky4EyzQ1kT73MaH3a8IdjZp8Qsr+w
         s0uXD5N0lVXscS6xgtNpDIc2H0ZQPo71vrAUOkTf006oM2vc3psRvcdENofUiaOtydIt
         r++9vNLvacCJ65WvC/I9HoJA+Xo9gKLGMlDMr/9zHBu7NdUJkkue5bUH7an6lszdsCrd
         qK+8cLCXyyWTBlrgxd70GkpPIxGgaFn7PKfeCnQvilsoAXMYF2JPb6hJfbOyTf6AhfAB
         Y1dv1OLGCvq7UesyML0YEx3DcPswkMSGHqPSKXMwUC+XJ010WWgToiH2y6tu9TZhTYl6
         5nZg==
X-Gm-Message-State: AOAM532SLsJAGdyJcRPUxnunKQedD3Vzo/EuC/rMwJykryQ7HmooMolU
        65rCZIOHKP/k7VG3Y5rHZfqdJVluscH8A4lpyNLNPOhu+1pPEQ==
X-Google-Smtp-Source: ABdhPJx7tU0s5oAzlCX6KcObAw7pnXe+OUlgIPaSYeanS0I8tIXJCe8bQ9bJp+Qnx650w5yUvGMOyjPhwCs+z0gzmLk=
X-Received: by 2002:a63:3d0:: with SMTP id 199mr15238146pgd.4.1613400964989;
 Mon, 15 Feb 2021 06:56:04 -0800 (PST)
MIME-Version: 1.0
References: <20210214145746.602770-1-zhengdejin5@gmail.com>
 <YCp1nh2ZEBvvB+lC@smile.fi.intel.com> <10fa1c64-6a7d-e995-f292-20dc6ce5ed62@siemens.com>
In-Reply-To: <10fa1c64-6a7d-e995-f292-20dc6ce5ed62@siemens.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 15 Feb 2021 16:55:48 +0200
Message-ID: <CAHp75VdcsnPxOLmHcwVSJn2c9jn2dFuWdyb-hiXaz4iUm2yYgA@mail.gmail.com>
Subject: Re: [PATCH] spi: pca2xx-pci: Fix an issue about missing call to 'pci_free_irq_vectors()'
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Feb 15, 2021 at 3:52 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 15.02.21 14:22, Andy Shevchenko wrote:
> > On Sun, Feb 14, 2021 at 10:57:46PM +0800, Dejin Zheng wrote:
> >> Call to 'pci_free_irq_vectors()' are missing both in the error handling
> >> path of the probe function, and in the remove function. So add them.
> >
> > I'm wondering if you noticed that it's done by pcim_* API.
> > Perhaps you can introduce pcim_alloc_irq_vectors() or so and do not add these
> > calls at all?
>
> You mean as plain wrapper for pci_alloc_irq_vectors, just to document
> it's managed?

Last time we discussed that with Christoph Hellwig he was on the side
that naming is problematic. So he insisted that it's pure luck that it
works like this. And IIUC his point, we need to create an explicit
managed version of pci_alloc_irq_vectorrs() that the caller will have
clear understanding what it does.

> >> Fixes: 64e02cb0bdfc7c ("spi: pca2xx-pci: Allow MSI")
> >
> > No, it doesn't fix anything.
>
> Ah, now I recall: imbalanced APIs.


-- 
With Best Regards,
Andy Shevchenko
