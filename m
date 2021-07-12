Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9603C5FD9
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jul 2021 17:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhGLP71 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Jul 2021 11:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230394AbhGLP71 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 12 Jul 2021 11:59:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9C024610C7;
        Mon, 12 Jul 2021 15:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626105398;
        bh=keaN0T5vYlPOedbs5ZyBvCh8sbEc+wcDTmdycy+wkgo=;
        h=Subject:From:Date:To:From;
        b=Vty8tH7IIhZN+fl+g5PtfLRzOYX/azASVEVEMUN+hXm6jfHbe2u18OJj5KGou9/Gn
         aZ9bBtSAHUod8blLvR96tRa9A9jGbufCDwUNxW+AXL2UDL8WKrVwegiNQn5wqRwg26
         rMtmd96cZPg7UU9L3LirKtv9mJiCkgaPhPMitnf4f4jRqUanftYNjAm1kRuPzQB8qt
         2CZUmdyPOnSzQ4cdjdIutAX3jTRg188TSqdLdqofvzXE1Lqs0S+HPmARjxemEw1Knw
         zZCLNXJqNrotopo6SQjHxSCZn2jhUaFX5cPi17W3u9kqHXkSAt6UhgE0NtvcnrcCL4
         iKHZVPRAjlPMQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8F10060A0C;
        Mon, 12 Jul 2021 15:56:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162610539857.9894.3771665269205691465.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 12 Jul 2021 15:56:38 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] GE Healthcare PPD firmware upgrade driver for ACHC (2021-07-12T15:02:40)
  Superseding: [v1] GE Healthcare PPD firmware upgrade driver for ACHC (2021-06-21T17:53:55):
    [PATCHv5,1/5] spi: add ancillary device support
    [PATCHv5,2/5] spi: dt-bindings: support devices with multiple chipselects
    [PATCHv5,3/5] dt-bindings: misc: ge-achc: Convert to DT schema format
    [PATCHv5,4/5] ARM: dts: imx53-ppd: Fix ACHC entry
    [PATCHv5,5/5] misc: gehc-achc: new driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

