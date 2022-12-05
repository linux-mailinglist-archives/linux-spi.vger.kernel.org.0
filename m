Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1896C6423E4
	for <lists+linux-spi@lfdr.de>; Mon,  5 Dec 2022 08:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbiLEH4e (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 5 Dec 2022 02:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiLEH4d (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 5 Dec 2022 02:56:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2550110FE9
        for <linux-spi@vger.kernel.org>; Sun,  4 Dec 2022 23:56:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B558360F8B
        for <linux-spi@vger.kernel.org>; Mon,  5 Dec 2022 07:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16C90C433D6;
        Mon,  5 Dec 2022 07:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670226992;
        bh=Ksb2g3YbGmI56vrzitZXqxN+VhIL7yLrkCB0TppBLyc=;
        h=Subject:From:Date:To:From;
        b=cD88YJgju1pecDwAadQpgF30dVQJVdQ+f2wj8nalD+h//SEAWO6J4UiPBv3U97tkW
         SI8dSZ354OpCi3ROiSPCCgCNwKcJJHYWMSRxcmGxrCumZdZ5Ry4zuJ85goqWFyMWE3
         1PRnxAVnJNWoyQ2SZMqxM05UKrtySD+EDpHnVpxobxMvxynnAKP25KhhZcQycDP0LC
         ZffCBPqeROX+K5W3XTWt5sB5HFrArli0JW+8ODA5zYilWnbE+JT3vNvqXd6z/6TG6w
         furMvsD9vUAg55/uHuOYESdE2pMHL6ZeUgvXItvXbt1KJegw2BldUS33NqESLH6wmN
         0v/Fr3z8pGv3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA433C395E5;
        Mon,  5 Dec 2022 07:56:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167022699195.25718.1134796012889476682.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 05 Dec 2022 07:56:31 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Add MediaTek MT7986 SPI NAND and ECC support (2022-12-05T06:57:47)
  Superseding: [v1] Add MediaTek MT7986 SPI NAND and ECC support (2022-11-28T02:06:04):
    [1/9] spi: mtk-snfi: add snfi support for mt7986 IC
    [2/9] spi: mtk-snfi: change default page format to setup default setting
    [3/9] spi: mtk-snfi: add optional nfi_hclk which needed for mt7986
    [4/9] mtd: nand: ecc-mtk: add ecc support fot mt7986 IC
    [5/9] dt-bindings: spi: mtk-snfi: add mt7986 IC snfi bindings
    [6/9] spi: mtk-snfi: add snfi sample delay and read latency adjustment
    [7/9] dt-bindings: spi: mtk-snfi: add two timing delay property
    [8/9] dt-bindings: mtd: Split ECC engine with rawnand controller
    [9/9] dt-bindings: mtd: ecc-mtk: add mt7986 IC ecc bindings


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

