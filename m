Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599942ABD91
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 14:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbgKINrO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 08:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729974AbgKINrN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 08:47:13 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C688C0613CF;
        Mon,  9 Nov 2020 05:47:13 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id ed14so4023687qvb.4;
        Mon, 09 Nov 2020 05:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3P4Xy4X3O8T4Nf4PgfEYUgS4xFf3jYJhHCyEVrGcPOA=;
        b=CnkNa2H+6dHsGG7oCncPC1SvCVCwADCa9oL2vYqCUUL6ad1Mh28I2FOsrm9mgoH5WX
         g55LdA13TrGDSXZ055BjdxAzQ0M9jIyGi3wzjqndyaXTv0IBwgw7Pc8MVJ5RDDjAgcIt
         9ZR/1NXyTe7eLwblNB2plK5rsEMXcvcwrdKR3H2HTUllWkHNWUDrjyXm4oW2D0s72FOC
         zbg5CnVzs0TFt18VD/0akL0kKhkS2osuOx3UfPkM7UXHtE50ZJcrVUQ4wuc+5WMA1Cms
         hxWduHV+ffDJv0vlyOKvQsrU7c6OZuTvDYzNHKaSkBYFVxPVQkjnbZeHw7JJz4xD8F2Q
         e34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3P4Xy4X3O8T4Nf4PgfEYUgS4xFf3jYJhHCyEVrGcPOA=;
        b=FtKc5rAT+AN6p3sV7dcYeq8yrw1vNkMlvjQTb77zzMP4kYMrnUspGSHgzd7nXlWxGR
         4/pgoa1MCtCFV2LU2JYdLzNQsNx4wPtE+SKcKQe5rwpu6QI4MGW8ad98esVwGWHaraPM
         fijVJsCkuwK2r9rLKItzjyTZvKlRjcejpVoxXRz5ZQPcjTey+EaOLnDPjVC4C1VHenAC
         scSjIdFdhwk2ZBJxDgssKnf1a+bMZ44hzK7VVQ/vPR4HD73TiHZXrnA9HRNwgn+NxpEO
         vmlX4ggenQ7q+gOx4ZBIQjC+3yrbnonkdwZwlEMKH9BrqrRhhj82a/9MQiTHbnFBvJ+e
         Hbog==
X-Gm-Message-State: AOAM531mwZFkTwnvhpcbisC5g2f5FVDy8gQL8ILDpgIVTXImJ3dL/k1I
        d2BDcKqxuntMmwBGPkd5LhQ=
X-Google-Smtp-Source: ABdhPJzU05Fw0kzNgO7z+uoXZtYaKr3IfKDrqYuQ/4WUNUe6l+9tEW5JmP/HvpwEVZFqdcj9iMWp3Q==
X-Received: by 2002:ad4:4e2f:: with SMTP id dm15mr1130200qvb.7.1604929632527;
        Mon, 09 Nov 2020 05:47:12 -0800 (PST)
Received: from [192.168.1.201] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id j50sm6081221qtc.5.2020.11.09.05.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 05:47:11 -0800 (PST)
Subject: Re: [PATCH 03/32] spi: dw: Fix driving MOSI low while recieving
To:     Mark Brown <broonie@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        linux-spi@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-4-damien.lemoal@wdc.com>
 <20201109132935.GB6380@sirena.org.uk>
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
Message-ID: <c37ca9be-ea92-b07a-b600-d68de4f7bde5@gmail.com>
Date:   Mon, 9 Nov 2020 08:47:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201109132935.GB6380@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11/9/20 8:29 AM, Mark Brown wrote:
> On Sat, Nov 07, 2020 at 05:13:51PM +0900, Damien Le Moal wrote:
> 
>> The resting state of MOSI is high when nothing is driving it. If we
>> drive it low while recieving, it looks like we are transmitting 0x00
>> instead of transmitting nothing. This can confuse slaves (like SD cards)
>> which allow new commands to be sent over MOSI while they are returning
>> data over MISO. The return of MOSI from 0 to 1 at the end of recieving
>> a byte can look like a start bit and a transmission bit to an SD card.
> 
> If client devices are interpreting the transmitted data then I would
> expect the drivers for that hardware to be ensuring that whatever we
> transmit matches what the device is expecting.  We shouldn't be putting
> a hack in a particular controller driver to paper over things, that will
> mean that the device will break when used with other controllers and if
> different devices have different requirements then obviously we can't
> satisfy them.  There is not meaningfully a general specification for SPI
> which says what happens when signals are idle, it's all specific to the
> client device.
>
> In this case it also looks like the controller hardware requires
> transmit data and therefore should be setting SPI_MUST_TX and just
> removing the in driver default anyway, though that will have no effect
> one way or anther on the issue you're seeing.

There is a recieve-only mode, but it is not used by this driver. Perhaps
it should be.

> Please also try to avoid the use of master/slave terminology where
> reasonable, controller and device tend to work for SPI (though MOSI/MISO
> are going to be harder to shift).

Here I use it to draw distinction between the SPI master and the SPI
slave, which are both devices in different contexts. 

--Sean
