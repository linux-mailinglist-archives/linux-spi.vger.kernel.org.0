Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABFE1F97E3
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 15:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgFONHj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 09:07:39 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36364 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729977AbgFONHj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 09:07:39 -0400
Received: by mail-ot1-f68.google.com with SMTP id 97so13044641otg.3;
        Mon, 15 Jun 2020 06:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iSsJfEBKvALFrXFgdoS1N0VdhxgvLc52xB34AcC9mQM=;
        b=n0dp4YGiBiM5v1eNi89Ig8kS6cY6Bh9VHW8uaqE86+QC0x2kXVr6fl+QBKmBSpH1Uv
         a30lPyMQ+Q+L7+I1qNSgzkBaG2P2rxFjBktqsAH4jtdKpA1PCjHtolkZfPNF6OjcKFiu
         wHulBNvkgVQ2OkSNYdLhu/RkeErXi1qZKPOCH+Gfc+HZ/jJAR5IQs72hWT4EhfYxmrHR
         4iXckPqxUCRYldLEL9my/M3LJUywzj4kXItOXumfPIzBGcrIF3R/aRF18GvnpdCONWv0
         +5Yd7huFmaff6iGSantFt6lYCy9aQTBcEs8AZ7g0m/yIMZqOuhXj0CM/EDY6ojq7a5T/
         rGwg==
X-Gm-Message-State: AOAM5331j87L3wiayTseatjZ1SXLdOEfi7NsnsZDChRNLMPrZQmWOxG0
        shf+Qim8I9WCm9wiWIR87CKC1CV2Sl3wjQriiZ9cd8DY
X-Google-Smtp-Source: ABdhPJzxDMDVkQ073lLLuSP4HvmEzzAQAtG0qgHPyL51Q8qUxY0RIBK+jKac5tmfH0R617J/b68GXDyv4uiWOEyUM3Y=
X-Received: by 2002:a05:6830:141a:: with SMTP id v26mr21458229otp.250.1592226457793;
 Mon, 15 Jun 2020 06:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <7cddc1a3-f3a8-37dd-487a-cd2274b7941c@fastree3d.com>
 <CAMuHMdXzErU5z69=2gks5ySutkGw98O6+f7weiuPUp8uqTx63w@mail.gmail.com> <9bfce379-1878-e8e5-c452-0e24aa263cbb@fastree3d.com>
In-Reply-To: <9bfce379-1878-e8e5-c452-0e24aa263cbb@fastree3d.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 Jun 2020 15:07:26 +0200
Message-ID: <CAMuHMdWkbVihHqKywxDRW6ucNEySXMa-XEuaVu8Vbx2+kUU-aA@mail.gmail.com>
Subject: Re: [cadence-spi] daisy chain
To:     Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Adrian,

CC devicetree

On Mon, Jun 15, 2020 at 3:01 PM Adrian Fiergolski
<adrian.fiergolski@fastree3d.com> wrote:
> On 13.06.2020 09:33, Geert Uytterhoeven wrote:
> > On Fri, Jun 12, 2020 at 6:26 PM Adrian Fiergolski
> > <adrian.fiergolski@fastree3d.com> wrote:
> > I have a daisy chain of three ltc2634 slaves (iio/dac/ltc2632.c)
> > connected to a single chip select of the cadence-spi master. I have the
> > impression such a configuration is supported by none of those two
> > drivers. I could try to extend both, however, I haven't found any other
> > SPI driver, where I could find implementation inspiration. Is it
> > supported by kernel?
> >
> > drivers/gpio/gpio-max3191x.c supports "#daisy-chained-devices".
> > drivers/gpio/gpio-74x164.c supports multiple shift registers through the
> > "registers-number" DT property.
> >
> > So both drivers handle this in their SPI slave drivers.
> >
> > Of course this does not handle the mixed case, i.e. daisy-chaining
> > different types of devices.
> >
> > The documentation mentions only about the common 'daisy-chained-devices'
> > property (devicetree/bindings/common-properties.txt). However, in order
> > to try to implement it in the master driver, IMHO, the spi subsystem
> > would need to have a call 'no-operation' to other nodes on the
> > daisy-chain, which are not addressed by the given SPI access. Is there
> > any recommended approach to address this case?
> >
> > Supporting this in a generic way would indeed be nice, as it would mean
> > individual SPI slave drivers no longer have to care about it.
> > However, that may be difficult, as the master needs to known which
> > dummy (no-op) data is safe to shift through the non-addresses SPI slaves.
>
> In fact, the ultimate solution would be to have it solved at the level
> of the spi subsystem:
>
>   * /spi_device struct/ would contain extra callback which returns msg
>     to be sent for no operation.
>   * spi_device struct would contain a pointer to the list describing the
>     given daisy chain (list of spi_devices on the chain)
>   * /spi_device struct /would contain extra u8 daisy_chain_msg_length
>     indicating length of a command of the addressed device if it's on
>     the daisy chain
>     For example, in case of the ltc2634 device, the regular message
>     consists of 24 bits, but when device is a part of a daisy chain, the
>     messages are 32 bits. This 32 would be stored in
>     /daisy_chain_msg_length./
>   * When /spi_write/ was called (include/linux/spi/spi.h), the
>     /spi_message_init_with_transfer/ would create a msg of length equal
>     to a sum of /daisy_chain_msg_length/ of all devices on the chain.
>     Afterwards, in /spi_message_init_with_transfers/, the actual message
>     would be filled with the command of the addressed device on the
>     chain and no_operation content for all other devices on the chain
>     not being addressed

Sounds good to me.

>   * I think in such a case, the /daisy-chained-devices /property would
>     be not used, as chains would be build basing on the assigned
>     chipselect (reg property).

So you still have to describe the chain in DT in some way.
As there can be only a single sub node with the same unit address
(= chip select), you probably need a container with that address, which
would contain all devices in the chain, in order (unit addresses 0, 1, ...).

> If you agree with the above description, I could try to implement it. Of
> course any suggestion are welcome, however, I would like to have a
> working solution until end of this week, so I would appreciate an active
> feedback. As my SoC works with kernel v4.19, I would implement it for
> it, test it, and move it afterwards to the master version (I hope, there
> were no big changes in the SPI subsystem, right?).

Having something that works by the end of the week sounds doable to.
Getting it in shape for upstreaming is a different thing...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
