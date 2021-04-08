Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0BB358A31
	for <lists+linux-spi@lfdr.de>; Thu,  8 Apr 2021 18:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhDHQzP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Apr 2021 12:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231566AbhDHQzP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 8 Apr 2021 12:55:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F8B1610A2;
        Thu,  8 Apr 2021 16:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617900904;
        bh=n4AaOm047gic1xsQMxn0173v6IZNNZIRxBSp/Uz27Vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hm4CBDp1664YIT+p/PYrmsyeSZxZfd+StRgQxdFVvHcqTHl5EslIyqBLnwuivfUyb
         9jO0mA+x0fq/KoZQ+p56QYcbI6QaEQjesxAMMBk+J4Gs/T6agFx2347mioQS4/oxeK
         02SVFZd5aNY0resv9e2cAQ05pj632aowFNWZYydLhWgnU5POrFjfcv1BmVMKbeCQik
         XZtUtYbFYP4X9AGA2i70sCYoXLBi0RoHm+YPpoBlvo4K+Wr9a4I3XAtHv3HLkDs2BB
         w/WS47DGfFegbIKNYFftGbpePaTxN5Ob0nDh07yh69rNE3rgUFSRvDuX7TgstRMkex
         hhexHYj8bh65w==
From:   Mark Brown <broonie@kernel.org>
To:     kjlu@umn.edu, Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in zynqmp_qspi_probe
Date:   Thu,  8 Apr 2021 17:54:31 +0100
Message-Id: <161790025317.17096.4281795778439539038.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408092559.3824-1-dinghao.liu@zju.edu.cn>
References: <20210408092559.3824-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 8 Apr 2021 17:25:59 +0800, Dinghao Liu wrote:
> When platform_get_irq() fails, a pairing PM usage counter
> increment is needed to keep the counter balanced. It's the
> same for the following error paths.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in zynqmp_qspi_probe
      commit: a21fbc42807b15b74b0891bd557063e6acf4fcae

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
