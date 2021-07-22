Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6DA03D2AEF
	for <lists+linux-spi@lfdr.de>; Thu, 22 Jul 2021 19:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbhGVQ3n (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Jul 2021 12:29:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233491AbhGVQ3m (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 22 Jul 2021 12:29:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 663FE6101E;
        Thu, 22 Jul 2021 17:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626973816;
        bh=0y6EvV/SZYziFOYNk4mk9PU37phNlHeQ+XRLD0pUigA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=et4gPkV0CJJKASLAX+uUEh0je3ljZNgzdGdJPEU4EFkUTJb2KVanr009oSiznSKtM
         neblx6kPVYcfm3ugFlkSC5ov9oTJorekT46+H7lSB58T1exW67odCtf2QwPl9YGJZX
         kaHSeFqYTKAQ7gqOi4shC/DRfkNOUt8N/WKnlu9yZZ692ErwLs3BnidsIw603DdDCR
         OnKtpQRsOSdXCKXax6dHIfTm/fU4yZTv3e+KcUxdpukwjUYpfOvAPwrXroi4imVUFE
         eTdfSQWBePADUgouN5U5Bfg9XEP3FGD80YzYmcoCCganbfkuStXdivYqysbPR6RPPi
         T8K0zMiEn66/Q==
From:   Mark Brown <broonie@kernel.org>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Peter Rosin <peda@axentia.se>
Cc:     Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: spi-mux: Add module info needed for autoloading
Date:   Thu, 22 Jul 2021 18:09:57 +0100
Message-Id: <162697114029.3066.3673742676606757991.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210721095321.2165453-1-u.kleine-koenig@pengutronix.de>
References: <20210721095321.2165453-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 21 Jul 2021 11:53:21 +0200, Uwe Kleine-König wrote:
> With the spi device table udev can autoload the spi-mux module in
> the presence of an spi-mux device.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mux: Add module info needed for autoloading
      commit: 1d5ccab95f06675a269f4cb223a1e3f6d1ebef42

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
