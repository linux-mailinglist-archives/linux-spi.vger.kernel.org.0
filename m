Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF4D37A1C2
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 10:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhEKI2G (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 04:28:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230457AbhEKI2A (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 04:28:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95AA2613CB;
        Tue, 11 May 2021 08:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721614;
        bh=KSr+7Mbs6ELX8rQHz8tWoGmhN2IfYhlzuOWD5YDsW6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mxXbO/DO4Duo+zZXGJYKQWYPgY8KasUR7feuF3uMB+UjmRT3R7E2F0mQFKMQfMPda
         /SnRztx3muM4Qj4z9HlVv8Hc0uKoroXSWN1BLJTqCXRXU+yQwfuqjfULSExafGGsKC
         syV3luKUX6gxvVriLKHKJpSGpLav4ZS2HY8uMyOVsHcVd+JsJ4fL/KPr4YLmeR2VC2
         2ka41qcl2Oq+ekmG2jD85GMKySsZbEJccFiScmzA8Tf2I7siwelOMHlhDi8WzQcz0L
         IyQinAhx+5o2RIcnJSrn68kdVj3NQrG/PGkKfLSjkP5VdMIDspYtswow18K5stJBEQ
         977jwwDHeoEtQ==
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: spi: dw-apb-ssi: Integrate Renesas RZ/N1 SPI controller
Date:   Tue, 11 May 2021 09:25:33 +0100
Message-Id: <162072071982.33404.2913820143971609057.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <aef15aa119ed02487ded4691141678bc1040c3b4.1620301936.git.geert+renesas@glider.be>
References: <aef15aa119ed02487ded4691141678bc1040c3b4.1620301936.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 6 May 2021 13:52:59 +0200, Geert Uytterhoeven wrote:
> Originally, the Renesas RZ/N1 SPI Controller DT bindings were not
> integrated in the main DT bindings for the Synopsys DesignWare
> Synchronous Serial Interface, but in its own file, as the RZ/N1
> controller has additional registers for software CS control and DMA.
> 
> As so far DMA is not supported on RZ/N1, and json-schema can handle any
> possible differences fine, integrate the RZ/N1 compatible values in the
> main DT bindings for the Synopsys DW SSI.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: dw-apb-ssi: Integrate Renesas RZ/N1 SPI controller
      commit: 029d32a892a860017d33ff8d9598259731e776ad

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
