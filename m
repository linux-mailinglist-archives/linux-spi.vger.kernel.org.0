Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1263CEBA1
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jul 2021 22:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356334AbhGSRWD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Jul 2021 13:22:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378430AbhGSRTq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Jul 2021 13:19:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFC1B610FB;
        Mon, 19 Jul 2021 18:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626717625;
        bh=JWq2f6zNmXW4BeuCzn54AbgPD0+ZAm0TjMTAxYtV9WI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TcFZvwR4olyw/rrNp+dglf+As16BA6AgtlpU9jbbv1IdRM67IVAUAU+XWWQxsFlmW
         SF1Q5vVrYpa+fN4Af8orQ5P0wVwwGI4DfKmHKSJaWTy0aRl4nZoU2ssZbNUEaV1JSq
         IxP5UIhIZmBaicQX7B98EL7d+YRt2FGtVMtqn6nuMrTsfn9ifd+J6QaSyAko/RWPCE
         JlpIwCNAOL1ncwHYjCns90XOsirn4UzDhCqlL+Z8YFnLxdl/4kWny6Ary47csLHBbQ
         JdGJ2HjxZZGbo+y8ePkIj/Tk5YZ5wFFTVCwAtjJ1GlYk4KQuBIWl3aabc9hN+tgolR
         CCOxjuKRByLRQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Cc:     Mark Brown <broonie@kernel.org>, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        joel@jms.id.au, openbmc@lists.ozlabs.org
Subject: Re: [PATCH 0/2] spi: fsi: Reduce max transfer size to 8 bytes
Date:   Mon, 19 Jul 2021 19:00:21 +0100
Message-Id: <162671570469.34697.17687227058188572653.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210716133915.14697-1-eajames@linux.ibm.com>
References: <20210716133915.14697-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 16 Jul 2021 08:39:13 -0500, Eddie James wrote:
> The security restrictions on the FSI-attached SPI controllers have
> been applied universally to all controllers, so the controller can no
> longer transfer more than 8 bytes for one transfer. Refactor the driver
> to remove the looping and support for larger transfers, and remove the
> "restricted" compatible string, as all the controllers are now
> considered restricted.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: fsi: Reduce max transfer size to 8 bytes
      commit: 34d34a56a5ea1e54a5af4f34c6ac9df724129351
[2/2] dt-bindings: fsi: Remove ibm,fsi2spi-restricted compatible
      commit: 2b2d4dfca4e7cb6de70985b1579a6c08c027b8c9

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
