Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733A13F84E3
	for <lists+linux-spi@lfdr.de>; Thu, 26 Aug 2021 11:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240937AbhHZJ5d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Aug 2021 05:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234666AbhHZJ5d (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 26 Aug 2021 05:57:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 11BBB61058;
        Thu, 26 Aug 2021 09:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629971806;
        bh=JQAcq2pO/0yQ7aKKxTRgnsT81ju4B9iJDPP5P904D6U=;
        h=Subject:From:Date:To:From;
        b=oE1zTIwG57UEBxtCizpZIilnWxD05Piuesjamdy4l+fF8UdXl59Y4zlgfSbXUl65+
         JQIYMxscaqcQUkr1YkveL1Fptuf8RsoRbqazEOBSQVi06BCeb0rrvzKbshktIuR3D/
         LTgsjwkJ1qcPXEkZ9iFbqQ6b3fiqVh0UmJj2Lg83qA1Vkraw5lBOl5JmDlumNbV/jn
         nxMg1RztCM0WFQGqQy5TcLhf5QNZ4/Qc9GmIcd4ktYzxSeI5n0nCpr8rq6fsAlKwUQ
         9cIMHLfIZ8heMKbWQJhDbBkX3xCXFEiFoROU6ym92TgA4jURCQi/0ZbQjp4VmHuLyF
         D53WR8onKsafw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F293960A12;
        Thu, 26 Aug 2021 09:56:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162997180598.9037.5092109747467040303.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 26 Aug 2021 09:56:45 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Add sprd ADI r3 support (2021-08-26T09:15:45)
  Superseding: [v2] Add sprd ADI r3 support (2021-08-25T06:59:28):
    [V2,1/3] spi: sprd: Add ADI r3 support
    [V2,2/3] dt-bindings: spi: Convert sprd ADI bindings to yaml
    [V2,3/3] dt-bindings: spi: add sprd ADI for sc9863 and ums512


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

