Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08B241622DC
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2020 09:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgBRI4g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Feb 2020 03:56:36 -0500
Received: from mga06.intel.com ([134.134.136.31]:38072 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgBRI4g (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 18 Feb 2020 03:56:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 00:56:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,456,1574150400"; 
   d="scan'208";a="314991670"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 18 Feb 2020 00:56:35 -0800
Received: from [10.226.38.30] (unknown [10.226.38.30])
        by linux.intel.com (Postfix) with ESMTP id 2ABC458033E;
        Tue, 18 Feb 2020 00:56:31 -0800 (PST)
Subject: Re: [PATCH v9 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dan.carpenter@oracle.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        dinguyen@kernel.org, tien.fong.chee@intel.com
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAAh8qsxnRSwonuEPrriuS=gUMTjt8ddUVy5HxegmoCk-FoE4qg@mail.gmail.com>
 <20200214121145.GF4827@sirena.org.uk>
 <4712cdc4-34cd-990b-3d53-3d394ae1250b@linux.intel.com>
 <20200217115213.GA9304@sirena.org.uk>
 <f5f868e5-a977-7487-9395-a76dd5e7c963@ti.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <49bc16bc-297f-d58c-5b93-6397edf1fbda@linux.intel.com>
Date:   Tue, 18 Feb 2020 16:56:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <f5f868e5-a977-7487-9395-a76dd5e7c963@ti.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Vignesh,

On 17/2/2020 8:18 PM, Vignesh Raghavendra wrote:
> Hi Vadivel,
>
> On 17/02/20 5:22 pm, Mark Brown wrote:
>> On Mon, Feb 17, 2020 at 05:28:38PM +0800, Ramuthevar, Vadivel MuruganX wrote:
>>> On 14/2/2020 8:11 PM, Mark Brown wrote:
>>>> Given that this is a new driver I'd be very surprised if it broke other
>>>> users?  I can imagine it might not work for them and it would definitely
>>>> be much better to get their review but it shouldn't be any worse than
>>>> the current lack of support.
>>> *[Vignesh]*  The legacy driver under drivers/mtd/spi-nor will be removed as
>>> we cannot
>>> support both SPI NOR and SPI NAND with single driver if its under
>>> spi-nor. New driver should be functionally equivalent to existing one.
>>> So I suggest you test this driver on legcay SoCFPGA products.
>> You're not actually removing the driver here, you're adding another
>> driver for the same thing.
>>
> I agree with Mark here.
>
> I realized that you are using same CONFIG option as the old one to build
> this driver. This causes new driver to fail to probe as old driver would
> bind to the node instead (both drivers will be built into the kernel and
> both drivers have same compatible).
>
> So, you should remove the old driver. Could you also include patches
> removing old driver? New driver and bindings are anyways backward
> compatible with existing one
Sure , will remove the existing driver and sending single patch, Thanks!

Regards
Vadivel
