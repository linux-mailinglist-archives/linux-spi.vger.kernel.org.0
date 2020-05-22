Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788D21DEF99
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 21:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbgEVTAz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 15:00:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730840AbgEVTAy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 22 May 2020 15:00:54 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E465E20723;
        Fri, 22 May 2020 19:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590174054;
        bh=L10jn+Uod600sOFDDWCOf7L3Q48oqRtFkolpuXWEwkU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=P3rNlBEWdzkHDM87gotRpru8wQOccT340erc292o2DNbEUI6YIXAbz2AFd9qvlxXn
         Kj4+Q6Jp8UKg4uPbU9QvVbnlDoT49B4TNxk0zRZCxKtw8UN1//whsm3kmKqo6fqT3H
         xdVI8WDPeOY36PD+OJZZKdmmdJXD9TgjWB2ARdlg=
Date:   Fri, 22 May 2020 20:00:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christopher Hill <ch6574@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20200521183631.37806-1-ch6574@gmail.com>
References: <20200521183631.37806-1-ch6574@gmail.com>
Subject: Re: [PATCH 1/3] spi: rb4xx: null pointer bug fix
Message-Id: <159017405191.21035.13416751423126725547.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 21 May 2020 14:36:29 -0400, Christopher Hill wrote:
> This patch fixes a null pointer bug in the spi driver spi-rb4xx.c by
> moving the private data initialization to earlier in probe

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: rb4xx: null pointer bug fix
      commit: 678e5e1e42d74f77a6e2e9feb6f95ed72a996251
[2/3] spi: rb4xx: update driver to be device tree aware
      commit: 9a436c62fbb4c57c6f0be01e4fc368ed5da6b730
[3/3] spi: rb4xx: add corresponding device tree documentation
      commit: 39690c8d1fa3cda70aaed9afc8cba3c0a8eb1f53

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
