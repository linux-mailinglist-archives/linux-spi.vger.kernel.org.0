Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0BD61DCD26
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 14:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgEUMoB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 08:44:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:52775 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728133AbgEUMoB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 May 2020 08:44:01 -0400
IronPort-SDR: CfbqkvL5jQccVODoS+fc38SZP7pi4T7nidPIHfOAxPGKfDv9MsqTFOCUTe0DHykuR8l6K0tops
 xSrsfxGBEfFg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 05:44:01 -0700
IronPort-SDR: aHzqo4PXnOejTBUW6P+vTkEhj/SEhiL123RZpfLwQmtEa6X671yVZFbDI44O4F2YeKwIAyFhWt
 6SSKRUz/9s7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,417,1583222400"; 
   d="scan'208";a="412380047"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 21 May 2020 05:44:00 -0700
Received: from [10.215.164.158] (vramuthx-mobl1.gar.corp.intel.com [10.215.164.158])
        by linux.intel.com (Postfix) with ESMTP id D70DA5804B4;
        Thu, 21 May 2020 05:43:52 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v2 1/1] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
To:     Mark Brown <broonie@kernel.org>
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, vigneshr@ti.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <20200520123612.11797-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200520124329.GF4823@sirena.org.uk>
 <fd086da7-7e18-83bc-d423-56095b0cff96@linux.intel.com>
 <20200521105646.GA4770@sirena.org.uk>
 <24b0297c-5c33-f690-9514-68b76fc2c9ea@linux.intel.com>
 <20200521122035.GB4770@sirena.org.uk>
 <463b24a4-0a6a-9fcf-7eb9-8fde602c0c13@linux.intel.com>
 <20200521123735.GC4770@sirena.org.uk>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <f2f15cc2-e2e4-3379-f3b8-ca31a65ded54@linux.intel.com>
Date:   Thu, 21 May 2020 20:43:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521123735.GC4770@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On 21/5/2020 8:37 pm, Mark Brown wrote:
> On Thu, May 21, 2020 at 08:34:43PM +0800, Ramuthevar, Vadivel MuruganX wrote:
>> On 21/5/2020 8:20 pm, Mark Brown wrote:
> 
>>> I mean that any changes to the bindings ought to be split out into
>>> separate patches, if there's multiple changes it may make sense for
>>> there to be multiple patches.
> 
>> Got it, we do not have multiple changes since it is new YAML file.
>> in case if we feel anything to be added , we add as separate patches.
> 
> If this is just a conversion to YAML then your changelog is wildly
> inaccurate and needs to be improved, your changelog says you are adding
> new things.
Yes , You are right, just conversion only, over that adding/modifying 
few of the properties like compatible and node name in  the example..etc
Sure I will make a multiple patches , Thanks!

Regards
Vadivel

> 
