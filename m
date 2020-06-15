Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7131F9999
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 16:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgFOOG1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 10:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgFOOG1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 10:06:27 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7A4C061A0E
        for <linux-spi@vger.kernel.org>; Mon, 15 Jun 2020 07:06:27 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id mb16so17594433ejb.4
        for <linux-spi@vger.kernel.org>; Mon, 15 Jun 2020 07:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastree3d-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=k4C/+/fRiSIFo4IwQCmhnSuHF4dvzSlHbziYd2q10mQ=;
        b=NZ8/p+7g9oqbeQZ9B5d/f0cUBG4RZ75xNZh+kaEgvuG4T0Y5KIcXATW79vy8VHQHki
         e3yWeeWTfYAGO510r+e/ojTL5lsR6vriuVpbvtDVjdR+ND72+xYPQpfGKqBxGFeL9bT5
         Ij8Y67WRfNUbAZUGvhCkSj3ijJ9p1aMn2eXJHYhWB020oNjFgYAdaNOYRDxfG1d7y2Dm
         YEBs3NJ6Ahbf2/Ir6/sw/R8U3c+l+y9vMwl1r3pTPKva9S/GmdfKNxeivNIpw6Q5nSn0
         Q6EtqSpUJ1n622RtCppfZHake6HfduWk35qKczzCkrMWhYD3G7457U6jL2MplvqD0KV+
         gUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=k4C/+/fRiSIFo4IwQCmhnSuHF4dvzSlHbziYd2q10mQ=;
        b=gueoIZHD5cT4XU4UGFPmBjJNLnebK6f4xCeM9g1eZOdj+lkbVyjufO+iC38ui/8E87
         dm675XPAxjNhbKRk3yRbLP/tPjEVtRTzzUXJSInzxP1NGSi/f9y+IstvNWpW/gUC1P2O
         plUtTEYvFTm+17U4Mx5DJb5feOstcO78KfhbhJI2xBa1oQK/4rTRNFk9KoClmN5roIlK
         SsqNKgufol27MOERr7uNVMa8Nap0Gy0AqTl3ygmpcbQ50HK53VsYuPQDln3BBBPVREut
         UNwqgFL8WokyTXNQjOxk4B0jqDjWxIVQudXAdil6XV93ihtqjAsg2oG4l919H9SBaIjS
         W4sw==
X-Gm-Message-State: AOAM532MgTKyll8rld8Rzv2hwrFg95vLLSQDQmFqVeZDHW4nlL6PVFtl
        KSYGIvkBssYcd3RrveeoVr29
X-Google-Smtp-Source: ABdhPJyuz3H0ISp8bnWfVL3IJF5WWI0Mfe4/Pv7NWPYiNpmsG89DIJEsajkV05rWnd4kfW88xq5z4g==
X-Received: by 2002:a17:906:c150:: with SMTP id dp16mr25220134ejc.536.1592229985726;
        Mon, 15 Jun 2020 07:06:25 -0700 (PDT)
Received: from [192.168.33.195] (fastree1.epfl.ch. [192.26.37.52])
        by smtp.gmail.com with ESMTPSA id n17sm1587294ejj.75.2020.06.15.07.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 07:06:25 -0700 (PDT)
From:   Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
X-Google-Original-From: Adrian Fiergolski <Adrian.Fiergolski@fastree3d.com>
Subject: Re: [cadence-spi] daisy chain
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <7cddc1a3-f3a8-37dd-487a-cd2274b7941c@fastree3d.com>
 <CAMuHMdXzErU5z69=2gks5ySutkGw98O6+f7weiuPUp8uqTx63w@mail.gmail.com>
 <9bfce379-1878-e8e5-c452-0e24aa263cbb@fastree3d.com>
 <CAMuHMdWkbVihHqKywxDRW6ucNEySXMa-XEuaVu8Vbx2+kUU-aA@mail.gmail.com>
 <143d0505-33a2-b97f-0088-75def4c1e30d@fastree3d.com>
Message-ID: <a1dd3e24-a393-0013-5ff7-a8e7cc7e0626@fastree3d.com>
Date:   Mon, 15 Jun 2020 16:06:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <143d0505-33a2-b97f-0088-75def4c1e30d@fastree3d.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Sorry for the typo in the example device tree:

On 15.06.2020 15:57, Adrian Fiergolski wrote:
> Hi Geert,
>
> Thank you for the quick reply.
>
> On 15.06.2020 15:07, Geert Uytterhoeven wrote:
>> Hi Adrian,
>>
>> CC devicetree
>>
>> On Mon, Jun 15, 2020 at 3:01 PM Adrian Fiergolski
>> <adrian.fiergolski@fastree3d.com> wrote:
>>> On 13.06.2020 09:33, Geert Uytterhoeven wrote:
>>>> On Fri, Jun 12, 2020 at 6:26 PM Adrian Fiergolski
>>>> <adrian.fiergolski@fastree3d.com> wrote:
>>>> I have a daisy chain of three ltc2634 slaves (iio/dac/ltc2632.c)
>>>> connected to a single chip select of the cadence-spi master. I have the
>>>> impression such a configuration is supported by none of those two
>>>> drivers. I could try to extend both, however, I haven't found any other
>>>> SPI driver, where I could find implementation inspiration. Is it
>>>> supported by kernel?
>>>>
>>>> drivers/gpio/gpio-max3191x.c supports "#daisy-chained-devices".
>>>> drivers/gpio/gpio-74x164.c supports multiple shift registers through the
>>>> "registers-number" DT property.
>>>>
>>>> So both drivers handle this in their SPI slave drivers.
>>>>
>>>> Of course this does not handle the mixed case, i.e. daisy-chaining
>>>> different types of devices.
>>>>
>>>> The documentation mentions only about the common 'daisy-chained-devices'
>>>> property (devicetree/bindings/common-properties.txt). However, in order
>>>> to try to implement it in the master driver, IMHO, the spi subsystem
>>>> would need to have a call 'no-operation' to other nodes on the
>>>> daisy-chain, which are not addressed by the given SPI access. Is there
>>>> any recommended approach to address this case?
>>>>
>>>> Supporting this in a generic way would indeed be nice, as it would mean
>>>> individual SPI slave drivers no longer have to care about it.
>>>> However, that may be difficult, as the master needs to known which
>>>> dummy (no-op) data is safe to shift through the non-addresses SPI slaves.
>>> In fact, the ultimate solution would be to have it solved at the level
>>> of the spi subsystem:
>>>
>>>   * /spi_device struct/ would contain extra callback which returns msg
>>>     to be sent for no operation.
>>>   * spi_device struct would contain a pointer to the list describing the
>>>     given daisy chain (list of spi_devices on the chain)
>>>   * /spi_device struct /would contain extra u8 daisy_chain_msg_length
>>>     indicating length of a command of the addressed device if it's on
>>>     the daisy chain
>>>     For example, in case of the ltc2634 device, the regular message
>>>     consists of 24 bits, but when device is a part of a daisy chain, the
>>>     messages are 32 bits. This 32 would be stored in
>>>     /daisy_chain_msg_length./
>>>   * When /spi_write/ was called (include/linux/spi/spi.h), the
>>>     /spi_message_init_with_transfer/ would create a msg of length equal
>>>     to a sum of /daisy_chain_msg_length/ of all devices on the chain.
>>>     Afterwards, in /spi_message_init_with_transfers/, the actual message
>>>     would be filled with the command of the addressed device on the
>>>     chain and no_operation content for all other devices on the chain
>>>     not being addressed
>> Sounds good to me.
>>
>>>   * I think in such a case, the /daisy-chained-devices /property would
>>>     be not used, as chains would be build basing on the assigned
>>>     chipselect (reg property).
>> So you still have to describe the chain in DT in some way.
>> As there can be only a single sub node with the same unit address
>> (= chip select), you probably need a container with that address, which
>> would contain all devices in the chain, in order (unit addresses 0, 1, ...).
> Good point. So maybe at the level of the device tree, it could be
> described like that (based on the spi-cadence example):
>
>         spi0: spi@ff040000 {
>             compatible = "cdns,spi-r1p6";
>             status = "disabled";
>             interrupt-parent = <&gic>;
>             interrupts = <0 19 4>;
>             reg = <0x0 0xff040000 0x0 0x1000>;
>             clock-names = "ref_clk", "pclk";
>             #address-cells = <1>;
>             #size-cells = <0>;
>             power-domains = <&zynqmp_firmware PD_SPI_0>;
>             daisy-chain0 : daisy_chain@0 {
>                #address-cells = <1>;
>                #size-cells = <0>;
>                reg = <0>;
>                daisy-chained-devices = 2;
>
>                dac0: ltc2632@0 {
>                    compatible = "lltc,ltc2634-l12";
>                    reg = <0>;
>                    spi-max-frequency = <1000000>;
>                };
>                dac1: ltc2632@1 {
>                    compatible = "lltc,ltc2634-l12";
>                    reg = <1>;
>                    spi-max-frequency = <2000000>;
>                };
>            };
>         };

        spi0: spi@ff040000 {
            compatible = "cdns,spi-r1p6";
            status = "disabled";
            interrupt-parent = <&gic>;
            interrupts = <0 19 4>;
            reg = <0x0 0xff040000 0x0 0x1000>;
            clock-names = "ref_clk", "pclk";
            #address-cells = <1>;
            #size-cells = <0>;
            power-domains = <&zynqmp_firmware PD_SPI_0>;
            daisy-chain0 : daisy_chain@0 {
               #address-cells = <1>;
               #size-cells = <0>;
               #daisy-chained-devices = <2>;

               reg = <0>;
               
               dac0: ltc2632@0 {
                   compatible = "lltc,ltc2634-l12";
                   reg = <0>;
                   spi-max-frequency = <1000000>;
               };
               dac1: ltc2632@1 {
                   compatible = "lltc,ltc2634-l12";
                   reg = <1>;
                   spi-max-frequency = <2000000>;
               };
           };
        };

>
> Once a node has daisy-chanied-devices property defined,
> of_register_spi_device (spi.c) will interpret it as a daisy chain. I
> will assume, that for the given chain the lowest frequency of the whole
> chain should be used. When it comes to the mode, as in case of
> incompatibility no much can be done anyway, the mode of the addressed
> spi device will be used.
>
>>> If you agree with the above description, I could try to implement it. Of
>>> course any suggestion are welcome, however, I would like to have a
>>> working solution until end of this week, so I would appreciate an active
>>> feedback. As my SoC works with kernel v4.19, I would implement it for
>>> it, test it, and move it afterwards to the master version (I hope, there
>>> were no big changes in the SPI subsystem, right?).
>> Having something that works by the end of the week sounds doable to.
>> Getting it in shape for upstreaming is a different thing...
> Let's try then. As I wrote earlier, I will try to implement it and test
> it with 4.19. Afterwards, I will share it with you for a general concept
> review. Once no comments, I will try to move it to the master and we can
> start from there the upstreaming process.
>
> Regards,
>
> Adrian
>
>
