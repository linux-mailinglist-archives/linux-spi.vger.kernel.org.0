Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF81D36421E
	for <lists+linux-spi@lfdr.de>; Mon, 19 Apr 2021 14:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhDSM5D (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Apr 2021 08:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239260AbhDSM5C (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Apr 2021 08:57:02 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B96C06174A
        for <linux-spi@vger.kernel.org>; Mon, 19 Apr 2021 05:56:33 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w4so30207930wrt.5
        for <linux-spi@vger.kernel.org>; Mon, 19 Apr 2021 05:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=devtank-co-uk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=cHvdJOLVrK2oV/sMJ9aTvajYHbt3szjG4e8tvwGAwak=;
        b=P1mZ+cXs4PHTBHaRcjkPmk43VhLwcQg7lcYFu1gruDcJo3/DXkaGOuCykl2+lLEFsW
         uuteo6ftxLNd1srQAPczjjl58efA3LEpvIl72lip9XuwKd8d9Ccl8lG7fxMT8gpPJm50
         HmTUohzypfZoodnF6/A7Ww25mHmSeweW1BwbWWCONoBgxt8QV96buU24oqtNw95deqDS
         M08f2jmK1qDOgBtHGr42KL3kvLjHxuo+cOJw3Mimu02uWDRZJVBlbY4OIVaCdgC/P5CR
         Qg94XMPZAeQ9aXESjzy5tXPO1M70fMjm3Eupr8FKaQQyAkf2K0gxaippRveimjdOtOcS
         ACyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cHvdJOLVrK2oV/sMJ9aTvajYHbt3szjG4e8tvwGAwak=;
        b=EmP4QQdvVoamuWqNdWpabKozIARdjiLYBwGCOFm2sgO7eTl9mWhkLwRQC2GocjWn6z
         XH6CsqLuwKXue6n5avgzpg/vB7k0g3Untzww+fAwcoVeziwyx5BHKZSvZT48s9VjwIEc
         +CkAc+1O/WP6f2FhFjZMru2YwF1Py55fHscRLh+6py753dbd9St2GmqX9+XNUBPKDTre
         TMv/GGlt9XenTVLDwp4/3qC045mFFxPT0+4IraP4fYyyxgWR/z9rJRjy9eQ9WdjHgmHB
         48nRw+22zI9OAEC3OhkC109q/n00IWLCKA1QZLE9KZc5HH42cL83VF9ZgXfbAFVGZmB6
         +G8Q==
X-Gm-Message-State: AOAM533Yh4PxQMskeFYVNDNF8OVGA3RLBdyC4HyFLOnKZdxld+yZjFWC
        EV8S/JXqb0NfmWqdd+ro4enZQA==
X-Google-Smtp-Source: ABdhPJwcz5X1OCuO4kAtu1/qQPZPgYzcESZZRA97mihPGpnZi5vIfLrKuqkd7+t2sIsmn2D5wzyjZQ==
X-Received: by 2002:adf:a40f:: with SMTP id d15mr14047504wra.375.1618836991844;
        Mon, 19 Apr 2021 05:56:31 -0700 (PDT)
Received: from [192.168.200.229] (static-84-9-134-242.vodafonexdsl.co.uk. [84.9.134.242])
        by smtp.gmail.com with ESMTPSA id u8sm22850696wrp.66.2021.04.19.05.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 05:56:31 -0700 (PDT)
Subject: Re: Multi driver SPI chip select count unenforced.
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>
References: <6a6c9d49-9064-4bbe-0330-87f92623d669@devtank.co.uk>
 <20210416153019.GA26144@wunner.de>
From:   Joe Burmeister <joe.burmeister@devtank.co.uk>
Message-ID: <438c7530-49db-47cc-6451-4defc645b577@devtank.co.uk>
Date:   Mon, 19 Apr 2021 13:56:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210416153019.GA26144@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Thanks Lukas,

I'll tweak and resubmit properly.

Regards,

Joe

On 16/04/2021 16:30, Lukas Wunner wrote:
> On Fri, Apr 16, 2021 at 11:55:45AM +0100, Joe Burmeister wrote:
>> However, after I found the same broken pattern in a few places.
>> You can find suspects by grep'ing in the SPI folder for "->chip_select]".
> You need to cc the maintainers of the affected drivers.
> You can retrieve them with "scripts/get_maintainer.pl drivers/spi/spi-...".
>
> Please don't attach patches but rather submit each one separately.
> Pass a commit range (abcdefg..0123456) to "git format-patch" to
> get numbered patches, then submit them with msmtp or "git send-email".
>
>
>> Subject: [PATCH] Handle SPI device setup callback failure.
> Prepend the subsystem to the subject and drop the period, e.g.:
>
> spi: Handle SPI device setup callback failure
>
> Patch otherwise LGTM.
>
>
>> Subject: [PATCH] Remove BCM2835 SPI chipselect limit.
> Prepend "spi: bcm2835: " in this case and drop the period.
> Use "git log --oneline <filename>" to see what the prefix should look
> like for a particular file.
>
>
>> The limit of 4 chipselects for the BCM2835 was not required and also was
>> not inforced. Without inforcement it was possible to make a device tree
>> over this limit which would trample memory.
>>
>> The chipselect count is now obtained from the device tree and expanded
>> if more devices are added.
> I'd prefer it if you could just raise BCM2835_SPI_NUM_CS to 6
> (or 8 or whatever you need).  Use commit 603e92ff10a8 as a template.
>
> Then submit a separate patch to error out of bcm2835_spi_setup()
> if bcm2835_spi_setup >= BCM2835_SPI_NUM_CS.
>
> Honestly I think the additional code complexity isn't worth it to allow
> for dynamic resizing.  Raising BCM2835_SPI_NUM_CS results in just a
> few additional bytes, that's probably smaller than the increase of the
> text segment due to the additional resizing code.
>
> Nit: I think the correct spelling is "enforce".  (Not an English native
> speaker but my dictionary says so.)
>
> Thanks!
>
> Lukas
