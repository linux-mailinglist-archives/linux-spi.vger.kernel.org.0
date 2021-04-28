Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6BB36DD94
	for <lists+linux-spi@lfdr.de>; Wed, 28 Apr 2021 18:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241351AbhD1QzD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Apr 2021 12:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241330AbhD1QzB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 28 Apr 2021 12:55:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D43E76143A;
        Wed, 28 Apr 2021 16:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619628856;
        bh=OOPtcWEzxX5oxq24BB+j2qJG/SvnmXpxXKzqoIM3jNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FFx+YBg+4cqGU1w+cffngLx/IdDBKn7NXaeFlK2ZrlKB+AWjiA+EMqv/DwtPGnDNX
         Ne7EPvYJbQnjkPJllySdllFkpPwpAxgBfgbuvD02QFn2K3tdecx6usMuYK3clGIdG2
         g8s1pQ3xuHLH17NkqAuVV+FMi5Vyxp2yhvA+IUAwZ9ScVzdBF39V59CsDShWZsWly6
         Q3C1Il23cxcTLGM0Z6WJ/RpRQuJRaUyraUEGUoBnNuyOYZZ4Dd2+UENSXtWTX/9n3g
         UqW3fnJWgtZNhutQExUWpL71EerPaqIHa/SyWohKwsvxFP1qI2FewmyNptsM1/ASVH
         i7J9ESOPVB9Ew==
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Mark Brown <broonie@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] spi: Fix spi device unregister flow
Date:   Wed, 28 Apr 2021 17:53:41 +0100
Message-Id: <161962869503.49700.1086509645637096934.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210426235638.1285530-1-saravanak@google.com>
References: <20210426235638.1285530-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 26 Apr 2021 16:56:38 -0700, Saravana Kannan wrote:
> When an SPI device is unregistered, the spi->controller->cleanup() is
> called in the device's release callback. That's wrong for a couple of
> reasons:
> 
> 1. spi_dev_put() can be called before spi_add_device() is called. And
>    it's spi_add_device() that calls spi_setup(). This will cause clean()
>    to get called without the spi device ever being setup.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Fix spi device unregister flow
      commit: c7299fea67696db5bd09d924d1f1080d894f92ef

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
