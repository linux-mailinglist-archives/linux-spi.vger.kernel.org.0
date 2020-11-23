Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7932C17EF
	for <lists+linux-spi@lfdr.de>; Mon, 23 Nov 2020 22:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbgKWVrJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Nov 2020 16:47:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730108AbgKWVrJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 23 Nov 2020 16:47:09 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6C6720663;
        Mon, 23 Nov 2020 21:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606168028;
        bh=THoe0Z/M/WwOV4LTDT6k94vvzIrnSxLcq+WgI8crrVo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=iWKjwPo2hxGHxP6Tn5C4FmkeB8f91GU46lQpn1JLcvKayLrIIz/OA93A+qyGIhpkP
         3Zuihqz3Taz4UBV3Ro0NT9yHzsurkRIAMz+7V1tZUJqijoiLe5+ImQ381O01wqa3Oj
         3NwHOtEUkuFbuRf9X0CrDF24ugNGNM/TaRoAvq/8=
Date:   Mon, 23 Nov 2020 21:46:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Qing Zhang <zhangqing@loongson.cn>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1605930231-19448-1-git-send-email-zhangqing@loongson.cn>
References: <1605930231-19448-1-git-send-email-zhangqing@loongson.cn>
Subject: Re: [PATCH] spi: amd: Use devm_platform_ioremap_resource() in amd_spi_probe
Message-Id: <160616800460.26654.5502584955606530702.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 21 Nov 2020 11:43:51 +0800, Qing Zhang wrote:
> Simplify this function implementation by using a known wrapper function.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: amd: Use devm_platform_ioremap_resource() in amd_spi_probe
      commit: 2ed6e3bac15242c18bef5af12547a13b25b65ac8

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
