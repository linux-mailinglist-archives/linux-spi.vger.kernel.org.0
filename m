Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F982EC78D
	for <lists+linux-spi@lfdr.de>; Thu,  7 Jan 2021 01:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbhAGA5z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 Jan 2021 19:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbhAGA5y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 6 Jan 2021 19:57:54 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CF5C0612EF
        for <linux-spi@vger.kernel.org>; Wed,  6 Jan 2021 16:57:14 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id l11so10921394lfg.0
        for <linux-spi@vger.kernel.org>; Wed, 06 Jan 2021 16:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4L2ilwEvbFs0xPTIVaPMjECMC0O+wLtADzZ9JsyRFeg=;
        b=Bn4ch0i5S38AJBnXHyCVm6uQyAganNYXM90ZPc3JLVAIeGESBMn/VDv2B5WkSxT5Zk
         aFtc/uh9iD/6roVxYUcp8qHFiQ5z2XMh6DibpzrTrPrmaQAiMbDKfWjRGZfOFNBqnLe6
         QqH1SzRJO2gTV9w/c1OuWzs7064u9CVpF0ZsoMU+YIOMDxDgLHJWFNa/a6FBhNEXaZyK
         LFBejmjNW193YjkYPZ8Oq9qxHBkXHZhGcjVC8ysP6FJX4JXJTEaaRe4f7mxC4xkSZ+HL
         VscL71JR+01iznouCY0f31m0m29uGO2KWtRsKPEEnzQfv7a++g8lTCSGkv03bfMVbd3M
         XLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4L2ilwEvbFs0xPTIVaPMjECMC0O+wLtADzZ9JsyRFeg=;
        b=gYF48RD6t91RtdeX8pkSfMcxqrfSIBZft5ER4Bf/R9mH124EKh2wBpFFHCJHnjC9V/
         6BkDVLl8sol+udBNqLkjVEQYrwfSNCsPwMuycEacMwBthqgWwBW4EFvXF0+u8oh+vUn0
         w+IG+djZUrIMAtRlvf8vAZ9yeveB/ughIHSi8vRi4mz84gFbETeRbJlQRtc5J1lHdBQ7
         BfSrh9NYMbB7H76zKYzSpuchwMpoe30YxCTTysrsNMf/EDjht9pGK2R6xRAyE7bOpemL
         M+FIga0ME8y3QNfdV5CDMEp4GeE1oe4/BGHS4J6uBaxm+Z9Bx2kFezZwFLqf1vHG2XKS
         cNMQ==
X-Gm-Message-State: AOAM533G/7tAVJdUP+Y7iBa3Z3Dxr5YJO/ZtUNVwjfVx8pT4Ea3dywzH
        YVsrhf1mw5WyisKUsdvNddxFgydGD4WnITqCx5mnn8ErU9M=
X-Google-Smtp-Source: ABdhPJwEIoGz3gjoJckfsYt8Y9qlGH7O7xR+2wqdBsFwh2u5+jLhkSEENB7t+gtFi/4a5Ov6GU/9xOuoz/hdtv+2YgM=
X-Received: by 2002:a19:40d7:: with SMTP id n206mr2794336lfa.27.1609981032737;
 Wed, 06 Jan 2021 16:57:12 -0800 (PST)
MIME-Version: 1.0
References: <CAF78GY3NWQ1jzkauG26nagcMuqR0=u7zcWLh+wDdrJ8G=e7how@mail.gmail.com>
 <20210106130049.GC4752@sirena.org.uk> <CAF78GY3=m0kMd3d4tS92tZS57mY5XeRuXtET+BVVvnTwcdtO3g@mail.gmail.com>
 <20210106173759.GF4752@sirena.org.uk>
In-Reply-To: <20210106173759.GF4752@sirena.org.uk>
From:   Vincent Pelletier <plr.vincent@gmail.com>
Date:   Thu, 7 Jan 2021 09:57:01 +0900
Message-ID: <CAF78GY0xnKrOj5RhU2GHcQUTo2MLryrBj3+5dAMKoGzJn2okYw@mail.gmail.com>
Subject: Re: 5.11.0-rc1+: "Division by zero in kernel." when writing to spidev
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jan 7, 2021 at 2:38 AM Mark Brown <broonie@kernel.org> wrote:
> I wouldn't have thought that would be something in your DT, unless it
> was previously buggy and some issue has been exposed, but then nothing
> springs to mind as being potentially relevant either.

I've started reading spi-bcm2835.c, and while I cannot claim that I understand
everything I'm reading, it raises some flags:
- it does not use "spi_finalize_current_transfer(...)" at all, but rather
  "complete(&...->xfer_completion)". The former only calls the latter,
  so this code seems technically correct, but this looks like an
  abstraction layer bust.
- while it uses "complete(...)" on its IRQ and DMA transfer codepaths,
  I do not see it being called on its polled codepath
  (bcm2835_spi_transfer_one_poll).
- ...polled codepath which checks bs->rx_len to tell when it's done,
  independently of transfer direction. And while tx_len and rx_len are
initialised
  to the same value, only the field actually corresponding to the
actual transfer
  direction will be updated within this polling loop.
  So maybe some transfers could timeout in the polled codepath and would
  still end up in the IRQ one which would end up calling "complete", but this
  looks suspicious.

Checking on 5.10.4, I see:
root@sushi:/sys/kernel/debug/spi-bcm2835-20204000.spi# cat count_transfer_dma
2
root@sushi:/sys/kernel/debug/spi-bcm2835-20204000.spi# cat count_transfer_irq
1
root@sushi:/sys/kernel/debug/spi-bcm2835-20204000.spi# cat
count_transfer_polling
27
root@sushi:/sys/kernel/debug/spi-bcm2835-20204000.spi# cat
count_transfer_irq_after_polling
0

so I am apparently not triggering the poll-then-IRQ case, but am
triggering the others
on this kernel version.

On 5.11, this becomes:
root@sushi:/sys/kernel/debug/spi-bcm2835-20204000.spi# cat count_transfer_dma
2
root@sushi:/sys/kernel/debug/spi-bcm2835-20204000.spi# cat count_transfer_irq
24
root@sushi:/sys/kernel/debug/spi-bcm2835-20204000.spi# cat
count_transfer_polling
0
root@sushi:/sys/kernel/debug/spi-bcm2835-20204000.spi# cat
count_transfer_irq_after_polling
0

so somehow this is not triggering polling transfers anymore, so the
maybe-missing
completion call would probably not matter.

Also, it sets can_dma with a function pointer, but ends up only
checking can_dma as
a boolean and then calls the function by name rather than using the
value stored in
can_dma. Again this looks technically correct (and is very much
unrelated to my issue)
as can_dma does not take any other value and a valid function address would not
evaluate as false, but it is surprising to my naive reading.

I'll continue poking around later (especially checking computed timeout values),
should I submit patches for s/complete/spi_finalize_current_transfer/ ?

Regards,
-- 
Vincent Pelletier
