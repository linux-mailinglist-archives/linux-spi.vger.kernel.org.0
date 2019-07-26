Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4B375CE5
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jul 2019 04:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbfGZCUS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Jul 2019 22:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfGZCUS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 25 Jul 2019 22:20:18 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564107618;
        bh=3A/qv15YEBE3ppIMHrn+RWowyIFto8TguqSDykG/2+g=;
        h=Subject:From:Date:To:From;
        b=rn/4E8Gst4tQTy0TJ6IAgL5+7JVgVhk0EfFJ6u/Mck2alyqdiY+Couv+sY2FVL0hI
         GNsEsZz2yqCOftA1nOGpD+9BTZbXPhx/FGgBsbkGcD/V5MtQ++3dQz1BBkOUC7nFo7
         BltMqCS2EcyysAQ9Q/RtmLKFRE5SrqMVxcq/I224=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <156410761833.10745.17881166622609689602.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 26 Jul 2019 02:20:18 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v15] spi: Add Renesas R-Car Gen3 RPC-IF SPI driver (2019-07-26T02:42:55)
  Superseding: [v14] spi: Add Renesas R-Car Gen3 RPC-IF SPI driver (2019-06-20T09:30:44):
    [v14,1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
    [v14,2/2] dt-bindings: spi: Document Renesas R-Car Gen3 RPC-IF controller bindings


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
