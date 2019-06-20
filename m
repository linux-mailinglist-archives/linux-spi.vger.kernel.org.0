Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E83E84CE0E
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2019 14:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbfFTMyl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jun 2019 08:54:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:32429 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbfFTMyl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 20 Jun 2019 08:54:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 05:54:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,396,1557212400"; 
   d="scan'208";a="165309292"
Received: from mylly.fi.intel.com (HELO [10.237.72.61]) ([10.237.72.61])
  by orsmga006.jf.intel.com with ESMTP; 20 Jun 2019 05:54:38 -0700
Subject: Re: [PATCH] spi/acpi: avoid spurious matches during slave enumeration
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-spi@vger.kernel.org
Cc:     broonie@kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        andy.shevchenko@gmail.com, masahisa.kojima@linaro.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
References: <20190620123649.4492-1-ard.biesheuvel@linaro.org>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <dc5e7e9b-1aae-d268-c4b7-b14288247cb1@linux.intel.com>
Date:   Thu, 20 Jun 2019 15:54:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190620123649.4492-1-ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 6/20/19 3:36 PM, Ard Biesheuvel wrote:
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
> Cc: andy.shevchenko@gmail.com
> Cc: masahisa.kojima@linaro.org
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: linux-acpi@vger.kernel.org
> Cc: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>   drivers/spi/spi.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
