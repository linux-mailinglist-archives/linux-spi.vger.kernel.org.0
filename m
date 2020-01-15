Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC4AF13B976
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2020 07:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgAOGVO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jan 2020 01:21:14 -0500
Received: from mga05.intel.com ([192.55.52.43]:6993 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgAOGVN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 15 Jan 2020 01:21:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 22:21:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,321,1574150400"; 
   d="scan'208";a="248298629"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jan 2020 22:21:12 -0800
Received: from [10.226.38.22] (unknown [10.226.38.22])
        by linux.intel.com (Postfix) with ESMTP id 19E965802B0;
        Tue, 14 Jan 2020 22:21:10 -0800 (PST)
Subject: Re: [PATCH v6 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     Vignesh Raghavendra <vigneshr@ti.com>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, dan.carpenter@oracle.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <20191230074102.50982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <860aecbc-22d3-c9ce-3570-44115d6e81b2@ti.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <1aa6033a-c9e1-579b-0916-25037c07654d@linux.intel.com>
Date:   Wed, 15 Jan 2020 14:21:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <860aecbc-22d3-c9ce-3570-44115d6e81b2@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 15/1/2020 2:13 PM, Vignesh Raghavendra wrote:
> Hi,
>
> On 12/30/2019 1:11 PM, Ramuthevar,Vadivel MuruganX wrote:
>> Add support for the Cadence QSPI controller. This controller is
>> present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
>> This driver has been tested on the Intel LGM SoCs.
>>
>> This driver does not support generic SPI and also the implementation
>> only supports spi-mem interface to replace the existing driver in
>> mtd/spi-nor/cadence-quadspi.c, the existing driver only support SPI-NOR
>> flash memory.
>>
>
>
> I am finally able to get spi-mem based cadence-quaspi driver working on
> TI platforms with DMA and DAC mode. I have also incorporated changes to
> disable DAC and autopolling for your intel SoC:

Thanks! a lot for the confirmation, with your changes it is working on 
TI platform.

> https://github.com/r-vignesh/linux/commits/qspi
>
> (Top two patches are of interest)
>
> I have tested both DAC and INDAC mode with s25fl flash and everything
> seems to be fine. Could you re test the driver on your SoC? Feel free to
> fold it into your series if everything works.
sure, I will test on Intel SoC with your changes .

Regards
Vadivel
> Regards
> Vignesh
>
>
>
