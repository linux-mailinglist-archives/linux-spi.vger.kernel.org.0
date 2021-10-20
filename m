Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC012434590
	for <lists+linux-spi@lfdr.de>; Wed, 20 Oct 2021 08:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhJTG7N (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Oct 2021 02:59:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229741AbhJTG7M (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 20 Oct 2021 02:59:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0D7CC610CB;
        Wed, 20 Oct 2021 06:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634713019;
        bh=ekm3j5h1A5tbAb+UTNahh95LjfLt8/gC0NjoC/kOD5k=;
        h=Subject:From:Date:To:From;
        b=mh6laBHVJf1KbG/IchNVAnVyu3X8u3Gx44eFmBxFCe/UevtIglqHmLS7SG7TRXfz2
         EKZleItkW3kG3kF6+d2o40H2sLy3lSoBG2yVpq10bPXCwwh3g0GyTY3oOtSDJE52uv
         rH+EBIrj44lN5VQAn04ElX/bF3YRu/iNomoi8FG1BVn171s6jNlhj5rV6axbiOMDu0
         IPrInKmKaVVQsDFadxk0vp8E7qU+Hq0njGivuajOGNnBCrhRfnbx/GasBV4+gyR8QQ
         ftouSOWcdeEVnBPXCxvoMUIUvoYtWurfiSciL4Ulhvc2+23LHVOkM1qO28dWSmND8+
         6mHXcxI8IwHoA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 018E5609D7;
        Wed, 20 Oct 2021 06:56:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163471301899.28223.4937640507708217992.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 20 Oct 2021 06:56:58 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] spi: spi-geni-qcom: Add support for GPI dma (2021-10-20T06:09:54)
  Superseding: [v4] spi: spi-geni-qcom: Add support for GPI dma (2021-10-19T06:01:35):
    [v4] spi: spi-geni-qcom: Add support for GPI dma


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

