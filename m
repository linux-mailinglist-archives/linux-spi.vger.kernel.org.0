Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD523575F8
	for <lists+linux-spi@lfdr.de>; Wed,  7 Apr 2021 22:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356187AbhDGU1V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Apr 2021 16:27:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356143AbhDGU0x (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 7 Apr 2021 16:26:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B094361184;
        Wed,  7 Apr 2021 20:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617827203;
        bh=BQl6kvC+0krlBqoptPSe7kRirbxGSA0fqvqnQDi+OnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fNo8+Roz+B4NTmBQZIaTjn4YNHaas/xal+nSx0iG6vmb3mX2SKKwj5IdDqTKyQjc5
         su8u9LglcGhVWWJdjKW0ac7LdgCOGW16Ae07XCyNnWWACHAZFMIXeBYLPoezTfNTR1
         dpWFdokZ5uBLeHE6IRSm2mlVKnly3j7QurthcFuQME5X0SMfmMunyDimY2lWViOI01
         Gr/4EFEUjDTaul+x4to5mnH/9D2CmegmVmn4tzciOfjkVpbL7ZCmst2kn0OxBav3Lr
         8qzizv1YA35jxRDo4btnvYqFkJtuH+NLKPI4yYNBBcmY42B8y9wX1/6PHl8m+FYNAK
         XyYQI5bh3ar6g==
From:   Mark Brown <broonie@kernel.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: orion: Use device_get_match_data() helper
Date:   Wed,  7 Apr 2021 21:26:18 +0100
Message-Id: <161782716302.42932.9036142611686148966.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1617258288-1490-1-git-send-email-tiantao6@hisilicon.com>
References: <1617258288-1490-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 1 Apr 2021 14:24:48 +0800, Tian Tao wrote:
> Use the device_get_match_data() helper instead of open coding.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: orion: Use device_get_match_data() helper
      commit: 0e6521f13c297de32906ad7f691905803b2b2880

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
