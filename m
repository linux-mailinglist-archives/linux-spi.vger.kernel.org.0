Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82A041183A
	for <lists+linux-spi@lfdr.de>; Mon, 20 Sep 2021 17:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241427AbhITPdC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Sep 2021 11:33:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237109AbhITPdB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 20 Sep 2021 11:33:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B0BC6109E;
        Mon, 20 Sep 2021 15:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632151894;
        bh=5rsU/1uq06UhshbzmlWgjO+6rbyl1Z8IQumnH4RN3S4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lN4Qwv4Wod47LRNTHB56z+vd/FS1aJYkEIm7d42v1wmzMhT4V//Q1VlgUVytBrJbI
         ewMzChYLWogQOnzyhpauLC7INyvb0obQcKWqNv1sIWyZZwZh/TH1aPpkjXIXhXoaqm
         O29VBRijp9DPDMzDI9/3Ghwg9Q350eDpaH7/3czhiGSMMwO+awjpIj2bmk2wrg6aqo
         6NRUqfo75DTG9GJGFdS6LI1TgfNse15AQQZW8CwGxn2C6Lwj564MF4gXUDcARtJX0j
         fDj7LwOGA4D2pY6ESG1CBbuhIxjP1bgO7JT5vNIeBRmkLbzMEuzhwUkDHkJ7KCJPIM
         Iyy7Q8zpit5pw==
From:   Mark Brown <broonie@kernel.org>
To:     Yoshitaka Ikeda <ikeda@nskint.co.jp>
Cc:     Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>,
        linux-spi@vger.kernel.org,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>,
        Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH] spi: Fixed division by zero warning
Date:   Mon, 20 Sep 2021 16:30:42 +0100
Message-Id: <163215175007.38597.10761138776591837888.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <OSZPR01MB70049C8F56ED8902852DF97B8BD49@OSZPR01MB7004.jpnprd01.prod.outlook.com>
References: <OSZPR01MB70049C8F56ED8902852DF97B8BD49@OSZPR01MB7004.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 8 Sep 2021 05:29:12 +0000, Yoshitaka Ikeda wrote:
> The reason for dividing by zero is because the dummy bus width is zero,
> but if the dummy n bytes is zero, it indicates that there is no data transfer,
> so there is no need for calculation.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Fixed division by zero warning
      commit: 09134c5322df9f105d9ed324051872d5d0e162aa

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
