Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568D41C5487
	for <lists+linux-spi@lfdr.de>; Tue,  5 May 2020 13:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgEELij (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 May 2020 07:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727090AbgEELij (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 May 2020 07:38:39 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E214C061A0F
        for <linux-spi@vger.kernel.org>; Tue,  5 May 2020 04:38:39 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mq3so993119pjb.1
        for <linux-spi@vger.kernel.org>; Tue, 05 May 2020 04:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m5tteuJaA1g0qvOeePwk1w6CmDmGCRR+j/8xp3J9Trc=;
        b=tIZD5TqEy4nKHNLy3jp+n4zw7wy00wkJZZ/P0ZZlOoQx/mMhsOvD1V3F90j+4uPeVh
         1jyhlI0dtZc1RACG8yE689VgHqwJzH5bJ0LsYsWpClYu252KY4K78wF26oPLWTVQfb0s
         XiSPa1whIKz0Bhdc8HBfwflU/BB7dhi9hddHhMhx7QaRCQ6yuTYD6ms4nWW5NekRI6Ga
         X+arHqcEVCu1MX8P+4PVbyz9SI3F4iCpBtPWpexiXz8xuW29/iJbbfhpi1NIwLqt67o7
         Uni5l9l8a6wvg7p0z8vR1WusXO1t4Sp9t1FhzzOH0cKWp+eD/F/Lt4l625Ule1oTSapB
         8x6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m5tteuJaA1g0qvOeePwk1w6CmDmGCRR+j/8xp3J9Trc=;
        b=MTnnRu2DcQHKDUmEe6CleCVi4Tu3iT7rl6OHakDrRkdwbU0a1sRF98SaEAct9Fcv6T
         xmfasusd/i4u3szC2KH51p4u6zoJu98rzvWEpijAVn+9DHF8B2Q92NYvbI5sIAvFNdrY
         BOt4aHqEzdKJ/TcwYUVdOG/KIqGQKOvr8/uvthlul380WgS6Ccf49hqMc0NumvpMvmpU
         uKNPBQI2mpDggxKduxoZXJ4lylb88RuM4BfnG0e0yY/6vKaoaPr+zpsqZ1r88lPUTn0d
         nTmS9d4qlppqKWDm+g22j6y0K+A/L+RVOkYy74DNRy9wKicxqKow/Z+5/vLNacWVf5ul
         5w4w==
X-Gm-Message-State: AGi0Pubb31qCRLdDkIZbNMCkAF0xu/w9eLhDtpdWzFVG2ryKRKPeoBZD
        4lwE4Hws/vkF3FarxTKjTt9ilf1/Yi9EwiIX5wNmabQ9
X-Google-Smtp-Source: APiQypLYE6hfWi/zBXXFMy30aDCp5s7twiUvlJA+LffN9TrZmNa2M83DsoWKp7l+2B8Xo0YBohGHrNFcjagVaUWQjEM=
X-Received: by 2002:a17:90a:340c:: with SMTP id o12mr2634936pjb.22.1588678718331;
 Tue, 05 May 2020 04:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <CABatt_wQpbtktD=bXwJCzdm_5aLeHcQrSW2pNMRergC9jZ0sMw@mail.gmail.com>
 <CAHp75Ve9giL99P+4Q+LjcFPKPq4fzXR+8UDPDZpA+sPr0o04cg@mail.gmail.com> <CABatt_wbC9sDu04FfG6NNi6P6NzhT6tmm=PHh3VXZhR_=1K03A@mail.gmail.com>
In-Reply-To: <CABatt_wbC9sDu04FfG6NNi6P6NzhT6tmm=PHh3VXZhR_=1K03A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 May 2020 14:38:31 +0300
Message-ID: <CAHp75VeJPuEc9HUOZ3toe29pj62xu7SR3C_+rFuQe792D1atSg@mail.gmail.com>
Subject: Re: SPI driver probe problem during boot
To:     Martin Townsend <mtownsend1973@gmail.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, May 5, 2020 at 12:47 PM Martin Townsend <mtownsend1973@gmail.com> wrote:
> On Tue, May 5, 2020 at 9:43 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, May 5, 2020 at 11:04 AM Martin Townsend <mtownsend1973@gmail.com> wrote:

...

> > > Now this is on a oldish kernel (4.12) and moving the kernel forward
> > > isn't trivial.  I was just wondering if this has been fixed already so
> > > I could backport it, I couldn't see anything in the latest kernel but
> > > maybe it has been solved a different way.  If not is there a better
> > > way of fixing this? Or is the OMAP SPI controller driver the problem,
> > > should it parse the child nodes first and set itself up accordingly?
> >
> > Can you confirm the issue on v5.7-rc4?
> >
>
> I will try but it's not always possible with these embedded SoC's
> without a lot of work.

I understand that, but if issue is fixed the proper (but might be
painful and long) way is to bisect to the fix and try to backport.
Otherwise it will need to be fixed in newest available kernel first.

So, in either case you should test on latest available.


-- 
With Best Regards,
Andy Shevchenko
