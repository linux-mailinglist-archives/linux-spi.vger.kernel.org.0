Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB974489CF6
	for <lists+linux-spi@lfdr.de>; Mon, 10 Jan 2022 17:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbiAJQAQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 Jan 2022 11:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiAJQAQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 Jan 2022 11:00:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDCDC06173F
        for <linux-spi@vger.kernel.org>; Mon, 10 Jan 2022 08:00:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15E55B81664
        for <linux-spi@vger.kernel.org>; Mon, 10 Jan 2022 16:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB64FC36AE5;
        Mon, 10 Jan 2022 16:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641830413;
        bh=9KSgN7Eq2v36qLu9TZqWMbIOzNYli3wzAax8q3craZE=;
        h=Subject:From:Date:To:From;
        b=vJsLoz/RD8MnK7Uu5rNnY5kBXdEU0GZE2+tvnUE4NKwq8PVLFDG9h6pc+uPuL72sU
         eNsjJxQjyQvSdrtRycEO12GO1/k8VyVxz5vMVvMWvq2G6sjEQJNNn5tdhzoW7CBJ3h
         r8oiU1BYIodPmQw4K8Zjkmb8Y9DeCNYBgbHOzOy35meC609St2oebYmEBmTIhnHr7B
         eQsxwk8ZzEyULV6Dn2K8KS8608nLS46kQoUVxxiWzv5UsMiWf36v3yt3UqTUlAz9c5
         3u78fVQErshvW0fv7bcfTRSXE2x/dJRYjIvIrEIQVenDKeIPv71Mg2Oro59bpIEQI3
         oaTJgimkTXzqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A86F3F6078C;
        Mon, 10 Jan 2022 16:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164183041362.19435.17463391211998737393.git-patchwork-summary@kernel.org>
Date:   Mon, 10 Jan 2022 16:00:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: driver:spi: change clk_disable_unprepare to clk_unprepare
  Submitter: Dongliang Mu <mudongliangabcd@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=590707
  Lore link: https://lore.kernel.org/r/20211206101931.2816597-1-mudongliangabcd@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


