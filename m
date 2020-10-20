Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AE0293562
	for <lists+linux-spi@lfdr.de>; Tue, 20 Oct 2020 09:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404710AbgJTHBS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Oct 2020 03:01:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:43654 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404628AbgJTHBR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Oct 2020 03:01:17 -0400
IronPort-SDR: 2zOpZrIpuGe+p6FUJCV7nRZkj7h74yMrMBx2IgjDOxejAMhaVVfL0s61/JA2kSCDRVHdHiksYj
 jI59V29MCmeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="231361300"
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400"; 
   d="scan'208";a="231361300"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 00:01:16 -0700
IronPort-SDR: /vPIQ5fTxE37/HGUWpCRGALFjoRLIrraxQcxoovDQw36qCRSewL1l8ci7P2GvZnaTB7K59gqs8
 fOGbIiCmPMLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400"; 
   d="scan'208";a="347748282"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 20 Oct 2020 00:01:15 -0700
Received: from [10.226.38.26] (vramuthx-mobl1.gar.corp.intel.com [10.226.38.26])
        by linux.intel.com (Postfix) with ESMTP id 78D725808A3;
        Tue, 20 Oct 2020 00:01:12 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v1 1/6] spi: Move cadence-quadspi.txt to
 Documentation/devicetree/bindings/spi
To:     Rob Herring <robh@kernel.org>
Cc:     simon.k.r.goldschmidt@gmail.com, richard@nod.at,
        qi-ming.wu@intel.com, vigneshr@ti.com, linux-spi@vger.kernel.org,
        broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        cheol.yong.kim@intel.com, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, dinguyen@kernel.org,
        linux-kernel@vger.kernel.org
References: <20201016093138.28871-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201016093138.28871-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201019212658.GA3630377@bogus>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <e63cfb14-5cb8-defb-5569-7964bf4d38e2@linux.intel.com>
Date:   Tue, 20 Oct 2020 15:01:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201019212658.GA3630377@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

On 20/10/2020 5:26 am, Rob Herring wrote:
> On Fri, 16 Oct 2020 17:31:33 +0800, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Move the Documentation/devicetree/bindings/mtd/cadence-quadspi.txt to
>> Documentation/devicetree/bindings/spi/
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   Documentation/devicetree/bindings/{mtd => spi}/cadence-quadspi.txt | 0
>>   1 file changed, 0 insertions(+), 0 deletions(-)
>>   rename Documentation/devicetree/bindings/{mtd => spi}/cadence-quadspi.txt (100%)
>>
> 
> Acked-by: Rob Herring <robh@kernel.org>
Thank you for an Ack!
> 
