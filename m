Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE2F1E61C3
	for <lists+linux-spi@lfdr.de>; Thu, 28 May 2020 15:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390189AbgE1NIP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 09:08:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390185AbgE1NIN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 28 May 2020 09:08:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2BD2206C3;
        Thu, 28 May 2020 13:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590671293;
        bh=SXJ2IGWSNitYLEi4N8F0sncc8lQY4aHX9WQaypm8Zs0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=x0Hf22FflnWRlvVewE0Waf4JRIUFnNitaN9jTurrk8ytPE0EUO9nVkX51F5WV35zj
         uFIfuc59kpcs+/tUwYO482RzCS9menlpv+UMQN5y5rkas4ohpN0YZC6xjLoJFjvveN
         +Up43CtddQuVCpwyRNhNmVHneTfQtd0EFQ5M+TwU=
Date:   Thu, 28 May 2020 14:08:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     kjlu@umn.edu, Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>, linux-spi@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200523125704.30300-1-dinghao.liu@zju.edu.cn>
References: <20200523125704.30300-1-dinghao.liu@zju.edu.cn>
Subject: Re: [PATCH] [v2] spi: tegra114: Fix runtime PM imbalance on error
Message-Id: <159067126729.55053.17825665315937942754.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 23 May 2020 20:57:04 +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra114: Fix runtime PM imbalance on error
      commit: cddc36f3fd706b1046a4d4608359c0003f72db32

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
