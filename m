Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3358E3B72B9
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jun 2021 14:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbhF2M7O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Jun 2021 08:59:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234028AbhF2M7M (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 29 Jun 2021 08:59:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 13AB461D1C;
        Tue, 29 Jun 2021 12:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624971405;
        bh=TM30FmUYPGU5GECNncnaUo8Qqr6Yh5mcrutSD7qBJr8=;
        h=Subject:From:Date:To:From;
        b=Wry7xUQyxJFe0cxftzZBfJl2Ax2EuXxBwFDVV5Qeo1Wm2calR7hMMAOtq5WY2OiuG
         jsezkXJESqeuDaNYclv8WzyjQh/0nrHhesMDb4TMvGhDlR5OzUUWIwOWIe2Rm6ckxj
         IT2S50eFDPfulUHxZaFtbhG0LAyypCH3LS8+GnuxM6nmU6mCrwvjkr3nCu7AzO+NCp
         n7hDwDWYztqC+OCYQGOPgk+qHnLRQudhWGbEw+bc2utja8G/AOck0WOQ00Z0rGaISZ
         BBrR2BljInrfAQLNlHO8XYOQyA6TUmSCEg59O5kifRuVfh1Y/yU7TLEBu9IIU+UblD
         Kq33hiJoRqa+Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 069F0609A3;
        Tue, 29 Jun 2021 12:56:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162497140501.8694.10918913408825667640.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 29 Jun 2021 12:56:45 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] fpga/mfd/hwmon: Initial support for Silicom N5010 PAC (2021-06-29T12:12:10)
  Superseding: [v2] fpga/mfd/hwmon: Initial support for Silicom N5010 PAC (2021-06-25T07:42:08):
    [v2,1/5] fpga: dfl: pci: add device IDs for Silicom N501x PAC cards
    [v2,2/5] fpga: dfl: expose feature revision from struct dfl_device
    [v2,3/5] spi: spi-altera-dfl: support n5010 feature revision
    [v2,4/5] mfd: intel-m10-bmc: add n5010 variant
    [v2,5/5] hwmon: intel-m10-bmc-hwmon: add n5010 sensors


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

