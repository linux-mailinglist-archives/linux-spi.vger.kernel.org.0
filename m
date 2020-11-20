Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E28E2B9F5B
	for <lists+linux-spi@lfdr.de>; Fri, 20 Nov 2020 01:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgKTAe0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Nov 2020 19:34:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:11591 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbgKTAe0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 19 Nov 2020 19:34:26 -0500
IronPort-SDR: p5XUTT3ag2CTB9dQFi/1JhzwmJdQVn48f3G9OMj6k2IzKrUIBS2iIS4FWY/Wrv86s3mVe2qf5Z
 J8PtQiIzOCkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="171558251"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="171558251"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 16:34:25 -0800
IronPort-SDR: eeeBn7+16YW+iSbQfMJEJ2UAcXVpvq/j7G9JdiIzK1GWAklsaRWMgOpNUpkMUE8KLNi1SIH5gq
 g25Uqvr95ujQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="534981484"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 19 Nov 2020 16:34:24 -0800
Received: from [10.213.153.3] (vramuthx-MOBL1.gar.corp.intel.com [10.213.153.3])
        by linux.intel.com (Postfix) with ESMTP id A8653580409;
        Thu, 19 Nov 2020 16:34:22 -0800 (PST)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v8 0/6] spi: cadence-quadspi: Add QSPI controller support
 for Intel LGM SoC
To:     Vignesh Raghavendra <vigneshr@ti.com>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, p.yadav@ti.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <20201119055551.26493-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <3f9abc46-b874-465e-152f-f6c0065e5613@ti.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <9d0ed730-59fc-b00e-5648-f1e5aeab0333@linux.intel.com>
Date:   Fri, 20 Nov 2020 08:34:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <3f9abc46-b874-465e-152f-f6c0065e5613@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Vignesh,

Thank you for the review comments...

On 19/11/2020 9:06 pm, Vignesh Raghavendra wrote:
> 
> 
> On 11/19/20 11:25 AM, Ramuthevar,Vadivel MuruganX wrote:
>> Add QSPI controller support for Intel LGM SoC.
>>
>> Note from Vignesh(mtd subsystem maintainer):
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
> 
> This text no longer makes sense anymore with few patches dropped and
> others reordered
Just for reference added, will drop it.
> 
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
> 
>>
>> Ramuthevar Vadivel Murugan (6):
>>    spi: cadence-quadspi: Add QSPI support for Intel LGM SoC
>>    spi: cadence-quadspi: Disable the DAC for Intel LGM SoC
>>    spi: cadence-quadspi: Add multi-chipselect support for Intel LGM SoC
>>    spi: Move cadence-quadspi.txt to Documentation/devicetree/bindings/spi
>>    dt-bindings: spi: Convert cadence-quadspi.txt to cadence-quadspi.yaml
>>    dt-bindings: spi: Add compatible for Intel LGM SoC
>>
> 
> This is quite confusing... Summary/diffstat still shows patches 4 to 6
> and so does the patch numbering in $subject while changelog says
> otherwise and I received only 3 patches in my Inbox?
oh my bad, while patch creation wrongly added, will correct it, thanks!

Regards
Vadivel
> 
> 
>>   .../devicetree/bindings/mtd/cadence-quadspi.txt    |  67 ----------
>>   .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 148 +++++++++++++++++++++
>>   drivers/spi/Kconfig                                |   2 +-
>>   drivers/spi/spi-cadence-quadspi.c                  |  33 ++++-
>>   4 files changed, 178 insertions(+), 72 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
>>   create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>>
> 
> So does the diffstat...
> 
