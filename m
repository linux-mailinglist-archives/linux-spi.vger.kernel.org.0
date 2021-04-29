Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29E836EEAE
	for <lists+linux-spi@lfdr.de>; Thu, 29 Apr 2021 19:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbhD2RRK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Apr 2021 13:17:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233302AbhD2RRJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 29 Apr 2021 13:17:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF8EA61447;
        Thu, 29 Apr 2021 17:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619716581;
        bh=3ORfGYj/153sJmdrDzrnGnyPcEjT30k1byRVwSVWPHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ef0cN8Oq1Hq1J5Gqbmv0wQWX4Xua3tAgu1s4cnCmN9huXHvccSyR33NQODEjaYBh4
         A/UKA1APOOQO1jV6IjqFwGBoLko9Y263TfFjcwwMPNnMahjNYg5SpDl0cWNPKbIG9C
         TvQlQsBByCjRsDXWSrqeBjpVALit6e354pU27rOSihVTCo0akE64cZbb73BFcKzFCv
         x3DSn2utg2WA8hvw3t7ZU3ml7uki8gc1ZhRjq4HjuN3ZlufmneXWQDsRRxPCuIFhyp
         OZKUi+Pfz9Zhm290mRsrJaPWqth69S4NM6duOaCi0dwuhJ180G3M0jGs3zwSVLtiYd
         7f4HQuDAa10YA==
From:   Mark Brown <broonie@kernel.org>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     Mark Brown <broonie@kernel.org>, git@xilinx.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND 0/2]spi: spi-zynq-qspi: Fix stack violation bug
Date:   Thu, 29 Apr 2021 18:15:48 +0100
Message-Id: <161970928184.41765.9202209200886629719.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210429053802.17650-1-amit.kumar-mahapatra@xilinx.com>
References: <20210429053802.17650-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 28 Apr 2021 23:38:00 -0600, Amit Kumar Mahapatra wrote:
> This patch series fixes kernel-doc warnings and stack violation
> issues in Zynq qspi driver.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spi-zynq-qspi: Fix kernel-doc warning
      commit: 121271f08809e5dc01d15d3e529988ac5d740af6
[2/2] spi: spi-zynq-qspi: Fix stack violation bug
      commit: 6d5ff8e632a4f2389c331e5554cd1c2a9a28c7aa

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
