Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B12A4F23CA
	for <lists+linux-spi@lfdr.de>; Tue,  5 Apr 2022 08:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiDEG6X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Apr 2022 02:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiDEG6W (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Apr 2022 02:58:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02D81087
        for <linux-spi@vger.kernel.org>; Mon,  4 Apr 2022 23:56:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 583D66158E
        for <linux-spi@vger.kernel.org>; Tue,  5 Apr 2022 06:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD786C340F3;
        Tue,  5 Apr 2022 06:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649141783;
        bh=ESPSbCMcO6E3gFNBHPXZgEuOqUoUeJR0dCymGoIj1ZU=;
        h=Subject:From:Date:To:From;
        b=V5y2c6LVBQdHNfBZlFUhUx43zcV/3uo2UAgXjIGF9qlX0EKvnH98+TLznzBrrSDWY
         GT1S7TqKdXu6Wy8EJH0wBnPCK2522kqQl23tp/04NHpit3155dRshK+g0GKOmqNINZ
         LvzvxT038/oKEwR0anwEuAsC3NXYCtVISSiNcH1ZejSmfTAHSfX2HJqKoV3oWbgdqC
         8II4AnJGWKeHuG6oCXOTJgULOtoSxkfB9p5V8X6pgYTrezLqDeKdPq5AaxmrphoZax
         FEoZ5QmP8FDCmiIps1eoVUUOSIxIssKdnDbCHjzkt1K4bR+EH4230eZAhe9i3ev8K8
         OYBN7DNVNG4UQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8DAAE85BCB;
        Tue,  5 Apr 2022 06:56:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164914178368.20798.1381690780497321739.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 05 Apr 2022 06:56:23 +0000
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

Latest series: [v2] dt-bindings: qcom: update maintainers (drop Akash and Mukesh) (2022-04-05T06:37:24)
  Superseding: [v1] dt-bindings: qcom: update maintainers (drop Akash and Mukesh) (2022-03-29T11:37:17):
    dt-bindings: qcom: update maintainers (drop Akash and Mukesh)

Latest series: [v4] dt-bindings: qcom: convert entire GSBI (QUP I2C/SPI/UART) to DT schema (2022-04-05T06:34:44)
  Superseding: [v3] dt-bindings: qcom: convert entire GSBI (QUP I2C/SPI/UART) to DT schema (2022-04-02T18:40:02):
    [v3,1/9] arm64: dts: qcom: align dmas in I2C/SPI/UART with DT schema
    [v3,2/9] arm64: dts: qcom: align clocks in I2C/SPI with DT schema
    [v3,3/9] ARM: dts: qcom: ipq4019: align dmas in SPI/UART with DT schema
    [v3,4/9] ARM: dts: qcom: ipq4019: align clocks in I2C with DT schema
    [v3,5/9] ARM: dts: qcom: msm8660: disable GSBI8
    [v3,6/9] spi: dt-bindings: qcom,spi-qup: convert to dtschema
    [v3,7/9] dt-bindings: serial: qcom,msm-uartdm: convert to dtschema
    [v3,8/9] dt-bindings: i2c: qcom,i2c-qup: convert to dtschema
    [v3,9/9] dt-bindings: qcom: qcom,gsbi: convert to dtschema


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

