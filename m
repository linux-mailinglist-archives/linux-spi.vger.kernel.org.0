Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDF21373D5
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2020 17:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgAJQkO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Jan 2020 11:40:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgAJQkO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 10 Jan 2020 11:40:14 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578674413;
        bh=zzjiJuywyxXq8hTk4Pcw1VrgfpgR7j38DYQWzA7a264=;
        h=Subject:From:Date:To:From;
        b=v5i+y2UTEqKmtmCjZZ6Js4JeRKl84eR6eKuzi48BG4P7luhpYx5Ju469jDqeqXcGL
         wotw9C3KzgydG83Hj8cXIFr7WLCtgaKvvfNJL1WBtVGqLEWbQDa4EY1UB+XefH90VC
         g7cpVfKzd1KGpnTivyC/Z0JxtPkTaplhMSWrY1bw=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157867441390.12147.1762723283044301809.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 10 Jan 2020 16:40:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] add device tree for SAM9X60 SoC and SAM9X60-EK board (2020-01-10T16:17:52)
  Superseding: [v1] add device tree for SAM9X60 SoC and SAM9X60-EK board (2020-01-08T12:55:07):
    [01/16] dt-bindings: at_xdmac: add entry for microchip compatibles
    [02/16] dt-bindings: atmel-can: add microchip,sam9x60-can
    [03/16] dt-bindings: atmel-tcb: add microchip,<chip>-tcb
    [04/16] dt-bindings: atmel-isi: add microchip,sam9x60-isi
    [05/16] dt-bindings: at91-sama5d2_adc: add microchip,sam9x60-adc
    [06/16] dt-bindings: atmel-matrix: add microchip,sam9x60-matrix
    [07/16] dt-bindings: atmel-nand: add microchip,sam9x60-pmecc
    [08/16] dt-bindings: atmel-sysreg: add microchip,sam9x60-ddramc
    [09/16] dt-bindings: atmel-smc: add microchip,sam9x60-smc
    [10/16] dt-bindings: atmel-gpbr: add microchip,sam9x60-gpbr
    [11/16] dt-bindings: atmel,at91rm9200-rtc: add microchip,sam9x60-rtc
    [12/16] dt-bindings: spi_atmel: add microchip,sam9x60-spi
    [13/16] dt-bindings: atmel-usart: add microchip,<chip>-usart
    [14/16] dt-bindings: arm: add sam9x60-ek board
    [15/16] ARM: at91/defconfig: enable MMC_SDHCI_OF_AT91 and MICROCHIP_PIT64B
    [16/16] ARM: dts: at91: sam9x60: add device tree for soc and board


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
