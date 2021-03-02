Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781A332B4FA
	for <lists+linux-spi@lfdr.de>; Wed,  3 Mar 2021 06:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238136AbhCCFrl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 00:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1575712AbhCBPfG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Mar 2021 10:35:06 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56187C061A27;
        Tue,  2 Mar 2021 06:52:22 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id m9so20962080ybk.8;
        Tue, 02 Mar 2021 06:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=shDiwtvjxW9HKBgWdxAQV0fG1bxmwZ/h9p6DqNjNEMo=;
        b=dWHpL1y0kNYGGo6ht640z7wd5SSsFPmb07qyaweFWrWjuSKPVxAwCSIQqjVKLLwvLu
         YeOsVCoEr9q62JDsFgd0zumEqrWlMoHXg1MuFeBeyEYrB/FR+Lw4QCiMi2KIHCsvIZDW
         Hn+Ophs64kDgf97ApuyaFJnu7jo+06Sco28BiVOAOThj1zNliq0ZQpWxNAzSfiXx/Q8x
         IGL5KeKNQuwua70Sqm1itgPnHF0uK/nH1Idw4IH83OL5COjvI02a+MyARqDcxic/68p5
         pA13KtkFkfuv8sDg8zOQZep9omDlFQq6QTrJTa63hqLTy+eOFbS6F+i4Vimnts4DIzTm
         TRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=shDiwtvjxW9HKBgWdxAQV0fG1bxmwZ/h9p6DqNjNEMo=;
        b=me3a4uJl3c3eaHND3n6ZvSYh0/FxGB4MG6qpuIFLz+7k++fVMfRECq1EN40+BG8OFA
         0ChajsLLRWGQWKAdVqWpafmxw6Behh8ySOoWnJ5cMDDc3u8b9zSXkrZqc8J5oP59ncw5
         tKe5yrB20nojs7zg39FWPVgxNZ3X+NnAUa4tEawlxMxGCBamLiq9rZ1d3GIjiEMmPMjn
         rfgRESMZKyzTdfVfSlVFoU28AeXqzouOLyJYyUDB24jL2mx+Tuur0MFNBveV9ktH46XV
         +UDo02mcoi5auVhQsAo5sNX+TLgENEZAxaZHXoaPAwjJxgHfV7JjX9QZMrP3/B+GfhfR
         r0jA==
X-Gm-Message-State: AOAM530l4+tl1A4vay2bOMUXo4UYkfs8P9yleU9jQiUoEWd7LSRoLyYj
        Db1ovfE8vCmBvI5pPEVukVhUn6Thbk8a9/o8o7k=
X-Google-Smtp-Source: ABdhPJw8CACQspkesAmhl91E4AzrDL/incidbLRSAJTbu6ZqbW9GiTp7tpYcPqXNqUYy+MMziYWbGUtbuFFNrpYElOw=
X-Received: by 2002:a05:6902:701:: with SMTP id k1mr31136319ybt.342.1614696741558;
 Tue, 02 Mar 2021 06:52:21 -0800 (PST)
MIME-Version: 1.0
References: <20210216110741.1286-1-andriy.shevchenko@linux.intel.com>
 <YDkpzZ8jL7O9HJuG@smile.fi.intel.com> <YDwmznD58ZtOwHgb@debian> <YDzaC2ahcHCrCI8V@smile.fi.intel.com>
In-Reply-To: <YDzaC2ahcHCrCI8V@smile.fi.intel.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Tue, 2 Mar 2021 14:51:45 +0000
Message-ID: <CADVatmP7V+pbpUC4xV+BmNzbfudPE5S0tT-6CgUKbQrC-FMrBA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] parport: Introduce module_parport_driver() helper macro
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Mar 1, 2021 at 12:12 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sun, Feb 28, 2021 at 11:27:10PM +0000, Sudip Mukherjee wrote:
> > On Fri, Feb 26, 2021 at 07:03:09PM +0200, Andy Shevchenko wrote:
> > > On Tue, Feb 16, 2021 at 01:07:39PM +0200, Andy Shevchenko wrote:
> > > > Introduce module_parport_driver() helper macro to reduce boilerplate
> > > > in the existing and new code.
> > >
> > > Sudip, any comments on this?
> >
> > Sorry for the delay in reply.
> > lgtm. I think there are few more drivers which can also use this new helper.
> > Will you like to do them also?
>
> Yes, that's the (slow going) plan.
>
> > Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
>
> Thanks! I considered that you take it thru parport tree. Do you have something
> else in mind?

I dont have a separate parport tree (parport is not under active
development to have a separate tree). I send everything parport
related to Greg and then he adds it to his tree.
I guess in this case if Greg agrees it can go via Mark's tree as the
series will also have SPI related patches.


--
Regards
Sudip
