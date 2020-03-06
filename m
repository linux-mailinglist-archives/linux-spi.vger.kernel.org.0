Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF06117B8D6
	for <lists+linux-spi@lfdr.de>; Fri,  6 Mar 2020 10:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgCFJAO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Mar 2020 04:00:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:52040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbgCFJAO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 6 Mar 2020 04:00:14 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583485214;
        bh=kRt3YSeB6l06pC6Vrbg03Nadd95Dyvxg8uEp9RSUf3U=;
        h=Subject:From:Date:To:From;
        b=CastPPGksI8ADDi4b37vH/XblAOTD/PotZkG2kaPH9ZAqcwaagOltput+T7kHPqrK
         lZOnV+dZAFexWQjArD42ewfnVOc2gMJMyQ9kDIwLJK90t7YLoDn00b5MWKOeqBYvaT
         CnILk13gnTj0N9EVfh6hz78Yg4Gcz8XsaWQxmAfY=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158348521423.9652.5376474463563956601.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 06 Mar 2020 09:00:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] rewrite mtk-quadspi spi-nor driver with spi-mem (2020-03-06T08:50:48)
  Superseding: [v2] rewrite mtk-quadspi spi-nor driver with spi-mem (2020-02-28T04:36:32):
    [v2,1/4] spi: make spi-max-frequency optional
    [v2,2/4] spi: add support for mediatek spi-nor controller
    [v2,3/4] dt-bindings: convert mtk-quadspi binding doc for spi-mtk-nor
    [v2,4/4] mtd: spi-nor: remove mtk-quadspi driver

Latest series: [v3] spi: dt-bindings: spi-controller: Slave mode fixes (2020-03-06T08:50:36)
  Superseding: [v2] spi: dt-bindings: spi-controller: Slave mode fixes (2020-03-03T09:45:20):
    [v2,1/2] spi: dt-bindings: spi-controller: Fix #address-cells for slave mode
    [v2,2/2] spi: dt-bindings: spi-controller: Fix spi-[rt]x-bus-width for slave mode


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
