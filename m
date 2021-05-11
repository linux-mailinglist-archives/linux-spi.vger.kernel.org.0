Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A8937A1C4
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 10:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhEKI2I (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 04:28:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230510AbhEKI2D (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 04:28:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9110A61107;
        Tue, 11 May 2021 08:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721617;
        bh=/gcsyHIVR3ayyligcDmVscVEOngbuB8UZJ4DeDdkjFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CuNDj5D/ix8IfpJN//W6mMfmvFISoHBO7VtKMhLTpN2JxGW5UBPfJARb6OLnO66yk
         1SUEvrjCq/z+ze/S9cLCxh0wEVA0tRIg+evekNS1fSqLXj+oe9EFbrdvwbyFgIg92V
         eINd6hP1Rq1RLHsCOM2kGFqi/avQYz7xaQh8cu7tgbDh43EDE19HhzpYQUI9AoLRA6
         usb1bzj4OYMkHhP9Mne3z4k9/ZEvQRuF3jnxjKgwv/SS7DHA6Vi6tQRzlgMpNvNjjh
         R5x5HdjzjdavAXYWxc9CFSB4PpJTjC7Vr8ChbHC+eiukFSA/avKL0zZjObvr6dGEpB
         cOSYtC6WAnb9A==
From:   Mark Brown <broonie@kernel.org>
To:     grant.likely@secretlab.ca, thierry.reding@gmail.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        swarren@nvidia.com, jonathanh@nvidia.com, ldewangan@nvidia.com
Cc:     Mark Brown <broonie@kernel.org>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] spi: tegra114: Fix an error message
Date:   Tue, 11 May 2021 09:25:34 +0100
Message-Id: <162072071981.33404.15179846944690790249.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <e2593974c9484b7055177ad0c9237c8e343946be.1620399829.git.christophe.jaillet@wanadoo.fr>
References: <e2593974c9484b7055177ad0c9237c8e343946be.1620399829.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 7 May 2021 17:07:59 +0200, Christophe JAILLET wrote:
> 'ret' is known to be 0 here.
> No error code is available, so just remove it from the error message.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra114: Fix an error message
      commit: 86b1d8ecb5f1f271a660ce0b882658447f85904a

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
