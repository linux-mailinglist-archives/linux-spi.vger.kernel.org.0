Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1F1E13BE4D
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2020 12:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgAOLUM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jan 2020 06:20:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:49858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgAOLUM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 15 Jan 2020 06:20:12 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579087211;
        bh=RUjH8lk+QqGnso5mr0tjm+DBoPTLzrWCWY1Qsn57dxw=;
        h=Subject:From:Date:To:From;
        b=IbkfYKRGv5ztyMdaOuxpm4UxzxNABOGfjcb99Pa1CDrlhkzn1nxtvbBX+QeMKIQ+C
         PxP2Jca1RlTOtzJ0FDpXIGgRRPbNlUpLEcQ8RdswoqLTeXpnC1u6bpKJvA7cXM1oaA
         FjnVG4IJwVb0SqNkRgRQvWbC7AKrdlN+q4enD/dI=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <157908721151.32343.11816369276484605501.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 15 Jan 2020 11:20:11 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] add device tree for SAM9X60 SoC and SAM9X60-EK board (2020-01-15T10:59:42)
  Superseding: [v3] add device tree for SAM9X60 SoC and SAM9X60-EK board (2020-01-14T10:23:10):
    [v3,1/7] dt-bindings: atmel-tcb: remove wildcard
    [v3,2/7] dt-bindings: atmel-tcb: add microchip,sam9x60-tcb
    [v3,3/7] dt-bindings: atmel,at91rm9200-rtc: add microchip,sam9x60-rtc
    [v3,4/7] dt-bindings: atmel-usart: remove wildcard
    [v3,5/7] dt-bindings: atmel-usart: add microchip,sam9x60-{usart, dbgu}
    [v3,6/7] ARM: at91/defconfig: enable MMC_SDHCI_OF_AT91 and MICROCHIP_PIT64B
    [v3,7/7] ARM: dts: at91: sam9x60: add device tree for soc and board


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
