Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1386C19953B
	for <lists+linux-spi@lfdr.de>; Tue, 31 Mar 2020 13:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbgCaLUP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 31 Mar 2020 07:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729925AbgCaLUP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 31 Mar 2020 07:20:15 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585653614;
        bh=nvi/J9PtuTO4SS237fF6F9cx+jPe7DvZzPXDPeWodmY=;
        h=Subject:From:Date:To:From;
        b=fccjrsMXpTD90k1QEGtmtjVy6ciVJcFyUdkmKAbOHX1AJRV6dFc9uK5eqJd/jUo9S
         rDghEKnJnWfC4M895690YylGh/zjLGREA2xK/nDlSQhOkovg6vtZ+33kAmIA323Pu3
         g/N/ZixC4H+7/5yTJmfCl4xZJ9q8uz04pi+U6cqE=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158565361460.4203.16473116986967110594.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 31 Mar 2020 11:20:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Add interconnect support to QSPI and QUP drivers (2020-03-31T11:09:28)
  Superseding: [v2] Add interconnect support to QSPI and QUP drivers (2020-03-13T13:12:06):
    [V2,1/8] interconnect: Add devm_of_icc_get() as exported API for users
    [V2,2/8] soc: qcom: geni: Support for ICC voting
    [V2,3/8] soc: qcom-geni-se: Add interconnect support to fix earlycon crash
    [V2,4/8] tty: serial: qcom_geni_serial: Add interconnect support
    [V2,5/8] i2c: i2c-qcom-geni: Add interconnect support
    [V2,6/8] spi: spi-geni-qcom: Add interconnect support
    [V2,7/8] spi: spi-qcom-qspi: Add interconnect support
    [V2,8/8] arm64: dts: sc7180: Add interconnect for QUP and QSPI


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
