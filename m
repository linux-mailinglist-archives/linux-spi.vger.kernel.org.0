Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17797210CA5
	for <lists+linux-spi@lfdr.de>; Wed,  1 Jul 2020 15:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbgGANra (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Jul 2020 09:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730783AbgGANr3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 Jul 2020 09:47:29 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32E6C08C5C1
        for <linux-spi@vger.kernel.org>; Wed,  1 Jul 2020 06:47:28 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id g20so19580381edm.4
        for <linux-spi@vger.kernel.org>; Wed, 01 Jul 2020 06:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastree3d-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=IZqGaC7UKFJKxIh1xknYzBl/gRj9Vi1cRPqUNrvuIIs=;
        b=CnX9d9UPA+ds4R1QvEnQr2c+qShya3aROm6KxtjWDe+Gcp6X+8U8KrfShn5tSNY0Ry
         R57WQEesqpuIqg5L2D5guuaOHOdGidYIBHG3PN9Hl24M1U81dlSiUaI0jOwOlRM6YjfL
         ztrEQfMtCtCAowFo9XG/LkMccHHlgUuqvbuJ9uQM2NxKqO1EXzoN/8EHZaAWohJJyJY6
         qZVsTtjqD/ZU6ZtKh9mSIv2P/Qk75p/etiRijyYY4nIpBAfuw4djxOIeVWm8rghlUJ9s
         xNzAHJ0YFyRNiR6X9ozksLM5jP+u55APPvcVAEMil5Mnr0tt1TK+LFwRE6dfIdpwtyfO
         YBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=IZqGaC7UKFJKxIh1xknYzBl/gRj9Vi1cRPqUNrvuIIs=;
        b=biPYLrLKpunmn8HCGPs2GA3qxVBw8O9t8XH90r4KD1UrTUK1IvNF+Yn4Zohl2kcyJp
         AaCe5u/Qi08vWCezIBn0KRP1WqFrvYr29n5Opbhxlo9vzMdwWGHbS1KVadkxkJsvqKwn
         FnPGOsZwDYuw26tmZ/WnvZlT42b8HScSm4orYa6xCutUvHfoke+Ko/WIL0qAVWXfn8v3
         B6FfiOoAN632211Gqe9UvBoGp7+So9QdKYNGEUD+u65svwwfaoQdNDF4EYb/poXfkkcx
         nx2g+z+lzSj84V6Fd3RBmVXJESEGvTo0y4l3n4979amHSkjJH2ZSpSmZXuv6NupePtBc
         97+g==
X-Gm-Message-State: AOAM533pM0D8GQ/Y/DkttWYYWg+PgNEwbc8D7JeGp2u2z6GY8kBkWjQ1
        ce1bE8uVpeCP+4RpsYnskJpx
X-Google-Smtp-Source: ABdhPJzw3DT+im3e+9kQoZpjXa9ePXb1oNX+lR0BvipjFZBQp7jSU6kdzDUfHekPDwcT5AghXzcTpg==
X-Received: by 2002:aa7:da56:: with SMTP id w22mr30276631eds.124.1593611243780;
        Wed, 01 Jul 2020 06:47:23 -0700 (PDT)
Received: from [192.168.33.195] (fastree1.epfl.ch. [192.26.37.52])
        by smtp.gmail.com with ESMTPSA id e8sm4643490eja.101.2020.07.01.06.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 06:47:23 -0700 (PDT)
From:   Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
X-Google-Original-From: Adrian Fiergolski <Adrian.Fiergolski@fastree3d.com>
Subject: Re: SPI daisy chain support
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
 <335c3afa-dcab-12e1-a9f4-877a0a26c1b1@fastree3d.com>
 <81b8393b-3eee-e5a9-3d29-506556852d81@fastree3d.com>
Message-ID: <e912805a-6bb5-2436-6606-00f8816e7715@fastree3d.com>
Date:   Wed, 1 Jul 2020 15:47:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <81b8393b-3eee-e5a9-3d29-506556852d81@fastree3d.com>
Content-Type: multipart/mixed;
 boundary="------------827C1265C8ED8A54F21949C7"
Content-Language: en-GB
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This is a multi-part message in MIME format.
--------------827C1265C8ED8A54F21949C7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi All,

I have implemented the SPI daisy chain support for kernel 4.19. I am
enclosing the patch.

The implementation is transparent for the SPI devices and doesn't
require their modifications. It is based on a virtual SPI device
(spi-daisy_chain) and defines two required device tree properties
('spi-daisy-chain-len' and 'spi-daisy-chain-noop') and one optional
('spi-daisy-chain-bits_per_word'). It has been tested on hardware with a
chain of three ltc2694 devices. I am able to successfully control them.
Unfortunately, I can't confirm that readout works properly

If you agree with this daisy-chain concept, in order to upstream this
feature, I am willing to merge it with the master (could you navigate me
to branch, repository against which I should do it?).

Regards,

Adrian

On 17.06.2020 14:33, Adrian Fiergolski wrote:
> Hi All,
>
> A quick update: I have started implementation taking into account most
> of the points from our discussion (a separate spi,daisy-chain spi
> device, single device addressed at once, etc.). I have realized that the
> daisy-chain device doesn't need to be a SPI controller and information
> about the chain can be stored in the spi_device struct and then handled
> by the SPI subsystem. Once I have a working implementation, I will share
> it with you for a review.
>
> Regards,
>
> Adrian
>
> On 16.06.2020 12:25, Adrian Fiergolski wrote:
>> Hi Geert and Rob,
>>
>> Thank you for your comments.
>>
>> On 16.06.2020 00:22, Rob Herring wrote:
>>> On Mon, Jun 15, 2020 at 3:30 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>> Hi Adrian,
>>>>
>>>> On Mon, Jun 15, 2020 at 6:05 PM Adrian Fiergolski
>>>> <adrian.fiergolski@fastree3d.com> wrote:
>>>>> On 15.06.2020 16:40, Geert Uytterhoeven wrote:
>>>>>> On Mon, Jun 15, 2020 at 4:06 PM Adrian Fiergolski
>>>>>> <adrian.fiergolski@fastree3d.com> wrote:
>>>>>>> Sorry for the typo in the example device tree:
>>>>>>>
>>>>>>> On 15.06.2020 15:57, Adrian Fiergolski wrote:
>>>>>>>> On 15.06.2020 15:07, Geert Uytterhoeven wrote:
>>>>>>>>> On Mon, Jun 15, 2020 at 3:01 PM Adrian Fiergolski
>>>>>>>>> <adrian.fiergolski@fastree3d.com> wrote:
>>>>>>>>>> On 13.06.2020 09:33, Geert Uytterhoeven wrote:
>>>>>>>>>>> On Fri, Jun 12, 2020 at 6:26 PM Adrian Fiergolski
>>>>>>>>>>> <adrian.fiergolski@fastree3d.com> wrote:
>>>>>>>>>>> I have a daisy chain of three ltc2634 slaves (iio/dac/ltc2632.c)
>>>>>>>>>>> connected to a single chip select of the cadence-spi master. I have the
>>>>>>>>>>> impression such a configuration is supported by none of those two
>>>>>>>>>>> drivers. I could try to extend both, however, I haven't found any other
>>>>>>>>>>> SPI driver, where I could find implementation inspiration. Is it
>>>>>>>>>>> supported by kernel?
>>>>>>>>>>>
>>>>>>>>>>> drivers/gpio/gpio-max3191x.c supports "#daisy-chained-devices".
>>>>>>>>>>> drivers/gpio/gpio-74x164.c supports multiple shift registers through the
>>>>>>>>>>> "registers-number" DT property.
>>>>>>>>>>>
>>>>>>>>>>> So both drivers handle this in their SPI slave drivers.
>>>>>>>>>>>
>>>>>>>>>>> Of course this does not handle the mixed case, i.e. daisy-chaining
>>>>>>>>>>> different types of devices.
>>>>>>>>>>>
>>>>>>>>>>> The documentation mentions only about the common 'daisy-chained-devices'
>>>>>>>>>>> property (devicetree/bindings/common-properties.txt). However, in order
>>>>>>>>>>> to try to implement it in the master driver, IMHO, the spi subsystem
>>>>>>>>>>> would need to have a call 'no-operation' to other nodes on the
>>>>>>>>>>> daisy-chain, which are not addressed by the given SPI access. Is there
>>>>>>>>>>> any recommended approach to address this case?
>>>>>>>>>>>
>>>>>>>>>>> Supporting this in a generic way would indeed be nice, as it would mean
>>>>>>>>>>> individual SPI slave drivers no longer have to care about it.
>>>>>>>>>>> However, that may be difficult, as the master needs to known which
>>>>>>>>>>> dummy (no-op) data is safe to shift through the non-addresses SPI slaves.
>>>>>>>>>> In fact, the ultimate solution would be to have it solved at the level
>>>>>>>>>> of the spi subsystem:
>>>>>>>>>>
>>>>>>>>>>   * /spi_device struct/ would contain extra callback which returns msg
>>>>>>>>>>     to be sent for no operation.
>>>>>>>>>>   * spi_device struct would contain a pointer to the list describing the
>>>>>>>>>>     given daisy chain (list of spi_devices on the chain)
>>>>>>>>>>   * /spi_device struct /would contain extra u8 daisy_chain_msg_length
>>>>>>>>>>     indicating length of a command of the addressed device if it's on
>>>>>>>>>>     the daisy chain
>>>>>>>>>>     For example, in case of the ltc2634 device, the regular message
>>>>>>>>>>     consists of 24 bits, but when device is a part of a daisy chain, the
>>>>>>>>>>     messages are 32 bits. This 32 would be stored in
>>>>>>>>>>     /daisy_chain_msg_length./
>>>>>>>>>>   * When /spi_write/ was called (include/linux/spi/spi.h), the
>>>>>>>>>>     /spi_message_init_with_transfer/ would create a msg of length equal
>>>>>>>>>>     to a sum of /daisy_chain_msg_length/ of all devices on the chain.
>>>>>>>>>>     Afterwards, in /spi_message_init_with_transfers/, the actual message
>>>>>>>>>>     would be filled with the command of the addressed device on the
>>>>>>>>>>     chain and no_operation content for all other devices on the chain
>>>>>>>>>>     not being addressed
>>>>>>>>> Sounds good to me.
>>>>>>>>>
>>>>>>>>>>   * I think in such a case, the /daisy-chained-devices /property would
>>>>>>>>>>     be not used, as chains would be build basing on the assigned
>>>>>>>>>>     chipselect (reg property).
>>>>>>>>> So you still have to describe the chain in DT in some way.
>>>>>>>>> As there can be only a single sub node with the same unit address
>>>>>>>>> (= chip select), you probably need a container with that address, which
>>>>>>>>> would contain all devices in the chain, in order (unit addresses 0, 1, ...).
>>>>>>>> Good point. So maybe at the level of the device tree, it could be
>>>>>>>> described like that (based on the spi-cadence example):
>>>>>>>>
>>>>>>>>         spi0: spi@ff040000 {
>>>>>>>>             compatible = "cdns,spi-r1p6";
>>>>>>>>             status = "disabled";
>>>>>>>>             interrupt-parent = <&gic>;
>>>>>>>>             interrupts = <0 19 4>;
>>>>>>>>             reg = <0x0 0xff040000 0x0 0x1000>;
>>>>>>>>             clock-names = "ref_clk", "pclk";
>>>>>>>>             #address-cells = <1>;
>>>>>>>>             #size-cells = <0>;
>>>>>>>>             power-domains = <&zynqmp_firmware PD_SPI_0>;
>>>>>>>>             daisy-chain0 : daisy_chain@0 {
>>>>>>>>                #address-cells = <1>;
>>>>>>>>                #size-cells = <0>;
>>>>>>>>                reg = <0>;
>>>>>>>>                daisy-chained-devices = 2;
>>>>>>>>
>>>>>>>>                dac0: ltc2632@0 {
>>>>>>>>                    compatible = "lltc,ltc2634-l12";
>>>>>>>>                    reg = <0>;
>>>>>>>>                    spi-max-frequency = <1000000>;
>>>>>>>>                };
>>>>>>>>                dac1: ltc2632@1 {
>>>>>>>>                    compatible = "lltc,ltc2634-l12";
>>>>>>>>                    reg = <1>;
>>>>>>>>                    spi-max-frequency = <2000000>;
>>>>>>>>                };
>>>>>>>>            };
>>>>>>>>         };
>>>>>>>         spi0: spi@ff040000 {
>>>>>>>             compatible = "cdns,spi-r1p6";
>>>>>>>             status = "disabled";
>>>>>>>             interrupt-parent = <&gic>;
>>>>>>>             interrupts = <0 19 4>;
>>>>>>>             reg = <0x0 0xff040000 0x0 0x1000>;
>>>>>>>             clock-names = "ref_clk", "pclk";
>>>>>>>             #address-cells = <1>;
>>>>>>>             #size-cells = <0>;
>>>>>>>             power-domains = <&zynqmp_firmware PD_SPI_0>;
>>>>>>>             daisy-chain0 : daisy_chain@0 {
>>>>>>>                #address-cells = <1>;
>>>>>>>                #size-cells = <0>;
>>>>>>>                #daisy-chained-devices = <2>;
>>>>>> You probably want a proper "compatible" value here instead.
>>>>>> I don't think "#daisy-chained-devices" is needed, it can be derived
>>>>>> from the number of subnodes.
>>> This is not how '#daisy-chained-devices' works either. The chained
>>> devices are represented as a single node and a single driver instance
>>> handles multiple physical devices.
>>>
>>> The above looks like mux'ed access rather than creating a 'super'
>>> device. Would you want to program all N chips in one SPI transfer or
>>> it's one device at a time? (We should be careful with the bindings
>>> that we're not encoding that into the binding as that could evolve
>>> with the OS.)
>> Well, I think the described concept of the daisy chain doesn't apply
>> here then. In principle, we can have different SPI devices, where each
>> is served by a different driver. Together, they create a long register
>> through which data is shifted. IMHO, the fact that the given device is
>> on the daisy chain with other devices should be transparent for its SPI
>> device driver and handled at the level of the SPI subsystem: at SPI
>> write/read stage, the SPI subsystem would combine message of a addressed
>> device with the specific no-operation pattern of all other devices being
>> present on the chain (each device may have its specific no-operation
>> pattern).
>>
>> At the moment, I wouldn't try to address a few SPI devices in a single
>> access.
>>
>> As you can see, it's no really a mux access like in case of e.g. I2C:
>> there, we have a physical device performing multiplexing. Once the I2C
>> bus is switched, no extra effort is required in communication between
>> the I2C master and I2C device (slave).
>>
>>>>> compatible = "daisy_chain" or compatible ="simple-bus" would be better?
>>>> Not "simple-bus", as this is not a simple memory-mapped bus.
>>>> I'd use something like "spi,daisy-chain", to be validated by RobH.
>>> Okay, but what makes it generic?
>>>
>>> What happens with power control of the child devices? While I'd think
>>> the only sane design is shared supplies, resets, clocks, etc. (and
>>> daisy-chained-devices certainly assumes that), it's certainly possible
>>> some cross device control is needed.
>>>
>>>>> Both could be caught by of_register_spi_devices to populate the daisy
>>>>> chain. Do you agree that at that level the chip select could be defined?
>>>> Or by a separate SPI device driver that matches against "spi,daisy-chain",
>>>> and parse the subnodes.
>> I have been thinking about it and came to a similar idea. However, I
>> didn't find a straightforward way to associate the SPI devices with the
>> abstract daisy-chain device which would then eventually be linked with
>> the SPI controller. It would a simple and clean implementation then: SPI
>> devices at write/read would call daisy-chain device which would create a
>> full message and pass it to SPI controller. The issue is that the SPI
>> device requires for all calls SPI controller. It implies that SPI
>> daisy-chain would need to be SPI controller as well. However, I think
>> currently the SPI concept in the kernel is fixed: SPI controller <-> SPI
>> device and there is no place to implement SPI controller <-> SPI
>> controller (daisy-chain device) <-> SPI device. Any suggestions on how
>> to address it?
>>
>>>>> The reg properties from the sub-nodes (defining actual spi devices)
>>>>> would be ignored, thus not even needed to be defined.
>>>> They are needed to determine the order in the chain.
>>> Agreed, you need something to address a device. A better address might
>>> be the bit position of the device in the chain. Then this could work
>>> for any mixture of devices that support chaining (though you'd need to
>>> know what's a nop for each device).
>> Well, the idea was that the daisy chain will be populated basing on all
>> sub-nodes and their order in the device tree. If we go for a reg
>> numbering the device in the chain, I think we need then
>> '#daisy-chained-devices' as well, such kernel knows a priori the length
>> of the chain and can issue an error in case some reg values are missing
>> on a given chain.
>>
>> Regards,
>>
>> Adrian
>>

--------------827C1265C8ED8A54F21949C7
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Add-SPI-daisy-chain-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Add-SPI-daisy-chain-support.patch"

From d0af2938bafc81ca2d56a92db7647e1e5a454205 Mon Sep 17 00:00:00 2001
From: Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
Date: Fri, 19 Jun 2020 17:10:21 +0200
Subject: [PATCH] Add SPI daisy chain support.

Signed-off-by: Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
---
 .../bindings/spi/spi-daisy_chain.txt          |  62 +++
 Documentation/spi/00-INDEX                    |   2 +
 drivers/spi/Kconfig                           |   5 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-daisy_chain.c                 | 419 ++++++++++++++++++
 drivers/spi/spi.c                             |  65 ++-
 include/linux/spi/spi-daisy_chain.h           |  32 ++
 include/linux/spi/spi.h                       |  15 +
 10 files changed, 620 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-daisy_chain.txt
 create mode 100644 drivers/spi/spi-daisy_chain.c
 create mode 100644 include/linux/spi/spi-daisy_chain.h

diff --git a/Documentation/devicetree/bindings/spi/spi-daisy_chain.txt b/Documentation/devicetree/bindings/spi/spi-daisy_chain.txt
new file mode 100644
index 000000000000..26e1d2dc4992
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-daisy_chain.txt
@@ -0,0 +1,62 @@
+spi-daisy_chain : The driver handling SPI daisy chains
+
+Required properties for the daisy chain virtual device:
+- compatible		: Should be "spi,daisy_chain"
+- reg			: Chip select assigned to the chain
+
+Required properties for the SPI devices on a common SPI chain (nodes of
+daisy_chain):
+- spi-daisy-chain-len  : Length (in bytes) of the SPI transfer,
+  		         when the SPI device is part of a device chain.
+- spi-daisy-chain-noop : Byte string of no-operation command which should
+  		         be send when device is not addressed during the
+			 given SPI transfer
+
+Optional properties for the SPI devices on a common SPI chain (nodes of
+daisy_chain):
+- spi-daisy-chain-bits_per_word : no-operation transfers involve
+                                  one or more words; word sizes like
+				  eight or 12 bits are common.
+				  In-memory wordsizes are powers of two
+				  bytes (e.g. 20 bit samples use 32 bits).
+				  If not defined, it is assumed to be 8.
+
+Example:
+
+&spi0 {
+	status = "okay";
+	num-cs = <2>;
+	is-decoded-cs = <0>;
+	
+	daisy_chain0: daisy_chain@0 {
+	        compatible = "spi,daisy_chain";
+		spi-max-frequency = <10000000>;
+		reg = <0>;
+
+		dac0: ltc2632@0 {
+	              compatible = "lltc,ltc2634-l12";
+		      spi-daisy-chain-len = <4>;
+		      spi-daisy-chain-noop = [00 F0 00 00];
+		};
+		dac1: ltc2632@1 {
+	              compatible = "lltc,ltc2634-l12";
+		      spi-daisy-chain-len = <4>;
+		      spi-daisy-chain-noop = [00 F0 00 00];
+		};
+		dac2: ltc2632@2 {
+	              compatible = "lltc,ltc2634-l12";
+		      spi-daisy-chain-len = <4>;
+		      spi-daisy-chain-noop = [00 F0 00 00];
+		};
+	};
+};
+
+The virtual daisy chain device is represented as a regular SPI device. Its nodes
+define physical devices available on the chain. The order of the nodes defines
+the order of the physical devices on the chain: MOSI pin of a device represented
+by first node is the last one on the MOSI daisy chain. The daisy-chain
+functionality is transparent to the drivers of physical devices on the
+chain. All nodes share SPI mode, chip select and max speed of the virtual daisy
+chain device. Once one of the physical device is accessed, the spi-daisy_chain
+driver combines this data with no-operation commands of all other devices on the
+chain.
diff --git a/Documentation/spi/00-INDEX b/Documentation/spi/00-INDEX
index 8e4bb17d70eb..457aec3e68ec 100644
--- a/Documentation/spi/00-INDEX
+++ b/Documentation/spi/00-INDEX
@@ -12,5 +12,7 @@ spi-lm70llp
 	- Connecting an LM70-LLP sensor to the kernel via the SPI subsys.
 spi-sc18is602
 	- NXP SC18IS602/603 I2C-bus to SPI bridge
+spi-daisy_chain
+	- Daisy chain driver
 spi-summary
 	- (Linux) SPI overview. If unsure about SPI or SPI in Linux, start here.
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 2608d941ee03..0d3ea783f305 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -54,6 +54,11 @@ config SPI_MEM
 	  This extension is meant to simplify interaction with SPI memories
 	  by providing a high-level interface to send memory-like commands.
 
+config SPI_DAISY_CHAIN
+	bool "SPI daisy chain support"
+	help
+	  Enable this option if you want to enable the SPI daist chain support.
+
 comment "SPI Master Controller Drivers"
 
 config SPI_ALTERA
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index c991bb287567..c4a93b5ae4cb 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -9,6 +9,7 @@ ccflags-$(CONFIG_SPI_DEBUG) := -DDEBUG
 # config declarations into driver model code
 obj-$(CONFIG_SPI_MASTER)		+= spi.o
 obj-$(CONFIG_SPI_MEM)			+= spi-mem.o
+obj-$(CONFIG_SPI_DAISY_CHAIN)		+= spi-daisy_chain.o
 obj-$(CONFIG_SPI_SPIDEV)		+= spidev.o
 obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
 
diff --git a/drivers/spi/spi-daisy_chain.c b/drivers/spi/spi-daisy_chain.c
new file mode 100644
index 000000000000..ded27deb3c0d
--- /dev/null
+++ b/drivers/spi/spi-daisy_chain.c
@@ -0,0 +1,419 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * A driver taking care of handling SPI daisy chaines.
+ *
+ * Copyright (C) 2020 Fastree3D
+ *	Adrian Fiergolski <Adrian.Fiergolski@fastree3d.com>
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/spi/spi.h>
+
+#include <linux/spi/spi-daisy_chain.h>
+
+/**
+  * spi_daisy_chain_message_pre - generate SPI daisy chain message
+  * @spi: device with which data will be exchanged
+  * @message: describes the data transfers
+  *
+  * The call checks if the SPI device is part of daisy chain. If so, it
+  * generates a message containg no-operation codes
+  * of unaddressed device of a given daisy chain.
+  **/
+
+int spi_daisy_chain_message_pre(struct spi_device *spi,
+				struct spi_message *message)
+{
+	struct spi_transfer *tr, *ntr;
+	struct spi_daisy_chain_device *spi_chain_dev;
+	int rc;
+
+	//the device is not part of a daisy-chain
+	if (spi->daisy_chain_devs == NULL)
+		return 0;
+
+	if (message->is_dma_mapped) {
+		dev_err(&spi->dev,
+			"DMA mapped transfer is not support when on daisy chain");
+		return -EINVAL;
+	}
+
+	if (!list_is_singular(&message->transfers)) {
+		dev_err(&spi->dev,
+			"Mutliple transfer segments are not support when on daisy chain");
+		return -EINVAL;
+	}
+
+	message->daisy_chain_transfers = message->transfers;
+	INIT_LIST_HEAD(&message->transfers);
+
+	list_for_each_entry (spi_chain_dev, spi->daisy_chain_devs, devices) {
+		if (spi_chain_dev->spi == spi) {
+			tr = list_first_entry(&message->daisy_chain_transfers,
+					      struct spi_transfer,
+					      transfer_list);
+
+			//check if mode is not beeing changed
+			if (tr->tx_nbits)
+				switch (spi->mode &
+					(SPI_TX_DUAL | SPI_TX_QUAD)) {
+				case 0:
+					if (tr->tx_nbits & SPI_NBITS_SINGLE)
+						break;
+				case SPI_TX_DUAL:
+					if (tr->tx_nbits & SPI_NBITS_DUAL)
+						break;
+				case SPI_TX_QUAD:
+					if (tr->tx_nbits & SPI_NBITS_QUAD)
+						break;
+				default:
+					dev_err(&spi->dev,
+						"Unsupported tx mode on daisy chain");
+					return -EINVAL;
+				}
+
+			if (tr->rx_nbits)
+				switch (spi->mode &
+					(SPI_RX_DUAL | SPI_RX_QUAD)) {
+				case 0:
+					if (tr->rx_nbits & SPI_NBITS_SINGLE)
+						break;
+				case SPI_RX_DUAL:
+					if (tr->rx_nbits & SPI_NBITS_DUAL)
+						break;
+				case SPI_RX_QUAD:
+					if (tr->rx_nbits & SPI_NBITS_QUAD)
+						break;
+				default:
+					dev_err(&spi->dev,
+						"Unsupported rx mode on daisy chain");
+					return -EINVAL;
+				}
+
+			//check if frequency is not being changed
+			if (tr->speed_hz && tr->speed_hz != spi->max_speed_hz) {
+				dev_err(&spi->dev,
+					"Change of SPI frequency not supported when on daisy chain");
+				return -EINVAL;
+			}
+
+			//daisy chain operations has a regular length
+			if (tr->len == spi_chain_dev->no_operation.len) {
+				tr->bits_per_word = spi_chain_dev->no_operation
+							    .bits_per_word;
+				tr->cs_change = 0;
+
+				list_add_tail(&tr->transfer_list,
+					      &message->transfers);
+			}
+			//daisy chain operation has different than regular length
+			else {
+				if (tr->len > spi_chain_dev->no_operation.len) {
+					dev_err(&spi->dev,
+						"Transmission not supported");
+					return -EINVAL;
+				}
+
+				ntr = kzalloc(sizeof(*ntr), GFP_KERNEL);
+
+				if (!ntr)
+					return -ENOMEM;
+
+				message->daisy_chain_new_transfer = ntr;
+
+				ntr->len = spi_chain_dev->no_operation.len;
+				ntr->bits_per_word = spi_chain_dev->no_operation
+							     .bits_per_word;
+
+				//copy tx buffer
+				if (tr->tx_buf) {
+					ntr->tx_buf =
+						kmalloc(ntr->len, GFP_KERNEL);
+					if (!ntr->tx_buf) {
+						rc = -ENOMEM;
+						goto err_out;
+					}
+
+					//The daisy-chain padding is assumed to be right-justified,
+					//so unused tx bits are transferred first
+					memcpy((void *)((char *)ntr->tx_buf +
+							ntr->len - tr->len),
+					       tr->tx_buf, tr->len);
+				}
+
+				//allocate rx buffer
+				if (tr->rx_buf) {
+					ntr->rx_buf =
+						kmalloc(ntr->len, GFP_KERNEL);
+					if (!ntr->rx_buf) {
+						rc = -ENOMEM;
+						goto err_out;
+					}
+				}
+
+				list_add_tail(&ntr->transfer_list,
+					      &message->transfers);
+			}
+		} else
+			list_add_tail(
+				&spi_chain_dev->no_operation.transfer_list,
+				&message->transfers);
+	}
+
+	return 0;
+
+err_out:
+	if (ntr->tx_buf)
+		kfree(ntr->tx_buf);
+	if (ntr->rx_buf)
+		kfree(ntr->rx_buf);
+	kfree(ntr);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(spi_daisy_chain_message_pre);
+
+/**
+  * spi_daisy_chain_message_post - generate SPI daisy chain message
+  * @spi: device with which data will be exchanged
+  * @message: describes the data transfers
+  *
+  * The call checks if the SPI device is part of daisy chain. If so, it 
+  * removes no-operation codes of unaddressd device of a given chain.
+  **/
+
+void spi_daisy_chain_message_post(struct spi_device *spi,
+				  struct spi_message *message)
+{
+	struct spi_transfer *tr;
+
+	//the device is not part of a daisy-chain
+	if (spi->daisy_chain_devs == NULL)
+		return;
+
+	if (message->daisy_chain_new_transfer) {
+		tr = list_first_entry(&message->daisy_chain_transfers,
+				      struct spi_transfer, transfer_list);
+		if (tr->rx_buf)
+			//The daisy-chain padding is assumed to be right-justified,
+			//so unused rx bits were received first and can be skipped
+			memcpy((void *)tr->rx_buf,
+			       (char *)message->daisy_chain_new_transfer->rx_buf +
+				       message->daisy_chain_new_transfer->len -
+				       tr->len,
+			       tr->len);
+
+		if (message->daisy_chain_new_transfer->tx_buf)
+			kfree(message->daisy_chain_new_transfer->tx_buf);
+
+		if (message->daisy_chain_new_transfer->rx_buf)
+			kfree(message->daisy_chain_new_transfer->rx_buf);
+
+		kfree(message->daisy_chain_new_transfer);
+	}
+
+	list_del(&message->transfers);
+
+	message->transfers = message->daisy_chain_transfers;
+}
+EXPORT_SYMBOL_GPL(spi_daisy_chain_message_post);
+
+void spi_daisy_chain_clean(struct list_head *daisy_chain_devs)
+{
+	struct spi_device *spi_dev;
+	struct spi_daisy_chain_device *spi_chain_dev;
+
+	list_for_each_entry (spi_chain_dev, daisy_chain_devs, devices) {
+		spi_dev = spi_chain_dev->spi;
+		spi_dev_put(spi_dev);
+		kfree(spi_chain_dev->no_operation.tx_buf);
+		kfree(spi_chain_dev);
+	}
+	list_del(daisy_chain_devs);
+	kfree(daisy_chain_devs);
+}
+
+static int spi_daisy_chain_driver_probe(struct spi_device *spi)
+{
+	struct device_node *nc;
+	struct spi_device *spi_dev;
+	struct spi_daisy_chain_device *spi_chain_dev;
+	struct spi_transfer *no_operation;
+	int w_size;
+	int rc;
+
+	//Initialise the SPI daisy-chain queue
+	spi->daisy_chain_devs =
+		kzalloc(sizeof(*spi->daisy_chain_devs), GFP_KERNEL);
+	if (!spi->daisy_chain_devs) {
+		return -ENOMEM;
+	}
+	INIT_LIST_HEAD(spi->daisy_chain_devs);
+
+	for_each_available_child_of_node (spi->dev.of_node, nc) {
+		if (of_node_test_and_set_flag(nc, OF_POPULATED))
+			continue;
+
+		spi_chain_dev = kzalloc(sizeof(*spi_chain_dev), GFP_KERNEL);
+		if (!spi_chain_dev) {
+			rc = -ENOMEM;
+			goto err_out;
+		}
+
+		////////////////////////////////////////////////////////////
+		//extract daisy-chain no-operation command from devicetree
+		////////////////////////////////////////////////////////////
+		no_operation = &spi_chain_dev->no_operation;
+		if (of_property_read_u8(nc, "spi-daisy-chain-bits_per_word",
+					&no_operation->bits_per_word)) {
+			no_operation->bits_per_word = 8;
+		}
+
+		if (no_operation->bits_per_word > 32) {
+			dev_err(&spi->dev,
+				"device %pOF: 'spi-daisy-chain-bits_per_word' property can't by higher than 32",
+				nc);
+			rc = -EINVAL;
+			goto err_out_spi_chain;
+		}
+
+		if (of_property_read_u32(nc, "spi-daisy-chain-len",
+					 &no_operation->len)) {
+			dev_err(&spi->dev,
+				"device %pOF doesn't define 'spi-daisy-chain-len' property",
+				nc);
+			rc = -EINVAL;
+			goto err_out_spi_chain;
+		}
+
+		// SPI transfer length should be multiple of SPI word size
+		// where SPI word size should be power-of-two multiple
+		if (no_operation->bits_per_word <= 8)
+			w_size = 1;
+		else if (no_operation->bits_per_word <= 16)
+			w_size = 2;
+		else
+			w_size = 4;
+
+		/* No partial transfers accepted */
+		if (no_operation->len % w_size) {
+			rc = -EINVAL;
+			dev_err(&spi->dev,
+				"no partial transfers accepted (propeties 'spi-daisy-chain-len' and  spi-daisy-chain-bits_per_word of device %pOF",
+				nc);
+			rc = -EINVAL;
+			goto err_out_spi_chain;
+		}
+
+		no_operation->tx_buf = kmalloc(no_operation->len, GFP_KERNEL);
+		if (!no_operation->tx_buf) {
+			rc = -ENOMEM;
+			goto err_out_spi_chain;
+		}
+
+		if (of_property_read_u8_array(nc, "spi-daisy-chain-noop",
+					      (void *)no_operation->tx_buf,
+					      no_operation->len)) {
+			dev_err(&spi->dev,
+				"device %pOF doesn't define 'spi-daisy-chain-noop' property",
+				nc);
+			rc = -EINVAL;
+			goto err_out_tx_buf;
+		}
+
+		////////////////////////////
+		//allocate a new SPI device
+		////////////////////////////
+		spi_dev = spi_alloc_device(spi->controller);
+		if (!spi_dev) {
+			dev_err(&spi->dev, "spi_device alloc error for %pOF\n",
+				nc);
+			rc = -ENOMEM;
+			goto err_out_tx_buf;
+		}
+		spi_chain_dev->spi = spi_dev;
+		spi_dev->daisy_chain_devs = spi->daisy_chain_devs;
+
+		//select device driver
+		rc = of_modalias_node(nc, spi_dev->modalias,
+				      sizeof(spi_dev->modalias));
+		if (rc < 0) {
+			dev_err(&spi->dev, "cannot find modalias for %pOF\n",
+				nc);
+			goto err_out_spi_dev;
+		}
+
+		//store a pointer to the node in the device structure
+		of_node_get(nc);
+		spi_dev->dev.of_node = nc;
+
+		//add the SPI device to the chain
+		list_add_tail(&spi_chain_dev->devices, spi->daisy_chain_devs);
+	}
+
+	//////////////////////
+	//add all SPI devices
+	//////////////////////
+	list_for_each_entry (spi_chain_dev, spi->daisy_chain_devs, devices) {
+		spi_dev = spi_chain_dev->spi;
+
+		//All devices on the chain share settings of the daisy-chain node
+		//The individual settings of the SPI nodes are ignored
+		spi_dev->mode = spi->mode;
+		spi_dev->chip_select = spi->chip_select;
+		spi_dev->max_speed_hz = spi->max_speed_hz;
+
+		//Register the new device
+		rc = spi_add_device(spi_dev);
+		if (rc) {
+			dev_err(&spi->dev,
+				"spi_device register error on daisy chain %pOF\n",
+				spi_dev->dev.of_node);
+			of_node_put(nc);
+			goto err_out;
+		}
+	}
+
+	return 0;
+
+err_out_spi_dev:
+	spi_dev_put(spi_chain_dev->spi);
+err_out_tx_buf:
+	kfree(spi_chain_dev->no_operation.tx_buf);
+err_out_spi_chain:
+	kfree(spi_chain_dev);
+err_out:
+	spi_daisy_chain_clean(spi->daisy_chain_devs);
+	return rc;
+}
+
+static int spi_daisy_chain_driver_remove(struct spi_device *spi)
+{
+	spi_daisy_chain_clean(spi->daisy_chain_devs);
+	return 0;
+}
+
+static const struct of_device_id spi_daisy_chain_of_match[] = {
+	{
+		.compatible = "spi,daisy_chain",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, spi_daisy_chain_of_match);
+
+static struct spi_driver spi_daisy_chain_driver = {
+	.probe = spi_daisy_chain_driver_probe,
+	.remove = spi_daisy_chain_driver_remove,
+	.driver =
+		{
+			.name = "daisy_chain",
+			.of_match_table = spi_daisy_chain_of_match,
+		},
+};
+module_spi_driver(spi_daisy_chain_driver);
+
+MODULE_AUTHOR("Adrian Fiergolski <Adrian.Fiergolski@fastree3d.com>");
+MODULE_DESCRIPTION("Driver handling SPI daisy chain");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:daisy_chain");
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index fd3f1aa79f26..4f32456f8cd0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -29,6 +29,9 @@
 #include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
+#ifdef	CONFIG_SPI_DAISY_CHAIN
+#include <linux/spi/spi-daisy_chain.h>
+#endif
 #include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_domain.h>
@@ -478,14 +481,33 @@ EXPORT_SYMBOL_GPL(spi_alloc_device);
 static void spi_dev_set_name(struct spi_device *spi)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&spi->dev);
+#ifdef CONFIG_SPI_DAISY_CHAIN
+	struct spi_daisy_chain_device *spi_chain_dev;
+	int spi_dev_index;
+#endif
 
 	if (adev) {
 		dev_set_name(&spi->dev, "spi-%s", acpi_dev_name(adev));
 		return;
 	}
 
-	dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->controller->dev),
-		     spi->chip_select);
+#ifdef CONFIG_SPI_DAISY_CHAIN
+	if (spi->daisy_chain_devs != NULL) {
+		spi_dev_index = 0;
+		list_for_each_entry (spi_chain_dev, spi->daisy_chain_devs,
+				     devices)
+			if (spi_chain_dev->spi == spi)
+				break;
+			else
+				spi_dev_index++;
+		dev_set_name(&spi->dev, "%s.%u.%u",
+			     dev_name(&spi->controller->dev), spi->chip_select,
+			     spi_dev_index);
+
+	} else
+#endif
+		dev_set_name(&spi->dev, "%s.%u",
+			     dev_name(&spi->controller->dev), spi->chip_select);
 }
 
 static int spi_dev_check(struct device *dev, void *data)
@@ -529,14 +551,27 @@ int spi_add_device(struct spi_device *spi)
 	 * chipselect **BEFORE** we call setup(), else we'll trash
 	 * its configuration.  Lock against concurrent add() calls.
 	 */
-	mutex_lock(&spi_add_lock);
+#ifdef CONFIG_SPI_DAISY_CHAIN
+	/* Do not lock the controller when registering the daisy_chain driver
+	 * as the last one wouldn't be able to register its subnodes
+	 */
+	if (strcmp((const char *)spi->dev.of_node->name, "daisy_chain") == 0)
+#endif
+		mutex_lock(&spi_add_lock);
 
-	status = bus_for_each_dev(&spi_bus_type, NULL, spi, spi_dev_check);
-	if (status) {
-		dev_err(dev, "chipselect %d already in use\n",
+#ifdef CONFIG_SPI_DAISY_CHAIN
+	if (spi->daisy_chain_devs == NULL) {
+#endif
+		status = bus_for_each_dev(&spi_bus_type, NULL, spi,
+					  spi_dev_check);
+		if (status) {
+			dev_err(dev, "chipselect %d already in use\n",
 				spi->chip_select);
-		goto done;
+			goto done;
+		}
+#ifdef CONFIG_SPI_DAISY_CHAIN
 	}
+#endif
 
 	if (ctlr->cs_gpios)
 		spi->cs_gpio = ctlr->cs_gpios[spi->chip_select];
@@ -561,7 +596,10 @@ int spi_add_device(struct spi_device *spi)
 		dev_dbg(dev, "registered child %s\n", dev_name(&spi->dev));
 
 done:
-	mutex_unlock(&spi_add_lock);
+#ifdef CONFIG_SPI_DAISY_CHAIN
+	if (strcmp((const char *)spi->dev.of_node->name, "daisy_chain") == 0)
+#endif
+		mutex_unlock(&spi_add_lock);
 	return status;
 }
 EXPORT_SYMBOL_GPL(spi_add_device);
@@ -3116,6 +3154,12 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
 	SPI_STATISTICS_INCREMENT_FIELD(&ctlr->statistics, spi_sync);
 	SPI_STATISTICS_INCREMENT_FIELD(&spi->statistics, spi_sync);
 
+#ifdef CONFIG_SPI_DAISY_CHAIN
+	status = spi_daisy_chain_message_pre(spi, message);
+	if (status < 0)
+		return status;
+#endif
+
 	/* If we're not using the legacy transfer method then we will
 	 * try to transfer in the calling context so special case.
 	 * This code would be less tricky if we could remove the
@@ -3149,6 +3193,11 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
 		status = message->status;
 	}
 	message->context = NULL;
+
+#ifdef CONFIG_SPI_DAISY_CHAIN
+	spi_daisy_chain_message_post(spi, message);
+#endif
+
 	return status;
 }
 
diff --git a/include/linux/spi/spi-daisy_chain.h b/include/linux/spi/spi-daisy_chain.h
new file mode 100644
index 000000000000..beb409b0be2e
--- /dev/null
+++ b/include/linux/spi/spi-daisy_chain.h
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * A driver taking care of handling daisy chaines.
+ *
+ * Copyright (C) 2020 Fastree3D
+ *	Adrian Fiergolski <Adrian.Fiergolski@fastree3d.com>
+ */
+
+#ifndef __LINUX_SPI_DAISY_CHAIN_H
+#define __LINUX_SPI_DAISY_CHAIN_H
+
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+/**
+ * struct spi_daisy_chain - interface to a SPI device on a daisy chain
+ * @spi: SPI device on the daisy chain
+ * @no_operation: no-opeartion SPI message for the given device
+ * @devices: list of SPI devices sharing the given daisy chain
+ **/
+struct spi_daisy_chain_device {
+	struct spi_device *spi;
+	struct spi_transfer no_operation;
+	struct list_head devices;
+};
+
+extern int spi_daisy_chain_message_pre(struct spi_device *spi,
+				       struct spi_message *message);
+extern void spi_daisy_chain_message_post(struct spi_device *spi,
+					 struct spi_message *message);
+
+#endif /* __LINUX_SPI_DAISY_CHAIN_H */
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index b5c84c1507cd..c247d1e2cfb9 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -102,6 +102,9 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
  * @dev: Driver model representation of the device.
  * @controller: SPI controller used with the device.
  * @master: Copy of controller, for backwards compatibility.
+ * @daisy_chain_devs: list of all SPI devices on the daisy chain
+ *      used by the given SPI device.
+ *      Handled by the SPI daisy chain driver.
  * @max_speed_hz: Maximum clock rate to be used with this chip
  *	(on this board); may be changed by the device's driver.
  *	The spi_transfer.speed_hz can override this for each transfer.
@@ -144,6 +147,9 @@ struct spi_device {
 	struct device		dev;
 	struct spi_controller	*controller;
 	struct spi_controller	*master;	/* compatibility layer */
+#ifdef CONFIG_SPI_DAISY_CHAIN
+	struct list_head        *daisy_chain_devs;
+#endif
 	u32			max_speed_hz;
 	u8			chip_select;
 	u8			bits_per_word;
@@ -821,6 +827,11 @@ struct spi_transfer {
 /**
  * struct spi_message - one multi-segment SPI transaction
  * @transfers: list of transfer segments in this transaction
+ * @daisy_chain_transfers: head of the original transfers queue.
+ *      Handled by the SPI daisy chain driver.
+ * @daisy_chain_new_transfer: pointer to an extra SPI transfer,
+ *      in case it had to be created.
+ *      Handled by the SPI daisy chain driver.
  * @spi: SPI device to which the transaction is queued
  * @is_dma_mapped: if true, the caller provided both dma and cpu virtual
  *	addresses for each transfer buffer
@@ -851,6 +862,10 @@ struct spi_transfer {
 struct spi_message {
 	struct list_head	transfers;
 
+#ifdef	CONFIG_SPI_DAISY_CHAIN
+	struct list_head	daisy_chain_transfers;
+        struct spi_transfer     *daisy_chain_new_transfer;
+#endif
 	struct spi_device	*spi;
 
 	unsigned		is_dma_mapped:1;
-- 
2.27.0


--------------827C1265C8ED8A54F21949C7--
