Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D69E45368B
	for <lists+linux-spi@lfdr.de>; Tue, 16 Nov 2021 16:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbhKPQBE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Nov 2021 11:01:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:59526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238680AbhKPQBA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Nov 2021 11:01:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E679B630EF;
        Tue, 16 Nov 2021 15:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637078283;
        bh=nw9ilccUSS9riuCqVRcgdImKNiblZBCSsmy9COmnFAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aSz4JtpgZrBAAGeYT+3yMDbM7TQrXs5tXBRJzyG1zk+LnSOWgY8IDK6bAtJHOMzsz
         3/3IoWAij1sX9kharzzq8JhopIkcMHUyjNncEYsiUadZf1+VaRBcIpqev5v9w/Ssjp
         zgqchH5bMQvN9TpbqrDqjgW/vFZxaDrZRpM4Pjpn7d7+0KCxS91QyqtJsIOfQZ5ork
         GbtvoeXHjiBO+mPcKiz5vefgXiD5Ifrt3f02rg27AqK8HpR8IepJdKzTOMNVAUBgI5
         KOa9Dzxh3VFFR1zWUO/o9VBx2ayc2P9Qf0PfSqpgNLFNBvubFBmsnV3uJIfP5Vi3t7
         xtYpQSom7wRUw==
Date:   Tue, 16 Nov 2021 21:27:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] spi: spi-geni-qcom: Add support for GPI dma
Message-ID: <YZPVB84Eq9Dn3Znv@matsya>
References: <20211020060954.1531783-1-vkoul@kernel.org>
 <CAD=FV=VDjqQsnGVOf0FPsk74xgP87iBnk3MznEi1TjTKHP0Ldw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=VDjqQsnGVOf0FPsk74xgP87iBnk3MznEi1TjTKHP0Ldw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 03-11-21, 14:17, Doug Anderson wrote:
> Hi,
> 
> On Tue, Oct 19, 2021 at 11:10 PM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > We can use GPI DMA for devices where it is enabled by firmware. Add
> > support for this mode
> >
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > --
> > -Changes since v4:
> >  - Fix the kbuild bot warning
> >
> > -Changes since v3:
> >  - Drop merged spi core, geni patches
> >  - Remove global structs and use local variables instead
> >  - modularize code more as suggested by Doug
> >  - fix kbuild bot warning
> >
> >  drivers/spi/spi-geni-qcom.c | 254 +++++++++++++++++++++++++++++++++---
> >  1 file changed, 239 insertions(+), 15 deletions(-)
> 
> This is already landed, but better review late than never? Maybe you
> can do a followup patch?

Thanks for the review, better late than never! I will follow up on this.

> > diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> > index 2f51421e2a71..27a446faf143 100644
> > --- a/drivers/spi/spi-geni-qcom.c
> > +++ b/drivers/spi/spi-geni-qcom.c
> > @@ -2,6 +2,9 @@
> >  // Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
> >
> >  #include <linux/clk.h>
> > +#include <linux/dmaengine.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/dma/qcom-gpi-dma.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  #include <linux/log2.h>
> > @@ -63,6 +66,15 @@
> >  #define TIMESTAMP_AFTER                BIT(3)
> >  #define POST_CMD_DELAY         BIT(4)
> >
> > +#define GSI_LOOPBACK_EN                BIT(0)
> > +#define GSI_CS_TOGGLE          BIT(3)
> > +#define GSI_CPHA               BIT(4)
> > +#define GSI_CPOL               BIT(5)
> > +
> > +#define MAX_TX_SG              3
> > +#define NUM_SPI_XFER           8
> > +#define SPI_XFER_TIMEOUT_MS    250
> 
> Above three #defines are not used anywhere.

Yes will remove

> > @@ -330,34 +345,197 @@ static int setup_fifo_params(struct spi_device *spi_slv,
> >         return geni_spi_set_clock_and_bw(mas, spi_slv->max_speed_hz);
> >  }
> >
> > +static void
> > +spi_gsi_callback_result(void *cb, const struct dmaengine_result *result)
> > +{
> > +       struct spi_master *spi = cb;
> > +
> > +       if (result->result != DMA_TRANS_NOERROR) {
> > +               dev_err(&spi->dev, "DMA txn failed: %d\n", result->result);
> > +               return;
> > +       }
> > +
> > +       if (!result->residue) {
> > +               dev_dbg(&spi->dev, "DMA txn completed\n");
> > +               spi_finalize_current_transfer(spi);
> > +       } else {
> > +               dev_err(&spi->dev, "DMA xfer has pending: %d\n", result->residue);
> 
> Wouldn't hurt to add a comment above saying that you're relying on the
> SPI core to timeout to get the system back in a usage state.
> 
> nit that I'd also reorganize to make the two error cases to be more parallel:
> 
> if (result->result != DMA_TRANS_NOERROR) {
>   dev_err(...);
>   return;
> }
> if (result->residue) {
>   dev_err(...);
>   return;
> }
> spi_finalize_current_transfer(...);

Should we always call spi_finalize_current_transfer() ? This way we
timeout... What is the way to signal error has occurred..?

> > +static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas,
> > +                         struct spi_device *spi_slv, struct spi_master *spi)
> > +{
> > +       unsigned long flags = DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
> > +       struct dma_slave_config config = {};
> > +       struct gpi_spi_config peripheral = {};
> > +       struct dma_async_tx_descriptor *tx_desc, *rx_desc;
> > +       int ret;
> > +
> > +       config.peripheral_config = &peripheral;
> > +       config.peripheral_size = sizeof(peripheral);
> > +       peripheral.set_config = true;
> > +
> > +       if (xfer->bits_per_word != mas->cur_bits_per_word ||
> > +           xfer->speed_hz != mas->cur_speed_hz) {
> > +               mas->cur_bits_per_word = xfer->bits_per_word;
> > +               mas->cur_speed_hz = xfer->speed_hz;
> > +       }
> 
> I'm pretty sure that "mas->cur_bits_per_word" isn't used in GSI mode
> (except below, where you could just use the values "xfer"), so you
> could get rid of this?

It is used below to get rx_len, i can try changing this
> 
> For "mas->cur_speed_hz" maybe you should be using this to avoid
> unnecessary calls to get_spi_clk_cfg() for when the clock didn't
> change?

Yeah we can do that

> > +
> > +       if (xfer->tx_buf && xfer->rx_buf) {
> > +               peripheral.cmd = SPI_DUPLEX;
> > +       } else if (xfer->tx_buf) {
> > +               peripheral.cmd = SPI_TX;
> > +               peripheral.rx_len = 0;
> > +       } else if (xfer->rx_buf) {
> > +               peripheral.cmd = SPI_RX;
> > +               if (!(mas->cur_bits_per_word % MIN_WORD_LEN)) {
> > +                       peripheral.rx_len = ((xfer->len << 3) / mas->cur_bits_per_word);
> > +               } else {
> > +                       int bytes_per_word = (mas->cur_bits_per_word / BITS_PER_BYTE) + 1;
> > +
> > +                       peripheral.rx_len = (xfer->len / bytes_per_word);
> > +               }
> > +       }
> > +
> > +       peripheral.loopback_en = !!(spi_slv->mode & SPI_LOOP);
> > +       peripheral.clock_pol_high = !!(spi_slv->mode & SPI_CPOL);
> > +       peripheral.data_pol_high = !!(spi_slv->mode & SPI_CPHA);
> 
> The fact that the "!!" above is actually needed is a sign that the
> "struct gpi_spi_config" definition should be fixed. It should declare
> things as "bool", not "u8". Then you can get rid of the "!!" here.

That is a good advice, yeah it should be a bool

> > +       peripheral.cs = spi_slv->chip_select;
> > +       peripheral.pack_en = true;
> > +       peripheral.word_len = xfer->bits_per_word - MIN_WORD_LEN;
> > +
> > +       ret = get_spi_clk_cfg(mas->cur_speed_hz, mas,
> > +                             &peripheral.clk_src, &peripheral.clk_div);
> > +       if (ret) {
> > +               dev_err(mas->dev, "Err in get_spi_clk_cfg() :%d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       if (!xfer->cs_change) {
> > +               if (!list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers))
> > +                       peripheral.fragmentation = FRAGMENTATION;
> > +       }
> > +
> > +       if (peripheral.cmd & SPI_RX) {
> > +               dmaengine_slave_config(mas->rx, &config);
> > +               rx_desc = dmaengine_prep_slave_sg(mas->rx, xfer->rx_sg.sgl, xfer->rx_sg.nents,
> > +                                                 DMA_DEV_TO_MEM, flags);
> > +               if (!rx_desc) {
> > +                       dev_err(mas->dev, "Err setting up rx desc\n");
> > +                       return -EIO;
> > +               }
> > +       }
> > +
> > +       /*
> > +        * Prepare the TX always, even for RX or tx_buf being null, we would
> > +        * need TX to be prepared per GSI spec
> > +        */
> > +       dmaengine_slave_config(mas->tx, &config);
> > +       tx_desc = dmaengine_prep_slave_sg(mas->tx, xfer->tx_sg.sgl, xfer->tx_sg.nents,
> > +                                         DMA_MEM_TO_DEV, flags);
> > +       if (!tx_desc) {
> > +               dev_err(mas->dev, "Err setting up tx desc\n");
> > +               return -EIO;
> > +       }
> > +
> > +       tx_desc->callback_result = spi_gsi_callback_result;
> > +       tx_desc->callback_param = spi;
> 
> I guess now when you get the TX callback then you assume that both the
> TX and RX are done. Is that truly safe? Perhaps I'm being paranoid (or
> maybe I just don't understand how things work), but I could sorta
> imagine that the peripheral has finished transmitting all the data but
> hasn't managed to DMA all the data that it received into main memory.
> If we were only going to pick one callback to register for and we have
> both TX and RX going, it seems like we should register for RX. Because
> of the way SPI works it seems like it would be impossible for TX to
> still be going if RX is fully done.

So, the way GSI works it we submit TX and RX always and we would get the
callback when the 'transfer' is completed, not when TX is done...

So it is perfectly fine to rely on one. Since we have TX always, it
makes sense to do this on TX

> 
> 
> > +       if (peripheral.cmd & SPI_RX)
> > +               dmaengine_submit(rx_desc);
> > +       dmaengine_submit(tx_desc);
> > +
> > +       if (peripheral.cmd & SPI_RX)
> > +               dma_async_issue_pending(mas->rx);
> > +
> > +       dma_async_issue_pending(mas->tx);
> > +       return 1;
> 
> You're returning "1" here which lets the SPI core do all the timeout
> handling, right? ...but that means you need to provide the SPI core
> with a way to abort your transfer if it times out. This should be in
> spi->handle_err(). Right now that points to handle_fifo_timeout(). I
> think you need to add code to handle errors for GPI mode too.

Missed that, we should handle that and do abort there

> > +static int spi_geni_grab_gpi_chan(struct spi_geni_master *mas)
> > +{
> > +       int ret;
> > +
> > +       mas->tx = dma_request_chan(mas->dev, "tx");
> > +       ret = dev_err_probe(mas->dev, IS_ERR(mas->tx), "Failed to get tx DMA ch\n");
> 
> s/IS_ERR/ERR_PTR/
> 
> dev_err_probe takes an error code, not a boolean. The way you've coded
> it all errors will be reported as "error 1". You'll also never trip
> the "if" test below (I suppose a smarter compiler could even detect
> this?) since "ret" will always be either 0 or 1 (and neither of those
> is < 0)
> 
> 
> > +       if (ret < 0)
> > +               goto err_tx;
> > +
> > +       mas->rx = dma_request_chan(mas->dev, "rx");
> > +       ret = dev_err_probe(mas->dev, IS_ERR(mas->rx), "Failed to get rx DMA ch\n");
> 
> s/IS_ERR/ERR_PTR/
> 
> dev_err_probe takes an error code, not a boolean. The way you've coded
> it all errors will be reported as "error 1".

Yeah I messed that, though a patch has been made and merged already

> > +static void spi_geni_release_dma_chan(struct spi_geni_master *mas)
> > +{
> > +       if (mas->rx) {
> > +               dma_release_channel(mas->rx);
> > +               mas->rx = NULL;
> > +       }
> > +
> > +       if (mas->tx) {
> > +               dma_release_channel(mas->tx);
> > +               mas->tx = NULL;
> > +       }
> 
> nit: I would have skipped the setting to NULL. This is only used in
> the probe error and in the removal case and there's just no reason to
> NULL these out.

True, but eventually we should release channels when not in use, so I
added this here for that eventuality...

> > @@ -380,15 +558,38 @@ static int spi_geni_init(struct spi_geni_master *mas)
> >         else
> >                 mas->oversampling = 1;
> >
> > -       geni_se_select_mode(se, GENI_SE_FIFO);
> > +       fifo_disable = readl(se->base + GENI_IF_DISABLE_RO) & FIFO_IF_DISABLE;
> > +       switch (fifo_disable) {
> > +       case 1:
> > +               ret = spi_geni_grab_gpi_chan(mas);
> > +               if (!ret) { /* success case */
> > +                       mas->cur_xfer_mode = GENI_GPI_DMA;
> > +                       geni_se_select_mode(se, GENI_GPI_DMA);
> > +                       dev_dbg(mas->dev, "Using GPI DMA mode for SPI\n");
> > +                       break;
> > +               }
> > +               /*
> > +                * in case of failure to get dma channel, we can still do the
> > +                * FIFO mode, so fallthrough
> 
> Maybe mention that "FIFO_IF_DISABLE" is poorly named in the comments?

ok

> 
> 
> > +                */
> > +               dev_warn(mas->dev, "FIFO mode disabled, but couldn't get DMA, fall back to FIFO mode\n");
> > +               fallthrough;
> > +
> > +       case 0:
> > +               mas->cur_xfer_mode = GENI_SE_FIFO;
> > +               geni_se_select_mode(se, GENI_SE_FIFO);
> > +               ret = 0;
> > +               break;
> > +       }
> >
> >         /* We always control CS manually */
> >         spi_tx_cfg = readl(se->base + SE_SPI_TRANS_CFG);
> >         spi_tx_cfg &= ~CS_TOGGLE;
> >         writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
> 
> Is the above "We always control CS manually" only for FIFO mode? It
> must be, right? Move this to the FIFO section?

yes it should be. CS is handled by gsi controller in GSI mode.

> 
> 
> > @@ -732,9 +944,17 @@ static int spi_geni_probe(struct platform_device *pdev)
> >         if (ret)
> >                 goto spi_geni_probe_runtime_disable;
> >
> > +       /*
> > +        * check the mode supported and set_cs for fifo mode only
> > +        * for dma (gsi) mode, the gsi will set cs based on params passed in
> > +        * TRE
> > +        */
> > +       if (mas->cur_xfer_mode == GENI_SE_FIFO)
> > +               spi->set_cs = spi_geni_set_cs;
> 
> It occurs to me that the other thing that's broken about not being
> able to set chip select manually is that you can't handle the chip
> select polarity (SPI_CS_HIGH), right? Maybe in the GSI transfer code
> you should be error checking that wasn't set?

I didnt find a way to pass polarity of CS thru flags in the Spec. Let me
ask QC about that. I can see we have toggle and delay there, but not
polarity..

-- 
~Vinod
