Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710AA261700
	for <lists+linux-spi@lfdr.de>; Tue,  8 Sep 2020 19:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731676AbgIHRXb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Sep 2020 13:23:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731796AbgIHRVl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Sep 2020 13:21:41 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC5392087D;
        Tue,  8 Sep 2020 17:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599585701;
        bh=mew/1s10XgJXC00/umlnesRbXahPHHRAmBvVFROAPLE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=W2mbYs0d4HETX7iuF+6ZhcuDIskL5R2jzkA4IEU3DYBWaRMKlWulzT718Jq/CvGdc
         uD8S6RdWpVIXwk+kgafzhGmizd5JdQtDfXde/jUa+hW4pd3HwNWTNehIcBbE9ZEZlE
         Vm113A/Z417I/RXVPEKdhZNgqjGNwDMduSAq9/qI=
Date:   Tue, 08 Sep 2020 18:20:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Peter Rosin <peda@axentia.se>,
        Lars Povlsen <lars.povlsen@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-spi@vger.kernel.org
In-Reply-To: <20200824203010.2033-1-lars.povlsen@microchip.com>
References: <20200824203010.2033-1-lars.povlsen@microchip.com>
Subject: Re: [PATCH v5 0/6] spi: Adding support for Microchip Sparx5 SoC
Message-Id: <159958565716.16771.6460929787549553831.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 24 Aug 2020 22:30:04 +0200, Lars Povlsen wrote:
> The series add support for the Sparx5 SoC SPI controller in the
> spi-dw-mmio.c spi driver.
> 
> v5 changes:
> - rx-sample-delay-ns documentation changes from Rob Herring:
>  - Drop superfluous type $ref
>  - Add default value = 0
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: dw: Add support for RX sample delay register
      commit: bac70b54ecb53b3d5af862dd4fcbaaad8f34ed23
[2/3] spi: dw: Add Microchip Sparx5 support
      commit: 53a09635ce56e3041fb3cbc7ceef8f5de28259a5
[3/3] dt-bindings: snps, dw-apb-ssi: Add sparx5 support, plus rx-sample-delay-ns property
      commit: 5ce78f4456a9b2cb103f5bad9e62636e8d086152

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
