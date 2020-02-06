Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C517915440C
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2020 13:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgBFMae (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Feb 2020 07:30:34 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42397 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbgBFMad (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 Feb 2020 07:30:33 -0500
Received: by mail-oi1-f194.google.com with SMTP id j132so4376921oih.9;
        Thu, 06 Feb 2020 04:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+1wFfKBBcLtp5HsDjSSxgCzKCPvIDHcwsEvjBCHh2bw=;
        b=XmAE1w2yO9wC3BL7kPK/ffAw0IykNlf2BpmVlytSEbHAAlZV3ImRK2behv6USpYxN4
         9bJhoUm0wrS1s5kuc2ordkStKKY5YryUDTlRyVSPTyWZO1jyw4WhbrjqwJdeLLjbtnQF
         2q7h2gyAlb+IVrgoCFCc5jDh7Ef8TvRUbaB8zQfdofnFKddV8CMmmbhhgp/2e38UIWSB
         SPwdpBmruKXr93RgnU+hH2AM0RbHQFdiBi6FBy+TDXdKbXiDVvVNG/by5u2ouslSnwMl
         g82QMp/WeFhrUP1UVBugeqQw2S2YOh/O7dCTJNh1GXJ6OHp3ffmqY6KXquXwInTCCg6j
         I0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+1wFfKBBcLtp5HsDjSSxgCzKCPvIDHcwsEvjBCHh2bw=;
        b=L9bm3QAvZA3iVEnj/RnY05RpK8z8wBCYWg2w3HNVbcYML7JQeYegc457tuyqt/bhUn
         mUap05BIQdilch7F4EQPuqNrVTb1IGlBhLm+UYPZ1G1+HD42nmoWelrmhQyhYq6/9DDi
         ykSHzP0q8nymrjyKxpeyek0uDRB1iZQvU8XVw0+tIRVgJs18EkqM8wheT7OhqSwfJuAI
         pszNdzOAMMHzBF4pUu7oY3oFVSDE7p2uEPjDg1+g8hgfoNtRJWChT8zBTx9Ja2NCdXYU
         Brlcd7rUuR01GizCJBWJzVKpgSso1L9+ybcFCcXIFj4oCdvtWfL08DSlo74o43/A4g1e
         E9OA==
X-Gm-Message-State: APjAAAXA6q4VPR+Z0JLF68KmrAdshaMabl1qbLguvsbiKik5JMtpncd/
        JBx5SrQe1WTlsOpSTn8oAIVP5oqqt7kbwxD9LLc=
X-Google-Smtp-Source: APXvYqxs9v7rOqTlKGdsKrcP18kSV7Lc+clMK7meuUj9srtzLfK8vGc9JfTNWAm94gxg0dSiQqzyhYlvkSnurGXfseE=
X-Received: by 2002:aca:1a17:: with SMTP id a23mr6403203oia.84.1580992232881;
 Thu, 06 Feb 2020 04:30:32 -0800 (PST)
MIME-Version: 1.0
References: <20200206084443.209719-1-gch981213@gmail.com> <20200206084443.209719-2-gch981213@gmail.com>
 <20200206113158.GK3897@sirena.org.uk>
In-Reply-To: <20200206113158.GK3897@sirena.org.uk>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Thu, 6 Feb 2020 20:30:21 +0800
Message-ID: <CAJsYDVKnOv+4NT8V+9fFy_0KE7QSoeTL0jHTdq31Z=88vBzHgQ@mail.gmail.com>
Subject: Re: [PATCH resend 1/2] spi: add driver for ar934x spi controller
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Feb 6, 2020 at 7:31 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Feb 06, 2020 at 04:44:42PM +0800, Chuanhong Guo wrote:
>
> This looks good, just a couple of comments below:
>
> > --- /dev/null
> > +++ b/drivers/spi/spi-ar934x.c
> > @@ -0,0 +1,230 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * SPI controller driver for Qualcomm Atheros AR934x/QCA95xx SoCs
>
> Please make the entire comment block a C++ one so things look
> more intentional.

Got it. I'll do this in v2.

>
> > +static int ar934x_spi_transfer_one(struct spi_controller *master,
> > +                                struct spi_message *m)
> > +{
> > +     struct ar934x_spi *sp = spi_controller_get_devdata(master);
> > +     struct spi_transfer *t = NULL;
>
> ...
>
> > +
> > +     m->actual_length = 0;
> > +     list_for_each_entry(t, &m->transfers, transfer_list) {
>
> It looks like this could just be a transfer_one() operation
> instead of transfer_one_message() (which is what this is in spite
> of the name)?  There's nothing custom outside this loop that I
> can see.

Chipselect is also handled during transfer. Controller asserts
corresponding chipselect in SHIFT_CTRL register, and if SHIFT_TERM bit
is set, controller will deassert chipselect after current transfer is
done. I need to know whether this is the last transfer and set
SHIFT_TERM accordingly.

Regards,
Chuanhong Guo
