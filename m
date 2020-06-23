Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB31205090
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jun 2020 13:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbgFWLUS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Jun 2020 07:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732191AbgFWLUS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Jun 2020 07:20:18 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592911218;
        bh=JdEuzOoBQSy0ATgysr8+rqhSBqYK/E54N9+5zET2IsA=;
        h=Subject:From:Date:To:From;
        b=aVw4xVvzyr4hIZB8MwR+HZzxjZpwMR5uZwm77EpXb/AusHpk8lucRyVf+ktUrmyXl
         RQMp3Upiigcz55wm/nZt/b8ZMHRbngp2ToHTJ1xksLMpJeQQoIeIzH3hCqpnqif1hB
         iekQ/Is6LP+yscSg0mUX14fB5FkSslau95zzM2Oo=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159291121821.16548.16574241212048039575.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 23 Jun 2020 11:20:18 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v8] Add interconnect support to QSPI and QUP drivers (2020-06-23T10:38:50)
  Superseding: [v7] Add interconnect support to QSPI and QUP drivers (2020-06-09T05:56:28):
    [V7,RESEND,1/7] soc: qcom: geni: Support for ICC voting
    [V7,RESEND,2/7] soc: qcom-geni-se: Add interconnect support to fix earlycon crash
    [V7,RESEND,3/7] i2c: i2c-qcom-geni: Add interconnect support
    [V7,RESEND,4/7] spi: spi-geni-qcom: Add interconnect support
    [V7,RESEND,5/7] tty: serial: qcom_geni_serial: Add interconnect support
    [V7,RESEND,6/7] spi: spi-qcom-qspi: Add interconnect support
    [V7,RESEND,7/7] arm64: dts: sc7180: Add interconnect for QUP and QSPI


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
