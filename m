Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC77E1DECAE
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 18:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbgEVQAB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 12:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730416AbgEVQAB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 May 2020 12:00:01 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F03AC061A0E;
        Fri, 22 May 2020 09:00:01 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k18so11913544ion.0;
        Fri, 22 May 2020 09:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FHIFAWUYDhJ80n0eXg0z7nTHf0/vDwtgn87D1kTvKZw=;
        b=VwHlaoAfnE0jrQI4ME3ZjZ87Fl8fMiI7FOB/65iDK32jeXJ0r6Bf6SnfYRIVEO6k6m
         DzlctHIuvMnhbnvAziB3ubyH4olRzONZWriz82tW84id41d+G0aaZsGJzAQD9SqY6STl
         U+KIXtBjUhXfneehG1qd35VDkYmEVKk7k7U5Q0d9nJw20AfuQV3MvWXVSY1liADEoJS7
         FgJEadNiBp+b7li6e5pXHsRL5ssVBlR672GS1Q9jDnRZiYAnpONVjiZRHjbbr9FFH8d8
         W/7kM258Bwcm/cHTYm/kHaSY9DU3wWohGjofhiEvbcNCowmRsk2+eu46fBFd/xkb9Pl+
         kx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FHIFAWUYDhJ80n0eXg0z7nTHf0/vDwtgn87D1kTvKZw=;
        b=A+yNY/YXKJ6E9VflmGi2yzcNMcGYRk8ULZrbxPRdk9Rxt1TSv4XA+NW9MZsR7t9sUZ
         Oikc+TKegcjZoGLfF2fG05y2JbGuZEQJA2eEPHuy6ooD5J+81pdxFuI8S65rqRD82BeL
         IBz4r2vB7OTxRO0A6vTz08ngBHG7i028l9TiVVOuDH1hppRf72Kke1JdjMcibvagaXUl
         MoaQZKDhzXF0wDERXCyMclhTbGWPo+4mwpLYmvNzoiTIMpAFg+jRX/5+lZg5dDFT/xLh
         fptOD0p9lDhRtqjQC/AU1Mz6C/o7KHjl5+kJvYsD3kseM5Q9uBDi0hh5D3KTHdETv85D
         nzCg==
X-Gm-Message-State: AOAM532SrHLahFWbAEx/PeWgngUZGGCOOO5JFcq+kXQjGxjJdV3W16O3
        PU9XpubBQfVg5h5e2x3jMRGTMVDs+AOnvqpDDeU=
X-Google-Smtp-Source: ABdhPJzAQJiDrgeJy7rhfX0pAkio1uuxAwG3849yDdBeiLJsJGxodT7NQRbXZ/oKCcFCwEsCtRUE249ryL/Lt2qOMyI=
X-Received: by 2002:a05:6638:631:: with SMTP id h17mr2552012jar.137.1590163200792;
 Fri, 22 May 2020 09:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <1589800165-3271-1-git-send-email-dillon.minfei@gmail.com>
 <1589800165-3271-4-git-send-email-dillon.minfei@gmail.com>
 <20200522113634.GE5801@sirena.org.uk> <CAL9mu0LAnT+AfjpGs0O-MD2HYrpnQRmrj6qXtJQrJi9kbQLPUw@mail.gmail.com>
In-Reply-To: <CAL9mu0LAnT+AfjpGs0O-MD2HYrpnQRmrj6qXtJQrJi9kbQLPUw@mail.gmail.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Fri, 22 May 2020 23:59:25 +0800
Message-ID: <CAL9mu0JZ4Qy+m2oF9TSTRqA_mM0J89huCt3t_Gs7qHa=3LxhBw@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] spi: stm32: Add 'SPI_SIMPLEX_RX', 'SPI_3WIRE_RX'
 support for stm32f4
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, p.zabel@pengutronix.de,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        thierry.reding@gmail.com, Sam Ravnborg <sam@ravnborg.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 22, 2020 at 10:57 PM dillon min <dillon.minfei@gmail.com> wrote:
>
> hi Mark,
>
> Thanks for reviewing.
>
> On Fri, May 22, 2020 at 7:36 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Mon, May 18, 2020 at 07:09:20PM +0800, dillon.minfei@gmail.com wrote:
> >
> > > 2, use stm32 spi's "In full-duplex (BIDIMODE=0 and RXONLY=0)", as tx_buf is
> > > null, we must add dummy data sent out before read data.
> > > so, add stm32f4_spi_tx_dummy() to handle this situation.
> >
> > There are flags SPI_CONTROLLER_MUST_TX and SPI_CONTROLLER_MUST_RX flags
> > that the driver can set if it needs to, no need to open code this in the
> > driver.
>
> Yes, after check SPI_CONTROLLER_MUST_TX in drivers/spi/spi.c , it's
> indeed to meet
> this situation,  i will try it and sumbmit a new patch.
>
> thanks.
>
> best regards
>
> Dillon

Hi Mark,

There might be a conflict with 'SPI_CONTROLLER_MUST_TX' and 'SPI_3WIRE' mode,
i need to know the SPI_3WIRE direction,  currently i get this
information from 'struct spi_device'
and 'struct spi_transfer'
if ((spi_device->mode & SPI_3WIRE) && (spi_transfer->tx_buf == NULL)
&& (spi_transfer->rx_buf != NULL))
    this is a SPI_3WIRE_RX transfer
if ((spi_device->mode & SPI_3WIRE) && (spi_transfer->tx_buf != NULL)
&& (spi_transfer->rx_buf == NULL))
    this is a SPI_3WIRE_TX transfer

but, after spi-core create a dummy tx_buf or rx_buf, then i can't get
the correct spi_3wire direction.
actually, this dummy tx_buf is useless for SPI_3WIRE. it's has meaning
for SPI_SIMPLE_RX mode,
simulate SPI_FULL_DUMPLEX

how do you think?

thanks

best regards

Dillon
