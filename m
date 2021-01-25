Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367E8304427
	for <lists+linux-spi@lfdr.de>; Tue, 26 Jan 2021 18:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbhAZGB3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Jan 2021 01:01:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:53156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729376AbhAYOUK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 25 Jan 2021 09:20:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E42AA2228A;
        Mon, 25 Jan 2021 14:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611584370;
        bh=7fpC+lTJSKxpC4pR/T7CZ14Iq6EymDL3VFSG9czVQ7M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iB6Y6xf+/afU+e1dBXKFAVyDkgLDNaPfZ/lS/xU2wbHUzebK2Papr3magQ+88sSrp
         MBcXZZDW1hugZVvSZwxNbs5veQR87pmKIZ2VXz4t0Fc3lEiiZJf2M+ZRZc+xOrIuaq
         bsmrUC5jXApAMYfFc/Ueau/7vikJz6MR4NMSlW9DEqt2T7od5GmlQzz73TIfoL2+RL
         VTcxKDVdoRXV2dqqzE5zQEoYCGt1qCGUVwn0nGKDlCyiiXp0OLAhtf0QbuEZr+3p4S
         t3Es3m0iL7a2nc/RykX5Oot98plEbzvnd/vRzi2f0O2R++xI4AqbTuRQCSn0oZ0bvh
         ngxpcp73vFnOw==
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Walker <danielwa@cisco.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        xe-linux-external@cisco.com
In-Reply-To: <20210121231237.30664-2-danielwa@cisco.com>
References: <20210121231237.30664-2-danielwa@cisco.com>
Subject: Re: [PATCH 2/2] spidev: Add cisco device compatible
Message-Id: <161158432930.33513.16598539718945571721.b4-ty@kernel.org>
Date:   Mon, 25 Jan 2021 14:18:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 21 Jan 2021 15:12:36 -0800, Daniel Walker wrote:
> Add compatible string for Cisco device present on the Cisco Petra
> platform.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/2] spidev: Add cisco device compatible
      commit: 396cf2a46adddbf51373e16225c1d25254310046

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
