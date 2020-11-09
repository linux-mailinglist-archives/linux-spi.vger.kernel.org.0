Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356F02AC5D5
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 21:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbgKIURt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 15:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgKIURt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 15:17:49 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEC2C0613CF;
        Mon,  9 Nov 2020 12:17:48 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id l10so11983801lji.4;
        Mon, 09 Nov 2020 12:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=39IRg2jSbMkxk30nBeMpPpnqXXb5weUeM3ki0KRmtXw=;
        b=p+tLe7nrrRRz6AT3ZKbFb1QzBpaFAMM3+X3HJ06XGx18X/XfM3ehCHHwjk3U93TS28
         Y8ulIRXTdGf7h6OBjE5qrSuKnNXM6rOI/OGxCvN/MDh7UzTjKxQOEKRp4Ae6+ooG+SCZ
         KFWNJcY5DOW6DbD5maxgkFuW069b+oI6UzOj6SF1jJoCslAW2Ic4GIFoT/3fx2Qg+cZT
         qHS7yMNasGCec9rgzfGrJBaftKrE5ZlTx0d+fFNfHoUOVJnLl6bS+mykX1a5KN3RQqLZ
         Mz/+xqKJdp91/RCeyaHsVrckk3Aa/naA00mCPT7pbMApY9ziGhjBp1O7iQepL8vdGd7K
         VZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=39IRg2jSbMkxk30nBeMpPpnqXXb5weUeM3ki0KRmtXw=;
        b=EVZLCtS1ppZ5w3my5l1uq/N4vxsNux6lfgtgZ5R+SJkjsIjefqFCW9KFoDyCJq61Na
         BvVaFy6uUR0TcMZHcIpB/YqZPnOMjG3AK9dt95Vqk78QlWEpJBRicyBXAJ7vGmiB7Dfc
         cMXiTZoj/jqZBJThkq9NngxWDoQ5x2l+z+imBMwTKyfc/Knn0ZienS9Mo8iEjXf1XVqZ
         P++r6T0YT8/a06G67p09BNEWwUN3wrWu5thrTnx/TDmvqUsWh538X50pf1dtinWmGUrh
         RBre7Tm6+/Vdv2aVOUu8rGR+GGeOSkuPHIZLhBsw3MWvnD3kEJlm22XC1Buc7yAZgj48
         NcEw==
X-Gm-Message-State: AOAM5317tKt57fVq0JBP+Ik4C5OoiEA4F/cSrabPfDaYigx7WCQKezaI
        zvNed9mcglxGFgLs0Ts2WOQ=
X-Google-Smtp-Source: ABdhPJwuoRdhlj8Lnwz+dXtVRMjzbV5nJxA24wh6QyJBwjZalEeG2zoyRrt3AFE+STvjCj9VrkvhOg==
X-Received: by 2002:a05:651c:103b:: with SMTP id w27mr6562923ljm.323.1604953066991;
        Mon, 09 Nov 2020 12:17:46 -0800 (PST)
Received: from mobilestation ([95.79.141.114])
        by smtp.gmail.com with ESMTPSA id m10sm1867427lfo.237.2020.11.09.12.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 12:17:46 -0800 (PST)
Date:   Mon, 9 Nov 2020 23:17:44 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sean Anderson <seanga2@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 03/32] spi: dw: Fix driving MOSI low while recieving
Message-ID: <20201109201744.zlxwur4p3ejbraup@mobilestation>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-4-damien.lemoal@wdc.com>
 <20201109132935.GB6380@sirena.org.uk>
 <c37ca9be-ea92-b07a-b600-d68de4f7bde5@gmail.com>
 <20201109141422.GD6380@sirena.org.uk>
 <20201109191909.wfuwpddng4rdn4ca@mobilestation>
 <5808c9b9-5955-4733-2c56-b93c627cb556@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5808c9b9-5955-4733-2c56-b93c627cb556@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 09, 2020 at 02:40:01PM -0500, Sean Anderson wrote:
> On 11/9/20 2:19 PM, Serge Semin wrote:
> > On Mon, Nov 09, 2020 at 02:14:22PM +0000, Mark Brown wrote:
> >> On Mon, Nov 09, 2020 at 08:47:10AM -0500, Sean Anderson wrote:
> >>> On 11/9/20 8:29 AM, Mark Brown wrote:
> >>>> On Sat, Nov 07, 2020 at 05:13:51PM +0900, Damien Le Moal wrote:
> >>>>
> > 
> >>>>> The resting state of MOSI is high when nothing is driving it. If we
> >>>>> drive it low while recieving, it looks like we are transmitting 0x00
> >>>>> instead of transmitting nothing. This can confuse slaves (like SD cards)
> >>>>> which allow new commands to be sent over MOSI while they are returning
> >>>>> data over MISO. The return of MOSI from 0 to 1 at the end of recieving
> >>>>> a byte can look like a start bit and a transmission bit to an SD card.
> > 
> > Yeah, that's what we've also experienced on our systems. We've worked
> > around the problem in exactly the same way as you have. But we haven't
> > dared to send it out as the solution seemed a bit hackish.
> 

> Well, the way it is now is equally wrong, since it is driving the line
> low.

Alas a lot of the SPI-controller drivers have got it implemented in the
same way. So, yeah, all of them won't work well with the SPI-based MMC
interfaces, unless either the client driver or the SPI core code are
properly fixed.

> 
> >>>>
> >>>> If client devices are interpreting the transmitted data then I would
> >>>> expect the drivers for that hardware to be ensuring that whatever we
> >>>> transmit matches what the device is expecting.  We shouldn't be putting
> >>>> a hack in a particular controller driver to paper over things, that will
> >>>> mean that the device will break when used with other controllers and if
> >>>> different devices have different requirements then obviously we can't
> >>>> satisfy them.  There is not meaningfully a general specification for SPI
> >>>> which says what happens when signals are idle, it's all specific to the
> >>>> client device.
> >>>>
> >>>> In this case it also looks like the controller hardware requires
> >>>> transmit data and therefore should be setting SPI_MUST_TX and just
> >>>> removing the in driver default anyway, though that will have no effect
> >>>> one way or anther on the issue you're seeing.
> >>
> > 
> >>> There is a recieve-only mode, but it is not used by this driver. Perhaps
> >>> it should be.
> >>
> >> I'd expect it'd perform better, especially on systems that are
> >> apparently struggling for CPU bandwidth like yours seems to.
> > 
> > CPU-wise. RO-mode won't help in that case. Moreover it will be even
> > more errors-prone for the systems with small CPU bandwidth. As I said
> > the Receive-only mode will make the SPI controller automatically
> > receiving data from the SPI bus and putting it into the Rx FIFO. If
> > CPU is either busy with something else or too slow in fetching the
> > data from the Rx FIFO, the FIFO will be eventually overflown with
> > data, which we need to avoid at all cost.
> > 
> > As I see it the Receive-only mode is only acceptable in the next two
> > situations:
> > 
> > 1) Rx-only DMA. But only if the DMA-engine and system bus are fast
> > enough to fetch the incoming data on time. (Note for example in our
> > system some DWC DMA-engine channels don't work well with the DW APB
> > SSI working with full-speed, so we had to set constraints on the DWC
> > DMA channels being used in conjunction with the DW APB SSI
> > controller.)
> > 
> > 2) Rx-only with atomic CPU utilization. In order to make sure that the
> > CPU keeps up with fetching the data from the Rx FIFO, we have to
> > disable the local CPU IRQs while performing the Rx-only transfers, so
> > to prevent the Rx FIFO overflow while the CPU is doing something else.
> > Needless to say that such approach should be utilized only as a last
> > resort, if we have no choice but to run the Receive-only transfers.
> > Because locking the CPU for God knows how much time may cause the
> > system interactivity degradation. For instance, a possible use-case of
> > that design is when the controller is communicating with the
> > SPI-devices with native DW APB SSI chip-select attached. BTW You can
> > also find that design implemented in the kernel 5.10 spi-dw-core.c
> > driver in context of the SPI-memory operations (with my last patches
> > merged in). In particular I had to use it to handle the CPU-based
> > EEPROM-read mode.
> > 
> > So in all other cases for normal CPU-based SPI-transfers when
> > GPIO-based chip-select is available the safest solution would be to
> > use a normal Push-Pull mode. In this case we have no risk in getting
> > the Rx FIFO overflow unless there is a bug in the code, which is
> > fixable anyway.
> > 
> > Getting back to the patch. In fact I don't really see how the
> > Receive-only mode will help us with solving the problem noted in the
> > patch log.
> 

> Shouldn't it put MOSI into High-Z like when the device is idle? The
> issue is mainly that the idle state and RX state are different.

AFAICS the manual doesn't say anything about High-Z, but only: "In
receive-only mode, transmitted data are not valid. After the first
write to the transmit FIFO, the same word is retransmitted for the
duration of the transfer."

I don't know for sure what "word" the authors meant, but it doesn't
sound like Tri-state anyway. So some value will still be put out on
the bus. Most likely it's the word written to the Tx-buffer to
initiate the Rx-only transfer.

> 
> > As Mark said the problem with the Tx data on Rx-only
> > transfers should be fixed on the client side. If an subordinate
> > SPI-device needs a specific value to be received in that case, then
> > that value should be somehow provided to the SPI-controller anyway.
> > So the native Rx-only mode of the DW APB SSI controller won't help.
> > Currently it's possible to be done only by executing a Full-duplex
> > SPI-transfer with the Tx-buffer being pre-initialized with that
> > value.
> > 
> > Another possible solution for the problem would be to fix the SPI core
> > so aside with tx_buf being set to the NULL-pointer, a client driver
> > would provide a default level or some specific value being put to the
> > SPI bus on Rx-only transfers. If an SPI-controller is capable of
> > satisfying the request, then it will accept the transfer. If it's not,
> > then the SPI core may try to convert the Rx-only transfer into the
> > Full-duplex transfer with the Tx-buffer being initialized with the
> > requested level.
> 

> This is probably the most general solution; is there an existing way to
> specify this sort of thing?

Without touching the SPI core code, as Mark said, the problem is
fixable only by converting the client-driver to executing the
Full-duplex SPI-transfers instead of the Rx-only ones. The client
driver will have to allocate a dummy-buffer and pre-initialize it with
the required default value of the MOSI lane.

-Sergey

> 
> --Sean
