Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F783D7A36
	for <lists+linux-spi@lfdr.de>; Tue, 27 Jul 2021 17:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhG0PwX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Jul 2021 11:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhG0PwX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Jul 2021 11:52:23 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38032C061757
        for <linux-spi@vger.kernel.org>; Tue, 27 Jul 2021 08:52:23 -0700 (PDT)
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C1B8E83171;
        Tue, 27 Jul 2021 17:52:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1627401140;
        bh=CxQwCSD35Rc5C6i8m6biH0BzwhuGcdgheiWV4dDu8zA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QFTUiOPdk2TItmKVOz97oImyg+q5/YddrjHfdenjf76XpXvfQ7SyPsXQr8brdqxOA
         rM9GWTRDUU+N6k138D2t4K+GpeDde93gN1DgzIhJeNN+wAvfMjr8OtOBvolFnDI6gS
         YTzRSK/2RKck97B2jEBGhuGlFuuJRtCJ4QVsifGd+HYLdLqXKOftbvlW1MLSv/jbqF
         8/VgOElrAGai7V4LtWaGuAhESSKYNQHK7lxFEveGfhm9eZESM3+W8Am00FRXlUQlK/
         w0ew24ojTlbN6aqucr7Tg05I8wzWKYFELOGDj9hosBvDi9/vriOj3FAZRTo4vyPSI8
         sOeWYCO2KbAdA==
Subject: Re: [PATCH] spi: imx: mx51-ecspi: Fix CONFIGREG delay comment
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20210726101502.6803-1-marex@denx.de>
 <20210727130110.dm5wa6hwrrftwt6g@pengutronix.de>
From:   Marek Vasut <marex@denx.de>
Message-ID: <cc72105b-ccfe-2e1c-4c3c-226f6e3f169c@denx.de>
Date:   Tue, 27 Jul 2021 17:52:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210727130110.dm5wa6hwrrftwt6g@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 7/27/21 3:01 PM, Uwe Kleine-König wrote:
> On Mon, Jul 26, 2021 at 12:15:02PM +0200, Marek Vasut wrote:
>> For (2 * 1000000) / min_speed_hz < 10 to be true in naturals with zero,
>> the min_speed_hz must above 222222. Update the comment. No functional
>> change.
> 
> With integer division delay is < 10 if min_speed_hz >= 200001.

Right, it's not 181, 100 or 222. I'll send a V2 and clarify this.
