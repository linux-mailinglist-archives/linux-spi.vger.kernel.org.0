Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA19C20D86B
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jun 2020 22:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732064AbgF2Tix (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Jun 2020 15:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729393AbgF2Tiw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 29 Jun 2020 15:38:52 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1FD220672;
        Mon, 29 Jun 2020 19:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593459532;
        bh=VPcS8epBLlrFbdjA3dDA2nHXRIqkQPcanzzcopIsL6E=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=gzT3tScuqQRogrsiLDYuckgwHfc92IZHNmS6pSZ2y0VeDfWXSDDilHXTNE6+2qvqt
         O05MVsgga2A3nLSlF/l02o+76FB2HLok7OwYZ47AEn7oaekBaeX615cQ/E6E0mO2+1
         lroeA8Ug/bD0BYOJEttAXecAxXRzSDtd4vtC1O8E=
Date:   Mon, 29 Jun 2020 20:38:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Dilip Kota <dkota@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, swboyd@chromium.org
In-Reply-To: <20200626151946.1.I06134fd669bf91fd387dc6ecfe21d44c202bd412@changeid>
References: <20200626151946.1.I06134fd669bf91fd387dc6ecfe21d44c202bd412@changeid>
Subject: Re: [PATCH] spi: spi-geni-qcom: Don't set the cs if it was already right
Message-Id: <159345952500.3556.3923328803896561754.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 26 Jun 2020 15:19:50 -0700, Douglas Anderson wrote:
> Setting the chip select on the Qualcomm geni SPI controller isn't
> exactly cheap.  Let's cache the current setting and avoid setting the
> chip select if it's already right.
> 
> Using "flashrom" to read or write the EC firmware on a Chromebook
> shows roughly a 25% reduction in interrupts and a 15% speedup.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-geni-qcom: Don't set the cs if it was already right
      commit: 638d8488ae00d2e5dd5033804e82b458d3cf85b1

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
