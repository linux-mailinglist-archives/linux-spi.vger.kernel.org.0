Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43994741E2
	for <lists+linux-spi@lfdr.de>; Tue, 14 Dec 2021 12:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhLNL5o (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Dec 2021 06:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhLNL5o (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Dec 2021 06:57:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAFFC061574
        for <linux-spi@vger.kernel.org>; Tue, 14 Dec 2021 03:57:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B86F614A2
        for <linux-spi@vger.kernel.org>; Tue, 14 Dec 2021 11:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68B0FC34601;
        Tue, 14 Dec 2021 11:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639483062;
        bh=NO7baxtn2MY/KNryT/4w8JF0YX7WREcPgplH1hgmdnw=;
        h=Subject:From:Date:To:From;
        b=j5Ku0zOVjSgVJ5Zi7ZVUShiWLz8NLvQJFWijCAdV5wxpLKJZy07Q3mIdgqYkUQdOG
         P9Eda8Uwt+5GB2im+TnwccY74t6UZ75S7DsX5aQ3CAOnOrCbr2bFHyHJanA5v5Hzlo
         c7xrULXJ6aeesFS4frnMWNBTK+jebvl+0OTrJxhMpwMIaaMGH/1rmTepidGnf1FaHO
         9tIrP8kwTJ/gGt0Pe0ocSVxWIj2jdNb+Ql2Ifnmp1YRvaF/OC1eCYdzY9jde2tC5GO
         gs0KixY1EQXBSU67VB0sc6s02yyRzGeUpBRv0YjwXaYQMYGpG9/O9y4D1SS0dtZEE7
         s2w+ToluyyteQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 52AE2609BA;
        Tue, 14 Dec 2021 11:57:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163948306228.25138.7056005388017523381.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 14 Dec 2021 11:57:42 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] Revert "spi: spi-zynqmp-gqspi: add mutex locking for exec_op" (2021-12-14T11:01:52)
  Superseding: [v1] Revert "spi: spi-zynqmp-gqspi: add mutex locking for exec_op" (2021-12-14T11:01:51):
    Revert "spi: spi-zynqmp-gqspi: add mutex locking for exec_op"


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

