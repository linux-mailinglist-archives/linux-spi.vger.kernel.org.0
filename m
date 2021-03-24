Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3855348568
	for <lists+linux-spi@lfdr.de>; Thu, 25 Mar 2021 00:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238872AbhCXXj5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Mar 2021 19:39:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239041AbhCXXjr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 24 Mar 2021 19:39:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEB0E619F8;
        Wed, 24 Mar 2021 23:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616629187;
        bh=8WB/8IvSpb94NjPs5pZL28lNHaNlJ0ynE8YIdJ3iv2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l62bxQK0f1CisswsdIHIA4YYgqasteXgTEzKNsrICUzprZorIha02oiZ4jKLXYDQL
         B2Ek4+6BxX0XNujd68HgNdB/xRkVBASlh/dfacTDYxL5B5LgxXvKGFsPhDekPImM9q
         VGj5hTF8YDFLF+ySNafiscpdoGFS/2ny9HISftScPXFgi5Xn7ZTnSB+FylAR//9fs0
         Vsetl+X0b1/vtDCvBeEqMMq4+u5i/xpOLgWcZvIO3pOPV7MfelPAdNmdDxEVvYg66r
         8uZE4Zf60y/bSm+fg/4HPcTfWiqYHOKBlvLqmjj1ZoiDci5izYbxB3JHbv71y0tCE8
         RzKPdNrpvtECg==
From:   Mark Brown <broonie@kernel.org>
To:     Jay Fang <f.fangjian@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, huangdaode@huawei.com,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 00/11] spi: Fix ERRORs reported by checkpatch
Date:   Wed, 24 Mar 2021 23:39:33 +0000
Message-Id: <161662883642.51717.4021125408436429442.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1616566602-13894-1-git-send-email-f.fangjian@huawei.com>
References: <1616566602-13894-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 24 Mar 2021 14:16:31 +0800, Jay Fang wrote:
> A total of 27 ERRORs are found when scanning all files in the drivers/spi
> directory by checkpatch tool. This series fixes 21 ERRORs of them, and the
> remaining 6 ERRORs I don't think need to be fixed.
> 
> No functional change.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/11] spi: spi-topcliff-pch: Fix checkpatch spacing error
        commit: c9831087356b7ae02dfb22b3121117c48aa9e95b
[02/11] spi: sprd: Fix checkpatch spacing error
        commit: e13a870ffaa60f459892eb4600a286b4db7da5ad
[03/11] spi: pxa2xx: Fix checkpatch spacing errors
        commit: c07caca3cea90332e410ba3e53bc264ae1f2c9c9
[04/11] spi: omap-100k: Fix checkpatch spacing errors
        commit: f2edb98e806d0bf7947e5da352d69f4fbb063b04
[05/11] spi: spi-mtk-nor: Fix checkpatch spacing error
        commit: 99b3a36204564cb689cd862794043e1b8f5863b1
[06/11] spi: dln2: Fix open brace following function definitions go on the next line
        commit: 211f8a0a39cd7dcd9c14744053ea681a0e7eb36d
[07/11] spi: spi-bitbang: Fix open brace following function definitions go on the next line
        commit: f96c19fab393db16a2db78183ca8f584ee1b716a
[08/11] spi: jcore: Fix trailing statements should be on next line
        commit: 45793de7bf89fbd0fd1e2db9dda4e58a9c1395ee
[09/11] spi: spi-mem: Fix code indent should use tabs where possible
        commit: 6ca6ad908e965b1b01c31618971a1de7b6307a21
[10/11] spi: rockchip: Fix code indent should use tabs where possible
        commit: 02621799966babf50d1d1dc523e834366904b55d
[11/11] spi: pl022: Fix trailing whitespace
        commit: 9d5376872162dc70c16ae8379dba0266f35883f9

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
