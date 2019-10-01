Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3BC4C33CE
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 14:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387624AbfJAMFY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 08:05:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbfJAMFY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 1 Oct 2019 08:05:24 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569931523;
        bh=/tJE0YMbD/P9egKECXUH6cYPBO5VcG5h6LQw1lkmlQI=;
        h=Subject:From:Date:References:To:From;
        b=0wN8XZ46jZTh5O2GW1RR9+sKE2MZJLkqWj50jY4ChTLBM25OWInXEY8BJmwo2xCe1
         b51IXi10odWoAWGXSwf9lgq+NgV/ZRi9seTCCrnL/grAs79CZYMk5nQzjYM5RGd0Vv
         vQeetjfxmUu5Y1XY3ATZmoG2RzfQkVwqWJ4f7FJ8=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <156993152378.9547.16467324246693247687.git-patchwork-summary@kernel.org>
Date:   Tue, 01 Oct 2019 12:05:23 +0000
References: <20190801083105.30102-1-chuanhua.han@nxp.com>
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: [1/3] dt-bindings: fsl: dspi: Add fsl,ls1088a-dspi compatible string
  Submitter: Chuanhua Han <chuanhua.han@nxp.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=153941
    Patches: [1/3] dt-bindings: fsl: dspi: Add fsl,ls1088a-dspi compatible string
             [2/3] arm64: dts: ls1088a: Add the DSPI controller node
             [3/3] arm64: dts: ls1088a-qds: Add the spi-flash nodes under the DSPI controller

Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
