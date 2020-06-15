Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0293C1FA057
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 21:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgFOTc5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 15:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729836AbgFOTcy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 15:32:54 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB38C08C5C5
        for <linux-spi@vger.kernel.org>; Mon, 15 Jun 2020 12:32:52 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y18so7213313plr.4
        for <linux-spi@vger.kernel.org>; Mon, 15 Jun 2020 12:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZjAXfZy5BudfnO86h+8mAf1S7F89/y7Ht34uQW17/+U=;
        b=QBeg3rvb86U6Tj0IyJR5u6BBRDaGksrhbixbVGEFMNAmYYAm2vi8ezn7Pzjsx+8Y/N
         0spIQQjXlTeZa6JYxyI0WQLYZewE/IOrv1eu80kZOYOGkcIsaJYdoUbYKY8F56IoVrW7
         todjyiaALbdigpVH6qkq1a3bhohRwm98ntcpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZjAXfZy5BudfnO86h+8mAf1S7F89/y7Ht34uQW17/+U=;
        b=k5MHyuzSgLWZFi9gulG8Mtf8wAdNTmADO8LXw1Wc1aLQ62EYQ1SNNfI1mFdRMpiHyu
         Oa2EshdZFy7xd5oxNrTWOeix2ZIj1DQcUwZ2ss0CJ7nkPM6VK+vxzToxR3rF6fuT64XG
         WrcvLLdmj0yFlk1WNipa006wcHeN2w3lbQlxb66znsvrnI1MYWL4g3zka++UQknIWzOV
         +AX6iN7EEYgMH9Yl0meRgy0cOf4uvcmem7cvz9Qb3DskgzUt6BoOeGeESmvZaS7MKpNr
         PjroLRIIQG63FUQz/2wBiWpubO6o9b1a8tO0Dhd2V53zoEtbOZtKN3HdHV3Egjz5mk/p
         hisQ==
X-Gm-Message-State: AOAM533VC7yEIs1zBHZHXk3sgqhNJoVLXYCqytH1Q3ZC6T4owGkljU1J
        JilTYYrbSlgCHvge50jEgfK90Q==
X-Google-Smtp-Source: ABdhPJxugszkh+55zcQ6ID8nCD+Y2mp2lHGMEtD9VsXD4kV92TrXKjIOZPR9BYw/ID9xL1GXxiQnCg==
X-Received: by 2002:a17:90b:23d2:: with SMTP id md18mr774459pjb.179.1592249571413;
        Mon, 15 Jun 2020 12:32:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n189sm14973604pfn.108.2020.06.15.12.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 12:32:50 -0700 (PDT)
Date:   Mon, 15 Jun 2020 12:32:49 -0700
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
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH 05/10] ide: Remove uninitialized_var() usage
Message-ID: <202006151231.74D2315450@keescook>
References: <20200603233203.1695403-1-keescook@chromium.org>
 <20200603233203.1695403-6-keescook@chromium.org>
 <CAKwvOdm5zDide5RuppY_jG=r46=UMdVJBrkBqD5x=dOMTG9cZg@mail.gmail.com>
 <202006041318.B0EA9059C7@keescook>
 <CAKwvOdk3Wc1gC0UMsFZsZqQ8n_bkPjNAJo5u3nfcyXcBaZCMHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdk3Wc1gC0UMsFZsZqQ8n_bkPjNAJo5u3nfcyXcBaZCMHw@mail.gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jun 04, 2020 at 01:29:44PM -0700, Nick Desaulniers wrote:
> On Thu, Jun 4, 2020 at 1:20 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Jun 04, 2020 at 12:29:17PM -0700, Nick Desaulniers wrote:
> > > On Wed, Jun 3, 2020 at 4:32 PM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > Using uninitialized_var() is dangerous as it papers over real bugs[1]
> > > > (or can in the future), and suppresses unrelated compiler warnings (e.g.
> > > > "unused variable"). If the compiler thinks it is uninitialized, either
> > > > simply initialize the variable or make compiler changes. As a precursor
> > > > to removing[2] this[3] macro[4], just remove this variable since it was
> > > > actually unused:
> > > >
> > > > drivers/ide/ide-taskfile.c:232:34: warning: unused variable 'flags' [-Wunused-variable]
> > > >         unsigned long uninitialized_var(flags);
> > > >                                         ^
> > > >
> > > > [1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
> > > > [2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
> > > > [3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
> > > > [4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
> > > >
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > >
> > > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > Thanks for the reviews!
> >
> > > Fixes ce1e518190ea ("ide: don't disable interrupts during kmap_atomic()")
> >
> > I originally avoided adding Fixes tags because I didn't want these
> > changes backported into a -stable without -Wmaybe-uninitialized
> > disabled, but in these cases (variable removal), that actually does make
> > sense. Thanks!
> 
> Saravana showed me a cool trick for quickly finding commits that
> removed a particular identifier that I find faster than `git blame` or
> vim-fugitive for the purpose of Fixes tags:
> $ git log -S <string> <file>

Ah yes, I always have to look up "-S". Good reminder!

> I've added it to our wiki:
> https://github.com/ClangBuiltLinux/linux/wiki/Command-line-tips-and-tricks#for-finding-which-commit-may-have-removed-a-string-try.
> I should update the first tip; what was your suggestion for
> constraining the search to the current remote?

Ah cool. I've updated it now. It was really to narrow to a "known set of
tags", and Linus's tree's tags always start with "v".

-- 
Kees Cook
