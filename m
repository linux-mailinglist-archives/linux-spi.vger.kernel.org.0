Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD1E40896E
	for <lists+linux-spi@lfdr.de>; Mon, 13 Sep 2021 12:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbhIMKzc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Sep 2021 06:55:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238681AbhIMKzb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 13 Sep 2021 06:55:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A1CE6103B;
        Mon, 13 Sep 2021 10:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631530456;
        bh=3SRhzTBiqP3IIrmIEDH1+61sWzXII/5uXbVi3rCBjN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CBD90Xf9ehAWWcgw2ujqPuwldG7ZtQe2ChCYey8K4Yrpdt71xUyogfzhFXu8RfMGl
         aS1IFPzUR2q2fjVe9MfOtnip2AE7WWISVY06NqXDR8DxgcMP8U7qHJPJwjQrLr4MNJ
         pYD6jrZjRft61Hq51iXcR+p1+IJLiR/Ho8dhFgE0392axlZGZK0IQHHnMjH5hzgE/F
         dsicF8XxY79QiunsWufOgJVgvfkfVJrmV9UnOTvbVA5RhU3jPz1s+mpOAHzn21Vc0J
         5R8+G3GVLods03LmnR4bdM7CQ94qIoa9VoNWMFBAYzW+ztbGxSH2FEZyGLEc3dBdlG
         QnRJ3BEcK/x9g==
From:   Mark Brown <broonie@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Pavel Nadein <pavelnadein@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, Pavel Nadein <pasha-net@narod.ru>
Subject: Re: [5.16][PATCH 0/3] Support for Ingenic JZ47xx SPI controller
Date:   Mon, 13 Sep 2021 11:53:07 +0100
Message-Id: <163153017121.45927.12831297849596169623.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210830230139.21476-1-contact@artur-rojek.eu>
References: <20210830230139.21476-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 31 Aug 2021 01:01:36 +0200, Artur Rojek wrote:
> This patchset introduces support for SPI controllers found in the
> Ingenic JZ47xx family of SoCs. Of particular note, this allows to
> replace GPIO backed SPI on the MIPS Creator CI20 board.
> 
> Mark:
> Checkpatch generates a `need consistent spacing around '*'` error on
> this patchset, however I believe this is a false positive due to it
> confusing a pointer with multiplication operator inside a macro.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] dt-bindings: spi: Document Ingenic SPI controller bindings
      commit: ff4daa7dd7e624a989dc882f7dcce6d8818b1036
[2/3] SPI: add Ingenic JZ47xx driver.
      commit: ae5f94cc00a7fdce830fd4bfe7a8c77ae7704666
[3/3] MIPS: JZ4780: CI20: DTS: add SPI controller config
      commit: 7b3fd8109b5d343b535e796328223b4f1c4aff5c

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
