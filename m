Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7364D36B56F
	for <lists+linux-spi@lfdr.de>; Mon, 26 Apr 2021 17:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbhDZPLQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Apr 2021 11:11:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233829AbhDZPLJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 26 Apr 2021 11:11:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E2F8600D1;
        Mon, 26 Apr 2021 15:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619449828;
        bh=tNhBVbZyVLvP13Ud9BG50oFq3Cy/ZUDHknpXxPiCkI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W4BxdZK/0xYpU9z/h/JlErgA6RTtW04vpCDFkv7L6ozbyZBPsnGC55vMJIRreoFHG
         CUUyOlowzKIwpi86n8JNS4JxVxv//gNHu8dIQ/cmCyo8yVeAk/6srb3xjMYlT2JFl2
         EAIlnKWfC1OTfNsdqvuXv8iYOk4MQ2/UHcRCkdZ5H6SLa5PJNSOf4eIq++nAyny+I+
         EI6AxbCFRRuZZHXZkSeTEotbxQ5enRngBkhg6+3XpSedShfXanEfY2tA8+FTab8hSc
         PakWBAW7+KqDQ+6+XLNcwRsrTSe0ZA1HsGC/WnUVBw2+LnMUMRP4dFlQJrSnWfyEom
         fRhTWlSruT2Ng==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/1] spi: Rename enable1 to activate in spi_set_cs()
Date:   Mon, 26 Apr 2021 16:09:57 +0100
Message-Id: <161944978786.15099.6336325529331688922.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210420131846.75983-1-andriy.shevchenko@linux.intel.com>
References: <20210420131846.75983-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 20 Apr 2021 16:18:46 +0300, Andy Shevchenko wrote:
> The enable1 is confusing name. Change it to clearly show what is
> the intention behind it. No functional changes.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Rename enable1 to activate in spi_set_cs()
      commit: 86527bcbc88922ea40df05d28189ee15489d2cf1

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
