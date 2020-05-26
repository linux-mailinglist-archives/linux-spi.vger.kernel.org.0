Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576161E2296
	for <lists+linux-spi@lfdr.de>; Tue, 26 May 2020 15:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389342AbgEZNAR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 May 2020 09:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389328AbgEZNAR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 26 May 2020 09:00:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590498016;
        bh=cgtOg7LRb7mHQVQ0w8JrChyqL9xUacXAwRK8lw4EMOk=;
        h=Subject:From:Date:To:From;
        b=GH6EgMW0jTU0RadjtTJyh2ZyQIeecrE724swCPl7J8K3uz3Pyyh1bnJUu/tksTqUG
         QmvextZ7ZQMmp/W7yavbEdAXJiPLpSRRfSEKhlhFOFYa30PTaEmPgCWCxnJ52notTc
         55+RbSTkL8km6lQCmLfER0o4PGBBEdbe3vaq+YD8=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159049801681.12076.9122781115765490183.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 26 May 2020 13:00:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v7] Add interconnect support to QSPI and QUP drivers (2020-05-26T12:54:43)
  Superseding: [v6] Add interconnect support to QSPI and QUP drivers (2020-05-21T08:29:17):
    [V6,1/7] soc: qcom: geni: Support for ICC voting
    [V6,2/7] soc: qcom-geni-se: Add interconnect support to fix earlycon crash
    [V6,3/7] i2c: i2c-qcom-geni: Add interconnect support
    [V6,4/7] spi: spi-geni-qcom: Add interconnect support
    [V6,5/7] tty: serial: qcom_geni_serial: Add interconnect support
    [V6,6/7] spi: spi-qcom-qspi: Add interconnect support
    [V6,7/7] arm64: dts: sc7180: Add interconnect for QUP and QSPI


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
