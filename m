Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA553C8818
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jul 2021 17:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239782AbhGNP7C (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Jul 2021 11:59:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239778AbhGNP66 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 14 Jul 2021 11:58:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 915DB613CB;
        Wed, 14 Jul 2021 15:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626278167;
        bh=euWLJF8O1gpFql8jqo5Afw+yAqgIphMrVOqkBThYSkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rTQXGGEpKAJ7B4H1hLq7js0qIbbKYecfd2QRqaLzVjDnJXDmlpZoPkaskkt/ApIdg
         MkjRrQmInTNu5rXdpHY4lWAsbbkP7pAje8ulPrj3p97uUzZRc5BQrPmdNMdHsL7lRp
         /sVelUswkyJWqZyybGzT6qwfj66RdQE8eknvyqdwYnRFG1XFQM3yFw/1faG2biaQfO
         9R18GfbwwYmW8VHu1yAPQ8SOTw4zCKIVEv5HH+8QVLcl6Z2xrxTMFxDeKvVBepHyS2
         QBVJhtjuB9EFDwTk02bJuzNB7ye585upGZCNLN79PF8jKTjOoPeZM8sj6PzLUEnKuh
         VF3IcR0a0s7Bg==
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        swboyd@chromium.org, vkoul@kernel.org, akashast@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-geni-qcom: Remove confusing comment about setting the watermark
Date:   Wed, 14 Jul 2021 16:55:16 +0100
Message-Id: <162627784667.55213.15626451683083900981.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210712085010.1.Ie3bb9f9d30d6475bb75251d32635194c1c72b9ee@changeid>
References: <20210712085010.1.Ie3bb9f9d30d6475bb75251d32635194c1c72b9ee@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 12 Jul 2021 08:50:17 -0700, Douglas Anderson wrote:
> The comment in setup_fifo_xfer() about setting the watermark wasn't
> quite proper grammar and also stopped making sense around commit
> 6d66507d9b55 ("spi: spi-geni-qcom: Don't wait to start 1st transfer if
> transmitting"). After that commit we actually start the transfer
> _before_ the watermark interrupt comes.
> 
> I don't think the comment really has any value anymore. We've already
> got a comment when we grab the spinlock saying that our interrupt can
> come any time as a result of the things in the locked section. Let's
> just remove it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-geni-qcom: Remove confusing comment about setting the watermark
      commit: 57f1c12e455fc6c4c0db2c9f14e57b95822c2321

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
