Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA9C62E99E
	for <lists+linux-spi@lfdr.de>; Fri, 18 Nov 2022 00:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbiKQXa1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Nov 2022 18:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbiKQXaW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Nov 2022 18:30:22 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74AE769FF
        for <linux-spi@vger.kernel.org>; Thu, 17 Nov 2022 15:30:18 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id n21so8967031ejb.9
        for <linux-spi@vger.kernel.org>; Thu, 17 Nov 2022 15:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=axMopHYkcP2eO76gc217cU40QRnhmQxYIb9bOz08c5U=;
        b=FridDl/rNXXSLfRVE2Ej/LIVg/hBFdbHxJ/TTXXWCxDO5wU2RaMOH+fdpfYdsoYZ4y
         0xXwp6bktgNr1OfxXo0EztLj3OYGmNFT2IzoP1eBWMcB6h7E56HDg3uxulyFvLmt9Vze
         fDyLFb/JRCVirnWEcTfYqjorqsaiDmu3Gafiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=axMopHYkcP2eO76gc217cU40QRnhmQxYIb9bOz08c5U=;
        b=2cxSiaJqJYD/4z+KJ2BuostVqGpjE0qOgCZ8dWZaeYH0XJ3OAQ81gRtstxypKvFLm6
         Rpfr6527vuDHDV10ZtbAE9mCyumak6QUKin4MyLZDVOAr1UIiAnEJFHOdKMLIedAT8xF
         hL13GwppC+DP7zY8bC5yltV42b8pGlxje4blE6+mzdYAJCn7VgUex1QvnrWMeYu7ANLc
         Hc7hOwaa/FspRh/NWnLxWcd3cD385OFBhlAdC/9ZKUaGC+ZiqY0rh/w8gdsKI5rUO6B9
         Sy9/h9IIxlmVLSumqNoKxJGcOmzPZwAgnISSP3hylpv6yf5L6V8AijNSNwO29jTUBpBi
         RFXw==
X-Gm-Message-State: ANoB5pm5BOF+HAk9g4Cba9IOP/bL4p/A7zB2ZBbqgEnH2mPIVEO3QLID
        Sxh1dELUtlYjQb1EIXjfSnHinx1xZEZQI6l+
X-Google-Smtp-Source: AA0mqf7RCkG/5trEqeGSPFoovYafAVqCidtQdb5XpgMJEp4kpfnJKFCO8iw0qMXh3ww89/2cPgkeOw==
X-Received: by 2002:a17:906:40d8:b0:78d:5966:b093 with SMTP id a24-20020a17090640d800b0078d5966b093mr4088313ejk.343.1668727816442;
        Thu, 17 Nov 2022 15:30:16 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id x20-20020a170906805400b007919ba4295esm931120ejw.216.2022.11.17.15.30.15
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 15:30:15 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id cl5so6421429wrb.9
        for <linux-spi@vger.kernel.org>; Thu, 17 Nov 2022 15:30:15 -0800 (PST)
X-Received: by 2002:adf:fb4c:0:b0:236:5270:735e with SMTP id
 c12-20020adffb4c000000b002365270735emr2687226wrs.659.1668727814791; Thu, 17
 Nov 2022 15:30:14 -0800 (PST)
MIME-Version: 1.0
References: <1668590135-7725-1-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1668590135-7725-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Nov 2022 15:30:03 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VQx3RSWwt5uBb3c2xdTPcBdZ1mkYkANOcFit0+sMv_tA@mail.gmail.com>
Message-ID: <CAD=FV=VQx3RSWwt5uBb3c2xdTPcBdZ1mkYkANOcFit0+sMv_tA@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add support for SE DMA mode
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com, vkoul@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Wed, Nov 16, 2022 at 1:15 AM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> @@ -95,6 +97,7 @@ struct spi_geni_master {
>         struct dma_chan *tx;
>         struct dma_chan *rx;
>         int cur_xfer_mode;
> +       u32 cur_m_cmd;

I don't think you need to store "cur_m_cmd". The only thing you do is
check for the SPI_TX_ONLY / SPI_RX_ONLY bits and instead you can just
check if cur_xfer->tx_buf / cur_xfer->rx_buf are NULL.


> @@ -129,23 +132,27 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
>         return ret;
>  }
>
> -static void handle_fifo_timeout(struct spi_master *spi,
> +static void handle_se_timeout(struct spi_master *spi,
>                                 struct spi_message *msg)
>  {
>         struct spi_geni_master *mas = spi_master_get_devdata(spi);
>         unsigned long time_left;
>         struct geni_se *se = &mas->se;
> +       const struct spi_transfer *xfer;
>
>         spin_lock_irq(&mas->lock);
>         reinit_completion(&mas->cancel_done);
> -       writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
> +       if (mas->cur_xfer_mode == GENI_SE_FIFO)
> +               writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
> +       if (mas->cur_xfer_mode == GENI_SE_DMA)
> +               xfer = mas->cur_xfer;

You could probably just get rid of the "if" test and always store
xfer. You'll only use it below if you're in GENI_SE_DMA but you might
as well save the "if" test...


> @@ -162,6 +169,44 @@ static void handle_fifo_timeout(struct spi_master *spi,
>                  */
>                 mas->abort_failed = true;
>         }
> +
> +unmap_if_dma:
> +       if (mas->cur_xfer_mode == GENI_SE_DMA) {
> +               if (xfer) {
> +                       if (xfer->tx_buf && xfer->tx_dma)
> +                               geni_se_tx_dma_unprep(se, xfer->tx_dma, xfer->len);
> +                       if (xfer->rx_buf && xfer->rx_dma)
> +                               geni_se_rx_dma_unprep(se, xfer->rx_dma, xfer->len);
> +               } else {
> +                       /*
> +                        * This can happen if a timeout happened and we had to wait
> +                        * for lock in this function because isr was holding the lock
> +                        * and handling transfer completion at that time.
> +                        * Unnecessary error but cannot be helped.
> +                        * Only do reset, dma_unprep is already done by isr.
> +                        */
> +                       dev_err(mas->dev, "Cancel/Abort on completed SPI transfer\n");
> +               }
> +
> +               if (mas->cur_m_cmd & SPI_TX_ONLY) {
> +                       spin_lock_irq(&mas->lock);
> +                       reinit_completion(&mas->tx_reset_done);
> +                       writel_relaxed(1, se->base + SE_DMA_TX_FSM_RST);

Why "relaxed"? In general the "relaxed" variants should only be used
in cases where we are reasonably certain we're in a critical path and
the regular writel() should be the default.


> +                       spin_unlock_irq(&mas->lock);
> +                       time_left = wait_for_completion_timeout(&mas->tx_reset_done, HZ);
> +                       if (!time_left)
> +                               dev_err(mas->dev, "DMA TX RESET failed\n");
> +               }
> +               if (mas->cur_m_cmd & SPI_RX_ONLY) {
> +                       spin_lock_irq(&mas->lock);
> +                       reinit_completion(&mas->rx_reset_done);
> +                       writel_relaxed(1, se->base + SE_DMA_RX_FSM_RST);

Why "relaxed"?


> +                       spin_unlock_irq(&mas->lock);
> +                       time_left = wait_for_completion_timeout(&mas->rx_reset_done, HZ);
> +                       if (!time_left)
> +                               dev_err(mas->dev, "DMA RX RESET failed\n");
> +               }

Comparing how the i2c driver does "se DMA", I notice that it does the
FSM reset _before_ calling geni_se_tx_dma_unprep() /
geni_se_rx_dma_unprep(). You do it in the opposite order. Are both
orders really OK?


> @@ -482,8 +528,11 @@ static bool geni_can_dma(struct spi_controller *ctlr,
>  {
>         struct spi_geni_master *mas = spi_master_get_devdata(slv->master);
>
> -       /* check if dma is supported */
> -       return mas->cur_xfer_mode != GENI_SE_FIFO;
> +       /*
> +        * return true if transfer needs to be mapped prior to
> +        * calling transfer_one which is the case only for GPI_DMA
> +        */
> +       return mas->cur_xfer_mode == GENI_GPI_DMA;

Comments should say _why_ we don't need the transfer to be mapped by
the SPI framework for SE_DMA? This is because geni_se_rx_dma_prep() /
geni_se_tx_dma_prep() does it for you?


> @@ -494,6 +543,7 @@ static int spi_geni_prepare_message(struct spi_master *spi,
>
>         switch (mas->cur_xfer_mode) {
>         case GENI_SE_FIFO:
> +       case GENI_SE_DMA:
>                 if (spi_geni_is_abort_still_pending(mas))
>                         return -EBUSY;
>                 ret = setup_fifo_params(spi_msg->spi, spi);
> @@ -604,8 +654,8 @@ static int spi_geni_init(struct spi_geni_master *mas)
>                 fallthrough;

Right above this line there's a warning that says: "FIFO mode
disabled, but couldn't get DMA, fall back to FIFO mode". It was never
clear to me if that truly worked. ...but now I wonder even more. If it
was OK to fall back to FIFO mode when GPI failed to init, is it also
OK to fall back to SE_DMA mode in that case?


>         case 0:
> -               mas->cur_xfer_mode = GENI_SE_FIFO;
> -               geni_se_select_mode(se, GENI_SE_FIFO);
> +               mas->cur_xfer_mode = GENI_SE_DMA;
> +               geni_se_select_mode(se, GENI_SE_DMA);

Do we even need the above two lines? Don't we change the mode between
FIFO/DMA each time based on the transfer size?


> @@ -716,14 +766,14 @@ static void geni_spi_handle_rx(struct spi_geni_master *mas)
>         mas->rx_rem_bytes -= rx_bytes;
>  }
>
> -static void setup_fifo_xfer(struct spi_transfer *xfer,
> +static int setup_se_xfer(struct spi_transfer *xfer,
>                                 struct spi_geni_master *mas,
>                                 u16 mode, struct spi_master *spi)
>  {
>         u32 m_cmd = 0;
> -       u32 len;
> +       u32 len, fifo_size = 0;

You don't need to initialize "fifo_size".


>         struct geni_se *se = &mas->se;
> -       int ret;
> +       int ret = 0;

You don't need to initialize "ret".


> @@ -771,6 +821,13 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
>                 writel(len, se->base + SE_SPI_RX_TRANS_LEN);
>                 mas->rx_rem_bytes = xfer->len;
>         }
> +       mas->cur_m_cmd = m_cmd;
> +
> +       /* Select transfer mode based on transfer length */
> +       fifo_size =
> +               (mas->tx_fifo_depth * mas->fifo_width_bits / mas->cur_bits_per_word);

Parentheses here are unnecessary.


> @@ -778,11 +835,36 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
>          */
>         spin_lock_irq(&mas->lock);
>         geni_se_setup_m_cmd(se, m_cmd, FRAGMENTATION);
> -       if (m_cmd & SPI_TX_ONLY) {
> +
> +       if (mas->cur_xfer_mode == GENI_SE_DMA) {
> +               if (m_cmd & SPI_RX_ONLY) {
> +                       ret =  geni_se_rx_dma_prep(se, xfer->rx_buf,
> +                               xfer->len, &xfer->rx_dma);

Is it truly legitimate to use "xfer->rx_dma" for your own purposes?
That's supposed to be something populated by the SPI framework if
can_dma() returns true and I'd be a bit nervous about using it. Are we
sure we shouldn't use the SPI framework to handle our mapping?


> +                       if (ret || !xfer->rx_buf) {

Remove the useless test for "xfer->rx_buf". The only way the
SPI_RX_ONLY bit could be set is if rx_buf was non-NULL and that test
was only a few lines earlier.


> +                               dev_err(mas->dev, "Failed to setup Rx dma %d\n", ret);
> +                               xfer->rx_dma = 0;
> +                               goto unlock_and_return;
> +                       }
> +               }
> +               if (m_cmd & SPI_TX_ONLY) {
> +                       ret =  geni_se_tx_dma_prep(se, (void *)xfer->tx_buf,

Why the extra cast to "void *". You don't need it and don't have it on
the rx side.


> +                               xfer->len, &xfer->tx_dma);
> +                       if (ret || !xfer->tx_buf) {

Remove the useless test for "xfer->tx_buf"


> +                               dev_err(mas->dev, "Failed to setup Tx dma %d\n", ret);
> +                               xfer->tx_dma = 0;
> +                               goto unlock_and_return;

Don't you need to undo geni_se_rx_dma_prep() if this is a full duplex
transfer? ...and I guess clear xfer->rx_dma? Is there anything we need
to do to undo the geni_se_setup_m_cmd() ?


> +                       }

Just out of curiosity, what exactly kicks off the transfer in the DMA
case. I guess it knows if it's a TX, RX, or duplex transfer and
magically kicks off when one or both of them are prepped?


> +               }
> +       } else if (m_cmd & SPI_TX_ONLY) {
>                 if (geni_spi_handle_tx(mas))
>                         writel(mas->tx_wm, se->base + SE_GENI_TX_WATERMARK_REG);
>         }
> +
> +unlock_and_return:
>         spin_unlock_irq(&mas->lock);
> +       if (!ret)
> +               ret = 1;

Move this extra "if (!ret) ret = 1;" to spi_geni_transfer_one() and
add a comment explaining it (it's part of the API that the SPI
framework expects if you're letting it wait for the transfer to
complete or call the timeout function).


> @@ -816,46 +899,73 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
>         if (!m_irq)
>                 return IRQ_NONE;
>
> -       if (m_irq & (M_CMD_OVERRUN_EN | M_ILLEGAL_CMD_EN | M_CMD_FAILURE_EN |
> -                    M_RX_FIFO_RD_ERR_EN | M_RX_FIFO_WR_ERR_EN |
> -                    M_TX_FIFO_RD_ERR_EN | M_TX_FIFO_WR_ERR_EN))
> -               dev_warn(mas->dev, "Unexpected IRQ err status %#010x\n", m_irq);
> -

Could still leave the above check/warning even for SE_DMA mode, can't
you? Then you can keep it outside the spinlock. Is there some reason
that those errors are more impossible for SE_DMA than they are for
FIFO?


>         spin_lock(&mas->lock);
>
> -       if ((m_irq & M_RX_FIFO_WATERMARK_EN) || (m_irq & M_RX_FIFO_LAST_EN))
> -               geni_spi_handle_rx(mas);
> -
> -       if (m_irq & M_TX_FIFO_WATERMARK_EN)
> -               geni_spi_handle_tx(mas);
> -
> -       if (m_irq & M_CMD_DONE_EN) {
> -               if (mas->cur_xfer) {
> +       if (mas->cur_xfer_mode == GENI_SE_FIFO) {
> +               if (m_irq & (M_CMD_OVERRUN_EN | M_ILLEGAL_CMD_EN | M_CMD_FAILURE_EN |
> +                                M_RX_FIFO_RD_ERR_EN | M_RX_FIFO_WR_ERR_EN |
> +                                M_TX_FIFO_RD_ERR_EN | M_TX_FIFO_WR_ERR_EN))
> +                       dev_warn(mas->dev, "Unexpected IRQ err status %#010x\n", m_irq);
> +
> +               if ((m_irq & M_RX_FIFO_WATERMARK_EN) || (m_irq & M_RX_FIFO_LAST_EN))
> +                       geni_spi_handle_rx(mas);
> +
> +               if (m_irq & M_TX_FIFO_WATERMARK_EN)
> +                       geni_spi_handle_tx(mas);
> +
> +               if (m_irq & M_CMD_DONE_EN) {
> +                       if (mas->cur_xfer) {
> +                               spi_finalize_current_transfer(spi);
> +                               mas->cur_xfer = NULL;
> +                               /*
> +                                * If this happens, then a CMD_DONE came before all the
> +                                * Tx buffer bytes were sent out. This is unusual, log
> +                                * this condition and disable the WM interrupt to
> +                                * prevent the system from stalling due an interrupt
> +                                * storm.
> +                                *
> +                                * If this happens when all Rx bytes haven't been
> +                                * received, log the condition. The only known time
> +                                * this can happen is if bits_per_word != 8 and some
> +                                * registers that expect xfer lengths in num spi_words
> +                                * weren't written correctly.
> +                                */
> +                               if (mas->tx_rem_bytes) {
> +                                       writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
> +                                       dev_err(mas->dev, "Premature done. tx_rem = %d bpw%d\n",
> +                                               mas->tx_rem_bytes, mas->cur_bits_per_word);
> +                               }
> +                               if (mas->rx_rem_bytes)
> +                                       dev_err(mas->dev, "Premature done. rx_rem = %d bpw%d\n",
> +                                               mas->rx_rem_bytes, mas->cur_bits_per_word);
> +                       } else {
> +                               complete(&mas->cs_done);
> +                       }
> +               }
> +       } else if (mas->cur_xfer_mode == GENI_SE_DMA) {
> +               const struct spi_transfer *xfer = mas->cur_xfer;
> +               u32 dma_tx_status = readl_relaxed(se->base + SE_DMA_TX_IRQ_STAT);
> +               u32 dma_rx_status = readl_relaxed(se->base + SE_DMA_RX_IRQ_STAT);

The above makes me nervous that a full duplex transfer could finish
right between the two register reads and something would be handled
incorrectly. ...but it actually looks OK. In that case we'll just get
another interrupt right after this one and finish everything. OK, no
action needed just documenting my thoughts.

-Doug
