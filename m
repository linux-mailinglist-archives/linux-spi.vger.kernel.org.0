Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9A4B160F99
	for <lists+linux-spi@lfdr.de>; Mon, 17 Feb 2020 11:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgBQKJN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Feb 2020 05:09:13 -0500
Received: from mga12.intel.com ([192.55.52.136]:55396 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729055AbgBQKJN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 17 Feb 2020 05:09:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 02:09:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,452,1574150400"; 
   d="scan'208";a="258225641"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 17 Feb 2020 02:09:12 -0800
Received: from [10.226.38.21] (unknown [10.226.38.21])
        by linux.intel.com (Postfix) with ESMTP id A339A580270;
        Mon, 17 Feb 2020 02:09:09 -0800 (PST)
Subject: Re: [PATCH v9 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     Mark Brown <broonie@kernel.org>,
        Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org, Vignesh R <vigneshr@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dan.carpenter@oracle.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAAh8qsxnRSwonuEPrriuS=gUMTjt8ddUVy5HxegmoCk-FoE4qg@mail.gmail.com>
 <20200214121145.GF4827@sirena.org.uk>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <7d264baf-1ea8-8ada-d93f-df55600a59e9@linux.intel.com>
Date:   Mon, 17 Feb 2020 18:09:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200214121145.GF4827@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On 14/2/2020 8:11 PM, Mark Brown wrote:
> On Fri, Feb 14, 2020 at 01:02:22PM +0100, Simon Goldschmidt wrote:
>> On Fri, Feb 14, 2020 at 12:46 PM Ramuthevar,Vadivel MuruganX
>> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>>> Add support for the Cadence QSPI controller. This controller is
>>> present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
>>> This driver has been tested on the Intel LGM SoCs.
>> This is v9 and still, none of the altera maintainers are on CC?
>> How will it be ensured that this doesn't break altera if it is merged?
> Given that this is a new driver I'd be very surprised if it broke other
> users?  I can imagine it might not work for them and it would definitely
> be much better to get their review but it shouldn't be any worse than
> the current lack of support.
Thanks for the clarification, Please kindly see the below discussion b/w
Vignesh and Dinh in the earlier mail chain.

[Vignesh]  The legacy driver under drivers/mtd/spi-nor will be removed 
as we cannot
support both SPI NOR and SPI NAND with single driver if its under
spi-nor. New driver should be functionally equivalent to existing one.
So I suggest you test this driver on legcay SoCFPGA products.

[Dinh]   I don't have the original patch series, but will monitor going 
forward.
As long as the new driver does not break legacy SoCFPGA products that
use the cadence-quadspi driver then it should be ok.

Regards
vadivel

