Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D7A327DFE
	for <lists+linux-spi@lfdr.de>; Mon,  1 Mar 2021 13:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbhCAMN4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Mar 2021 07:13:56 -0500
Received: from mga11.intel.com ([192.55.52.93]:8898 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233604AbhCAMNx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 1 Mar 2021 07:13:53 -0500
IronPort-SDR: vPTR7ZLpB6wC1YkSD0kOM07L639n12T/D0lcct6ky2Xtzx4iknYFO9pNG7vu5JYGHlwTk5hrtK
 JqXDcJp1qTMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="183042587"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="183042587"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 04:12:00 -0800
IronPort-SDR: EsaEcILB1OFORR2RiFKnNrMEx+lPqdyP/Dgd6Tt8YfhFDpGDHmIf4R/yX/oSQTcubfowW+JtsE
 97v1cdo9sXcw==
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="397700326"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 04:11:59 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lGhP1-0098VT-WC; Mon, 01 Mar 2021 14:11:55 +0200
Date:   Mon, 1 Mar 2021 14:11:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] parport: Introduce module_parport_driver() helper
 macro
Message-ID: <YDzaC2ahcHCrCI8V@smile.fi.intel.com>
References: <20210216110741.1286-1-andriy.shevchenko@linux.intel.com>
 <YDkpzZ8jL7O9HJuG@smile.fi.intel.com>
 <YDwmznD58ZtOwHgb@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDwmznD58ZtOwHgb@debian>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Feb 28, 2021 at 11:27:10PM +0000, Sudip Mukherjee wrote:
> On Fri, Feb 26, 2021 at 07:03:09PM +0200, Andy Shevchenko wrote:
> > On Tue, Feb 16, 2021 at 01:07:39PM +0200, Andy Shevchenko wrote:
> > > Introduce module_parport_driver() helper macro to reduce boilerplate
> > > in the existing and new code.
> > 
> > Sudip, any comments on this?
> 
> Sorry for the delay in reply.
> lgtm. I think there are few more drivers which can also use this new helper.
> Will you like to do them also?

Yes, that's the (slow going) plan.

> Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Thanks! I considered that you take it thru parport tree. Do you have something
else in mind?

-- 
With Best Regards,
Andy Shevchenko


