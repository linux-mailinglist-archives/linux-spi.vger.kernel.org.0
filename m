Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C7C610AF9
	for <lists+linux-spi@lfdr.de>; Fri, 28 Oct 2022 09:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJ1HFg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Oct 2022 03:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJ1HFf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Oct 2022 03:05:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21EF4623D
        for <linux-spi@vger.kernel.org>; Fri, 28 Oct 2022 00:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666940734; x=1698476734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qdlwbg1eCUvbstkzt9zs1hQS0LeR5rz3vUQ/l0NHdz8=;
  b=BhhM00MFeC2XxjgfPj1S5qLdJeNDIAfPx7pvM4Ofy/E4Zl3US/aq7DGl
   0mZNCnLArGu1sc05uksed5jGXFaS70rqci9rChQ4QAqwPvm8GoqPjgNul
   0sA/L+dQrzKWaYf7LtxBeyp0hBEQPwi0uO+ehP9oq4LXlP7/Vs6uB1tL6
   mdhkcglx34gPunNIdAuF6TnXGCG04kLG4hoF+9IkqHtrCeLdAtQeShJBj
   Xn8rUw92OmQ2kFWmb4NW2mESIFD1QwkkaN48h9R5Gvj5MwAx/9srumog6
   68qHJ7N/hDdq8n5YoHkbrxkb5Gp8j7tKv1IEBtlgdCHxI9pA+Oeah4m99
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="370493711"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="370493711"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 00:05:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="721954033"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="721954033"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Oct 2022 00:05:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 3CA4A107; Fri, 28 Oct 2022 10:05:47 +0300 (EEST)
Date:   Fri, 28 Oct 2022 10:05:47 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Gole, Dhruva" <d-gole@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: Re: [PATCH 2/4] spi: intel: Implement adjust_op_size()
Message-ID: <Y1t/SxzTWNPnr/8T@black.fi.intel.com>
References: <20221025064623.22808-1-mika.westerberg@linux.intel.com>
 <20221025064623.22808-3-mika.westerberg@linux.intel.com>
 <99f962a4-0101-b040-17dc-cec3d877dba8@ti.com>
 <Y1t13q53WbQxDzST@black.fi.intel.com>
 <32870277-555b-f384-c9e8-2b4225cb2943@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32870277-555b-f384-c9e8-2b4225cb2943@ti.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Fri, Oct 28, 2022 at 12:16:43PM +0530, Gole, Dhruva wrote:
> 
> On 10/28/2022 11:55 AM, Mika Westerberg wrote:
> > Hi,
> > 
> > On Fri, Oct 28, 2022 at 11:42:09AM +0530, Gole, Dhruva wrote:
> > > Hi Mika,
> > > 
> > > On 10/25/2022 12:16 PM, Mika Westerberg wrote:
> > > > This allows us to get rid of the checks in the intel_spi_[sh]w_cycle()
> > > > and makes it possible for the SPI-NOR core to split the transaction into
> > > > smaller chunks as needed.
> > > If I understand correctly, the controller ops are called from spi-mem.c, and
> > > 
> > > spi_mem_adjust_op does exist and on it's own does "split a data transfer
> > >   operation into multiple ones"
> > > 
> > > So is this really something that you require the controller to do and
> > > 
> > > can we not rely on spi-mem.c to do it's thing instead?
> > How does it know the size supported by the hardware? I think this is the
> > reason spi_mem_adjust_op was introduced but I may be mistaken.'
> 
> The following piece of code might help:
> 
>         op->data.nbytes = min3((size_t)op->data.nbytes,
>                        spi_max_transfer_size(mem->spi),
>                        spi_max_message_size(mem->spi)
> 
> I believe this will help it know the size supported by the hardware.
> 
> and on the controller side:
> 
> in case of cadence I have seen it pickup the fifo depth from DTSI, for eg.
> 
> arch/arm64/boot/dts/ti/k3-am62-main.dtsi: cdns,fifo-depth = <256>;

I'm not entirely sure I understand what you are suggesting to be honest? ;-)

For example the Intel SPI controller does not have any sort of device
tree description, it does not really understand anything about SPI
either (internally yes but the operations it exposes to software are
higher level), and it has fixed 64 byte FIFO.

Can I get the SFDP opcode supported with that without implementing
custom spi_mem_adjust_op() and if yes, how? Thanks!
