Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBB877AE71
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2019 18:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbfG3Qxx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Jul 2019 12:53:53 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43771 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfG3Qxx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Jul 2019 12:53:53 -0400
Received: by mail-lf1-f66.google.com with SMTP id c19so45230818lfm.10
        for <linux-spi@vger.kernel.org>; Tue, 30 Jul 2019 09:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dr5C7KQU9eOCQSa8blb+7TwHFoH/AQOPyjtbxZR3wEw=;
        b=n6VwzoC82cjLzaKyMS8TYJE21RybcmpxGRbyaDegPwja7yh9OImhVQ96rNFap2asR+
         AesvPOS6PMPKdIXBKXbBhS9JnXyov3teWpjDtcz1RAuF8uzkgWIwC1E2vJuycwXl7o4B
         1GBFQGSZ6HHgoU6h3Riq1tDwK9tN5+GB+PJawR9jmOqtLGLq0XnaMKPRe8QDNFinGNDv
         iHT0dy0E96DEOROAErzWARnrqfe0n4uaxaEDuTSGvcoVf1HAXitquQdneqDEzemhG7ec
         dMzo5x7GVe1M9hFoCSXWTeEqVdA+XECsKDOZEY9npRoButzNFXxnKzuOQquN76bSbb2e
         kwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Dr5C7KQU9eOCQSa8blb+7TwHFoH/AQOPyjtbxZR3wEw=;
        b=jcfiK0Yc0+aC03x5VgzS54a6Hl0TfyGrGf5SuWQ9XzyfHwH5APt/5azeKYSqeIu0ac
         aChss/yjd7IZynMeLezezT4tT3+0H4GIB4QxKwUfe7btK/k+OXVvw/3wRdJ0WV7uxf1n
         +o5Awe0xxkOFP6ALp2OOEvKY3wlE1BannkyNX8kPBZoQDvK18WyUzp08+RA++uRUsCUD
         dL2fpuLwoMAWIx0fbnbKRhVENlUdY7ujFYuq+7hg7EKy3V8X7CDpad/JuZ6B6topIyvv
         7+kjMZj1gS2yPM1NZzXjKFoW85pYBCKsMmSnrGgVh3FYAO19NKHLzhqbuEQ6AxwP3W1p
         b3Fw==
X-Gm-Message-State: APjAAAVXvuT6IPRndhJ6o7fo/uihLUY2/kEAzjCGGUg0VMeAyAqH6dZr
        Z0Vz7H9YCCYUY6p0VES+GZBFZeJ3Hxs=
X-Google-Smtp-Source: APXvYqwJvNf17IzLfphH3pMtcc+2Ne0XbkA7B9Qjxqb0xpsM3x4YTmfFl6y9Ur5HSRYGsOfd35JrdA==
X-Received: by 2002:a19:4f4a:: with SMTP id a10mr54759913lfk.30.1564505631521;
        Tue, 30 Jul 2019 09:53:51 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:4c5:af01:782b:483e:bc20:30b0])
        by smtp.gmail.com with ESMTPSA id v17sm15174582ljg.36.2019.07.30.09.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:53:50 -0700 (PDT)
Subject: Re: [RFC v1 0/3] *spi-mem: adding setup and callback function
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Tomer Maimon <tmaimon77@gmail.com>, vigneshr@ti.com
Cc:     broonie@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        bbrezillon@kernel.org, tudor.ambarus@microchip.com,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
References: <20190729142504.188336-1-tmaimon77@gmail.com>
 <20190729172859.4374a2ad@collabora.com>
 <CAP6Zq1iPXDX_Gtz6ZWYm3JoHgHjdapotVLGw-Lq4tc2X-6eAug@mail.gmail.com>
 <20190730085438.6fe0480b@collabora.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <2272f934-df83-bd6d-2aee-ac2d93799092@cogentembedded.com>
Date:   Tue, 30 Jul 2019 19:53:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190730085438.6fe0480b@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 07/30/2019 09:54 AM, Boris Brezillon wrote:

> Trimmed the recipient list a bit and used Frieder's new address.
> +Sergey

  TY. :-)

> On Mon, 29 Jul 2019 23:55:05 +0300
> Tomer Maimon <tmaimon77@gmail.com> wrote:
> 
>> Hi Boris,
>>
>> Thanks for the prompt reply,
>>
>>
>>
>> On Mon, 29 Jul 2019 at 18:29, Boris Brezillon <boris.brezillon@collabora.com>
>> wrote:
>>
>>> Hi Tomer,
>>>
>>> On Mon, 29 Jul 2019 17:25:01 +0300
>>> Tomer Maimon <tmaimon77@gmail.com> wrote:
>>>  
>>>> Lately we have working on Flash interface unit (FIU) SPI driver that
>>>> using spi-mem interface, Our FIU HW module support direct Flash Rd//Wr.
>>>>
>>>> In our SOC (32 bit dual core ARM) we have 3 FIU's that using memory  
>>> mapping as follow:  
>>>>
>>>> FIU0 - have 2 chip select and each one have 128MB memory mapping (total  
>>> 256MB memory mapping)  
>>>> FIU1 - have 4 chip select and each one have 128MB memory mapping (total  
>>> 512MB memory mapping)  
>>>> FIU2 - have 4 chip select and each one have 16MB memory mapping (total  
>>> 32MB memory mapping)  
>>>>
>>>> Totally 800MB memory mapping.
>>>>
>>>> When the FIU driver probe it don't know the size of each Flash that
>>>> connected to the FIU, so the entire memory mapping is allocated for each  
>>> FIU  
>>>> according the FIU device tree memory map parameters.  
>>>
>>> Do you need those mappings to be active to support simple reg accesses?
>>>  
>>>> It means, if we enable all three FIU's the drivers will try to allocate  
>>> totally 800MB.  
>>>>
>>>> In 32bit system it is problematic because the kernel have only 1GB
>>>> of memory allocation so the vmalloc cannot take 800MB.
>>>>
>>>> When implementing the FIU driver in the mtd/spi-nor we allocating memory  
>>> address only  
>>>> for detected Flash with exact size (usually we are not using 128MB  
>>> Flash), and in that case usually we allocating much less memory.  
>>>>
>>>> To solve this issue we needed to overcome two things:
>>>>
>>>> 1.    Get argument from the upper layer (spi-mem layer)
>>>> 2.    Calling the get argument function after SPI_NOR_SCAN function.  
>>> (the MTD Flash size filled in  SPI_NOR_SCAN function)
>>>
>>> That's clearly breaking the layering we've tried to restore with the
>>> spi-nor/spi-mem split, and I don't see why this is needed since we now
>>> have a way to create direct mappings dynamically (with the dirmap API).
>>> Have you tried implementing the dirmap hooks in your driver?  
>>
>>
>>  Sorry but I wasn't familiar with the direct mapping in the spi-mem, it
>> seems it needed to implemented in the m25p80 driver as well, am I correct?
> 
> There's this patch [1] floating around. IIRC, Sergey was waiting for
> the m25p80 -> spi-nor merge to send a v5.

   No, not really waiting for it. I was asked to recast the patch using
the managed device APIs, and I got sucked into my HyperFlash driver and
dropped the ball...

> Vignesh, any updates on that
> one? If you don't have time to work on that, maybe Sergey could send a
> v5.

   I can try recasting it RSN, if it's blocking some other stuff...

> [1]https://www.spinics.net/lists/linux-mtd/msg07358.html

MBR, Sergei
