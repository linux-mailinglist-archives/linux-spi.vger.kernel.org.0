Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9014E1F9E85
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 19:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbgFORcD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 13:32:03 -0400
Received: from foss.arm.com ([217.140.110.172]:52812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728585AbgFORcD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 13:32:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B79C1F1;
        Mon, 15 Jun 2020 10:32:02 -0700 (PDT)
Received: from [10.57.9.128] (unknown [10.57.9.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E3FC3F73C;
        Mon, 15 Jun 2020 10:32:00 -0700 (PDT)
Subject: Re: [PATCH v2] spi: bcm2835: Enable shared interrupt support
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     lukas@wunner.de,
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
 <bb9dbf11-9e33-df60-f5ae-f7fdfe8458b4@gmail.com>
 <20200615170031.GA4447@sirena.org.uk>
 <692bc94e-d574-e07a-d834-c0d569e87bba@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2f354ed0-9fb7-59ea-ddd1-78703d9c818e@arm.com>
Date:   Mon, 15 Jun 2020 18:31:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <692bc94e-d574-e07a-d834-c0d569e87bba@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2020-06-15 18:04, Florian Fainelli wrote:
> 
> 
> On 6/15/2020 10:00 AM, Mark Brown wrote:
>> On Mon, Jun 15, 2020 at 09:34:58AM -0700, Florian Fainelli wrote:
>>
>>> OK, so this has been dropped for spi/for-next right? How do we move from
>>> there?
>>
>> Well, I actually have it queued up for applying so unless I pull it
>> before my scripts get that far through the stuff I queued over the merge
>> window it'll go in (I dropped it due to it not being a bugfix).  If it
>> were me I'd go with the two instruction hit from checking the flag TBH
>> but otherwise I guess __always_inline should work for compilers that
>> misoptimize.  None of this is getting in the way of the framework so if
>> everyone involved in the driver is happy to spend time optimising it
>> and dealing with the fragility then it's fine by me.
> 
> OK, how about I send you an increment patch (would a fixup be okay?)
> that adds __always_inline since we know from this thread that some
> compilers may mis-optimize the function inlining?

Now that I've been inclined to go and look up the documentation, are we 
sure this so-very-contentious check is even correct? From my reading of 
things we're checking whether the RXR interrupt function is *enabled*, 
which still says nothing about whether either condition for the 
interrupt being *asserted* is true (RXR = 1 or DONE = 1). Thus if more 
than one SPI instance is active at once we could still end up trying to 
service an IRQ on a controller that didn't raise it.

Robin.
