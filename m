Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA2E4EBF52
	for <lists+linux-spi@lfdr.de>; Wed, 30 Mar 2022 12:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245645AbiC3K6P (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Mar 2022 06:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245633AbiC3K6N (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Mar 2022 06:58:13 -0400
Received: from mail.mleia.com (mleia.com [178.79.152.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7C4264F6C
        for <linux-spi@vger.kernel.org>; Wed, 30 Mar 2022 03:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1648637786; bh=4IIWQUgWGsZ11QKKnaAI5uwjc5+4qsqXHmvopyeu08Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sKg8wM7/S4xPfgalgPUuhNcgK8CAWPT95zHeug7JUeCD0Q4wA1PUrifrh61FsonLE
         IRTLsS7UFDgHyHARwNKIjhH2oDBYULcJ0y7p+QPtsAt5jpsNPEPTRB93rZwtax69j3
         7adwXfrwPv+5/Bir3kg49GfOCAhd0PMbLV4ZbrZjCheITBoP0mqTeFLi/LiFDQFPwy
         NegvglXje8eil4tYpcabfFVYcsngDKwQqZudpVVR8xvqE3xypsYFDTE8LzGxh6c9ws
         GGCFsn44ozVmkMqE8EuGPMLfCPL9XLlm2hVxrLJG5cEXlFN00FJ7RmkF0ZOw47aRIz
         /gUNw5g5BCQBg==
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 7900D3A3D70;
        Wed, 30 Mar 2022 10:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1648637786; bh=4IIWQUgWGsZ11QKKnaAI5uwjc5+4qsqXHmvopyeu08Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sKg8wM7/S4xPfgalgPUuhNcgK8CAWPT95zHeug7JUeCD0Q4wA1PUrifrh61FsonLE
         IRTLsS7UFDgHyHARwNKIjhH2oDBYULcJ0y7p+QPtsAt5jpsNPEPTRB93rZwtax69j3
         7adwXfrwPv+5/Bir3kg49GfOCAhd0PMbLV4ZbrZjCheITBoP0mqTeFLi/LiFDQFPwy
         NegvglXje8eil4tYpcabfFVYcsngDKwQqZudpVVR8xvqE3xypsYFDTE8LzGxh6c9ws
         GGCFsn44ozVmkMqE8EuGPMLfCPL9XLlm2hVxrLJG5cEXlFN00FJ7RmkF0ZOw47aRIz
         /gUNw5g5BCQBg==
Received: from [192.168.1.102] (88-113-46-102.elisa-laajakaista.fi [88.113.46.102])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mleia.com (Postfix) with ESMTPSA id 3D0373A3D2B;
        Wed, 30 Mar 2022 10:56:26 +0000 (UTC)
Message-ID: <e060912b-0a7d-9fd5-edde-c27a8da55569@mleia.com>
Date:   Wed, 30 Mar 2022 13:56:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: spi-pl022 on lpc32xx
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Trevor Woerner <twoerner@gmail.com>
Cc:     linux-spi@vger.kernel.org, alexandre.belloni@bootlin.com
References: <20220328190104.GA11946@localhost>
 <CACRpkdY2ynzAyQz3q2gHnZMA+Opr-b=w=dA4YMqH=i0Rv+OYcg@mail.gmail.com>
 <20220329183135.GA6427@localhost>
 <CACRpkdZUW0wQrJxnA1pcJ9AO6-FOVEx6pXczg0iz2UnQMCEWpw@mail.gmail.com>
From:   Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <CACRpkdZUW0wQrJxnA1pcJ9AO6-FOVEx6pXczg0iz2UnQMCEWpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20220330_105626_514181_B638520B 
X-CRM114-Status: GOOD (  29.72  )
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Linus, Trevor,

On 3/30/22 00:33, Linus Walleij wrote:
> On Tue, Mar 29, 2022 at 8:31 PM Trevor Woerner <twoerner@gmail.com> wrote:
> 
>>>>          &ssp0 {
>>>>                  status = "okay";
>>>
>>> The main definition of the SSP is elsewhere in the node with ssp0:, so I
>>> have no idea how this is configured really.
>>
>> I'm not sure what you mean here. lpc32xx.dtsi defines the ssp0 node and
>> disables it.
> 
> Yeah that is what I'm asking about. So now that I look at that:
> 
>                          ssp0: spi@20084000 {
>                                  compatible = "arm,pl022", "arm,primecell";
>                                  reg = <0x20084000 0x1000>;
>                                  interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
>                                  clocks = <&clk LPC32XX_CLK_SSP0>;
>                                  clock-names = "apb_pclk";
>                                  #address-cells = <1>;
>                                  #size-cells = <0>;
>                                  status = "disabled";
>                          };
> 
> Just apb_pclk? You need sspclk as well. If the same clock is used for
> both then add the same clock with the name "sspclk" *before* the
> apb_pclk, so:
> 
> clocks = <&clk LPC32XX_CLK_SSP0>, <&clk LPC32XX_CLK_SSP0>;
> clock-names = "sspclk", "apb_pclk";
> 
> NOTE: I don't know if this is what the SoC is actually routing to the SSP.
> Consult the LPC32xx docs to figure out which clock is actually connected
> to the SSPCLK input of the PL022.
> 
>>>>                  m25p16@0 {
>>>>                          compatible = "jedec,spi-nor";
>>>>                          reg = <0>;
>>>>                          spi-max-frequency = <500000>;
>>>>
>>>>                          pl022,interface = <0>;
>>>>                          pl022,com-mode = <1>;
>>>
>>> com-mode 1 (polling) really? Why? Are interrupts broken
>>> on your silicon?
>>
>> Right now I'm getting nothing back from the spi-nor. I see the SPI subsystem
>> sending out the 0x9f, I see the pl022 driver writing it to the data register,
>> I've added some code to the pl022 driver to print out the status register, and
>> the "receive FIFO not empty flag" (RNE) never goes up. In polling mode it'll
>> eventually time out and I'll get to a prompt (to reflash and reboot). In
>> interrupt mode I'd have to yank the power, boot to a different image, flash
>> from there, and reboot. So polling mode make the build/flash/reboot cycle
>> faster :-)
> 
> I'd bet on the clock (which is obviously wrong) and if you have a pin
> controller then inspect the pin multiplexing too. You have
> drivers/pinctrl/pinctrl-lpc18xx.c
> but there is no driver for lpc32xx? So how is pin multiplexing
> actually set up on this platform?

years ago you've asked the same question, and the answer is that there is no
pinctrl IP or controls on the SoC. This sounds weird, but that's how it goes.

There are just a few multiplexed pins, and a pin function selection is done
on basis of powering up a corresponding particular IP while keeping
conflicting ones disabled. Such implicit pin multiplexing is inconvenient,
but working, fortunately the SoC is simple to have such a model supported.

The newer LPC18xx/LPC43xx has a pin control IP, and it makes everything much
more transparent and comprehensible, but it's not transferable to LPC32xx.

> How are these two SPI and SSP controllers actually sharing these
> pins without any configuration anywhere? It just gives me the feel
> that an lpc32xx pin control driver is missing.
> 
> On LPC18xx it looks like this:
> 
>                 pinctrl: pinctrl@40086000 {
>                          compatible = "nxp,lpc1850-scu";
>                          reg = <0x40086000 0x1000>;
>                          clocks = <&ccu1 CLK_CPU_SCU>;
>                  };
> 
> SCU sounds like "system control unit" doesn't LPC32xx have one
> of these? Where is that configured then?
> 
> Yours,
> Linus Walleij

--
Best wishes,
Vladimir
