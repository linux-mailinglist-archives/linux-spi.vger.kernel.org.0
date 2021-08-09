Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236253E4848
	for <lists+linux-spi@lfdr.de>; Mon,  9 Aug 2021 17:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbhHIPDe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Aug 2021 11:03:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235097AbhHIPDd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Aug 2021 11:03:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD66160EBB;
        Mon,  9 Aug 2021 15:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628521393;
        bh=OYFPvBpAz+gBYk1xqnpaZKlokxOeCKmDhJ5hGhXtecU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X1p5Bsf26lKmLIq26lrO/iZ9qZPIQzVB3m4Q/3F/kUUiKOQtV9YLB3uAU5unX8Lhk
         KXDjd98y4rh4kp/9Q/rqyOztNIlIbCDKzisj6pnf0IW1SdgBh3sRjLMnsL3WQvqn0A
         rv9Jq0j2IaChOT7f/FFrrc/oiSmUf41pC0H0EBqOzgCzMR8wCrKjimiUdhLEDycFdS
         FNvVp/tdwZB0/i99UYV/XJGRsmxKNR2cc9ZtSCW2OKLtZkAPq0yxhvpw92wf9Hempe
         bC+49TrLZwpSepdq+W0tMTxfijByb+nYbNuSw9e674K4JfmYI6SvHcpk+CozIhddPv
         SqCGePLjy1VbQ==
From:   Mark Brown <broonie@kernel.org>
To:     Mason Zhang <Mason.Zhang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/1] spi: mediatek: fix build warnning in set cs timing
Date:   Mon,  9 Aug 2021 16:02:54 +0100
Message-Id: <162852121764.46095.11307268331804449714.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210809055911.17538-1-Mason.Zhang@mediatek.com>
References: <20210809055911.17538-1-Mason.Zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 9 Aug 2021 13:59:12 +0800, Mason Zhang wrote:
> this patch fixed the build warnning in set cs timing.
> 
> 
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mediatek: fix build warnning in set cs timing
      commit: 5c842e51ac63130a1344650b0a95bdc398666947

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
