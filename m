Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80328316477
	for <lists+linux-spi@lfdr.de>; Wed, 10 Feb 2021 11:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhBJK7V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Feb 2021 05:59:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:52614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231480AbhBJK5T (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Feb 2021 05:57:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C7C7E64E2F;
        Wed, 10 Feb 2021 10:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612954598;
        bh=jz5wGMdLbjj2MWL3g1EX5+gJF8EAeBu44ouidG79KVg=;
        h=Subject:From:Date:To:From;
        b=Tp4elxsBiPD4Kt9GY2Nz/1GfVF6tlGYmCFNV6vw9GknJnx9xLtHP1gboTZC7lwKar
         yZBtFmOF76sZ6j0yVL+uQP9wVTdLKd7YrBaRs9/RtNhz3bM1nGLen2szSFA94O/fag
         F2L8C2+WWeIJD6rWwdcQkZHl62zg/mKilIkPQ+QVVQ0k/BOMcq4ofPqh1GD1jw4rHz
         4L3FJbC43+6p82X4KQx5BR/NcgPOZqXyaF5G5IvXuO3h2elzFrPJKqAW1Q9r2uBVAz
         ePpg204dAjc9T1u92OTM0zZI/Kt+tA1oAjDRmbC6kBsBtVytx7mj4F5bG7VUCG37F7
         oYjsXL4Fd4kZw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B804D609E9;
        Wed, 10 Feb 2021 10:56:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161295459874.13735.559644952506882517.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 10 Feb 2021 10:56:38 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] dt-bindings: spi: zynq: Convert Zynq QSPI binding to yaml (2021-02-10T10:10:25)
  Superseding: [v1] dt-bindings: spi: zynq: Convert Zynq QSPI binding to yaml (2021-02-03T13:46:44):
    dt-bindings: spi: zynq: Convert Zynq QSPI binding to yaml


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

