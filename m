Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F06576A28E
	for <lists+linux-spi@lfdr.de>; Mon, 31 Jul 2023 23:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjGaVUZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Jul 2023 17:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjGaVUY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Jul 2023 17:20:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9C08F
        for <linux-spi@vger.kernel.org>; Mon, 31 Jul 2023 14:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7F1D612A4
        for <linux-spi@vger.kernel.org>; Mon, 31 Jul 2023 21:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15148C433C8;
        Mon, 31 Jul 2023 21:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690838423;
        bh=EDjo46WtDeTA2xJz9si4+XlCuVOUIrJ5mNiRyucflcg=;
        h=Subject:From:Date:To:From;
        b=Tt6nVNzuX2skVtwNLMFxWyfPWaC4Kcs/E5ln3gXY6OU0iIFVXyAPZsbFewyGrULz+
         kQ84urHdnzhcvYqQHhrJs1sbk32daDa+2goRuoMEysmvXffMTCYiG0f2osnqHAymh2
         cuvQglsrmh/rHUmvq4HDMOqzgh3NX6VfObbqOCcozNFnfk5lFEHsCazrW2YVwBAvxW
         FiHmzsLYmKn9aYSSICuCYCBtSHN1EtFlf50hBnJQWzuBlXd+Pc1ml7PZqVRizlWNIK
         9FykSZTpvXDhuHRnthZqouGRMFrhJDYyWkL+h+S6hUBK8xxyG6OC8fqcwVHH6hAwCp
         drUzwPGYwcpOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF898E96ABF;
        Mon, 31 Jul 2023 21:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169083842284.26809.17738804245263901263.git-patchwork-summary@kernel.org>
Date:   Mon, 31 Jul 2023 21:20:22 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi-geni-qcom: Add SPI device mode support for GENI based QuPv3
  Submitter: Praveen Talari <quic_ptalari@quicinc.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=765519
  Lore link: https://lore.kernel.org/r/20230714042203.14251-1-quic_ptalari@quicinc.com
    Patches: [v7,1/2] soc: qcom: geni-se: Add SPI Device mode support for GENI based QuPv3
             [v7,2/2] spi: spi-geni-qcom: Add SPI Device mode support for GENI based QuPv3

Series: spi-geni-qcom: Add SPI SLAVE mode support for GENI based QuPv3
  Submitter: Praveen Talari <quic_ptalari@quicinc.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=756605
  Lore link: https://lore.kernel.org/r/20230613065229.5619-1-quic_ptalari@quicinc.com
    Patches: [1/2] soc: qcom: geni-se: Add SPI SLAVE mode support for GENI based QuPv3

Series: spi-geni-qcom: Add SPI SLAVE mode support for
  Submitter: Praveen Talari <quic_ptalari@quicinc.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=757345
  Lore link: https://lore.kernel.org/r/20230615070706.18322-1-quic_ptalari@quicinc.com
    Patches: [v2,1/3] soc: qcom: geni-se: Add SPI SLAVE mode support for GENI based QuPv3

Series: spi-geni-qcom: Add SPI device mode support for
  Submitter: Praveen Talari <quic_ptalari@quicinc.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=762931
  Lore link: https://lore.kernel.org/r/20230706051024.15422-1-quic_ptalari@quicinc.com
    Patches: [v4,1/2] soc: qcom: geni-se: Add SPI Device mode support for GENI based QuPv3


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


