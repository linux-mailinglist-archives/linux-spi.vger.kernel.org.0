Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7F22B56AA
	for <lists+linux-spi@lfdr.de>; Tue, 17 Nov 2020 03:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgKQCQW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 21:16:22 -0500
Received: from mga09.intel.com ([134.134.136.24]:44261 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727472AbgKQCQW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Nov 2020 21:16:22 -0500
IronPort-SDR: PbJGY+ed4JifbPaG2QLRcj+RrTMQFFow/x7WAoJ3Ki84Mz8aOxvt3czXxXSQqvpenQe3OdHOxk
 ZiyFx9ELKt1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="171019265"
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="171019265"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 18:16:19 -0800
IronPort-SDR: Di+NFc+q6jZhrHWVsvRMrloOEAgjXLd3pyvSbWk3pssZl2eMj0jBfZFWzP92vTT6Q8yv2mDgjo
 zrrdzn2/SLmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="367922696"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 16 Nov 2020 18:16:18 -0800
Received: from [10.213.151.175] (vramuthx-MOBL1.gar.corp.intel.com [10.213.151.175])
        by linux.intel.com (Postfix) with ESMTP id 1A900580428;
        Mon, 16 Nov 2020 18:16:15 -0800 (PST)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v7 5/6] dt-bindings: spi: Convert cadence-quadspi.txt to
 cadence-quadspi.yaml
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, vigneshr@ti.com, p.yadav@ti.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <20201116031003.19062-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201116031003.19062-6-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201116190733.GF4739@sirena.org.uk>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <17f8b568-77f6-df85-252c-2edadd2a76e5@linux.intel.com>
Date:   Tue, 17 Nov 2020 10:16:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201116190733.GF4739@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On 17/11/2020 3:07 am, Mark Brown wrote:
> On Mon, Nov 16, 2020 at 11:10:02AM +0800, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Convert the cadence-quadspi.txt documentation to cadence-quadspi.yaml
>> remove the cadence-quadspi.txt from Documentation/devicetree/bindings/spi/
> 
> As previously and repeatedly requested please make any conversions to
> YAML the *final* thing in serieses so that issues with the conversion do
> not hold up other development.
Thank you for the suggestions...
I understood like order of series to be changed, that's the reason 
added-up YAML conversion patches at the end of series, sorry I will drop 
the patches of YAML conversion.

Regards
Vadivel
> 
