Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBBFE14C6FF
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jan 2020 08:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgA2HkK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jan 2020 02:40:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:45546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbgA2HkK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 29 Jan 2020 02:40:10 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580283609;
        bh=Nl3cuig++QBe7UfbH2LWZIZpNZN6cCefQTfSSvYtvkI=;
        h=Subject:From:Date:To:From;
        b=SJggalImkO8Z45twoA0TDkbzvk/c0dS6PG6JZUTwd6sYClSWuIFL0E4LQkxgdRbW7
         Kjo/V5UI5eq597xFsHwkkK3juYgalLbVS6skzdg9kH/5Espw6V9sgxPaGk6MYYgcjk
         ECHMfb1/nM83+G+5sglNDtNVrjo+gy1nTCEPcNwg=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158028360985.15732.6417676112663715208.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 29 Jan 2020 07:40:09 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v8] spi: cadence-quadpsi: Add support for the Cadence QSPI controller (2020-01-29T07:24:55)
  Superseding: [v7] spi: cadence-quadpsi: Add support for the Cadence QSPI controller (2020-01-22T09:18:07):
    [v7,1/2] dt-bindings: spi: Add schema for Cadence QSPI Controller driver
    [v7,2/2] spi: cadence-quadpsi: Add support for the Cadence QSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
