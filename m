Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E52936F285
	for <lists+linux-spi@lfdr.de>; Fri, 30 Apr 2021 00:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhD2WVD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Apr 2021 18:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhD2WVD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Apr 2021 18:21:03 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E60FC06138B;
        Thu, 29 Apr 2021 15:20:16 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 741622224D;
        Fri, 30 Apr 2021 00:20:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1619734813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=la6VLsxOJVtAExCAynbfZPh1rnm5vHPZ1THtd/hTHcY=;
        b=U1hNdI7EaTGjYM4poaPfhkmA5c76axn4jj3YiAyBX56MOJQoXCvwx/44i8od6G5H/YKUum
        lHdmylGQ99VQvHC/vqZj3663T77p2LReCJzpgTtY8fHUJWF8AEGfuccJwg5sklLtzTuXgy
        hUu31FWHRAF9cKaEdUhINy1f5hlLAnI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 30 Apr 2021 00:20:13 +0200
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor.Ambarus@microchip.com, nm@ti.com, kristo@kernel.org,
        robh+dt@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, lokeshvutla@ti.com
Subject: Re: [RFC PATCH 4/6] spi: cadence-qspi: Use PHY for DAC reads if
 possible
In-Reply-To: <20210429181908.bwb45eljn5nxscf6@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
 <20210311191216.7363-5-p.yadav@ti.com>
 <2f26456e-59ff-2625-5d65-c1537052839d@microchip.com>
 <20210312101757.sqeyledbwjnpqdoy@ti.com>
 <ee2b753b16e76ecbede4c1373b6f2d77@walle.cc>
 <20210429181908.bwb45eljn5nxscf6@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <e17722c30deb7f2dcb94a9aa43bbc6dd@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2021-04-29 20:19, schrieb Pratyush Yadav:
> On 29/04/21 06:28PM, Michael Walle wrote:
>> Am 2021-03-12 11:17, schrieb Pratyush Yadav:
>> > On 12/03/21 09:13AM, Tudor.Ambarus@microchip.com wrote:
>> > > On 3/11/21 9:12 PM, Pratyush Yadav wrote:
>> > > > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>> > > >
>> > > > Check if a read is eligible for PHY and if it is, enable PHY and DQS.
>> > >
>> > > DQS as in data strobe? Shouldn't the upper layer inform the QSPI
>> > > controller
>> > > whether DS is required or not?
>> >
>> > Yes, DQS as in data strobe. I need to check this again, but IIRC the
>> > controller cannot run in PHY mode unless DS is used. Ideally the upper
>> > layer should indeed inform the controller whether DS is supported/in-use
>> > or not. That can be used to decide whether PHY mode (and consequently
>> > the DS line) is to be used or not.
>> >
>> > Currently there are only two flashes that use 8D-8D-8D mode (S28HS512T
>> > and MT35XU512ABA), and both of them drive the DS line.
>> 
>> The LS1028A datasheet explicitly states that the calibration is only
>> used for non-DQS flashes. Which makes sense, because it just determine 
>> at
>> which point the input data is sampled. And if the flash provides a 
>> data
>> strobe, it already know when to sample it. What I am missing here?
> 
> If there was 0 delay in transferring the signals from flash to
> SoC/controller, you would be right. But in practice there is a small 
> but
> noticeable delay from when the flash launches the signal and when it is
> received by the device. So by the time the DQS signal reaches the SoC 
> it
> might already be too late and the data lines might not be valid any
> more. The calibration accounts for these (and some others) delays.

DQS and the data signals are trace length matched, so for data reads
they will end up on the IO pad of the SoC at the same time. This is
also mentioned in [1] (Fig 1.1, point 4 and 5). So while there needs
to be a delay on the clock line for the receiving FF, the best value
for this should be half the SCK clock period.

Does this work without DQS? That should be the main purpose for a
calibration, no? Because in this case, you'll have to determine
the delay between SCK and the data signals (for reads).

Btw. I can't get my head around how the TX delay search would work.
Basically you shift the SCK to the command / data to the flash. So
the flash will either recognize a valid read command or if the delay
is too short/too long the flash will (hopefully) ignore the wrong
command, correct? Might there be any misinterpreted commands which
might be harmful? Are there any flashes which actually need a delay
between data out and SCK?

Of course, the calibration might help with broken hardware where the
SCK/DQ/DQS traces are not length matched.

-michael

> 
> See [0] for a somewhat similar discussion I had with Tudor.
> 
> [0] 
> https://lore.kernel.org/linux-mtd/20210312181447.dlecnw2oed7jtxe7@ti.com/

[1] https://www.ti.com/lit/an/spract2/spract2.pdf
