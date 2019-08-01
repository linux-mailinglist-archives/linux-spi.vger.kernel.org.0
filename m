Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF4C7DB2E
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2019 14:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfHAMRW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Aug 2019 08:17:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50324 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHAMRW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Aug 2019 08:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dee5olqt7XlPjLLePVsNMyNo/Zg/J+KeegX7G29ctJE=; b=WGHtRa0yUM09pDDHuuiKDR7pv
        Pc3RFPJ1ikPHPGDtq379yWvLkjIGHBmehZWJjh1q2+0kKs/RxRzY+T0TOcGQRn8TXQ36H13My5gjU
        CaPk/hQEQwfast7p/7GOiTo11kk9mbEb0xuNk6FCVMaf96BURliBjRWb6BqUuv2CA+4KOprotj4Q1
        SCchH46ixelfj0caeUsXRSqGp/MwebEFEmqXRhaxoY8ugFwCTQ9DwLYH2R5X9L1JKE+xfk1GE7mQo
        Reo+CvQJlxglqQP5ZtPVWT7j2pS2HVHOp6PqPm/FJ7p8Q3yTViiVKQJpXR/7851AamZGI0RFufw3W
        5cpXbUERA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1htA1H-0007KB-VP; Thu, 01 Aug 2019 12:17:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 632452029F4C5; Thu,  1 Aug 2019 14:17:18 +0200 (CEST)
Date:   Thu, 1 Aug 2019 14:17:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Doug Anderson <dianders@google.com>
Subject: Re: [PATCH 5/5] spi: Reduce kthread priority
Message-ID: <20190801121718.GE31381@hirez.programming.kicks-ass.net>
References: <20190801111348.530242235@infradead.org>
 <20190801111541.917256884@infradead.org>
 <640721f8-8a20-b161-473f-98a9dbc053cc@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <640721f8-8a20-b161-473f-98a9dbc053cc@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Aug 01, 2019 at 01:27:04PM +0200, Enric Balletbo i Serra wrote:
> 
> cc'ing Doug as he might be really interested on this patch
> 
> On 1/8/19 13:13, Peter Zijlstra wrote:
> > The SPI thingies request FIFO-99 by default, reduce this to FIFO-50.
> > 
> 
> You say below that is not a suitable default but there is any other reason? Did
> you observed problems with this?

I didn't observe any problems with it personally. But imagine your
device is used to control something critical, like something leathal,
say a bandsaw. And just as you stick your hand through the laser
guarding it, your SPI device chirps and preempts the task that was about
to pull the emergency break and save your hand.

FIFO-99 is the highest possible prio (for SCHED_FIFO) and by using it
you say your task is the utmost imporant task on the system.

I'm thinking that isn't true 99% of the time, except of course when that
bandsaw emergency break is attached through SPI, but in that case the
admin can very well chrt the prio of this thread.

