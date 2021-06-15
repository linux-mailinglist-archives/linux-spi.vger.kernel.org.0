Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3021B3A83C3
	for <lists+linux-spi@lfdr.de>; Tue, 15 Jun 2021 17:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhFOPRb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Jun 2021 11:17:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230079AbhFOPRb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 15 Jun 2021 11:17:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2306261601;
        Tue, 15 Jun 2021 15:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623770126;
        bh=MYHkuK3uOLVum0xq/JwRmdO5KG2CRJaEP6NvhWxooE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TPSx70679wc2SPyTAXJQTTB8qN/99EfO0JW9u82hiEOlZk/mk2Ajj6KRPrMYgPvTy
         D8sLD5KFGZ6nmWRWqDMcUnXauquzMCPTEkw7GtweMvRgcC10pNUaJERbACHXBZ5VTF
         byb47NodJuZy5YeECNhOvspv9SwipYRLohFH3gGp7zwqJOYshex5Lk5qgABCmHfUXr
         E8yIgsVmy5SVqbdpPHN1NOR81f2o61M85v65BG/GShv6W8iUM5/0sEdc1ikwz+E5Rk
         GDu6qw8xu8WRAdYaZmRYa5yoAq2/vdBYnQZcZoAnWxkKCpuNVHTREm63329dAmmmu8
         ApHmeyGMyOG8g==
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        patrice.chotard@foss.st.com
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        christophe.kerello@foss.st.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] spi: stm32-qspi: Remove unused qspi field of struct stm32_qspi_flash
Date:   Tue, 15 Jun 2021 16:15:05 +0100
Message-Id: <162376589204.36516.7751226518675364305.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210615090115.30702-1-patrice.chotard@foss.st.com>
References: <20210615090115.30702-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 15 Jun 2021 11:01:15 +0200, patrice.chotard@foss.st.com wrote:
> Remove struct stm32_qspi_flash's field qspi which is not used.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32-qspi: Remove unused qspi field of struct stm32_qspi_flash
      commit: 6a5976f23dc38749afcb62cc3acf5e3e2b53d5ba

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
