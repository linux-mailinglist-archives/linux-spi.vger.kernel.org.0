Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E163DDEC9
	for <lists+linux-spi@lfdr.de>; Mon,  2 Aug 2021 19:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhHBR46 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Aug 2021 13:56:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhHBR45 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 2 Aug 2021 13:56:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1CA3860D07;
        Mon,  2 Aug 2021 17:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627927008;
        bh=8CA72VexYIRkydx3E65vYgAlWGlwc7xqOHu31MNpamo=;
        h=Subject:From:Date:To:From;
        b=u/KLqw9OdFqdIRfzHAzsoite+73BbWrZEM5wiqTqtuPXR1MaUW9zj2hj04py6pFln
         YwxxMqjIQEnjGdqRsO1695U8JBb374KlFNExXXGv+Sbncd9cyW16J1cDY3t3jgGabO
         gACw3phUn0CHT5isFsPCdVfjj2EJ8ViZdmLK+mVLm1m+P5GqzOsLYfvDGOlu6u35b7
         8SAHVqoYzyaK+LSTGd6vHgmkKl1vM5lU23bYlMrYCFIbD8ZriH1baZ4JzcUbrm+Wfv
         KzwKchGBfpYpX3plkwDrDt2otJ6inO5G2RXZHhTVXDq/HiHzRdsOjU1kuIKYqaJseL
         ktl+aVWP2jAMA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1571260A2F;
        Mon,  2 Aug 2021 17:56:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162792700807.22634.7041659670771730574.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 02 Aug 2021 17:56:48 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] GE Healthcare PPD firmware upgrade driver for ACHC (2021-08-02T17:23:08)
  Superseding: [v1] GE Healthcare PPD firmware upgrade driver for ACHC (2021-07-13T16:35:28):
    [PATCHv7,1/3] dt-bindings: misc: ge-achc: Convert to DT schema format
    [PATCHv7,2/3] ARM: dts: imx53-ppd: Fix ACHC entry
    [PATCHv7,3/3] misc: gehc-achc: new driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

