Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11BC33364D
	for <lists+linux-spi@lfdr.de>; Wed, 10 Mar 2021 08:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhCJHVe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Mar 2021 02:21:34 -0500
Received: from www381.your-server.de ([78.46.137.84]:60428 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCJHVW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Mar 2021 02:21:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=qz+v/U8OfCpTcBxQ524rjA3+edB4w4v2XAKWVao9tZw=; b=NOcAydZc5yBZM0Muwj7fz+C8N6
        MLVX5u/dL4dKLslXt9sIydO9khfqiXZy8yYjcv1kT6LDVjL/8hiWkYVoIrzv4E/HCeSH7Qjdz3Fa0
        jVoOH/9yqvIniidnNF7Nsziu54b/eKK9jz9QFQVAO2ICDFZypDI04wgSKrt1D5SX06TIqupGjiq6y
        d/71t5fC8hQOTrGNz6/jHWJmo37Ix9C6lsRdQx8RKT+nwmWuuCdc8beN5t4DnJemOfoxj8mzUEYlh
        XWZvpdDGVsG/PFnkQFgSwOylKlq7ODZf4TnzXtJn691AbSdy+LIzbbdsAJlFF4pFr1zkpUDM83kqI
        /BUNDg1g==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lJt9f-0001ZM-Fz; Wed, 10 Mar 2021 08:21:15 +0100
Received: from [62.216.202.180] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lJt9f-00041w-55; Wed, 10 Mar 2021 08:21:15 +0100
Subject: Re: [PATCH 01/10] spi: spi-axi-spi-engine: remove usage of
 delay_usecs
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, elder@kernel.org,
        johan@kernel.org, vireshk@kernel.org, rmfrfs@gmail.com,
        f.fainelli@gmail.com, ldewangan@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, linux@deviqon.com
References: <20210308145502.1075689-1-aardelean@deviqon.com>
 <20210308145502.1075689-2-aardelean@deviqon.com>
 <8a6ec9a1-71f8-ce1d-600a-66eba9244a54@metafoo.de>
 <CAASAkoZ+3T27KK0HN6YikKczUFS15xSpOssaOmx4NtDQKiKvHQ@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <bafbb401-d563-dafc-ff11-9fbfd33709a4@metafoo.de>
Date:   Wed, 10 Mar 2021 08:21:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAASAkoZ+3T27KK0HN6YikKczUFS15xSpOssaOmx4NtDQKiKvHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26103/Tue Mar  9 13:03:37 2021)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 3/10/21 8:16 AM, Alexandru Ardelean wrote:
> On Mon, 8 Mar 2021 at 18:42, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 3/8/21 3:54 PM, Alexandru Ardelean wrote:
>>> The 'delay_usecs' field was handled for backwards compatibility in case
>>> there were some users that still configured SPI delay transfers with
>>> this field.
>>>
>>> They should all be removed by now.
>>>
>>> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
>>> ---
>>>    drivers/spi/spi-axi-spi-engine.c | 12 ++++--------
>>>    1 file changed, 4 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
>>> index af86e6d6e16b..80c3e38f5c1b 100644
>>> --- a/drivers/spi/spi-axi-spi-engine.c
>>> +++ b/drivers/spi/spi-axi-spi-engine.c
>>> @@ -170,14 +170,10 @@ static void spi_engine_gen_sleep(struct spi_engine_program *p, bool dry,
>>>        unsigned int t;
>>>        int delay;
>>>
>>> -     if (xfer->delay_usecs) {
>>> -             delay = xfer->delay_usecs;
>>> -     } else {
>>> -             delay = spi_delay_to_ns(&xfer->delay, xfer);
>>> -             if (delay < 0)
>>> -                     return;
>>> -             delay /= 1000;
>>> -     }
>>> +     delay = spi_delay_to_ns(&xfer->delay, xfer);
>>> +     if (delay < 0)
>>> +             return;
>> Bit of a nit, but this could be `delay <= 0` and then drop the check for
>> `delay == 0` below.
> hmm, that's a bit debatable, because the `delay == 0` check comes
> after `delay /= 1000` ;
> to do what you're suggesting, it would probably need a
> DIV_ROUND_UP(delay, 1000) to make sure that even sub-microsecond
> delays don't become zero;

Ah, true. Lets keep the code as it is.

On the other hand you could argue that we should round up to ensure the 
delay is at least as long as requested. But that is something that 
should be changed independently from this series.


