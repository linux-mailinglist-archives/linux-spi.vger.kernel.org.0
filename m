Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AA3413623
	for <lists+linux-spi@lfdr.de>; Tue, 21 Sep 2021 17:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbhIUP1Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Sep 2021 11:27:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233853AbhIUP1Z (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 21 Sep 2021 11:27:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1150661186;
        Tue, 21 Sep 2021 15:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632237956;
        bh=eyjTinIjeXPa0AJBKtnyfN91AZdFFxdTY14CTjIc1z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AhrcU4h4aLg7A2EytJTjpJEM09a6pqMyRT8ED0GB6up/+6EATWA+8nVai4ssH4+BW
         kpVKSdI/4K4qd3SsPAibowc6tMgWg/aoJbX2rC8AAEoz/cvcfLnyrlrEHHjrujKmNg
         phgcbYmsbbdTa4QPO2UrDifELAm8bgunxIHpcuI/puDKuUInqh9GGq+KIlFGcAnzgB
         30OZU+RZqvy6DBHWLd1am79ZGWNvnqxffTaEPvb23fMlVsKimxfeJ4MrPpihJmsE2z
         BhhZ9YKDCvJC3ORqhXyyrASOapxUeTOV4kp8E+JBPpx0WBsyedUiinpNZPWhAIvJ+W
         ErXv+eq+mTlVQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, Apurva Nandan <a-nandan@ti.com>,
        linux-spi@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Mark Brown <broonie@kernel.org>, michael@walle.cc
Subject: Re: (subset) [PATCH v2 0/2] dt-bindings: mtd: spi-nand: Convert to DT schema
Date:   Tue, 21 Sep 2021 16:25:07 +0100
Message-Id: <163223675481.32536.11593084094057981568.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210920142713.129295-1-a-nandan@ti.com>
References: <20210920142713.129295-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 20 Sep 2021 19:57:11 +0530, Apurva Nandan wrote:
> Series to convert spi-nand.txt binding to YAML format and also fix up
> snps-dw-apb-ssi for related dt_schema errors.
> 
> Changes in v2:
> - Fixed dtschema erros in snps-dw-apb-ssi.
> - Improved additionalProperties, reg, and compatible fields in
>   spi-nand.yaml.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/2] dt-bindings: snps,dw-apb-ssi: Use 'flash' node name instead of 'spi-flash' in example
      commit: d7a48e27b38a94bf73c973c236461234610256d5

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
