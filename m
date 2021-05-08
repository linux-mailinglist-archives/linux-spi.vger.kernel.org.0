Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DF9376EEF
	for <lists+linux-spi@lfdr.de>; Sat,  8 May 2021 04:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhEHCqR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 May 2021 22:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhEHCqR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 May 2021 22:46:17 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A1DC061574
        for <linux-spi@vger.kernel.org>; Fri,  7 May 2021 19:45:16 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b15so9217942pfl.4
        for <linux-spi@vger.kernel.org>; Fri, 07 May 2021 19:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pbUNc5llcQ9qbObTLrmf/A1vx6tUtsC/Gdf50hgfp2k=;
        b=TnlVk+E14A3u5p/jV4MAu/Kk6pGRvjic8kBTUpFLsJGtPxWiioeK7S5xiV6I4uQ+7J
         6SIFAXpic9vmS9wEUc69WFEy5p5fShNr4QnOdxRCOnpvncDBCLKnV5zlPKZIb7+oP+pi
         WINCBBLR+bnION2cO4lX1RB+tNoTKALq+OGD+MSdrneXEG3Hyqh5ts7IF0gvr+uZn+KW
         kSpJvz6K0PyeG/QSIziLdhJ9f0rZG0D+w1M+7in3emDokNWLzjmd19iWOA5UEBTYEWym
         w+4jYUBrgwQe5GosH9yoM7S1spDFzA2yivLW6+XGIOODVhIVQslBnoAQhrkwWnHRQmRp
         KWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pbUNc5llcQ9qbObTLrmf/A1vx6tUtsC/Gdf50hgfp2k=;
        b=RFTto96sP86kuPMoWSmWe16AZC9ELsmXNN6FjfraU27KfaHYM1o68Ez1GJ7MebSAg0
         mRfhwG1JQu0WtzqFO0DlKEQgAm4tXJzeefnigkPx/49jyl6Pc1FWmQozmb/4UlFlmW5I
         bUTWErCLaGdv0+b06Kz3iSU0FpRM8F/9vJLZzC/W9uL8khFeTkzpZKDhwNby7Ep+a8ct
         EeydOwT7Yt/SYrkGVugZmuJq6njcOxw+vOYpKBZ8VnmyuvFH+Xm5Y4aZ9U9e/TszAS3w
         ABHi5TnRBajm+hsXBp7LRfU4013hCGEzzxHrTLwb1NWlHj3Node3RGVtJpGItEmLfEF2
         u8Hw==
X-Gm-Message-State: AOAM5324pBjvYdEzvp+FmM7tUgddVRkQ3CzPtemIAs5ejy9B0kqKs44Q
        FHNDQF8rGgx1+ByehOlNbSc=
X-Google-Smtp-Source: ABdhPJwC9o8TNtVuRkmdDpEu5dIkKH4PUMjU/WRB0GMXhQRqAyNYd0TkhfHj56JSR7jk+BkD6p4aIQ==
X-Received: by 2002:a62:ee09:0:b029:211:1113:2e7c with SMTP id e9-20020a62ee090000b029021111132e7cmr13329120pfi.49.1620441915581;
        Fri, 07 May 2021 19:45:15 -0700 (PDT)
Received: from [192.168.137.17] ([71.212.140.226])
        by smtp.gmail.com with ESMTPSA id 132sm5471640pfu.107.2021.05.07.19.45.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 19:45:15 -0700 (PDT)
From:   "Jonathan Lemon" <jonathan.lemon@gmail.com>
To:     "Ricardo Ribalda Delgado" <ribalda@kernel.org>
Cc:     "Mark Brown" <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH] spi: xilinx: Inhibit transmitter while filling TX FIFO
Date:   Fri, 07 May 2021 19:44:58 -0700
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <0B4232D1-E80F-404A-B388-C53EFDF70DDA@gmail.com>
In-Reply-To: <3E382801-224D-4B11-961D-4822F51F5496@gmail.com>
References: <20210507215319.3882138-1-jonathan.lemon@gmail.com>
 <CAPybu_0eWaEdtaUWAZUaBDGonX7cjeLNCTszsCDEHrJeEC8QGQ@mail.gmail.com>
 <3E382801-224D-4B11-961D-4822F51F5496@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 7 May 2021, at 17:46, Jonathan Lemon wrote:

> On 7 May 2021, at 16:02, Ricardo Ribalda Delgado wrote:
>
>> Hi Jonathan
>>
>> Thanks for your patch.
>>
>> On Fri, May 7, 2021 at 11:53 PM Jonathan Lemon 
>> <jonathan.lemon@gmail.com> wrote:
>>>
>>> Contrary to the comment in xilinx_spi_txrx_bufs(), the transmitter
>>> was not disabled on entry.  On my particular board, when sending a 
>>> PP
>>> sequence, the first address byte was clocked out 3 times, writing 
>>> data
>>> into the wrong location, and generally locking up the chip.
>>
>> Sorry, what do you mean by PP sequence?
>>
>> By clocked out 3 times you mean that the sequence is sent like
>> B0........B1.........B2
>> instead of:
>> B0B1B2
>
> PP: Page program.  When I’m trying to write to the flash, the 
> sequence
> [opcode 02][A1 A2 A3][D1 D2 ..] is sent.  The result is a flash write
> at location [A1 A1 A1] = [A2 A3 D1 D2 ...]
>
> In other words, the first byte of the address appears to have been
> sent to the chip 3x.
>
>
>> If your hardware supports IRQ. can you try forcing use_irq to true?
>
> Will try this in a bit.  The hw does have an irq registered, but it
> it isn't always set, as it depends on how many how many bytes the
> spi_transfer sets.  So sometimes it will set use_irq, and sometimes 
> not.

So I tried the following change:

-       if (xspi->irq >= 0 &&  remaining_words > xspi->buffer_size) {
+       if (xspi->irq >= 0) {

And that also allows writes to to through successfully.   Perhaps
this is a simpler change that would work?
-- 
Jonathan
