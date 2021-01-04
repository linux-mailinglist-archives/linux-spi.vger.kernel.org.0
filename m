Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A7D2E97D0
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 15:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbhADO5R (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 09:57:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:51356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727255AbhADO5Q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 Jan 2021 09:57:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 41D2222211;
        Mon,  4 Jan 2021 14:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609772196;
        bh=K5rZC5d/xA4ul2zn4jBEhAERIBnlz6Q9l1FLc1EmSSc=;
        h=Subject:From:Date:To:From;
        b=i4/LUSJbgbvjkUuCfE/iNYKR0/DCNKO0vzNmiLKpJEz1d/VmmChk6lWnzkjKclx9i
         cvSQSOg1nQmllsKFbpkN+oO9VfY6UXq2P3tJ04fa5pmao279RpeXaCqYMvzhEcvg9p
         NNPTU7m1Krk3ecYq5lv+OR/+n49xecQ4vW6XH5OaCKJQh4yfUq1ofaXkwfmw0PKBQ4
         WG7G1DYvuAHaLydRFCNbIy+pzRYqEtnCzqLC/ah/hi68IlxSkD37YURkZ74MoCunHF
         PBYKVTVfk2eStx5dMJDc6eb3YlgDqxRLZ6q0s0a6jNA4eRnVxCz6InqFH5vGYTdsMj
         Qd+SugahtTvpA==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 32D996011A;
        Mon,  4 Jan 2021 14:56:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160977219614.28084.9373904950629964851.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 04 Jan 2021 14:56:36 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: stm32: update dev_dbg() print format for SPI params (2021-01-04T14:31:03)
  Superseding: [v1] spi: stm32: update dev_dbg() print format for SPI params (2021-01-04T08:59:23):
    spi: stm32: update dev_dbg() print format for SPI params


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

