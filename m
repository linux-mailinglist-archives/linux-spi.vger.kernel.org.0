Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFAE2D6CC9
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 01:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbgLKAwI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Dec 2020 19:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389532AbgLKAvi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Dec 2020 19:51:38 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0109EC0613CF
        for <linux-spi@vger.kernel.org>; Thu, 10 Dec 2020 16:50:58 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 131so5849921pfb.9
        for <linux-spi@vger.kernel.org>; Thu, 10 Dec 2020 16:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=dprNn0WuSryYKqCdSm/Bp8UbqgSIIDDVYORtNWfa1WU=;
        b=TgF3ywgeruCprqOfnZtUK170KoOS56SF0sNSw9F9eGyjKwPruhDwRMwGj9lsZWaKb+
         QY3z63z2q3RRyqhgPUDj0qz6QDZwZikHLKHid80XFpV+d8RX0f0kPBOPHhncpXyOFfzf
         AHG1StZy2oGIpCpqfM9KUk2MtIsBTPmFNa7fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=dprNn0WuSryYKqCdSm/Bp8UbqgSIIDDVYORtNWfa1WU=;
        b=nWDU62zv+qo/v7zex0g7VfgX3kVCaDgsNkiDuXg2Pdal3uoPZDDkcUnPUUK1cLgfPI
         Oa73HeXvQ6t8hu96Y+CpPhBzE4KI2iXlPCjJjCUY6NIEaV72dB8rTv1kFnW+wfheWXFE
         8ZJZ42kbeIKcB88yhPGzt+qHjEhlxLuNl8yKBTjLeAAQHCyiMR4WG3rat6OePHT7aOm4
         KXUQ+70X/NbPacOFGZasS07kmW2JMDRzIF9uMwFx0oxNACy7r9qT+a4+NpfsvMLQ5+8n
         dlDa9xk4aFDY74ae1As3GjUvAvNZz4jDJccXPKGCuRqe2zOsICTqKukEZILisBbwlbts
         BCGw==
X-Gm-Message-State: AOAM531DGo7Zywf8tOfKG9m9zkudXq3nCOJYK8E1N9NgSvT2b4H7uoKj
        s4J/Rh/i+UlVdU8cgBO7CyVr+A==
X-Google-Smtp-Source: ABdhPJz+ynpDV2ZeTiWYo1dZQvphlReCEnRcQnhu1YiqYPQQTmyVAJGBkFiTjtQH5d93gN+KxaPVmQ==
X-Received: by 2002:a63:4b1f:: with SMTP id y31mr9247800pga.29.1607647857472;
        Thu, 10 Dec 2020 16:50:57 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id q22sm4375726pjg.15.2020.12.10.16.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 16:50:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=WvG085orLqnvg9WUobL7iyxwgoxh-8RvOaRdi9rLeDUg@mail.gmail.com>
References: <20201203074459.13078-1-rojay@codeaurora.org> <CAD=FV=XKyXnjsM4iS-ydRWBnmYMojPOaYAdYhOkxkPTCQf0RLQ@mail.gmail.com> <160757022002.1580929.8656750350166301192@swboyd.mtv.corp.google.com> <CAD=FV=WtU3cnRe6pDKFMA9_0cnQFtSOyohY_bJwZObK+KrbhVQ@mail.gmail.com> <160764107797.1580929.14768824290834396298@swboyd.mtv.corp.google.com> <CAD=FV=WuQjKC6GHy8d2nuqS-fgsUfxYrJosg3eyC9JU1FPCcjw@mail.gmail.com> <160764316821.1580929.18177257779550490986@swboyd.mtv.corp.google.com> <CAD=FV=WvG085orLqnvg9WUobL7iyxwgoxh-8RvOaRdi9rLeDUg@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Fix NULL pointer access in geni_spi_isr
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Roja Rani Yarubandi <rojay@codeaurora.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        msavaliy@qti.qualcomm.com
To:     Doug Anderson <dianders@chromium.org>
Date:   Thu, 10 Dec 2020 16:50:55 -0800
Message-ID: <160764785500.1580929.4255309510717807485@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Doug Anderson (2020-12-10 15:50:04)
> Hi,
>=20
> On Thu, Dec 10, 2020 at 3:32 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Doug Anderson (2020-12-10 15:07:39)
> > > Hi,
> > >
> > > On Thu, Dec 10, 2020 at 2:58 PM Stephen Boyd <swboyd@chromium.org> wr=
ote:
> > > > right? It will only ensure that other irq handlers have completed, =
which
> > > > may be a problem, but not the only one.
> > > >
> > > > TL;DR: Peek at the irq status register in the timeout logic and ski=
p it
> > > > if the irq is pending?
> > >
> > > I don't have tons of experience with synchronize_irq(), but the
> > > function comment seems to indicate that as long as the interrupt is
> > > pending synchronize_irq() will do what we want even if the CPU that
> > > should handle the interrupt is in an irqsoff section.  Digging a
> > > little bit I guess it relies upon the interrupt controller being able
> > > to read this state, but (hopefully) the GIC can?
> >
> > I didn't read synchronize_irq() more than the single line summary. I
> > thought it would only make sure other irq handlers have finished, which
> > is beside the point of some long section of code that has disabled irqs
> > on CPU0 with local_irq_disable(). And further more, presumably the irq
> > handler could be threaded, and then we could put a sufficiently large
> > msleep() at the start of geni_spi_isr() and see the same problem?
>=20
> As I understand it synchronize_irq():
> 1. If the interrupt is not running but is pending at a hardware level,
> it'll wait.
> 2. If the interrupt is currently running it waits for it to finish.
>=20
> That should handle all the cases you're talking about including
> waiting for the threaded IRQ handler.  There's an explicit comment
> about the threaded IRQ being accounted for in synchronize_irq():
>=20
> https://elixir.bootlin.com/linux/v5.9/source/kernel/irq/manage.c#L134

Ok cool sounds like it would work then. Thanks for reading the code for
me! :)

>=20
>=20
> > > If it doesn't work like I think it does, I'd be OK with peeking in the
> > > IRQ status register, but we shouldn't _skip_ the logic IMO.  As long
> > > as we believe that an interrupt could happen in the future we
> > > shouldn't return from handle_fifo_timeout().  It's impossible to
> > > reason about how future transfers would work if the pending interrupt
> > > from the previous transfer could fire at any point.
> >
> > Right. I just meant skip the timeout handling logic. We'd have to go
> > back to the timeout and keep waiting until the irq handler can run and
> > complete the completion variable.
> >
> > I forgot that this is half handled in the spi core though. Peeking at
> > m_irq doesn't look very easy to implement. It certainly seems like this
> > means the timeout handler is busted and the diagram earlier could
> > indicate that spi core is driving this logic from
> > spi_transfer_one_message().
>=20
> My assumption was that it was still OK (even if not perfect) to still
> process it as a timeout.  I just want to really make sure a future
> interrupt isn't going to show up.

I'm worried about the buffer disappearing if spi core calls handle_err()
but the geni_spi_isr() handler runs both an rx and a cancel/abort
routine. That doesn't seem to be the case though so it looks all fine.

>=20
> If we want to try to do better, we can do timeout handling ourselves.
> The SPI core allows for that.
>=20
>=20
> > So why don't we check for cur_xfer being NULL in the rx/tx handling
> > paths too and bail out there? Does the FIFO need to be cleared out in
> > such a situation that spi core thinks a timeout happened but there's RX
> > data according to m_irq? Do we need to read it all and throw it away? Or
> > does the abort/cancel clear out the RX fifo?
>=20
> I don't know for sure, but IMO it's safest to read anything that's in
> the FIFO.  It's also important to adjust the watermark in the TX case.
> The suggestions I provided in my original reply (#2 and #3) handle
> this and are plenty simple.
>=20
> As per my original reply, though, anything we do in the ISR doesn't
> replace the changes we need to make to handle_fifo_timeout().  It is
> very important that when handle_fifo_timeout() finishes that no future
> interrupts for old transfers will fire.
>=20

Alright. With a proper diagram in the commit text I think doing all of
the points, 1 through 3, would be good and required to leave the
hardware in a sane state for all the scenarios. Why do we need to call
synchronize_irq() at the start and end of handle_fifo_timeout() though?
Presumably having it at the start would make sure the long delayed irq
runs and handles any rx/tx by throwing it away. Sounds great, but having
it at the end leaves me confused. We want to make sure the cancel really
went through?  Don't we know that because the completion variable for
cancel succeeded?

I guess I'm not convinced that the hardware is so bad that it cancels
and aborts the sequencer, raises an irq for that, and then raises an irq
for the earlier rx/tx that the sequencer canceled out. Is that
happening? It's called a sequencer because presumably it runs a sequence
of operations like tx, rx, cs change, cancel, and abort. Hopefully it
doesn't run them out of order. If they run at the same time it's fine,
the irq handler will see all of them and throw away reads, etc.
