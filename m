Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF893F8801
	for <lists+linux-spi@lfdr.de>; Thu, 26 Aug 2021 14:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240886AbhHZMw1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Aug 2021 08:52:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237292AbhHZMw0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 26 Aug 2021 08:52:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DB6660184;
        Thu, 26 Aug 2021 12:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629982299;
        bh=G0g5qoxtqChHUFJNJcPrQux80ciZrW4m+9nezijEiHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k5Xopvhpw36SdBTiAc/TE8o9kk4Baga4HvAHPNQtj4wiaaev2xmWnhYM0iuJB+//H
         IwSulDZPMOzlTPmVSJTrVyYuu2pvwoqDa5FTvX2kQYtZZ+4OEWASGpJaKLWF+3zvh4
         tDmEsw1kjDSolSTym5lLQJVtiJOoWZ9v01Sw/XQFvPjepN7lDga5oHLFMntJf5lSrc
         bfzc8KQtGaknG18IrF2QQD8r7qOXEZ9mhiVoMDvJb/jxJmd2ypXLMOqGLSfAakAg2g
         tZljomFw0E1KaOl8pAnMlsx8ni0XxoeVeRdLuYxxphs+NTDFT9KfjUUQ3kU8quj5cA
         iphxJ/2jmrdvw==
From:   Mark Brown <broonie@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        linux-spi@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Luting Guo <luting.guo@unisoc.com>
Subject: Re: [PATCH V3 0/4] Add sprd ADI r3 support
Date:   Thu, 26 Aug 2021 13:51:07 +0100
Message-Id: <162998226397.33692.16363707556815113095.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210826091549.2138125-1-zhang.lyra@gmail.com>
References: <20210826091549.2138125-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 26 Aug 2021 17:15:45 +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> This patchset adds new ADI version (r3) support which used on sc9863 and
> some other Unisoc's SoCs.
> 
> Since v2:
> * Added Rob's and Baolin's Reviewed-by;
> * Seprated a stable patch for wrong macro fix from the last version patch 1/3;
> * Removed redundant empty line from spi-sprd-adi.c.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: sprd: Fix the wrong WDG_LOAD_VAL
      commit: 245ca2cc212bb2a078332ec99afbfbb202f44c2d
[2/4] spi: sprd: Add ADI r3 support
      commit: 3b66ca9783d1d1b7be7bf41e8934ca2eaf50a9c0
[3/4] dt-bindings: spi: Convert sprd ADI bindings to yaml
      commit: f15e60d460391d16bdad2e446e9dca4f264ccdfe
[4/4] dt-bindings: spi: add sprd ADI for sc9863 and ums512
      commit: 0f887ac82971cbde59e563d6490c05c6b15aa82f

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
