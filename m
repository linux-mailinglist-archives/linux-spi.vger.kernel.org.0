Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE64F14096E
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2020 13:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgAQMAQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jan 2020 07:00:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:60050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgAQMAQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 17 Jan 2020 07:00:16 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579262415;
        bh=9ZjBAdQCp2oVE3UT1IkLaO+KVYRmwok2FWuZLyqkSIM=;
        h=Subject:From:Date:To:From;
        b=hwo3Yr8v723ZU2Faj3NwIouDv49imA7WsVa8Kr5wSnPhkif8nIktB1NfClwrimR/v
         z1j0Ccdt3czL2TNUbHKSkczQYh5HuxKJfClaxT3feHHZGrVt57HF7oF8hAPQ2M7VVR
         zxw5KaV1DLsrySJeP/fkh3SX6PI4zYc/F/HYuGKk=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157926241527.19277.8585237815774985044.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 17 Jan 2020 12:00:15 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] add device tree for SAM9X60 SoC and SAM9X60-EK board (2020-01-17T11:58:27)
  Superseding: [v4] add device tree for SAM9X60 SoC and SAM9X60-EK board (2020-01-15T10:59:42):
    [v4,1/5] dt-bindings: atmel,at91rm9200-rtc: add microchip,sam9x60-rtc
    [v4,2/5] dt-bindings: atmel-usart: remove wildcard
    [v4,3/5] dt-bindings: atmel-usart: add microchip,sam9x60-{usart, dbgu}
    [v4,4/5] ARM: at91/defconfig: enable MMC_SDHCI_OF_AT91 and MICROCHIP_PIT64B
    [v4,5/5] ARM: dts: at91: sam9x60: add device tree for soc and board


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
