Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D9429227B
	for <lists+linux-spi@lfdr.de>; Mon, 19 Oct 2020 08:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgJSG0o (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Oct 2020 02:26:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:17427 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgJSG0o (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Oct 2020 02:26:44 -0400
IronPort-SDR: EA6Z/X4lc3AOdEYcXaIokqXdc1aB+ekOovIYxup6k6LVFqrpWlsBT4S0RTE4cy/Em+6BwL11uC
 /uCGRQRjJUfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="164361114"
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="164361114"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2020 23:26:42 -0700
IronPort-SDR: DCdbjYGby5pOWTc5RmZWNjgvDZrbBdh1x6ZSFuS4F6rza9aPjzUsw0E1jvS/q/AjQrCqQbIBaW
 1OYSN3tLUTgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="301282872"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 18 Oct 2020 23:26:40 -0700
Received: from [10.226.38.24] (vramuthx-MOBL1.gar.corp.intel.com [10.226.38.24])
        by linux.intel.com (Postfix) with ESMTP id 8F7335808A3;
        Sun, 18 Oct 2020 23:26:37 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v1 4/6] spi: cadence-quadspi: Add QSPI support for Intel
 LGM SoC
To:     Mark Brown <broonie@kernel.org>
Cc:     vigneshr@ti.com, tudor.ambarus@microchip.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        miquel.raynal@bootlin.com, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, richard@nod.at, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <20201016093138.28871-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201016093138.28871-5-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201016163318.GI5274@sirena.org.uk>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <2c5d1e04-3b4c-311e-38fb-357e2fcd44a8@linux.intel.com>
Date:   Mon, 19 Oct 2020 14:26:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201016163318.GI5274@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On 17/10/2020 12:33 am, Mark Brown wrote:
> On Fri, Oct 16, 2020 at 05:31:36PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> 
>> +	depends on OF && (ARM || ARM64 || X86 || COMPILE_TEST)
> 
>> +	{
>> +		.compatible = "intel,lgm-qspi",
>> +	},
> 
> This is an x86 SoC (or SoC series) - is it really going to use DT for
> the firmware interfaces? 
Thank you for the review comments...
Intel LGM SoC does uses DT based firmware blob.
  It's not specifically a problem, just
> surprising to see something other than ACPI.  Or is the intention to use
> PRP0001? 
Yes, You're right most of them uses ACPI based, but LGM SoC doesn't.

Regards
Vadivel
  There's a new comaptible here which wasn't really the use case
> for PRP0001.  Like I say not really a problem, just curious.
> 
