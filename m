Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB59A3E2034
	for <lists+linux-spi@lfdr.de>; Fri,  6 Aug 2021 02:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242142AbhHFAsb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Aug 2021 20:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242031AbhHFAsb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Aug 2021 20:48:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04BB061185;
        Fri,  6 Aug 2021 00:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628210896;
        bh=S2s6F4nF3F05P33Fwnz3xX4cS4OViBsUU3KUHdqNp6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LjuHTTB5Ia4FUH3yKh0gr1tW0VrVdrruGdZ1q5XIebYsAKMsoCf/Lnzlg/cPfJOfo
         vkvxE9CMKho0GYSigJnkMXCmCRDo70yiqftk+CU1VgoaBizrkb2XYiCpR28+PJLPCC
         WOy4f/RSluyRetcHDslOfjEHHgksW10F9n6fndcq9eiS7LL8CS2Di4+XvV/qaf2V2s
         Uy9oQDP4hJUn8B+lWxSkB0FY6u+iwcKmEZeC5oM6I5F83jlsUr5k5BE+5HdLu3PmF3
         ZgMKciFmtsao1681t6i69zeqryYZxZzyuB+fyjehDWZFgxLJNAU/OI0zSL6Foxur6R
         LHpCe3n4I6Bzw==
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mason Zhang <Mason.Zhang@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 2/2] spi: modify set_cs_timing parameter
Date:   Fri,  6 Aug 2021 01:47:46 +0100
Message-Id: <162821082763.19049.17106859300843537737.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210804133746.6742-1-Mason.Zhang@mediatek.com>
References: <20210804133746.6742-1-Mason.Zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 4 Aug 2021 21:37:47 +0800, Mason Zhang wrote:
> This patch modified set_cs_timing parameter, no need pass in spi_delay
> to set_cs_timing callback.
> By the way, we modified the mediatek and tegra114 spi driver to fix build err.
> In mediatek spi driver, We have support set absolute time not clk_count,
> and call this function in prepare_message not user's API.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/2] spi: modify set_cs_timing parameter
      commit: 04e6bb0d6bb127bac929fb35edd2dd01613c9520

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
