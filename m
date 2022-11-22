Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA929633C7C
	for <lists+linux-spi@lfdr.de>; Tue, 22 Nov 2022 13:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiKVMaf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Nov 2022 07:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbiKVMac (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Nov 2022 07:30:32 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA2D5B5B4
        for <linux-spi@vger.kernel.org>; Tue, 22 Nov 2022 04:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669120230; x=1700656230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pLqUyfQ32hwsa++iM/ixkMotyZAVzaFTjMFvtcUYzmg=;
  b=lUnXUGK7Pj5AtuAjcbwIJihr+uXRZBTE+L7e5amv9UAtPjpiRqYpPShV
   XTxMi5Rac1b6WckQwwgnOwAql8RcAKzlVF+S54TOD8QrRcp0qgi3rL8AC
   nVVZQoJSVk7oYcuaw8UJKL36bHP546Evk1jx8LAuq40zeaJhU7dsAzIH4
   dQjXe9f9pGp2fX0smeeORxA0Y0rO9Y2jSrxEUOePKh1o34mMVelmAnvSg
   GSyKNk8/uTyg6R0/ZIBUx64V+8hGIiw/h263mjW9tBkAGDPC4y7Mlyply
   kgD3mDf6xhdWaS9xK0c+8s1hc7W7QXyTPDYPID65PTXsLwDiUx2nq7COT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="294193547"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="294193547"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 04:30:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="672468614"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="672468614"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 22 Nov 2022 04:30:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id E48CC128; Tue, 22 Nov 2022 14:30:53 +0200 (EET)
Date:   Tue, 22 Nov 2022 14:30:53 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, "Gole, Dhruva" <d-gole@ti.com>
Subject: Re: [PATCH 0/4] spi: intel: Add support for SFDP opcode
Message-ID: <Y3zA/THfo2jBglKS@black.fi.intel.com>
References: <20221025064623.22808-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221025064623.22808-1-mika.westerberg@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On Tue, Oct 25, 2022 at 09:46:19AM +0300, Mika Westerberg wrote:
> Hi,
> 
> This series adds support for SFDP (Serial Flash Discoverable Parameter)
> opcode to the Intel SPI driver. This allows the SPI-NOR core to query
> the flash chip what it supports.
> 
> Mika Westerberg (4):
>   spi: intel: Use ->replacement_op in intel_spi_hw_cycle()
>   spi: intel: Implement adjust_op_size()
>   spi: intel: Take possible chip address into account in intel_spi_read/write_reg()
>   spi: intel: Add support for SFDP opcode
> 
>  drivers/spi/spi-intel.c | 78 +++++++++++++++++++++--------------------
>  1 file changed, 40 insertions(+), 38 deletions(-)

Any chance getting this queued for v6.2? Thanks!
