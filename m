Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240A33F8805
	for <lists+linux-spi@lfdr.de>; Thu, 26 Aug 2021 14:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242537AbhHZMwa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Aug 2021 08:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237292AbhHZMw3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 26 Aug 2021 08:52:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAD8060F39;
        Thu, 26 Aug 2021 12:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629982302;
        bh=1+Q+7zZDJekdL7Sry9FDpUZ3p6I+koaJOsMtC+fWF3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KRfsTT9HTbO59SN5m1PULDQIja7TDoBpO9GRqL9w4uo/VaXt5j7VF3pKTII/LkG1F
         eBVgUUEMHwu4+Fgipnnz2yemdFjKYbtxZ4zJWuDFQAkA+als7rQirpi3hSgUmy8Bfa
         Qx9y2U1D+IkYE3hvsrCgtwYs7pVV6/GvAo67TcZPsjEL3YWBY+fp2f+W100pxRX7VD
         NyVJZ2cdhhJ0WpQrLF404tkoU64aHSnurEo38NXvqwxjbSkMbuutvVu9r7fiNf85Cz
         tm3FA2w+zK6/iVgziZVf5fQaeN0lqIREkaygFirT2Owo0r2y8EN97q7QWIZDuP3dda
         Me0OnAd8MJrWA==
From:   Mark Brown <broonie@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-spi@vger.kernel.org,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Luting Guo <luting.guo@unisoc.com>
Subject: Re: [PATCH V2 0/3] Add sprd ADI r3 support
Date:   Thu, 26 Aug 2021 13:51:08 +0100
Message-Id: <162998226397.33692.3511107237485346327.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210825065931.2111159-1-zhang.lyra@gmail.com>
References: <20210825065931.2111159-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 25 Aug 2021 14:59:28 +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> This patchset adds new ADI version (r3) support which used on sc9863 and
> some other Unisoc's SoCs.
> 
> since v1:
> * Address comments from Rob.
> - Rewrote schema for 'sprd,hw-channels' and hwlocks.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: sprd: Add ADI r3 support
      commit: 3b66ca9783d1d1b7be7bf41e8934ca2eaf50a9c0
[2/3] dt-bindings: spi: Convert sprd ADI bindings to yaml
      (no commit info)
[3/3] dt-bindings: spi: add sprd ADI for sc9863 and ums512
      (no commit info)

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
