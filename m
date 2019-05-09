Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B01A519306
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2019 21:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfEITrM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 9 May 2019 15:47:12 -0400
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:36596
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfEITrM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 May 2019 15:47:12 -0400
Received: from [10.10.10.192] (account martin@sperl.org [10.10.10.192] verified)
  by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
  with ESMTPSA id 7764569; Thu, 09 May 2019 19:47:08 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync instead run teardown delayed
From:   Martin Sperl <kernel@martin.sperl.org>
X-Mailer: iPad Mail (16E227)
In-Reply-To: <20190123175609.GG7503@sirena.org.uk>
Date:   Thu, 9 May 2019 21:47:08 +0200
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <CB6BCD42-60F9-493A-B05B-FC27C125E982@martin.sperl.org>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com> <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org> <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com> <AAA7943B-B1F1-4389-AAC3-8621EC6E38B8@martin.sperl.org> <20190115192619.GG5522@sirena.org.uk> <5D3256B1-5DAE-4E3F-9099-5425F4BCA304@martin.sperl.org> <20190115212539.GK5522@sirena.org.uk> <EA757B47-A264-4B4D-9E5F-16611ABA0278@martin.sperl.org> <20190118191202.GG6260@sirena.org.uk> <EE52ED32-CBB4-40D4-8615-CA814158C826@martin.sperl.org> <20190123175609.GG7503@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark!

> On 23.01.2019, at 18:56, Mark Brown <broonie@kernel.org> wrote:
> 
>> On Sun, Jan 20, 2019 at 12:24:23PM +0100, kernel@martin.sperl.org wrote:
>> 
>> These kind of changes it requires are consuming a bit more time than
>> I was hoping for.
> 
> Thanks for trying.
> 
>> So maybe at this very moment the best is reverting the patch.
> 
> Yes, I'm just going to do that for now.
> 
>> As for the root cause of the regression: my guess is that spi-mem is
>> just not triggering a shutdown any more because of how message_pump works.
> 
> I'm fairly sure that's what's going on but not been able to get my head
> around things enough to figure out what's going wrong yet.

While thinking about this again maybe an idea:
What about implement a second spi_transfer_one implementation (together
with a message pump implementation) that would handle things correctly.

Any driver then can select the old (default) or new implementation and thus
would allow the optimizations to take place only for verified working drivers...

At least this way we would not be blocked because no hw exposing this
Behavior is available to us - at the cost of extra code to get maintained.

What I would then also like to do for the new implementation is modify the
API a bit - ideally I would like to:
* Make spi_sync the primary interface which the message pump is also 
  using directly
* move all the prepare stuff early into spi-sync, so that for example the
  Preparing (including dma mapping) would get done in the calling thread
  And only the prepared message would get submitted to the queue
  - special processing would be needed for the spi-async case.

This should optimize the computations out of the central loop faster.

Adding spi-nand support could get added later by someone who has
access to a device making use of this.

If that sounds as somewhat acceptable then I will try get something
Implemented.

Any other ideas where we could improve as well?

Martin



