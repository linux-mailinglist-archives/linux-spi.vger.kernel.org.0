Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7C922997C
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jul 2020 15:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732603AbgGVNpb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jul 2020 09:45:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbgGVNpb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 Jul 2020 09:45:31 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2A412065D;
        Wed, 22 Jul 2020 13:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595425530;
        bh=JT1T0xY9ITfKv2BNX8GybRgJ1VpXvJMEJdQe/DKkLVY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=rgcY+8l4mr07iC6EemjNyt2U6mRg1dE2tsG1wxssacRUyXef0FqrahoMqxApqXM/S
         NGchfdEbswOuqtUQTsNAuQQdYXQvli5hUA5U8e9yzG34Cuj4U/d3uoSw+CXEy68TbW
         ky6gtVnXNIG2qwWyuXbTx6mtqE/yBPwD7iTupEeY=
Date:   Wed, 22 Jul 2020 14:45:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200720155714.714114-1-vaibhavgupta40@gmail.com>
References: <20200720155714.714114-1-vaibhavgupta40@gmail.com>
Subject: Re: [PATCH v1] spi: spi-topcliff-pch: use generic power management
Message-Id: <159542550175.19884.5724047291778558359.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 20 Jul 2020 21:27:15 +0530, Vaibhav Gupta wrote:
> Drivers using legacy PM have to manage PCI states and device's PM states
> themselves. They also need to take care of configuration registers.
> 
> With improved and powerful support of generic PM, PCI Core takes care of
> above mentioned, device-independent, jobs.
> 
> This driver makes use of PCI helper functions like
> pci_save/restore_state(), pci_enable/disable_device(), pci_enable_wake()
> and pci_set_power_state() to do required operations. In generic mode, they
> are no longer needed.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-topcliff-pch: use generic power management
      commit: f185bcc779808df5d31bc332b79b5f1455ee910b

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
