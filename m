Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D03365F80
	for <lists+linux-spi@lfdr.de>; Tue, 20 Apr 2021 20:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbhDTSgm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Apr 2021 14:36:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233624AbhDTSgi (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Apr 2021 14:36:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23B3A61026;
        Tue, 20 Apr 2021 18:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618943766;
        bh=gXxDuv0z7RhME/c0IYsfVuN2HzlDJPJp644/BBV/X60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QxvQGAWN5P/lyUYtznPTGQieTVGFMBZt82bAla132PCOtOW2TFKIVqi2Ow9d+DhwZ
         bd02JYXKjJscdAC+63uXufqgBKx/ol++iTtToAtXpXWhwFHfSG58Q+rkTqlKIbsgSu
         vROGkd/MSTDjD67gHRQSYhpruP1F5VQpM7Rg9xJV5bAyxSbT8vx35KcsdkoVGvoUSN
         kZ7E+InnlMuyH/nN42SQfVi5XngjYu6LBIEQVXCW0nFTw2WkXdOvh5MIsCQg7+VrH6
         IVhe0OMbQ+Cruz9aYK14yscuztjw3ytIBEQggWCwbrLM/iRAOdjj2QH2/Lze2cNefo
         XtgE7COsYCkuQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, shiva.linuxworks@gmail.com
Cc:     Mark Brown <broonie@kernel.org>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spidev: Add Micron SPI NOR Authenta device compatible
Date:   Tue, 20 Apr 2021 19:35:31 +0100
Message-Id: <161894372992.35357.17967885265176552893.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210419204015.1769-1-sshivamurthy@micron.com>
References: <20210419204015.1769-1-sshivamurthy@micron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 19 Apr 2021 20:40:15 +0000, shiva.linuxworks@gmail.com wrote:
> Add compatible string for Micron SPI NOR Authenta device.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spidev: Add Micron SPI NOR Authenta device compatible
      commit: 3a1634daf8cbf7d1e76b120fea9665325557be8c

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
