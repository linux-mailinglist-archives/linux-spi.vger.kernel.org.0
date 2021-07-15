Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4FD3CA596
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jul 2021 20:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhGOSj0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Jul 2021 14:39:26 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49468 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhGOSj0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 15 Jul 2021 14:39:26 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16FIaVsJ015674;
        Thu, 15 Jul 2021 13:36:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626374191;
        bh=WlRz9fBX24Was6x0T1p3ro/jH/U2eTIShEnKruwRElE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=uLWenkjDIqKnKTH1/TN6/yg3Cn9LIKDuAtF7j09/TNcF0HutkHy3zgcR9utdtNtm0
         sThs1Mmq4VocoqYF8yCYg47EKTwvAo3m3eOiIxLgiM+shczyp6lJAj9RY2b5NN+arr
         rVCfobXL3f8jhuOqk66kZiTS4y9Klx0DqTsRs2O0=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16FIaVBn090211
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jul 2021 13:36:31 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 15
 Jul 2021 13:36:30 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 15 Jul 2021 13:36:30 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16FIaTmD014416;
        Thu, 15 Jul 2021 13:36:30 -0500
Date:   Fri, 16 Jul 2021 00:06:29 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Apurva Nandan <a-nandan@ti.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/2] spi: cadence-quadspi: Disable Auto-HW polling
Message-ID: <20210715183627.qtibbtrbsq7wsx42@ti.com>
References: <20210713125743.1540-1-a-nandan@ti.com>
 <20210713125743.1540-2-a-nandan@ti.com>
 <20210713182550.GG4098@sirena.org.uk>
 <f1947183-81d2-3519-d25f-71d93f59e434@ti.com>
 <20210714162805.GE4719@sirena.org.uk>
 <dfa38823-b63f-1807-6141-682930de2f3a@ti.com>
 <1cebc261-e0aa-572a-8083-1e3ec0d09195@ti.com>
 <20210715164142.GB27092@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210715164142.GB27092@sirena.org.uk>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 15/07/21 05:41PM, Mark Brown wrote:
> On Thu, Jul 15, 2021 at 09:57:51PM +0530, Apurva Nandan wrote:
> 
> > Now, whether the poll instruction should have an address phase or not
> > depends on the connected flash chip, which the controller wouldn't be
> > aware of as it only takes in a spimem op from the flash cores for execution.
> 
> ...
> 
> > More to this, not just address phase but any kind of variation in the
> > read register operation would result in polling failure.
> 
> That seems like something that should be fixed since it means that no
> controller will be able to support a feature like this - it needs to get
> enough information passed to it to allow it to poll correctly.

Right.

> 
> > Any SPI operation that is going underneath the visibility of flash core
> > can can problems. I agree offloading the status polling process to
> > controller HW is beneficial but on the other hand it restricts the flash
> > on having a fixed type of polling operation. This would reduce the
> > number of flash devices it will support (out of the box).
> > What should be the right way out for this situation?
> 
> One idea would be to have something that takes both the operation itself
> and the operation that's used to poll for status (with expected result),
> the controller can then check the poll operation and either tell the
> core it's not supported or go ahead and do the polling.  Or simpler just
> a separate poll operation which is fully specified enough.

We do have the new spi_mem_poll_status() API that does this somewhat. 
But this is not very useful for this controller since it you can't issue 
the auto polling on demand. It only happens when you perform a write.

One option is:

  spi_mem_exec_op_with_poll(mem, op, poll_op, mask, match, timeout);

But then the problem is how to tell the caller whether the poll actually 
happened or not. The other option I see is:

  ret = spi_mem_set_autopoll_op(mem, poll_op, mask, match, ...);
  spi_mem_exec_op(mem, op);

  if (ret == -EOPNOTSUPP)
	poll_status();

When spi_mem_set_autopoll_op() is called, the controller driver can 
check if it can autopoll with this op. It can configure its autopoll 
feature based on this, and can provide feedback to the caller about 
whether they will then have to poll themselves, or it has already been 
done for them.

I like the latter option more.

I think the question we need to answer first is whether doing all this 
is worth the hassle. Are there enough controllers with this auto polling 
feature to make it worth the bother?

> 
> Not actually looked at the code to see how tasteful that is though...

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
