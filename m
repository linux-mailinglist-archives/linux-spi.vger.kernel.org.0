Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90AEC414BB7
	for <lists+linux-spi@lfdr.de>; Wed, 22 Sep 2021 16:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbhIVOYA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Sep 2021 10:24:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233079AbhIVOX7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 Sep 2021 10:23:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8FF0611EE;
        Wed, 22 Sep 2021 14:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632320549;
        bh=w0CiDKqnRRUJbI+z1jsdeIHWo2h3svuV6kMxajs6Ea0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=faQLVZgoLyJNi7f2zK5ZRZTh+CCGXV8eQk3ndGSgnHU7vqzVB2xNe4i1RGoQoZbs+
         H1kPj4wSX7qMYCBKqr3IH8r63qECyaV1jaxAJrhWF0b4ZqVHyh6Qn54Na87mThcKy/
         iEXlGi56p5coC1R9kKb6/doD0GDA2T/4D8OpkYt4eLdw5EezZUl09G3LZooJV2Ew/Q
         RQt1y784QFaGEUtNCn6sgEvOXCoAl1yMBMcmQtHlAth80PVqR2AN8wy/soh+zKSGoI
         QgVYzFbVLpK3tV0VIzYsRkVbVjwGhH/7yTrA+ZOUvtvQ9ipp/gSyTm79/jGpC6K56A
         PoM8rcFpUDqYw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: Check we have a spi_device_id for each DT compatible
Date:   Wed, 22 Sep 2021 15:21:38 +0100
Message-Id: <163232035870.53481.10674934476747626357.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210921192149.50740-1-broonie@kernel.org>
References: <20210921192149.50740-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 21 Sep 2021 20:21:49 +0100, Mark Brown wrote:
> Currently for SPI devices we use the spi_device_id for module autoloading
> even on systems using device tree, meaning that listing a compatible string
> in the of_match_table isn't enough to have the module for a SPI driver
> autoloaded.
> 
> We attempted to fix this by generating OF based modaliases for devices
> instantiated from DT in 3ce6c9e2617e ("spi: add of_device_uevent_modalias
> support") but this meant we no longer reported spi_device_id based aliases
> which broke drivers such as spi-nor which don't list all the compatible
> strings they support directly for DT, and in at least that case it's not
> super practical to do so given the very large number of compatibles
> needed, much larger than the number spi_device_ids due to vendor strings.
> As a result fell back to using spi_device_id based modalises.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] spi: Check we have a spi_device_id for each DT compatible
      commit: 5fa6863ba69265cb7e45567d12614790ff26bd56

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
