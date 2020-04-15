Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105C21A9BCB
	for <lists+linux-spi@lfdr.de>; Wed, 15 Apr 2020 13:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393933AbgDOLJ3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Apr 2020 07:09:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393930AbgDOLJU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 15 Apr 2020 07:09:20 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586948413;
        bh=8BhWlFaMt3Ruv03hhLTEAK/UrEfE/a2RlK6Yv8PRiqQ=;
        h=Subject:From:Date:To:From;
        b=IeZaXud3xs3w585Z4r29GqcioDgdDVGiLC1FVQnlxfZ1cpkW2ymwJH+ekSPlhPwXK
         BF6TCVQxHMBN/g7khbankri/zVrRk2FxHmUHgjOwp2Y5Jx6baf/L70ENoUQ8tIXj5q
         Xy6WG/NOH42nu8finsoK0J/h/tTGww6YkYkjasug=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158694841320.26276.8539319623227981518.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 15 Apr 2020 11:00:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] Add interconnect support to QSPI and QUP drivers (2020-04-15T10:23:12)
  Superseding: [v3] Add interconnect support to QSPI and QUP drivers (2020-03-31T11:09:28):
    [V3,1/8] interconnect: Add devm_of_icc_get() as exported API for users
    [V3,2/8] soc: qcom: geni: Support for ICC voting
    [V3,3/8] soc: qcom-geni-se: Add interconnect support to fix earlycon crash
    [V3,4/8] i2c: i2c-qcom-geni: Add interconnect support
    [V3,5/8] spi: spi-geni-qcom: Add interconnect support
    [V3,6/8] tty: serial: qcom_geni_serial: Add interconnect support
    [V3,7/8] spi: spi-qcom-qspi: Add interconnect support
    [V3,8/8] arm64: dts: sc7180: Add interconnect for QUP and QSPI


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
