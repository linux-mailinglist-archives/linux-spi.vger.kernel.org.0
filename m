Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E741252353
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 00:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgHYWGv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Aug 2020 18:06:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:3658 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgHYWGv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 25 Aug 2020 18:06:51 -0400
IronPort-SDR: 0q+LsUwTUppTEdFEhszVTx/OAffSL6aR7tTCgxZ4NjGWocY2adQXYJA0wPpQ7RdrmlX6C33AZo
 XkOctnF0kb6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="143976451"
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="143976451"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 15:06:51 -0700
IronPort-SDR: yADuTKWgeKCc9PVCf49RctCfYFju9B48eBZx5F6RW9H6Caa3txLDDhDUfkj2IJJt4mh6E6kHwo
 wBPl+FvASyMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="329011301"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 25 Aug 2020 15:06:50 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kAh5c-00BPy8-8w; Wed, 26 Aug 2020 01:06:48 +0300
Date:   Wed, 26 Aug 2020 01:06:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org
Subject: Re: [PATCH v2] spi: pxa2xx: Add SSC2 and SSPSP2 SSP registers
Message-ID: <20200825220648.GY1891694@smile.fi.intel.com>
References: <20200825201743.4926-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825201743.4926-1-cezary.rojewski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Aug 25, 2020 at 10:17:43PM +0200, Cezary Rojewski wrote:
> Update list of SSP registers with SSC2 and SSPSP2. These registers are
> utilized by LPT/WPT AudioDSP architecture.
> 
> While SSC2 shares the same offset (0x40) as SSACDD, description of this
> register for SSP device present on mentioned AudioDSP is different so
> define separate constant to avoid any ambiguity.
> 
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Side note for the future: When you put a tag, you may remove Cc of the same
person (git-send-email will add Cc based on the tag).

-- 
With Best Regards,
Andy Shevchenko


