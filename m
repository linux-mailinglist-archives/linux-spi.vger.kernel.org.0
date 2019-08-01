Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE76B7DB09
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2019 14:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfHAMMP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Aug 2019 08:12:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37750 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbfHAMMP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Aug 2019 08:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t9wQCPXDBSJ5U4TlAQQU+HRbE5Tc6JjxUxLV++Qf7eM=; b=ofDukxc2Byu76WKM0t8KljwuH
        fEW+W/rICtF1Zim2BdvEG0nhfQNuCsMn8XM2cqI5bq3uPnSPgmSL9cEUc8M1qVX4xzFj8oFdpPN6t
        3+rlBzLwbuM+Y6RR3ah0Ikh8NzkR9Mj/fmO2s8WgxJXe49qv9Z0x2Eq/ufGd4mfIFXWSFXjj6VcFJ
        ld2VUDlS0JXaXPVyeBPlv0rFaqHeTuTIavTDjfgsxwAvI7gty9Jqeibpay2N4R3YMohBv0vAmpVEt
        7bAQxAba5GgZhxE0oOCnJlSfLAO/yH7YfDEnD5U2dEd1aqFhvWNcpF/6gJCYaPKXog+nyUstRTes5
        Yttril/Nw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1ht9wJ-0002b3-1f; Thu, 01 Aug 2019 12:12:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D7DF2029F4C5; Thu,  1 Aug 2019 14:12:09 +0200 (CEST)
Date:   Thu, 1 Aug 2019 14:12:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 5/5] spi: Reduce kthread priority
Message-ID: <20190801121209.GD31381@hirez.programming.kicks-ass.net>
References: <20190801111348.530242235@infradead.org>
 <20190801111541.917256884@infradead.org>
 <CAMuHMdU3D22PAWepGP6rMvDwJKVTfbxxH9J=kuo59PB7CCVKOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU3D22PAWepGP6rMvDwJKVTfbxxH9J=kuo59PB7CCVKOA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Aug 01, 2019 at 01:27:03PM +0200, Geert Uytterhoeven wrote:
> Hi Peter,
> 
> On Thu, Aug 1, 2019 at 1:18 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > The SPI thingies request FIFO-99 by default, reduce this to FIFO-50.
> >
> > FIFO-99 is the very highest priority available to SCHED_FIFO and
> > it not a suitable default; it would indicate the SPI work is the
> > most important work on the machine.
> >
> > Cc: Benson Leung <bleung@chromium.org>
> > Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: linux-spi@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  drivers/platform/chrome/cros_ec_spi.c |    2 +-
> >  drivers/spi/spi.c                     |    2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > --- a/drivers/platform/chrome/cros_ec_spi.c
> > +++ b/drivers/platform/chrome/cros_ec_spi.c
> > @@ -706,7 +706,7 @@ static int cros_ec_spi_devm_high_pri_all
> >                                            struct cros_ec_spi *ec_spi)
> >  {
> >         struct sched_param sched_priority = {
> > -               .sched_priority = MAX_RT_PRIO - 1,
> > +               .sched_priority = MAX_RT_PRIO / 2,
> 
> include/linux/sched/prio.h says:
> 
>  * Priority of a process goes from 0..MAX_PRIO-1, valid RT
>  * priority is 0..MAX_RT_PRIO-1, and SCHED_NORMAL/SCHED_BATCH
>  * tasks are in the range MAX_RT_PRIO..MAX_PRIO-1. Priority
>  * values are inverted: lower p->prio value means higher priority.
> 
> So the new 50 is actually a higher priority than the old 99?
> 
> Given I'm far from an RT expert, I must be missing something?
> Thanks!

Ah; you found the confusion ;-)

https://lkml.kernel.org/20190617122448.GA3436@hirez.programming.kicks-ass.net

But basically, user-space prio is [1-99], while in-kernel prio is
[0-98]. The above is user prio (it basically uses the
sched_setscheduler() syscall).

So 50 really is lower than 99.
