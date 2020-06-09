Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37FA01F33E4
	for <lists+linux-spi@lfdr.de>; Tue,  9 Jun 2020 08:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgFIGAT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Jun 2020 02:00:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbgFIGAT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 9 Jun 2020 02:00:19 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591682418;
        bh=G5DipP6abBNbcRx5Alabrkoo5C348FjCdHg+db2ExDU=;
        h=Subject:From:Date:To:From;
        b=txHiOBO1sjaQez9v2R3xa1ZKp44/dS+kFZma7aUjH978CbYft/ylK5oDsQqsZpVGq
         CIts4V9Cw91LlC+HJsLvg3ofgoFSr2MEk6IGEYQC+JFR6B+jDOWzgvnxXFr9HBNCGN
         xZUNeDad3IHS3tUHvoRsxIvPCYromofKdJbg6ZPA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159168241883.27435.8573212731362396643.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 09 Jun 2020 06:00:18 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v7] Add interconnect support to QSPI and QUP drivers (2020-06-09T05:56:28)
  Superseding: [v7] Add interconnect support to QSPI and QUP drivers (2020-05-26T12:54:43):
    [V7,1/7] soc: qcom: geni: Support for ICC voting
    [V7,2/7] soc: qcom-geni-se: Add interconnect support to fix earlycon crash
    [V7,3/7] i2c: i2c-qcom-geni: Add interconnect support
    [V7,4/7] spi: spi-geni-qcom: Add interconnect support
    [V7,5/7] tty: serial: qcom_geni_serial: Add interconnect support
    [V7,6/7] spi: spi-qcom-qspi: Add interconnect support
    [V7,7/7] arm64: dts: sc7180: Add interconnect for QUP and QSPI


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
