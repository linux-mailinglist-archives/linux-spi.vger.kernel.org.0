Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E67B16B9CE
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2020 07:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgBYGdx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Feb 2020 01:33:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:4552 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729058AbgBYGdx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 25 Feb 2020 01:33:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 22:33:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,483,1574150400"; 
   d="scan'208";a="226244465"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 24 Feb 2020 22:33:52 -0800
Received: from [10.226.38.25] (unknown [10.226.38.25])
        by linux.intel.com (Postfix) with ESMTP id E5E0858052E;
        Mon, 24 Feb 2020 22:33:49 -0800 (PST)
Subject: Re: [PATCH v10 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        broonie@kernel.org
Cc:     robh+dt@kernel.org, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, tien.fong.chee@intel.com, marex@denx.de,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <20200219022852.28065-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <99f7e23f-268d-f32b-086f-4a46fc232ce9@ti.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <e5571c19-de2a-5c93-8bde-22b03d6a21a4@linux.intel.com>
Date:   Tue, 25 Feb 2020 14:33:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <99f7e23f-268d-f32b-086f-4a46fc232ce9@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 25/2/2020 12:23 PM, Vignesh Raghavendra wrote:
> Hi,
>
> On 19/02/20 7:58 am, Ramuthevar,Vadivel MuruganX wrote:
> [...]
>>      CHECK   Documentation/devicetree/bindings/spi/cdns,qspi-nor.example.dt.yaml
>>
>> Ramuthevar Vadivel Murugan (2):
>>    dt-bindings: spi: Add schema for Cadence QSPI Controller driver
>>    spi: cadence-quadpsi: Add support for the Cadence QSPI controller
>>
>>   .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 147 +++++
>>   drivers/mtd/spi-nor/Kconfig                        |  11 -
>>   drivers/mtd/spi-nor/Makefile                       |   1 -
>>   drivers/spi/Kconfig                                |   8 +
>>   drivers/spi/Makefile                               |   1 +
>>   .../spi-cadence-quadspi.c}                         | 641 ++++++++++-----------
>>   6 files changed, 459 insertions(+), 350 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> You will have to remove old bindings as well. Also please CC linux-mtd
> list as these patches touch drivers/mtd/*

Sure, will remove old bindings.

Agree!, cc of linux-mtd list.

>
> Just run scripts/get_maintainer.pl on your patches to get list of
> mailing list and people to CC

Thanks for the commands.

Regards
Vadivel
>>   rename drivers/{mtd/spi-nor/cadence-quadspi.c => spi/spi-cadence-quadspi.c} (73%)
>>
