Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097703C755E
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 18:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbhGMQ7a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 12:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229987AbhGMQ73 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Jul 2021 12:59:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B9C08610C7;
        Tue, 13 Jul 2021 16:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626195399;
        bh=HXpAfjOvD7TuecJtN8LbQvg11mxTjpvQ6xSfl9F1kLg=;
        h=Subject:From:Date:To:From;
        b=ImWD0bLRcgDoIBMCDf3bDuhVyOSG44kGIoPFFAIPOIY7YH4in4ZtRmi3goCF++VXU
         y7IMUP2al2JEtiBT+Wor7utQQHKRfSTdD9ONSAOI+w7HCKqXe80fWwfuyoPPvkkiMw
         +hfkJpvvylXtSh9mnyvIkQThdl45lY/pTlss2xjxqd5SDPkCzQKCMUJLA1TacQLknU
         FvAvItb4Od38s7uC06V7Z5rPhpdvjD7LGH/GmmycOUQqD05FcWECISn1PotWXKPQhf
         MlPQ2XEnUktP64kaPUmOnrVIa5EFMDV1kJbPCjFhYuZqnTFXE7sufvUp0xRK5LCBI4
         tij75C3gR2SkQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id ACD1D60A0C;
        Tue, 13 Jul 2021 16:56:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162619539970.10480.13615738174180999968.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 13 Jul 2021 16:56:39 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] GE Healthcare PPD firmware upgrade driver for ACHC (2021-07-13T16:35:28)
  Superseding: [v1] GE Healthcare PPD firmware upgrade driver for ACHC (2021-07-12T15:02:40):
    [PATCHv6,1/3] dt-bindings: misc: ge-achc: Convert to DT schema format
    [PATCHv6,2/3] ARM: dts: imx53-ppd: Fix ACHC entry
    [PATCHv6,3/3] misc: gehc-achc: new driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

