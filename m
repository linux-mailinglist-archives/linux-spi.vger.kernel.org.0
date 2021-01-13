Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A222F4EC3
	for <lists+linux-spi@lfdr.de>; Wed, 13 Jan 2021 16:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbhAMPaP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Jan 2021 10:30:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727017AbhAMPaO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 Jan 2021 10:30:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 591AB2343F;
        Wed, 13 Jan 2021 15:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610551774;
        bh=B8HwA1TfxiyQY9ObkeveJFqfUY4ee1yqtB0TB+l0sQU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uH3S0lua4haDBe8xaIWVR/Bh/RVeGFsJnKEtdwOOwf3HDmgbQS2PDmpCuhzA9Cx9J
         XWq5IQOyR2LRADbfU7+y8iTLTWIPd+N+qNVYVlCY0uN0Ew2b9M4kThPIZm4j0P1LFm
         WLNJq1VnrFwPNK+v+IiwBQ+JWKIlWonNwMk62P8TQWCu/NB/Hn6/cNr+ap3stkUsCv
         W6GQpTdnOsEIXC4IiE01AP7FhqwZYtdppsFaec24Djwp3CSjR3XR+gU9MVCcq9Hqp/
         ZfJrs7syZFGx5QW90sm3U1LiHr965ku0o2B18hpFlpZj7sXiFyKBC7PT2Sra2zkp+S
         KPaeF94PsD8jQ==
From:   Mark Brown <broonie@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>, linux-spi@vger.kernel.org
Cc:     john.garry@huawei.com, prime.zeng@huawei.com
In-Reply-To: <1610526716-14882-1-git-send-email-yangyicong@hisilicon.com>
References: <1610526716-14882-1-git-send-email-yangyicong@hisilicon.com>
Subject: Re: [PATCH] spi: hisi-sfc-v3xx: extend version checking compatibility
Message-Id: <161055171029.21847.6604310912525486400.b4-ty@kernel.org>
Date:   Wed, 13 Jan 2021 15:28:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 13 Jan 2021 16:31:56 +0800, Yicong Yang wrote:
> Currently we use concrete version to determine the max_cmd_dword.
> New entries should be added for compatible hardwares of new version
> or on new platform, otherwise the device will use 16 dwords instead
> of 64 even if it supports, which will degrade the performance.
> This will decrease the compatibility and the maintainability.
> 
> Drop the switch-case statement of the version checking. Only version
> less than 0x351 supports maximum 16 command dwords.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: hisi-sfc-v3xx: extend version checking compatibility
      commit: 566c6120f095be74862bed35f557f797478abade

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
