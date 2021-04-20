Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C742365BE0
	for <lists+linux-spi@lfdr.de>; Tue, 20 Apr 2021 17:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhDTPHm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Apr 2021 11:07:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:57498 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232450AbhDTPHl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Apr 2021 11:07:41 -0400
IronPort-SDR: G5cTN16g3QeuYM0wus8A5k6MAzklftn+xtJjDGAJpcZm/YzGcHVpTTuBpXz7eHeTogZkWebWSr
 jjLPCXaZPwwA==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="175008354"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="175008354"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 08:07:10 -0700
IronPort-SDR: 9q13GGCrrghGbB9eslsi8trUnvImpwcPLvXvJd4rHoH4onIGxStG7XtiuzghhDcmRElWeGR0jj
 WdtcHUSCTTCA==
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="384111398"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 08:07:09 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lYrxy-005n4e-Lf; Tue, 20 Apr 2021 18:07:06 +0300
Date:   Tue, 20 Apr 2021 18:07:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] spi: Avoid potential UB when counting unused
 native CSs
Message-ID: <YH7uGhEmnk2sBzVv@smile.fi.intel.com>
References: <20210420141004.59936-1-andriy.shevchenko@linux.intel.com>
 <20210420141004.59936-2-andriy.shevchenko@linux.intel.com>
 <20210420145616.GC6073@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420145616.GC6073@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Apr 20, 2021 at 03:56:16PM +0100, Mark Brown wrote:
> On Tue, Apr 20, 2021 at 05:10:04PM +0300, Andy Shevchenko wrote:
> > ffz(), that has been used to count unused native CSs, might produce UB
> 
> Bit of an IA there...

UB -- undefined behaviour.
I'll decode it. Should I decode CS as well?

-- 
With Best Regards,
Andy Shevchenko


