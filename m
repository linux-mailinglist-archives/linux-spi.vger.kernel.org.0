Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445F41E843B
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 19:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgE2RAO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 13:00:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgE2RAN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 May 2020 13:00:13 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590771613;
        bh=fUOqwYWT8tbTuMzPYDcpQ0z+8oF3oaSsv0YL/KNeZA4=;
        h=Subject:From:Date:To:From;
        b=D8Y2XWdgRJJ/YH0Xmzz73ev5VwSOQAvuOiOFWsJMQnqEW42imeZyKZ+G4zt8vTXNx
         JFivT5B4b5gLnRAK8P4Ut5083eYqgLKdeN2Y3BxlfM7W/B0+f1/pnETrjdyDCP6V5i
         VPfujfJ0PViKSUyvNa6kZ0s+9lTto/CcYuPXhJBE=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159077161358.32365.3498519012737469282.git-patchwork-summary@kernel.org>
Date:   Fri, 29 May 2020 17:00:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: [PATCHv4,1/2] spi: dw: add reset control
  Submitter: Dinh Nguyen <dinguyen@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=295785
  Link: <20200529155806.16758-1-dinguyen@kernel.org>
    Patches: [PATCHv4,1/2] spi: dw: add reset control
             [PATCHv4,2/2] dt-bindings: snps,dw-apb-ssi: add optional reset property

Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
