Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517B21FADFB
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 12:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgFPK0j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 06:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgFPK0D (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Jun 2020 06:26:03 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5A6C08C5C2
        for <linux-spi@vger.kernel.org>; Tue, 16 Jun 2020 03:25:59 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id e12so13858127eds.2
        for <linux-spi@vger.kernel.org>; Tue, 16 Jun 2020 03:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastree3d-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=uvWiDRpXyXmM380ZrN9zlV0oOXaMR/3vOUKFI6y1X4s=;
        b=omUo107sz4rEVpoLq37pLdyMWkehlEpMoqjlJNnvSwwEjdRQcjQEnw997FE8bflTuP
         WQbpt6Q0Q4MNkoDybpTKC4RJYNL020+Y8K47ZbPTPswE3aoFP/J7WsOhJ+iGOOtXtqHm
         sj1wAqyoxOiuZlRXjqYuU7Ns9hKgZ6KDloltHZwYvLeWSrlBDqZEUyd7bAiWUoMMhFXM
         iMwXWpgPKI+S+enDFxD677Pw0TWLQoLz1R5uv+i3cdgjJFjcba/EgFl0D2JjMAWFaGKn
         pTI5m0ULduJ/07nsFnGsbyXZ7OSSTa/juJwEelUztBtJF6c51nSzp6h0sVSMRr9LCsax
         Kejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uvWiDRpXyXmM380ZrN9zlV0oOXaMR/3vOUKFI6y1X4s=;
        b=H387TpMnMg7ezz7rTNzoMf8l5XFy2vrzD2ZsxI81xHt3f8Z9mAFwpnckf48lGV845W
         EQKauDwHLqTcN+gmDBkwJ2WwGJVaHIfUOq7+KThtNoo6oJs3hHiO0P3K4yUJDCINORPM
         h48dYe/NjFRMklVKd9GvFy2lE9Y1e1Fs4NqbNpg6N+C/Ha5qAVe+tEANFWxg6Mnrn2Ut
         dQyz5aw+NReYvOZO+Ev9Cx2tIygXqZtaR9fFqr7qUo8bP6kZgs2q5B9Zn6Gdft9B2oJD
         M2gAcRxu3sEjxdzyxjnT1mty3qruUi1BlB8ai5+ozJ70ol1TnNWrNZovQbm6TQeMSqPl
         +JAQ==
X-Gm-Message-State: AOAM532hY/FjS9xfZeXacciAiLRE8LYwNKkZH99O1VAp1unnW3r9s8P/
        EOA9S7P5L3qmb3OT8x/PUUqhMClbKA==
X-Google-Smtp-Source: ABdhPJzfQjX3Lir3Vo2rjjcSCHcSDhqDcZqB2Z9+UlZYt0fJcY4gMrh+oFOfj3B/sndP21M0h8zCSQ==
X-Received: by 2002:a50:f289:: with SMTP id f9mr1846629edm.188.1592303157695;
        Tue, 16 Jun 2020 03:25:57 -0700 (PDT)
Received: from [192.168.33.195] (fastree1.epfl.ch. [192.26.37.52])
        by smtp.gmail.com with ESMTPSA id l8sm11012270ejz.52.2020.06.16.03.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 03:25:57 -0700 (PDT)
From:   Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
X-Google-Original-From: Adrian Fiergolski <Adrian.Fiergolski@fastree3d.com>
Subject: Re: [cadence-spi] daisy chain
To:     Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <7cddc1a3-f3a8-37dd-487a-cd2274b7941c@fastree3d.com>
 <CAMuHMdXzErU5z69=2gks5ySutkGw98O6+f7weiuPUp8uqTx63w@mail.gmail.com>
 <9bfce379-1878-e8e5-c452-0e24aa263cbb@fastree3d.com>
 <CAMuHMdWkbVihHqKywxDRW6ucNEySXMa-XEuaVu8Vbx2+kUU-aA@mail.gmail.com>
 <143d0505-33a2-b97f-0088-75def4c1e30d@fastree3d.com>
 <a1dd3e24-a393-0013-5ff7-a8e7cc7e0626@fastree3d.com>
 <CAMuHMdWPo6xDMipBg2noSOD3trYJjifDbSf-krtgPkA-XdbXZg@mail.gmail.com>
 <4311cc0a-016d-1a24-10f9-9dccc28ddd43@fastree3d.com>
 <CAMuHMdVHqNi9peLm8Lf+uSXDjzJP6eB9Kz1oM-Mr8RQ62+1uZg@mail.gmail.com>
 <CAL_JsqLuo4jB6B8eqwm3YQ1gxxndwC6o23=+tm0dugPcGxm6ww@mail.gmail.com>
Message-ID: <335c3afa-dcab-12e1-a9f4-877a0a26c1b1@fastree3d.com>
Date:   Tue, 16 Jun 2020 12:25:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLuo4jB6B8eqwm3YQ1gxxndwC6o23=+tm0dugPcGxm6ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Geert and Rob,

Thank you for your comments.

On 16.06.2020 00:22, Rob Herring wrote:
> On Mon, Jun 15, 2020 at 3:30 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> Hi Adrian,
>>
>> On Mon, Jun 15, 2020 at 6:05 PM Adrian Fiergolski
>> <adrian.fiergolski@fastree3d.com> wrote:
>>> On 15.06.2020 16:40, Geert Uytterhoeven wrote:
>>>> On Mon, Jun 15, 2020 at 4:06 PM Adrian Fiergolski
>>>> <adrian.fiergolski@fastree3d.com> wrote:
>>>>> Sorry for the typo in the example device tree:
>>>>>
>>>>> On 15.06.2020 15:57, Adrian Fiergolski wrote:
>>>>>> On 15.06.2020 15:07, Geert Uytterhoeven wrote:
>>>>>>> On Mon, Jun 15, 2020 at 3:01 PM Adrian Fiergolski
>>>>>>> <adrian.fiergolski@fastree3d.com> wrote:
>>>>>>>> On 13.06.2020 09:33, Geert Uytterhoeven wrote:
>>>>>>>>> On Fri, Jun 12, 2020 at 6:26 PM Adrian Fiergolski
>>>>>>>>> <adrian.fiergolski@fastree3d.com> wrote:
>>>>>>>>> I have a daisy chain of three ltc2634 slaves (iio/dac/ltc2632.c)
>>>>>>>>> connected to a single chip select of the cadence-spi master. I have the
>>>>>>>>> impression such a configuration is supported by none of those two
>>>>>>>>> drivers. I could try to extend both, however, I haven't found any other
>>>>>>>>> SPI driver, where I could find implementation inspiration. Is it
>>>>>>>>> supported by kernel?
>>>>>>>>>
>>>>>>>>> drivers/gpio/gpio-max3191x.c supports "#daisy-chained-devices".
>>>>>>>>> drivers/gpio/gpio-74x164.c supports multiple shift registers through the
>>>>>>>>> "registers-number" DT property.
>>>>>>>>>
>>>>>>>>> So both drivers handle this in their SPI slave drivers.
>>>>>>>>>
>>>>>>>>> Of course this does not handle the mixed case, i.e. daisy-chaining
>>>>>>>>> different types of devices.
>>>>>>>>>
>>>>>>>>> The documentation mentions only about the common 'daisy-chained-devices'
>>>>>>>>> property (devicetree/bindings/common-properties.txt). However, in order
>>>>>>>>> to try to implement it in the master driver, IMHO, the spi subsystem
>>>>>>>>> would need to have a call 'no-operation' to other nodes on the
>>>>>>>>> daisy-chain, which are not addressed by the given SPI access. Is there
>>>>>>>>> any recommended approach to address this case?
>>>>>>>>>
>>>>>>>>> Supporting this in a generic way would indeed be nice, as it would mean
>>>>>>>>> individual SPI slave drivers no longer have to care about it.
>>>>>>>>> However, that may be difficult, as the master needs to known which
>>>>>>>>> dummy (no-op) data is safe to shift through the non-addresses SPI slaves.
>>>>>>>> In fact, the ultimate solution would be to have it solved at the level
>>>>>>>> of the spi subsystem:
>>>>>>>>
>>>>>>>>   * /spi_device struct/ would contain extra callback which returns msg
>>>>>>>>     to be sent for no operation.
>>>>>>>>   * spi_device struct would contain a pointer to the list describing the
>>>>>>>>     given daisy chain (list of spi_devices on the chain)
>>>>>>>>   * /spi_device struct /would contain extra u8 daisy_chain_msg_length
>>>>>>>>     indicating length of a command of the addressed device if it's on
>>>>>>>>     the daisy chain
>>>>>>>>     For example, in case of the ltc2634 device, the regular message
>>>>>>>>     consists of 24 bits, but when device is a part of a daisy chain, the
>>>>>>>>     messages are 32 bits. This 32 would be stored in
>>>>>>>>     /daisy_chain_msg_length./
>>>>>>>>   * When /spi_write/ was called (include/linux/spi/spi.h), the
>>>>>>>>     /spi_message_init_with_transfer/ would create a msg of length equal
>>>>>>>>     to a sum of /daisy_chain_msg_length/ of all devices on the chain.
>>>>>>>>     Afterwards, in /spi_message_init_with_transfers/, the actual message
>>>>>>>>     would be filled with the command of the addressed device on the
>>>>>>>>     chain and no_operation content for all other devices on the chain
>>>>>>>>     not being addressed
>>>>>>> Sounds good to me.
>>>>>>>
>>>>>>>>   * I think in such a case, the /daisy-chained-devices /property would
>>>>>>>>     be not used, as chains would be build basing on the assigned
>>>>>>>>     chipselect (reg property).
>>>>>>> So you still have to describe the chain in DT in some way.
>>>>>>> As there can be only a single sub node with the same unit address
>>>>>>> (= chip select), you probably need a container with that address, which
>>>>>>> would contain all devices in the chain, in order (unit addresses 0, 1, ...).
>>>>>> Good point. So maybe at the level of the device tree, it could be
>>>>>> described like that (based on the spi-cadence example):
>>>>>>
>>>>>>         spi0: spi@ff040000 {
>>>>>>             compatible = "cdns,spi-r1p6";
>>>>>>             status = "disabled";
>>>>>>             interrupt-parent = <&gic>;
>>>>>>             interrupts = <0 19 4>;
>>>>>>             reg = <0x0 0xff040000 0x0 0x1000>;
>>>>>>             clock-names = "ref_clk", "pclk";
>>>>>>             #address-cells = <1>;
>>>>>>             #size-cells = <0>;
>>>>>>             power-domains = <&zynqmp_firmware PD_SPI_0>;
>>>>>>             daisy-chain0 : daisy_chain@0 {
>>>>>>                #address-cells = <1>;
>>>>>>                #size-cells = <0>;
>>>>>>                reg = <0>;
>>>>>>                daisy-chained-devices = 2;
>>>>>>
>>>>>>                dac0: ltc2632@0 {
>>>>>>                    compatible = "lltc,ltc2634-l12";
>>>>>>                    reg = <0>;
>>>>>>                    spi-max-frequency = <1000000>;
>>>>>>                };
>>>>>>                dac1: ltc2632@1 {
>>>>>>                    compatible = "lltc,ltc2634-l12";
>>>>>>                    reg = <1>;
>>>>>>                    spi-max-frequency = <2000000>;
>>>>>>                };
>>>>>>            };
>>>>>>         };
>>>>>         spi0: spi@ff040000 {
>>>>>             compatible = "cdns,spi-r1p6";
>>>>>             status = "disabled";
>>>>>             interrupt-parent = <&gic>;
>>>>>             interrupts = <0 19 4>;
>>>>>             reg = <0x0 0xff040000 0x0 0x1000>;
>>>>>             clock-names = "ref_clk", "pclk";
>>>>>             #address-cells = <1>;
>>>>>             #size-cells = <0>;
>>>>>             power-domains = <&zynqmp_firmware PD_SPI_0>;
>>>>>             daisy-chain0 : daisy_chain@0 {
>>>>>                #address-cells = <1>;
>>>>>                #size-cells = <0>;
>>>>>                #daisy-chained-devices = <2>;
>>>> You probably want a proper "compatible" value here instead.
>>>> I don't think "#daisy-chained-devices" is needed, it can be derived
>>>> from the number of subnodes.
> This is not how '#daisy-chained-devices' works either. The chained
> devices are represented as a single node and a single driver instance
> handles multiple physical devices.
>
> The above looks like mux'ed access rather than creating a 'super'
> device. Would you want to program all N chips in one SPI transfer or
> it's one device at a time? (We should be careful with the bindings
> that we're not encoding that into the binding as that could evolve
> with the OS.)

Well, I think the described concept of the daisy chain doesn't apply
here then. In principle, we can have different SPI devices, where each
is served by a different driver. Together, they create a long register
through which data is shifted. IMHO, the fact that the given device is
on the daisy chain with other devices should be transparent for its SPI
device driver and handled at the level of the SPI subsystem: at SPI
write/read stage, the SPI subsystem would combine message of a addressed
device with the specific no-operation pattern of all other devices being
present on the chain (each device may have its specific no-operation
pattern).

At the moment, I wouldn't try to address a few SPI devices in a single
access.

As you can see, it's no really a mux access like in case of e.g. I2C:
there, we have a physical device performing multiplexing. Once the I2C
bus is switched, no extra effort is required in communication between
the I2C master and I2C device (slave).

>>> compatible = "daisy_chain" or compatible ="simple-bus" would be better?
>> Not "simple-bus", as this is not a simple memory-mapped bus.
>> I'd use something like "spi,daisy-chain", to be validated by RobH.
> Okay, but what makes it generic?
>
> What happens with power control of the child devices? While I'd think
> the only sane design is shared supplies, resets, clocks, etc. (and
> daisy-chained-devices certainly assumes that), it's certainly possible
> some cross device control is needed.
>
>>> Both could be caught by of_register_spi_devices to populate the daisy
>>> chain. Do you agree that at that level the chip select could be defined?
>> Or by a separate SPI device driver that matches against "spi,daisy-chain",
>> and parse the subnodes.

I have been thinking about it and came to a similar idea. However, I
didn't find a straightforward way to associate the SPI devices with the
abstract daisy-chain device which would then eventually be linked with
the SPI controller. It would a simple and clean implementation then: SPI
devices at write/read would call daisy-chain device which would create a
full message and pass it to SPI controller. The issue is that the SPI
device requires for all calls SPI controller. It implies that SPI
daisy-chain would need to be SPI controller as well. However, I think
currently the SPI concept in the kernel is fixed: SPI controller <-> SPI
device and there is no place to implement SPI controller <-> SPI
controller (daisy-chain device) <-> SPI device. Any suggestions on how
to address it?

>>> The reg properties from the sub-nodes (defining actual spi devices)
>>> would be ignored, thus not even needed to be defined.
>> They are needed to determine the order in the chain.
> Agreed, you need something to address a device. A better address might
> be the bit position of the device in the chain. Then this could work
> for any mixture of devices that support chaining (though you'd need to
> know what's a nop for each device).

Well, the idea was that the daisy chain will be populated basing on all
sub-nodes and their order in the device tree. If we go for a reg
numbering the device in the chain, I think we need then
'#daisy-chained-devices' as well, such kernel knows a priori the length
of the chain and can issue an error in case some reg values are missing
on a given chain.

Regards,

Adrian

