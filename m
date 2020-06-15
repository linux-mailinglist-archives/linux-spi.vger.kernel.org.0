Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D4C1F97B9
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 15:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbgFONCJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 09:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730187AbgFONBu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 09:01:50 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D661C061A0E
        for <linux-spi@vger.kernel.org>; Mon, 15 Jun 2020 06:01:49 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dr13so17314802ejc.3
        for <linux-spi@vger.kernel.org>; Mon, 15 Jun 2020 06:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastree3d-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=KAx3Gd+dzqs3howWlB2WDextkWfIoGt2wEvuDBBK+0g=;
        b=Y67p7MQIa11L7vrXwLhQ0c6azp79K1RSIyIR9rXrgegEQYgtMIUUTd+SBh2HEzLLX9
         QaJJ6bCmT/B3k/jAcmdrXnqZL+jCaenZT0/LEloT7xJV6HgFQLZPjhIiAOr+fIdI3Lm8
         3ju4pmUXoaEIyO0TN2tFMEv68YJzOhUOKSGK0t04uOhB0dD2NqPw7oDzsM7nYBaYn5xO
         w0j1OVJkosdj73YQEygTqgbPmwhZ9kcidph35I//AGTJOp7T5wixxc3OSo39ncjEvGRC
         TLHuqbckPhd7bIEaBoalBqLattenz8eaiYGP7fXWw+eyKmFv+0hwv4Vs8GqCAE3eU8hH
         hwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KAx3Gd+dzqs3howWlB2WDextkWfIoGt2wEvuDBBK+0g=;
        b=oEbGwpoVfdjHQJa7SJXhyFwJa7Clw2TSyUe13UkqndN0+hoIe629sB9491R0MY4HI9
         nZ8n/6ew2Kw/J/h7+BB7sqP74MeWM34gmeceIa/XBfiuSrNNX5OlVhlIfnrAcA4/bu6V
         tmHDX2BaRXHrkxqsZnKZAKrv3y+SPyHuwisGvnH/tg8Be4lqY85Rag5m7oBElcvYeym7
         +bMv3abTI4zPLwGJp1zTSnujkT1AtZlx/OR/gBvCL2ZlDJqGdVukKXx8ZwIHincSVuN2
         gdmAXQzNLDrei4B+HIR/8y48bRU/RuHl/1QBGK1VuzG+47on+xPX8984WcYg528cSw7v
         Colg==
X-Gm-Message-State: AOAM531sst1AH4SUqroAMZEKii350COa/ipqn55P9++q7i9zU44MbwMi
        h3FzZiOlHNPl69FBk+/B80ZD
X-Google-Smtp-Source: ABdhPJyeVXI3AMbnLTnbxoyD4+HY+uGo2pUth+Wlfe6akQ/JZmqFp21+yCpPeEzu10yv/VPye8Nt7w==
X-Received: by 2002:a17:906:560b:: with SMTP id f11mr26334904ejq.11.1592226107669;
        Mon, 15 Jun 2020 06:01:47 -0700 (PDT)
Received: from [192.168.33.195] (fastree1.epfl.ch. [192.26.37.52])
        by smtp.gmail.com with ESMTPSA id o27sm8945231ejc.95.2020.06.15.06.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 06:01:47 -0700 (PDT)
From:   Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
X-Google-Original-From: Adrian Fiergolski <Adrian.Fiergolski@fastree3d.com>
Subject: Re: [cadence-spi] daisy chain
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
References: <7cddc1a3-f3a8-37dd-487a-cd2274b7941c@fastree3d.com>
 <CAMuHMdXzErU5z69=2gks5ySutkGw98O6+f7weiuPUp8uqTx63w@mail.gmail.com>
Message-ID: <9bfce379-1878-e8e5-c452-0e24aa263cbb@fastree3d.com>
Date:   Mon, 15 Jun 2020 15:01:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXzErU5z69=2gks5ySutkGw98O6+f7weiuPUp8uqTx63w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Geert,

Thank you for the update.

In fact, the ultimate solution would be to have it solved at the level
of the spi subsystem:

  * /spi_device struct/ would contain extra callback which returns msg
    to be sent for no operation.
  * spi_device struct would contain a pointer to the list describing the
    given daisy chain (list of spi_devices on the chain)
  * /spi_device struct /would contain extra u8 daisy_chain_msg_length
    indicating length of a command of the addressed device if it's on
    the daisy chain
    For example, in case of the ltc2634 device, the regular message
    consists of 24 bits, but when device is a part of a daisy chain, the
    messages are 32 bits. This 32 would be stored in
    /daisy_chain_msg_length./
  * When /spi_write/ was called (include/linux/spi/spi.h), the
    /spi_message_init_with_transfer/ would create a msg of length equal
    to a sum of /daisy_chain_msg_length/ of all devices on the chain.
    Afterwards, in /spi_message_init_with_transfers/, the actual message
    would be filled with the command of the addressed device on the
    chain and no_operation content for all other devices on the chain
    not being addressed
  * I think in such a case, the /daisy-chained-devices /property would
    be not used, as chains would be build basing on the assigned
    chipselect (reg property).

If you agree with the above description, I could try to implement it. Of
course any suggestion are welcome, however, I would like to have a
working solution until end of this week, so I would appreciate an active
feedback. As my SoC works with kernel v4.19, I would implement it for
it, test it, and move it afterwards to the master version (I hope, there
were no big changes in the SPI subsystem, right?).

Regards,

Adrian

On 13.06.2020 09:33, Geert Uytterhoeven wrote:
> Hi Adrian,
>
> CC Lukas for #daisy-chained-devices
>
> On Fri, Jun 12, 2020 at 6:26 PM Adrian Fiergolski
> <adrian.fiergolski@fastree3d.com> wrote:
>> I have a daisy chain of three ltc2634 slaves (iio/dac/ltc2632.c)
>> connected to a single chip select of the cadence-spi master. I have the
>> impression such a configuration is supported by none of those two
>> drivers. I could try to extend both, however, I haven't found any other
>> SPI driver, where I could find implementation inspiration. Is it
>> supported by kernel?
> drivers/gpio/gpio-max3191x.c supports "#daisy-chained-devices".
> drivers/gpio/gpio-74x164.c supports multiple shift registers through the
> "registers-number" DT property.
>
> So both drivers handle this in their SPI slave drivers.
>
> Of course this does not handle the mixed case, i.e. daisy-chaining
> different types of devices.
>
>> The documentation mentions only about the common 'daisy-chained-devices'
>> property (devicetree/bindings/common-properties.txt). However, in order
>> to try to implement it in the master driver, IMHO, the spi subsystem
>> would need to have a call 'no-operation' to other nodes on the
>> daisy-chain, which are not addressed by the given SPI access. Is there
>> any recommended approach to address this case?
> Supporting this in a generic way would indeed be nice, as it would mean
> individual SPI slave drivers no longer have to care about it.
> However, that may be difficult, as the master needs to known which
> dummy (no-op) data is safe to shift through the non-addresses SPI slaves.
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
