Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85A0E4CE11
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2019 14:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbfFTM4c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jun 2019 08:56:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:9151 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbfFTM4b (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 20 Jun 2019 08:56:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 05:56:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,396,1557212400"; 
   d="scan'208";a="181853271"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 20 Jun 2019 05:56:27 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 20 Jun 2019 15:56:26 +0300
Date:   Thu, 20 Jun 2019 15:56:26 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org,
        andy.shevchenko@gmail.com, masahisa.kojima@linaro.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-acpi@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] spi/acpi: avoid spurious matches during slave enumeration
Message-ID: <20190620125626.GA2640@lahna.fi.intel.com>
References: <20190620123649.4492-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620123649.4492-1-ard.biesheuvel@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jun 20, 2019 at 02:36:49PM +0200, Ard Biesheuvel wrote:
> In the new SPI ACPI slave enumeration code, we use the value of
> lookup.max_speed_khz as a flag to decide whether a match occurred.
> However, doing so only makes sense if we initialize its value to
> zero beforehand, or otherwise, random junk from the stack will
> cause spurious matches.
> 
> So zero initialize the lookup struct fully, and only set the non-zero
> members explicitly.
> 
> Fixes: 4c3c59544f33 ("spi/acpi: enumerate all SPI slaves in the namespace")
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
