Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23D97E5C8E
	for <lists+linux-spi@lfdr.de>; Wed,  8 Nov 2023 18:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjKHRk2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Nov 2023 12:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjKHRkZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Nov 2023 12:40:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3681FF9
        for <linux-spi@vger.kernel.org>; Wed,  8 Nov 2023 09:40:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 636B2C433C7;
        Wed,  8 Nov 2023 17:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699465223;
        bh=y+qq0jWjihrm+KK+sH+gI/e6UoAO219NXSr6CwXRxDA=;
        h=Subject:From:Date:To:From;
        b=ePWNR405+ubMdmAADnjyLsZ1O75JWVOBbg0MMQRtt5FxP0GxZDRE7aCt1E2Ef5bsf
         yqU6+Aca4w3EQe9w/Qs8Ow9cySWw7QNAkOTP7QkiOaPxqOSHuIiMGk2b2o83jMD/5E
         AYGxOFmPicPbyKe3L3WXXwHhbpZAO+FYj2V2w6qYRJXlcJ06ZoN5MNO5dBmqqOdJXB
         G9iAExSEILxu/pN8/FxBSDNzuxBT1iaa3OsBjKCeIN8JoMZwQIqhN3aAW9b38a5Uz+
         hFd098SMwk8qDNVGWixhGHb76WlNQyzCS3Q3bwp5yHxi0JmgtrL1XlgaVaAwhInTsU
         6wsgIFQg4ZZxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D217C3274D;
        Wed,  8 Nov 2023 17:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169946522316.21948.7278824101252665698.git-patchwork-summary@kernel.org>
Date:   Wed, 08 Nov 2023 17:40:23 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1] spi: Fix null dereference on suspend
  Submitter: Mark Hasemeyer <markhas@chromium.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=799533
  Lore link: https://lore.kernel.org/r/20231107144743.v1.1.I7987f05f61901f567f7661763646cb7d7919b528@changeid


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


