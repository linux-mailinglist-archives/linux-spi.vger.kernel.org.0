Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08D835A30D
	for <lists+linux-spi@lfdr.de>; Fri,  9 Apr 2021 18:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhDIQX6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Apr 2021 12:23:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233577AbhDIQXx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 9 Apr 2021 12:23:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F02DE6108B;
        Fri,  9 Apr 2021 16:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617985420;
        bh=Mn/CYV02N9fvkmLNxJq8JF8Vl5edtfQntyZwBg4n1x0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=roIpKc1Najw4Vc4U26pTdW9lUXFB3WBOeLYV1NPwYUwGwcBZ3u9amIV9+mhRCkkQp
         BkP/3hJ+KlkKSKzjw2Vgnls9hl+DXoTqqOLG4NnoKDXy8ofdpCmpfWLw0Ji3jXMXO5
         4s9gh8Ezid1tsa8NOZGRBD9XV2PPcspmo6GED8+TrLsGxdw6VTbTfc58rSDRBEMs1a
         4EK29CrUPvKqFYg3unRv/iFloxmu3avHhf2/es4ZuCV6QFfblSs05w/EOS9sS5B8Qh
         lgKsZ6WgIOocOn6tfS0UQCsSePiK21+VKEUHpHr0QporTnjctDpmNrJkgiKeSE8a52
         05ml8L14yJIhw==
From:   Mark Brown <broonie@kernel.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH] spi: simplify devm_spi_register_controller
Date:   Fri,  9 Apr 2021 17:22:47 +0100
Message-Id: <161798356988.48466.11601967952451641527.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1617843307-53853-1-git-send-email-tiantao6@hisilicon.com>
References: <1617843307-53853-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 8 Apr 2021 08:55:07 +0800, Tian Tao wrote:
> Use devm_add_action_or_reset() instead of devres_alloc() and
> devres_add(), which works the same. This will simplify the
> code. There is no functional changes.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: simplify devm_spi_register_controller
      commit: 59ebbe40fb51e307032ae7f63b2749fad2d4635a

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
