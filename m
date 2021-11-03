Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFCF444A23
	for <lists+linux-spi@lfdr.de>; Wed,  3 Nov 2021 22:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhKCVUm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Nov 2021 17:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhKCVUl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Nov 2021 17:20:41 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF66C061714
        for <linux-spi@vger.kernel.org>; Wed,  3 Nov 2021 14:18:04 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id h23so4030048ila.4
        for <linux-spi@vger.kernel.org>; Wed, 03 Nov 2021 14:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vp7L6fWq5JOaVwWXrcgwmhvI35J5PWQSGZU7/nILXi8=;
        b=k0kOuwMyU27qhvZKgPW+bgT0b6uwzDdWQOIy223IiZN73FydP0W2fIJ8q4SMSBsWm9
         pouS3KJiGhVaIP8VIP5T7qK1li0/QxB1H3kISS1ARdusqa9UAWsCmGAO0Pna/iUqZ8p0
         ww6FnkUC1HKBndSvsg5CsjBwx3AWGBKMJMMgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vp7L6fWq5JOaVwWXrcgwmhvI35J5PWQSGZU7/nILXi8=;
        b=ZbcBVZ/KaNEk78iP64gjeWj0exbVLZm6AnxBkz2NrzQJ8aXAK2x2pHq55WlowRu74r
         Fn3x3Q4QfqKULCIFwShOrdmeL54kafTdM+1dE+g2ybl+uZgzBQkF1Vo9LcP18WXqCTgz
         68xJ3xiWj4yKj9ehgEaL+rOMVMs0pv8H15kfCCZhoZoWrwdpxZZkh6MhyAF7lV+uWkRN
         BBismNbn/kes9dTBz5D4A5EGiFM/ycDCzRMQwP09kWIcIq0OdPEPmqyO44tdAtfwuDyR
         d5aQxR6TWixv1YCI6FHprbPUc+W2+2a6uLn3U5bV8l8XNjQMlDxuHEL+xYWSBD882jVw
         xsqg==
X-Gm-Message-State: AOAM530BVzoiGx2A6J+JDvxLl90cE2PX16Mip2LB0U80XFzUXzhO79rT
        3GmctmCZ3niHZqLApxJhM/+eYyuecizFJg==
X-Google-Smtp-Source: ABdhPJyqL7umRWD0gyoXW6eyqqSOuqDwXILtKmlpfJ4mr3fFkqOF1FkTqFAOPuBx1yFTZNjiQCZSGw==
X-Received: by 2002:a92:cda5:: with SMTP id g5mr8768458ild.97.1635974283662;
        Wed, 03 Nov 2021 14:18:03 -0700 (PDT)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com. [209.85.166.169])
        by smtp.gmail.com with ESMTPSA id e5sm1843509ilu.17.2021.11.03.14.18.03
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 14:18:03 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id x9so4027042ilu.6
        for <linux-spi@vger.kernel.org>; Wed, 03 Nov 2021 14:18:03 -0700 (PDT)
X-Received: by 2002:a05:6e02:144e:: with SMTP id p14mr445657ilo.180.1635974282559;
 Wed, 03 Nov 2021 14:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211020060954.1531783-1-vkoul@kernel.org>
In-Reply-To: <20211020060954.1531783-1-vkoul@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 3 Nov 2021 14:17:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VDjqQsnGVOf0FPsk74xgP87iBnk3MznEi1TjTKHP0Ldw@mail.gmail.com>
Message-ID: <CAD=FV=VDjqQsnGVOf0FPsk74xgP87iBnk3MznEi1TjTKHP0Ldw@mail.gmail.com>
Subject: Re: [PATCH v5] spi: spi-geni-qcom: Add support for GPI dma
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Tue, Oct 19, 2021 at 11:10 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> We can use GPI DMA for devices where it is enabled by firmware. Add
> support for this mode
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> --
> -Changes since v4:
>  - Fix the kbuild bot warning
>
> -Changes since v3:
>  - Drop merged spi core, geni patches
>  - Remove global structs and use local variables instead
>  - modularize code more as suggested by Doug
>  - fix kbuild bot warning
>
>  drivers/spi/spi-geni-qcom.c | 254 +++++++++++++++++++++++++++++++++---
>  1 file changed, 239 insertions(+), 15 deletions(-)

This is already landed, but better review late than never? Maybe you
can do a followup patch?


> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 2f51421e2a71..27a446faf143 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -2,6 +2,9 @@
>  // Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
>
>  #include <linux/clk.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dma/qcom-gpi-dma.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/log2.h>
> @@ -63,6 +66,15 @@
>  #define TIMESTAMP_AFTER                BIT(3)
>  #define POST_CMD_DELAY         BIT(4)
>
> +#define GSI_LOOPBACK_EN                BIT(0)
> +#define GSI_CS_TOGGLE          BIT(3)
> +#define GSI_CPHA               BIT(4)
> +#define GSI_CPOL               BIT(5)
> +
> +#define MAX_TX_SG              3
> +#define NUM_SPI_XFER           8
> +#define SPI_XFER_TIMEOUT_MS    250

Above three #defines are not used anywhere.


> @@ -330,34 +345,197 @@ static int setup_fifo_params(struct spi_device *spi_slv,
>         return geni_spi_set_clock_and_bw(mas, spi_slv->max_speed_hz);
>  }
>
> +static void
> +spi_gsi_callback_result(void *cb, const struct dmaengine_result *result)
> +{
> +       struct spi_master *spi = cb;
> +
> +       if (result->result != DMA_TRANS_NOERROR) {
> +               dev_err(&spi->dev, "DMA txn failed: %d\n", result->result);
> +               return;
> +       }
> +
> +       if (!result->residue) {
> +               dev_dbg(&spi->dev, "DMA txn completed\n");
> +               spi_finalize_current_transfer(spi);
> +       } else {
> +               dev_err(&spi->dev, "DMA xfer has pending: %d\n", result->residue);

Wouldn't hurt to add a comment above saying that you're relying on the
SPI core to timeout to get the system back in a usage state.

nit that I'd also reorganize to make the two error cases to be more parallel:

if (result->result != DMA_TRANS_NOERROR) {
  dev_err(...);
  return;
}
if (result->residue) {
  dev_err(...);
  return;
}
spi_finalize_current_transfer(...);


> +static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas,
> +                         struct spi_device *spi_slv, struct spi_master *spi)
> +{
> +       unsigned long flags = DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
> +       struct dma_slave_config config = {};
> +       struct gpi_spi_config peripheral = {};
> +       struct dma_async_tx_descriptor *tx_desc, *rx_desc;
> +       int ret;
> +
> +       config.peripheral_config = &peripheral;
> +       config.peripheral_size = sizeof(peripheral);
> +       peripheral.set_config = true;
> +
> +       if (xfer->bits_per_word != mas->cur_bits_per_word ||
> +           xfer->speed_hz != mas->cur_speed_hz) {
> +               mas->cur_bits_per_word = xfer->bits_per_word;
> +               mas->cur_speed_hz = xfer->speed_hz;
> +       }

I'm pretty sure that "mas->cur_bits_per_word" isn't used in GSI mode
(except below, where you could just use the values "xfer"), so you
could get rid of this?

For "mas->cur_speed_hz" maybe you should be using this to avoid
unnecessary calls to get_spi_clk_cfg() for when the clock didn't
change?


> +
> +       if (xfer->tx_buf && xfer->rx_buf) {
> +               peripheral.cmd = SPI_DUPLEX;
> +       } else if (xfer->tx_buf) {
> +               peripheral.cmd = SPI_TX;
> +               peripheral.rx_len = 0;
> +       } else if (xfer->rx_buf) {
> +               peripheral.cmd = SPI_RX;
> +               if (!(mas->cur_bits_per_word % MIN_WORD_LEN)) {
> +                       peripheral.rx_len = ((xfer->len << 3) / mas->cur_bits_per_word);
> +               } else {
> +                       int bytes_per_word = (mas->cur_bits_per_word / BITS_PER_BYTE) + 1;
> +
> +                       peripheral.rx_len = (xfer->len / bytes_per_word);
> +               }
> +       }
> +
> +       peripheral.loopback_en = !!(spi_slv->mode & SPI_LOOP);
> +       peripheral.clock_pol_high = !!(spi_slv->mode & SPI_CPOL);
> +       peripheral.data_pol_high = !!(spi_slv->mode & SPI_CPHA);

The fact that the "!!" above is actually needed is a sign that the
"struct gpi_spi_config" definition should be fixed. It should declare
things as "bool", not "u8". Then you can get rid of the "!!" here.


> +       peripheral.cs = spi_slv->chip_select;
> +       peripheral.pack_en = true;
> +       peripheral.word_len = xfer->bits_per_word - MIN_WORD_LEN;
> +
> +       ret = get_spi_clk_cfg(mas->cur_speed_hz, mas,
> +                             &peripheral.clk_src, &peripheral.clk_div);
> +       if (ret) {
> +               dev_err(mas->dev, "Err in get_spi_clk_cfg() :%d\n", ret);
> +               return ret;
> +       }
> +
> +       if (!xfer->cs_change) {
> +               if (!list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers))
> +                       peripheral.fragmentation = FRAGMENTATION;
> +       }
> +
> +       if (peripheral.cmd & SPI_RX) {
> +               dmaengine_slave_config(mas->rx, &config);
> +               rx_desc = dmaengine_prep_slave_sg(mas->rx, xfer->rx_sg.sgl, xfer->rx_sg.nents,
> +                                                 DMA_DEV_TO_MEM, flags);
> +               if (!rx_desc) {
> +                       dev_err(mas->dev, "Err setting up rx desc\n");
> +                       return -EIO;
> +               }
> +       }
> +
> +       /*
> +        * Prepare the TX always, even for RX or tx_buf being null, we would
> +        * need TX to be prepared per GSI spec
> +        */
> +       dmaengine_slave_config(mas->tx, &config);
> +       tx_desc = dmaengine_prep_slave_sg(mas->tx, xfer->tx_sg.sgl, xfer->tx_sg.nents,
> +                                         DMA_MEM_TO_DEV, flags);
> +       if (!tx_desc) {
> +               dev_err(mas->dev, "Err setting up tx desc\n");
> +               return -EIO;
> +       }
> +
> +       tx_desc->callback_result = spi_gsi_callback_result;
> +       tx_desc->callback_param = spi;

I guess now when you get the TX callback then you assume that both the
TX and RX are done. Is that truly safe? Perhaps I'm being paranoid (or
maybe I just don't understand how things work), but I could sorta
imagine that the peripheral has finished transmitting all the data but
hasn't managed to DMA all the data that it received into main memory.
If we were only going to pick one callback to register for and we have
both TX and RX going, it seems like we should register for RX. Because
of the way SPI works it seems like it would be impossible for TX to
still be going if RX is fully done.


> +       if (peripheral.cmd & SPI_RX)
> +               dmaengine_submit(rx_desc);
> +       dmaengine_submit(tx_desc);
> +
> +       if (peripheral.cmd & SPI_RX)
> +               dma_async_issue_pending(mas->rx);
> +
> +       dma_async_issue_pending(mas->tx);
> +       return 1;

You're returning "1" here which lets the SPI core do all the timeout
handling, right? ...but that means you need to provide the SPI core
with a way to abort your transfer if it times out. This should be in
spi->handle_err(). Right now that points to handle_fifo_timeout(). I
think you need to add code to handle errors for GPI mode too.


> +static int spi_geni_grab_gpi_chan(struct spi_geni_master *mas)
> +{
> +       int ret;
> +
> +       mas->tx = dma_request_chan(mas->dev, "tx");
> +       ret = dev_err_probe(mas->dev, IS_ERR(mas->tx), "Failed to get tx DMA ch\n");

s/IS_ERR/ERR_PTR/

dev_err_probe takes an error code, not a boolean. The way you've coded
it all errors will be reported as "error 1". You'll also never trip
the "if" test below (I suppose a smarter compiler could even detect
this?) since "ret" will always be either 0 or 1 (and neither of those
is < 0)


> +       if (ret < 0)
> +               goto err_tx;
> +
> +       mas->rx = dma_request_chan(mas->dev, "rx");
> +       ret = dev_err_probe(mas->dev, IS_ERR(mas->rx), "Failed to get rx DMA ch\n");

s/IS_ERR/ERR_PTR/

dev_err_probe takes an error code, not a boolean. The way you've coded
it all errors will be reported as "error 1".


> +static void spi_geni_release_dma_chan(struct spi_geni_master *mas)
> +{
> +       if (mas->rx) {
> +               dma_release_channel(mas->rx);
> +               mas->rx = NULL;
> +       }
> +
> +       if (mas->tx) {
> +               dma_release_channel(mas->tx);
> +               mas->tx = NULL;
> +       }

nit: I would have skipped the setting to NULL. This is only used in
the probe error and in the removal case and there's just no reason to
NULL these out.


> @@ -380,15 +558,38 @@ static int spi_geni_init(struct spi_geni_master *mas)
>         else
>                 mas->oversampling = 1;
>
> -       geni_se_select_mode(se, GENI_SE_FIFO);
> +       fifo_disable = readl(se->base + GENI_IF_DISABLE_RO) & FIFO_IF_DISABLE;
> +       switch (fifo_disable) {
> +       case 1:
> +               ret = spi_geni_grab_gpi_chan(mas);
> +               if (!ret) { /* success case */
> +                       mas->cur_xfer_mode = GENI_GPI_DMA;
> +                       geni_se_select_mode(se, GENI_GPI_DMA);
> +                       dev_dbg(mas->dev, "Using GPI DMA mode for SPI\n");
> +                       break;
> +               }
> +               /*
> +                * in case of failure to get dma channel, we can still do the
> +                * FIFO mode, so fallthrough

Maybe mention that "FIFO_IF_DISABLE" is poorly named in the comments?


> +                */
> +               dev_warn(mas->dev, "FIFO mode disabled, but couldn't get DMA, fall back to FIFO mode\n");
> +               fallthrough;
> +
> +       case 0:
> +               mas->cur_xfer_mode = GENI_SE_FIFO;
> +               geni_se_select_mode(se, GENI_SE_FIFO);
> +               ret = 0;
> +               break;
> +       }
>
>         /* We always control CS manually */
>         spi_tx_cfg = readl(se->base + SE_SPI_TRANS_CFG);
>         spi_tx_cfg &= ~CS_TOGGLE;
>         writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);

Is the above "We always control CS manually" only for FIFO mode? It
must be, right? Move this to the FIFO section?


> @@ -732,9 +944,17 @@ static int spi_geni_probe(struct platform_device *pdev)
>         if (ret)
>                 goto spi_geni_probe_runtime_disable;
>
> +       /*
> +        * check the mode supported and set_cs for fifo mode only
> +        * for dma (gsi) mode, the gsi will set cs based on params passed in
> +        * TRE
> +        */
> +       if (mas->cur_xfer_mode == GENI_SE_FIFO)
> +               spi->set_cs = spi_geni_set_cs;

It occurs to me that the other thing that's broken about not being
able to set chip select manually is that you can't handle the chip
select polarity (SPI_CS_HIGH), right? Maybe in the GSI transfer code
you should be error checking that wasn't set?


-Doug
