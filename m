Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B3E299B0E
	for <lists+linux-spi@lfdr.de>; Tue, 27 Oct 2020 00:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408478AbgJZXrr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Oct 2020 19:47:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408453AbgJZXrq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 26 Oct 2020 19:47:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02DB720720;
        Mon, 26 Oct 2020 23:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603756066;
        bh=w2e6yjuf2xF9EiFramqNdbuttE84vufq0+9dKJ75HMg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=sK4aFfZEucZfqfvhKgcBh1SPatuRQx92FnxMTdFCp7vNcyCDGPWZedf1Qa0gGdZIx
         fGED9/l6oqrnX9UrP0Fn00pBpvcUi8CefTFTER3jppf7WQjwLkEKlm3CrQHUuYJkpK
         hhZFP6BrS5FMc/+CVpkuzh0rEgOXDMduu/pZ9Bms=
Date:   Mon, 26 Oct 2020 23:47:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Alexander Kochetkov <al.kochet@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201016085014.31667-1-al.kochet@gmail.com>
References: <20201016085014.31667-1-al.kochet@gmail.com>
Subject: Re: [PATCH] spi: rockchip: enable autosuspend feature
Message-Id: <160375605708.32342.3052547021812852625.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 16 Oct 2020 11:50:14 +0300, Alexander Kochetkov wrote:
> If SPI is used for periodic polling any sensor, significant delays
> sometimes appear. Switching on module clocks during resume lead to delays.
> Enabling autosuspend mode causes the controller to not suspend between
> SPI transfers and the delays disappear.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rockchip: enable autosuspend feature
      commit: 940f3bbf3dacd6e31e482a10e64c96e69b00dded

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
