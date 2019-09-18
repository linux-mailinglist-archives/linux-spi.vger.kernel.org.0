Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1E3CB5B7D
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2019 07:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfIRF7K (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Sep 2019 01:59:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:19499 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfIRF7K (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 18 Sep 2019 01:59:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2019 22:59:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,519,1559545200"; 
   d="scan'208";a="189161370"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 17 Sep 2019 22:59:09 -0700
Received: from [10.226.38.20] (unknown [10.226.38.20])
        by linux.intel.com (Postfix) with ESMTP id 645335800B9;
        Tue, 17 Sep 2019 22:59:07 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] spi: cadence-qspi: Add QSPI support for Intel LGM
 SoC
To:     Mark Brown <broonie@kernel.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <20190916073843.39618-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190916073843.39618-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190916113255.GA4352@sirena.co.uk>
 <466b41c1-3d65-0bf4-6db7-d3b3e06b107b@linux.intel.com>
 <20190917153650.GF3524@sirena.co.uk>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <eeefa79b-0a3b-5d62-3a1b-c1e9dcb03aa7@linux.intel.com>
Date:   Wed, 18 Sep 2019 13:59:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190917153650.GF3524@sirena.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

    Thank you for the review comments.

On 17/9/2019 11:36 PM, Mark Brown wrote:
> On Tue, Sep 17, 2019 at 10:11:28AM +0800, Ramuthevar, Vadivel MuruganX wrote:
>
>> *    spi-cadence.c* in *drivers/spi/*, which supports very old legacy
>> cadence-spi based devices(normal)
>> *    cadence-quadspi.c(drivers/mtd/spi-nor/)* : specific support to SPI-NOR
>> flash with new spi-nor layer.
>>      all the API's in this driver purely on spi-nor specific, so couldn't
>> proceed to adapt.
> Are these completely separate IPs or are they just different versions of
> the same IP?

These are same IPs , but different features Enabled/Disabled depends 
upon the SoC vendors.

for e.g: Intel LGM SoC uses the same IP, but without DMA and Direct 
access controller.

also dedicated support to flash devices.

Best regards

Vadivel

