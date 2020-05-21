Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA8E1DC8DC
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 10:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgEUIkP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 04:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbgEUIkP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 May 2020 04:40:15 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590050415;
        bh=c2j5u/ahJg2OZIca1zc/el/3OOGJtTXiDphwlsk1d1I=;
        h=Subject:From:Date:To:From;
        b=gTMnz2+g12YE7dKzAzVRylh4c5gtbfOitYy9kwEFfUgPGs+Ta1Pre5oHLdNmm+0nR
         gJsoUqxm66CqakdUaw2MnrGYH6A2eV0WGi9Z6QhqnmNJvww4pW5nVGEBFpiRdWNSuM
         /H8O1RDAACzbutLGFQ4enqW+zAxiFqHc1XH/IFF4=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159005041540.23548.15953907221256798496.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 21 May 2020 08:40:15 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] Add interconnect support to QSPI and QUP drivers (2020-05-21T08:29:17)
  Superseding: [v5] Add interconnect support to QSPI and QUP drivers (2020-05-08T06:33:34):
    [V5,1/7] soc: qcom: geni: Support for ICC voting
    [V5,2/7] soc: qcom-geni-se: Add interconnect support to fix earlycon crash
    [V5,3/7] i2c: i2c-qcom-geni: Add interconnect support
    [V5,4/7] spi: spi-geni-qcom: Add interconnect support
    [V5,5/7] tty: serial: qcom_geni_serial: Add interconnect support
    [V5,6/7] spi: spi-qcom-qspi: Add interconnect support
    [V5,7/7] arm64: dts: sc7180: Add interconnect for QUP and QSPI


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
