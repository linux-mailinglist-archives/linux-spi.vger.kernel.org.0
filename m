Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4761387D8E
	for <lists+linux-spi@lfdr.de>; Tue, 18 May 2021 18:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345582AbhERQdh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 May 2021 12:33:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237685AbhERQdg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 18 May 2021 12:33:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F485611AD;
        Tue, 18 May 2021 16:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621355538;
        bh=u/ifQStYJysHcF59SInItHEF8Wxyg3nxlW2CG82zMp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DEDhKcf3e997sxUsUKQQUP64kru3kfut0zj6klKiXRgXBmbqZxYQtcXCc18XQt3+E
         tN3i2ixBdXR9K2xfD3bEbkPkMPXLSl8ZZhONpsVisQK3Elu8g7T/svIijJpPbrxrPZ
         aIJjrCUQMj35EoI50N1wYEUXhKJI98v/8fyrfYayZrGpBi3bVzQeTnYt4wIZRzQkw9
         aFn9g/h9osQMcRBQPuL1eNWPn6T4DPspm+0MwsKd2P5Jkwk6l14vE8FZ/JnbhDOSYZ
         yg9qQgZ5Zkz+bftGNjGxJr961anAHwzWSrYPFRN57QjDO28IQN0s7SPII9tiV7oOgh
         ODGlDhpXLDeYQ==
From:   Mark Brown <broonie@kernel.org>
To:     Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: spi: spi-mux: rename flash node
Date:   Tue, 18 May 2021 17:31:25 +0100
Message-Id: <162135545749.38023.9744391307325226905.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210517153946.9502-1-michael@walle.cc>
References: <20210517153946.9502-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 17 May 2021 17:39:46 +0200, Michael Walle wrote:
> The recent conversion of the common MTD properties to YAML now mandates
> a particular node name for SPI flash devices.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: spi-mux: rename flash node
      commit: 0b07154f066ab2c087c342b372be5771145bdc60

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
