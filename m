Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F2334220A
	for <lists+linux-spi@lfdr.de>; Fri, 19 Mar 2021 17:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhCSQhZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Mar 2021 12:37:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230129AbhCSQhJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 19 Mar 2021 12:37:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CF526148E;
        Fri, 19 Mar 2021 16:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616171829;
        bh=vze3nZ9XGVQKBDHy8nsHBoCFG5qVh398Hqss19Pvgcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZuDXGH84pbQdkB3SSfKOf0aSsTvCpyL0Mlax46k9BnxI/78JRYfBGQ2Qr2YtVdJn+
         +7goMlBb6oAJyl9Qb30pwkTAqQgWmQhNQjgXl8nb1a3ww1E/DwhVaGpthffkGr0xMt
         N2IGeaTnwA67m9c7v9kVMO/gt49gBoZGXgI/mqjnNOt+5PBKF5oZNWxR6MvsDRavEa
         PBb45JvsX0r0zNhl4PUDHvffqnE/q7fLzk1idS65IIgQaTkZgPHOBWzDKge8xsL+j1
         BbBFN0v6c04fP2PJj0cc6KD/0bqT+XX4wgAufxTc9NIiIv5Za2YZZ8/aslQq883f0v
         3/BDim9n61K6Q==
From:   Mark Brown <broonie@kernel.org>
To:     amelie.delaunay@foss.st.com,
        Alain Volmat <alain.volmat@foss.st.com>
Cc:     Mark Brown <broonie@kernel.org>, mcoquelin.stm32@gmail.com,
        fabrice.gasnier@foss.st.com, alexandre.torgue@foss.st.com,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        antonio.borneo@foss.st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: stm32: Fix use-after-free on unbind
Date:   Fri, 19 Mar 2021 16:37:03 +0000
Message-Id: <161617166734.9851.4969692619964809885.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1616052290-10887-1-git-send-email-alain.volmat@foss.st.com>
References: <1616052290-10887-1-git-send-email-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 18 Mar 2021 08:24:50 +0100, Alain Volmat wrote:
> stm32_spi_remove() accesses the driver's private data after calling
> spi_unregister_master() even though that function releases the last
> reference on the spi_master and thereby frees the private data.
> 
> Fix by switching over to the new devm_spi_alloc_master() helper which
> keeps the private data accessible until the driver has unbound.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: Fix use-after-free on unbind
      commit: 79c6246ae8793448c05da86a4c82298eed8549b0

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
