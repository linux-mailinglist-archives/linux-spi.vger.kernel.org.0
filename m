Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF530367311
	for <lists+linux-spi@lfdr.de>; Wed, 21 Apr 2021 21:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245379AbhDUTEv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Apr 2021 15:04:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245377AbhDUTEr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 21 Apr 2021 15:04:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4348A6145F;
        Wed, 21 Apr 2021 19:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619031853;
        bh=g/8nf17kbeStmv6J0pgzqx/VDBN/9MWXjrwtGSSy01c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fRGeF2/vjXflG5d648nIuWmTnPIF3fyMyR/HBh2+67Bk/AM+qV1QjV46fvqS0A3Uj
         R+wyzuXVKD8G4dmH+292QY2pUo2dphKSJjzPSqip4HpRnHKfBlsJ5Ptunz45f4F+n2
         vDv1TNXxWDurw8t52pOPNAi6qH9hz0dbNEwol2NIVHxnnTbVB20sfEFPizuWcmhaEb
         kle6AvOesGeKX+Ts/3DrmMdRGfd/XLh8V1lNcKYlL8yEnPE0zgwOTBjpLRwN+34EIm
         K0U58P7MYB8khtSxwDDxL9yRjoA/GNrd72LrOQAoIcrv7H81LepkKwu1IH/3OMXdBQ
         AhncME7/ZHcQg==
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        eajames@linux.ibm.com
Cc:     Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: fsi: add a missing of_node_put
Date:   Wed, 21 Apr 2021 20:03:27 +0100
Message-Id: <161903040535.13608.18069667099177914560.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <504e431b900341249d331b868d90312cf41f415a.1618947919.git.christophe.jaillet@wanadoo.fr>
References: <504e431b900341249d331b868d90312cf41f415a.1618947919.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 20 Apr 2021 21:46:13 +0200, Christophe JAILLET wrote:
> 'for_each_available_child_of_node' performs an of_node_get on each
> iteration, so a return from the middle of the loop requires an of_node_put.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsi: add a missing of_node_put
      commit: 24b5515aa3ac075880be776bf36553ff7f9712c7

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
