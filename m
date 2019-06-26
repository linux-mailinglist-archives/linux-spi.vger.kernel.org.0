Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD24565F5
	for <lists+linux-spi@lfdr.de>; Wed, 26 Jun 2019 11:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfFZJxt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Jun 2019 05:53:49 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43561 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfFZJxt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Jun 2019 05:53:49 -0400
Received: by mail-oi1-f194.google.com with SMTP id w79so1435477oif.10
        for <linux-spi@vger.kernel.org>; Wed, 26 Jun 2019 02:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FZpn/SM18BezW4pukReRxQPBUQ3d8CRsVoZLAmRFkEQ=;
        b=qZba/tM9eft65EFUIByi5j0X3EgynrVJ1vVYrBQ58awodkt/Hmh6mAt5Dl/8Gt5QRQ
         LBO9r9OQUaDAQjUByKwdK+Ri+jrFQ+FhrLU85t7F2QfZM5yp+ehlJIl0zFwKozwIUbzM
         1Sz8ys/nXVTK1XTuTs0ovmSp6quwkzPHLftf1+hpkimkgqx2dG2gWgDEnM7R6VHZPTHn
         c1SUb1Rv5L1oNGGnZbI0gptdzIYOrNAJt+CdDtEHbCe1AxxDfuZqBhJSOp6j5uceCmwW
         Urs0zIkoB75eOx9wJI+L7MQPuUMDK55cFsfAwq8OkQrFyWy/KuX+OL7HkuQUmR5k7BSV
         y4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FZpn/SM18BezW4pukReRxQPBUQ3d8CRsVoZLAmRFkEQ=;
        b=U3u8twaurOieddK8tFL9SnVUnRCQywPHBVZeyZELgAI1fp9sfjdVUglNYF0UnkpCIS
         OpawbPmV/6P3GnPhji0DlW5SSsn8o6EhvW2srlJQSlp1NCLX33V7tMpHoBwipHEq8osR
         d9UNgDbrO/nS8pB6+BuX6mdOKYld7pZYQE6uhL9hhxVETOaMco27ag5oRtMD7fS14ybk
         /aSO5wl1sjTJTvfAIYV7FQtgwiRxFTYZe7qbpgiZc31OehhmEhOT5erbAktjBg6fdmfD
         CtiEdQ1bDV6Ngx63RnoUuP7ZWD4UBSjdyr/KbgMMau3ULGixpTH67XIBEL3pM3DMkHqs
         gvVw==
X-Gm-Message-State: APjAAAUEbv/ngEfa20NYxUZrYXty7yjNQgNqoOglghx8DqICWbaNqcPC
        ye5PUoN5OQYap0UJwF01I6RXprFtg3UxViv8jAg=
X-Google-Smtp-Source: APXvYqxfk/cj40sWUyc5CEgNJu4Yg3oD4q5paX2kRGSz+7gHqZ783BKiR4FGZ4IL6ggSz2EBe4FOcjraNVZD7CUbFB4=
X-Received: by 2002:aca:b208:: with SMTP id b8mr1238382oif.98.1561542828346;
 Wed, 26 Jun 2019 02:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <1521807722-21626-1-git-send-email-nagasure@xilinx.com>
 <BY2PR02MB14115B9E46B35A59AC6505D9AFB00@BY2PR02MB1411.namprd02.prod.outlook.com>
 <CALgLF9K=rZxVx_QXvV_LH3OhidTcguZ=K=p=Lf9AfFbk4H+8Zw@mail.gmail.com>
 <20180917170522.0312ae8c@bbrezillon> <CALgLF9JVweEcEm6L33HaHp4HtXhmsZL7J5FDe8+O11i0Q1nukg@mail.gmail.com>
 <20180918091712.2f97db80@bbrezillon>
In-Reply-To: <20180918091712.2f97db80@bbrezillon>
From:   naga suresh kumar <nagasureshkumarrelli@gmail.com>
Date:   Wed, 26 Jun 2019 15:23:36 +0530
Message-ID: <CALgLF9JrTODVPJV8K-TkeN4cAOr88YJT2Swt-jCz_4KN-nwa3A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] RFC for Zynq QSPI
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Naga Sureshkumar Relli <nagasure@xilinx.com>,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd@lists.infradead.org, vigneshr@ti.com,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Boris,

On Tue, Sep 18, 2018 at 12:47 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> Hi Naga,
>
> On Tue, 18 Sep 2018 11:26:05 +0530
> naga suresh kumar <nagasureshkumarrelli@gmail.com> wrote:
>
> > Hi,
> >
> > Please see my reply inline by prefacing my name, currently i am facing
> > issues with my outlook. the reply looks not good but please don't mind.
>
> I do mind. Please find a way to fix that, 'cause I'm pretty sure others
> will soon complain about that too.
>
>
> > > > As i said, it needs tweaking the mtd->size and spi read/write addresses.
> > >
> > > Can you elaborate a bit on why you think this is needed? Did you look
> > > at [1]? Maybe it will prevent us from exposing the flash size at the
> > > spi-mem level.
> > > [naga]: some example snippet below
> > >
> > > spi_nor_read () {
> > >
> > >    if (nor->isparallel == 1)
> > >
> > >    {
> > >
> > >       offset /= 2; //byte stripping will happen here
> > >
> > >        nor->spi->master->flags |= SPI_DATA_STRIPE;
> > >
> > >        //By setting this flag even bits of data word located in lower
> > > memory and odd are in upper memory
> > >
> > >    }
> > >
> > >    if (nor->isstacked == 1) {
> > >
> > >      stack_shift = 1;
> > >
> > >      if (offset >= (mtd->size / 2)) {
> > >
> > >      offset = offset - (mtd->size / 2);
> > >
> > >      nor->spi->master->flags |= SPI_MASTER_U_PAGE;
> > >
> > >      //We can access Upper memory or lower memory, by setting this flag in
> > > controller.
> > >
> > >   } else {
> > >
> > >         nor->spi->master->flags &= ~SPI_MASTER_U_PAGE;
> > >
> > >   }
> > >
> > >  }
> > >
> > > same for spi_nor_write() also.
>
> Let's put the stacked and parallel support on the side for now and
> focus on single die/chip support. Will find a clean way to handle that
> afterwards.
>
> > >
> > > Also in both dual parallel and stacked mode mtd->size should be sum of
> > > both flash device sizes
>
> Yes, but this information should stay at the spi-nor/mtd level.
>
> > >
> > > also status register read will change, it needs status from both devices.
> > > like that some changes
> > >
> > > will be needed in core.
>
> Which is why this needs to be handled in spi-nor.c. The spi-nor core
> needs to know about the parallel/stack setup and handle it differently
> (read both status bytes, read both IDs, ...).
>
> > > > Can somebody share your thoughts on this(Adding Zynq QSPI Dual parallel
> > > and
> > > > stacked)?
> > >
> > > I always have a hard time with this naming. I guess stacked is when you
> > > have 2 chips sharing the same I/O bus, and parallel is when you have 2
> > > chips with one taking all of the I/O and the other taking the other
> > > half. Is that correct?
> > > [naga]: Yes, you are correct, i have attached the diagrams for these mode.
> > >
> > > In parallel mode, with the help of controller STRIPE feature, even bits of
> > >
> > > data words are located in lower memory and odd bits are located in upper
> > > memory.
> > >
> > > Data management will be taken care by controller in both modes
>
> Ok. I need to think about it a bit more. In the meantime, I recommend
> that you submit a version of the driver that does not support parallel
> and stacked modes.

As you suggested previously, i have added the support for Zynq QSPI
controller to support single chip.
Currently i am planning to add support for Parallel and Stacked for the same.
Could you please provide your implementation thoughts on this Parallel
and Stacked mode?

From my side, i am thinking like below.
Will take two config entries CONFIG_SPI_XLNX_PARALLEL and
CONFIG_SPI_XLNX_STACKED
and
#ifdef CONFIG_SPI_XILINX_PARALLEL
   #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors, _flags) \
   ------
  .sector_size = (_sector_size) << 1, \
  .n_sectors = (_n_sectors), \
  .page_size = (256 << 1), \
  .flags = (_flags | SPI_NOR_XLNX_PARALLEL),
#elif CONFIG_SPI_XILINX_STACKED
    #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors, _flags) \
    -------
  .sector_size = (_sector_size), \
  .n_sectors = (_n_sectors << 1), \
  .page_size = 256, \
  .flags = (_flags | SPI_NOR_XLNX_STACKED),
#else
  #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors, _flags) \
   ------
 .sector_size = (_sector_size), \
  .n_sectors = (_n_sectors), \
  .page_size = 256, \
 .flags = (_flags),
 #endif
>

And in the spi_nor_scan()
if (info->flags & (SPI_NOR_XLNX_PARALLEL || SPI_NOR_XLNX_STACKED)) {
        mtd->size = (params.size << 1);
        if (info->flags & SPI_NOR_XLNX_PARALLEL) {
            nor->spi->controller->flags |= (SPI_CONTROLLER_BOTH_CS |
SPI_CONTROLLER_DATA_STRIPE);
            nor->flags |= SNOR_F_XLNX_PARALLEL;
        } else if (info->flags & SPI_NOR_XLNX_STACKED) {
            nor->flags |= SNOR_F_XLNX_STACKED;
       }
}
Based on these flags, will alter the address to write/read, in
spi_nor_write() and spi_nor_read().
i will send an RFC patch with this update just to give show case this feature.

So could you please provide a way to implement the same?
i have also seen, that NXP flex controller is also supporting Parallel
flash mode, but not sure how
they are handling the chip select and mtd->size, page_size etc...
Sorry to bother you, but your suggestions helps a lot.

Thanks,
Naga Sureshkumar Relli

> Regards,
>
> Boris
