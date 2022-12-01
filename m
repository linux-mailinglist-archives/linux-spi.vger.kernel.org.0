Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556F063FABC
	for <lists+linux-spi@lfdr.de>; Thu,  1 Dec 2022 23:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiLAWl4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Dec 2022 17:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiLAWll (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Dec 2022 17:41:41 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD0DCBA69
        for <linux-spi@vger.kernel.org>; Thu,  1 Dec 2022 14:40:48 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id vp12so7646712ejc.8
        for <linux-spi@vger.kernel.org>; Thu, 01 Dec 2022 14:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QCBYYhoGVnPTz4nZHJRlsPZmuJN8IhHsIEClmRUBJpo=;
        b=jBcVX9Jl9yrC96NGyAJJme3N1v+AcQiGHgHXRNu8ZsSznlpuF+iEpmAg1j7gwBA8gm
         dWiaW3mkUvrBoTlgohQGGoX9JWZPsOalitI1/7b7NdOkDgkZicIDCD+rLoMWBdJzqp66
         JlfXDtT3QfqvSBpIg/TonYco3N03nPKIiO/Cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCBYYhoGVnPTz4nZHJRlsPZmuJN8IhHsIEClmRUBJpo=;
        b=NswEIxnjYeZmfsRjNkQny4mQkY40MoSP6Sd0R4VshTAtgQnSjHh1zbXx6L4/+rv5qi
         nLB1bVrS43cN4vs7Y1ZstP+tMbuaoIt1izGQCBHq+AtMAYK+wY/Bd41hXTasAv0YOn9T
         f05Mn0OaPNBAWAoZVv/EVOuSJ3s/H0yKNmXdUzyhNeZWhJoO82lGrgxLnULHZmZ4MqBZ
         3NqMhdobshawDLD4oGgrrjiTR+kz/pC4KJlQpHz6vKzhrqSlcYMM7tQdjieKSzPpEW+A
         Yd0pEst1kAx8FEkhFjwhtB1qr4VphdKDQdixYQaNVzRrcqXH0ItqzsTkIRG3RgKUT7iU
         rZmA==
X-Gm-Message-State: ANoB5pnhfF5NgmuN/d9VxXp0ikyJxe3IYPvRMc8OgPpaAdFeFSQBJSvY
        GtJ4wvJIhAF1Tk9j+nDMINU3LBcpEdGVkC9e
X-Google-Smtp-Source: AA0mqf4/SbHJiAx5Fapq26MuH5Mm6BVyjZicEsTbH7CUOgyYL4ot+PAcvaPvJPxE6kne3MVr0h9uqQ==
X-Received: by 2002:a17:906:a884:b0:7bd:15a6:27e8 with SMTP id ha4-20020a170906a88400b007bd15a627e8mr27224499ejb.78.1669934445083;
        Thu, 01 Dec 2022 14:40:45 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id du1-20020a17090772c100b00772061034dbsm2271582ejc.182.2022.12.01.14.40.44
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 14:40:44 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id h4-20020a1c2104000000b003d0760654d3so3757768wmh.4
        for <linux-spi@vger.kernel.org>; Thu, 01 Dec 2022 14:40:44 -0800 (PST)
X-Received: by 2002:a05:600c:3109:b0:3cf:5731:53db with SMTP id
 g9-20020a05600c310900b003cf573153dbmr54653459wmo.85.1669934443867; Thu, 01
 Dec 2022 14:40:43 -0800 (PST)
MIME-Version: 1.0
References: <1669713814-28876-1-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1669713814-28876-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 1 Dec 2022 14:40:32 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WW-YttMn2+_6MdKwVDQO2stHjiisSdX8vFoOFBMnsjRA@mail.gmail.com>
Message-ID: <CAD=FV=WW-YttMn2+_6MdKwVDQO2stHjiisSdX8vFoOFBMnsjRA@mail.gmail.com>
Subject: Re: [V3] spi: spi-geni-qcom: Add support for SE DMA mode
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com, vkoul@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Tue, Nov 29, 2022 at 1:23 AM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> @@ -95,6 +97,7 @@ struct spi_geni_master {
>         struct dma_chan *tx;
>         struct dma_chan *rx;
>         int cur_xfer_mode;
> +       u32 cur_m_cmd;

In v1, I said: "I don't think you need to store "cur_m_cmd" ..."
...you responded: Please note that cur_xfer can be NULL. Added further
to comments."

I don't see any comments about this.

In any case, I'm still unclear about why this is needed. I guess
you're looking at the code in handle_se_timeout(). I'll comment there.


> @@ -162,6 +169,45 @@ static void handle_fifo_timeout(struct spi_master *spi,
>                  */
>                 mas->abort_failed = true;
>         }
> +
> +unmap_if_dma:
> +       if (mas->cur_xfer_mode == GENI_SE_DMA) {
> +               if (mas->cur_m_cmd & SPI_TX_ONLY) {
> +                       spin_lock_irq(&mas->lock);
> +                       reinit_completion(&mas->tx_reset_done);
> +                       writel(1, se->base + SE_DMA_TX_FSM_RST);
> +                       spin_unlock_irq(&mas->lock);
> +                       time_left = wait_for_completion_timeout(&mas->tx_reset_done, HZ);
> +                       if (!time_left)
> +                               dev_err(mas->dev, "DMA TX RESET failed\n");
> +               }
> +               if (mas->cur_m_cmd & SPI_RX_ONLY) {
> +                       spin_lock_irq(&mas->lock);
> +                       reinit_completion(&mas->rx_reset_done);
> +                       writel(1, se->base + SE_DMA_RX_FSM_RST);
> +                       spin_unlock_irq(&mas->lock);
> +                       time_left = wait_for_completion_timeout(&mas->rx_reset_done, HZ);
> +                       if (!time_left)
> +                               dev_err(mas->dev, "DMA RX RESET failed\n");
> +               }
> +
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
> +                        * isr will set cur_xfer to NULL when done.
> +                        * Unnecessary error but cannot be helped.
> +                        * Only do reset, dma_unprep is already done by isr.
> +                        */
> +                       dev_err(mas->dev, "Cancel/Abort on completed SPI transfer\n");
> +               }

For the above block of code, if "xfer" is NULL then do we actually
need to issue the DMA TX Reset and the DMA RX Reset? As per your
comments, the only case "xfer" can be NULL is if the ISR was holding
the lock and handling the transfer completion at that time. If the ISR
handled the transfer completion then we're not actually in a bad
state, right? Thus, couldn't you do:

if (xfer) {
  if (xfer->tx_buf && xfer->tx_dma) {
    // Do the FSM reset
    // Unprepare the DMA
  }
  if (xfer->rx_buf && xfer->rx_dma) {
    // Do the FSM reset
    // Unprepare the DMA
  }
} else {
  dev_err(...);
}

That should be fine, right? ...and then we can get rid of the need for
"cur_m_cmd" as per my previous comment, right?

I'll also ask if we can downgrade the "dev_err" to a "dev_warn". I
usually reserve dev_err for things that are fatal. Here we think we'll
probably recover, right?


> @@ -778,11 +836,39 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
>          */
>         spin_lock_irq(&mas->lock);
>         geni_se_setup_m_cmd(se, m_cmd, FRAGMENTATION);
> -       if (m_cmd & SPI_TX_ONLY) {
> +
> +       if (mas->cur_xfer_mode == GENI_SE_DMA) {
> +               if (m_cmd & SPI_RX_ONLY) {
> +                       ret =  geni_se_rx_dma_prep(se, xfer->rx_buf,
> +                               xfer->len, &xfer->rx_dma);

In response to v1 I asked if it's really OK to use "xfer->rx_dma" for
your purposes since it's supposed to be managed by the SPI framework.

It still makes me nervous to use it, even though it seems to work.
Since we're using it in an undocumented way, I'd be nervous that the
SPI framework might change what it's doing and break us in the future.

We can only have one TX and one RX transfer at a time anyway. Why
don't we just have our own "rx_dma" and "tx_dma" in "struct
spi_geni_master". It's only 16 extra bytes of data and it would make
me feel less nervous.

It still would be nice to eventually use the SPI framework to manage
the mapping, but I agree that can be a future task.


> +                       if (ret) {
> +                               dev_err(mas->dev, "Failed to setup Rx dma %d\n", ret);
> +                               xfer->rx_dma = 0;
> +                               goto unlock_and_return;
> +                       }
> +               }
> +               if (m_cmd & SPI_TX_ONLY) {
> +                       ret =  geni_se_tx_dma_prep(se, (void *)xfer->tx_buf,
> +                               xfer->len, &xfer->tx_dma);

In v1 I asked about the above "void *" cast. You pointed out that it
was to cast away constness. So I agree that you can keep it here for
now, but could you also post a patch to change geni_se_tx_dma_prep()
to take a "const void *"? You'll need a cast in _that_ function to
remove the constness (since dma_map_single() is generic for both TX
and RX), but it seems like a better place for it. Then a later patch
could remove the cast here.


> +                       if (ret) {
> +                               dev_err(mas->dev, "Failed to setup Tx dma %d\n", ret);
> +                               xfer->tx_dma = 0;
> +                               if (m_cmd & SPI_RX_ONLY && xfer->rx_dma) {

Don't need "&& xfer->rx_dma". You _just_ mapped it above and if it had
failed it would have returned an error. you don't need to
double-check. You can trust that the framework knows what it's doing
and won't return NULL to you. If it did return NULL to you because of
a bug, it's not necessarily better to just silently skip unpreparing
anyway.


> @@ -823,39 +913,66 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
>
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

Question: did you try actually using the chip select with your new
GENI_SE_DMA? Does it work? I ask because I don't see anything that
completes the "cs_done" in the DMA case of the ISR and I don't see
anything in spi_geni_set_cs() that forces it to FIFO mode. Note: if
you're only testing on trogdor/herobrine boards, you'd have to change
them to not use a GPIO for chip select.


-Doug
