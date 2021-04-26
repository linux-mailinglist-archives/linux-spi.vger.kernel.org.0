Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D271C36B571
	for <lists+linux-spi@lfdr.de>; Mon, 26 Apr 2021 17:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbhDZPLR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Apr 2021 11:11:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233973AbhDZPLM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 26 Apr 2021 11:11:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 819DD61289;
        Mon, 26 Apr 2021 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619449831;
        bh=TFq7kiQdjGAQzF36BJ2uF0+GQaNJWuVwyE3Ppyv4z2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vP/q0mM7spKtvBRV8gEuxRGV9D5TusU6QS94HuYTmwyJQ4x2AItGMdNDFVrXhrTnr
         7TYKDWbpEAlK43oOLpsntGMkj60+ORP7XoFuR3URuzaET909meZe8mvJYmF8FPETug
         j9Syib1JKoSPRIuBWisMRV2f/98KV7+mSb6Ba2Y2Xxe+EafXnw1EPd05Z1/b45yg5k
         eFSIOJKmXz1z4AFzGofcZyyzXfm+Emc22sxsspoCtnZRKJ4FV/0ZetYCCRxuNRvTJM
         elbEGkh5YKLbzhIY0ZtaYeuARnhOwoO/1uF1tWCluEY5bI03sBsrLfwAzP9+tGH3os
         YNfg9svEjobCw==
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Kuldeep Singh <kuldeep.singh@nxp.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Han Xu <han.xu@nxp.com>
Subject: Re: [PATCH] dt-bindings: spi: Convert Freescale QSPI binding to json schema
Date:   Mon, 26 Apr 2021 16:09:58 +0100
Message-Id: <161944978786.15099.9857213915602715493.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210312054038.3586706-1-kuldeep.singh@nxp.com>
References: <20210312054038.3586706-1-kuldeep.singh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 12 Mar 2021 11:10:38 +0530, Kuldeep Singh wrote:
> Convert the Freescale QSPI binding to DT schema format using json-schema.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: Convert Freescale QSPI binding to json schema
      commit: 9ec2a73f0b09f5a5070a0092f08b1531b2cb0d8d

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
