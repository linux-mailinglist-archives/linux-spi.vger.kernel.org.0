Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B665C50812A
	for <lists+linux-spi@lfdr.de>; Wed, 20 Apr 2022 08:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346614AbiDTG3z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Apr 2022 02:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348640AbiDTG3x (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Apr 2022 02:29:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A543AA66
        for <linux-spi@vger.kernel.org>; Tue, 19 Apr 2022 23:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650436024; x=1681972024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hfwbe9msN9hFNQGBoKCNDDtBbbvKTG5hJQ92VxaPBBY=;
  b=MsT0LuKTfoCZgZLbkQvfMT5sagBUPCr2AiaVqx36nSm8Iuo23GF8PgeR
   1V3RQobCeJ+9WjBjHt4h+z/9HOtEDHAl8K+wdZA5Tpr+KrVyH5r2hHyaK
   K/9N53Dz8fmOM4eNhqzmxkuK4mTDiQfwangBtbDO7QBypdkJE3N4nnVZE
   8RgT57QoPheIDJ6y7AOSg7t0m9dmFaBwIiDDk64Dlh/RBkm/CcwwMyU8S
   j90GJ0GFChFn74Ve5EFTpuR82sSzXtt6cbgxaDJ9Yv1GjbhUPzm5Kwh0x
   xLCcoIM1gVvF+MTThlq3Aa0yUdbC41oXDuEk+QFe/rCwWhMSpBOzqelaR
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="289055419"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="289055419"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 23:27:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="593063703"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 23:27:01 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 20 Apr 2022 09:25:48 +0300
Date:   Wed, 20 Apr 2022 09:25:48 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Hongli Li <hongli.li@intel.com>, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 2/2] spi: intel: Implement dirmap hooks
Message-ID: <Yl+nbNCj5l7uDgH0@lahna>
References: <20220411113158.2037-1-mika.westerberg@linux.intel.com>
 <20220411113158.2037-2-mika.westerberg@linux.intel.com>
 <Yl6nS0kSdSGOCYM3@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yl6nS0kSdSGOCYM3@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On Tue, Apr 19, 2022 at 01:12:59PM +0100, Mark Brown wrote:
> On Mon, Apr 11, 2022 at 02:31:58PM +0300, Mika Westerberg wrote:
> > Currently the driver goes over the supported opcodes list each time
> > ->exec_op() is called and finds the suitable for the given operation.
> > This consumes unnecessary amount of CPU cycles because the operation is
> > always the same. For this reason populate dirmap hooks for the driver so
> > that we cache the selected operation and then simply call it on each
> > read/write.
> 
> This breaks an x86 allmodconfig build:
> 
> /build/stage/linux/drivers/spi/spi-intel.c: In function ‘intel_spi_dirmap_read’:
> /build/stage/linux/drivers/spi/spi-intel.c:808:38: error: passing argument 2 of ‘iop->exec_op’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>   808 |         ret = iop->exec_op(ispi, desc->mem, iop, &op);
>       |                                  ~~~~^~~~~
>       |                                      |
>       |                                      struct spi_mem *

Oh, indeed :( I have another patch adding second chip select support
that adds the parameter and then I changed the ordering, and of course
forgot to reflect that to this patch. I will fix this up and re-send.
Sorry about this.
