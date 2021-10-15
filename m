Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF11842FC75
	for <lists+linux-spi@lfdr.de>; Fri, 15 Oct 2021 21:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242818AbhJOTuH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Oct 2021 15:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242816AbhJOTuF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 Oct 2021 15:50:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B37761151;
        Fri, 15 Oct 2021 19:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634327278;
        bh=IEZP2NYbaHN62lOVAqacdiG1LlcAY+GOEHAfjiqAfnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TMx6zC/66L+PFSwXOg6tQJ+bvXXPgPy4x/txpB2GHcl5FfQ6dRHb4C/YPRUeHicqz
         VeEmhQwCOpSx32ivy2AAhOAAoAvV9/rqRA7Li0zX6AlsXWOZR6UXjUoAFcH4pU+nBm
         FS9YqNn0QD6lfeU0KzWVYJwVx57ETdV+a9wyiX/58cEeb6pthFdjYnYVi3xH1GCfbK
         iv+psCk7sHQ6yNodALTZZXznldOZaQA9kxCeYIUUWIopWSWnbkijeAaRA24Ojx2DlM
         pe8qY3wfliZDVBkCEvdD6FnPlfOmtEIN/4ezbW515pdxWsqnlQxXO9qg9Rgjvjh/76
         bYmDwT95rQdXQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Wan Jiabing <wanjiabing@vivo.com>
Cc:     Mark Brown <broonie@kernel.org>, kael_w@yeah.net
Subject: Re: [PATCH] spi: cadence: Add of_node_put() before return
Date:   Fri, 15 Oct 2021 20:47:50 +0100
Message-Id: <163432719233.1317044.9590305237305769638.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211015033919.5915-1-wanjiabing@vivo.com>
References: <20211015033919.5915-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 14 Oct 2021 23:39:17 -0400, Wan Jiabing wrote:
> Fix following coccicheck warning:
> ./drivers/spi/spi-cadence-xspi.c:490:1-23: WARNING: Function
> for_each_child_of_node should have of_node_put() before return
> 
> Early exits from for_each_child_of_node should decrement the
> node reference counter.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence: Add of_node_put() before return
      commit: 2a4a4e8918f002c9da41d4ffb643ea78b1aa4a4f

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
