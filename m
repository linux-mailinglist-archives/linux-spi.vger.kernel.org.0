Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E563B3AEA9D
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jun 2021 15:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhFUN7a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Jun 2021 09:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbhFUN73 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Jun 2021 09:59:29 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93469C061574;
        Mon, 21 Jun 2021 06:57:14 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id l26so1112239vsm.9;
        Mon, 21 Jun 2021 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pZVttNnY2gk0Fem9oit8zoLa/S60n/zV3eRb8RtWkIo=;
        b=omonsKx4kzZUxJ/IX8sdmhoKuezWoqXSOl1LJ6QM3Bjhl73T7aK/y4WGY+rN5Mkz91
         H573Y+sMRItTZzlvLDrM9D2pHbrw1ZSLlJEdWppYoicoR011ROcivMfF9P1LD3kzBsnl
         NCOGHBROub+knDGf7dvTJW83yPI6nkhora8aJYm2+DLYI5y64fP0MaWa3n1hU8/rsVqB
         H4KcvmA+y3SkvmCyji+RGtQe9rtK/CchfeU3VtrAeVI+JmgriQ8CpONOaP7QVL4W+Z2a
         mr7yfY2IRw6g4lqv/IkH2ioB/tQTxSXGEeXL1RT89KT8j8LrF23XeXtMJj0KvHPSMjqO
         P1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pZVttNnY2gk0Fem9oit8zoLa/S60n/zV3eRb8RtWkIo=;
        b=Yg12RAwcLMWjHVl9PFNCndKzPO8gE+Ym6/tgdRmPrEtpqpVIqpVXAFPX2iIa9uTrX5
         cr01XE6SQZfxUcrt79opZupQtunzmf63SNiCSTkyuk7She75I+UZOCM+wKzqHNh2NKaO
         93/EWvi2nvc8ei7JxUKIw4STiNtKY9LO3KV9bATghLVthbKKWITf87kMd3/6ti3FrRoi
         kHx/6zyeAjcRvUDmNUt39sVBYuM4FZxgLzRt/PRoo2i2oHlFO+YdE4E0MljqrmA8dktU
         F1GR8RGryXNoZeza+xTrkr6Iij0d0h7xLdj6IcV/JtH/nG0ctFvo7JXHXMCmaZLQ4z5H
         okQQ==
X-Gm-Message-State: AOAM531NirVTZyo8spJTH1/J29fUiX7HR+jdD3k6NjQRaRnIaEjpkH/W
        Rm2B8sVR1WcIkLZlPPyazowRSAcWTFAOyvzDgu4=
X-Google-Smtp-Source: ABdhPJwPDiEsJYtuFJTZahcoVl+G+uhTJ31CBMtSLNxssW4XS/NzCuYrSqkNLtoa9n7uAwOf0f4prEFHCwxEGIR0o3c=
X-Received: by 2002:a67:f48c:: with SMTP id o12mr16826051vsn.13.1624283833786;
 Mon, 21 Jun 2021 06:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210527084531.18989-1-christian.gmeiner@gmail.com>
 <CAH9NwWfh9-2+kLoTXJgkVSStb1cHHvC-He5jnfFxMpUngMeAtA@mail.gmail.com> <20210616194347.GC6418@sirena.org.uk>
In-Reply-To: <20210616194347.GC6418@sirena.org.uk>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Mon, 21 Jun 2021 15:57:02 +0200
Message-ID: <CAH9NwWffSZB5xkXJ+1EOs5Su3UOifqn+oJHtCGMs=xWvCW4xbg@mail.gmail.com>
Subject: Re: [PATCH] spidev: add platform driver support
To:     Mark Brown <broonie@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

Am Mi., 16. Juni 2021 um 21:44 Uhr schrieb Mark Brown <broonie@kernel.org>:
>
> On Wed, Jun 16, 2021 at 09:16:44PM +0200, Christian Gmeiner wrote:
>
> > ping
>
> I replied to your mail some time ago...
>

It did not land in my in-box and I do not see your mail here:
https://patches.linaro.org/patch/449250/
In the end I found it only here:
https://lore.kernel.org/lkml/YK9wDd%2F+c1uAjwk7@sirena.org.uk/

This makes it basically quite hard to answer your question. So will do it here:

> > This makes it possible to use spidev in combination with the
> > MFD subsystem. The MFD subsystem add platform_driver devices.

> This is a really strange thing to want to do so it needs a
> changelog which explains what the goal is and why this is a good
> way of accomplishing that goal.

I am currently working on a system controller that is connected via
SPI. The system controller
provides a handful of LEDs, a hex switch and some GPIOs. All of this
can be modeled quite easily
with the MFD subsystem but the e.g. LED subsystem.

The biggest pain point is that this system controller or the used FPGA
can be updated via SPI. And
I see no suitable subsystem to handle this update case.

That's why I have chosen to expose the SPI device also via spidev.

>
> Also:
>
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so
> on so unless there is some reason for urgency (like critical bug fixes)
> please allow at least a couple of weeks for review.  If there have been
> review comments then people may be waiting for those to be addressed.
>

I am aware of the rules.. but as I told you I got nothing in my in-box
for 2 weeks.

> Sending content free pings adds to the mail volume (if they are seen at
> all) which is often the problem and since they can't be reviewed
> directly if something has gone wrong you'll have to resend the patches
> anyway, so sending again is generally a better approach though there are
> some other maintainers who like them - if in doubt look at how patches
> for the subsystem are normally handled.
>
> Please don't top post, reply in line with needed context.  This allows
> readers to readily follow the flow of conversation and understand what
> you are talking about and also helps ensure that everything in the
> discussion is being addressed.

Yeah.. I should never ever send a mail from my smartphone.


--
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
