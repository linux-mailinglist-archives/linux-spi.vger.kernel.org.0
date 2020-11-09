Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF7E2ABF25
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 15:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731266AbgKIOsN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 09:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730338AbgKIOsN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 09:48:13 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088BAC0613CF;
        Mon,  9 Nov 2020 06:48:13 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id e27so12775472lfn.7;
        Mon, 09 Nov 2020 06:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K0FA6hn3mgfs3nr4Tq0aLjhCMC7Ar/moVNi5BoLwQZ0=;
        b=l6evJkKbqsoNee9rn/v9Uq+TWjJuWeQ6uKAIo58ktqGngWVJhFv2/I+GhDxG2BciPg
         WxgmObUCndcHUXQPIyJTC9bvoaWIgljVw4chV42s4idasbBz7QUcNcKejlio7Q6hbbiS
         3bwMsM1ZkxLJ5t2e56/m2a3zjtix5Wzp16UrqPsvTrIZC6aj9+OymGA2DnApkl4kzTwE
         jG183liWmwY8GRRmf/wIHUugf7QyBbXNTOBkXzL7gUFMLlbBKOr8+//182rj0eFTNqMQ
         3wgjQ1g7h9DiXPEQ3tAOlZ/hWbvtyMS9ZnXrisDeih6aHBWXLbN7a0wjZuLhm6Omdraa
         1Byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K0FA6hn3mgfs3nr4Tq0aLjhCMC7Ar/moVNi5BoLwQZ0=;
        b=oKScaCSBxKd8JkEI5kXcPxqusqiYbCEWe+y6UDyPZC5XAakQkTRXg7lOvjWFAy3ggs
         6Xj6aCX5Nxd962oQvQdpx6fBe8xyJxbcxJDxRj7G+vBc4QPwyUxtjVa0KWFeVWLNozVM
         5aKtRa4oTw6JA+NfFNcozgZ4iHRJvOCZ16fgFkQdrM7hjrRucQwUh3lgEJX7HRrOnVRg
         Gfl2sZqUko3o6Zsst5V+qFaJLIzHWTVSJngDXPt41NZqsK0iYuA0LWToZiV6o9xwXiwh
         CPYuxRoZ8Ojx1N3SN2+SlphhcRAkRWvTjzdcAFHplSqJIemKwVq/mY+GMVeHcdb27eR0
         d7nQ==
X-Gm-Message-State: AOAM5324pYDAiFRq1At8sYq1gBkLomTUAmuahrqCo/HPaPKssRoWDBN3
        9CiWHBmQGhtnYKzj/Z5HDjr26KSZAzGEnmFG
X-Google-Smtp-Source: ABdhPJwAYSC7luYDcL7xMZ5Pf3F7g3S4iKqCFXZDtrfHDwHahR6oW6F/q1A+lv8u2Laa/2TruqAzRw==
X-Received: by 2002:a19:7b06:: with SMTP id w6mr6263479lfc.260.1604933291552;
        Mon, 09 Nov 2020 06:48:11 -0800 (PST)
Received: from mobilestation ([95.79.141.114])
        by smtp.gmail.com with ESMTPSA id t22sm2200248ljh.89.2020.11.09.06.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 06:48:10 -0800 (PST)
Date:   Mon, 9 Nov 2020 17:48:08 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Sean Anderson <seanga2@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 03/32] spi: dw: Fix driving MOSI low while recieving
Message-ID: <20201109144808.mvttq2f6st7xd7sm@mobilestation>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-4-damien.lemoal@wdc.com>
 <20201109132935.GB6380@sirena.org.uk>
 <c37ca9be-ea92-b07a-b600-d68de4f7bde5@gmail.com>
 <20201109141422.GD6380@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109141422.GD6380@sirena.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 09, 2020 at 02:14:22PM +0000, Mark Brown wrote:
> On Mon, Nov 09, 2020 at 08:47:10AM -0500, Sean Anderson wrote:
> > On 11/9/20 8:29 AM, Mark Brown wrote:
> 
> > > In this case it also looks like the controller hardware requires
> > > transmit data and therefore should be setting SPI_MUST_TX and just
> > > removing the in driver default anyway, though that will have no effect
> > > one way or anther on the issue you're seeing.
> 

> > There is a recieve-only mode, but it is not used by this driver. Perhaps
> > it should be.
> 
> I'd expect it'd perform better, especially on systems that are
> apparently struggling for CPU bandwidth like yours seems to.

Well, it might seem a good idea to use that mode, but there are multiple problems
you may get in implementing it.

First of all the Receive-only mode is having a limited number bytes to receive
at once. It's just 64KB. So in order to implement it you'd need to split the
bigger transfers up, and feed the DMA engine with smaller chunks one-by-one.

Secondly the Receive-only mode will make the DW SSI controller to constantly receive
the data from the SPI bus and to put it into the Rx FIFO. So your DMA engine will
have to keep up with extracting the data from there on time, otherwise you'll
end up with Rx FIFO overflow error eventually. The problem will be actual for the
DMA engines/system buses, which are slower than the SPI bus speed, second for the
DMA engines with no hardware accelerated LLP traversal support (like on our DWC DMA
controller). The second problem can be also fixed by splitting the transfers up as
it has been already implemented in the spi-dw-dma.c. But the first problem can't be
fixed, but just workarounded by limiting the SPI bus frequency so the DMA engine
would keep up with incoming data traffic.

-Sergey

> 
> > > Please also try to avoid the use of master/slave terminology where
> > > reasonable, controller and device tend to work for SPI (though MOSI/MISO
> > > are going to be harder to shift).
> 
> > Here I use it to draw distinction between the SPI master and the SPI
> > slave, which are both devices in different contexts. 
> 
> If you find the use of device to refer to the device being controlled
> confusing consider also using something like client device instead,
> there's a number of ways to do it (there's a list in Documentation IIRC).


