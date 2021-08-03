Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84A63DF7EA
	for <lists+linux-spi@lfdr.de>; Wed,  4 Aug 2021 00:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbhHCWgP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Aug 2021 18:36:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231770AbhHCWgP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 3 Aug 2021 18:36:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63A5360F02;
        Tue,  3 Aug 2021 22:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628030161;
        bh=Smw4ShGSYQR1ubaPrFN09PPGlpmvwH+pcd2WaGVRics=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TYK2FWUrR9CTsWSm61JemTXZrJ8TPqbrjYPB2nAkFFKUco9Q94HHHbGPMa7udbCzO
         GUfwXxuqSCzFhsmWk1dGliCikYEQ7Ca5c7sUqwaMz9dxqdtAtuFHpzHKyEq8oiVWeB
         8qvuCFDuhQf2M8SkHCjsxwiciX5iZ7uvZfCmdLxW0PCLexSjD4qWjt7P/n2IbMcHAV
         8UkTbhrPDm8HfXCDw0XaFFXV4reRnEzasPk6cGaEZOstPAt8JFAVrYpPb3hBc95Q+M
         v1qTY2JhAAsuTROUars/SuFnXy7ISHWvxCR7/03B9yTztcT7DrW6Cf16w/vJ5nN9Uo
         AfRFjOAspQ3eA==
From:   Mark Brown <broonie@kernel.org>
To:     nsaenz@kernel.org, Jason Wang <wangborong@cdjrlc.com>
Cc:     Mark Brown <broonie@kernel.org>, rjui@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, sbranden@broadcom.com,
        linux-arm-kernel@lists.infradead.org, f.fainelli@gmail.com,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: bcm2835aux: use 'unsigned int' instead of 'unsigned'
Date:   Tue,  3 Aug 2021 23:35:31 +0100
Message-Id: <162803013702.42391.3293196498865210081.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210731133342.432575-1-wangborong@cdjrlc.com>
References: <20210731133342.432575-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 31 Jul 2021 21:33:42 +0800, Jason Wang wrote:
> Prefer 'unsigned int' to bare use of 'unsigned'.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm2835aux: use 'unsigned int' instead of 'unsigned'
      commit: b09bff2676be3ae286e6161a1a581a40c53a3c62

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
