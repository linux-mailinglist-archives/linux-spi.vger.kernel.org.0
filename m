Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AD6397936
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jun 2021 19:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbhFARkJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Jun 2021 13:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231726AbhFARkG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 1 Jun 2021 13:40:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0F0E61378;
        Tue,  1 Jun 2021 17:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622569105;
        bh=YfGlGDmFN4kFvKY0B+6l98kWq3rspZuPBVaBdEln5Wc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ulmIUGqn99as3fVUiQNF3iSdKEn3vqu1H+/uKPb7fUduLBYuygc/dKAbYb4b+xYle
         TbZay7XgiVMFZEjtqw5GHrohnW0edBVx8luI02/lmSgmAOkak0Et/Wo3EHC0iln41u
         BgE6YpVebvOyEDd+TMMTkGrbgFHVz8QEYroetS9QVc/0hMHe2CgTfXPQEbjcxosJ9d
         J8t4Fcz/UGbPvDTX5tdsZDInMfvcs08/AdvB2dVkScUvpPt6vq2M5LBNL1qc/Y+9X7
         pVosOvGQSO8wDBNWSHNpKYfjOSb6GGDAyMG/FW4LiI0M07TD8SW2tsog7nBX+pWNKJ
         9dQLKcnYAtbfA==
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>,
        Saravana Kannan <saravanak@google.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel-team@android.com,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH for-5.13] spi: Cleanup on failure of initial setup
Date:   Tue,  1 Jun 2021 18:37:57 +0100
Message-Id: <162256906236.20104.6932209900805467815.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <f76a0599469f265b69c371538794101fa37b5536.1622149321.git.lukas@wunner.de>
References: <f76a0599469f265b69c371538794101fa37b5536.1622149321.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 27 May 2021 23:10:56 +0200, Lukas Wunner wrote:
> Commit c7299fea6769 ("spi: Fix spi device unregister flow") changed the
> SPI core's behavior if the ->setup() hook returns an error upon adding
> an spi_device:  Before, the ->cleanup() hook was invoked to free any
> allocations that were made by ->setup().  With the commit, that's no
> longer the case, so the ->setup() hook is expected to free the
> allocations itself.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Cleanup on failure of initial setup
      commit: 2ec6f20b33eb4f62ab90bdcd620436c883ec3af6

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
