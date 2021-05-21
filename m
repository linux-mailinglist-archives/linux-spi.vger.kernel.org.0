Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1DE38CF6D
	for <lists+linux-spi@lfdr.de>; Fri, 21 May 2021 22:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhEUU6C (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 May 2021 16:58:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhEUU6B (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 21 May 2021 16:58:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5C5C1613D8;
        Fri, 21 May 2021 20:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621630598;
        bh=0O7b2oFVxnVmelge7uqUdiGX6/BBkCZ4gcmcyLXeAoc=;
        h=Subject:From:Date:To:From;
        b=QhL6Ona4NKarzbgHJuOZEqoF19XgLSWKwwrayRLREIga5ZpqaEt2c5Y8VGcIKKamg
         bBuw8pOV8u0PzN4N0i+jYb3GRtmVS3BeG+bxKYays1UuASsMFwDMmQ8fnjdN0yt9ge
         zDbNY5cPzKkWgKZcYzCWamhdFjFBoRsq/WSxPpqagwfc1hD10zFpvBFsvZu2q6Llx+
         eR/QIpo+tHGVrFw5gwjEjsh3rPA66WUewkWMSc7fvHDSYzaQ1Pom5R7xL0GgRl6eQU
         a7uRxc06Di/HN3qWFqTVTAI104aGD2mslRtqMZLVmN1xfIwPyvyvUqfe33napUIkId
         9R7lswj57/a4g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 48F56609E9;
        Fri, 21 May 2021 20:56:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162163059824.22775.1923697807052894433.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 21 May 2021 20:56:38 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi-sun6i: Fix chipselect/clock bug (2021-05-21T20:19:13)
  Superseding: [v1] spi-sun6i: Fix chipselect/clock bug (2021-05-20T10:06:56):
    [1/1] spi-sun6i: Fix chipselect/clock bug


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

