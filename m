Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B71051B111
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2019 09:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfEMHVf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Mon, 13 May 2019 03:21:35 -0400
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:37156
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfEMHVf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 May 2019 03:21:35 -0400
Received: from msmac.intern.sperl.org (account martin@sperl.org [10.10.10.11] verified)
  by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
  with ESMTPSA id 7764767; Mon, 13 May 2019 07:21:31 +0000
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync instead run teardown delayed
From:   kernel@martin.sperl.org
In-Reply-To: <20190512085409.GM21483@sirena.org.uk>
Date:   Mon, 13 May 2019 09:21:40 +0200
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <02F11B40-F747-4E57-9E37-1DD010D54CBC@martin.sperl.org>
References: <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com> <AAA7943B-B1F1-4389-AAC3-8621EC6E38B8@martin.sperl.org> <20190115192619.GG5522@sirena.org.uk> <5D3256B1-5DAE-4E3F-9099-5425F4BCA304@martin.sperl.org> <20190115212539.GK5522@sirena.org.uk> <EA757B47-A264-4B4D-9E5F-16611ABA0278@martin.sperl.org> <20190118191202.GG6260@sirena.org.uk> <EE52ED32-CBB4-40D4-8615-CA814158C826@martin.sperl.org> <20190123175609.GG7503@sirena.org.uk> <CB6BCD42-60F9-493A-B05B-FC27C125E982@martin.sperl.org> <20190512085409.GM21483@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark!

> On 12.05.2019, at 10:54, Mark Brown <broonie@kernel.org> wrote:
> 
> On Thu, May 09, 2019 at 09:47:08PM +0200, Martin Sperl wrote:
> 
>> While thinking about this again maybe an idea:
>> What about implement a second spi_transfer_one implementation (together
>> with a message pump implementation) that would handle things correctly.
> 
>> Any driver then can select the old (default) or new implementation and thus
>> would allow the optimizations to take place only for verified working drivers...
> 
> I'd rather avoid having yet another interface for drivers to use, people
> already get confused trying to choose between the ones we already have.
> It'd have to be something where the existing drivers got actively
> converted and the old interface retired rather than something that hangs
> around.

I totally understand that.

> 
>> What I would then also like to do for the new implementation is modify the
>> API a bit - ideally I would like to:
>> * Make spi_sync the primary interface which the message pump is also 
>>  using directly
>> * move all the prepare stuff early into spi-sync, so that for example the
>>  Preparing (including dma mapping) would get done in the calling thread
>>  And only the prepared message would get submitted to the queue
>>  - special processing would be needed for the spi-async case.
> 
> IIRC the mapping is deliberately done late in order to minimize the
> amount of time we're consuming resources for the mapping, there were
> some systems that had limited DMA channels.  However I don't know how
> big a concern that is in this day and age with even relatively old
> systems.

We may be able to make the mapping early or late.

The place where it REALLY makes a difference is when we are running
in the Pump (because of async or because of multiple threads writing
to the same spi bus via spi_sync)

>  The idea of spi_async() having a separate path also makes me a
> bit nervous as it's much less widely used so more likely to get broken
> accidentially.

I would try to come up with something,


> Otherwise pushing things out to the caller makes sense, it should have
> no real impact in the majority of cases where the thread is just getting
> used to idle the controller and the actual work is all happening in the
> calling context anyway and if the pump is being used it means it's
> spending more time actually pushing transfers out.

> For the case where we do have the message pump going one thing it'd be
> good to do is overlap more of the admin work around the messages with
> other transfers - ideally we'd be able to kick off the next transfer
> from within the completion of a DMA.  I need to have a dig around and
> figure out if I have any hardware that can actually support that, last
> time I looked at this my main system needed to kick everything up to the
> thread due to hardware requirements.

But to get all this done I fear it will definitely require api changes
and thus a new kind of pump.

Maybe the pump can get shared by multiple spi (master) controller. This
would help when there are say 4 devices connected each to a separate
controller and then transferring short messages that would get handled
by polling - that would mean 4 CPUs just polling, which is also consuming
lots of cpu cycles. If we could pool this polling

I am starting to wonder if there is a means to make the wakeup of threads 
fast/priority to keep the latency on spi_sync minimal - essentially
yielding the CPU to the “right” thread (so making a yield cheap).

But let us see how far we get before we can tackle this...

Form a performance/thru-put perspective I guess it may be relevant to
extend the spi_test framework to also gather performance/latency
statistics so that we have a means to compare actual performance
numbers and avoid regressions.

Martin



