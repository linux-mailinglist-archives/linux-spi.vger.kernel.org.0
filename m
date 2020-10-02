Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00D3281345
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 14:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgJBM5f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 08:57:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBM5f (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 2 Oct 2020 08:57:35 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601643455;
        bh=aaorstv3qEuLLfBbLhdmbDNL3IQNmjc6K8hpMBFirig=;
        h=Subject:From:Date:To:From;
        b=YDfx3beRJfCp38Xm1Id6xyN+GzA52xK/f1G9auqYOUdbk+sdDlA7R+hCf8XKuwmew
         CDPMXQVK19z7UOa0yOlmEffFbKRomwwyl2cBPOoqwGsYehqFWEMBjSk3MdtrT5dU4n
         PKEikzKTIqLKXR5sJmoJT87L6QNhl/XoJxT+JYeU=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160164345502.29096.6631060152895862371.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 02 Oct 2020 12:57:35 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Some fixes for spi-s3c64xx (2020-10-02T12:22:42)
  Superseding: [v2] Some fixes for spi-s3c64xx (2020-08-21T16:13:52):
    [v2,1/9] spi: spi-s3c64xx: swap s3c64xx_spi_set_cs() and s3c64xx_enable_datapath()
    [v2,2/9] spi: spi-s3s64xx: Add S3C64XX_SPI_QUIRK_CS_AUTO for Exynos3250
    [v2,3/9] spi: spi-s3c64xx: Report more information when errors occur
    [v2,4/9] spi: spi-s3c64xx: Rename S3C64XX_SPI_SLAVE_* to S3C64XX_SPI_CS_*
    [v2,5/9] spi: spi-s3c64xx: Fix doc comment for struct s3c64xx_spi_driver_data
    [v2,6/9] spi: spi-s3c64xx: Check return values
    [v2,7/9] spi: spi-s3c64xx: Ensure cur_speed holds actual clock value
    [v2,8/9] spi: spi-s3c64xx: Increase transfer timeout
    [v2,9/9] spi: spi-s3c64xx: Turn on interrupts upon resume


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

