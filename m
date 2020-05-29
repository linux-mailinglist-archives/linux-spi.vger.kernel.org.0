Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF971E87A8
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 21:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgE2TVt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 15:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgE2TVr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 15:21:47 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D509C03E969
        for <linux-spi@vger.kernel.org>; Fri, 29 May 2020 12:21:47 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id i17so1616055pli.13
        for <linux-spi@vger.kernel.org>; Fri, 29 May 2020 12:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JWSQ7856a0Bya3eVvYlz6tSkdfnSnRHE0twupimfgUA=;
        b=mKcXHBkyUBK6HvNii4vSOWAAFzGhcopXWp+xFC4AuscW6/ErOGOsXB0Tc3joTe+jpu
         dJL9Vv7zcTzkTTtq3T74eX0091pByhSKF2RLrjCb79roPM7V4HUk9jEZl1mFoill7TGY
         JdnS5h7g7Ct4s5nlV0vV34AndwSndOXMJSrl29BfJUSKBo58XKHEgTftnJ8zUYCyDd9v
         1rhall2N30GM/MKgZARTh90R+iKen63Ynm4VN9bnhM8GqLYpuiB2UE06oZDFkDIyqkPC
         YveqshO3VWqGO2qhHNUGRxM1eEWWsDJ8anWQcyIS2SwtEjUqdv9lTi8raSWDfUSAvFwq
         JnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWSQ7856a0Bya3eVvYlz6tSkdfnSnRHE0twupimfgUA=;
        b=Qo1KmCpicp+yz7MWM1exeRBbxhl5huAR79L9z8hfx6ZLewDQR13besK/vr/5+RhdXU
         4p8JKTUzjU23W/C6lqpCDar3I3Fdnhkn/vWQ7NUP04Iz9Ru8eLP+7T9D+HJK0O6rgcnO
         5fuIzc8v1zOAy3IjAvBjBkUP2iYKiN0/hNoGFej2F6uzM7l0ZSKSyZptwIfm8ytovvUA
         so88rTyoNIk5LUjLNf4ZSK4p2BhAV1QQBzUEyUp3oM7eTCg4ShXPu/RZJcshqGsN64DE
         TFr/PPfqoQ7dSPizGsqFuxI3mmsnxnB7HHIheBlDcazmx/o2hLSOSHhFq2ya0aEH8SVI
         Ou+Q==
X-Gm-Message-State: AOAM533rt3/KDc6AdwwszelleOFNRDF4LNOEtp0FWF/MMb3uoNnXPuTO
        648sC8NULVkwBq5lyi/JJMPIiUn7PndlbLFjMPo=
X-Google-Smtp-Source: ABdhPJz1A0Hqic9glkpaQh4I5t6ySRdXXXEglKwCIwM3HRwOwEARi2PYlYchFD9lhMnQQtHAZjDN8CLdpUhpk2LgdxY=
X-Received: by 2002:a17:902:ea8a:: with SMTP id x10mr10157680plb.255.1590780107061;
 Fri, 29 May 2020 12:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200529183150.44149-1-andriy.shevchenko@linux.intel.com>
 <20200529184050.bkn72tash33zgoo4@mobilestation> <20200529184955.GY1634618@smile.fi.intel.com>
 <20200529190416.lwou54v6a3suicfd@mobilestation>
In-Reply-To: <20200529190416.lwou54v6a3suicfd@mobilestation>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 May 2020 22:21:35 +0300
Message-ID: <CAHp75VdTGU-1gOt10eUP3BM6BaSCV4MxcfOdtLs_EVUqxLELKw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] spi: dw: Make DMA request line assignments
 explicit for Intel Medfield
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 29, 2020 at 10:05 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> On Fri, May 29, 2020 at 09:49:55PM +0300, Andy Shevchenko wrote:
> > On Fri, May 29, 2020 at 09:40:50PM +0300, Serge Semin wrote:
> > > On Fri, May 29, 2020 at 09:31:49PM +0300, Andy Shevchenko wrote:

...

> > > You know my attitude to these changes.) But anyway what's the point in having
> > > the *tx and *rx pointers here? Without any harm to the readability you can use
> > > the structures names directly, don't you?
> >
> > I will wait for Mark to decide.
>
> So no response to a review comment? Shall I do the same when get a review from
> you?.)

This patch is result of you insisting on your version of things when I
tried to explain you that it's not how it should be done. You pushed
your vision. Mark proposed to submit your changes and consider mine
which I agreed on. I will wait for him.

> I am not asking about the whole patch purpose. You know what I think about it.
> My question was about why *tx and *rx pointers are required? Just wondering, I
> may misunderstand something... As I see it you could use dma_tx and dma_rx here
> directly with the same level of readability.

I'll consider this in case v3 will be needed, thanks.

-- 
With Best Regards,
Andy Shevchenko
