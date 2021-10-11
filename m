Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EAE42950F
	for <lists+linux-spi@lfdr.de>; Mon, 11 Oct 2021 19:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbhJKRDs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Oct 2021 13:03:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231646AbhJKRDs (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 11 Oct 2021 13:03:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65D1D60F3A;
        Mon, 11 Oct 2021 17:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633971707;
        bh=trunSQKQ2GIzOU7WZWO6vf/702Eas0ZSDgsLldNfWME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Un+XWCdt8ORuG5rRWlbwLJYki3/NppsyktKShn1HHWT4O/1HiOxRtQIo2RP5TsoBo
         X4gDpM/LxeaKuUJcy4wmXksc4baiXB4dPamcE6/vFEQEcgD2NA1tUsfwFlKiPQUlSB
         s0p44T+GmDfvrArFDo9C/E526zwuGKwQJaEMebVpOg1Ytc/C98cwpEQ9wm8ngc+j9o
         IposvsmSNYYJto56ZsAdbUBLfc0VJ7nbvhB0HwOPgC9R4FJd5Qj+sCEKzdV6rEfBQw
         WIVQOWLooIjQhyN7Y51rt9D38/FZ3VL9paSDh6UBaa9GZrjFmVsHFM1ja/ye0dkxAM
         ifWdpo2+DV9uQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        yendapally.reddy@broadcom.com, f.fainelli@gmail.com
Subject: Re: [PATCH 0/3] spi-bcm-qspi spcr3 enahancements
Date:   Mon, 11 Oct 2021 18:01:38 +0100
Message-Id: <163397094904.6819.8623150916603608652.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211008203603.40915-1-kdasu.kdev@gmail.com>
References: <20211008203603.40915-1-kdasu.kdev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 8 Oct 2021 16:36:00 -0400, Kamal Dasu wrote:
> This change set feature enahancements for spcr3 transfer modes as well as
> adds support for half-duplex 3-wire mode transfer.
> 
> Kamal Dasu (3):
>   spi: bcm-qspi: Add mspi spcr3 32/64-bits xfer mode
>   spi: bcm-qspi: clear MSPI spifie interrupt during probe
>   spi: bcm-qspi: add support for 3-wire mode for half duplex transfer
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: bcm-qspi: Add mspi spcr3 32/64-bits xfer mode
      commit: ee4d62c47326c69e57180da53c057e55f0e73e35
[2/3] spi: bcm-qspi: clear MSPI spifie interrupt during probe
      commit: 75b3cb97eb1f05042745c0655a7145b0262d4c5c
[3/3] spi: bcm-qspi: add support for 3-wire mode for half duplex transfer
      commit: e81cd07dcf50ef4811f6667dba89c5614278cbdd

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
