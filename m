Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1ED419D49
	for <lists+linux-spi@lfdr.de>; Mon, 27 Sep 2021 19:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbhI0Rsl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Sep 2021 13:48:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237857AbhI0RsS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 27 Sep 2021 13:48:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7FBD60F11;
        Mon, 27 Sep 2021 17:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632764800;
        bh=M2fE1KzUmsHGmDPy1ydIAlzP+8L8KfPS3vRsSeNHrVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nfYgbY3BV5F21rHtxhATAGpxlp5Y/96qyDNt6j6uIhW7WwXKEuI06/DkmDNwxElUb
         7yOWonQCDSq+AGzFew5Jd2WF25H3ly5GlPsZaOfKBjEzq3ojxy3NX7R/VUJZnNBaeD
         z/keUwRIVhAmHL322fGjAWHFhTnDAQyA3yywlHPW1xg3ZMsHr4s6xgiClXf29Pyjl3
         czS5BSBUiQ5sRz7ehehlTPlCMN663EGYecMSxKB7d+sAuXiya3hzeiLOsFwjUby/uh
         2J7BA3sBpjzhj5Pj4p6BN5T5kFT2glSQULj09+CCCdy9oyOpwnfMGmO+c7XjZ/f/JI
         XOqpzezO/vWsg==
From:   Mark Brown <broonie@kernel.org>
To:     Parshuram Thombare <pthombar@cadence.com>, lukas@wunner.de,
        robh+dt@kernel.org, p.yadav@ti.com
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        jpawar@cadence.com, mparab@cadence.com
Subject: Re: [PATCH v6 0/2] add support for Cadence's XSPI controller
Date:   Mon, 27 Sep 2021 18:45:17 +0100
Message-Id: <163276467076.29936.8659985409450963520.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1632038668-23756-1-git-send-email-pthombar@cadence.com>
References: <1632038668-23756-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 19 Sep 2021 10:04:28 +0200, Parshuram Thombare wrote:
> This patch series adds support for Cadence's XSPI controller.
> It supports 3 work modes.
> 1. ACMD (auto command) work mode
>     ACMD name is because it uses auto command engine in the controller.
>     It further has 2 modes PIO and CDMA (command DMA).
>     The CDMA work mode is dedicated for high-performance application
>     where very low software overhead is required. In this mode the
>     Command Engine is programmed by the series of linked descriptors
>     stored in system memory. These descriptors provide commands to execute
>     and store status information for finished commands.
>     The PIO mode work mode is dedicated for single operation where
>     constructing a linked list of descriptors would require too
>     much effort.
> 2. STIG (Software Triggered Instruction Generator) work mode
>     In STIG mode, controller sends low-level instructions to memory.
>     Each instruction is 128-bit width. There is special instruction
>     DataSequence which carries information about data phase.
>     Driver uses Slave DMA interface to transfer data as only this
>     interface can be used in STIG work mode.
> 3. Direct work mode
>     This work mode allows sending data without invoking any command through
>     the slave interface.
> Currently only STIG work mode is enabled, remaining work modes will
> be added later.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: cadence: add dt-bindings documentation for Cadence XSPI controller
      commit: 1f01818b410ac05344c38f65e5ae135e034d47ce
[2/2] spi: cadence: add support for Cadence XSPI controller
      commit: a16cc807762730a6291762d4bedd7b00624a6426

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
