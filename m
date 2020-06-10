Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A431F52CB
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jun 2020 13:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgFJLEP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Jun 2020 07:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728267AbgFJLEN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Jun 2020 07:04:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64BAE206F7;
        Wed, 10 Jun 2020 11:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591787052;
        bh=EwtPHLWn+DTApDYb5Wc2b44Mud8TrcUb4fGhHcUssCc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Stx5Mtk7wXj/6v9y+VYR0hIeysL7z0Xm0ksuymP6/KNReeyO/IyDflz4JyCXnCNmA
         MNvXMTbqyLORwrk10rPcOxic1lbg5IagY/hnybzjtAJ8RQE+TlLBiwrxEkazpuGsM+
         +rgpGghPHNRyMyn6ID9NaGOwUFBBYz+9qwT1JzfQ=
Date:   Wed, 10 Jun 2020 12:04:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Alexander Stein <alexander.stein@mailbox.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org
In-Reply-To: <20200609165527.55183-1-alexander.stein@mailbox.org>
References: <20200609165527.55183-1-alexander.stein@mailbox.org>
Subject: Re: [PATCH 1/1] spi: dt-bindings: amlogic, meson-gx-spicc: Fix schema for meson-g12a
Message-Id: <159178705075.52654.15102712059659144852.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 9 Jun 2020 18:55:27 +0200, Alexander Stein wrote:
> 


Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: amlogic, meson-gx-spicc: Fix schema for meson-g12a
      commit: a575357b6435c6dd988b8194c59eec83f6e5d5af

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
