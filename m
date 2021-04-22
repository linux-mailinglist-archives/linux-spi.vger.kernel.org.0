Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A526F367F72
	for <lists+linux-spi@lfdr.de>; Thu, 22 Apr 2021 13:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbhDVLTN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Apr 2021 07:19:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:24052 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236087AbhDVLTN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 22 Apr 2021 07:19:13 -0400
IronPort-SDR: qOOhlRwEouIHjKMQ0QicD5u+8TSb4vPYVf/PCkCuNC/1xR5DvShp3pcADFCVbRgiYeLYpHepPY
 GsQ54pzXIzSA==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="175353917"
X-IronPort-AV: E=Sophos;i="5.82,242,1613462400"; 
   d="scan'208";a="175353917"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 04:18:37 -0700
IronPort-SDR: YKtPdeYyAb17FoK2RSAGl3PBWg3fq2Ve7xGQ/FHHu4Kd7KdA41vuYaFFqqM+OLbusLOaswCTpy
 A0Sp2Ul6aVKQ==
X-IronPort-AV: E=Sophos;i="5.82,242,1613462400"; 
   d="scan'208";a="453227876"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 04:18:35 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lZXLt-006G58-MS; Thu, 22 Apr 2021 14:18:33 +0300
Date:   Thu, 22 Apr 2021 14:18:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: Rename enable1 to activate in spi_set_cs()
Message-ID: <YIFbiQklq6ttXu1P@smile.fi.intel.com>
References: <20210420131846.75983-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420131846.75983-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Apr 20, 2021 at 04:18:46PM +0300, Andy Shevchenko wrote:
> The enable1 is confusing name. Change it to clearly show what is
> the intention behind it. No functional changes.

Is this one okay or does it require some work?


-- 
With Best Regards,
Andy Shevchenko


