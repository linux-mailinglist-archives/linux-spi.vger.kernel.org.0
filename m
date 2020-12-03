Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8B72CD08B
	for <lists+linux-spi@lfdr.de>; Thu,  3 Dec 2020 08:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgLCHqJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Dec 2020 02:46:09 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:30312 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgLCHqI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 3 Dec 2020 02:46:08 -0500
Received: from ironmsg07-lv.qualcomm.com (HELO ironmsg07-lv.qulacomm.com) ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 02 Dec 2020 23:45:27 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qulacomm.com with ESMTP/TLS/AES256-SHA; 02 Dec 2020 23:45:26 -0800
X-QCInternal: smtphost
Received: from c-rojay-linux.qualcomm.com ([10.206.21.80])
  by ironmsg01-blr.qualcomm.com with ESMTP; 03 Dec 2020 13:15:02 +0530
Received: by c-rojay-linux.qualcomm.com (Postfix, from userid 88981)
        id D45DF2819; Thu,  3 Dec 2020 13:15:01 +0530 (IST)
From:   Roja Rani Yarubandi <rojay@codeaurora.org>
To:     broonie@kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, swboyd@chromium.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        akashast@codeaurora.org, msavaliy@qti.qualcomm.com,
        Roja Rani Yarubandi <rojay@codeaurora.org>
Subject: [PATCH] spi: spi-geni-qcom: Fix NULL pointer access in geni_spi_isr
Date:   Thu,  3 Dec 2020 13:14:59 +0530
Message-Id: <20201203074459.13078-1-rojay@codeaurora.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Here, there is a chance of race condition occurrence which leads to
NULL pointer dereference with struct spi_geni_master member 'cur_xfer'
between setup_fifo_xfer() and handle_fifo_timeout() functions.

Fix this race condition with guarding the 'cur_xfer' where it gets updated,
with spin_lock_irq/spin_unlock_irq in setup_fifo_xfer() as we do in
handle_fifo_timeout() function.

Call trace:
 geni_spi_isr+0x114/0x34c
 __handle_irq_event_percpu+0xe0/0x23c
 handle_irq_event_percpu+0x34/0x8c
 handle_irq_event+0x48/0x94
 handle_fasteoi_irq+0xd0/0x140
 __handle_domain_irq+0x8c/0xcc
 gic_handle_irq+0x114/0x1dc
 el1_irq+0xcc/0x180
 geni_spi a80000.spi: Failed to cancel/abort m_cmd
 dev_watchdog+0x348/0x354
 call_timer_fn+0xc4/0x220
 __run_timers+0x228/0x2d4
 spi_master spi6: failed to transfer one message from queue
 run_timer_softirq+0x24/0x44
 __do_softirq+0x16c/0x344
 irq_exit+0xa8/0xac
 __handle_domain_irq+0x94/0xcc
 gic_handle_irq+0x114/0x1dc
 el1_irq+0xcc/0x180
 cpuidle_enter_state+0xf8/0x204
 cpuidle_enter+0x38/0x4c
 cros-ec-spi spi6.0: spi transfer failed: -110
 ...

Fixes: 2ee471a1e28e ("spi: spi-geni-qcom: Mo' betta locking")
Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
---
 drivers/spi/spi-geni-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 25810a7eef10..e65d6676602b 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -457,7 +457,6 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 		len = xfer->len / (mas->cur_bits_per_word / BITS_PER_BYTE + 1);
 	len &= TRANS_LEN_MSK;
 
-	mas->cur_xfer = xfer;
 	if (xfer->tx_buf) {
 		m_cmd |= SPI_TX_ONLY;
 		mas->tx_rem_bytes = xfer->len;
@@ -475,6 +474,7 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 	 * interrupt could come in at any time now.
 	 */
 	spin_lock_irq(&mas->lock);
+	mas->cur_xfer = xfer;
 	geni_se_setup_m_cmd(se, m_cmd, FRAGMENTATION);
 
 	/*
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

