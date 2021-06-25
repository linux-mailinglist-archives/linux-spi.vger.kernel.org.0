Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F68F3B4467
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jun 2021 15:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhFYN1s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Jun 2021 09:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231723AbhFYN1s (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 25 Jun 2021 09:27:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBF7E61962;
        Fri, 25 Jun 2021 13:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624627527;
        bh=qcpAWsaKBKP2cYE/QTJytbAgd5/dYyX6bEO/6RAQR9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YgwWd1Z97gDsr2HOEBIE+YINKAIbCMOFDyRb8UcIHURTdp5iA/NuJOQqcBVIrSD8u
         ka0BIiOCmjPs2I71RhIWRHS9W2K0RAmlcKcpypmWq8clarwhZreZGM44Zg8HfbIv6M
         3Soz11sUS7jpNdoeKaEO4WX5JXE/GCpk84Ram8keWaG3MnX1MIRgXADQRKtlsBhlU/
         y6mFJTMkPKXiqwRBeoILLQElg0bMoOSxVP77YDNXfTmKSVCR2ZvFYhaZrNsoRwtyyl
         qB3zW3XPcjl287YmzemkJk/LKJ5PT6TWYNDwQ4WSxkzxiso4UfZEjnUDRBqMFtWPq/
         ooQPEck09apSA==
From:   Mark Brown <broonie@kernel.org>
To:     michal.simek@xilinx.com, robh+dt@kernel.org,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: spi: convert Xilinx Zynq UltraScale+ MPSoC GQSPI bindings to YAML
Date:   Fri, 25 Jun 2021 14:24:56 +0100
Message-Id: <162462715508.45765.10141179560885768264.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210613214317.296667-1-iwamatsu@nigauri.org>
References: <20210613214317.296667-1-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 14 Jun 2021 06:43:17 +0900, Nobuhiro Iwamatsu wrote:
> Convert spi for Xilinx Zynq UltraScale+ MPSoC GQSPI bindings
> documentation to YAML.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: convert Xilinx Zynq UltraScale+ MPSoC GQSPI bindings to YAML
      commit: c58db2abb19fd2bf23fb25bb3630a9f540df6042

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
