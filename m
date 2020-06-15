Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13A01FA368
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 00:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgFOWXE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 18:23:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgFOWXE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 18:23:04 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FBA220768;
        Mon, 15 Jun 2020 22:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592259782;
        bh=j4z0XBSGuF+WLgQoNw8dYLLAwZXMYmBL6SbWZDYqhgo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A0ln/FTnO3bXXFoMfOOmXO9+YPb4HtDl5FAc69IIVFUftd52l5eHxu1pjXoiKDWjs
         IXF/u9kJ5Y1W98W3vIRE1F6QfGJkv49cjEWDysvimaQnVtZOqXtQNpokzw7fDVaSf2
         tBPH3w8ep+lYinUoHqMIrsJJSRpUUbwbLBFm6XCo=
Received: by mail-oi1-f176.google.com with SMTP id b8so17472195oic.1;
        Mon, 15 Jun 2020 15:23:02 -0700 (PDT)
X-Gm-Message-State: AOAM531zUH1+3mYG9IU4q/U2g0e4x5cQoL/X55rQhJxecraLfOHthw5b
        Dbr+fTGfIDCuCcmSoh8Lho72Xs+a3gjcRpb+lg==
X-Google-Smtp-Source: ABdhPJwMEufH0zIsPUC/JrC3ZiEk4m9XpE9RQClmRqKUdXAgPYO5wkOtjPOF3WMU4QN5C+4QD08fesyUzN22iVqsIfI=
X-Received: by 2002:aca:d454:: with SMTP id l81mr1308803oig.152.1592259781555;
 Mon, 15 Jun 2020 15:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <7cddc1a3-f3a8-37dd-487a-cd2274b7941c@fastree3d.com>
 <CAMuHMdXzErU5z69=2gks5ySutkGw98O6+f7weiuPUp8uqTx63w@mail.gmail.com>
 <9bfce379-1878-e8e5-c452-0e24aa263cbb@fastree3d.com> <CAMuHMdWkbVihHqKywxDRW6ucNEySXMa-XEuaVu8Vbx2+kUU-aA@mail.gmail.com>
 <143d0505-33a2-b97f-0088-75def4c1e30d@fastree3d.com> <a1dd3e24-a393-0013-5ff7-a8e7cc7e0626@fastree3d.com>
 <CAMuHMdWPo6xDMipBg2noSOD3trYJjifDbSf-krtgPkA-XdbXZg@mail.gmail.com>
 <4311cc0a-016d-1a24-10f9-9dccc28ddd43@fastree3d.com> <CAMuHMdVHqNi9peLm8Lf+uSXDjzJP6eB9Kz1oM-Mr8RQ62+1uZg@mail.gmail.com>
In-Reply-To: <CAMuHMdVHqNi9peLm8Lf+uSXDjzJP6eB9Kz1oM-Mr8RQ62+1uZg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 15 Jun 2020 16:22:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLuo4jB6B8eqwm3YQ1gxxndwC6o23=+tm0dugPcGxm6ww@mail.gmail.com>
Message-ID: <CAL_JsqLuo4jB6B8eqwm3YQ1gxxndwC6o23=+tm0dugPcGxm6ww@mail.gmail.com>
Subject: Re: [cadence-spi] daisy chain
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Adrian Fiergolski <adrian.fiergolski@fastree3d.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Jun 15, 2020 at 3:30 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Adrian,
>
> On Mon, Jun 15, 2020 at 6:05 PM Adrian Fiergolski
> <adrian.fiergolski@fastree3d.com> wrote:
> > On 15.06.2020 16:40, Geert Uytterhoeven wrote:
> > > On Mon, Jun 15, 2020 at 4:06 PM Adrian Fiergolski
> > > <adrian.fiergolski@fastree3d.com> wrote:
> > >> Sorry for the typo in the example device tree:
> > >>
> > >> On 15.06.2020 15:57, Adrian Fiergolski wrote:
> > >>> On 15.06.2020 15:07, Geert Uytterhoeven wrote:
> > >>>> On Mon, Jun 15, 2020 at 3:01 PM Adrian Fiergolski
> > >>>> <adrian.fiergolski@fastree3d.com> wrote:
> > >>>>> On 13.06.2020 09:33, Geert Uytterhoeven wrote:
> > >>>>>> On Fri, Jun 12, 2020 at 6:26 PM Adrian Fiergolski
> > >>>>>> <adrian.fiergolski@fastree3d.com> wrote:
> > >>>>>> I have a daisy chain of three ltc2634 slaves (iio/dac/ltc2632.c)
> > >>>>>> connected to a single chip select of the cadence-spi master. I have the
> > >>>>>> impression such a configuration is supported by none of those two
> > >>>>>> drivers. I could try to extend both, however, I haven't found any other
> > >>>>>> SPI driver, where I could find implementation inspiration. Is it
> > >>>>>> supported by kernel?
> > >>>>>>
> > >>>>>> drivers/gpio/gpio-max3191x.c supports "#daisy-chained-devices".
> > >>>>>> drivers/gpio/gpio-74x164.c supports multiple shift registers through the
> > >>>>>> "registers-number" DT property.
> > >>>>>>
> > >>>>>> So both drivers handle this in their SPI slave drivers.
> > >>>>>>
> > >>>>>> Of course this does not handle the mixed case, i.e. daisy-chaining
> > >>>>>> different types of devices.
> > >>>>>>
> > >>>>>> The documentation mentions only about the common 'daisy-chained-devices'
> > >>>>>> property (devicetree/bindings/common-properties.txt). However, in order
> > >>>>>> to try to implement it in the master driver, IMHO, the spi subsystem
> > >>>>>> would need to have a call 'no-operation' to other nodes on the
> > >>>>>> daisy-chain, which are not addressed by the given SPI access. Is there
> > >>>>>> any recommended approach to address this case?
> > >>>>>>
> > >>>>>> Supporting this in a generic way would indeed be nice, as it would mean
> > >>>>>> individual SPI slave drivers no longer have to care about it.
> > >>>>>> However, that may be difficult, as the master needs to known which
> > >>>>>> dummy (no-op) data is safe to shift through the non-addresses SPI slaves.
> > >>>>> In fact, the ultimate solution would be to have it solved at the level
> > >>>>> of the spi subsystem:
> > >>>>>
> > >>>>>   * /spi_device struct/ would contain extra callback which returns msg
> > >>>>>     to be sent for no operation.
> > >>>>>   * spi_device struct would contain a pointer to the list describing the
> > >>>>>     given daisy chain (list of spi_devices on the chain)
> > >>>>>   * /spi_device struct /would contain extra u8 daisy_chain_msg_length
> > >>>>>     indicating length of a command of the addressed device if it's on
> > >>>>>     the daisy chain
> > >>>>>     For example, in case of the ltc2634 device, the regular message
> > >>>>>     consists of 24 bits, but when device is a part of a daisy chain, the
> > >>>>>     messages are 32 bits. This 32 would be stored in
> > >>>>>     /daisy_chain_msg_length./
> > >>>>>   * When /spi_write/ was called (include/linux/spi/spi.h), the
> > >>>>>     /spi_message_init_with_transfer/ would create a msg of length equal
> > >>>>>     to a sum of /daisy_chain_msg_length/ of all devices on the chain.
> > >>>>>     Afterwards, in /spi_message_init_with_transfers/, the actual message
> > >>>>>     would be filled with the command of the addressed device on the
> > >>>>>     chain and no_operation content for all other devices on the chain
> > >>>>>     not being addressed
> > >>>> Sounds good to me.
> > >>>>
> > >>>>>   * I think in such a case, the /daisy-chained-devices /property would
> > >>>>>     be not used, as chains would be build basing on the assigned
> > >>>>>     chipselect (reg property).
> > >>>> So you still have to describe the chain in DT in some way.
> > >>>> As there can be only a single sub node with the same unit address
> > >>>> (= chip select), you probably need a container with that address, which
> > >>>> would contain all devices in the chain, in order (unit addresses 0, 1, ...).
> > >>> Good point. So maybe at the level of the device tree, it could be
> > >>> described like that (based on the spi-cadence example):
> > >>>
> > >>>         spi0: spi@ff040000 {
> > >>>             compatible = "cdns,spi-r1p6";
> > >>>             status = "disabled";
> > >>>             interrupt-parent = <&gic>;
> > >>>             interrupts = <0 19 4>;
> > >>>             reg = <0x0 0xff040000 0x0 0x1000>;
> > >>>             clock-names = "ref_clk", "pclk";
> > >>>             #address-cells = <1>;
> > >>>             #size-cells = <0>;
> > >>>             power-domains = <&zynqmp_firmware PD_SPI_0>;
> > >>>             daisy-chain0 : daisy_chain@0 {
> > >>>                #address-cells = <1>;
> > >>>                #size-cells = <0>;
> > >>>                reg = <0>;
> > >>>                daisy-chained-devices = 2;
> > >>>
> > >>>                dac0: ltc2632@0 {
> > >>>                    compatible = "lltc,ltc2634-l12";
> > >>>                    reg = <0>;
> > >>>                    spi-max-frequency = <1000000>;
> > >>>                };
> > >>>                dac1: ltc2632@1 {
> > >>>                    compatible = "lltc,ltc2634-l12";
> > >>>                    reg = <1>;
> > >>>                    spi-max-frequency = <2000000>;
> > >>>                };
> > >>>            };
> > >>>         };
> > >>         spi0: spi@ff040000 {
> > >>             compatible = "cdns,spi-r1p6";
> > >>             status = "disabled";
> > >>             interrupt-parent = <&gic>;
> > >>             interrupts = <0 19 4>;
> > >>             reg = <0x0 0xff040000 0x0 0x1000>;
> > >>             clock-names = "ref_clk", "pclk";
> > >>             #address-cells = <1>;
> > >>             #size-cells = <0>;
> > >>             power-domains = <&zynqmp_firmware PD_SPI_0>;
> > >>             daisy-chain0 : daisy_chain@0 {
> > >>                #address-cells = <1>;
> > >>                #size-cells = <0>;
> > >>                #daisy-chained-devices = <2>;
> > >
> > > You probably want a proper "compatible" value here instead.
> > > I don't think "#daisy-chained-devices" is needed, it can be derived
> > > from the number of subnodes.

This is not how '#daisy-chained-devices' works either. The chained
devices are represented as a single node and a single driver instance
handles multiple physical devices.

The above looks like mux'ed access rather than creating a 'super'
device. Would you want to program all N chips in one SPI transfer or
it's one device at a time? (We should be careful with the bindings
that we're not encoding that into the binding as that could evolve
with the OS.)


> > compatible = "daisy_chain" or compatible ="simple-bus" would be better?
>
> Not "simple-bus", as this is not a simple memory-mapped bus.
> I'd use something like "spi,daisy-chain", to be validated by RobH.

Okay, but what makes it generic?

What happens with power control of the child devices? While I'd think
the only sane design is shared supplies, resets, clocks, etc. (and
daisy-chained-devices certainly assumes that), it's certainly possible
some cross device control is needed.

> > Both could be caught by of_register_spi_devices to populate the daisy
> > chain. Do you agree that at that level the chip select could be defined?
>
> Or by a separate SPI device driver that matches against "spi,daisy-chain",
> and parse the subnodes.
>
> > The reg properties from the sub-nodes (defining actual spi devices)
> > would be ignored, thus not even needed to be defined.
>
> They are needed to determine the order in the chain.

Agreed, you need something to address a device. A better address might
be the bit position of the device in the chain. Then this could work
for any mixture of devices that support chaining (though you'd need to
know what's a nop for each device).

Rob
