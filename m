Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE86A3345CA
	for <lists+linux-spi@lfdr.de>; Wed, 10 Mar 2021 18:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhCJR4k (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Mar 2021 12:56:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhCJR40 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Mar 2021 12:56:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id DD45364F3A;
        Wed, 10 Mar 2021 17:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615398985;
        bh=ntxTmSI0qrlABAjcziDpbpJHTLVkD4JoD3dUi+mZvNc=;
        h=Subject:From:Date:To:From;
        b=ZWqeLJdw1bHrQGQCC3THwFogtYbBAMOUOrPDhCE4dnPrEZqTnyeTPR/fWAYQbKtEu
         yqYjTtARZE+XnH0JL8Usci781wsiinBRkNruC1mkJuiZ18sqOH8524lURTkFKGm7HI
         MAO1K0YCVHBlC+6uDLosatkbRgHYo8Hw1dayVXJHXeEeZOBjrPPhmBtTBxTbYnKVIE
         lRq6fxVZp/sXCNaSsf8pQ0L4wcSSrXypyuexialsBBqFk7vhmeNK7SARt6/wyzLwp/
         u9c2noJM4kD1arEB6lpe6W75XK2Ctr+7sxkBflu/ei/G6rZ5O+dnpPN3kNXk8dk62I
         kqBgzMD8kIl2w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C898A609B8;
        Wed, 10 Mar 2021 17:56:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161539898576.2429.13797182723281868800.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 10 Mar 2021 17:56:25 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] dt-bindings: spi: Convert NXP flexspi to json schema (2021-03-10T16:52:00)
  Superseding: [v1] dt-bindings: spi: Convert NXP flexspi to json schema (2021-03-09T10:35:28):
    dt-bindings: spi: Convert NXP flexspi to json schema


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

