Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298C2216ACA
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jul 2020 12:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgGGKxm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Jul 2020 06:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgGGKxl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Jul 2020 06:53:41 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C614C061755
        for <linux-spi@vger.kernel.org>; Tue,  7 Jul 2020 03:53:41 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n26so32169348ejx.0
        for <linux-spi@vger.kernel.org>; Tue, 07 Jul 2020 03:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastree3d-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xzMc8ThId2/X4pKYDkTZL/dvNCzrhOR7XnxySi0pc/s=;
        b=D2ypRy0OeuE2marIBj8ZKQqaaGMNwz1Z/07MI2vPrWr2CVg1XoUmhv0A4s2UsgKShF
         FK5shzg0FG5PT7LYECWo81PyDgnObHrIUuQhIkqVcziEzASHvIuy4k5MZF1/WftjKWI7
         isILWoilv2u9zLkU8PBltwQ5aI75S7LeDk+ZKrDyIqB+B+dBMgJ2zVw3S3jfvg+3LvqB
         zu+KiRmXc1HiNgWWXgl/++5nYre/06oALbccRHrp1VdcrdODQ9Q6Zpm1P2fM4dwufgr5
         DufNmDk2pAJMlrY8XwbYXLIQ6PKMAifacFEI0Gz30KDwwek+j+YHeQLdXwhhEi2bMAKj
         DFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xzMc8ThId2/X4pKYDkTZL/dvNCzrhOR7XnxySi0pc/s=;
        b=Jn0BFzxbFuXLTjfhSw40htwKv4x2WKfDcQRoX8314XxjgkjCVtt+cV9PGZt4tVa9x3
         Xzo9ePFvtvNcpFAlG7U6u/VMMMySaMGvPcXiiAZotsfS8Cn0TbPNwToRviIS/sK+fYX+
         g6qEPlylP3Fvr9KjW1z5AuYbFv6vjYJWmxJCpRNEEYxOXVeXWzhevT4nAZgTt0X7TvsV
         rfuxz5dR9KJTaUVRe3GFrPax5zBM13qI77nRJejDMgkaAH0mWWv1fFUQG8602jigWyJg
         Csnix5verS8ze/794gfrqMU7ualQqvLt1aGZ3VUMK+26/Nohuwv/JArbEQCG6zty/F1b
         pKjQ==
X-Gm-Message-State: AOAM533K35JOAt7EuyU8IRNWhl626WGdLudPlZJiOtFYIC7QB1TlWpzu
        Gk5fA2LadXXC20a6QQjxM9V9
X-Google-Smtp-Source: ABdhPJwJPMAgTxCR9XDqmuIUqppz4Gli6VJuXH7xTDCYIlqs2VT9w+p7iYuZmUzIkF1cpjcumfCK+w==
X-Received: by 2002:a17:906:c943:: with SMTP id fw3mr46063060ejb.55.1594119219778;
        Tue, 07 Jul 2020 03:53:39 -0700 (PDT)
Received: from [192.168.33.195] (fastree1.epfl.ch. [192.26.37.52])
        by smtp.gmail.com with ESMTPSA id x19sm24542135eds.43.2020.07.07.03.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 03:53:39 -0700 (PDT)
From:   Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
X-Google-Original-From: Adrian Fiergolski <Adrian.Fiergolski@fastree3d.com>
Subject: Re: [PATCH v2 1/2] spi: Add the SPI daisy chain support.
To:     Mark Brown <broonie@kernel.org>
Cc:     geert@linux-m68k.org, lukas@wunner.de,
        kernel test robot <lkp@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202007040833.xIqR5rAw%lkp@intel.com>
 <20200706092247.20740-1-adrian.fiergolski@fastree3d.com>
 <20200706161810.GB6176@sirena.org.uk>
Message-ID: <0072bb03-d6ec-38b8-0c31-61571b77bf93@fastree3d.com>
Date:   Tue, 7 Jul 2020 12:53:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200706161810.GB6176@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 06.07.2020 18:18, Mark Brown wrote:
> On Mon, Jul 06, 2020 at 11:22:43AM +0200, Adrian Fiergolski wrote:
>
> Please don't send new patches in reply to old threads, it buries them
> and can be confusing.

Ok, thanks. It's my debut in sharing a complete driver patch ;-)

>
>> The implementation is transparent for the SPI devices and doesn't require
>> their modifications. It is based on a virtual SPI device (spi-daisy_chain)
>> and defines two required device tree properties ('spi-daisy-chain-len' and
>> 'spi-daisy-chain-noop') and one optional
> It would really help to have an example of how a client device will use
> this, right now it's a bit hard to follow.  Overall it feels like this
> should be better abstracted, right now there's lots of ifdefs throughout
> the code which make things unclear and also seem like they're going to
> be fragile long term since realistically very few systems will be using
> this.  Perhaps this needs to be a library for devices that can daisy
> chain?  It does feel like the instances should be aware of each other
> since half the point with building the hardware like this is that it
> enables operations on multiple devices to happen in sync.

Well, I assume that one can connect completely different SPI devices on
a single daisy chain. In order to address all devices in a single
access, a controller would need to delay a transaction, wait for a
certain moment (how long?), synchronise and then transfer the message. I
think it adds unnecessary complexity, as MHO many engineers' issue at
the moment, including myself, is hardware implementing SPI daisy chain
without any support in the kernel. Usually, those are simple devices
where performance is not critical, which need to be accessed only once
or sporadically.

>
> There are also pervasive coding style issues which are really
> distracting.
>
>>  drivers/spi/spi-daisy_chain.c       | 428 ++++++++++++++++++++++++++++
> Please use - and _ consistently.
Basing on other drivers, I understood that the convention is 'spi-name'.
My idea was that name is daisy_chain.
>
>> @@ -55,6 +55,14 @@ config SPI_MEM
>>  	  This extension is meant to simplify interaction with SPI memories
>>  	  by providing a high-level interface to send memory-like commands.
>>  
>> +config SPI_DAISY_CHAIN
>> +	bool "SPI daisy chain support"
>> +	depends on OF
> Please keep Makefile and Kconfig sorted.
To be done in v3.
>
>> +++ b/drivers/spi/spi-daisy_chain.c
>> @@ -0,0 +1,428 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +/*
>> + * A driver handling the SPI daisy chaines.
> Please make the entire comment block a C++ to make things look more
> intentional.
To be done in v3.
>
>> +	int rc;
>> +
>> +	//the device is not part of a daisy-chain
>> +	if (spi->daisy_chain_devs == NULL)
> Coding style for the comment here and throughout the code.  If your code
> doesn't visually resemble the normal coding style for the code base
> you're working on then that is a bit of a red flag when reviewing.
Do you mean '//' vs '/*' ? In the spi.c I tried to follow the original
style. In spi-daisy_chain.c, which is a new driver added by myself, I
used '//' which is me personal preference. Is it wrong approach in your
opinion?
>
>> +	if (!list_is_singular(&message->transfers)) {
>> +		dev_err(&spi->dev,
>> +			"Mutliple transfer segments are not support when on daisy chain");
>> +		return -EINVAL;
>> +	}
> That seems excessively restrictive?
Well, with multiple transfers, drivers could request deactivation of SS
in between them. That would break the daisy chain, as data is latched in
all devices once SS is de-asserted. How such a transaction should be
then handled? Do you know any example of drivers/devices using multiple
transfers?
>
>> +			//check if frequency is not being changed
>> +			if (tr->speed_hz && tr->speed_hz != spi->max_speed_hz) {
>> +				dev_err(&spi->dev,
>> +					"Change of SPI frequency not supported when on daisy chain");
>> +				return -EINVAL;
>> +			}
> Again this seems unreasonably restrictive, especially given the above
> single transfer restriction which means the speed can't change during a
> message?
We could allow here also slower transfers.

A person defining the daisy chain in the DT knowns the maximum frequency
(aka propagation delays between different components on PCB + internal
timing of the devices) at which the whole chain operates properly. Thus,
the transfer speed of the message can't violate this upper limit.
>
>> +			if (tr->len == spi_chain_dev->no_operation.len) {
>> +				tr->bits_per_word = spi_chain_dev->no_operation
>> +							    .bits_per_word;
>> +				tr->cs_change = 0;
>> +
>> +				list_add_tail(&tr->transfer_list,
>> +					      &message->transfers);
>> +			}
>> +			//daisy chain operation has different than regular length
>> +			else {
> Coding style on both the if () and placement of the comment.
It was corrected like that by clang-format-buffer in emacs which uses
the format defined in the kernel source-tree.
>
>> +				//copy tx buffer
>> +				if (tr->tx_buf) {
>> +					ntr->tx_buf =
>> +						kmalloc(ntr->len, GFP_KERNEL);
>> +					if (!ntr->tx_buf) {
>> +						rc = -ENOMEM;
>> +						goto err_out;
>> +					}
> Why is this not a kmemdup()?
Not really. Due to SPI big-endiannes, one needs to apply padding
(right-justification) properly at the beginning of the new buffer. I
have been looking for some kernel function, which would copy the buffers
from their ends in the reverse order. I haven't found a good candidate.
Any suggestion?
>
>> +					//The daisy-chain padding is assumed to be right-justified,
>> +					//so unused tx bits are transferred first
>> +					memcpy((void *)((char *)ntr->tx_buf +
>> +							ntr->len - tr->len),
>> +					       tr->tx_buf, tr->len);
> These casts shouldn't be needed, especially the cast to void * - if you
> need to cast to void * something bad is most likely happening.  Simiar
> issues apply in other places where you're casting.
tx_buf is 'const void*' in spi_transfer. spi-daisy_chain could allocate
a new spi_transfer with the extended tx_buffer, copy rest of fields from
the original one, swap the transactions in the message and eventually
(after transmission) copy back the rx buffer to the original transaction
and swap the transfers again. I think though, it's a bit of unnecessary
overhead. What do you think?
