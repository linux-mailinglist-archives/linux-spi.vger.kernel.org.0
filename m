Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F9637900C
	for <lists+linux-spi@lfdr.de>; Mon, 10 May 2021 16:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbhEJOCN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 May 2021 10:02:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230093AbhEJN57 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 10 May 2021 09:57:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9945961075;
        Mon, 10 May 2021 13:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620655004;
        bh=Puyp5P5CqB5Lpd3EQG2cvT4OgsbCUixf32rXBLse7Nw=;
        h=Subject:From:Date:To:From;
        b=FkPxxdbTFzK23KscraGUv5d4NYRYSqUm+1A/e4kLyHUafjHt32rQzlD41E4UYFDli
         a7+A5w1GMdlokW81DnQrmEDVADFt75EWs/t/Tnhh2Vw63KHCzz7DdCKn9WJPgYn1UY
         vBRLLq5ZxnhfQPuXpLcECi1zBSlosi35biNShQuNS+PYhcf21Hk+oOh3kzv3P1Q+VV
         SmCEz19IIL+R6keOAbTqvvZjsbwLA0ZNT66rHb3Av4yZPJkQalZb6D+zRtxqMhddrN
         wU/ng6kLsXUdnS7QhEqvk8qtTJIy2HD0W1xQSBrYBKsiQCm6uURZFeh01luGC9ncjw
         20ld4mp2gMRsg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 823D8609AC;
        Mon, 10 May 2021 13:56:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162065500447.30507.1356049596551309933.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 10 May 2021 13:56:44 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: pxa2xx: Set of cleanups (2021-05-10T12:41:24)
  Superseding: [v2] spi: pxa2xx: Set of cleanups (2021-04-23T18:24:31):
    [v2,01/14] spi: pxa2xx: Use one point of return when ->probe() fails
    [v2,02/14] spi: pxa2xx: Utilize MMIO and physical base from struct ssp_device
    [v2,03/14] spi: pxa2xx: Utilize struct device from struct ssp_device
    [v2,04/14] spi: pxa2xx: Replace header inclusions by forward declarations
    [v2,05/14] spi: pxa2xx: Unify ifdeffery used in the headers
    [v2,06/14] spi: pxa2xx: Group Intel Quark specific definitions
    [v2,07/14] spi: pxa2xx: Introduce int_stop_and_reset() helper
    [v2,08/14] spi: pxa2xx: Reuse int_error_stop() in pxa2xx_spi_slave_abort()
    [v2,09/14] spi: pxa2xx: Use pxa_ssp_enable()/pxa_ssp_disable() in the driver
    [v2,10/14] spi: pxa2xx: Extract pxa2xx_spi_update() helper
    [v2,11/14] spi: pxa2xx: Extract clear_SSCR1_bits() helper
    [v2,12/14] spi: pxa2xx: Extract read_SSSR_bits() helper
    [v2,13/14] spi: pxa2xx: Constify struct driver_data parameter
    [v2,14/14] spi: pxa2xx: Introduce special type for Merrifield SPIs


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

