Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C181DF3DC
	for <lists+linux-spi@lfdr.de>; Sat, 23 May 2020 03:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387475AbgEWBfo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 21:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387418AbgEWBfo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 May 2020 21:35:44 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0A1C061A0E;
        Fri, 22 May 2020 18:35:43 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id 18so12693579iln.9;
        Fri, 22 May 2020 18:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S1QSAzJLA557HDI9geZdFtza2j2ttaAmC0/pNbF94RQ=;
        b=A992b6KQ0XxvQBvr4hpSCBAiJVOy3bCMOJRZbTEgNVsjziHkOX1YLkNL2W7JgGf5kB
         6dkdnQIBW/+Lh4TZr5VZ9W9jlKsQLHFUNaXvbtKPXiXkE2z25chDOo+YqkADBuJdDhZ/
         tHUB4rgSKsyEN1xbge2cNw65A0heIWhKbJcDMDvUkNC/9rydOmAqGX3PUZ8I2z0U7Y/V
         5Cr+kLr+aMh+DQj7mplWOIOBhISwulzYr6G01tL+aSEMoNt7Tw1DQ0rbXyQBcNzZ99L6
         aTZi5JpRzKVrsOLiFDG26hTNg0/+eB2eYUciggM6rhuzsRwMg4KgAEsT2EqkXuw9fJM0
         UHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S1QSAzJLA557HDI9geZdFtza2j2ttaAmC0/pNbF94RQ=;
        b=DgAFAc830boakhrF3DPI/j3d+CCWdkDX14ukx/QlioTLAHr0BpeV8dr+orcc1Xa6eg
         /HcJWyFXIav2X0LeX/YETywX+obHaYm0BbTYLlVL+Nwh5CpnWEOcdcyeDwFUR6YRHZkO
         OW/wwORiBOU4/iWhwNPXa/yLtm9T55KS7FVjEqA4h2hQbcmOK+hOTZxjD6wTAuE1T7cK
         xZ9bjz+X8JEurVZW5B6PuQkfXwXPFnE+5AL8wv9UZYk/coJXss7CMBm4w08mVCyk5XN9
         3l8dQuF0Hu6gjMq5FcHOWMy+YPcnBFf+dif3Idt9aAXqUpDrEoW4nZAC09gfjUj8w3FA
         OZzw==
X-Gm-Message-State: AOAM532arBrW/DX65bckdXrLUsNI9smIclT5cLczOJNbHc5WvdkaWdx9
        rJZEphQE/BdineKCqmJYR2vtbH/izU5a1PpRWOZuzCte1dc=
X-Google-Smtp-Source: ABdhPJyFMcan15/IQgBUd7V654mVVCiDvmI/KPlV1LTFmOXrmNhn289+5jn0LkISjmGIfWZTCLlEXoFxdgoJGQtXdZU=
X-Received: by 2002:a92:dc85:: with SMTP id c5mr15557198iln.270.1590197742955;
 Fri, 22 May 2020 18:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <1589800165-3271-1-git-send-email-dillon.minfei@gmail.com>
 <1589800165-3271-4-git-send-email-dillon.minfei@gmail.com>
 <20200522113634.GE5801@sirena.org.uk> <CAL9mu0LAnT+AfjpGs0O-MD2HYrpnQRmrj6qXtJQrJi9kbQLPUw@mail.gmail.com>
 <CAL9mu0JZ4Qy+m2oF9TSTRqA_mM0J89huCt3t_Gs7qHa=3LxhBw@mail.gmail.com> <20200522162901.GP5801@sirena.org.uk>
In-Reply-To: <20200522162901.GP5801@sirena.org.uk>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Sat, 23 May 2020 09:35:06 +0800
Message-ID: <CAL9mu0+E5R0mDUW3f+aKpfE_457VimS-ow2z_xVOmCfCAMnKuA@mail.gmail.com>
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

On Sat, May 23, 2020 at 12:29 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, May 22, 2020 at 11:59:25PM +0800, dillon min wrote:
>
> > but, after spi-core create a dummy tx_buf or rx_buf, then i can't get
> > the correct spi_3wire direction.
> > actually, this dummy tx_buf is useless for SPI_3WIRE. it's has meaning
> > for SPI_SIMPLE_RX mode,
> > simulate SPI_FULL_DUMPLEX
>
> Oh, that's annoying.  I think the fix here is in the core, it should
> ignore MUST_TX and MUST_RX in 3WIRE mode since they clearly make no
> sense there.

How about add below changes to spi-core

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8994545..bfd465c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1022,7 +1022,8 @@ static int spi_map_msg(struct spi_controller
*ctlr, struct spi_message *msg)
        void *tmp;
        unsigned int max_tx, max_rx;

-       if (ctlr->flags & (SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX)) {
+       if ((ctlr->flags & (SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX)) &&
+               !(msg->spi->mode & SPI_3WIRE)) {
                max_tx = 0;
                max_rx = 0;

for my board, lcd panel ilitek ill9341 use 3wire mode, gyro l3gd20 use
simplex rx mode.
it's has benefits to l3gd20, no impact to ili9341.

if it's fine to spi-core, i will include it to my next submits.

thanks

best regards.

Dillon
