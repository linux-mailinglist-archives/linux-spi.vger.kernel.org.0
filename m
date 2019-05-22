Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A021525F76
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2019 10:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfEVI1h (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 May 2019 04:27:37 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40802 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbfEVI1h (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 May 2019 04:27:37 -0400
Received: by mail-lf1-f66.google.com with SMTP id h13so1005564lfc.7
        for <linux-spi@vger.kernel.org>; Wed, 22 May 2019 01:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=svB5nl3fT0U7Ej+HdK0cpAaD6HsRDyQv724K7n/Iu1I=;
        b=XPEPKyJ/KUpL4GASg/fc1AhnAc89hB55UzTCv9GAfj0URH6kzxw1eUYfGBG11VQ5At
         2dDshoZQA6fnD+mZpwP70GzbAms/pdzL36VN2lPl90cEPt8W393ZARceZbc1TIs6QvFw
         +ILMXpZtnTQWokmfGyiVSDuidVlODHO+sMZIsEi5cBwQlHYkmIrzaILUEi8i0m4Zs1EN
         9w4YokIDB6SDoq7kLJckccU33keqVAJqW93QXNpPpdhAn5euH+BGv9+2+7TTL5zDz66L
         p/ZVtJ0CFkuL84QdMI6GKd127tuSHPMHF1jhuyMpV362gjXoTeV3ykTx/2+MhqpLpQg1
         5YYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=svB5nl3fT0U7Ej+HdK0cpAaD6HsRDyQv724K7n/Iu1I=;
        b=FlmzBZ3274s8SwKuVmBAMBhcTGzqu7/QDPbjU7zKz9CKBPIBHAhtTntI4y37XDhAH6
         pOPoxdIBVQi/XTM6h0rjUAPaDpOwZdDdZA454rxrN6Sc6PETURUHVGaD/XX/5HArrO7/
         6s5A1uxlpZhLzwpL6kWje4yWNq+4JDad8U0z2Bhfxt1agmPQWjtNcUof6esjGBoAeebX
         NX2pljQuxVRoDz5sdovsjlZJ6wOynhXtHtXX4kJpC1xfZvzLjg9PcVvr/5JMdhhdfvpr
         CiMOSORTmFDQgfrzG3508u0zFxGnjDZphxbqfOx+XcvjHHGQNdJySdKFvegm3OXOUl5S
         g44g==
X-Gm-Message-State: APjAAAXRiDtud6L8SsCGjln1ek+6dlKIxJJK6MheKBzAIRso05Ii+/Zy
        QjSJoWn62F1tNZpSpNlSKNk1iRIBBRCnua75V5XRRw==
X-Google-Smtp-Source: APXvYqxCkbgEFxI6SZaBp54bJgBFxf7xmKlK2jv+sAoeqTCvs9thEtMgg1qBHJrg2aSXpeqTY1a8wnY5n7yq2u03Dps=
X-Received: by 2002:ac2:4c93:: with SMTP id d19mr24078559lfl.116.1558513654796;
 Wed, 22 May 2019 01:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190521115958.22504-1-masahisa.kojima@linaro.org>
 <20190521115958.22504-4-masahisa.kojima@linaro.org> <20190521181609.GB16633@sirena.org.uk>
In-Reply-To: <20190521181609.GB16633@sirena.org.uk>
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
Date:   Wed, 22 May 2019 17:27:23 +0900
Message-ID: <CADQ0-X9yKQ2akerpxKfjxOxmRhPiaaxe7ALDO7VQiH+-+SHo3w@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] spi: Add spi driver for Socionext Synquacer platform
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        geert@linux-m68k.org, tpiepho@impinj.com,
        andy.shevchenko@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Satoru Okamoto <okamoto.satoru@socionext.com>,
        Yoshitoyo Osaki <osaki.yoshitoyo@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Thank you very much for your comments.

On Wed, 22 May 2019 at 03:16, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, May 21, 2019 at 08:59:58PM +0900, Masahisa Kojima wrote:
>
> > +     switch (sspi->bpw) {
> > +     case 8:
>
> > +             {
> > +             u8 *buf = sspi->rx_buf;
> > +
> > +             readsb(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO, buf, len);
> > +             sspi->rx_buf = buf + len;
> > +             break;
> > +             }
>
> Please indent these properly.
>
> > +     default:
> > +             {
> > +             u32 *buf = sspi->rx_buf;
> > +
> > +             readsl(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO, buf, len);
> > +             sspi->rx_buf = buf + len;
> > +             break;
> > +             }
>
> It'd be better to explicitly list the values this works for and return
> an error otherwise.
>
> > +     if (sspi->rx_words) {
> > +             val = SYNQUACER_HSSPI_RXE_FIFO_MORE_THAN_THRESHOLD |
> > +                   SYNQUACER_HSSPI_RXE_SLAVE_RELEASED;
> > +             writel_relaxed(val, sspi->regs + SYNQUACER_HSSPI_REG_RXE);
> > +             status = wait_for_completion_timeout(&sspi->transfer_done,
> > +                     msecs_to_jiffies(SYNQUACER_HSSPI_TRANSFER_TMOUT_MSEC));
> > +             writel_relaxed(0, sspi->regs + SYNQUACER_HSSPI_REG_RXE);
> > +     }
> > +
> > +     if (xfer->tx_buf) {
> > +             val = SYNQUACER_HSSPI_TXE_FIFO_EMPTY;
> > +             writel_relaxed(val, sspi->regs + SYNQUACER_HSSPI_REG_TXE);
> > +             status = wait_for_completion_timeout(&sspi->transfer_done,
> > +                     msecs_to_jiffies(SYNQUACER_HSSPI_TRANSFER_TMOUT_MSEC));
> > +             writel_relaxed(0, sspi->regs + SYNQUACER_HSSPI_REG_TXE);
> > +     }
>
> I guess the TX will complete before the RX usually so I'd kind of expect
> the waits to be in the other order?
>
> > +     if (status < 0) {
> > +             dev_err(sspi->dev, "failed to transfer\n");
> > +             return status;
> > +     }
>
> Printing the error code could be helpful for users.
>
> > +static void synquacer_spi_set_cs(struct spi_device *spi, bool enable)
> > +{
> > +     struct synquacer_spi *sspi = spi_master_get_devdata(spi->master);
> > +     u32 val;
> > +
> > +     val = readl_relaxed(sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
> > +     val &= ~(SYNQUACER_HSSPI_DMPSEL_CS_MASK <<
> > +              SYNQUACER_HSSPI_DMPSEL_CS_SHIFT);
> > +     val |= spi->chip_select << SYNQUACER_HSSPI_DMPSEL_CS_SHIFT;
> > +
> > +     if (enable) {
> > +             val |= SYNQUACER_HSSPI_DMSTOP_STOP;
> > +             writel_relaxed(val, sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
> > +
> > +             if (sspi->rx_buf) {
> > +                     u32 buf[SYNQUACER_HSSPI_FIFO_DEPTH];
> > +
> > +                     sspi->rx_buf = buf;
> > +                     sspi->rx_words = SYNQUACER_HSSPI_FIFO_DEPTH;
> > +                     read_fifo(sspi);
> > +             }
>
> This is doing things with the FIFO, that's completely inappropriate for
> a set_cs() operation.  The set_cs() operation should set the chip select
> and nothing else.
>
> > +static irqreturn_t sq_spi_rx_handler(int irq, void *priv)
> > +{
> > +     uint32_t val;
> > +     struct synquacer_spi *sspi = priv;
> > +
> > +     val = readl_relaxed(sspi->regs + SYNQUACER_HSSPI_REG_RXF);
> > +     if ((val & SYNQUACER_HSSPI_RXF_SLAVE_RELEASED) ||
> > +         (val & SYNQUACER_HSSPI_RXF_FIFO_MORE_THAN_THRESHOLD))
> > +             read_fifo(sspi);
> > +
> > +     if (sspi->rx_words == 0) {
> > +             writel_relaxed(0, sspi->regs + SYNQUACER_HSSPI_REG_RXE);
> > +             complete(&sspi->transfer_done);
> > +     }
> > +
> > +     return 0;
> > +}
>
> 0 is not a valid return from an interrupt handler, IRQ_HANDLED or
> IRQ_NONE.
>
> > +     ret = devm_request_irq(&pdev->dev, rx_irq, sq_spi_rx_handler,
> > +                             0, "synquacer-spi-rx", sspi);
> > +     ret = devm_request_irq(&pdev->dev, tx_irq, sq_spi_tx_handler,
> > +                             0, "synquacer-spi-tx", sspi);
>
> The code looked awfully like we depend on having interrupts?

I"m not sure I correctly understand what this comment means,
should driver assume the case interrupt is not available?
Do I need to support both interrupt and polling handling?

> > +     master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_DUAL | SPI_RX_DUAL |
> > +                         SPI_TX_QUAD | SPI_RX_QUAD;
>
> I don't see any code in the driver that configures dual or quad mode
> support other than setting _PCC_SAFESYNC, I'm not clear how the driver
> supports these modes?

Configuring single, dual and quad mode is depending on
the spi_transfer member from upper driver.

+static int synquacer_spi_config(struct spi_master *master,

 <snip>

+       if (xfer->tx_buf) {
+               bus_width = xfer->tx_nbits;
+               transfer_mode = SYNQUACER_HSSPI_TRANSFER_MODE_TX;
+       } else {
+               bus_width = xfer->rx_nbits;
+               transfer_mode = SYNQUACER_HSSPI_TRANSFER_MODE_RX;
+       }

 <snip>

+       val &= ~(3 << SYNQUACER_HSSPI_DMTRP_BUS_WIDTH_SHIFT);
+       val |= ((bus_width >> 1) << SYNQUACER_HSSPI_DMTRP_BUS_WIDTH_SHIFT);
+       writel_relaxed(val, sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
