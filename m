Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0802715A63B
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2020 11:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgBLKYr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Feb 2020 05:24:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:40755 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgBLKYr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 12 Feb 2020 05:24:47 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 02:24:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="237671207"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 12 Feb 2020 02:24:43 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j1pCG-000uto-8C; Wed, 12 Feb 2020 12:24:44 +0200
Date:   Wed, 12 Feb 2020 12:24:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Rajat Jain <rajatja@google.com>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        rajatxjain@gmail.com, evgreen@google.com,
        shobhit.srivastava@intel.com, porselvan.muthukrishnan@intel.com
Subject: Re:
Message-ID: <20200212102444.GR10400@smile.fi.intel.com>
References: <20200211223400.107604-1-rajatja@google.com>
 <b3397374-0cb8-cf6c-0555-34541a1c108c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3397374-0cb8-cf6c-0555-34541a1c108c@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Feb 12, 2020 at 11:30:51AM +0200, Jarkko Nikula wrote:
> On 2/12/20 12:34 AM, Rajat Jain wrote:

> This patch subject is missing from mail subject.

> I'm thinking can this be done only once after resume and may other LPSS
> blocks need the same? I.e. should this be done in drivers/mfd/intel-lpss.c?

On resume we restore the previously saved context, can we be sure that values
we saved during suspend are correct?

If above won't show any issue, it might be best place to have this quirk
applied in intel_lpss_suspend() / intel_lpss_resume() callbacks as Jarkko
suggested.

-- 
With Best Regards,
Andy Shevchenko


