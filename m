Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51D427B7E0
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jul 2019 04:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfGaCAI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Jul 2019 22:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727636AbfGaCAI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 30 Jul 2019 22:00:08 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564538407;
        bh=f1jqnWTXy1JwzCir1d9P/llZFzP4OVNT/A630lvdxs0=;
        h=Subject:From:Date:To:From;
        b=JKGh3fMP27vnkkpRA+eEuVeTQqkG2ss1RtNi4smmqmPupiZWviNATzOE8iaG30RVe
         xNckPUWETiPyD0xig3SqzD4ZCphvQj9/ZS9coBt8qi40iVbAdjkL3ORDsuHSAsfuCQ
         RzgTKJzvxhFNGmPILVB1enuFWCS03d54nlP10EZ8=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <156453840769.10902.11405811118753334656.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 31 Jul 2019 02:00:07 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v16] spi: Add Renesas R-Car Gen3 RPC-IF SPI driver (2019-07-31T02:14:16)
  Superseding: [v15] spi: Add Renesas R-Car Gen3 RPC-IF SPI driver (2019-07-26T02:42:55):
    [v15,1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
    [v15,2/2] dt-bindings: spi: Document Renesas R-Car Gen3 RPC-IF controller bindings


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
