Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3657DF47
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2019 17:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbfHAPoL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Aug 2019 11:44:11 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45851 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfHAPoK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Aug 2019 11:44:10 -0400
Received: by mail-io1-f66.google.com with SMTP id g20so145352095ioc.12
        for <linux-spi@vger.kernel.org>; Thu, 01 Aug 2019 08:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vspdYAgVGKceUPiVFKieEOMlC+LiG/ZtP0gwv4WyoMc=;
        b=E9jIpetc+G2V/zMXTRPehFZLbbQhmqsVpa1m2rKjZmgTJcxY8hrvSHpbVkT+N919ho
         zcp2WVewQn5V4gKXix7773WimA5+0lnX79+qRPETNJLA+5kqQ/3Jg8V1A9PKlVkG0A/r
         0PScnyrnPXzP+2jeTUnOeQi13mW3qBNs0zGRZYeltDT9Sx/LEa7nF7tbUPsRN5qxuw7y
         dpLC6pntECKeit7+csgOrS7Ihn1FdpwniAHgkjKxG8aAq+/PXbTkdT4GqsQBeIPQy7cd
         oV2EiGVGfMVX+rlU3Ua6piBs1OowN2ymxKX1xPpDA+OyzYvvsX2pwHLW5P5zFOKA9JY3
         uM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vspdYAgVGKceUPiVFKieEOMlC+LiG/ZtP0gwv4WyoMc=;
        b=ty3E6lQe8qSdIAFGq3UDBDRrwt6Ub49qkPL6ZDNt2j0hm1fl//td+sTPhKP8SvJ+Lx
         hqHv5tcy4qjoPEE931QxAIVpZMUriXecDUXZyTb149r303U0VNUcE38tjRlWyRtGlC7h
         vZ6UihoHpk5decuT+uZV6O0pJ9P8Wk/mYmqBQ5QoxJpCvqaq824b6aJMEoOJZBFJkb3r
         zDMVDJ7KyVvAF5oJBEpnJ+mOsQFqw8KXbv03uil0kLuYmNoRuLOGAeesUYM5pJhsiD82
         1D4YNcmONKA3IjjVhi8fpvQbpODAJ0MmMAKaCJgVvFPPJA196BeoeMavhJrt52jWMLNk
         M7HA==
X-Gm-Message-State: APjAAAVSnOZzRJiUlDx06lNRZZGk/fQ6TsbUBerJS0g0onGH7RUgUA7a
        oRvpw4vg6bWGXtxPLcP0ueA+Et5Y1u2FAIT4h7ETgQ==
X-Google-Smtp-Source: APXvYqyMI/46xUheno1G6g0K5O4v4bXDf/LowKYdBMoiZCLfzMEORfKBIz0fUZDA3SC130TyUqTArsZeQ4J1sg/1m50=
X-Received: by 2002:a5d:885a:: with SMTP id t26mr9879366ios.218.1564674249377;
 Thu, 01 Aug 2019 08:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190801111348.530242235@infradead.org> <20190801111541.917256884@infradead.org>
 <640721f8-8a20-b161-473f-98a9dbc053cc@collabora.com> <20190801121718.GE31381@hirez.programming.kicks-ass.net>
 <20190801123503.GC5488@sirena.org.uk>
In-Reply-To: <20190801123503.GC5488@sirena.org.uk>
From:   Doug Anderson <dianders@google.com>
Date:   Thu, 1 Aug 2019 08:44:01 -0700
Message-ID: <CAD=FV=UsYF1R6+XRfFFFm6PfmkTsEOfxxgCw2JxCnpyu1kGVLQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] spi: Reduce kthread priority
To:     Mark Brown <broonie@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Thu, Aug 1, 2019 at 5:35 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Aug 01, 2019 at 02:17:18PM +0200, Peter Zijlstra wrote:
>
> > I'm thinking that isn't true 99% of the time, except of course when that
> > bandsaw emergency break is attached through SPI, but in that case the
> > admin can very well chrt the prio of this thread.
>
> The SPI thread isn't usually RT, it's only made RT if something in the
> system asks for it - the reason the ChromeOS people got CCed in is that
> some of their embedded controllers are very fragile and need super tight
> timing on some of the interactions over their control interface so
> they're one of the users here.  Of course everyone is then going to
> claim that their usage is the most critical usage in the system, and
> they may well even be right, but I do tend to agree that just any old RT
> priority is probably a sensible default since for most cases there will
> be few if any other RT tasks anyway.

For the Chrome OS case I believe that "MAX_RT_PRIO / 2" should be just
fine.  In fact in an earlier version of my work to make CrOS EC work
better at <https://crrev.com/c/1603464> I had said "We'll arbitrarily
pick a priority of "MAX_RT_PRIO / 4 - 1", AKA 24.  This seems to work
fine in practice."  I only switched to "MAX_RT_PRIO - 1" to match the
SPI code.

Mostly we just need to be a bit higher than things that request the
highest non-realtime priority, notably DM Crypt and loopback which
both schedule a bunch of work on the high priority system workqueue.
Those two things in particular seem to want high priority for
performance reasons but not for correctness reasons.  As mentioned
earlier our EC will actually fail transfers if there is too much
delay.

Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
