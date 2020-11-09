Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C712AC68F
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 22:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgKIVFh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 16:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKIVFh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 16:05:37 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79ACC0613CF;
        Mon,  9 Nov 2020 13:05:35 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id z21so13118069lfe.12;
        Mon, 09 Nov 2020 13:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cOCI4SBuOxmuGoq5//5OC6v0o3RKmJwbRqP0ztXYBPg=;
        b=n4ngB+Vm9o9xmuhSrzJl37tTI/Ijz0DVTxm+2jswEXS09Xx7G9FcvVjduKzPqiR/6h
         erDLxVVBC2QuOEu6vUTQgNya971tH04Oe9/LQGtt7kQOwtNI5M/r6HNRxC6HRlzBoApi
         XElf7F9mhweqy1Y+2XC2fV+oCNMrJ8SGHADBgSw4t+S3tm2oth/xtrBlbuKiS9spOAY4
         HR6npPXPi8Zir6MXXqZFGIfL48LIdrpGIMf19GOJT6DTOI7WaIeNZLO6dl+d0Ja45sGW
         Ds+hyyz06ryoUtyE5hwiFb8vSmYSCWM48PUDhXQKThHFTBKpNB4KIUYE6GHwV/gU2tLv
         0ZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cOCI4SBuOxmuGoq5//5OC6v0o3RKmJwbRqP0ztXYBPg=;
        b=sqQYEU8sABOhp4zp+lwDljVDaFThRqDhdC8fpFzHeLRkkPCO1ZZnycxaVBVY9gF7/s
         ggURxqkUzmG30bl+cJjbuq7y2U0LHyi48TkPdOocgYl3KQXeRmaEsVe5Zrvpvqbpsf7L
         Qnzp4iBrJPI7ADlPk++KESgA2fud3njVL9dPzM6+3BG/0gVbsg5opEsQHj9yqax6gvDJ
         JRPqEh+wZedXVELNSKlGRpqr3RYd2yHwiybO57McXUQDML8z0CWyLh+oqgtrF2JGHOUe
         HUlhl5jnV6iJfMWGGSUti9fyEPhtgR1EaLwTWVaSBCmr8JBF+zyCR+tHshc3hKP94Xem
         rk8w==
X-Gm-Message-State: AOAM530EPhapEkI/plgR35KdqhgGa6Lg34WnsvePwtDk6IPpiRhH1Slo
        2YQ63umEN0CBgiYms7iPVXQ=
X-Google-Smtp-Source: ABdhPJxTsyoxQb7yCq2ZZTuh56M+VCAlvJvsmViI1PeyAplkpjFzX7nVjgWcN9JR3sBC8wg31tRoZA==
X-Received: by 2002:ac2:4216:: with SMTP id y22mr6171180lfh.169.1604955934247;
        Mon, 09 Nov 2020 13:05:34 -0800 (PST)
Received: from mobilestation ([95.79.141.114])
        by smtp.gmail.com with ESMTPSA id p5sm1920225lfj.0.2020.11.09.13.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:05:33 -0800 (PST)
Date:   Tue, 10 Nov 2020 00:05:31 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Sean Anderson <seanga2@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 03/32] spi: dw: Fix driving MOSI low while recieving
Message-ID: <20201109210531.wp4dmug4w2r4kh4p@mobilestation>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-4-damien.lemoal@wdc.com>
 <20201109132935.GB6380@sirena.org.uk>
 <c37ca9be-ea92-b07a-b600-d68de4f7bde5@gmail.com>
 <20201109141422.GD6380@sirena.org.uk>
 <20201109191909.wfuwpddng4rdn4ca@mobilestation>
 <20201109202052.GL6380@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109202052.GL6380@sirena.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 09, 2020 at 08:20:52PM +0000, Mark Brown wrote:
> On Mon, Nov 09, 2020 at 10:19:09PM +0300, Serge Semin wrote:
> > On Mon, Nov 09, 2020 at 02:14:22PM +0000, Mark Brown wrote:
> 
> > > I'd expect it'd perform better, especially on systems that are
> > > apparently struggling for CPU bandwidth like yours seems to.
> 
> > CPU-wise. RO-mode won't help in that case. Moreover it will be even
> > more errors-prone for the systems with small CPU bandwidth. As I said
> 
> Right, these are two separate issues - one is that the client device
> has requirements on the transmit data at times when the driver isn't
> defining what should be transmitted, the other is that the controller
> driver is using full duplex mode even for single duplex data.  I just
> happened to notice the second issue while reviewing the change - there
> shouldn't be any code for setting the dummy transmit pattern in the
> driver in the first place.
> 
> > 2) Rx-only with atomic CPU utilization. In order to make sure that the
> > CPU keeps up with fetching the data from the Rx FIFO, we have to
> > disable the local CPU IRQs while performing the Rx-only transfers, so
> > to prevent the Rx FIFO overflow while the CPU is doing something else.
> 
> ...
> 
> > So in all other cases for normal CPU-based SPI-transfers when
> > GPIO-based chip-select is available the safest solution would be to
> > use a normal Push-Pull mode. In this case we have no risk in getting
> > the Rx FIFO overflow unless there is a bug in the code, which is
> > fixable anyway.
> 

> I'm not clear why we would have issues with the FIFO overflowing in PIO
> mode, especially with a GPIO chip select - even if we're forced to tell
> the controller how big the transfer is if we're using a GPIO chip select

> we could just tell it we're doing a series of FIFO sized transfers?

Hm, you are right. Splitting the Rx-only transfers on the chunks with
lengths smaller than the FIFO size indeed would have solved the
problem of the Rx FIFO overflow with GPIO-based CS hardware. Don't
really know how I missed that. Most likely because when concerning the
Tx-only/Rx-only/EEPROM-read modes I always think about the native
chip-select automatic assertion/de-assertion, in which case we have no
other way but to provide the SPI-transfers/message atomicity.

> 
> > Another possible solution for the problem would be to fix the SPI core
> > so aside with tx_buf being set to the NULL-pointer, a client driver
> > would provide a default level or some specific value being put to the
> > SPI bus on Rx-only transfers. If an SPI-controller is capable of
> > satisfying the request, then it will accept the transfer. If it's not,
> > then the SPI core may try to convert the Rx-only transfer into the
> > Full-duplex transfer with the Tx-buffer being initialized with the
> > requested level.
> 

> We do have support in the core for creating dummy data buffers for
> controllers that can't do half duplex - that's the SPI_MUST_TX and
> matching SPI_MUST_RX that I mentioned in my initial reply.  Currently we
> always zero fill transmit buffers, the expected semantic is that if the
> client driver isn't supplying data that means the device doesn't care
> what gets sent and it's not clear to me that it isn't sensible to just
> keep that like I said earlier,

> I don't know how common it's going to be
> to need this since most half duplex transfers generally are half duplex.
> The whole point with the SPI_MUST_ flags was to remove the need for
> controller drivers to open code handling this, it was adding
> complication and supporting configuration of the dummy data feels like
> it's adding room for things to go wrong.

If by general Rx-only half-duplex transfers you meant that the client
SPI-device shall just not care what the MOSI level, then the only
acceptable solution of the noted in this patch problem is to fix the
client driver. Since in case of the MMC-SPI client device sometimes it
does care about the level.

-Sergey

