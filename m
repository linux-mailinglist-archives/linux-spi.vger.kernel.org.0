Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA3C5B1FCF
	for <lists+linux-spi@lfdr.de>; Thu,  8 Sep 2022 15:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbiIHN45 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Sep 2022 09:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbiIHN4y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 8 Sep 2022 09:56:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C245AFD211
        for <linux-spi@vger.kernel.org>; Thu,  8 Sep 2022 06:56:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D0BC61CF6
        for <linux-spi@vger.kernel.org>; Thu,  8 Sep 2022 13:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C451AC433D7;
        Thu,  8 Sep 2022 13:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662645409;
        bh=OELGn79eRWcZ9/USJW6V0YTtVdKWmu7A9+hLCvgQD5U=;
        h=Subject:From:Date:To:From;
        b=imBsb4NhMBuoilLwN14V/YkdM+zKL8Y7Ym0FGaCtcxFQv1MAdzCL6zd+76tHSmmYp
         mJozq6zb79bfshc6CY3yfv/AYy457qJTC8BCkiwcD32M1V+vMGyw/XnYjMZm8eN+DO
         Nz6h5TD7SZV2scJs5fGtpjWBwRVKuznuW7OQx4zFNapNi1fqSz5TUTXic9HkihdZI4
         nMONvwGIbgmPX1oNATgcQTCJUL7s9x1VaTmiu3KYGrrK+y2xlzt8FLLpIXO7G35DdE
         83hFO99T0cFF+0fdejpyJOdRtPjQGMJikGBNM9yN7fZidHgOyvaL3h718sTnGpRSNh
         CtIh51a4fqAVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A99BBC04E59;
        Thu,  8 Sep 2022 13:56:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166264540968.7246.1279698364896737434.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 08 Sep 2022 13:56:49 +0000
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

Latest series: [v2] ACPI: unify _UID handling as integer (2022-09-08T13:29:06)
  Superseding: [v1] ACPI: unify _UID handling as integer (2022-09-07T16:46:05):
    [v1,1/8] ACPI: utils: Add acpi_dev_uid_to_integer() helper to get _UID as integer
    [v1,2/8] ACPI: LPSS: Refactor _UID handling to use acpi_dev_uid_to_integer()
    [v1,3/8] ACPI: x86: Refactor _UID handling to use acpi_dev_uid_to_integer()
    [v1,4/8] i2c: amd-mp2-plat: Refactor _UID handling to use acpi_dev_uid_to_integer()
    [v1,5/8] i2c: mlxbf: Refactor _UID handling to use acpi_dev_uid_to_integer()
    [v1,6/8] perf: qcom_l2_pmu: Refactor _UID handling to use acpi_dev_uid_to_integer()
    [v1,7/8] spi: pxa2xx: Refactor _UID handling to use acpi_dev_uid_to_integer()
    [v1,8/8] efi/dev-path-parser: Refactor _UID handling to use acpi_dev_uid_to_integer()

Latest series: [v2] spi: Group cs_change and cs_off flags together in struct spi_transfer (2022-09-08T13:05:18)
  Superseding: [v1] spi: Group cs_change and cs_off flags together in struct spi_transfer (2022-09-08T12:54:44):
    [v1,1/1] spi: Group cs_change and cs_off flags together in struct spi_transfer


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

