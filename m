Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D882E7DDC
	for <lists+linux-spi@lfdr.de>; Thu, 31 Dec 2020 04:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgLaD2z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Dec 2020 22:28:55 -0500
Received: from mga18.intel.com ([134.134.136.126]:55661 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbgLaD2z (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Dec 2020 22:28:55 -0500
IronPort-SDR: fmiKhIlReQ1Xnn/rGvE3WWHIhcT/4IYf3+8qMcgbsFHOajvTAZiqyesas1dyjDST3QcNz3tDjr
 bujcrYCebfmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9850"; a="164375799"
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; 
   d="scan'208";a="164375799"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2020 19:28:15 -0800
IronPort-SDR: 4nEd9tuGFET2IJ17xLLLQk2AR5fGET0jtRv9hkcorEN37Rbx0woLwCABynHZk4y/aWyXhDzrTW
 XzcLGdMl5ktQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; 
   d="scan'208";a="419740778"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga001.jf.intel.com with ESMTP; 30 Dec 2020 19:28:13 -0800
Date:   Thu, 31 Dec 2020 11:23:37 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: fix the divide by 0 error when calculating xfer
  waiting time
Message-ID: <20201231032337.GA7980@yilunxu-OptiPlex-7050>
References: <1609219662-27057-1-git-send-email-yilun.xu@intel.com>
 <1609219662-27057-3-git-send-email-yilun.xu@intel.com>
 <20201229131308.GE4786@sirena.org.uk>
 <20201230022420.GF14854@yilunxu-OptiPlex-7050>
 <20201230134644.GE4428@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230134644.GE4428@sirena.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Dec 30, 2020 at 01:46:44PM +0000, Mark Brown wrote:
> On Wed, Dec 30, 2020 at 10:24:20AM +0800, Xu Yilun wrote:
> > On Tue, Dec 29, 2020 at 01:13:08PM +0000, Mark Brown wrote:
> 
> > > Does this still apply with current code?  There have been some fixes in
> > > this area which I think should ensure that we don't turn the speed down
> > > to 0 if the controller doesn't supply a limit IIRC.
> 
> > Yes, there is chance the speed is set to 0, some related code from 5.11-rc1
> 
> Please check the code in the SPI tree and -next.

I see the fix patches in maillist, thanks.

> 
> > BTW, Could we keep the spi->max_speed_hz if no controller->max_speed_hz?
> > Always clamp the spi->max_speed_hz to 0 makes no sense.
> 
> Right, that's the fix.

Seems it still doesn't fix the case that neither controller nor client dev
provides the non-zero max_speed_hz. Do you think the patch is still
necessary?

Thanks,
Yilun
