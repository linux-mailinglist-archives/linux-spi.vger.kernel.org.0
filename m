Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A18A45DB50
	for <lists+linux-spi@lfdr.de>; Thu, 25 Nov 2021 14:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355507AbhKYNmV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Nov 2021 08:42:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344320AbhKYNkU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 25 Nov 2021 08:40:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A9D06108F;
        Thu, 25 Nov 2021 13:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637847429;
        bh=I+qIOYUEkCQopGYZKuKmqHVkDOBrJtNledOmZhH8c58=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FF6FYTlG6USpz/xtiuPwj29qXim8WGbwoLHhTxlQHMjnk3OxvAFT40mqophWWaSEJ
         j1M36lhUEsUKVRXHZWDwT8sU46mRNGiqvqn3U1VKk15wriqi62aCSVSm8pwR+q8tYB
         kwVCU9AWNZslMtF1J8pEYV3tUc9WFaYDYW07tdw3+VHnOrcm+kdA1Q9OtzbT/fkqDs
         KAeHHY0V3w5Ko/1B8WAKAfFlmFfZbfAU7xtOKIHg/+a/Ueg1pbt2P9vYJ9hkL0L0yc
         2qALsBDI4o2NuY5tUliHxzdtZsPx8zusfKNWRUwo4y5eTpma7ld8OuwbEtDIUEKRO8
         IQWoA7B1/7N0g==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        linux-spi@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        yendapally.reddy@broadcom.com
In-Reply-To: <20211124193353.32311-1-kdasu.kdev@gmail.com>
References: <20211124193353.32311-1-kdasu.kdev@gmail.com>
Subject: Re: [PATCH 0/2] spi transfer paramater changes and baud rate calculation
Message-Id: <163784742804.3102022.16557507037490210155.b4-ty@kernel.org>
Date:   Thu, 25 Nov 2021 13:37:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 24 Nov 2021 14:33:51 -0500, Kamal Dasu wrote:
> The changes picks either the 27Mhz or 108MhZ system clock for spi transfers
> based user requested transfer speed. Also we set the master controller transfer
> parameter only if they change.
> 
> Kamal Dasu (2):
>   spi: bcm-qspi: choose sysclk setting based on requested speed
>   spi: bcm-qspi: set transfer parameter only if they change
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: bcm-qspi: choose sysclk setting based on requested speed
      commit: c74526f947ab946273939757c72499c0a5b09826
[2/2] spi: bcm-qspi: set transfer parameter only if they change
      commit: e10a6bb5f52de70c7798b720d16632d4042d2552

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
