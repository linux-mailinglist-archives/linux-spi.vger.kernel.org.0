Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAFF184CA0
	for <lists+linux-spi@lfdr.de>; Fri, 13 Mar 2020 17:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgCMQhy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Mar 2020 12:37:54 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41818 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgCMQhx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Mar 2020 12:37:53 -0400
Received: by mail-ed1-f65.google.com with SMTP id m25so12609225edq.8;
        Fri, 13 Mar 2020 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ug47PEEkURrWYS4cuqEj7hzz31EJ8yvl86Hv/BuIrmY=;
        b=SjzmjBSEyZhk7pXH+/HhQn1zjaWSNLKMbo0GSmYcYFJi2HN12sUJhH2QePQmw/jZ2E
         ntrskaMhjBqsRBkuCSR3EEokFfATE99fs4Z1gxzMZ26H9yR0F2tXdTRQgxp7FB7RVaVU
         q6x9eCGAdPIka0gR1+hi0r6CShXGLINozhuiunPut2g7eUyh7aIzSsLeCm3GQAmugmP7
         gPryE+22DGyg/a15Kbm6YVuMetcO0mj6OQLg5copv5DdV+3BVzXmrMMGtOINrWzNyISj
         t5GxzY+oc2vBwI6ye93gdUkH3Mxon5VZuRlEpKUF3QNaG/hz6RrNI0F/wEaXTbCnBEmi
         KRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ug47PEEkURrWYS4cuqEj7hzz31EJ8yvl86Hv/BuIrmY=;
        b=VrO5HhxvJDGWFz+itiCKcGv8MrR8PnKwWt+YArky3MKaoiLVck7cX2TWGADXJ1UEoR
         lLmDBzom/7tee5nD1O0awknUPyIeNElsYNweKqpZ9e4BEoQ72BVzYhtX4ZUolQUZqiCz
         zwnW0094EYCKsvRIp6mtFD8Jis8xvbIhujxOCKN5Nsl9bDsGY+HDfymcvYXu1SK5K7ZN
         CqiqmmgVkobc5boQzfXRrtY2T5pnKix1OAswAmZ96H5UdcPyan1kjboFdVx9vlX+jCGE
         osBjJVX8zgpIwMK99rgSvBBnTqHABP8NHXVArR4CAK7oengBN/H+lO5KzIOwTvSQaz+U
         rBwg==
X-Gm-Message-State: ANhLgQ1Fml5Fd0X9weFGnHJuntzBFWsmLPz5SZ2/scjLW4qU2hAgBMxV
        8ZhnA2237ZJKxw5GHobTSpQgRFO/5rima06f1ws=
X-Google-Smtp-Source: ADFU+vvzuNqHEtlSJQWiF/MSD0uhQphIrFgqseKL1hLdMrG0M30AEFfgN/bOSm5pPk3vwaVXAqE1PaAxxCXRT5Q41jI=
X-Received: by 2002:a50:9b07:: with SMTP id o7mr14635673edi.139.1584117471141;
 Fri, 13 Mar 2020 09:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200310125542.5939-1-olteanv@gmail.com> <615284875b709f602d57e4a4621a83c1@walle.cc>
 <CA+h21hrYoHVDvsxT1EPWhYprL+zNHfE4MW7k4HxiK7ma4ZWn1g@mail.gmail.com>
 <59b07b7d70603c6b536a7354ed0ea8d8@walle.cc> <4ba077c80143c8ec679066e6d8cedca2@walle.cc>
In-Reply-To: <4ba077c80143c8ec679066e6d8cedca2@walle.cc>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Fri, 13 Mar 2020 18:37:39 +0200
Message-ID: <CA+h21hqk+pVrGgHx4iTshfE3i4WF7VANPfMf2ykPFpL3=ragag@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] NXP DSPI bugfixes and support for LS1028A
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

Hi Michael,

On Fri, 13 Mar 2020 at 18:07, Michael Walle <michael@walle.cc> wrote:
>
> Am 2020-03-10 16:22, schrieb Michael Walle:
> > Hi Vladimir,
> >
> > Am 2020-03-10 15:56, schrieb Vladimir Oltean:
> >>> (2) Also, reading the flash, every second time there is
> >>> (reproducibly)
> >>> an
> >>> IO error:
> >>>
> >>> # hexdump -C /dev/mtd0
> >>> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
> >>> |huhu............|
> >>> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> >>> |................|
> >>> *
> >>> 01000000
> >>> # hexdump -C /dev/mtd0
> >>> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
> >>> |huhu............|
> >>> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> >>> |................|
> >>> *
> >>> hexdump: /dev/mtd0: Input/output error
> >>> 00dc0000
> >>> # hexdump -C /dev/mtd0
> >>> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
> >>> |huhu............|
> >>> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> >>> |................|
> >>> *
> >>> 01000000
> >>> # hexdump -C /dev/mtd0
> >>> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
> >>> |huhu............|
> >>> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> >>> |................|
> >>> *
> >>> hexdump: /dev/mtd0: Input/output error
> >>> 00e6a000
> >>>
> >>
> >> Just to be clear, issue 2 is seen only after you abort another
> >> transaction, right?
> >
> > No, just normal uninterrupted reading. Just tried it right after
> > reboot. Doesn't seem to be every second time though, just random
> > which makes me wonder if that is another problem now. Also the
> > last successful reading is random.
>
>
> Ok I guess I know what the root cause is. This is an extract of
> the current code:
>
> > static int dspi_transfer_one_message(struct spi_controller *ctlr,
> >                                    struct spi_message *message)
> > {
> > ..
> >       /* Kick off the interrupt train */
> >       dspi_fifo_write(dspi);
> >
> >       status = wait_event_interruptible(dspi->waitq,
> >                                         dspi->waitflags);
> >       dspi->waitflags = 0;
> > ..
> > }
> >
> > static int dspi_rxtx(struct fsl_dspi *dspi)
> > {
> >       dspi_fifo_read(dspi);
> >
> >       if (!dspi->len)
> >               /* Success! */
> >               return 0;
> >
> >       dspi_fifo_write(dspi);
> >
> >       return -EINPROGRESS;
> > }
>
> dspi_rxtx() is used in the ISR. Both dspi_fifo_write() and dspi_rxtx()
> access shared data like, dspi->words_in_flight. In the EIO error case
> the following bytes_sent is -1, because dspi->words_in_flight is -1.
>
> > /* Update total number of bytes that were transferred */
> > bytes_sent = dspi->words_in_flight * dspi->oper_word_size;
>
> words_in_flight is always -1 after dspi_fifo_read() was called. In
> the error case, the ISR kicks in right in the middle of the execution
> of dspi_fifo_write() in dspi_transfer_one_message().
>
> > static void dspi_fifo_write(struct fsl_dspi *dspi)
> > {
> > ..
> >       if (dspi->devtype_data->trans_mode == DSPI_EOQ_MODE)
> >               dspi_eoq_fifo_write(dspi);
> >        else
> >               dspi_xspi_fifo_write(dspi);
>
> Now if the ISR is executed right here..
>
> >
> >       /* Update total number of bytes that were transferred */
> >       bytes_sent = dspi->words_in_flight * dspi->oper_word_size;
>
> .. words_in_flight might be -1.
>
> >       msg->actual_length += bytes_sent;
>
> and bytes_sent is negative. And this causes an IO error because
> the returned overall message length doesn't match.
>
> >       dspi->progress += bytes_sent / DIV_ROUND_UP(xfer->bits_per_word, 8);
> > ..
> > }
>
> I could not reproduce the issue with the following patch. I don't
> know if I got the locking correct though or if there is a better
> way to go.
>
>
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 8b16de9ed382..578fedeb16a0 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -224,6 +224,7 @@ struct fsl_dspi {
>          u16                                     tx_cmd;
>          const struct fsl_dspi_devtype_data      *devtype_data;
>
> +       spinlock_t lock;
>          wait_queue_head_t                       waitq;
>          u32                                     waitflags;
>
> @@ -873,14 +874,20 @@ static void dspi_fifo_write(struct fsl_dspi *dspi)
>
>   static int dspi_rxtx(struct fsl_dspi *dspi)
>   {
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&dspi->lock, flags);
>          dspi_fifo_read(dspi);
>
> -       if (!dspi->len)
> +       if (!dspi->len) {
>                  /* Success! */
> +               spin_unlock_irqrestore(&dspi->lock, flags);
>                  return 0;
> +       }
>
>          dspi_fifo_write(dspi);
>
> +       spin_unlock_irqrestore(&dspi->lock, flags);
>          return -EINPROGRESS;
>   }
>
> @@ -950,7 +957,9 @@ static int dspi_transfer_one_message(struct
> spi_controller *ctlr,
>          struct fsl_dspi *dspi = spi_controller_get_devdata(ctlr);
>          struct spi_device *spi = message->spi;
>          struct spi_transfer *transfer;
> +       unsigned long flags;
>          int status = 0;
> +       int i = 0;
>
>          if (dspi->irq)
>                  dspi_enable_interrupts(dspi, true);
> @@ -1009,7 +1018,9 @@ static int dspi_transfer_one_message(struct
> spi_controller *ctlr,
>                                  goto out;
>                  } else if (dspi->irq) {
>                          /* Kick off the interrupt train */
> +                       spin_lock_irqsave(&dspi->lock, flags);
>                          dspi_fifo_write(dspi);
> +                       spin_unlock_irqrestore(&dspi->lock, flags);
>
>                          status = wait_event_interruptible(dspi->waitq,
>
> dspi->waitflags);
> @@ -1301,6 +1312,7 @@ static int dspi_probe(struct platform_device
> *pdev)
>          ctlr->cleanup = dspi_cleanup;
>          ctlr->slave_abort = dspi_slave_abort;
>          ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
> +       spin_lock_init(&dspi->lock);
>
>          pdata = dev_get_platdata(&pdev->dev);
>          if (pdata) {
>
>
>
> -michael

Thanks for taking such a close look. I haven't had the time to follow up.
Indeed, the ISR, and therefore dspi_fifo_read, can execute before
dspi->words_in_flight was populated correctly. And bad things will
happen in that case.
But I wouldn't introduce a spin lock that disables interrupts on the
local CPU just for that - it's too complicated for this driver.
I would just keep the SPI interrupt quiesced via SPI_RSER and enable
it only once it's safe, aka after updating dspi->words_in_flight.

Thanks,
-Vladimir
