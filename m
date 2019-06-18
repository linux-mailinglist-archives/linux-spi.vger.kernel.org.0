Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA9F94A9DA
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2019 20:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfFRSbD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jun 2019 14:31:03 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40243 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729983AbfFRSbD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jun 2019 14:31:03 -0400
Received: by mail-lj1-f196.google.com with SMTP id a21so546152ljh.7
        for <linux-spi@vger.kernel.org>; Tue, 18 Jun 2019 11:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gyNy15hElQfb6faJOYdlciqBwgo+KH0lw2hUWWK86b8=;
        b=v3ECDDht1j/1ajxlHK1TBKMokOCsPwVwCJv1s5FX2VIz7evVNajnBil1sAVB4F5EqN
         tu9riLr56T+/EDPKwnmS9vmhtMvCqZ/s+uQg4VLoCV3thOSP/vqVVF5F7kIgEAs89aPy
         GHMDRpMVSHzPmkXOba4petvbVVzzv9m96VjcPCHuxPuHPigKS020vufpZayQMgfWx3He
         vUCV9R6U12WU3BB4qhtLtfnnaNIZVF2jwwFuuRJyLOh6djgIx6PnU14V2osmEjRmV9Z6
         rW6JOmlfCF32tcq+kH1we1bGBX44N/ti0ZorfdlABN4pD4nINOmztZF+drHOdnRxgpKv
         jdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gyNy15hElQfb6faJOYdlciqBwgo+KH0lw2hUWWK86b8=;
        b=Y6GSJ83r2rTSpebrcSATaJyOfkm/RPFu/e65lb/n4K+DM/uIEljHS9FsFyD6bBkqbN
         cBGY3VaccLcZ2KF3uMJvLdbO3AOdzWl7osbpXgptTFXOE5es0KE32ndg5zfnh8Z9dw4E
         gVb6TiOLSOARp7UzsGTwAZZpbiUr47S70q/Tk9QB0lGQugNsw1T9Ms6exKKMJHJDBWCk
         pPRDyP8GhIsjTg7M87SSmIylcKTN8jBIUpzzkVHoltONo4Cg7GE5uYN+oaZVOVcuuIPs
         nD7X/HxcrV+Q9OmxcUT5Fm+VMzxL/BmZaa6f5rJOZ3eg31ouHpxIOd0twfm7A6HrZOV6
         DUxw==
X-Gm-Message-State: APjAAAWE726csLXlMBPcT0Qa+FbM0sBzwCWP0w7HMGgLaqdD/pBXpCGe
        brpyKKBMN3isV9gQlXgKVEhFS1M9Kas=
X-Google-Smtp-Source: APXvYqz7C/JeiE5n6DJ9f1P4bIzriWRHgNnTOOtFSYc87M8kaQBVIYEpIrM/wKZ7eCB7sz9awMFyhw==
X-Received: by 2002:a05:651c:87:: with SMTP id 7mr46566135ljq.184.1560882661911;
        Tue, 18 Jun 2019 11:31:01 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.80.4])
        by smtp.gmail.com with ESMTPSA id k12sm2566743lfm.90.2019.06.18.11.31.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:31:01 -0700 (PDT)
Subject: Re: [PATCH RFC 2/2] mfd: add Renesas RPC-IF driver
To:     Lee Jones <lee.jones@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi <linux-spi@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
 <1538cadb-7c6a-2c4c-fe8c-960b25286950@cogentembedded.com>
 <20190612090552.GD4797@dell>
 <41d74ecf-c939-27e1-4ef2-ad052b4e924b@cogentembedded.com>
 <20190617093048.GD16364@dell>
 <CAMuHMdX6GC2ZDam=odC-QFLUdrh1PYPVWEo5x3EHduqJ4FmTng@mail.gmail.com>
 <20190618091955.GN16364@dell>
 <CAMuHMdX7fFSO25TPJA9PO=VQC0czKux8nritMeffBcnaxr=WMQ@mail.gmail.com>
 <20190618095741.GA18371@dell>
 <CAMuHMdX829_CFGt53fS4nd9=qdS479OvJXYY3++DZ=4fLmp62w@mail.gmail.com>
 <20190618113426.GD18371@dell>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <303086dc-5ec0-f46d-3e41-8f12878f5db0@cogentembedded.com>
Date:   Tue, 18 Jun 2019 21:30:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190618113426.GD18371@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello!

On 06/18/2019 02:34 PM, Lee Jones wrote:

>>>>> So is an RPC-IF a real hardware device.  Can you share the datasheet?
>>>>
>>>> Unfortunately the datasheet for the R-Car Gen3 and RZ/G2 SoCs is
>>>> not yet public.
>>>
>>> When will it be public?
>>
>> Dunno. RZ/G1 documentation became public a few months after the SoC
>> release.
>>
>>> Do you have access to it?
>>
>> Yes I do.
> 
> Great.  Maybe you can help Sergei with his 'undocumented bits' issue.

   You're an optimist. :-)
   I think I have the same gen3 manual v1.50 as Geert. It won't help as the
bits that constitute the magic numbers in the driver are not described (not
even the default values are listed for the most of them).

>>>> However, a very similar hardware block is present in the RZ/A2M SoC.
>>>> Please see Chapter 20 ("SPI Multi I/O Bus Controller") of the "RZ/A2M Group
>>>> User’s Manual: Hardware", which you can download from
>>>> https://www.renesas.com/eu/en/products/microcontrollers-microprocessors/rz/rza/rza2m.html#documents
>>>
>>>   "The SPI multi I/O bus controller enables the direct connection of
>>>    serial flash, OctaFlashTM, XccelaTM flash, or HyperFlashTM memory
>>>    devices to this LSI chip.
>>>
>>>    This module allows the connected serial flash, OctaFlashTM, XccelaTM
>>>    flash, or HyperFlashTM memory devices to be accessed by reading the
>>>    external address space, or using Manual mode to transmit and receive
>>>    data."
>>>
>>> Looks like a flash device to me.
>>
>> The external address space is a small window.

   Yeah, it only provides 64 MiB window into the flash chip.

>>> Can the SPI portion be used to connect generic SPI devices?
>>
>> I'll defer that to the people who worked on the driver...

   Yes. Or at least it should, looking at the driver code...

MBR, Sergei
