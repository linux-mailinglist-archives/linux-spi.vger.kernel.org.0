Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD513C5AEC
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jul 2021 13:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbhGLKtn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Jul 2021 06:49:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234085AbhGLKtl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 12 Jul 2021 06:49:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0FAD610A7;
        Mon, 12 Jul 2021 10:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626086813;
        bh=Ao3c5ZQCxM2QID6m4VZxbaPV+tdCnDhxUfo395ZRO4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QS+DcUhYhU5EcnC3uQl6KIo23hoLVhexryf+QJgueL7Kdzc8Kp8lMucMbl1MWMg3n
         hlIKa+KL4n0x2BzsYBMbu+o5mXk3sinXUPAxGeABmDvnei6YVVmdqVWypWhmKF1fvD
         IyzuBHb2Aiyxqym7MkJ9zLGRQgkPYlYA138MCE+PYQqphSj//SSg/kU6FSQz0p2hy6
         jM+AEETvquUxCQ9RFFHK9ALAzvNoRsb7zdRWS5XQjn4mmKIjZprZgV4p18i7cGnGDm
         X7c1VN7tDz0e+4k6STP6KPJxKYWSBjuR7cXmNqDfO3eZn3z/Um3ObLVFFSA8kVNwpX
         nJSmmo3QyCl2A==
From:   Mark Brown <broonie@kernel.org>
To:     Mason Zhang <mason.zhang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mason Zhang <Mason.Zhang@mediatek.com>,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        linux-spi@vger.kernel.org, leilk.liu@mediatek.com
Subject: Re: [PATCH 2/2] spi: mediatek: update spi master bingdings for MT6893 SOC
Date:   Mon, 12 Jul 2021 11:45:40 +0100
Message-Id: <162608669457.4543.2639315857957915855.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210629101310.21045-1-mason.zhang@mediatek.com>
References: <20210629101310.21045-1-mason.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 29 Jun 2021 18:13:11 +0800, Mason Zhang wrote:
> this patch update spi master bingdings for MT6893 SOC.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/2] spi: mediatek: update spi master bingdings for MT6893 SOC
      commit: 3522d9aa19285bbff14da20cb3481e36ef4835fd

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
