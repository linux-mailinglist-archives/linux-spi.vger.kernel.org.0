Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B5F39BC5A
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jun 2021 17:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhFDP6c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Jun 2021 11:58:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhFDP6c (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 4 Jun 2021 11:58:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 12C36610A0;
        Fri,  4 Jun 2021 15:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622822206;
        bh=G1b1yIe4X/kilOytUK7PtC+dGJAFI1YDihefCxWKH28=;
        h=Subject:From:Date:To:From;
        b=ZhSmcpHKlaxjTENQ1bmkqTOWFzL3JsvOV4utILwhd9sKxiHNtRWiKmA95ecLQW0oL
         ZxDxo1rHdV1sgd0zGadBL/Eje3oJQprV9NC0o0WCzd4GeFHi+5RRYs9vxWioteIwyY
         fhynODQZriAIFUc8ZSN+30c+wr+EYiwoHmlIkKbh24ab+feN2i79L4/Xgakhj1aJad
         u24HAk0aj1aJ5vOKwealkeXsrVihFBQqMjRBfWVz2ptov7UduJeAq59V0XJSDitUGd
         MHr/lZgIUn/vHNohdwQbh0qbOUKNTAh1c29wQ+dG8G91P3vX53ppHlFzr8cpkOFD3k
         KW77DgJK2NykA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0773260A39;
        Fri,  4 Jun 2021 15:56:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162282220602.5138.9957630036060656362.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 04 Jun 2021 15:56:46 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] Add Rockchip SFC(serial flash controller) support (2021-06-04T15:10:47)
  Superseding: [v3] Add Rockchip SFC(serial flash controller) support (2021-06-01T20:10:18):
    [v3,1/4] dt-bindings: rockchip-sfc: Bindings for Rockchip serial flash controller
    [v3,2/4] spi: rockchip-sfc: add rockchip serial flash controller driver
    [v3,3/4] arm64: dts: rockchip: Add SFC to PX30
    [v4,4/4] arm64: dts: rockchip: Enable SFC for Odroid Go Advance


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

