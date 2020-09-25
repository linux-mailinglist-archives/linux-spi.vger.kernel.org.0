Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865B32783E6
	for <lists+linux-spi@lfdr.de>; Fri, 25 Sep 2020 11:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgIYJZA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Sep 2020 05:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgIYJZA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Sep 2020 05:25:00 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD0BC0613CE
        for <linux-spi@vger.kernel.org>; Fri, 25 Sep 2020 02:25:00 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id q26so697785uaa.12
        for <linux-spi@vger.kernel.org>; Fri, 25 Sep 2020 02:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xwgHnfwJO4p3e2k/8UmICPhqPe1pJTwIO3qj/AAMTOs=;
        b=NCvFcGrJ4lAMHxPsuRNAM6CQqIi8DN2DhKWzJy934kPHwe8Q25N/LRBK3oE3ruxgdO
         jMCZ3ABixw8fJ8qWStplc3e7oLYbrPCm7yWKBM1VkbU5poVN6p97MMqg/MyPSLbb72Sj
         cZ6nhCwkAnlntTsedZEux/9pumM7CSlH2r0Sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwgHnfwJO4p3e2k/8UmICPhqPe1pJTwIO3qj/AAMTOs=;
        b=SnAzpeqvDNK51htQjgjveP806euOoZd0WaTCQCaiWJRoRes8t5zNbqA5yEYZ+S9Cu7
         4LNheG1AUxW+JDYm9ty28a0BHH4g9iC027UHiv8Vo3/EytTdXApRg5Tg2+gl4GBY3QEj
         95Qpv771bh2Br6MNYS3nUDPSlTtC/0TCRTFHj9myRBX294osCVuhGVY0rVn46uMS/UTX
         ERmPK0GtrKdzM7XNlK/XcJJuCik0FKllMixOxGiEMPgZxaPMRBWoH5ufqlemW/OstLrC
         WNPMWucN6uJ5pQil9/81NBw5wOltyWjavmPpFz+UFeuMzylOWQteGik9Eqs8q17tBPBn
         DseQ==
X-Gm-Message-State: AOAM533l+FoFIuMWc7cgiavvW5QGWNR2iBDpuHMc+N7QNH8DSRPMkC/r
        oC+t8Inn0hBwXf8JhaOIR+jh9ipCQ5fbL3dB+MdKFw==
X-Google-Smtp-Source: ABdhPJwEhNuZMKTBbzc2tvQBDUTaHYy/tzrpFK9uL/uoFKikWZI7pmKGmiwxngGtWyRur+oP/X/aWlhGFiVPkyjZpws=
X-Received: by 2002:ab0:2404:: with SMTP id f4mr1874548uan.108.1601025899341;
 Fri, 25 Sep 2020 02:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200925065418.1077472-1-ikjn@chromium.org> <20200925145255.v3.3.I7a3fc5678a81654574e8852d920db94bcc4d3eb8@changeid>
 <CAJsYDV+CEQ2PEOcdP1vadOBOHgW39XNNjPET04uWQktnPHZcFA@mail.gmail.com>
In-Reply-To: <CAJsYDV+CEQ2PEOcdP1vadOBOHgW39XNNjPET04uWQktnPHZcFA@mail.gmail.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Fri, 25 Sep 2020 17:24:48 +0800
Message-ID: <CAATdQgAZyi+T5YLsDooTjCJTGD6jvzXuKqUwpdNY=-Eqi1=_YQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] spi: spi-mtk-nor: support 7 bytes transfer of
 generic spi
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Sep 25, 2020 at 3:47 PM Chuanhong Guo <gch981213@gmail.com> wrote:
>
> Hi!
>
> On Fri, Sep 25, 2020 at 2:55 PM Ikjoon Jang <ikjn@chromium.org> wrote:
> >
> > When mtk-nor fallbacks to generic spi transfers, it can actually
> > transfer up to 7 bytes.
>
> generic transfer_one_message should support full-duplex transfers,
> not transfers with special format requirements. (e.g. here the last
> byte is rx only.) These transfers with format requirements should
> be implemented with spi-mem interface instead.

yep, that's correct.

>
> >
> > This patch fixes adjust_op_size() and supports_op() to explicitly
> > check 7 bytes range and also fixes possible under/overflow conditions
> > in register offsets calculation.
> >
> > Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
>
> I was notified by Bayi about your discussion and sent some
> patches yesterday for the same purpose. Whoops...
> As transfer_one_message isn't the proper place to implement
> this, maybe we could work on my version instead?
>

I didn't noticed that before,
Sure, please go ahead, I'll follow up with your patch in v4.

> > ---
> >
> > (no changes since v1)
>
> This should be "new patch" not "no changes" :P

oops, it seems my script did something wrong.

>
>
> >
> >  drivers/spi/spi-mtk-nor.c | 102 ++++++++++++++++++++++++++++----------
> >  1 file changed, 76 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
> > index 0f7d4ec68730..e7719d249095 100644
> > --- a/drivers/spi/spi-mtk-nor.c
> > +++ b/drivers/spi/spi-mtk-nor.c
> > @@ -79,7 +79,11 @@
> >  #define MTK_NOR_REG_DMA_DADR           0x720
> >  #define MTK_NOR_REG_DMA_END_DADR       0x724
> >
> > +/* maximum bytes of TX in PRG mode */
> >  #define MTK_NOR_PRG_MAX_SIZE           6
> > +/* maximum bytes of TX + RX is 7, last 1 byte is always being sent as zero */
> > +#define MTK_NOR_PRG_MAX_CYCLES         7
> > +
> >  // Reading DMA src/dst addresses have to be 16-byte aligned
> >  #define MTK_NOR_DMA_ALIGN              16
> >  #define MTK_NOR_DMA_ALIGN_MASK         (MTK_NOR_DMA_ALIGN - 1)
> > @@ -167,6 +171,24 @@ static bool mtk_nor_match_read(const struct spi_mem_op *op)
> >         return false;
> >  }
> >
> > +static bool mtk_nor_check_prg(const struct spi_mem_op *op)
> > +{
> > +       size_t len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
> > +
> > +       if (len > MTK_NOR_PRG_MAX_SIZE)
> > +               return false;
> > +
> > +       if (!op->data.nbytes)
> > +               return true;
> > +
> > +       if (op->data.dir == SPI_MEM_DATA_OUT)
> > +               return ((len + op->data.nbytes) <= MTK_NOR_PRG_MAX_SIZE);
> > +       else if (op->data.dir == SPI_MEM_DATA_IN)
> > +               return ((len + op->data.nbytes) <= MTK_NOR_PRG_MAX_CYCLES);
> > +       else
> > +               return true;
> > +}
> > +
> >  static int mtk_nor_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
> >  {
> >         size_t len;
> > @@ -195,10 +217,22 @@ static int mtk_nor_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
> >                 }
> >         }
> >
> > -       len = MTK_NOR_PRG_MAX_SIZE - op->cmd.nbytes - op->addr.nbytes -
> > -             op->dummy.nbytes;
> > -       if (op->data.nbytes > len)
> > -               op->data.nbytes = len;
> > +       if (mtk_nor_check_prg(op))
> > +               return 0;
> > +
> > +       len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
> > +
> > +       if (op->data.dir == SPI_MEM_DATA_OUT) {
> > +               if (len == MTK_NOR_PRG_MAX_SIZE)
> > +                       return -EINVAL;
> > +               op->data.nbytes = min_t(unsigned int, op->data.nbytes,
> > +                                       MTK_NOR_PRG_MAX_SIZE - len);
> > +       } else  {
> > +               if (len == MTK_NOR_PRG_MAX_CYCLES)
> > +                       return -EINVAL;
> > +               op->data.nbytes = min_t(unsigned int, op->data.nbytes,
> > +                                       MTK_NOR_PRG_MAX_CYCLES - len);
> > +       }
> >
> >         return 0;
> >  }
> > @@ -206,8 +240,6 @@ static int mtk_nor_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
> >  static bool mtk_nor_supports_op(struct spi_mem *mem,
> >                                 const struct spi_mem_op *op)
> >  {
> > -       size_t len;
> > -
> >         if (op->cmd.buswidth != 1)
> >                 return false;
> >
> > @@ -223,12 +255,11 @@ static bool mtk_nor_supports_op(struct spi_mem *mem,
> >                                (op->data.buswidth == 1);
> >         }
> >
> > -       len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
> > -       if ((len > MTK_NOR_PRG_MAX_SIZE) ||
> > -           ((op->data.nbytes) && (len == MTK_NOR_PRG_MAX_SIZE)))
> > +       /* fallback to generic spi xfer */
> > +       if (op->cmd.buswidth > 1 || op->addr.buswidth > 1 || op->data.buswidth > 1)
> >                 return false;
>
> Rejecting an op in supports_op doesn't tell it to fall back to generic
> spi transfer.
> It instead tells caller to abort this transfer completely.
> A fallback only happens when exec_op returns -ENOTSUPP.

yep but I think that case always going PRG mode in exec_op() with the
same condition?

> This comment is incorrect. I'd put this buswidth checking in mtk_nor_check_prg
> instead because mtk_nor_check_prg is checking whether an op is supported
> by prg mode, thus it should reject ops with buswidth > 1.
>
> >
> > -       return true;
> > +       return mtk_nor_check_prg(op);
> >  }
> >
> >  static void mtk_nor_setup_bus(struct mtk_nor *sp, const struct spi_mem_op *op)
> > @@ -459,22 +490,36 @@ static int mtk_nor_transfer_one_message(struct spi_controller *master,
> >         int stat = 0;
> >         int reg_offset = MTK_NOR_REG_PRGDATA_MAX;
> >         void __iomem *reg;
> > -       const u8 *txbuf;
> > -       u8 *rxbuf;
> > -       int i;
> > +       int i, tx_len = 0, rx_len = 0;
> >
> >         list_for_each_entry(t, &m->transfers, transfer_list) {
> > -               txbuf = t->tx_buf;
> > -               for (i = 0; i < t->len; i++, reg_offset--) {
> > +               const u8 *txbuf = t->tx_buf;
> > +
> > +               if (!txbuf) {
> > +                       rx_len += t->len;
> > +                       continue;
> > +               }
> > +
> > +               if (rx_len) {
> > +                       stat = -EPROTO;
> > +                       goto msg_done;
> > +               }
>
> NACK. you are unnecessarily rejecting possible transfers.

yep, ditto

>
> > +
> > +               for (i = 0; i < t->len && reg_offset >= 0; i++, reg_offset--) {
> >                         reg = sp->base + MTK_NOR_REG_PRGDATA(reg_offset);
> > -                       if (txbuf)
> > -                               writeb(txbuf[i], reg);
> > -                       else
> > -                               writeb(0, reg);
> > +                       writeb(txbuf[i], reg);
> > +                       tx_len++;
>
> According to SPI standard, during a rx transfer, tx should be kept low.
> These PROGDATA registers doesn't clear itself so it'll keep sending
> data from last transfer, which violates this rule. That's
> why the original code writes 0 to PRGDATA for rx bytes.

following lines with while() will set 0s to the rest of registers.

>
> >                 }
> > -               trx_len += t->len;
> >         }
> >
> > +       while (reg_offset >= 0) {
> > +               writeb(0, sp->base + MTK_NOR_REG_PRGDATA(reg_offset));
> > +               reg_offset--;
> > +       }
> > +
> > +       rx_len = min_t(unsigned long, MTK_NOR_PRG_MAX_CYCLES - tx_len, rx_len);
> > +       trx_len = tx_len + rx_len;
> > +
> >         writel(trx_len * BITS_PER_BYTE, sp->base + MTK_NOR_REG_PRG_CNT);
> >
> >         stat = mtk_nor_cmd_exec(sp, MTK_NOR_CMD_PROGRAM,
> > @@ -482,13 +527,18 @@ static int mtk_nor_transfer_one_message(struct spi_controller *master,
> >         if (stat < 0)
> >                 goto msg_done;
> >
> > -       reg_offset = trx_len - 1;
> > -       list_for_each_entry(t, &m->transfers, transfer_list) {
> > -               rxbuf = t->rx_buf;
> > -               for (i = 0; i < t->len; i++, reg_offset--) {
> > -                       reg = sp->base + MTK_NOR_REG_SHIFT(reg_offset);
> > -                       if (rxbuf)
> > +       if (rx_len > 0) {
> > +               reg_offset = rx_len - 1;
> > +               list_for_each_entry(t, &m->transfers, transfer_list) {
> > +                       u8 *rxbuf = t->rx_buf;
> > +
> > +                       if (!rxbuf)
> > +                               continue;
> > +
> > +                       for (i = 0; i < t->len && reg_offset >= 0; i++, reg_offset--) {
> > +                               reg = sp->base + MTK_NOR_REG_SHIFT(reg_offset);
> >                                 rxbuf[i] = readb(reg);
> > +                       }
>
> I think this is replacing original code with some equivalent ones, which
> seems unnecessary.

This patch addressed the issue with 1+6 bytes transfer (e.g JEDEC ID)
can have negative reg_offset.
And there's skipping the loop if (rx_len < 0)
anyway I'd like to follow with your new patch. :-)

Thanks!

>
> >                 }
> >         }
> >
> --
> Regards,
> Chuanhong Guo
