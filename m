Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 232F84D9A9
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2019 20:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfFTSp3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jun 2019 14:45:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44470 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfFTSp3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Jun 2019 14:45:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id k18so3637105ljc.11
        for <linux-spi@vger.kernel.org>; Thu, 20 Jun 2019 11:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W45OWsFB7NJo4wygppq2k0Qj2wwD7bNHrgx+G01jlR8=;
        b=FnjV2XpWf5Ab22ncYVqvlyo39Cxb8tHIGrlAdKaIWxIWpPWoxcUtX7Nib+oYXR3GaX
         IW19dbz/fzExkoo9JoJr0ue80z20akEDd1br7mxe71WTpPyDV3vADOBfUEZSE69B54cq
         oooEDBv7u321tJ1M398GQqwhMkZ4ZfP1wC61pPiqxtE/GvPsZsYhXdfpJNhIgIK8teJw
         VxtnrQfH+uAY2Vg1tRPY8e911PpumcxECi5ink7zEgO8aUbP7WiHg9x8dtqje8Crz9Xc
         6m4CR2BEzZXeEJ/PTT7tWlOhYGsTajyyK3hYVxhYl03GobClo3zI+uaLem6EAxKuaMMw
         inLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=W45OWsFB7NJo4wygppq2k0Qj2wwD7bNHrgx+G01jlR8=;
        b=BJT1b/V4AtIodkcYMOvXb2FSIlUd7GxvMegmPdNGm+pR6tvo8G/Nr63SQ3iZSF2slN
         S7lBdCrAwSaS9a6KCwbjmE3piI/THGI+mt3ene+ups8w5MvmpnTdDHM6xsMK/KLc10YR
         5LMXr8j4cRFuXAYYWN5cUc6O0UJt+nqelEO8Qx+hPASVMFAwfd/X+JZlTp30wJFQBl92
         NUsxtN3qYOdOFXxCkHbuXzFfmWqTRBsYQxGCz6cRcROtXdK35HjkWxZeWrVWAOKdhhYG
         dx1Bwsa5LnFPG30ZWg9ykRQeYkuXYH5Mm7J8cVzRzYCtgRdjTBgygKoceS3D+/QntvWA
         fkqw==
X-Gm-Message-State: APjAAAVT3J72dNwKXaqAfSMpe5Nt4ArLNbaSb+nByV3FFteSxDnLs8Df
        CJA8FSujx6Rx0ETUv4k6je/UNVMgLbM=
X-Google-Smtp-Source: APXvYqzqyJAU99j36FXe7G378crwvtmDYmahwDrHbtHISu65eBWyrv8t39wBGQoQ0unvY87q16aCWw==
X-Received: by 2002:a2e:968f:: with SMTP id q15mr5915116lji.30.1561056326157;
        Thu, 20 Jun 2019 11:45:26 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.80.47])
        by smtp.gmail.com with ESMTPSA id 137sm54130ljj.46.2019.06.20.11.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 11:45:25 -0700 (PDT)
Subject: Re: [PATCH RFC 2/2] mfd: add Renesas RPC-IF driver
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Mason Yang <masonccyang@mxic.com.tw>, linux-spi@vger.kernel.org
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
 <1538cadb-7c6a-2c4c-fe8c-960b25286950@cogentembedded.com>
 <20190612090552.GD4797@dell>
 <41d74ecf-c939-27e1-4ef2-ad052b4e924b@cogentembedded.com>
 <20190617093048.GD16364@dell>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <07603eca-7e4b-e244-781f-e391c1a87319@cogentembedded.com>
Date:   Thu, 20 Jun 2019 21:45:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190617093048.GD16364@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 06/17/2019 12:30 PM, Lee Jones wrote:

>>>> Add the MFD driver for Renesas RPC-IF which registers either the SPI or
>>>> HyperFLash  device depending on the contents of the device tree subnode.
>>>> It also provides the absract "back end" device APIs that can be used by
>>>> the "front end" SPI/MTD drivers to talk to the real hardware.
>>>>
>>>> Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.
>>>>
>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> [...]
>>>> Index: mfd/drivers/mfd/rpc-if.c
>>>> ===================================================================
>>>> --- /dev/null
>>>> +++ mfd/drivers/mfd/rpc-if.c
>>>> @@ -0,0 +1,535 @@
[...]
>>>> +#define RPCIF_DIRMAP_SIZE	0x4000000
>>>
>>> Can you shift this lot out to a header file please.
>>
>>    You mean all register #defne's? Why? I'm not intending to use them outside
>> this file.
> 
> Because its 10's of lines of cruft.

   Thank you! :-)

> People won't want to wade through that to get to real functional C
> code every time they open up this file.

   This is how the most drivers are written.

> You already have a header file, please use it.

   Headers are for public things. I've encapsulated the h/w assess into
the MFD driver, the client code doesn't have to see all the gory hardware
details... IOW, I don't agree to this request.

>>>> +void rpcif_enable_rpm(struct rpcif *rpc)
>>>> +{
>>>> +	pm_runtime_enable(rpc->dev);
>>>> +}
>>>> +EXPORT_SYMBOL(rpcif_enable_rpm);
>>>> +
>>>> +void rpcif_disable_rpm(struct rpcif *rpc)
>>>> +{
>>>> +	pm_runtime_disable(rpc->dev);
>>>> +}
>>>> +EXPORT_SYMBOL(rpcif_disable_rpm);
>>>
>>> Where are you exporting these out to?
>>
>>    The "sub-drivers" (SPI/HyperFlash-to-RPC translation drivers).
>>
>>> Why are you seemingly unnecessarily abstracting out the pm_* API?
>>
>>    With RPM being otherwise controlled by this driver, I thought that should be
>> consistent.
> 
> Just use the pm_runtime_*() API directly.

   This would go against the driver encapsulation as well, I would leave it
as is...

>>>> +void rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
>>>> +{
>>>> +	pm_runtime_get_sync(rpc->dev);
>>>> +
>>>> +	/*
>>>> +	 * NOTE: The 0x260 are undocumented bits, but they must be set.
>>>> +	 *	 RPCIF_PHYCNT_STRTIM is strobe timing adjustment bit,
>>>> +	 *	 0x0 : the delay is biggest,
>>>> +	 *	 0x1 : the delay is 2nd biggest,
>>>> +	 *	 On H3 ES1.x, the value should be 0, while on others,
>>>> +	 *	 the value should be 6.
>>>> +	 */
>>>> +	regmap_write(rpc->regmap, RPCIF_PHYCNT,
>>>> +		     RPCIF_PHYCNT_CAL | RPCIF_PHYCNT_STRTIM(6) |
>>>> +		     RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0) | 0x260);
>>>
>>> At least #define it, even it it's not documented.
>>
>>    Do you have an idea how to name such #define?
> 
> How did you find out that they must be set?

   Mason lifted all this "magic" from the bootloader's driver.

> How did you find out the value?

> What happens if they are not set?

   Don't know, maybe Mason does. :-)

[...]
>>>> +static int wait_msg_xfer_end(struct rpcif *rpc)
>>>> +{
>>>> +	u32 sts;
>>>> +
>>>> +	return regmap_read_poll_timeout(rpc->regmap, RPCIF_CMNSR, sts,
>>>> +					sts & RPCIF_CMNSR_TEND, 0,
>>>
>>> Aren't you using sts undefined here?
>>
>>    No, the macro reads 'sts' from the register first.
> 
> That's confusing and ugly.
> 
> Please re-write it to the code is clear and easy to read/maintain.

   OK, I will look into this...

[...]

>>> Looking at all this code from here ...

[...]

>>> ... to here.
>>>
>>> Not sure what all this is, but it looks like it doesn't have anything
>>
>>    This is an abstracted "back end" API for the "front end" MTD/SPI drivers.
>> Only this code talks to real RPC-IF hardware. Probably needs some kernel-doc...
> 
> I suggest this needs moving out to a suitable subsystem.
> 
> Possibly MTD.
> 
>>> to do with MFD.  I suggest you move it to somewhere more appropriate.
>>
>>    Like where?
> 
> MTD?

   Well, the new idea is /drivers/memory/, right?

>>>> +static const struct mfd_cell rpcif_hf_ctlr = {
>>>> +	.name = "rpcif-hyperflash",
>>>> +};
>>>> +
>>>> +static const struct mfd_cell rpcif_spi_ctlr = {
>>>> +	.name = "rpcif-spi",
>>>> +};
>>>
>>> This looks like a very tenuous use of the MFD API.
>>>
>>> I suggest that this isn't actually an MFD at all.
>>
>>    The same hardware supports 2 different physical interfaces, hence
>> the drivers have to comply to 2 different driver frameworks... sounded
>> like MFD to me. :-)
> 
> Not to me.
> 
> This appears to be some kind of 'mode selector' for an MTD device.
> 
> Lots of drivers have multiple ways to control them - they are not all
> MFDs.

   OK, sounds like drivers/mfd/ are for a single device having multiple
distinct subdevices, right?

>> [...]
>>>> +static int rpcif_probe(struct platform_device *pdev)
>>>> +{
>>>> +	struct device_node *flash;
>>>> +	const struct mfd_cell *cell;
>>>> +	struct resource *res;
>>>> +	void __iomem *base;
>>>> +	struct rpcif *rpc;
>>>> +
>>>> +	flash = of_get_next_child(pdev->dev.of_node, NULL);
>>>> +	if (!flash) {
>>>> +		dev_warn(&pdev->dev, "no flash node found\n");
>>>> +		return -ENODEV;
>>>> +	}
>>>> +
>>>> +	if (of_device_is_compatible(flash, "jedec,spi-nor")) {
>>>> +		cell = &rpcif_spi_ctlr;
>>>> +	} else if (of_device_is_compatible(flash, "cfi-flash")) {
>>>> +		cell = &rpcif_hf_ctlr;
>>>> +	} else {
>>>> +		dev_warn(&pdev->dev, "unknown flash type\n");
>>>> +		return -ENODEV;
>>>> +	}
>>>
>>> Why not let DT choose which device to probe?
>>
>>    It's the DT that decides here. How else would you imagine that?
>> It's the same hardware, just the different physical busses that it
>> commands...
> 
> DT is not deciding here.  This driver is deciding based on the
> information contained in the tables - very different thing.

   Well, both are done in software. :-)

> Why not just let the OF framework probe the correct device i.e. let it
> parse the 2 compatible strings and let it match the correct driver for
> the device?

   That doesn't go well with the DT spec, I'm afraid. And much code would be
duplicated in case of 2 independent drivers...

MBR, Sergei
