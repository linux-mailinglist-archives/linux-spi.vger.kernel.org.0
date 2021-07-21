Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66AF3D17F3
	for <lists+linux-spi@lfdr.de>; Wed, 21 Jul 2021 22:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbhGUTiB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Jul 2021 15:38:01 -0400
Received: from phobos.denx.de ([85.214.62.61]:34052 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232808AbhGUTiB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 21 Jul 2021 15:38:01 -0400
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id D643F8164D;
        Wed, 21 Jul 2021 22:18:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1626898716;
        bh=nNNRf+OmgsFB3RAgbEKJM50FASZmcgjDzTFB0wDcc+Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=U+lybguxWWOXnAZMwduMIs8BiRj3DRpgT/lSRwXpc4QnojrxTniI6d/z3T5QKlvG0
         1nT26dGn2ANoBGNG7MFu8JqmX1Zxi8Z0ss6VrO3IrEDY3sxfIyxeIvaxgczyOrvr/a
         9AGf7mhVngE+aOnJk97Kpv/TOz5cdGcD3MezVZne0uEm9Y1vaWr5bWApREbmsLHyG1
         2WWmhAH3iQql4E+8BGiWFyc37W+/3X5tWlqbWoG6uYvyIckXQmwdSnmFBCHmxyeCpE
         9G/ypwZHJ5aPWA4hLSLi3+isGr/xoyQJdYYqI813nfEAoKitqSvkVRinCJuktK1LOK
         gVbbLXY4W55kg==
Subject: Re: [PATCH] spi: imx: mx51-ecspi: Fix low-speed CONFIGREG delay
 calculation
To:     Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-spi@vger.kernel.org
References: <20210718211143.143557-1-marex@denx.de>
 <20210719082015.ud43iwg5rfdomlqi@pengutronix.de>
 <17bf62a4-af57-1706-f20a-35f9d6cbf9d0@denx.de>
 <20210719211221.GA35544@sirena.org.uk>
From:   Marek Vasut <marex@denx.de>
Message-ID: <37b0f7eb-39fd-9e15-20e3-becfcfd4b5f4@denx.de>
Date:   Wed, 21 Jul 2021 22:18:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210719211221.GA35544@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 7/19/21 11:12 PM, Mark Brown wrote:
> On Mon, Jul 19, 2021 at 03:38:55PM +0200, Marek Vasut wrote:
>> On 7/19/21 10:20 AM, Uwe Kleine-König wrote:
> 
>>> Can it happen that all transfer's spped_hz are zero?
> 
>> I don't think so, what kind of spi_message would that be ?
> 
>> And even if it was zero, the delay would be 2000000/~0U , so zero as well,
>> which I suppose is the best we can do in such a case.
> 
> I can see that happening for a controller that didn't set any speed
> information with a driver that also didn't set any speed information,
> everything is just hoping that the default is fine but only the hardware
> is actually setting something.  I've not gone and checked if anything
> ever insists there absolutely must be something specified in software.

So, should I send a V2 here with any changes or is this one OK as-is ?
