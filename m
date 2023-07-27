Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884AA7649A4
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jul 2023 09:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbjG0H7U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Jul 2023 03:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbjG0H7G (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Jul 2023 03:59:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08764231
        for <linux-spi@vger.kernel.org>; Thu, 27 Jul 2023 00:56:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 551F961D95
        for <linux-spi@vger.kernel.org>; Thu, 27 Jul 2023 07:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0A0DC433C7;
        Thu, 27 Jul 2023 07:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690444585;
        bh=iFkh8d8AUfEC8cAzpawJxwe9yF55sY3K8fevYD8BC4E=;
        h=Subject:From:Date:To:From;
        b=bgVT7xZUz1foQ2LpxNtHfdi/DnGFf8KIeW/KR1UFsyE/Z4f3LkgzmTtxFt9u1TJB3
         sqIeEmh9zp/ejZwnL0+Ia/uK1ZOSWyCWDvPn3wBWkTl2B4ZZN+Cravnnx/TZdtjU5B
         HkG2DAyNltrC6sMtSc2itoqa1ZfHSMwHXAl8QGd+K5QxceTR7vEZPDi3t7cXxOVdhq
         aaFlEZavAGCMi/RP3sMfS9bZFhouBhfX19kk3YBFqcAmc2uyLcdJ5HpAJucwh506tp
         nzOPkCufEwdY/FhDWo0wc1v0m9HQE1Rklev1vIs8CELPHibBqkFYhXiDFYU+O2QrEY
         0MuselImpghiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8ED6DC41672;
        Thu, 27 Jul 2023 07:56:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169044458551.25342.14755275984689311338.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 27 Jul 2023 07:56:25 +0000
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

Latest series: [v2] dt-bindings: spi: convert spi-brcm63xx.txt to YAML (2023-07-27T07:08:06)
  Superseding: [v1] dt-bindings: spi: convert spi-brcm63xx.txt to YAML (2023-07-15T10:02:10):
    dt-bindings: spi: convert spi-brcm63xx.txt to YAML


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

