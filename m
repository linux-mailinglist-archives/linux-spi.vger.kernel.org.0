Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9A333CDAA
	for <lists+linux-spi@lfdr.de>; Tue, 16 Mar 2021 06:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhCPF44 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Mar 2021 01:56:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231758AbhCPF42 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Mar 2021 01:56:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0FFC6651A8;
        Tue, 16 Mar 2021 05:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615874188;
        bh=TN/Sb+Wzwf9+5MIpJ8A5SzkFpGy87MHSFkFypdVQ3Sk=;
        h=Subject:From:Date:To:From;
        b=Ih/hRJLCwQeJT6ZtJ4RK2t0yY6H9a/T6EhcQeUxpMetzixJ3DTPvHqgTZsk0oa4dN
         2gGsudJjgQaDYTSvpvX4TpTZxiTwd5zitBB4t9PSiwOEBOMcgTPXJklwnhMvnyq+xN
         wriKPEg2y69Pj9AsRDEM/myE1YKwNDQ5+7nhShmupS5prBhlmI5wVmaxwfUEjaKOXV
         g95Tz3WpLG1IS8yoj+P0GPdP6Kt17/+fjBLsqbpRcOW9W8hhtn7OzJJ1DOI0AinCVt
         MBOr4xmfvAVbJce0XfTwZ8k9Ek2FeNNb3H0HRV/wE8I9nxlgFvgDT4/PI6HXuxueFR
         wKaE1iDL9mq9A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id EBD2B60997;
        Tue, 16 Mar 2021 05:56:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161587418791.4697.528924829250582696.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 16 Mar 2021 05:56:27 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] enable flexspi support on imx8mp (2021-03-16T05:04:23)
  Superseding: [v2] enable flexspi support on imx8mp (2021-03-09T05:31:13):
    [v2,1/4] spi: fspi: enable fspi driver for on imx8mp
    [v2,2/4] dt-bindings: spi: add compatible entry for imx8mp in FlexSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

