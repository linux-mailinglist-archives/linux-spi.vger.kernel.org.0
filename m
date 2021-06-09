Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7F93A1A3F
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jun 2021 17:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhFIP6u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Jun 2021 11:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230311AbhFIP6u (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 9 Jun 2021 11:58:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B78EC61278;
        Wed,  9 Jun 2021 15:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623254215;
        bh=CcHCWRHVjPFrhA1KHVD2K1K++Gkavhm18Hn8EXirvNw=;
        h=Subject:From:Date:To:From;
        b=FjKpNVjZAXFhwS8gr4OcaGVH+FfVxKthMocLicg2bRpQY6PSov4neZYeXRjUrvsjv
         an18rg30ZomiTi2D4eQw1koRPfCLKPf5uR2RnPAG1xOuc6bXgroj11hJelrxuoqS4Q
         g+STRG24e29B1P7rYIAVYvgQKL+gbTnEwLN0tsNK5a1RQV1CSO8wrrWSnE289IKRVs
         LkWCbLhx3hKNFRGDGNjT+h1/ArO+aARjJP4tCeLoUbo4b2a6teD0JdnAPc1ZyAm33t
         pF99+ApDmSAL8Aj4C4ts4VxXADIJnTroVg2YQE7aN5+bNhO8bHwCT3WeepF0xHEN40
         vJ8FGnkZQ6h3A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id ABC3160A0E;
        Wed,  9 Jun 2021 15:56:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162325421569.4859.10848722132541100849.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 09 Jun 2021 15:56:55 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] GE Healthcare PPD firmware upgrade driver for ACHC (2021-06-09T15:12:30)
  Superseding: [v1] GE Healthcare PPD firmware upgrade driver for ACHC (2021-05-28T11:33:43):
    [PATCHv3,1/5] spi: add ancillary device support
    [PATCHv3,2/5] spi: dt-bindings: support devices with multiple chipselects
    [PATCHv3,3/5] dt-bindings: misc: ge-achc: Convert to DT schema format
    [PATCHv3,4/5] ARM: dts: imx53-ppd: Fix ACHC entry
    [PATCHv3,5/5] misc: gehc-achc: new driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

