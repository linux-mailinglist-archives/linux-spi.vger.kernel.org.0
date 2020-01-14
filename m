Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE8E113A792
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2020 11:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgANKkO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jan 2020 05:40:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:35912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgANKkO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Jan 2020 05:40:14 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578998414;
        bh=v8vnVpz1eJdXhASFrWh8GTR9L6gw6nFx/xiPHAkOBtY=;
        h=Subject:From:Date:To:From;
        b=oxuZpXOvmzwiQxJpbuU/PH14f89DiG3PJ4vUald2qLKha/JuK8eGTVzHghGn+b6p6
         8VSh7zfdMwZTSpG4TXki1/E4Bu2jmURD4buf7qteq3RdTB1Q5oOUzai/X3T6pBes7x
         YhBmJPERgZm7hLX4iATZ4j5mNVIeTi7jKhWGuOYM=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157899841429.4970.9863839801681820375.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 14 Jan 2020 10:40:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] add device tree for SAM9X60 SoC and SAM9X60-EK board (2020-01-14T10:23:10)
  Superseding: [v2] add device tree for SAM9X60 SoC and SAM9X60-EK board (2020-01-10T16:17:52):
    [v2,01/17] dt-bindings: at_xdmac: remove wildcard
    [v2,02/17] dt-bindings: at_xdmac: add microchip,sam9x60-dma
    [v2,03/17] dt-bindings: atmel-can: add microchip,sam9x60-can
    [v2,04/17] dt-bindings: atmel-tcb: add microchip,sam9x60-tcb
    [v2,05/17] dt-bindings: atmel-isi: add microchip,sam9x60-isi
    [v2,06/17] dt-bindings: at91-sama5d2_adc: add microchip,sam9x60-adc
    [v2,07/17] dt-bindings: atmel-matrix: add microchip,sam9x60-matrix
    [v2,08/17] dt-bindings: atmel-nand: add microchip,sam9x60-pmecc
    [v2,09/17] dt-bindings: atmel-sysreg: add microchip,sam9x60-ddramc
    [v2,10/17] dt-bindings: atmel-smc: add microchip,sam9x60-smc
    [v2,11/17] dt-bindings: atmel-gpbr: add microchip,sam9x60-gpbr
    [v2,12/17] dt-bindings: atmel,at91rm9200-rtc: add microchip,sam9x60-rtc
    [v2,13/17] dt-bindings: atmel-usart: remove wildcard
    [v2,14/17] dt-bindings: atmel-usart: add microchip,sam9x60-{usart, dbgu}
    [v2,15/17] dt-bindings: arm: add sam9x60-ek board
    [v2,16/17] ARM: at91/defconfig: enable MMC_SDHCI_OF_AT91 and MICROCHIP_PIT64B
    [v2,17/17] ARM: dts: at91: sam9x60: add device tree for soc and board


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
