Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B6B3CD5CC
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jul 2021 15:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbhGSM6T (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Jul 2021 08:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239101AbhGSM6S (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Jul 2021 08:58:18 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE51C061574
        for <linux-spi@vger.kernel.org>; Mon, 19 Jul 2021 06:01:08 -0700 (PDT)
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id B077F81E3D;
        Mon, 19 Jul 2021 15:38:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1626701935;
        bh=LXQh/0TkVJqHXckVjqhzliB6kXC50Ki8fnlX1mqdYao=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rS2dbOyNtp7yb10fK4s3SJtWlxbr05NwYjtHh6ydZ31SWtDcXbc9IL2mGEKfLj/5G
         GyqDrRS4l5mNoheLrJ1IHJuVHsqx5Kys7S2DL3UeQwKjiO8I1tstX7ypMwuB2cF+PD
         YX0XHdD7j4Z5K68pneVFXiiK4+XdoM6Y9a9DKJw19DPKoDM7D8otp8vZBy8qa04xup
         /B334jLiRpSfMopNL8snF+8g7MVIZAaRP/48RW4ICsU3riP5st/X+xC7emWV9bepjC
         Gd/AAxO/vBz0OXT4WIWPsMEbNqsx4px88q+9KA8xiLr7raY/LQingAOzB48WVTu/JH
         N/P2CZOG8F28w==
Subject: Re: [PATCH] spi: imx: mx51-ecspi: Fix low-speed CONFIGREG delay
 calculation
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20210718211143.143557-1-marex@denx.de>
 <20210719082015.ud43iwg5rfdomlqi@pengutronix.de>
From:   Marek Vasut <marex@denx.de>
Message-ID: <17bf62a4-af57-1706-f20a-35f9d6cbf9d0@denx.de>
Date:   Mon, 19 Jul 2021 15:38:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210719082015.ud43iwg5rfdomlqi@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 7/19/21 10:20 AM, Uwe Kleine-König wrote:

[...]

>> @@ -505,7 +505,9 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
>>   				      struct spi_message *msg)
>>   {
>>   	struct spi_device *spi = msg->spi;
>> +	struct spi_transfer *xfer;
>>   	u32 ctrl = MX51_ECSPI_CTRL_ENABLE;
>> +	u32 min_speed_hz = ~0U;
>>   	u32 testreg, delay;
>>   	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
>>   
>> @@ -578,7 +580,13 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
>>   	 * the SPI communication as the device on the other end would consider
>>   	 * the change of SCLK polarity as a clock tick already.
>>   	 */
>> -	delay = (2 * 1000000) / spi_imx->spi_bus_clk;
>> +	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
>> +		if (!xfer->speed_hz)
>> +			continue;
>> +		min_speed_hz = min(xfer->speed_hz, min_speed_hz);
>> +	}
> 
> Can it happen that all transfer's spped_hz are zero?

I don't think so, what kind of spi_message would that be ?

And even if it was zero, the delay would be 2000000/~0U , so zero as 
well, which I suppose is the best we can do in such a case.

>> +
>> +	delay = (2 * 1000000) / min_speed_hz;
> 
> Orthogonal to your change: I wonder if we need to round up the division
> here.

That is not necessary, since the delay here is twice what it needs to be 
(because we really do not know what happens in the hardware internally).

>>   	if (likely(delay < 10))	/* SCLK is faster than 100 kHz */
>>   		udelay(delay);
>>   	else			/* SCLK is _very_ slow */
> 
> Also the comments are wrong here. Is SCLK is 150 kHz we have
> min_speed_hz = 150000, right? Then delay becomes 13 and the slow freq
> path is entered. The right comment (when keeping delay = (2 * 1000000) /
> min_speed_hz) would be
> 
> 	if (likely(delay < 10)) /* SCLK is faster than 181.818 kHz */

This whole if/else is in fact based on 
Documentation/timers/timers-howto.rst , which says use usleep_range() 
for delays above 10uS or so.

The comment should be updated, but that's a separate patch.

-- 
Best regards,
Marek Vasut

DENX Software Engineering GmbH, Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-56 Email: marex@denx.de
