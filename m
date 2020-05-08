Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA28F1CA457
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 08:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgEHGlN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 02:41:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgEHGkP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 May 2020 02:40:15 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588920014;
        bh=mexFV2cJJf339HOMyCMboTrtQGZ06LeD5ppmoMTtesc=;
        h=Subject:From:Date:To:From;
        b=SsceZSdqHVgFOQbRGxB67bUYx2BhwuinObSeviabtVzcYsAmK10pZWv0m56IOPoXS
         uNdw+PzKDa3iIpm0t4+M1oZHkJmlPWA0vCjlA7trUjz/GBVC59t1mSbkf2aa/Gt3rm
         Y/UfWqmHELaKlSG1yezTPcYVHXaCLiiPwztjdCVE=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158892001487.31787.11766267547401074991.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 08 May 2020 06:40:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] Add interconnect support to QSPI and QUP drivers (2020-05-08T06:33:34)
  Superseding: [v4] Add interconnect support to QSPI and QUP drivers (2020-04-15T10:23:12):
    [V4,1/9] interconnect: Add devm_of_icc_get() as exported API for users
    [V4,2/9] interconnect: Set peak requirement as twice of average
    [V4,3/9] soc: qcom: geni: Support for ICC voting
    [V4,4/9] soc: qcom-geni-se: Add interconnect support to fix earlycon crash
    [V4,5/9] i2c: i2c-qcom-geni: Add interconnect support
    [V4,6/9] spi: spi-geni-qcom: Add interconnect support
    [V4,7/9] tty: serial: qcom_geni_serial: Add interconnect support
    [V4,8/9] spi: spi-qcom-qspi: Add interconnect support
    [V4,9/9] arm64: dts: sc7180: Add interconnect for QUP and QSPI


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
