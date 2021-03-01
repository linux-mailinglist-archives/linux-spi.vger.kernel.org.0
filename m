Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11CA32A5D8
	for <lists+linux-spi@lfdr.de>; Tue,  2 Mar 2021 17:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240808AbhCBNUB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Mar 2021 08:20:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346258AbhCAXkH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 1 Mar 2021 18:40:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E55F6146B;
        Mon,  1 Mar 2021 23:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614641949;
        bh=FC5E0jgM2oYDDQU3j98r7awtXgaJzsC9gg9QAlFAKC8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ge/cQFMMzNZ8kEJ0nCBHlFyfI4rzjL2b8N5jGL5BpTA8jXuBqFqNgQQpRhhNYGwGq
         bUnqFurDNzQFkgb0UDk4R7yex3dETJDiPrY2ftRv8nGc5Cu/H3eWZ2vVF8aNNgPWuc
         meTwGEMNlRALGaEdKlzO7J0BCQt/irAzh/Ae0/Il1qcMmMuV9C+pege+buXLNUgar5
         cfco/rKBuz7jM+/5FGoBRM+KDPzmWM7tb/9cXBL5LVo0ONdfrPOd79PcM9nXbrdOOe
         wvYmeHaSjTAYQhTw3/ISwovbx+1S04PJIs/2rbS3+isWqtTmDbw/dVEuN0JWbzYjDA
         FZ6/3JAPi7iWQ==
From:   Mark Brown <broonie@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>
Cc:     linux-rockchip@lists.infradead.org,
        Alexander Kochetkov <al.kochet@gmail.com>,
        Jon Lin <jon.lin@rock-chips.com>,
        Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Johan Jonker <jbx6244@gmail.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-spi@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20210225125541.1808719-1-arnd@kernel.org>
References: <20210225125541.1808719-1-arnd@kernel.org>
Subject: Re: [PATCH] spi: rockchip: avoid objtool warning
Message-Id: <161464187231.31555.17379793263807156995.b4-ty@kernel.org>
Date:   Mon, 01 Mar 2021 23:37:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 25 Feb 2021 13:55:34 +0100, Arnd Bergmann wrote:
> Building this file with clang leads to a an unreachable code path
> causing a warning from objtool:
> 
> drivers/spi/spi-rockchip.o: warning: objtool: rockchip_spi_transfer_one()+0x2e0: sibling call from callable instruction with modified stack frame
> 
> Use BUG() instead of unreachable() to avoid the undefined behavior
> if it does happen.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rockchip: avoid objtool warning
      commit: d86e880f7a7c5b64a650146a1353f98750863f21

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
