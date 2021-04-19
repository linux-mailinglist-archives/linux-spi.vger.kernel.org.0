Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D290B36490D
	for <lists+linux-spi@lfdr.de>; Mon, 19 Apr 2021 19:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbhDSReu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Apr 2021 13:34:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230063AbhDSRes (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Apr 2021 13:34:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 085B161246;
        Mon, 19 Apr 2021 17:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618853658;
        bh=cEHv94ngU2KSQrihCyTESuDSOrXQjqsdy9SA/oN6vdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iKnhbiWgLmv9oKnVdh/c1vbCUINTA0nKgaua88LZBT982/X+iZQGhP/sSwHoElw61
         0NLNgAEURcnvf34VIm3YMm8OQTmmiEZk2fqI8/IhuRAs2wIHL1go1J7Id0tH14P1gs
         t5/sFkMoQaCm6mS2vX9DMu8HqOaO1VTO/dWOOhYpjk0qYvthoELL79RXzhacT9T1g8
         FigK3pVkCoqbeMJahy36e8ezk0KW9YMu64wAsedwwQ5eOzZZ/xbi1htP2S+ZBXQ4pn
         yPgptx7gGeHFwmra+xYsy1pU1YTuiBqP++xzw8Tib/6smsI8Myi+1G9108slxLqTLL
         fJWoPfAKuZKKA==
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        patrice.chotard@foss.st.com
Cc:     Mark Brown <broonie@kernel.org>, christophe.kerello@foss.st.com,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 0/3] spi: stm32-qspi: Fix and update
Date:   Mon, 19 Apr 2021 18:33:45 +0100
Message-Id: <161885314932.4710.7975812733588849701.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210419121541.11617-1-patrice.chotard@foss.st.com>
References: <20210419121541.11617-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 19 Apr 2021 14:15:38 +0200, patrice.chotard@foss.st.com wrote:
> Christophe Kerello (1):
>   spi: stm32-qspi: fix pm_runtime usage_count counter
> 
> Patrice Chotard (2):
>   spi: stm32-qspi: Trigger DMA only if more than 4 bytes to transfer
>   spi: stm32-qspi: Add dirmap support
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: stm32-qspi: fix pm_runtime usage_count counter
      commit: 102e9d1936569d43f55dd1ea89be355ad207143c
[2/3] spi: stm32-qspi: Trigger DMA only if more than 4 bytes to transfer
      commit: f3530f26f8e9869e6e8c3370cf6f61330774fe2b
[3/3] spi: stm32-qspi: Add dirmap support
      commit: 18674dee3cd651279eb3d9ba789fe483ddfe1137

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
