Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA892F596D
	for <lists+linux-spi@lfdr.de>; Thu, 14 Jan 2021 04:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbhANDhV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Jan 2021 22:37:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:55688 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbhANDhV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 Jan 2021 22:37:21 -0500
IronPort-SDR: 1LVI0qotUX/5cm2/asHnIuaKHYwFhs9UoJEvsXaML+VOWqjxJD7WFca85HgoL/gszx+sJ6EEqG
 +HWVXEirgL1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="242377422"
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; 
   d="scan'208";a="242377422"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 19:35:35 -0800
IronPort-SDR: ygzTiOHXJJWannPZltaZAD28jha+8ihALXpvtTjpIPOTgv3dQCeRSxdqh0hOZHE3o5I725urN6
 D/Gk0dnee8QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; 
   d="scan'208";a="499471394"
Received: from imail001.iil.intel.com ([10.184.82.104])
  by orsmga004.jf.intel.com with ESMTP; 13 Jan 2021 19:35:32 -0800
Received: from [10.215.249.35] (cheolyon-MOBL.gar.corp.intel.com [10.215.249.35])
        by imail001.iil.intel.com with ESMTP id 10E3ZYsJ004016;
        Thu, 14 Jan 2021 05:35:35 +0200
From:   "Kim, Cheol Yong" <cheol.yong.kim@linux.intel.com>
Subject: Re: [PATCH v9 0/5] spi: cadence-quadspi: Add QSPI controller support
 for Intel LGM SoC
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, rtanwar@maxlinear.com
Cc:     vigneshr@ti.com, qi-ming.wu@intel.com, cheol.yong.kim@intel.com,
        p.yadav@ti.com, linux-mtd@lists.infradead.org,
        "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>, ckim@maxlinear.com
References: <20201124041840.31066-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <161055171029.21847.3382759454400721764.b4-ty@kernel.org>
Message-ID: <6916fcc9-3132-2786-5c36-de3b64721694@linux.intel.com>
Date:   Thu, 14 Jan 2021 11:35:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <161055171029.21847.3382759454400721764.b4-ty@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 1/13/2021 11:28 PM, Mark Brown wrote:
> On Tue, 24 Nov 2020 12:18:35 +0800, Ramuthevar, Vadivel MuruganX wrote:
>> Add QSPI controller support for Intel LGM SoC.
>>
>> Patches to move move bindings over to
>> "Documentation/devicetree/bindings/spi/" directory and also added compatible
>> Support for Intel platform.
>>
>> dt-bindings: spi: cadence-qspi: Add support for Intel lgm-qspi
>> (earlier patch mail thread and Ack-by)
>> link: "https://lore.kernel.org/lkml/5d6d1b85.1c69fb81.96938.0315@mx.google.com/"
>>
>> [...]
> Applied to
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
>
> Thanks!
>
> [1/5] spi: cadence-quadspi: Add QSPI support for Intel LGM SoC
>        commit: ab2d28750aacb773dc42d72fbad59146e8a6db5e
> [2/5] spi: cadence-quadspi: Disable the DAC for Intel LGM SoC
>        commit: ad2775dc3fc5d30dd51984ccbaa736cc7ea9caca
> [3/5] spi: cadence-quadspi: Add multi-chipselect support for Intel LGM SoC
>        commit: b436fb7d29bfa48ff5e00cbf413609c7a6d4d81e
> [4/5] spi: Move cadence-quadspi.txt to Documentation/devicetree/bindings/spi
>        commit: eb4aadc31ef4224b926d5165048cb297f4bda34f
> [5/5] dt-bindings: spi: cadence-qspi: Add support for Intel lgm-qspi
>        commit: fcebca39938fa9f6ed03f27fc75645ad7fd489e9
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.

Thanks Mark!

Vadivel left company. Added Rahul <rtanwar@maxlinear.com> as a maintainer


>
> Thanks,
> Mark
