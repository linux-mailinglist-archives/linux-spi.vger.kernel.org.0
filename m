Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C857253857
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 21:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHZTgd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 15:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgHZTgc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Aug 2020 15:36:32 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA77C061574;
        Wed, 26 Aug 2020 12:36:32 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d19so1598619pgl.10;
        Wed, 26 Aug 2020 12:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ud+hAaCROu/aZycapYYqslpUeLOacrK4Jlp2cPqS/jE=;
        b=c9V3n4Za3diymB1HJ/nHHbAioxKv/9zo9tCkVT/oQcbSru/Yw6OCX9+Qu2MqbyXDql
         9m0Epe1MTL4CI1PrIVngo8l6MTB6ktjDfI58STfLWMzrupjA3mYFY1VrlyNIwo48Q723
         USUQ1jr1h8Ls6YKgalt9DWl/jtJRS+v9CKR5c2IJ3MhrWgtaLVAFeZWkGU2xTDXv+xy7
         nqqkEN5ghOCY3S+tIzIqoqCWAu+Hpp2YWl114WL1V9V8ULCx39F8EB6WTulBNVi2S4I5
         Ssahm90pvklWFsrsXuUp8pgcvTano+vRWNKkTguTMfyRt/3m1H6g47bTU8enWmbkyovU
         PBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ud+hAaCROu/aZycapYYqslpUeLOacrK4Jlp2cPqS/jE=;
        b=ZxKDF2pn145MNdMgyMlBBnTryH+HrKLZ1y06RPphXmSaGH2CqrnQeQYQyGk5qPgdjZ
         CJT7YROimkWnp38SWP7S29QUtcWPLhJAKfJfskkpE5/Y5dslYDyjAxmlU+bkjSZriM/s
         qCEeeu7KWPa3DFHSz1BFL7JU0T2pTulf2zZFAdB937LEXLmi4GWZjZ5Kvbyv1R5TaUse
         qNGB3CYQeG2+u4YRQS+g/8Ep4tKVCItAS2rEVeObwivHD3/qaXILOq2xTuNxx49s4yCg
         ADNn5KYCAJdXmPSwv43m8a74vrarfP2ug2eelOJx2XhBY3Bgah1XtsKUvFDWe3Xbi1Cz
         m4Bw==
X-Gm-Message-State: AOAM530x8y5sz/GwZatDDCnVBHaFqfJuK2I9C0dQha6d40MTugPj1UYJ
        ZyNUD1vlCR9hvyt+K3M5AYRBSB7QimrMdQ83yF4=
X-Google-Smtp-Source: ABdhPJxsfrZpkr3NGOF+AsJzLuIpdTtILYu1EiJCQNu0puqEGa0gdWgkCHt09Wf3So2Kzcdcvf6wIAx0fQQ4PpHyy3s=
X-Received: by 2002:a17:902:b194:: with SMTP id s20mr13417765plr.321.1598470591807;
 Wed, 26 Aug 2020 12:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
 <20200822183342.6sdhp6yq6i7yvdia@skbuf> <CAHp75VeNXy1jWNWMuZc0bfXruKc3=0H4ezwpE8jbj6GLYk5QBA@mail.gmail.com>
In-Reply-To: <CAHp75VeNXy1jWNWMuZc0bfXruKc3=0H4ezwpE8jbj6GLYk5QBA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Aug 2020 22:36:15 +0300
Message-ID: <CAHp75VetYbnOHv3LQhq4Gvs1CFe8LnZPzFAVoNmBi5DyAmZ9Jg@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Add ACPI support
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        tanveer <tanveer.alam@puresoftware.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Aug 26, 2020 at 10:34 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Aug 22, 2020 at 9:37 PM Vladimir Oltean <olteanv@gmail.com> wrote:
> > On Fri, Aug 21, 2020 at 06:40:29PM +0530, kuldip dwivedi wrote:
>
> > Just noticed this now.
> > So for device tree, spi-fsl-dspi supports the following compatibles:
> >
> > fsl,vf610-dspi
> > fsl,ls1021a-v1.0-dspi
> > fsl,ls1012a-dspi
> > fsl,ls1028a-dspi
> > fsl,ls1043a-dspi
> > fsl,ls1046a-dspi
> > fsl,ls2080a-dspi
> > fsl,ls2085a-dspi
> > fsl,lx2160a-dspi
> >
> > Depending on the compatible string, the driver knows whether to use DMA
> > or XSPI mode, and what the FIFO size is.

FIFO size can be read from the property (or better if you can derive
it directly from HW, like DesignWare does).
DMA is just defined by FixedDMA resources (your platform with DMA
provides them, otherwise no such resources).

> > Now, of course not all of the above SoCs are going to support ACPI, but
> > it is reasonable to expect that more than one will. And in that case,
> > the driver should still be able to know on what SoC it's running,
> > because for example LS1043A doesn't support DMA, and LS2085A doesn't
> > support XSPI.
> >
> > How is this dealt with in ACPI?
>
> Theoretically you may declare your HID in the same / similar way as
> PRP0001 and use same compatible strings and all other DT properties
> (when they make sense and not duplicate ACPI functionality).
> But better if ACPI people can tell you (I Cc'ed Rafael and ACPI
> mailing list) if it is gonna work.


-- 
With Best Regards,
Andy Shevchenko
