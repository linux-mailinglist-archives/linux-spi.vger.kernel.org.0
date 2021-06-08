Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B584D39EE71
	for <lists+linux-spi@lfdr.de>; Tue,  8 Jun 2021 07:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhFHF6q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Jun 2021 01:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhFHF6q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Jun 2021 01:58:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2ADE360241;
        Tue,  8 Jun 2021 05:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623131814;
        bh=AvjGZw/z08iCUl7+EQK9O4IkaGtnVTlXX7NwRfOP/vY=;
        h=Subject:From:Date:To:From;
        b=YBcH5QcU1EqogFev9PuUop9V+kAIHL8Hx5kh/7GFrGFa4OeBMmFA2KC5vaDqui0St
         LuOBTZbceek40+hRP7LoB5Icl7BfDwq0ArCO8BBkPc5lVODowiDhcI/9CO7wYEQd46
         DyUw7Hc3o3N79zq8Ls80shDYjhogL5OwXGRhpyOuvWE5YmHqwpIDMu++1GBZyc4+QS
         Lg9NxifcS2f5sOFbhP9x/URekVbKqQo1kRh4dWyYwweTriMuFiSnfZPYJ0KOtSTJoC
         G5GkeuO2SIQxuoRy9spmep4Jwr6vc8XGYqqDfN8Dvw3g8XNqnBzQQK6tETU7u1qcV4
         /thq/kADr9kww==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1FEFA60A0C;
        Tue,  8 Jun 2021 05:56:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162313181412.31712.5524415507444647817.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 08 Jun 2021 05:56:54 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] dt-bindings: spi: omap-spi: Convert to json-schema (2021-06-08T05:20:09)
  Superseding: [v1] dt-bindings: spi: omap-spi: Convert to json-schema (2021-06-02T12:34:10):
    [1/5] ARM: dts: am335x: align ti,pindir-d0-out-d1-in property with dt-shema
    [2/5] ARM: dts: am437x: align ti,pindir-d0-out-d1-in property with dt-shema
    [3/5] arm64: dts: ti: am65: align ti,pindir-d0-out-d1-in property with dt-shema
    [4/5] arm64: dts: ti: k3-am642-evm: align ti,pindir-d0-out-d1-in property with dt-shema
    [5/5] dt-bindings: spi: omap-spi: Convert to json-schema


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

