Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29984EDF2D
	for <lists+linux-spi@lfdr.de>; Thu, 31 Mar 2022 18:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240313AbiCaQ6O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 31 Mar 2022 12:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbiCaQ6N (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 31 Mar 2022 12:58:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75E9232137
        for <linux-spi@vger.kernel.org>; Thu, 31 Mar 2022 09:56:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05676B82055
        for <linux-spi@vger.kernel.org>; Thu, 31 Mar 2022 16:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B87BC340ED;
        Thu, 31 Mar 2022 16:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648745783;
        bh=dRZxzWGy7/knn43G8tjLuPgMqXjwXw6oyCyxvfS57yo=;
        h=Subject:From:Date:To:From;
        b=AXwKqoobKR++wloaOICkx+IIYWdKybeITxQXplhqObbDyHnt7PbV9ucEocYWcRtAR
         OXoxAK+oHguL+ANg6E/ZfE8QGtjHljg4sesYOh3z7byo8YSXusFUSO4tigHxnO0tIY
         aJJ3U5kiIscYOqQX9E2N0YrCSaGycFa8IxHUdW2S6Ds9KrjmMx1o8QsePY1tJAnI3N
         TYx25K5t7/Y4vySL15Owb3lZruNO9VoGszi0egmrhr6fR3w+oP8g4eFzeARNUf1c9p
         j2K0CzAEQKyp67Kg2Th1ih5J/daQAoqmlyrH6YFDbcFWe8qLzzWPcgi2NgG3aWOWoX
         nkIh4wc6lRQVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 818B0EAC09B;
        Thu, 31 Mar 2022 16:56:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164874578352.13195.5648530228499807221.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 31 Mar 2022 16:56:23 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: dt-bindings: qcom,spi-geni-qcom: convert to dtschema (2022-03-31T16:02:48)
  Superseding: [v1] spi: dt-bindings: qcom,spi-geni-qcom: convert to dtschema (2022-03-29T11:27:16):
    [1/2] spi: dt-bindings: qcom,spi-geni-qcom: convert to dtschema


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

