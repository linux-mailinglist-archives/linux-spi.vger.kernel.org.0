Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6B0A1861AB
	for <lists+linux-spi@lfdr.de>; Mon, 16 Mar 2020 03:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgCPCdk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 22:33:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729584AbgCPCdk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 15 Mar 2020 22:33:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47CB420722;
        Mon, 16 Mar 2020 02:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584326019;
        bh=e0FJE4mmKOLy1FnSL5Kj2UeQ9zkdN+4VFJKPic2+/YI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HkEOIoaeF07JedlJPbadevlTgGT2iWUedMZXceW9cKLD5mYjAlu2YVSo/uXwMSiv+
         N/6Y+mNWFdEk+uP9imVhtSIG30nIGdKhNYV7FmUO5r9xDaxz/UuaJsOOwpa6plCvO8
         3NuUfL0Fs0yVavp75cKv1uqvvLdEPZfo9oLdyVJ4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thommy Jakobsson <thommyj@gmail.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.5 16/41] spi/zynqmp: remove entry that causes a cs glitch
Date:   Sun, 15 Mar 2020 22:32:54 -0400
Message-Id: <20200316023319.749-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316023319.749-1-sashal@kernel.org>
References: <20200316023319.749-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Thommy Jakobsson <thommyj@gmail.com>

[ Upstream commit 5dd8304981ecffa77bb72b1c57c4be5dfe6cfae9 ]

In the public interface for chipselect, there is always an entry
commented as "Dummy generic FIFO entry" pushed down to the fifo right
after the activate/deactivate command. The dummy entry is 0x0,
irregardless if the intention was to activate or deactive the cs. This
causes the cs line to glitch rather than beeing activated in the case
when there was an activate command.

This has been observed on oscilloscope, and have caused problems for at
least one specific flash device type connected to the qspi port. After
the change the glitch is gone and cs goes active when intended.

The reason why this worked before (except for the glitch) was because
when sending the actual data, the CS bits are once again set. Since
most flashes uses mode 0, there is always a half clk period anyway for
cs to clk active setup time. If someone would rely on timing from a
chip_select call to a transfer_one, it would fail though.

It is unknown why the dummy entry was there in the first place, git log
seems to be of no help in this case. The reference manual gives no
indication of the necessity of this. In fact the lower 8 bits are a
setup (or hold in case of deactivate) time expressed in cycles. So this
should not be needed to fulfill any setup/hold timings.

Signed-off-by: Thommy Jakobsson <thommyj@gmail.com>
Reviewed-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Link: https://lore.kernel.org/r/20200224162643.29102-1-thommyj@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-zynqmp-gqspi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 60c4de4e44856..7412a3042a8d2 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -401,9 +401,6 @@ static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
 
 	zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, genfifoentry);
 
-	/* Dummy generic FIFO entry */
-	zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, 0x0);
-
 	/* Manually start the generic FIFO command */
 	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
 			zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
-- 
2.20.1

