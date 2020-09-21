Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A262271AAD
	for <lists+linux-spi@lfdr.de>; Mon, 21 Sep 2020 08:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgIUGKb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Sep 2020 02:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgIUGKb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Sep 2020 02:10:31 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F66C061755
        for <linux-spi@vger.kernel.org>; Sun, 20 Sep 2020 23:10:31 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id q124so3060673vkb.8
        for <linux-spi@vger.kernel.org>; Sun, 20 Sep 2020 23:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hi2rPF/VTt+7YBV2OIek85mNirM/1FNuwC783UZ79gY=;
        b=QaZvdjqmE01vsDCJpv/L3PIhQD9pFvCOGUpf8KQBf3AdasjOy8neTN7t/wRbvEYv1E
         O1FVTx4IAh2rEkqCtye+7TzvIRzyjesUj2gTs4+Ewbb5W8ANnrCwLRpt5GYWxlXO4ElQ
         JwwGdQdUvIdzbc2Tp2ibQkb6BgEX3QMwJUSt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hi2rPF/VTt+7YBV2OIek85mNirM/1FNuwC783UZ79gY=;
        b=K/qh5CaTWy//eTQP8Wg5M++Dy0qTske0yf6OunfYHL+Ss/3pD1j22H+oEb9n6l0lA/
         9DtnttpxpEUEHm28kIit3LYDukgGOW1nzJPYm7wPnNKWfWA4pR+Nq66/mSB4mH2mYrq/
         7++tL5uLbXSZcHuMWkXRaqhII94XOYzlewAepnB5G1W2tw56aaifIVzIdu0+H/oQibhx
         B5mj5TYmS28YDbG9YNHu6ZhZJAg7RB4Av3BeejBUO8eHo09J0cmsOLyI7afokt32o5uy
         SFwod12WjoxAdbFLewIR1VefR1OWoApiUYMUMUwr47Ci6KKSKXU/yI3GsfZFY60vQBpM
         lkvQ==
X-Gm-Message-State: AOAM533CLqPAysPow+PVWKYBEcR+F5lw/uwuBY+d5jF7tZDtTFGp7g4O
        qEUicK0jN/GB8f6wiebocCyB1dyxbvZwaKgHTnezmA==
X-Google-Smtp-Source: ABdhPJwS1vT6jl1+U7TJLvBVogQi38c1rNUQm4Kcmwy0nzE27iFQkCgHBkdfG6By1N4TLFUCpb7VEZDUgpxahYlWQZM=
X-Received: by 2002:a1f:1c17:: with SMTP id c23mr17961911vkc.0.1600668630316;
 Sun, 20 Sep 2020 23:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200918083124.3921207-1-ikjn@chromium.org> <20200918162834.v2.2.I3de2918f09b817cc2ae6d324f1ece62779ecc7cf@changeid>
 <CAJsYDV+Um3aEsgW-829BsZSaiVCp3O2LkrTmgCthhFv4fuEnLg@mail.gmail.com>
In-Reply-To: <CAJsYDV+Um3aEsgW-829BsZSaiVCp3O2LkrTmgCthhFv4fuEnLg@mail.gmail.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Mon, 21 Sep 2020 14:10:19 +0800
Message-ID: <CAATdQgB5UAFbxW6J2no7=Jyn2ddaHXceAxedGaaAxa++gGNDkg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] spi: spi-mtk-nor: fix mishandled logics in
 checking SPI memory operation
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

On Fri, Sep 18, 2020 at 9:09 PM Chuanhong Guo <gch981213@gmail.com> wrote:
>
> Hi!
>
> On Fri, Sep 18, 2020 at 4:34 PM Ikjoon Jang <ikjn@chromium.org> wrote:
> >
> > Fix a simple bug which can limits its transfer size,
> > and add a simple helper function for code cleanups.
> >
> > Fixes: a59b2c7c56bf ("spi: spi-mtk-nor: support standard spi properties")
> > Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> >
> > ---
> >
> > (no changes since v1)
> >
> >  drivers/spi/spi-mtk-nor.c | 62 ++++++++++++++++++++++++---------------
> >  1 file changed, 38 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
> > index 6e6ca2b8e6c8..54b2c0fde95b 100644
> > --- a/drivers/spi/spi-mtk-nor.c
> > +++ b/drivers/spi/spi-mtk-nor.c
> > @@ -167,52 +167,63 @@ static bool mtk_nor_match_read(const struct spi_mem_op *op)
> >         return false;
> >  }
> >
> > -static int mtk_nor_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
> > +static bool need_bounce(void *cpu_addr, unsigned long len)
> >  {
> > -       size_t len;
> > +       return !!(((uintptr_t)cpu_addr) & MTK_NOR_DMA_ALIGN_MASK);
> > +}
>
> parameter 'len' isn't used in this function.

ACK.

>
> >
> > +static int mtk_nor_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
> > +{
> >         if (!op->data.nbytes)
> >                 return 0;
> >
> >         if ((op->addr.nbytes == 3) || (op->addr.nbytes == 4)) {
> > -               if ((op->data.dir == SPI_MEM_DATA_IN) &&
> > -                   mtk_nor_match_read(op)) {
>
> I think replacing a if/else if with a two-case switch is more
> of a personal code preference rather than code cleanup.
> I'd prefer only adding need_bounce to replace alignment
> check using a separated commit and leave other stuff
> untouched because:
> 1. This "cleanup" made unintended logic changes (see below)
> 2. The "cleanup" itself actually becomes the major part of
>     this patch, while the actual fix mentioned in commit
>     message is the minor part.
> 3. A fix commit should contain the fix itself. It shouldn't
>     mix with these code changes.

Got it, v3 will only include the fix itself.

>
> > +               switch (op->data.dir) {
> > +               case SPI_MEM_DATA_IN:
> > +                       if (!mtk_nor_match_read(op))
> > +                               return -EINVAL;
>
> You are changing the code logic here.
> mtk_nor_match_read checks if the operation can be executed
> using controller PIO/DMA reading. Even if it's not supported,
> we can still use PRG mode to execute the operation.
> One example of such an operation is SPI NOR SFDP reading.
> Your change breaks that which then breaks 1_2_2 and 1_4_4
> reading capability because spi-nor driver parses these op formats
> from SFDP table.

As you already noticed it, this is a bug from the last patch I made
and v2 isn't fixing this problem. This should be restored & fixed in v3.
And will not include other changes in a same patch.

>
> > +                       /* check if it's DMAable */
> >                         if ((op->addr.val & MTK_NOR_DMA_ALIGN_MASK) ||
> > -                           (op->data.nbytes < MTK_NOR_DMA_ALIGN))
> > +                           (op->data.nbytes < MTK_NOR_DMA_ALIGN)) {
> >                                 op->data.nbytes = 1;
> > -                       else if (!((ulong)(op->data.buf.in) &
> > -                                  MTK_NOR_DMA_ALIGN_MASK))
> > +                       } else {
> > +                               if (need_bounce(op->data.buf.in, op->data.nbytes) &&
> > +                                   (op->data.nbytes > MTK_NOR_BOUNCE_BUF_SIZE))
> > +                                       op->data.nbytes = MTK_NOR_BOUNCE_BUF_SIZE;
> >                                 op->data.nbytes &= ~MTK_NOR_DMA_ALIGN_MASK;
> > -                       else if (op->data.nbytes > MTK_NOR_BOUNCE_BUF_SIZE)
> > -                               op->data.nbytes = MTK_NOR_BOUNCE_BUF_SIZE;
>
> data length alignment is intentionally done only for DMA reading
> without the bounce buffer.
> My intention here:
> If we use the bounce buffer, we can read more data than needed to.
> Say we want 25 bytes of data, reading 32 bytes using DMA and
> bounce buffer should be faster than reading 16 bytes with DMA
> and another 9 bytes with PIO, because for every single byte of PIO
> reading, adjust_op_size and exec_op is called once, we
> program controller with new cmd/address, and controller need
> to send extra cmd/address to flash.
> I noticed that you removed this part of logic from DMA reading
> execution in 3/5 as well. Please revert the logic change here
> add in DMA reading function (see later comment in 3/5).

In v2, I wasn't sure whether this behavior is sane (read more than requested)
Now I think this is okay, I've missed the fact that flash address is
also aligned together.
I'll just keep the previous logics with padding in v3.

Thanks!

>
> > -                       return 0;
> > -               } else if (op->data.dir == SPI_MEM_DATA_OUT) {
> > +                       }
> > +                       break;
> > +               case SPI_MEM_DATA_OUT:
> >                         if (op->data.nbytes >= MTK_NOR_PP_SIZE)
> >                                 op->data.nbytes = MTK_NOR_PP_SIZE;
> >                         else
> >                                 op->data.nbytes = 1;
> > -                       return 0;
> > +                       break;
> > +               default:
> > +                       break;
> >                 }
> > +       } else {
> > +               u8 len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
> > +
> > +               if (len > MTK_NOR_PRG_MAX_SIZE)
> > +                       return -EINVAL;
> > +               if (op->data.nbytes && !(MTK_NOR_PRG_MAX_SIZE - len))
> > +                       return -EINVAL;
> > +               if (op->data.nbytes > (MTK_NOR_PRG_MAX_SIZE - len))
> > +                       op->data.nbytes = MTK_NOR_PRG_MAX_SIZE - len;
> >         }
> >
> > -       len = MTK_NOR_PRG_MAX_SIZE - op->cmd.nbytes - op->addr.nbytes -
> > -             op->dummy.nbytes;
> > -       if (op->data.nbytes > len)
> > -               op->data.nbytes = len;
> > -
> >         return 0;
> >  }
> >
> >  static bool mtk_nor_supports_op(struct spi_mem *mem,
> >                                 const struct spi_mem_op *op)
> >  {
> > -       size_t len;
> > -
> >         if (op->cmd.buswidth != 1)
> >                 return false;
> >
> >         if ((op->addr.nbytes == 3) || (op->addr.nbytes == 4)) {
> > -               switch(op->data.dir) {
> > +               switch (op->data.dir) {
> >                 case SPI_MEM_DATA_IN:
> >                         if (!mtk_nor_match_read(op))
> >                                 return false;
> > @@ -226,11 +237,14 @@ static bool mtk_nor_supports_op(struct spi_mem *mem,
> >                 default:
> >                         break;
> >                 }
> > +       } else {
> > +               u8 len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
> > +
> > +               if (len > MTK_NOR_PRG_MAX_SIZE)
> > +                       return false;
> > +               if (op->data.nbytes && !(MTK_NOR_PRG_MAX_SIZE - len))
> > +                       return false;
> >         }
> > -       len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
> > -       if ((len > MTK_NOR_PRG_MAX_SIZE) ||
> > -           ((op->data.nbytes) && (len == MTK_NOR_PRG_MAX_SIZE)))
> > -               return false;
> >
> >         return spi_mem_default_supports_op(mem, op);
> >  }
> > --
> > 2.28.0.681.g6f77f65b4e-goog
> >
>
>
> --
> Regards,
> Chuanhong Guo
