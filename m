Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A48E6C8F40
	for <lists+linux-spi@lfdr.de>; Sat, 25 Mar 2023 16:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjCYP4s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 25 Mar 2023 11:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjCYP4r (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 25 Mar 2023 11:56:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5988685
        for <linux-spi@vger.kernel.org>; Sat, 25 Mar 2023 08:56:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE9B3B802C7
        for <linux-spi@vger.kernel.org>; Sat, 25 Mar 2023 15:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77B2EC433D2;
        Sat, 25 Mar 2023 15:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679759803;
        bh=+aBYKT5satfZUw+37iVqZx7MiPAJepKYbHLzKk3Ex70=;
        h=Subject:From:Date:To:From;
        b=k8eVPUyKbUqSskXCgvFS/qn3CHG5vFhl9I5OrK+GLZAkbpLm0Xn3iaY3+lliMkzLp
         E1xYFMIQG9XJo20K7ZGa7i5an407VPeEiQb059rWrUh6OYYPKaUtKaphSfBbbt+aux
         RBga48rVwItuJOy+byW37LsycSYJsacvQmC5ackhJzAG/50t7ZCf4lVlPj4QZV8cbM
         k6s/+862Mz398I3U2iPngdH3/ErFY/ftK2V2FY+zHADxfaBTS5j615+/0uob6loN8i
         ijQkSwI6iV560+XQFuLHH772osS21OeNviVUoP2ThP0C0LpOKMGxGgJ/a1fbzpMK2z
         MaVsdEU892r0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57B68E2A039;
        Sat, 25 Mar 2023 15:56:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167975980335.29785.15329975284620387610.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 25 Mar 2023 15:56:43 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v7] Add Intel LJCA device driver (2023-03-25T15:47:05)
  Superseding: [v6] Add Intel LJCA device driver (2023-03-23T17:21:07):
    [v6,1/6] usb: Add support for Intel LJCA device
    [v6,2/6] usb: ljca: Add transport interfaces for sub-module drivers
    [v6,3/6] Documentation: Add ABI doc for attributes of LJCA device
    [v6,4/6] gpio: Add support for Intel LJCA USB GPIO driver
    [v6,5/6] i2c: Add support for Intel LJCA USB I2C driver
    [v6,6/6] spi: Add support for Intel LJCA USB SPI driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

