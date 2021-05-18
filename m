Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9E0387D92
	for <lists+linux-spi@lfdr.de>; Tue, 18 May 2021 18:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350708AbhERQdj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 May 2021 12:33:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237685AbhERQdj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 18 May 2021 12:33:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A795C611CE;
        Tue, 18 May 2021 16:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621355541;
        bh=9zV/zMdMZXIyt5TkKZX1Al7bQhnvofQXn9jJ+4sXY+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pw3L+NQ2oddAs5hIATArPiccMlZv2fpWGbgAh7F9385tgwppOTdazeSioMpWtV/Xk
         Zgkdiz3wwjFc0ZpZH6QfO71lSMKIR+ylhALYwN/f4Dggy8ujFiqXpam6nulUjm98pA
         xCsFLT/5x9NMDmswjKOxXJ1UBgmrm4HPUynoDHxg2eYMbqOHxjtdw5Hxbp/RS46FUS
         pZR4z6gbISoHHCDv+BSbFyvO4CCP+0Z41SglqrI3LUhJ1vYSx4FV4J/Y/B3pfZinRT
         X6IgBa7GHb0AHRv8wxk1z6zGFzoW8xaD8EMPQRNUS445YR0I7juqBWgFbTVuOFxPPA
         vaJUnU+O6rwRA==
From:   Mark Brown <broonie@kernel.org>
To:     amelie.delaunay@foss.st.com,
        Alain Volmat <alain.volmat@foss.st.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
        mcoquelin.stm32@gmail.com, fabrice.gasnier@foss.st.com
Subject: Re: [PATCH] MAINTAINERS: Add Alain Volmat as STM32 SPI maintainer
Date:   Tue, 18 May 2021 17:31:26 +0100
Message-Id: <162135545749.38023.1433793383274689045.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1620796842-23546-1-git-send-email-alain.volmat@foss.st.com>
References: <1620796842-23546-1-git-send-email-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 12 May 2021 07:20:42 +0200, Alain Volmat wrote:
> Add Alain Volmat as STM32 SPI maintainer.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] MAINTAINERS: Add Alain Volmat as STM32 SPI maintainer
      commit: d7aed20d446d8c87f5e13adf73281056b0064a45

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
