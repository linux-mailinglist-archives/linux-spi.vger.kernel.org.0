Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00E73CCACC
	for <lists+linux-spi@lfdr.de>; Sun, 18 Jul 2021 23:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhGRVXh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 18 Jul 2021 17:23:37 -0400
Received: from phobos.denx.de ([85.214.62.61]:38366 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhGRVXg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 18 Jul 2021 17:23:36 -0400
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 131978033E;
        Sun, 18 Jul 2021 23:20:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1626643237;
        bh=dBTByRjuC+nnsQNafbrKvzYWF+IWP9D6sQC3w99S3o8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jhYjqQeDik8SuerPziUJ/5sbZGkKzywRWMwSanuzdeiCLK57r1+5UcgVTrpabwgxs
         MOyhPk0nLnQiOKVcUbGbH75qaqe2O5AxGaiQ4cSkxM7KYv/LBHaqYwzXEc8fgO/gFh
         mrAnDMW7Ls83LNo4PJN0gIXeOGPCplM3rJln3xhxxpR/S6zslPUK6GL004t6cZLb0i
         8l0M6VfFG45e7ACgmtyt4HxzyGC4e4/xO/wJYr79Kd90LCHBIuQV3HTLtkcp02MgHP
         SXG+Bw8XjrMsuqwTl35rDiChhLpBz/wJ1C42AOzi2+14Rg6xC+t28sWR3una0v8SbO
         PhwD/pCP4+87A==
Subject: Re: [PATCH] spi: imx: mx51-ecspi: Reinstate low-speed CONFIGREG delay
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20210703022300.296114-1-marex@denx.de>
 <162567934678.18850.1622229665696547684.b4-ty@kernel.org>
From:   Marek Vasut <marex@denx.de>
Message-ID: <ac7f2fd1-e61d-07ce-162a-9b5cdc91d145@denx.de>
Date:   Sun, 18 Jul 2021 23:20:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <162567934678.18850.1622229665696547684.b4-ty@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 7/7/21 7:52 PM, Mark Brown wrote:
> On Sat, 3 Jul 2021 04:23:00 +0200, Marek Vasut wrote:
>> Since 00b80ac935539 ("spi: imx: mx51-ecspi: Move some initialisation to
>> prepare_message hook."), the MX51_ECSPI_CONFIG write no longer happens
>> in prepare_transfer hook, but rather in prepare_message hook, however
>> the MX51_ECSPI_CONFIG delay is still left in prepare_transfer hook and
>> thus has no effect. This leads to low bus frequency operation problems
>> described in 6fd8b8503a0dc ("spi: spi-imx: Fix out-of-order CS/SCLK
>> operation at low speeds") again.
>>
>> [...]
> 
> Applied to
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thanks!
> 
> [1/1] spi: imx: mx51-ecspi: Reinstate low-speed CONFIGREG delay
>        commit: 135cbd378eab336da15de9c84bbb22bf743b38a5
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

I messed that one up, here is the incremental fix:

https://patchwork.kernel.org/project/spi-devel-general/patch/20210718211143.143557-1-marex@denx.de/
