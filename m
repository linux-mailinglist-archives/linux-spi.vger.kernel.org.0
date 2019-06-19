Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1D114BF12
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2019 18:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfFSQzG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Jun 2019 12:55:06 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45319 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFSQzG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Jun 2019 12:55:06 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so3926095lje.12
        for <linux-spi@vger.kernel.org>; Wed, 19 Jun 2019 09:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r2IBCsR+DBCmFXsQgJOCa0iOJ4+DHb5LSlJv8W/yew4=;
        b=Ilwg2t/tAfwWtwxGMOi/f/TwVB5gJhPw4EHrBebBI/LXpYo76z+3Z6Q1O6ZGiaBXPS
         Y0h6MCzqjjmMKwqFozGy8r7p8vh9aidR1YPJco3AYSX++Md8Pl+XksoLof8Wf0N4mY1X
         PL5KGyU8Q3jxybJd0aMY18lkLuJvbBbGzKRDJhWuN/iyn6XYSkoD20Kg6/2grvJD8IJY
         Naj4sTcxVAkuuH7p9MNPQp8GZEysFZbHP+c5DT4Wx2e2ZU6U4G5I3JBFmFGrFMBYZqWZ
         byyA8qGCdoxW17DaIOv0NMQM3xiT6GvwQ3+Eozz1psSgN6NBQhrNX2rSq+RWoB0DU41Y
         uj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=r2IBCsR+DBCmFXsQgJOCa0iOJ4+DHb5LSlJv8W/yew4=;
        b=kf5bctBk6whzdBQt2jx+lLR+zpdPvXPm6yfo8vIVgcRl8McK627FTLyEZ9Jw4PhweK
         ViUOWvXMjYUcbPxfOq3cGtCQOPKb7hE1xU8k6smb1k4sa5SCyi0YaRbWBDAKPvJA0XO7
         XlfHQ3N9FWRqQXX979mvk1Pt9dED/RlU+rNSIEdeLuOLHI8LbTQCfrXxIisvon9kDvzU
         I+OjSxVrQSs8D3RzQVEMCxPeYAP2PSTlSplYV6tGh0cW9wrLgF5hdEmUkPHFUSraxSFi
         vlmijDphr4WWHzWihiqddM6y9t5gEQjyQ40wJ9KO80PciXE3xa3GbnMSNBDLK75a8zgr
         DnZA==
X-Gm-Message-State: APjAAAXsmW+9z5OUYOBvxil4P9lvU/rRtSJXXVgsj6ACD6EOvVQ81w1D
        PxUija3WIxm7ghszCYzsaW1zH+MDQdc=
X-Google-Smtp-Source: APXvYqx8UPaLj8WdIUTrVC3E7PNb43tr7akho7MVkHK7tyOBwSGWGu3wsZb6Cs3qDJ3p6OOpMBVYSw==
X-Received: by 2002:a2e:824d:: with SMTP id j13mr65896443ljh.137.1560963304338;
        Wed, 19 Jun 2019 09:55:04 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.80.22])
        by smtp.gmail.com with ESMTPSA id x79sm2747018lff.74.2019.06.19.09.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 09:55:03 -0700 (PDT)
Subject: Re: [PATCH RFC 2/2] mfd: add Renesas RPC-IF driver
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi <linux-spi@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>
References: <20190612090552.GD4797@dell>
 <41d74ecf-c939-27e1-4ef2-ad052b4e924b@cogentembedded.com>
 <20190617093048.GD16364@dell>
 <CAMuHMdX6GC2ZDam=odC-QFLUdrh1PYPVWEo5x3EHduqJ4FmTng@mail.gmail.com>
 <20190618091955.GN16364@dell>
 <CAMuHMdX7fFSO25TPJA9PO=VQC0czKux8nritMeffBcnaxr=WMQ@mail.gmail.com>
 <20190618095741.GA18371@dell>
 <CAMuHMdX829_CFGt53fS4nd9=qdS479OvJXYY3++DZ=4fLmp62w@mail.gmail.com>
 <20190618113426.GD18371@dell>
 <303086dc-5ec0-f46d-3e41-8f12878f5db0@cogentembedded.com>
 <20190619061858.GI18371@dell>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <0e609c19-f825-40c3-1b6b-fd87b2779ad3@cogentembedded.com>
Date:   Wed, 19 Jun 2019 19:55:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190619061858.GI18371@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 06/19/2019 09:18 AM, Lee Jones wrote:

>>>>>>> So is an RPC-IF a real hardware device.  Can you share the datasheet?
>>>>>>
>>>>>> Unfortunately the datasheet for the R-Car Gen3 and RZ/G2 SoCs is
>>>>>> not yet public.
>>>>>
>>>>> When will it be public?
>>>>
>>>> Dunno. RZ/G1 documentation became public a few months after the SoC
>>>> release.
>>>>
>>>>> Do you have access to it?
>>>>
>>>> Yes I do.
>>>
>>> Great.  Maybe you can help Sergei with his 'undocumented bits' issue.
>>
>>    You're an optimist. :-)
>>    I think I have the same gen3 manual v1.50 as Geert. It won't help as the
>> bits that constitute the magic numbers in the driver are not described (not
>> even the default values are listed for the most of them).
> 
> Then how did you get hold of them?

   Mason did, not me. And they were copied from the bootloader, IIRC.

>>>>>> However, a very similar hardware block is present in the RZ/A2M SoC.
>>>>>> Please see Chapter 20 ("SPI Multi I/O Bus Controller") of the "RZ/A2M Group
>>>>>> User’s Manual: Hardware", which you can download from
>>>>>> https://www.renesas.com/eu/en/products/microcontrollers-microprocessors/rz/rza/rza2m.html#documents
>>>>>
>>>>>   "The SPI multi I/O bus controller enables the direct connection of
>>>>>    serial flash, OctaFlashTM, XccelaTM flash, or HyperFlashTM memory
>>>>>    devices to this LSI chip.
>>>>>
>>>>>    This module allows the connected serial flash, OctaFlashTM, XccelaTM
>>>>>    flash, or HyperFlashTM memory devices to be accessed by reading the
>>>>>    external address space, or using Manual mode to transmit and receive
>>>>>    data."
>>>>>
>>>>> Looks like a flash device to me.
>>>>
>>>> The external address space is a small window.
>>
>>    Yeah, it only provides 64 MiB window into the flash chip.
>>
>>>>> Can the SPI portion be used to connect generic SPI devices?
>>>>
>>>> I'll defer that to the people who worked on the driver...
>>
>>    Yes. Or at least it should, looking at the driver code...
> 
> Judging by that response, I'm guessing that this is unused/untested.

   I certainly haven't tested it, perhaps Mason did?

MBR, Sergei
