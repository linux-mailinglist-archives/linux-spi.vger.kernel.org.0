Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 771D54AAFF
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2019 21:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbfFRT0k (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jun 2019 15:26:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40826 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfFRT0k (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jun 2019 15:26:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id a9so10177649lff.7
        for <linux-spi@vger.kernel.org>; Tue, 18 Jun 2019 12:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HROWi8K4HXdzUCYwxLZe1u0Cnnb02XdsZl/IiAvrnbA=;
        b=pt3a6wGYV1gIUfHJ6/e9IVNgtmcG2T8rChDFBvnHKyHCntcyyNq57SMnneNkoaxKlP
         9O432aksDeW+N5tepJDb+KXliJVrNq1wTc3abE6i6+eXbHtYBEvjHqa06pIqrY35ENX6
         +kD7nVYS9K9hGGRsqTqosHSTavdaZ2KN/R4vsb9Z1jxFyNaRlrS8UVFyt+rwvaXuO/ay
         6coIKtaalnvZBnTiApRnX9CF5xQNLz9zSTRLzSY14IsAlJ7+yRZoBClE3/NNx4mUVyPl
         PtHMTxkL+K/4+o2Nvsspzc2EmwARw8uAfHgqH25RSkHTO8RgWo/sGQ1sWtVSpAl2AK1y
         g3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HROWi8K4HXdzUCYwxLZe1u0Cnnb02XdsZl/IiAvrnbA=;
        b=KRFRCpdHJA/0iCrJSY4tfTwp4j2d0Dmpf5HAryWa4+0aIAoX498C4jVHvN79DpJerD
         CzkI+wIcY8LfuU2LmcQmCJuEyy+OKtqEUX2L4QxxDZDRiXy2GB8HCT1wzWzvVs4xlGG1
         hqbGDvepi0T1iedoa5iyHiWXbvHUtfYRbuC98P3P0sLFE4TRypANiLT+vR6d6puYnmZw
         aV25/eM1zePE7KX06bOiZOK/hLp8sw2k/XEy5OiBbgtKZm4jvQ/qyaorJMusJ/ljHcXK
         5NEhfdeeXgFpzrB0/T9KR17PvjIQ1RuMnIRu/a6n9GZjBmmhHxFcYXOGr3SFT9AlfKXz
         C/mg==
X-Gm-Message-State: APjAAAU8z49JsR3R/ews1AOTsqhLtqlkSpZtFwl7D7bD9A9wOt1WhNqH
        CrQPsZdSdK1PPLo/v/li6cUu5bC0Vew=
X-Google-Smtp-Source: APXvYqw5rIDOsvHDdgcSc0yU3OxbDkVtPOsLdXBOvlvDoL+fEMowCrJ34eSBiCkXppGG8s17rUc77Q==
X-Received: by 2002:a19:4f50:: with SMTP id a16mr58641484lfk.24.1560885997379;
        Tue, 18 Jun 2019 12:26:37 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.80.4])
        by smtp.gmail.com with ESMTPSA id m28sm2732697ljb.68.2019.06.18.12.26.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 12:26:36 -0700 (PDT)
Subject: Re: [PATCH RFC 2/2] mfd: add Renesas RPC-IF driver
To:     Lee Jones <lee.jones@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi <linux-spi@vger.kernel.org>
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
 <1538cadb-7c6a-2c4c-fe8c-960b25286950@cogentembedded.com>
 <20190612090552.GD4797@dell>
 <41d74ecf-c939-27e1-4ef2-ad052b4e924b@cogentembedded.com>
 <20190617093048.GD16364@dell>
 <CAMuHMdX6GC2ZDam=odC-QFLUdrh1PYPVWEo5x3EHduqJ4FmTng@mail.gmail.com>
 <20190618091955.GN16364@dell>
 <CAMuHMdX7fFSO25TPJA9PO=VQC0czKux8nritMeffBcnaxr=WMQ@mail.gmail.com>
 <20190618095741.GA18371@dell>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <ff85a907-8f26-5e80-c7f0-655ca11afe25@cogentembedded.com>
Date:   Tue, 18 Jun 2019 22:26:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190618095741.GA18371@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 06/18/2019 12:57 PM, Lee Jones wrote:

[...]
>>>>>>>> +static int rpcif_probe(struct platform_device *pdev)
>>>>>>>> +{
>>>>>>>> +  struct device_node *flash;
>>>>>>>> +  const struct mfd_cell *cell;
>>>>>>>> +  struct resource *res;
>>>>>>>> +  void __iomem *base;
>>>>>>>> +  struct rpcif *rpc;
>>>>>>>> +
>>>>>>>> +  flash = of_get_next_child(pdev->dev.of_node, NULL);
>>>>>>>> +  if (!flash) {
>>>>>>>> +          dev_warn(&pdev->dev, "no flash node found\n");
>>>>>>>> +          return -ENODEV;
>>>>>>>> +  }
>>>>>>>> +
>>>>>>>> +  if (of_device_is_compatible(flash, "jedec,spi-nor")) {
>>>>>>>> +          cell = &rpcif_spi_ctlr;
>>>>>>>> +  } else if (of_device_is_compatible(flash, "cfi-flash")) {
>>>>>>>> +          cell = &rpcif_hf_ctlr;
>>>>>>>> +  } else {
>>>>>>>> +          dev_warn(&pdev->dev, "unknown flash type\n");
>>>>>>>> +          return -ENODEV;
>>>>>>>> +  }
>>>>>>>
>>>>>>> Why not let DT choose which device to probe?
>>>>>>
>>>>>>    It's the DT that decides here. How else would you imagine that?
>>>>>> It's the same hardware, just the different physical busses that it
>>>>>> commands...
>>>>>
>>>>> DT is not deciding here.  This driver is deciding based on the
>>>>> information contained in the tables - very different thing.
>>>>>
>>>>> Why not just let the OF framework probe the correct device i.e. let it
>>>>> parse the 2 compatible strings and let it match the correct driver for
>>>>> the device?
>>>>
>>>> The OF framework matches against the RPC-IF node, which is a single
>>>> hardware type, hence has a fixed compatible value.
>>>> The mode depends on the subnode in DT, which is something the OF
>>>> framework doesn't match against, so the driver itself has to check the
>>>> subnode's compatible value.
>>>
>>> I can see how it has been implemented.
>>>
>>> It is that which I was questioning.
>>>
>>>> DT describes hardware, not software (Linux subsystem boundary) policy.
>>>
>>> So is an RPC-IF a real hardware device.  Can you share the datasheet?
>>
>> Unfortunately the datasheet for the R-Car Gen3 and RZ/G2 SoCs is
>> not yet public.
> 
> When will it be public?

   Ask Renesas. :-)

> Do you have access to it?

   We do...

> Maybe someone who does can help with the magic number definitions.

   Not very likely. :-)

>> However, a very similar hardware block is present in the RZ/A2M SoC.
>> Please see Chapter 20 ("SPI Multi I/O Bus Controller") of the "RZ/A2M Group
>> User’s Manual: Hardware", which you can download from
>> https://www.renesas.com/eu/en/products/microcontrollers-microprocessors/rz/rza/rza2m.html#documents

   Also, there's RZ/A1 where a previous version of this hardware seems to be used, see chapter 17
(SPI Multi I/O Bus Controller) of the RZ/A1H/M manual, downloadable from:
https://www.renesas.com/us/en/products/microcontrollers-microprocessors/rz/rza/rza1h.html#documents

>   "The SPI multi I/O bus controller enables the direct connection of
>    serial flash, OctaFlashTM, XccelaTM flash, or HyperFlashTM memory
>    devices to this LSI chip.> 
>    This module allows the connected serial flash, OctaFlashTM, XccelaTM
>    flash, or HyperFlashTM memory devices to be accessed by reading the
>    external address space, or using Manual mode to transmit and receive
>    data."

   For contrast, RZ/A1 didn't yet support OctaFlash and HyperFlash, and R-Car gen3 RPC-IF doesn't
support Xccella yet...

> Looks like a flash device to me.

   More like a multi-protocol flash controller, with the real flash chip connected
to it.

MBR, Sergei
