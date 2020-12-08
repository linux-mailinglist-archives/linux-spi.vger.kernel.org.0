Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F04D2D2367
	for <lists+linux-spi@lfdr.de>; Tue,  8 Dec 2020 06:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgLHF5l (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Dec 2020 00:57:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:41022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726928AbgLHF5l (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Dec 2020 00:57:41 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607407020;
        bh=hQRF+IR8Rd1e14gl/xFRFZvITYh2zy5CWxQkSGQud9E=;
        h=Subject:From:Date:To:From;
        b=f9Ezg+RryUwwnzPSgpUfu+VEN0/zUqR1Jp+YQc2DBDI43b3ZkW57chLEw7VJQz08I
         SLIS0qZcujUki2QanB5waq4zZAAW75ArYXeEqHWq7lmjLjnMLguVPyv/68i8jdhyEP
         9OWHBOOW66RObnLv42SdE+4aupjkdhNlG3OI2t2UfpXAUxmKfqmFfDSLbCUJM3yUb9
         d1eawAfm7uZYbBzBmfcm10RHz66I8X1noJ3b6ghM8Ij4XzsntIoZryc3HtMNbt39zK
         r3FM1n+y2gxxltl+7i2iTHtp05T31g91OUxtwjdqXoN3HiXrbPOGBbNpdBuVbBzl4w
         L/5eYj5ARvwyg==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160740702051.30198.1136555467411404719.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 08 Dec 2020 05:57:00 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] arch: riscv: add board and SoC DT file support (2020-12-08T04:55:32)
  Superseding: [v1] arch: riscv: add board and SoC DT file support (2020-12-02T08:03:52):
    [1/4] dt-bindings: riscv: Update DT binding docs to support SiFive FU740 SoC
    [2/4] riscv: dts: add initial support for the SiFive FU740-C000 SoC
    [3/4] dt-bindings: riscv: Update YAML doc to support SiFive HiFive Unmatched board
    [4/4] riscv: dts: add initial board data for the SiFive HiFive Unmatched


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

