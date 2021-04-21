Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF3336730D
	for <lists+linux-spi@lfdr.de>; Wed, 21 Apr 2021 21:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245367AbhDUTEp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Apr 2021 15:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245356AbhDUTEo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 21 Apr 2021 15:04:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47AF861454;
        Wed, 21 Apr 2021 19:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619031850;
        bh=EUamgAcBScttg/wRJDAg/kzndRLDlqHrPak55dTAxiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sn1GGJaL6FbTz2sIQBc9TIgqmuQdTUPtoFsF297z00vXBoWGzxsQ93Oj28EEkgHi8
         WDH0KN7+oUAvQnBIox2vGRQI7isMNdC/2k0P6Fg1QRGQxtOsDeQ2+zP4FetzMJYc4O
         lo1jJVQqpgRa+ZmquRRH9dVKIqk7f2//2Kr/dBhyZI8sQyCEI35arIS3m2F+QDHSuk
         Wnbg9CTiaDJd33MLLdYidFdpwds/RaIspR81oXB233iWlh1LSr+Ai4DPM3OMrUWfns
         FKB5ilUlT/YfWaT7aEykW/1XPO3jVVU8qoptHDB1eGMWbYRIt+gP9hO4b9JagmJw6x
         tCZzIXuxa3P4g==
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        saravanak@google.com
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH] spi: Make of_register_spi_device also set the fwnode
Date:   Wed, 21 Apr 2021 20:03:26 +0100
Message-Id: <161903040535.13608.1822731950090796402.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210421101402.8468-1-ckeepax@opensource.cirrus.com>
References: <20210421101402.8468-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 21 Apr 2021 11:14:02 +0100, Charles Keepax wrote:
> Currently, the SPI core doesn't set the struct device fwnode pointer
> when it creates a new SPI device. This means when the device is
> registered the fwnode is NULL and the check in device_add which sets
> the fwnode->dev pointer is skipped. This wasn't previously an issue,
> however these two patches:
> 
> commit 4731210c09f5 ("gpiolib: Bind gpio_device to a driver to enable
> fw_devlink=on by default")
> commit ced2af419528 ("gpiolib: Don't probe gpio_device if it's not the
> primary device")
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Make of_register_spi_device also set the fwnode
      commit: 0e793ba77c18382f08e440260fe72bc6fce2a3cb

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
