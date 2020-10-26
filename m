Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961BC299B12
	for <lists+linux-spi@lfdr.de>; Tue, 27 Oct 2020 00:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408548AbgJZXr5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Oct 2020 19:47:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408545AbgJZXr4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 26 Oct 2020 19:47:56 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC51220773;
        Mon, 26 Oct 2020 23:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603756076;
        bh=Nzsx1oBne0HLZzJSm/LpAlW++g20Agd/uH9VqCnZRIk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=p7V4O//b8CvX5FnCRsNRXdk1QXGZCnlOf+1m1B2UXRlvJ+UWvmpsuaUPOBa700z11
         iYhx5WXtBS/atz44tXBtbeErfnvQEaoGChUCcszRv8g8N2S2AHxcN0EwNP8b14MMOM
         wDhV+TI0zM0m25CsFot/fkcpoMUmuQb1TZdcEdIY=
Date:   Mon, 26 Oct 2020 23:47:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Alexander Kochetkov <al.kochet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20201019150343.2520-1-akochetkov@lintech.ru>
References: <20201019150343.2520-1-akochetkov@lintech.ru>
Subject: Re: [PATCH v2] spi: spi-sun6i: enable autosuspend feature
Message-Id: <160375605709.32342.14419610889033006203.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 19 Oct 2020 18:03:43 +0300, Alexander Kochetkov wrote:
> If SPI is used for periodic polling any sensor, significant delays
> sometimes appear. Switching on module clocks during resume lead to delays.
> Enabling autosuspend mode causes the controller to not suspend between
> SPI transfers and the delays disappear.
> 
> The commit also remove unnecessary call to pm_runtime_idle() used
> to explicit put device to suspended state. Without pm_runtime_idle() PM
> core will put device in the suspended state just after probe() returns.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-sun6i: enable autosuspend feature
      commit: ae0f18bef30d0e76dd62be46c59b24c75f175092

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
