Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6828C1888C0
	for <lists+linux-spi@lfdr.de>; Tue, 17 Mar 2020 16:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgCQPMp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Mar 2020 11:12:45 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:32856 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgCQPMp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Mar 2020 11:12:45 -0400
Received: by mail-vs1-f66.google.com with SMTP id y138so6304810vsy.0
        for <linux-spi@vger.kernel.org>; Tue, 17 Mar 2020 08:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TMnGNLtemyYfK63VsKtAIUfhYRVvGpYyUyZZJL3pFE8=;
        b=krPP7HlJbr5Dn8feHiKoBw/GYprYC3TKDcwhHNekL+6MG5CG72nWF0fp/Z4WONtZmZ
         nsaZLia3aLvc4Yasfn60ZXH0MF3i2iGNSVmiZ0TyUUkfTG9D1u2h30TH8V9R3Y/Ji6va
         ckIB9FCfSyqIcJL+IfFmAKzRjwm+b9IPUk8eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TMnGNLtemyYfK63VsKtAIUfhYRVvGpYyUyZZJL3pFE8=;
        b=HY8aV3lgXEYxvf9oQW1XbFgtqPsgpUSjr3Z/YPDqNX6WidU6QTWlvFVVqAH77h9QEP
         9PjefRJ3A70Zkjqt06B9vAw3LxVnIFmHT2QowtV8ubN9ft6Zl9C9Q5E68jsi5YvjO7aX
         kl86R28eTg3JySdJT/RixxnpKlHXBvy0agWu4bn8A4VI+LjZU7DAN7uVN5pCLVJ/FCpU
         sYnailN8ch1wKSuGlQ7N/kpvrqt8KZpDfQX+f5Nad36QABfUYbPshyfu/l2V0QRsQJVf
         tqNOk3LPcKrzm4g9oviu05iUZ/3PlKhZgVIh11WnTFDtpzKkQepUqT1V1CUM9gSaOHdl
         u95A==
X-Gm-Message-State: ANhLgQ0Id6FtGSWrO2XvDxNOl5ZNOYO+NusO2S7JJddOfe3Zrb0/Gzoi
        X7mm9tfcPgMhFesOkcdYIFNEf7xz/Do=
X-Google-Smtp-Source: ADFU+vte8w5MZYZyWfgc0mdOn+IMToI4aitYeLGXpAsEWbrLXJoNiNKmld/8lcLuElS/R5AvPV/6PQ==
X-Received: by 2002:a05:6102:52f:: with SMTP id m15mr4139926vsa.195.1584457963879;
        Tue, 17 Mar 2020 08:12:43 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id k24sm1683418uaq.15.2020.03.17.08.12.42
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 08:12:43 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id n6so14093293vsc.3
        for <linux-spi@vger.kernel.org>; Tue, 17 Mar 2020 08:12:42 -0700 (PDT)
X-Received: by 2002:a05:6102:7c7:: with SMTP id y7mr4207665vsg.198.1584457962249;
 Tue, 17 Mar 2020 08:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200316151939.1.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid>
 <20200317121018.GB3971@sirena.org.uk>
In-Reply-To: <20200317121018.GB3971@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 17 Mar 2020 08:12:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VAeOYAG-R6aeAAoo7TsuvDBgNnqxn3XE2Mw3hwL1H7Ew@mail.gmail.com>
Message-ID: <CAD=FV=VAeOYAG-R6aeAAoo7TsuvDBgNnqxn3XE2Mw3hwL1H7Ew@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Speculative fix of "nobody cared"
 about interrupt
To:     Mark Brown <broonie@kernel.org>
Cc:     Alok Chauhan <alokc@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>, skakit@codeaurora.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Tue, Mar 17, 2020 at 5:10 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Mar 16, 2020 at 03:20:01PM -0700, Douglas Anderson wrote:
>
> > +     /*
> > +      * We don't expect to hit this, but if we do we should try our best
> > +      * to clear the interrupts and return so we don't just get called
> > +      * again.
> > +      */
> > +     if (mas->cur_mcmd == CMD_NONE)
> > +             goto exit;
> > +
>
> Does this mean that there was an actual concrete message of type
> CMD_NONE or does it mean that there was no message waiting?  If there
> was no message then isn't the interrupt spurious?

There is no message of type "CMD_NONE".  The "cur_mcmd" field is
basically where in the software state machine we're at:

* CMD_NONE - Software thinks that the controller should be idle.
* CMD_XFER - Software has started a transfer.
* CMD_CS - Software has started a chip select change.
* CMD_CANCEL - Software sent a "cancel".

...so certainly if we see "cur_mcmd == CMD_NONE" in the interrupt
handler we're in an unexpected situation.  We don't expect interrupts
while idle.  I wouldn't necessarily say it was a spurious interrupt,
though.  To say that I'd rather look at the result of this line in the
IRQ handler:

    m_irq = readl(se->base + SE_GENI_M_IRQ_STATUS);

...if that line returns 0 then I would be willing to say it is a
spurious interrupt.


So there is really more than one issue at hand, I guess.

A) Why did we get an interrupt when we had "cur_mcmd == CMD_NONE"?
IMO this is due to weakly ordered memory and not enough locking.

B) If we do see an interrupt when "cur_mcmd == CMD_NONE" (even after
we fix the locking), what should we do?  IMO we should still try to
Ack it.  I can add a "pr_warn()" if it's helpful?

C) Do we care to try to detect spurious interrupts (by checking
SE_GENI_M_IRQ_STATUS) and return IRQ_NONE?  Right now a spurious
interrupt will be harmless because all of the logic in geni_spi_isr()
doesn't do anything if SE_GENI_M_IRQ_STATUS has no bits set.  ...but
it will still return IRQ_HANDLED.  I can't imagine anyone ever putting
this device on a shared interrupt, but if it's important I can detect
this and return IRQ_NONE in this case in a v2 of this patch.

-Doug
