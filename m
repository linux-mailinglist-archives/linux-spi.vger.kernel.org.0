Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AACC1273F9
	for <lists+linux-spi@lfdr.de>; Thu, 23 May 2019 03:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfEWB2u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 May 2019 21:28:50 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19521 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEWB2u (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 May 2019 21:28:50 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce5f74d0000>; Wed, 22 May 2019 18:28:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 22 May 2019 18:28:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 22 May 2019 18:28:49 -0700
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 May
 2019 01:28:49 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 23 May 2019 01:28:49 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.170.210]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ce5f74f0006>; Wed, 22 May 2019 18:28:48 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <broonie@kernel.org>,
        <natechancellor@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1 00/12] LP0 entry and exit support for Tegra210
Date:   Wed, 22 May 2019 18:28:29 -0700
Message-ID: <1558574922-16531-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558574925; bh=XkrgQWPSdSys4sY6++u5MjM3R5kQ9ZrMn6kdxayE2Cw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=O5GbkgIDNZUXU4Msp9o4s6piJJSGEQwm0kjrS3Haye3FNkSU/Ao0cDViMLj88uRyd
         0Fj4Q+mOdXTGA2hxEC4h9g7MWMySzse1VQNPT5RS5kpR2q6taB+1wHyk9GcudqqMpO
         9TchfANyfb+jmeY7wwB5gSkF5q1Q5R/qaF7CzoVj0VJgrQZloQZBQ6duae69psSCrl
         N0xVsqrqykOrvlM9Zv7J/I4x5OPhxDiE9KbZouanoCSZ45UT6eXSPIc430GlzQhFWs
         cNbFucPnfofGfByBlWcmEOzKQcWsRV8B+ogt0XtPyqKAomM0Bj8Bxtb74p/0xX1UWn
         alGb5sUIyQYEQ==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch series includes Tegra210 deepsleep or LP0 support with
deep sleep exit through RTC alarm wake and power button wake events.

This series also includes save and restore of PLLs, clocks, OSC contexts
for basic LP0 exit.

This patch series is doesn't support for 100% suspend/resume to fully
functional state and we are working on some more drivers suspend and
resume implementations.

Sowjanya Komatineni (12):
  irqchip: tegra: do not disable COP IRQ during suspend
  pinctrl: tegra: add suspend and resume support
  clk: tegra: save and restore PLLs state for system
  clk: tegra: add support for peripheral clock suspend and resume
  clk: tegra: add support for OSC clock resume
  clk: tegra: add suspend resume support for DFLL clock
  clk: tegra: support for Tegra210 clocks suspend-resume
  soc/tegra: pmc: allow support for more tegra wake models
  soc/tegra: pmc: add pmc wake support for tegra210
  gpio: tegra: implement wake event support for Tegra210 and prior GPIO
  soc/tegra: pmc: configure tegra deep sleep control settings
  arm64: tegra: enable wake from deep sleep on RTC alarm.

 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi |   7 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi       |   5 +-
 drivers/clk/tegra/clk-dfll.c                   |  82 ++++++
 drivers/clk/tegra/clk-dfll.h                   |   2 +
 drivers/clk/tegra/clk-divider.c                |  19 ++
 drivers/clk/tegra/clk-pll-out.c                |  25 ++
 drivers/clk/tegra/clk-pll.c                    | 220 ++++++++++++--
 drivers/clk/tegra/clk-tegra-fixed.c            |  15 +
 drivers/clk/tegra/clk-tegra210.c               | 382 +++++++++++++++++++++++++
 drivers/clk/tegra/clk.c                        |  74 ++++-
 drivers/clk/tegra/clk.h                        |  18 ++
 drivers/gpio/gpio-tegra.c                      | 109 ++++++-
 drivers/irqchip/irq-tegra.c                    |  10 +-
 drivers/pinctrl/tegra/pinctrl-tegra.c          |  68 ++++-
 drivers/pinctrl/tegra/pinctrl-tegra.h          |   3 +
 drivers/pinctrl/tegra/pinctrl-tegra114.c       |   1 +
 drivers/pinctrl/tegra/pinctrl-tegra124.c       |   1 +
 drivers/pinctrl/tegra/pinctrl-tegra20.c        |   1 +
 drivers/pinctrl/tegra/pinctrl-tegra210.c       |   1 +
 drivers/pinctrl/tegra/pinctrl-tegra30.c        |   1 +
 drivers/soc/tegra/pmc.c                        | 159 +++++++++-
 21 files changed, 1167 insertions(+), 36 deletions(-)

-- 
2.7.4

