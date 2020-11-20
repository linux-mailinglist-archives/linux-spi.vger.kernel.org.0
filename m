Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4494F2B9EFB
	for <lists+linux-spi@lfdr.de>; Fri, 20 Nov 2020 01:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgKTAGo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Nov 2020 19:06:44 -0500
Received: from mga07.intel.com ([134.134.136.100]:51260 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgKTAGo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 19 Nov 2020 19:06:44 -0500
IronPort-SDR: oVzYdSyNhBRRelooA+qv8BH3v6n/Dukip8V89tS3ESznkhPjVeg9wh78TJUmIt14ZtTEqEKe7j
 Wuw3Va2o9LjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="235534486"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="235534486"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 16:06:43 -0800
IronPort-SDR: iz+IielfoYppbtbikNhl3Wz2qLKZa2w0KeA48U77kvg/3ENjHg7xD+kQMaK7TM4lLN8PWKg+s4
 hFNuXq6YmpQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="360222742"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 19 Nov 2020 16:06:43 -0800
Received: from [10.213.153.3] (vramuthx-MOBL1.gar.corp.intel.com [10.213.153.3])
        by linux.intel.com (Postfix) with ESMTP id A8265580806;
        Thu, 19 Nov 2020 16:06:40 -0800 (PST)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v8 0/6] spi: cadence-quadspi: Add QSPI controller support
 for Intel LGM SoC
To:     Vignesh Raghavendra <vigneshr@ti.com>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, p.yadav@ti.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <20201119055551.26493-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <98b7b367-0bf3-e745-1dd2-302f76bab0b7@ti.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <b57321fc-f6ff-1a15-20fa-e776416544c9@linux.intel.com>
Date:   Fri, 20 Nov 2020 08:06:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <98b7b367-0bf3-e745-1dd2-302f76bab0b7@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Vignesh,

Thank you very much for the review comments...

On 19/11/2020 8:36 pm, Vignesh Raghavendra wrote:
> 
> 
> On 11/19/20 11:25 AM, Ramuthevar,Vadivel MuruganX wrote:
>> Add QSPI controller support for Intel LGM SoC.
>>
>> Note from Vignesh(mtd subsystem maintainer):H
>> This series is a subset of "[PATCH v12 0/4] spi: cadence-quadspi: Add
>> support for the Cadence QSPI controller" by Ramuthevar,Vadivel MuruganX
>> <vadivel.muruganx.ramuthevar@linux.intel.com> that intended to move
>> cadence-quadspi driver to spi-mem framework
>>
>> Those patches were trying to accomplish too many things in a single set
>> of patches and need to split into smaller patches. This is reduced
>> version of above series.
>>
>> Changes that are intended to make migration easy are split into separate
>> patches. Patches 1 to 3 drop features that cannot be supported under
>> spi-mem at the moment (backward compatibility is maintained).
>> Patch 4-5 are trivial cleanups. Patch 6 does the actual conversion to
>> spi-mem and patch 7 moves the driver to drivers/spi folder.
>>
>> I have tested both INDAC mode (used by non TI platforms like Altera
>> SoCFPGA) and DAC mode (used by TI platforms) on TI EVMs.
>>
>> Patches to move move bindings over to
>> "Documentation/devicetree/bindings/spi/" directory and also conversion
>> of bindig doc to YAML will be posted separately.  Support for Intel
>> platform would follow that.
>>
>> Reference:
>>          https://lkml.org/lkml/2020/6/1/50
>>
>> ---
>> v8:
>>    - As Mark suggested to add the dt-bindings documentation patches
>>      end of the series , so dropped.
> 
> Suggestion was to drop patches converting legacy binding doc to YAML schema.
> You still need to include a patch documenting new compatible
> "intel,lgm-qspi" in the existing (legacy) binding doc.
Noted, will do that.

Regards
Vadivel
> 
