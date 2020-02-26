Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71BFC16F513
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2020 02:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbgBZBch (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Feb 2020 20:32:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:9676 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729395AbgBZBch (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 25 Feb 2020 20:32:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 17:32:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,486,1574150400"; 
   d="scan'208";a="241509135"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 25 Feb 2020 17:32:36 -0800
Received: from [10.226.38.18] (unknown [10.226.38.18])
        by linux.intel.com (Postfix) with ESMTP id EE2A3580544;
        Tue, 25 Feb 2020 17:32:33 -0800 (PST)
Subject: Re: [PATCH v10 1/2] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        simon.k.r.goldschmidt@gmail.com, Dinh Nguyen <dinguyen@kernel.org>,
        tien.fong.chee@intel.com,
        =?UTF-8?Q?Marek_Va=c5=a1ut?= <marex@denx.de>,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <20200219022852.28065-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200219022852.28065-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAL_JsqKJky=y4nhECUFVzTYvEpjFoOH_6UY9uZG5bvBVWq=SYQ@mail.gmail.com>
 <64b7ab12-0c11-df25-95e7-ee62227ec7ec@linux.intel.com>
 <85178128-4906-8b1a-e3f1-ab7a36ff8c23@ti.com>
 <c119a70d-b7ef-ab1b-4590-7ac77395297f@linux.intel.com>
 <8c329860-84fd-463b-782f-83a788998878@ti.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <98c90f35-297b-a13c-61ad-ce7a7f1d650f@linux.intel.com>
Date:   Wed, 26 Feb 2020 09:32:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <8c329860-84fd-463b-782f-83a788998878@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 25/2/2020 7:00 PM, Vignesh Raghavendra wrote:
>
> On 25/02/20 1:08 pm, Ramuthevar, Vadivel MuruganX wrote:
>>>>>> +
>>>>>> +  cdns,fifo-depth:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>>> +    description:
>>>>>> +      Size of the data FIFO in words.
>>>>> A 4GB fifo is valid? Add some constraints.
>>>> 128 is valid, will update.
>>> Nope, the width of this field is 8bits -> 256 bytes
>> correct me if I am wrong, the width of this field is 4bits -> 128 bytes
>> (based on QUAD mode) .
> This has nothing to do with quad-mode. Its about how much SRAM amount of
> SRAM is present to buffer INDAC mode data. For TI platforms this is 256
> bytes.
> See CQSPI_REG_SRAMPARTITION definition in your datasheet.
Agreed, Thanks!
Yes , I have gone through it , Intel and Altera SoC's SRAM(act as 
FIFO)size is 128 bytes and TI has 256 .
BTW old legacy DT binding mentioned size is 128, as per your earlier 
suggestion you have mention that
keep the contents from old dt bindings as it is, so shall I keep 128/256?

Regards
Vadivel
