Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E802DDAC7
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 22:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgLQVWJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 16:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgLQVWI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Dec 2020 16:22:08 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A57C061794
        for <linux-spi@vger.kernel.org>; Thu, 17 Dec 2020 13:21:28 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id a6so24963vkb.8
        for <linux-spi@vger.kernel.org>; Thu, 17 Dec 2020 13:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rb4QRsrzHetcmVvjFenLb+xxlOjxCoQIDDaKT8olvy4=;
        b=eYrjHAZUBdAwFqXOsQgOfJ3405lOCKr+wOjixZJ2LjI5r8W+85GaTLEOtN9ZIRp5Hc
         toRNJQV5dByAv7/bgMj+44h94qcIXQwfMOxHanusirB8sAKW94E/7NeUPEj700eFBTne
         Ywh9h21AgnWgJX87hpuOVuK4isj7cuU36cxog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rb4QRsrzHetcmVvjFenLb+xxlOjxCoQIDDaKT8olvy4=;
        b=j/ruNcYLNQgj26YMqAi9rXOFdWSt5mIUbOYcXyXD047FQ6csDpwQlO+erqUDJSQeiL
         OHzzknS3QYH24XSoxSetyRczzhJ9c3AAQQPqUup7dx5Jozz7zEJ13W0Yn2kfv3U33MDn
         CNouLQtvPq83PBQYGorp3i2UBgTWZZD81Kv4nIbft3ZMMF5THmi5hPdTRJxj+qNicj9L
         1dE0yg6tmnQeTnewzBqJ9BPV/6IvC4fV2jE34RucUFQ5MRKKm6cufOXHpJ+gvqD0R7uK
         /raMgfWBiCTTLdhxYLY0HSNi4KIdtqKkWbr+hv/dKyoTFEK0tJqpIoYf7+aNUBB7B/2J
         rLJQ==
X-Gm-Message-State: AOAM533k5BXQO3W8rAW5itz3CYV8voNfBLoQ7N9FUhmpMGDfcfFLeAPG
        YPgwXvOdTvHOEp/nCYDCIu2UofxgJdbbFw==
X-Google-Smtp-Source: ABdhPJwx567qAwVGbN/fDxC6aEZcc3I7wKywlADQ0ziGH6ZkQMxxhH6l5/aHlKVaRNzfQLKhHDc1pw==
X-Received: by 2002:a1f:9156:: with SMTP id t83mr1019720vkd.3.1608240087386;
        Thu, 17 Dec 2020 13:21:27 -0800 (PST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id v126sm955935vkd.28.2020.12.17.13.21.26
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 13:21:26 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id a6so24937vkb.8
        for <linux-spi@vger.kernel.org>; Thu, 17 Dec 2020 13:21:26 -0800 (PST)
X-Received: by 2002:a1f:3fc9:: with SMTP id m192mr1317831vka.17.1608240085900;
 Thu, 17 Dec 2020 13:21:25 -0800 (PST)
MIME-Version: 1.0
References: <20201216144114.v2.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid>
 <20201216144114.v2.3.I07afdedcc49655c5d26880f8df9170aac5792378@changeid> <160817911850.1580929.16402785505110078436@swboyd.mtv.corp.google.com>
In-Reply-To: <160817911850.1580929.16402785505110078436@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Dec 2020 13:21:14 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WcVpkpwrLYVaXcRZmQztpw8in6b42+krRbN1+a8LVt6Q@mail.gmail.com>
Message-ID: <CAD=FV=WcVpkpwrLYVaXcRZmQztpw8in6b42+krRbN1+a8LVt6Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] spi: spi-geni-qcom: Don't try to set CS if an xfer
 is pending
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, msavaliy@qti.qualcomm.com,
        Akash Asthana <akashast@codeaurora.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Wed, Dec 16, 2020 at 8:25 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Douglas Anderson (2020-12-16 14:41:51)
> > If we get a timeout sending then this happens:
> > * spi_transfer_wait() will get a timeout.
> > * We'll set the chip select
> > * We'll call handle_err() => handle_fifo_timeout().
> >
> > Unfortunately that won't work so well on geni.  If we got a timeout
> > transferring then it's likely that our interrupt handler is blocked,
> > but we need that same interrupt handler to adjust the chip select.
> > Trying to set the chip select doesn't crash us but ends up confusing
> > our state machine and leads to messages like:
> >   Premature done. rx_rem = 32 bpw8
> >
> > Let's just drop the chip select request in this case.  Sure, we might
> > leave the chip select in the wrong state but it's likely it was going
> > to fail anyway and this avoids getting the driver even more confused
> > about what it's doing.
> >
> > The SPI core in general assumes that setting chip select is a simple
> > operation that doesn't fail.  Yet another reason to just reconfigure
> > the chip select line as GPIOs.
>
> Indeed.
>
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v2:
> > - ("spi: spi-geni-qcom: Don't try to set CS if an xfer is pending") new for v2.
> >
> >  drivers/spi/spi-geni-qcom.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> > index d988463e606f..0e4fa52ac017 100644
> > --- a/drivers/spi/spi-geni-qcom.c
> > +++ b/drivers/spi/spi-geni-qcom.c
> > @@ -204,9 +204,14 @@ static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
> >                 goto exit;
> >         }
> >
> > -       mas->cs_flag = set_flag;
> > -
> >         spin_lock_irq(&mas->lock);
> > +       if (mas->cur_xfer) {
>
> How is it possible that cs change happens when cur_xfer is non-NULL?

I'll add this to the commit message:

spi_transfer_one_message()
 ->transfer_one() AKA spi_geni_transfer_one()
  setup_fifo_xfer()
   mas->cur_xfer = non-NULL
 spi_transfer_wait() => TIMES OUT
 msg->status != -EINPROGRESS => goto out
 if (ret != 0 ...)
  spi_set_cs()
   ->set_cs AKA spi_geni_set_cs()
    # mas->cur_xfer is non-NULL

Specifically the place where cur_xfer is usually made NULL is in the
interrupt handler.  If that doesn't run then it will be non-NULL.


> > +               dev_err(mas->dev, "Can't set CS when prev xfter running\n");
>
> xfer? or xfter?

Will fix.


-Doug
