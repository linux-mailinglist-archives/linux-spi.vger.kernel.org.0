Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDF31F9D8E
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 18:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbgFOQfJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 12:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730622AbgFOQfI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 12:35:08 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9358EC061A0E;
        Mon, 15 Jun 2020 09:35:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l11so17819122wru.0;
        Mon, 15 Jun 2020 09:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5lQ7/lXKr17vodyRktD27IeUshUvPdaX3z7NooA/F6c=;
        b=lIxkFBz4V7PvO7vVgR/1G7SztwCxC+vE7xGy7iiI04gpvRrGz3fvI6WC2TlbheWbcA
         hVziL9UihaCcCbEfALSiVRaZEaoEWBDglQSV7TEf4br1zJMuX19hnyeWo2IBZjx1+F4T
         GNG5MSP4WRky8nQZ6FezVDnp8l/iUQelNogrAsqbUOnGnXMk1D2ga531EYXwTTm+Z32V
         zrhWCmNoWtFtobtHUq8eRx4yMvvhF+TR4xw4vOUFD5xk9BEliXendpGi3k62DLLehbVU
         AKog/oFVxhmYuZJZMkHqRqWZxcPbRUmS8YKBMXB7PROAR0Zse1agKmEZyIMnnkdkmczY
         vexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5lQ7/lXKr17vodyRktD27IeUshUvPdaX3z7NooA/F6c=;
        b=NSieIw2QkhC7AGri6LILIaNY4AntXJV60RgY9O5A/B2lvjTyudyRK3uP2wZi8tk3mV
         io5h84M+v5pbjT632U9cefLbnI//9shA9B44VhAqazUN1asD86gOFG3vBQ//oBXhj+3V
         JjKBKhMM08sgREZeVGbUhVvPmelq9CNKF4Ivvkbh28iCXSo3i5w4Wq3nzkTIgq1QpR/7
         AZhjIsk+h6YCVo+45fx6mMK4pGb7Kk6uRo3PAPn4h4ms+1N+UCFFAoA//qc9csul/LE4
         Tqif2r3fRyPLcQhBD25j6W9uffsU+upV1RpBQe2GO59F7zh5M5R9ZXtEgBmbj1NhuJBA
         BKnA==
X-Gm-Message-State: AOAM532n8qAMP/6DXxccku/+UMm27Z2iZUyrB/bqzK9gk65t6KACoelA
        SNR10jvGugjF+3fIEKdNXNc=
X-Google-Smtp-Source: ABdhPJx16P7DvzPCkCZaqX3CvQm6rK5GkXK/vM+JGs/qyiKtD3n7zer28P+ZWST4ukMKG0x0q4CynA==
X-Received: by 2002:adf:ecc2:: with SMTP id s2mr32591979wro.60.1592238906258;
        Mon, 15 Jun 2020 09:35:06 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d24sm67808wmb.45.2020.06.15.09.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 09:35:05 -0700 (PDT)
Subject: Re: [PATCH v2] spi: bcm2835: Enable shared interrupt support
To:     Mark Brown <broonie@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, lukas@wunner.de,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Martin Sperl <kernel@martin.sperl.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
References: <20200604212819.715-1-f.fainelli@gmail.com>
 <142d48ae-2725-1368-3e11-658449662371@arm.com>
 <20200605132037.GF5413@sirena.org.uk>
 <2e371a32-fb52-03a2-82e4-5733d9f139cc@arm.com>
 <06342e88-e130-ad7a-9f97-94f09156f868@arm.com>
 <d3fe8b56-83ef-8ef0-bb05-11c7cb2419f8@gmail.com>
 <a6f158e3-af51-01d9-331c-4bc8b6847abb@arm.com>
 <20200608112840.GC4593@sirena.org.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <bb9dbf11-9e33-df60-f5ae-f7fdfe8458b4@gmail.com>
Date:   Mon, 15 Jun 2020 09:34:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200608112840.GC4593@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 6/8/2020 4:28 AM, Mark Brown wrote:
> On Mon, Jun 08, 2020 at 12:11:11PM +0100, Robin Murphy wrote:
> 
>> Again, 2 cycles. The overhead of a static key alone is at least 50% of that.
>> And that's not even considering whether the change in code layout caused by
>> doubling up the IRQ handler might affect I-cache or branch predictor
>> behaviour, where a single miss stands to more than wipe out any perceived
>> saving. And all in code that has at least one obvious inefficiency left on
>> the table either way.
> 
>> This thread truly epitomises Knuth's "premature optimisation" quote... ;)
> 
> In fairness the main reason this driver is so heavily tuned already (and
> has lead to some really nice improvements in the core) is that there are
> a number of users hitting 100% CPU utilization driving SPI devices on
> some of the older RPi hardware, IIRC around IIO type applications
> mostly.  I do tend to agree that this particular optimization is a bit
> marginal but there has been a lot of effort put into this.

OK, so this has been dropped for spi/for-next right? How do we move from
there?
-- 
Florian
