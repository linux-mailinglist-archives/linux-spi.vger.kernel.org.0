Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FB4253829
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 21:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgHZTRx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 15:17:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbgHZTRv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 26 Aug 2020 15:17:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF3A92078A;
        Wed, 26 Aug 2020 19:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598469471;
        bh=Msg94sVnxgYZ5tSLUPVzIC5igpCZ5D0lrYqNmAZsJcA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=GI9cwYFg4+VacryxRyhDAMm+YB4HnfU4u0sj3WwZygN1bT12wVmIPZF3GE95KfUPu
         5UcT0iiN4WvcHMq43eFULl07EScoxqm4OxutgKo92rgfKxcMt6cpQIi/e2wh2i8E4/
         G1XMmMgMCyATAfz8Ub5IxTSuD0zaUzrTdhJa6EaM=
Date:   Wed, 26 Aug 2020 20:17:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-spi@vger.kernel.org, Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Bayi Cheng <bayi.cheng@mediatek.com>,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20200826085450.508556-1-ikjn@chromium.org>
References: <20200820052827.2642164-1-ikjn@chromium.org> <20200826085450.508556-1-ikjn@chromium.org>
Subject: Re: [PATCH v2] dt-bindings: spi: Convert spi-mtk-nor to json-schema
Message-Id: <159846942993.39994.12565318588814253714.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 26 Aug 2020 16:54:50 +0800, Ikjoon Jang wrote:
> Convert Mediatek ARM SOC's serial NOR flash controller binding
> to json-schema format.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: Convert spi-mtk-nor to json-schema
      commit: 043ebcf3204ca1a0ce0d03cb7dc6e0d63d2cf512

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
