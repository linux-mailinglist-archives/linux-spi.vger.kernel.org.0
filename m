Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA95F2AC569
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 20:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbgKITtE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 14:49:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729247AbgKITtD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Nov 2020 14:49:03 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB2BC206D8;
        Mon,  9 Nov 2020 19:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604951343;
        bh=3Ok4/Pbb99zI/ObDxFnKakiL6dk8E4Cn5TISbUMUryM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=MoGeK0ciCUCEeHvA+U/Ls1OKBDdZVso3UvHacXGXb1Su333bztdpPXpcp0QNCW8ib
         6Br8MjjdDPd1vXvznjLpipWaMEMcT3BmRg8yKMlNzqTo7EKl+Ch6JsdjXFbIr+u0vr
         owHtY7HuykR1ULIEeklnX8AXRyLXZI2pTsbr0u0o=
Date:   Mon, 09 Nov 2020 19:48:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Qinglang Miao <miaoqinglang@huawei.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org
In-Reply-To: <20201103074912.195576-1-miaoqinglang@huawei.com>
References: <20201103074912.195576-1-miaoqinglang@huawei.com>
Subject: Re: [PATCH v2] spi: mt7621: fix missing clk_disable_unprepare() on error in mt7621_spi_probe
Message-Id: <160495129749.49337.6551797928136426498.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 3 Nov 2020 15:49:12 +0800, Qinglang Miao wrote:
> Fix the missing clk_disable_unprepare() before return
> from mt7621_spi_probe in the error handling case.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mt7621: fix missing clk_disable_unprepare() on error in mt7621_spi_probe
      commit: 702b15cb97123cedcec56a39d9a21c5288eb9ae1

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
