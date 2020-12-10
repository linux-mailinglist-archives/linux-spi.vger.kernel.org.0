Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638732D63CE
	for <lists+linux-spi@lfdr.de>; Thu, 10 Dec 2020 18:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392686AbgLJRPS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Dec 2020 12:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392671AbgLJRPL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Dec 2020 12:15:11 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C94BC061794
        for <linux-spi@vger.kernel.org>; Thu, 10 Dec 2020 09:14:31 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id x12so2625470plr.10
        for <linux-spi@vger.kernel.org>; Thu, 10 Dec 2020 09:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xMgQPzANQdeOqMY+fXyJVOEZa71a65TdMFizwM/N9b0=;
        b=WnikWqu/v1U0viE/wvjK6QZAW6WMiIGtgjXOrFJM+gR4YgZklzOOU/3A8DYKZRjnvZ
         /KqbvstT7mebzyo7tqJPILPN8Rt1PlqqIB0GFGSeFC2zpLhD7d9cxFeoYc9hsbVOUQqE
         N9dRWSWNxoK4zG9RdmRRpq8Q0VxyW6mOw60ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xMgQPzANQdeOqMY+fXyJVOEZa71a65TdMFizwM/N9b0=;
        b=c9x4ud1GOPVQWk8JNYXyBNMlheKSEkchlFErlZ8cNRIhNtL5xLrRoJbI53DSkGbYzW
         cfrCwdz0DXaTxEkbXrHc/eM0ipPMeuXufknZSLFxCMIIz4cXWl/XVjjxDDCzMQ6OZ8y3
         yIfdSzC/SrHSlKFTF4yz2AqIGNxaTA6t2igzBlo5E8xAqvAWF1hthayMtI1x75dliQVE
         DsfuybdI3GhV0hGOupycT/eaMx3xVvG8Oie75dNDyUpis3UNrGKS35LzzEmlg5xX+fPl
         K/+VqEmW2B8iDeAz/gwsg18rv7eVzCNYWNlDxJGetG6Zkw2H3cq3iA2hFo2Ki4mBKR/l
         2wwQ==
X-Gm-Message-State: AOAM530Sb09nYRtUDxHy8EAmdMWCx8BvZQvTrAtDfl17TkzgOCqn0byI
        bxOkAoCi0lFfteemmufOPC0urpGBBBuaYw==
X-Google-Smtp-Source: ABdhPJz4GjT6mXlYON1xJdXG3qFF53NBT/0blmE2zsYDbOJCAZRegy/7XRRDycBXMaKpxiGhR6No8g==
X-Received: by 2002:a05:6102:2:: with SMTP id j2mr8955330vsp.47.1607620469340;
        Thu, 10 Dec 2020 09:14:29 -0800 (PST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id t7sm606161vkk.43.2020.12.10.09.14.27
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 09:14:28 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id v185so1391347vkf.8
        for <linux-spi@vger.kernel.org>; Thu, 10 Dec 2020 09:14:27 -0800 (PST)
X-Received: by 2002:ac5:ce9b:: with SMTP id 27mr10106859vke.9.1607620467257;
 Thu, 10 Dec 2020 09:14:27 -0800 (PST)
MIME-Version: 1.0
References: <20201203074459.13078-1-rojay@codeaurora.org> <CAD=FV=XKyXnjsM4iS-ydRWBnmYMojPOaYAdYhOkxkPTCQf0RLQ@mail.gmail.com>
 <160757022002.1580929.8656750350166301192@swboyd.mtv.corp.google.com>
In-Reply-To: <160757022002.1580929.8656750350166301192@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 10 Dec 2020 09:14:15 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WtU3cnRe6pDKFMA9_0cnQFtSOyohY_bJwZObK+KrbhVQ@mail.gmail.com>
Message-ID: <CAD=FV=WtU3cnRe6pDKFMA9_0cnQFtSOyohY_bJwZObK+KrbhVQ@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Fix NULL pointer access in geni_spi_isr
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Roja Rani Yarubandi <rojay@codeaurora.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        msavaliy@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Wed, Dec 9, 2020 at 7:17 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Doug Anderson (2020-12-03 08:40:46)
>
> > I would guess that if "mas->cur_xfer" is NULL then
> > geni_spi_handle_rx() should read all data in the FIFO and throw it
> > away and geni_spi_handle_tx() should set SE_GENI_TX_WATERMARK_REG to
> > 0.  NOTE: I _think_ that with the synchronize_irq() I'm suggesting
> > above we'll avoid this case, but it never hurts to be defensive.
> >
> >
> > Does that all make sense?  So the summary is that instead of your patch:
>
> Can we get a CPU diagram describing the race and scenario where this
> happens? Something like:
>
>   CPU0                                CPU1
>   ----                                ----
>   setup_fifo_xfer()
>    spin_lock_irq(&mas->lock);
>    spin_unlock_irq(&mas->lock);
>    mas->cur_xfer = xfer
>    ...
>    <IRQ>
>                                       geni_spi_isr()
>                                        geni_spi_handle_rx()
>                                         <NULL deref boom explosion!>
>
> But obviously this example diagram is incorrect and some timeout happens
> instead? Sorry, I'm super lazy and don't want to read many paragraphs of
> text. :) I'd rather have a diagram like above that clearly points out
> the steps taken to the NULL pointer deref.

This is my untested belief of what's happening

 CPU0                                CPU1
 ----                                ----
                                     setup_fifo_xfer()
                                      ...
                                      geni_se_setup_m_cmd()
                                      <hardware starts transfer>
 <unrelated interrupt storm>          spin_unlock_irq()
 <continued interrupt storm>         <time passes>
 <continued interrupt storm>         <transfer complets in hardware>
 <continued interrupt storm>         <hardware sets M_RX_FIFO_WATERMARK_EN>
 <continued interrupt storm>         <time passes>
 <continued interrupt storm>         handle_fifo_timeout()
 <continued interrupt storm>          spin_lock_irq()
 <continued interrupt storm>          mas->cur_xfer = NULL
 <continued interrupt storm>          geni_se_cancel_m_cmd()
 <continued interrupt storm>          spin_unlock_irq()
 <continued interrupt storm>          wait_for_completion_timeout() => timeout
 <continued interrupt storm>          spin_lock_irq()
 <continued interrupt storm>          geni_se_abort_m_cmd()
 <continued interrupt storm>          spin_unlock_irq()
 <continued interrupt storm>          wait_for_completion_timeout() => timeout
 <interrupt storm ends>
 geni_spi_isr()
  spin_lock()
  if (m_irq & M_RX_FIFO_WATERMARK_EN)
   geni_spi_handle_rx()
    mas->cur_xfer NULL derefrence

With my proposed fix, I believe that would transform into:

 CPU0                                CPU1
 ----                                ----
                                     setup_fifo_xfer()
                                      ...
                                      geni_se_setup_m_cmd()
                                      <hardware starts transfer>
 <unrelated interrupt storm>          spin_unlock_irq()
 <continued interrupt storm>         <time passes>
 <continued interrupt storm>         <transfer complets in hardware>
 <continued interrupt storm>         <hardware sets M_RX_FIFO_WATERMARK_EN>
 <continued interrupt storm>         <time passes>
 <continued interrupt storm>         handle_fifo_timeout()
 <continued interrupt storm>          synchronize_irq()
 <continued interrupt storm>           <time passes>
 <interrupt storm ends>
 geni_spi_isr()
  ...
                                       <synchronize_irq() finishes>
                                      spin_lock_irq()
                                      mas->cur_xfer = NULL
                                      geni_se_cancel_m_cmd()
                                      spin_unlock_irq()
 geni_spi_isr()
   ...
                                      wait_for_completion_timeout() => success

The extra synchronize_irq() I was suggesting at the end of the
function would be an extra bit of paranoia.  Maybe a new storm showed
up while we were processing the timeout?


> > 1. Add synchronize_irq() at the start and end of
> > handle_fifo_timeout().  Not under lock.
> >
> > 2. In geni_spi_handle_rx(), check for NULL "mas->cur_xfer".  Read all
> > data in the FIFO (don't cap at rx_rem_bytes), but throw it away.
> >
> > 3. In geni_spi_handle_tx(), check for NULL "mas->cur_xfer".  Don't
> > write any data.  Just write 0 to SE_GENI_TX_WATERMARK_REG.
> >
> > I think #1 is the real fix, but #2 and #3 will avoid crashes in case
> > there's another bug somewhere.
>
> Aren't 2 and 3 papering over some weird problem though where irqs are
> coming in unexpectedly?

I think that's what I said but in different words?  #1 is the real fix
but #2 and #3 will keep us from crashing (AKA paper over) if we have
some other (unexpected) bug.  We'll already have an error in the log
in this case "Failed to cancel/abort m_cmd" so it doesn't feel
necessary to crash with a NULL dereference...

-Doug
