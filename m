Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E812017E783
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 19:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbgCISvX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 14:51:23 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34439 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbgCISvX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 14:51:23 -0400
Received: by mail-ed1-f66.google.com with SMTP id c21so13277849edt.1;
        Mon, 09 Mar 2020 11:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=clm3ma+lW+rgLiuhiXicUwTpVbExG2Z9wddCYQg0RBY=;
        b=Vpo8dbHLf0dmQTuU1Izi7Z6u49fsMS0yQVI1374A8t4XxDNlmVMDZYhUwW5xS5OsSB
         8KLBOE9JnnkURKRFwJHMqfOGlI3FEAUq95PWtNXM0m8W32pSqvOrjla7AAryTTkv6k4k
         teEJf/R7lHiXON9br1q47+XiEyr1WWGqCN7NmsQ5ou0vbZXxMFOAOFPg6q24jeoSzMIi
         Pp6610o1EOFE6YsoFC686/SnJVGCd06s6jvVOkbkuQU+kDV7jFid2eJD9SMo0x03TYjW
         nNoJb9JGukxUTiwicGIHBhS5KbBzVQCNc1Yy2p54w9xEkScRJjk0LVPyFPo82fCGTrIs
         PAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=clm3ma+lW+rgLiuhiXicUwTpVbExG2Z9wddCYQg0RBY=;
        b=dT7UC8EMAFUHmQViFXWNX8LQGBLQKZeP9ZfyuPRRGeUNn/82E2wrpVcCl3XPeU9TXo
         39roGdEMT/bKoiMfJ3yD+t6rZbAHf4KXRBrrHHI0maqxy2WtR2WYBbB2pUCTPYuzuBNw
         2jd+86EwiGMUAp3q8/cqX5ygXUgU5MWX6LFbaHxxTN8US7mGSvo2Qn7zPlJSoqXPrTfR
         VCa+jsYiLITKuoSeTqAJtydEaPIwQNNIU98CwiGGCg1ngc/bWY8PFeRFfhacZkzHuoNl
         oLpC0xaFZ8jjoyyAmPsNz/BJ0WSJP+xEmq2WKDBYTOdx9WiLqOrATrGo78X3Vlj1Mze1
         R1hg==
X-Gm-Message-State: ANhLgQ2zfJfISg9sCd+ZSQL7VY+L2QHJVNEJZU1UMTCzh/POLZJhkYWu
        OPRc95HXcgblWr1jS+2LGeQWKeHSFkKkXrPsQJI=
X-Google-Smtp-Source: ADFU+vuseX5BEjC97MIGq7PYnoQDZLuXCsj6A+R2Y/EAXARggxkZ+Xi6oBkK68P3pMQm94X2XgRZ0HRkKfEEO9QFY14=
X-Received: by 2002:a17:906:76c6:: with SMTP id q6mr15722099ejn.176.1583779879971;
 Mon, 09 Mar 2020 11:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200309145624.10026-1-olteanv@gmail.com> <20200309145624.10026-5-olteanv@gmail.com>
 <02a2816d2f39bf621dfee543ed612ae0@walle.cc>
In-Reply-To: <02a2816d2f39bf621dfee543ed612ae0@walle.cc>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Mon, 9 Mar 2020 20:51:09 +0200
Message-ID: <CA+h21hoqmXfBdhGBg6TLLqLeXJTE3wZKzQpsZJRsOhqWCO9gJQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] spi: spi-fsl-dspi: Add support for LS1028A
To:     Michael Walle <michael@walle.cc>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        angelo@sysam.it, andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>,
        peng.ma@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 9 Mar 2020 at 20:38, Michael Walle <michael@walle.cc> wrote:
>
> Am 2020-03-09 15:56, schrieb Vladimir Oltean:
> > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> >
> > This is similar to the DSPI instantiation on LS1028A, except that:
> >  - The A-011218 erratum has been fixed, so DMA works
> >  - The endianness is different, which has implications on XSPI mode
> >
> > Some benchmarking with the following command:
> >
> > spidev_test --device /dev/spidev2.0 --bpw 8 --size 256 --cpha --iter
> > 10000000 --speed 20000000
> >
> > shows that in DMA mode, it can achieve around 2400 kbps, and in XSPI
> > mode, the same command goes up to 4700 kbps. This is somewhat to be
> > expected, since the DMA buffer size is extremely small at 8 bytes, the
> > winner becomes whomever can prepare the buffers for transmission
> > quicker, and DMA mode has higher overhead there. So XSPI FIFO mode has
> > been chosen as the operating mode for this chip.
> >
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > ---
> >  drivers/spi/spi-fsl-dspi.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> > index 5624b9ee77db..264d184e7296 100644
> > --- a/drivers/spi/spi-fsl-dspi.c
> > +++ b/drivers/spi/spi-fsl-dspi.c
> > @@ -131,6 +131,7 @@ struct fsl_dspi_devtype_data {
> >  enum {
> >       LS1021A,
> >       LS1012A,
> > +     LS1028A,
> >       LS1043A,
> >       LS1046A,
> >       LS2080A,
> > @@ -163,6 +164,14 @@ static const struct fsl_dspi_devtype_data
> > devtype_data[] = {
> >               .pushr_cmd              = 0,
> >               .pushr_tx               = 2,
> >       },
> > +     [LS1028A] = {
> > +             .trans_mode             = DSPI_DMA_MODE,
>
> shouldn't this be DSPI_XSPI_MODE according to your cover letter?
>
> -michael
>

Yes, sorry, I forgot to change it back after testing it both ways.

> > +             .dma_bufsize            = 8,
> > +             .max_clock_factor       = 8,
> > +             .fifo_size              = 4,
> > +             .pushr_cmd              = 2,
> > +             .pushr_tx               = 0,
> > +     },
> >       [LS1043A] = {
> >               /* Has A-011218 DMA erratum */
> >               .trans_mode             = DSPI_XSPI_MODE,
> > @@ -1113,6 +1122,9 @@ static const struct of_device_id
> > fsl_dspi_dt_ids[] = {
> >       }, {
> >               .compatible = "fsl,ls1012a-dspi",
> >               .data = &devtype_data[LS1012A],
> > +     }, {
> > +             .compatible = "fsl,ls1028a-dspi",
> > +             .data = &devtype_data[LS1028A],
> >       }, {
> >               .compatible = "fsl,ls1043a-dspi",
> >               .data = &devtype_data[LS1043A],
