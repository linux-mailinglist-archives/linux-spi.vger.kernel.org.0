Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06DC3FBCAA
	for <lists+linux-spi@lfdr.de>; Mon, 30 Aug 2021 20:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhH3SsI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 30 Aug 2021 14:48:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231147AbhH3SsI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 30 Aug 2021 14:48:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 63F2960F5B;
        Mon, 30 Aug 2021 18:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630349234;
        bh=A0wvwaDlaRctCFGYkE8zpgSCJvdfcSDUodE+BVJlOvk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kE71twZa0J/rCxp1pALV1PhvlD93VleslNViSVEPyxHR5XGZBSblqa4H65OAwM1i2
         ZvGEN3HbOk2R7bKAV/mBafcyJ1k41E1sfDPaxNZyvHHFMaL4nc0YmGpsuTobM+6F1e
         lVRjsksRdHMUHZv4msmavGBNrF+GEWLiwSXuw0Iyof+A8Qs0REyM8UZnrnrREbahNe
         8Puv2LWiQ9SJrBp6c9Cmudc4YPFXaHYOTlRrpd4TFjNt7uslIHLWyfHDlcRu9Et2fG
         GLbfJALnGCtufV5AX9GaEadFx6oc7Nk9T/lmek3Vmsx2N+GbUYLtg7uTlVgIWbfNAP
         vcgxO3+0Pcouw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5AA6360A4F;
        Mon, 30 Aug 2021 18:47:14 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210830125123.B823CD1B482@fitzroy.sirena.org.uk>
References: <20210830125123.B823CD1B482@fitzroy.sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210830125123.B823CD1B482@fitzroy.sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.15
X-PR-Tracked-Commit-Id: 6e9c846aa0c53673c5d53925a6122aa0e53a9795
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0da9bc6d2fc3f98095d69f34c17f7d5730bbcc6c
Message-Id: <163034923436.1022.10036355668846822970.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 18:47:14 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 13:51:10 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0da9bc6d2fc3f98095d69f34c17f7d5730bbcc6c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
