Return-Path: <linux-spi+bounces-3550-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C08A915641
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 20:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963091C21167
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 18:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B111A00EE;
	Mon, 24 Jun 2024 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="sQS08B5U"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C801A00ED
	for <linux-spi@vger.kernel.org>; Mon, 24 Jun 2024 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719252679; cv=none; b=WmgLKLL37iJYiDE7RZlzApumJJ4jAMHKxkqA8MMnpf6gigXPHWhZRp2LpXyQ6liOjzYRY48Ro4p9Qa4BsWwZqSAwgK7aXAVYnTaDfCXrvUdRunq4kq1zitO3tROVssfry0HU3LhDn/n9LWJlhNgNnKuoIzry8H7xxB1bDV3sAFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719252679; c=relaxed/simple;
	bh=nIUdy22oglBfUryv7MbqxD7BiJz15+mnbfSouo20eE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/+7N0VJmn45Rgni0XapTZquKL0VcEMlMfpwaB7zHV5UaktOnbJK+crIaZdMW2jGBRuuHGd0iGke+P1BfNPweCw8Qto1zOUJiqYTAF8X4KR5Z5Cwdzr+pJhuxODhy2uTxkrgsEl6hd6gH66Otys+7oY/txA/EcRZAoA3TfntEEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=sQS08B5U; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dff26b612a9so4003230276.1
        for <linux-spi@vger.kernel.org>; Mon, 24 Jun 2024 11:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1719252675; x=1719857475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5jGR9g/Bb8Va571zVMLt5UXvxDZ++mFdkIqRAoUvAic=;
        b=sQS08B5UMSb+22J6GNJ5ErP7KnMW9h8n6ml0sPCi3JxLUevLqlfHukKB4+MNafmjFr
         Zvu8x2tY5+hDkZd2xiVhyE6A7h6+YsbTDhvGf9FVq3c/4Ykxp1wBQoMp/hDQzN/zyIvM
         MgqCiNEyS/+6hejeKqWCB2FtGJe35f++BaaIto0tLABzGT3kL62KJcXKqYG4Dm5iYtMN
         Gpo6gOCiOYAyW3PLT55pqqDgh1CeDU0BCKREBK8EzYNt6pykUYsltNSkYowCb3Xh2udu
         iW/izwf4f486KNpMOoKQEgO/QrrkYc3e/CHa1ML8WBOaeJ/VJ8vqoubs1ARqEmbzUhRl
         Zhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719252675; x=1719857475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jGR9g/Bb8Va571zVMLt5UXvxDZ++mFdkIqRAoUvAic=;
        b=rkRr43TsTgRe9Wiw9JGEJIuLLxhnS6Xk4MkqpbxychSD/qaS6FqecwJ/egu6H8/GA4
         PCIBzCzlCWq8Bi4X5yu9lGNW+uwUZI5X2to0lhnzL9zDlkIFPkTXndlNMx/Lo9hhfgsv
         zIzUP8wnIlwM/mWfONAj9BcBxtPulTwFihtZ/ZhpU1fJwniu8eJXwl2BgP+QeXXxF5n0
         OuD+DeQh+lYqUC5xt4z9YXru8B6G64FnTR3oCjSzXf1yXhg0GijcDHnwtxuR9wguFSFH
         zaMzGXPU7I2i9T45UoT8mOv5wo9qqi3mZQswgVHLbgV1MmTU4y+aKIZ9JRjDr+tmSxP9
         CqNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0+X30ArhjC0qOfZ3zYtEz8tZVgxJifEcZQI+lKDlIZDtFZDAryRA/yokrYky4cr6Vrq3WADtKzonDSAohIXXHUI+NMShgxfOV
X-Gm-Message-State: AOJu0YxE6mwmqxmWoyLH0IpYIa+CFb+REAytwZuYUlSVE8yell8aVQb+
	2Xra5Y9j5yp5EgfV6aIsp73aHQVWw0d3+iZXUc9HHwzKkseERPeA16kaf3LtQLiW9VIK7qPnbOc
	jFhWCVDmgUzTOySAFIEfUPAMObLG/iPOC8pxj+A==
X-Google-Smtp-Source: AGHT+IFaAqmhNPlm6MCoDVgffhkfuksOWP1wIZM8AnbBnkW6RDpNrHr6R7v3rNj3Wz45MorU/sgEZjJu5xv7+4bnw1s=
X-Received: by 2002:a25:c54d:0:b0:e02:bf87:7cd4 with SMTP id
 3f1490d57ef6-e0303fea2bdmr5469380276.53.1719252675064; Mon, 24 Jun 2024
 11:11:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
 <20240524182702.1317935-9-dave.stevenson@raspberrypi.com> <ZmCo4IfRhEzMf9gs@lizhi-Precision-Tower-5810>
In-Reply-To: <ZmCo4IfRhEzMf9gs@lizhi-Precision-Tower-5810>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 24 Jun 2024 19:10:58 +0100
Message-ID: <CAPY8ntBNz5tGfVz7FJ0wvzxWZ+AyjbTn7JbDFX=cNq-EN2Vu5A@mail.gmail.com>
Subject: Re: [PATCH 08/18] dmaengine: bcm2835: pass dma_chan to generic functions
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Vinod Koul <vkoul@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Vladimir Murzin <vladimir.murzin@arm.com>, Phil Elwell <phil@raspberrypi.com>, 
	Stefan Wahren <wahrenst@gmx.net>, Serge Semin <Sergey.Semin@baikalelectronics.ru>, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org, iommu@lists.linux.dev, 
	linux-sound@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>
Content-Type: text/plain; charset="UTF-8"

Hi Frank.

On Wed, 5 Jun 2024 at 19:05, Frank Li <Frank.li@nxp.com> wrote:
>
> On Fri, May 24, 2024 at 07:26:52PM +0100, Dave Stevenson wrote:
> > From: Stefan Wahren <stefan.wahren@i2se.com>
> >
> > In preparation to support more platforms pass the dma_chan to the
> > generic functions. This provides access to the DMA device and possible
> > platform specific data.
>
> why need this change? you can easy convert between dma_chan and
> bcm2835_chan.

These patches are leading to adding a bcm2711_chan structure for a new
(but very closely related) variant of the DMA controller.

dma_chan is the generic structure, therefore we can keep more
commonality between the variants if we use that wherever possible.

  Dave

> >
> > Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > ---
> >  drivers/dma/bcm2835-dma.c | 24 ++++++++++++++----------
> >  1 file changed, 14 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> > index e2f9c8692e6b..aefaa1f01d7f 100644
> > --- a/drivers/dma/bcm2835-dma.c
> > +++ b/drivers/dma/bcm2835-dma.c
> > @@ -288,12 +288,13 @@ static void bcm2835_dma_desc_free(struct virt_dma_desc *vd)
> >  }
> >
> >  static bool
> > -bcm2835_dma_create_cb_set_length(struct bcm2835_chan *chan,
> > +bcm2835_dma_create_cb_set_length(struct dma_chan *chan,
> >                                struct bcm2835_dma_cb *control_block,
> >                                size_t len, size_t period_len,
> >                                size_t *total_len)
> >  {
> > -     size_t max_len = bcm2835_dma_max_frame_length(chan);
> > +     struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
> > +     size_t max_len = bcm2835_dma_max_frame_length(c);
> >
> >       /* set the length taking lite-channel limitations into account */
> >       control_block->length = min_t(u32, len, max_len);
> > @@ -417,7 +418,7 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
> >               /* set up length in control_block if requested */
> >               if (buf_len) {
> >                       /* calculate length honoring period_length */
> > -                     if (bcm2835_dma_create_cb_set_length(c, control_block,
> > +                     if (bcm2835_dma_create_cb_set_length(chan, control_block,
> >                                                            len, period_len,
> >                                                            &total_len)) {
> >                               /* add extrainfo bits in info */
> > @@ -485,8 +486,9 @@ static void bcm2835_dma_fill_cb_chain_with_sg(
> >       }
> >  }
> >
> > -static void bcm2835_dma_abort(struct bcm2835_chan *c)
> > +static void bcm2835_dma_abort(struct dma_chan *chan)
> >  {
> > +     struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
> >       void __iomem *chan_base = c->chan_base;
> >       long int timeout = 10000;
> >
> > @@ -513,8 +515,9 @@ static void bcm2835_dma_abort(struct bcm2835_chan *c)
> >       writel(BCM2835_DMA_RESET, chan_base + BCM2835_DMA_CS);
> >  }
> >
> > -static void bcm2835_dma_start_desc(struct bcm2835_chan *c)
> > +static void bcm2835_dma_start_desc(struct dma_chan *chan)
> >  {
> > +     struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
> >       struct virt_dma_desc *vd = vchan_next_desc(&c->vc);
> >       struct bcm2835_desc *d;
> >
> > @@ -533,7 +536,8 @@ static void bcm2835_dma_start_desc(struct bcm2835_chan *c)
> >
> >  static irqreturn_t bcm2835_dma_callback(int irq, void *data)
> >  {
> > -     struct bcm2835_chan *c = data;
> > +     struct dma_chan *chan = data;
> > +     struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
> >       struct bcm2835_desc *d;
> >       unsigned long flags;
> >
> > @@ -566,7 +570,7 @@ static irqreturn_t bcm2835_dma_callback(int irq, void *data)
> >                       vchan_cyclic_callback(&d->vd);
> >               } else if (!readl(c->chan_base + BCM2835_DMA_ADDR)) {
> >                       vchan_cookie_complete(&c->desc->vd);
> > -                     bcm2835_dma_start_desc(c);
> > +                     bcm2835_dma_start_desc(chan);
> >               }
> >       }
> >
> > @@ -594,7 +598,7 @@ static int bcm2835_dma_alloc_chan_resources(struct dma_chan *chan)
> >       }
> >
> >       return request_irq(c->irq_number, bcm2835_dma_callback,
> > -                        c->irq_flags, "DMA IRQ", c);
> > +                        c->irq_flags, "DMA IRQ", chan);
> >  }
> >
> >  static void bcm2835_dma_free_chan_resources(struct dma_chan *chan)
> > @@ -682,7 +686,7 @@ static void bcm2835_dma_issue_pending(struct dma_chan *chan)
> >
> >       spin_lock_irqsave(&c->vc.lock, flags);
> >       if (vchan_issue_pending(&c->vc) && !c->desc)
> > -             bcm2835_dma_start_desc(c);
> > +             bcm2835_dma_start_desc(chan);
> >
> >       spin_unlock_irqrestore(&c->vc.lock, flags);
> >  }
> > @@ -846,7 +850,7 @@ static int bcm2835_dma_terminate_all(struct dma_chan *chan)
> >       if (c->desc) {
> >               vchan_terminate_vdesc(&c->desc->vd);
> >               c->desc = NULL;
> > -             bcm2835_dma_abort(c);
> > +             bcm2835_dma_abort(chan);
> >       }
> >
> >       vchan_get_all_descriptors(&c->vc, &head);
> > --
> > 2.34.1
> >

