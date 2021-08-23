Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350B43F4FA6
	for <lists+linux-spi@lfdr.de>; Mon, 23 Aug 2021 19:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhHWRjG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Aug 2021 13:39:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230154AbhHWRjF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 23 Aug 2021 13:39:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2662B6136F;
        Mon, 23 Aug 2021 17:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629740302;
        bh=00YwudNE7MR/TP/XvuAZxtNITWiXbC+Ci4XZyCUewy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X8icCSmOFJ5Pw98KDv4nkG7yd5EuXm0NfskwmHuTJWGvSuh1k+oEnRXKO53hdiduf
         yHLo+WCWt2rJmDidJL6T42lKNArYegyF6Jjsv8sHA+A8QHABxxtvNMUD8fbwOs9STN
         eGQVYNGrWuTwB0LT8U9Q7Nf3QSVr0kiHyCRztFRMBiY4559LVVMNqgbAJDojwqyygr
         vUJuR9T0vONXL8zIdnR4E8vqJu/+7L5ebQnK4ZdA7EzMnQIPUeAuUMnP35SliqnLma
         rO0BMZEl4SQdyqot6XJXmHGrnhm3bNR+xgFjbMssZV1+bUEwWomgnNNfpYaH19lVbm
         yhFXTSIruTyYg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Jon Lin <jon.lin@rock-chips.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Colin King <colin.king@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] spi: rockchip-sfc: Fix assigned but never used return error codes
Date:   Mon, 23 Aug 2021 18:37:50 +0100
Message-Id: <162974017516.3286.9365314960815127788.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210818141051.36320-1-colin.king@canonical.com>
References: <20210818141051.36320-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 18 Aug 2021 15:10:51 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently there are two places where the error return variable ret is
> being assigned -ETIMEDOUT on timeout errors and this value is not
> being returned. Fix this by returning -ETIMEDOUT rather than redundantly
> assiging it to ret.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rockchip-sfc: Fix assigned but never used return error codes
      commit: 745649c59a0d1fde9dcc02286f23f8c78a1f724d

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
