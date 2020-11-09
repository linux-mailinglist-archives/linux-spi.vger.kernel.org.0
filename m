Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF2D2AC52C
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 20:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbgKITkF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 14:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729697AbgKITkE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 14:40:04 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D25C0613CF;
        Mon,  9 Nov 2020 11:40:03 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id v143so4573431qkb.2;
        Mon, 09 Nov 2020 11:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IvG3Qlw3Sims/I+Pl3z2VFRo151O+rq5wXrIzz+k3p4=;
        b=IhhoxcZPpMSQSlFHJ2lui4ElDlkAAlvkD3NsdSNLxFv0zEpS5E2+KeizKUEsdWOH4F
         hENjo3zqokFRnJxQ8jTlg/tK+177ihjSsTmGWZCR/NvZ+zI/XX++kfXtOHUQdYPNPJtn
         ZEvHSP+fB0zPHY10uwELnTISnvff+v6o9nGZojeLjPuCMOyoN8q2raiw6xBPQuheJcUr
         AmJBfgpYCLVi9nnVZVvx5R6fr4WsGq6zNtb9lhQaIFtgJKS/bXuGAJ13rUSTZi4te7M2
         wlAMrpdeG4B7YAJ3A/EEgs8SHeG4nMdNYrFqNn3lbL8V1kNXtqez2NLNvxsg96FWKVq5
         qBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IvG3Qlw3Sims/I+Pl3z2VFRo151O+rq5wXrIzz+k3p4=;
        b=ebxLdfWmx1zRB2GPdKF4EbIzmCrgmHppaGCOfduJ2ASxoOi2f0pnWen1hJUV/CrWjS
         08clSGUjxkxOvzKo1+/uAkJfKeoA8zlKwYrDA0QilI6wHoRamkjtddjXrUTe4gc0Xed1
         E4qTvV74RwBFtmhAf5hzaf79iitmxJbz6tYm8EwYuLR7UqRcApkdFSuFewVXgD3Ty33+
         sUwL+QCXsg7rOy1xOIQQNFb17TYE8heQgOEiqQW2+WPL0uqU3ti7fStl99K/GCixpCFx
         2L+dabgcRlzpDqd6GMTGKwg8iRepAEXOv10FLao3bXsmIj4qv9ZQO7qFn7NH5KNhejyD
         6O1Q==
X-Gm-Message-State: AOAM530q5gKrwv4QE62X3kIvKQ0RBKKUsHUHCFS854E1B8OG/PvaLbAV
        /QG+8RyNRvXZD2yeX+7ttNU=
X-Google-Smtp-Source: ABdhPJztog9f7rPeKsxFXpcxutk1IpQlx7WHd8tOV+vS7hj0AIRLT2P8fBGg5wxVZnwwdTIbbETs3w==
X-Received: by 2002:a37:a14a:: with SMTP id k71mr15779388qke.33.1604950802988;
        Mon, 09 Nov 2020 11:40:02 -0800 (PST)
Received: from [192.168.1.201] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id j50sm6783377qtc.5.2020.11.09.11.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 11:40:02 -0800 (PST)
Subject: Re: [PATCH 03/32] spi: dw: Fix driving MOSI low while recieving
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-4-damien.lemoal@wdc.com>
 <20201109132935.GB6380@sirena.org.uk>
 <c37ca9be-ea92-b07a-b600-d68de4f7bde5@gmail.com>
 <20201109141422.GD6380@sirena.org.uk>
 <20201109191909.wfuwpddng4rdn4ca@mobilestation>
From:   Sean Anderson <seanga2@gmail.com>
Autocrypt: addr=seanga2@gmail.com; prefer-encrypt=mutual; keydata=
 mQENBFe74PkBCACoLC5Zq2gwrDcCkr+EPGsT14bsxrW07GiYzQhLCgwnPdEpgU95pXltbFhw
 46GfyffABWxHKO2x+3L1S6ZxC5AiKbYXo7lpnTBYjamPWYouz+VJEVjUx9aaSEByBah5kX6a
 lKFZWNbXLAJh+dE1HFaMi3TQXXaInaREc+aO1F7fCa2zNE75ja+6ah8L4TPRFZ2HKQzve0/Y
 GXtoRw97qmnm3U36vKWT/m2AiLF619F4T1mHvlfjyd9hrVwjH5h/2rFyroXVXBZHGA9Aj8eN
 F2si35dWSZlIwXkNu9bXp0/pIu6FD0bI+BEkD5S7aH1G1iAcMFi5Qq2RNa041DfQSDDHABEB
 AAG0K1NlYW4gR2FsbGFnaGVyIEFuZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNvbT6JAVcEEwEK
 AEECGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4ACGQEWIQSQYR1bzo1I0gPoYCg+6I/stKEQ
 bgUCXT+S2AUJB2TlXwAKCRA+6I/stKEQbhNOB/9ooea0hU9Sgh7PBloU6CgaC5mlqPLB7NTp
 +JkB+nh3Fqhk+qLZwzEynnuDLl6ESpVHIc0Ym1lyF4gT3DsrlGT1h0Gzw7vUwd1+ZfN0CuIx
 Rn861U/dAUjvbtN5kMBqOI4/5ea+0r7MACcIVnKF/wMXBD8eypHsorT2sJTzwZ6DRCNP70C5
 N1ahpqqNmXe0uLdP0pu55JCqhrGw2SinkRMdWyhSxT56uNwIVHGhLTqH7Q4t1N6G1EH626qa
 SvIJsWlNpll6Y3AYLDw2/Spw/hqieS2PQ/Ky3rPZnvJt7/aSNYsKoFGX0yjkH67Uq8Lx0k1L
 w8jpXnbEPQN3A2ZJCbeM
Message-ID: <5808c9b9-5955-4733-2c56-b93c627cb556@gmail.com>
Date:   Mon, 9 Nov 2020 14:40:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201109191909.wfuwpddng4rdn4ca@mobilestation>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11/9/20 2:19 PM, Serge Semin wrote:
> On Mon, Nov 09, 2020 at 02:14:22PM +0000, Mark Brown wrote:
>> On Mon, Nov 09, 2020 at 08:47:10AM -0500, Sean Anderson wrote:
>>> On 11/9/20 8:29 AM, Mark Brown wrote:
>>>> On Sat, Nov 07, 2020 at 05:13:51PM +0900, Damien Le Moal wrote:
>>>>
> 
>>>>> The resting state of MOSI is high when nothing is driving it. If we
>>>>> drive it low while recieving, it looks like we are transmitting 0x00
>>>>> instead of transmitting nothing. This can confuse slaves (like SD cards)
>>>>> which allow new commands to be sent over MOSI while they are returning
>>>>> data over MISO. The return of MOSI from 0 to 1 at the end of recieving
>>>>> a byte can look like a start bit and a transmission bit to an SD card.
> 
> Yeah, that's what we've also experienced on our systems. We've worked
> around the problem in exactly the same way as you have. But we haven't
> dared to send it out as the solution seemed a bit hackish.

Well, the way it is now is equally wrong, since it is driving the line
low.

>>>>
>>>> If client devices are interpreting the transmitted data then I would
>>>> expect the drivers for that hardware to be ensuring that whatever we
>>>> transmit matches what the device is expecting.  We shouldn't be putting
>>>> a hack in a particular controller driver to paper over things, that will
>>>> mean that the device will break when used with other controllers and if
>>>> different devices have different requirements then obviously we can't
>>>> satisfy them.  There is not meaningfully a general specification for SPI
>>>> which says what happens when signals are idle, it's all specific to the
>>>> client device.
>>>>
>>>> In this case it also looks like the controller hardware requires
>>>> transmit data and therefore should be setting SPI_MUST_TX and just
>>>> removing the in driver default anyway, though that will have no effect
>>>> one way or anther on the issue you're seeing.
>>
> 
>>> There is a recieve-only mode, but it is not used by this driver. Perhaps
>>> it should be.
>>
>> I'd expect it'd perform better, especially on systems that are
>> apparently struggling for CPU bandwidth like yours seems to.
> 
> CPU-wise. RO-mode won't help in that case. Moreover it will be even
> more errors-prone for the systems with small CPU bandwidth. As I said
> the Receive-only mode will make the SPI controller automatically
> receiving data from the SPI bus and putting it into the Rx FIFO. If
> CPU is either busy with something else or too slow in fetching the
> data from the Rx FIFO, the FIFO will be eventually overflown with
> data, which we need to avoid at all cost.
> 
> As I see it the Receive-only mode is only acceptable in the next two
> situations:
> 
> 1) Rx-only DMA. But only if the DMA-engine and system bus are fast
> enough to fetch the incoming data on time. (Note for example in our
> system some DWC DMA-engine channels don't work well with the DW APB
> SSI working with full-speed, so we had to set constraints on the DWC
> DMA channels being used in conjunction with the DW APB SSI
> controller.)
> 
> 2) Rx-only with atomic CPU utilization. In order to make sure that the
> CPU keeps up with fetching the data from the Rx FIFO, we have to
> disable the local CPU IRQs while performing the Rx-only transfers, so
> to prevent the Rx FIFO overflow while the CPU is doing something else.
> Needless to say that such approach should be utilized only as a last
> resort, if we have no choice but to run the Receive-only transfers.
> Because locking the CPU for God knows how much time may cause the
> system interactivity degradation. For instance, a possible use-case of
> that design is when the controller is communicating with the
> SPI-devices with native DW APB SSI chip-select attached. BTW You can
> also find that design implemented in the kernel 5.10 spi-dw-core.c
> driver in context of the SPI-memory operations (with my last patches
> merged in). In particular I had to use it to handle the CPU-based
> EEPROM-read mode.
> 
> So in all other cases for normal CPU-based SPI-transfers when
> GPIO-based chip-select is available the safest solution would be to
> use a normal Push-Pull mode. In this case we have no risk in getting
> the Rx FIFO overflow unless there is a bug in the code, which is
> fixable anyway.
> 
> Getting back to the patch. In fact I don't really see how the
> Receive-only mode will help us with solving the problem noted in the
> patch log.

Shouldn't it put MOSI into High-Z like when the device is idle? The
issue is mainly that the idle state and RX state are different.

> As Mark said the problem with the Tx data on Rx-only
> transfers should be fixed on the client side. If an subordinate
> SPI-device needs a specific value to be received in that case, then
> that value should be somehow provided to the SPI-controller anyway.
> So the native Rx-only mode of the DW APB SSI controller won't help.
> Currently it's possible to be done only by executing a Full-duplex
> SPI-transfer with the Tx-buffer being pre-initialized with that
> value.
> 
> Another possible solution for the problem would be to fix the SPI core
> so aside with tx_buf being set to the NULL-pointer, a client driver
> would provide a default level or some specific value being put to the
> SPI bus on Rx-only transfers. If an SPI-controller is capable of
> satisfying the request, then it will accept the transfer. If it's not,
> then the SPI core may try to convert the Rx-only transfer into the
> Full-duplex transfer with the Tx-buffer being initialized with the
> requested level.

This is probably the most general solution; is there an existing way to
specify this sort of thing?

--Sean
