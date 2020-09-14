Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC275268E69
	for <lists+linux-spi@lfdr.de>; Mon, 14 Sep 2020 16:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgINOx4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Sep 2020 10:53:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbgINOxD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Sep 2020 10:53:03 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4664920829;
        Mon, 14 Sep 2020 14:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600095171;
        bh=67NCxVU5r6fw67dZxFQH4Sc12hr1k8DV1oWxp2VyYZk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=obirEuEZKJwGnnNPE8eL0IZuyuJcyZ/8248PJTT3C1tfiW747V3/SdkQ3QnbQ4/V8
         S4C47zNq21V66+q54tnLgTlvSoQoo1AlV7t4dq236MzxcmhbpVF9Xk4rz5NHqrzOP2
         8442j9ft3p8cVhRGIO615EnO6DHsgtWASFGZvZwM=
Date:   Mon, 14 Sep 2020 15:52:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        linux-spi@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Akash Asthana <akashast@codeaurora.org>
In-Reply-To: <20200912140730.1.Ie67fa32009b94702d56232c064f1d89065ee8836@changeid>
References: <20200912140730.1.Ie67fa32009b94702d56232c064f1d89065ee8836@changeid>
Subject: Re: [PATCH 1/3] spi: spi-geni-qcom: Use the FIFO even more
Message-Id: <160009511833.5702.5578249542149144949.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 12 Sep 2020 14:07:59 -0700, Douglas Anderson wrote:
> In commit 902481a78ee4 ("spi: spi-geni-qcom: Actually use our FIFO") I
> explained that the maximum size we could program the FIFO was
> "mas->tx_fifo_depth - 3" but that I chose "mas->tx_fifo_depth()"
> because I was worried about decreased bandwidth.
> 
> Since that time:
> * All the interconnect patches have landed, making things run at the
>   proper speed.
> * I've done more measurements.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spi-geni-qcom: Use the FIFO even more
      commit: fc129a43aa2705770dc45b2e9c506d2617fd5863
[2/2] spi: spi-geni-qcom: Don't program CS_TOGGLE again and again
      commit: 14ac4e049dc1183440960f177b60b54357e54d90

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
