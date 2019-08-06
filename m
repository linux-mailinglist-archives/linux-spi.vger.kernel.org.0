Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24843829B2
	for <lists+linux-spi@lfdr.de>; Tue,  6 Aug 2019 04:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbfHFCkH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 5 Aug 2019 22:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbfHFCkH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 5 Aug 2019 22:40:07 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565059207;
        bh=zQBa95qwOYuLDW7RsaYKaAOnJNVe9PEZp/b3swvnH2g=;
        h=Subject:From:Date:To:From;
        b=sDemZw5hc3FPdo8h9uGgZNlylu0fqd69zIJXHRnD2dcL/+uUox8s6h8vnAgUZIYK1
         OyUl5yFpTE0N6TizDdnSMR46r23aKyqiTlMYXRvJzgy6cip6BC39pFEVBDLSBSomcK
         gDa+8zvL5MDvELX9OcKcCL6sZUP1TaPf0HrAsjLI=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <156505920696.25307.2501906173012342304.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 06 Aug 2019 02:40:06 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v17] spi: Add Renesas R-Car Gen3 RPC-IF SPI driver (2019-08-06T02:54:19)
  Superseding: [v16] spi: Add Renesas R-Car Gen3 RPC-IF SPI driver (2019-07-31T02:14:16):
    [v16,1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
    [v16,2/2] dt-bindings: spi: Document Renesas R-Car Gen3 RPC-IF controller bindings


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
