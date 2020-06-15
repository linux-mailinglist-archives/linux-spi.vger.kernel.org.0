Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1051F9A7E
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 16:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbgFOOkU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 10:40:20 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39678 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730503AbgFOOkU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 10:40:20 -0400
Received: by mail-oi1-f193.google.com with SMTP id d67so16063041oig.6;
        Mon, 15 Jun 2020 07:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rcay9uCDol5ek0H9aB+GTc9B9A7OXkd9/2qPj3gqRRc=;
        b=gOst+sDC9x5wChjx6dEyJKAppRdGJ6peWeurEMoruakLvh8vSs3xNWQBjU2xCKX5Y4
         uNQGjAS/tV5KmAb1HNt09euo+CcOh4JkjXLJgYuBamGdbdBDap6QF4MgD75Yg30V3xaC
         I2wK6EO3qKdnK6wyBgY7Ki047UWd1cgYEZI3T9n3jocwDMOGDx+LcP7uMQFLyypz4khE
         VoyAVF0mFdxEl2o40F6GVozVgCv4IWr1gsfhx2bA0NKhSMF8r6eOXx6+7d88+aVeFwP6
         cFMPLibW+9EHEGOam4ZB0ZhQIJ1KmEbXiaV3E7iUxG7uO4caKwmbjhsWO0/VfiQp7g0a
         hdvg==
X-Gm-Message-State: AOAM533gulnKPMoUWR3qBkwO+Jb0XPkCx1Go+AFM3REOUsGCb2IINnYO
        A4AlwSZgKlVxpx1+WTO7w1rfEiaThiGul/uNIa8RTKuN
X-Google-Smtp-Source: ABdhPJyzs7Sy/TbPQB7whx7T2Er1XPJbQcTk0I3JgaXXBL2M3Csf25y1FXxBr1wX5s3q14Go2ZJNCKeUBmIo4v+7Y+o=
X-Received: by 2002:aca:1a19:: with SMTP id a25mr9122803oia.54.1592232017510;
 Mon, 15 Jun 2020 07:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <7cddc1a3-f3a8-37dd-487a-cd2274b7941c@fastree3d.com>
 <CAMuHMdXzErU5z69=2gks5ySutkGw98O6+f7weiuPUp8uqTx63w@mail.gmail.com>
 <9bfce379-1878-e8e5-c452-0e24aa263cbb@fastree3d.com> <CAMuHMdWkbVihHqKywxDRW6ucNEySXMa-XEuaVu8Vbx2+kUU-aA@mail.gmail.com>
 <143d0505-33a2-b97f-0088-75def4c1e30d@fastree3d.com> <a1dd3e24-a393-0013-5ff7-a8e7cc7e0626@fastree3d.com>
In-Reply-To: <a1dd3e24-a393-0013-5ff7-a8e7cc7e0626@fastree3d.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 Jun 2020 16:40:04 +0200
Message-ID: <CAMuHMdWPo6xDMipBg2noSOD3trYJjifDbSf-krtgPkA-XdbXZg@mail.gmail.com>
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

On Mon, Jun 15, 2020 at 4:06 PM Adrian Fiergolski
<adrian.fiergolski@fastree3d.com> wrote:
> Sorry for the typo in the example device tree:
>
> On 15.06.2020 15:57, Adrian Fiergolski wrote:
> > On 15.06.2020 15:07, Geert Uytterhoeven wrote:
> >> On Mon, Jun 15, 2020 at 3:01 PM Adrian Fiergolski
> >> <adrian.fiergolski@fastree3d.com> wrote:
> >>> On 13.06.2020 09:33, Geert Uytterhoeven wrote:
> >>>> On Fri, Jun 12, 2020 at 6:26 PM Adrian Fiergolski
> >>>> <adrian.fiergolski@fastree3d.com> wrote:
> >>>> I have a daisy chain of three ltc2634 slaves (iio/dac/ltc2632.c)
> >>>> connected to a single chip select of the cadence-spi master. I have the
> >>>> impression such a configuration is supported by none of those two
> >>>> drivers. I could try to extend both, however, I haven't found any other
> >>>> SPI driver, where I could find implementation inspiration. Is it
> >>>> supported by kernel?
> >>>>
> >>>> drivers/gpio/gpio-max3191x.c supports "#daisy-chained-devices".
> >>>> drivers/gpio/gpio-74x164.c supports multiple shift registers through the
> >>>> "registers-number" DT property.
> >>>>
> >>>> So both drivers handle this in their SPI slave drivers.
> >>>>
> >>>> Of course this does not handle the mixed case, i.e. daisy-chaining
> >>>> different types of devices.
> >>>>
> >>>> The documentation mentions only about the common 'daisy-chained-devices'
> >>>> property (devicetree/bindings/common-properties.txt). However, in order
> >>>> to try to implement it in the master driver, IMHO, the spi subsystem
> >>>> would need to have a call 'no-operation' to other nodes on the
> >>>> daisy-chain, which are not addressed by the given SPI access. Is there
> >>>> any recommended approach to address this case?
> >>>>
> >>>> Supporting this in a generic way would indeed be nice, as it would mean
> >>>> individual SPI slave drivers no longer have to care about it.
> >>>> However, that may be difficult, as the master needs to known which
> >>>> dummy (no-op) data is safe to shift through the non-addresses SPI slaves.
> >>> In fact, the ultimate solution would be to have it solved at the level
> >>> of the spi subsystem:
> >>>
> >>>   * /spi_device struct/ would contain extra callback which returns msg
> >>>     to be sent for no operation.
> >>>   * spi_device struct would contain a pointer to the list describing the
> >>>     given daisy chain (list of spi_devices on the chain)
> >>>   * /spi_device struct /would contain extra u8 daisy_chain_msg_length
> >>>     indicating length of a command of the addressed device if it's on
> >>>     the daisy chain
> >>>     For example, in case of the ltc2634 device, the regular message
> >>>     consists of 24 bits, but when device is a part of a daisy chain, the
> >>>     messages are 32 bits. This 32 would be stored in
> >>>     /daisy_chain_msg_length./
> >>>   * When /spi_write/ was called (include/linux/spi/spi.h), the
> >>>     /spi_message_init_with_transfer/ would create a msg of length equal
> >>>     to a sum of /daisy_chain_msg_length/ of all devices on the chain.
> >>>     Afterwards, in /spi_message_init_with_transfers/, the actual message
> >>>     would be filled with the command of the addressed device on the
> >>>     chain and no_operation content for all other devices on the chain
> >>>     not being addressed
> >> Sounds good to me.
> >>
> >>>   * I think in such a case, the /daisy-chained-devices /property would
> >>>     be not used, as chains would be build basing on the assigned
> >>>     chipselect (reg property).
> >> So you still have to describe the chain in DT in some way.
> >> As there can be only a single sub node with the same unit address
> >> (= chip select), you probably need a container with that address, which
> >> would contain all devices in the chain, in order (unit addresses 0, 1, ...).
> > Good point. So maybe at the level of the device tree, it could be
> > described like that (based on the spi-cadence example):
> >
> >         spi0: spi@ff040000 {
> >             compatible = "cdns,spi-r1p6";
> >             status = "disabled";
> >             interrupt-parent = <&gic>;
> >             interrupts = <0 19 4>;
> >             reg = <0x0 0xff040000 0x0 0x1000>;
> >             clock-names = "ref_clk", "pclk";
> >             #address-cells = <1>;
> >             #size-cells = <0>;
> >             power-domains = <&zynqmp_firmware PD_SPI_0>;
> >             daisy-chain0 : daisy_chain@0 {
> >                #address-cells = <1>;
> >                #size-cells = <0>;
> >                reg = <0>;
> >                daisy-chained-devices = 2;
> >
> >                dac0: ltc2632@0 {
> >                    compatible = "lltc,ltc2634-l12";
> >                    reg = <0>;
> >                    spi-max-frequency = <1000000>;
> >                };
> >                dac1: ltc2632@1 {
> >                    compatible = "lltc,ltc2634-l12";
> >                    reg = <1>;
> >                    spi-max-frequency = <2000000>;
> >                };
> >            };
> >         };
>
>         spi0: spi@ff040000 {
>             compatible = "cdns,spi-r1p6";
>             status = "disabled";
>             interrupt-parent = <&gic>;
>             interrupts = <0 19 4>;
>             reg = <0x0 0xff040000 0x0 0x1000>;
>             clock-names = "ref_clk", "pclk";
>             #address-cells = <1>;
>             #size-cells = <0>;
>             power-domains = <&zynqmp_firmware PD_SPI_0>;
>             daisy-chain0 : daisy_chain@0 {
>                #address-cells = <1>;
>                #size-cells = <0>;
>                #daisy-chained-devices = <2>;

You probably want a proper "compatible" value here instead.
I don't think "#daisy-chained-devices" is needed, it can be derived
from the number of subnodes.

>
>                reg = <0>;
>
>                dac0: ltc2632@0 {
>                    compatible = "lltc,ltc2634-l12";
>                    reg = <0>;
>                    spi-max-frequency = <1000000>;
>                };
>                dac1: ltc2632@1 {
>                    compatible = "lltc,ltc2634-l12";
>                    reg = <1>;
>                    spi-max-frequency = <2000000>;
>                };
>            };
>         };
>
> >
> > Once a node has daisy-chanied-devices property defined,
> > of_register_spi_device (spi.c) will interpret it as a daisy chain. I
> > will assume, that for the given chain the lowest frequency of the whole
> > chain should be used. When it comes to the mode, as in case of
> > incompatibility no much can be done anyway, the mode of the addressed
> > spi device will be used.

Don't the modes have to agree, too?
Else the dummy command may be interpreted differently than intended.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
