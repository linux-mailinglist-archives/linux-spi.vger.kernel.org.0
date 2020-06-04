Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F1E1EEBC9
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jun 2020 22:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgFDUUD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Jun 2020 16:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgFDUUC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Jun 2020 16:20:02 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA54C08C5C0
        for <linux-spi@vger.kernel.org>; Thu,  4 Jun 2020 13:20:02 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so2658752plv.9
        for <linux-spi@vger.kernel.org>; Thu, 04 Jun 2020 13:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gz66RqxXF5KGuRHQ0GYBuygtpEJiPzNI0sTLh4Vu69Y=;
        b=jAmWlkIQJZzKdLIy24SnHWINuzTVOS3/wjvm2cU2AFi5wGPpwqQkjWfOwBraDHgs8k
         bMHElbdbRxBbtC27xZm6mEe99uDc96pKouYmbV/dc0+e2MIiE2jcwrdVq98w16mgeguV
         2DhLtfyu1wmL1bs6o/3S7BQ/OXA9/tFItMGTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gz66RqxXF5KGuRHQ0GYBuygtpEJiPzNI0sTLh4Vu69Y=;
        b=Cuz2QgZ+FMCjOoznTP6dfkWkYdkyEmnbkQtth5t3pJU+k8oMTapE+giVH4MQiZV38e
         EZyFVPQpELzLBICmetgjqsPD0PYmFTKQEuIvJlVKmVq9ICxs8W7tmofFs5QYThiSma8r
         TuJQ5MxSzmIRCZhtOHQJO1zA3SjR+v+1zEK/Wi/eS4vpT31nKrsku7E/+JXItQYWwweM
         bXe3Zntya9ia0Afpdg1B8ingr7G0HOf9nO5qku1Cx7X9KLpR/qXzpBsO5ZVELRvs6XCg
         nkaIMElfI4mDuoHcCE6/FsX9rNI5nFL6/oI20YCXcrOS+f9oXsa13Cs0J+i6x754AsUh
         pMKg==
X-Gm-Message-State: AOAM531FQBvWdvSXNvWuxp8TFL6VZJzWQe8OQIgxQTBaOzK50Fz/XjLz
        wgl8tt4VwffPrCGe4UumLtYQkw==
X-Google-Smtp-Source: ABdhPJxkV30NNQPml+L5dx48JHt30SosyvH9CeJOsvPeKMxl1Di1uyDaJOg4t+7npffgj0Ki2XTH3Q==
X-Received: by 2002:a17:90a:7043:: with SMTP id f61mr7838452pjk.140.1591302001916;
        Thu, 04 Jun 2020 13:20:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g17sm1432553pju.11.2020.06.04.13.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 13:20:01 -0700 (PDT)
Date:   Thu, 4 Jun 2020 13:20:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org,
        Network Development <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 05/10] ide: Remove uninitialized_var() usage
Message-ID: <202006041318.B0EA9059C7@keescook>
References: <20200603233203.1695403-1-keescook@chromium.org>
 <20200603233203.1695403-6-keescook@chromium.org>
 <CAKwvOdm5zDide5RuppY_jG=r46=UMdVJBrkBqD5x=dOMTG9cZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm5zDide5RuppY_jG=r46=UMdVJBrkBqD5x=dOMTG9cZg@mail.gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jun 04, 2020 at 12:29:17PM -0700, Nick Desaulniers wrote:
> On Wed, Jun 3, 2020 at 4:32 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Using uninitialized_var() is dangerous as it papers over real bugs[1]
> > (or can in the future), and suppresses unrelated compiler warnings (e.g.
> > "unused variable"). If the compiler thinks it is uninitialized, either
> > simply initialize the variable or make compiler changes. As a precursor
> > to removing[2] this[3] macro[4], just remove this variable since it was
> > actually unused:
> >
> > drivers/ide/ide-taskfile.c:232:34: warning: unused variable 'flags' [-Wunused-variable]
> >         unsigned long uninitialized_var(flags);
> >                                         ^
> >
> > [1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
> > [2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
> > [3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
> > [4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for the reviews!

> Fixes ce1e518190ea ("ide: don't disable interrupts during kmap_atomic()")

I originally avoided adding Fixes tags because I didn't want these
changes backported into a -stable without -Wmaybe-uninitialized
disabled, but in these cases (variable removal), that actually does make
sense. Thanks!

-Kees

-- 
Kees Cook
