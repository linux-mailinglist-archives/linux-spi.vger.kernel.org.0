Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF414707EB
	for <lists+linux-spi@lfdr.de>; Fri, 10 Dec 2021 18:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241679AbhLJSAm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Dec 2021 13:00:42 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57630 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbhLJSAl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Dec 2021 13:00:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7AB78CE2C76
        for <linux-spi@vger.kernel.org>; Fri, 10 Dec 2021 17:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC66BC00446;
        Fri, 10 Dec 2021 17:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639159023;
        bh=lVImYuWY99TEDugDtxM1b1FebLXMQNqMdiYATGxFVW8=;
        h=Subject:From:Date:To:From;
        b=em1yjjvB3WAfvfxI4j+wJsgrJp+hKeBiwK+1tu+Z76Gl7a8EehKVwG0B6Hh6f9nQW
         JeYXXJMgHMwtReZeLzbteoZUkhCVsU3UwjGw+HQFcgmaNFmYNFmXVqz6smdKx6C13G
         JrvGyq38HSmksfUXbQoBfxIux/UxbBsmNpvVVpeKzce3OMeRzOQa+dBRlisBWaK6mC
         ySsXcPigGLrht+LX4ipdo164gW6TIIoUOL10uVUqdsWoIEJw+ql5ga8ZnWN2ubcKBI
         CmubHDn7MdXF270TMkhaZBG48mEtb3RiMCIcHin7CH+4DTqlK9Hse0wY04MzjLskWv
         rzpH94F9PpQfQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 84D7E60A37;
        Fri, 10 Dec 2021 17:57:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163915902348.3939.15203090824746492570.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 10 Dec 2021 17:57:03 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: Fix incorrect cs_setup delay handling (2021-12-10T17:05:34)
  Superseding: [v1] spi: Fix incorrect cs_setup delay handling (2021-12-10T15:36:34):
    spi: Fix incorrect cs_setup delay handling


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

