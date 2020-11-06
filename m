Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5382A8E69
	for <lists+linux-spi@lfdr.de>; Fri,  6 Nov 2020 05:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgKFEdN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Nov 2020 23:33:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:29066 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgKFEdN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Nov 2020 23:33:13 -0500
IronPort-SDR: XJ21RBExyM9V8nzps9v9SCnDK0GBZczcSO1dKLB/u1oBTj20cRXu3bP8y/rocTl4LFSMcOIk34
 m7pWgQg/1dIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="233667386"
X-IronPort-AV: E=Sophos;i="5.77,455,1596524400"; 
   d="scan'208";a="233667386"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 20:33:12 -0800
IronPort-SDR: 7SctOXFUOGmjDkRR+9WJYNZt298Uat34XoyBlMrWswJPKKqaMnyWUyTDE69dsX4EWvcWq9blw2
 mh8/xkQm99VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,455,1596524400"; 
   d="scan'208";a="326282609"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 05 Nov 2020 20:33:12 -0800
Received: from [10.215.162.127] (vramuthx-MOBL1.gar.corp.intel.com [10.215.162.127])
        by linux.intel.com (Postfix) with ESMTP id 73C3B580841;
        Thu,  5 Nov 2020 20:33:08 -0800 (PST)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v6 3/6] spi: cadence-quadspi: Add multi-chipselect support
 for Intel LGM SoC
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Vignesh R <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        =?UTF-8?Q?Miqu=c3=a8l_Raynal?= <miquel.raynal@bootlin.com>,
        Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Richard Weinberger <richard@nod.at>, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <20201030053153.5319-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201030053153.5319-4-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CACRpkdZnAfogewQt83wDMmkhb4kZD=qdbq26nHcam3401WGiOA@mail.gmail.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <5a4f6085-0408-d5e5-5f40-efc7814cbe42@linux.intel.com>
Date:   Fri, 6 Nov 2020 12:33:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdZnAfogewQt83wDMmkhb4kZD=qdbq26nHcam3401WGiOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Linus,

Thank you for the review comments...

On 5/11/2020 3:11 pm, Linus Walleij wrote:
> On Fri, Oct 30, 2020 at 6:32 AM Ramuthevar,Vadivel MuruganX
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
> 
>> +       ddata  = of_device_get_match_data(dev);
>> +       if (ddata->hwcaps_mask & CQSPI_SUPPORTS_MULTI_CHIPSELECT) {
>> +               if (of_property_read_u32(np, "num-chipselect",
> 
> The standard SPI bindings in spi-controller.yaml already has a binding
> for this "num-cs" so please use that. It is also what your device tree
> binding is referencing, 
yes, you are point is valid, I will use that.
so if you were using "num-chipselect" the
> YAML check should give a warning?
In the example, I just converted from existing txt -to- yaml that's
why I didnt face any problem.

Regards
Vadivel
> 
> Yours,
> Linus Walleij
> 
