Return-Path: <linux-spi+bounces-8490-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CD5AD87CD
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 11:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496D61652A1
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 09:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E37291C32;
	Fri, 13 Jun 2025 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MjveCkQJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FC6291C0F
	for <linux-spi@vger.kernel.org>; Fri, 13 Jun 2025 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749806966; cv=none; b=jal8rgKobBDHg2nM8MHj+KLCaYcPRlAFWaFBVXIt+cw9sSiog+QL3Ni6tQw063lzJadxvZFiX7vUhqUB6eewiQmP3L3E9qoqDQ/Fkc85IXLnmnX+J0UzqlBQnRXE76lOUZUKP2TgoeXUWwY+1zaD8ATYlmjynnqh0Ze0FJ/DWV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749806966; c=relaxed/simple;
	bh=I6Uh0W1U/pEscoVd7miIYAu5wzDsffordzyPGY3jblE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EU+5D/2PUJ5OIrwrMf45zmp9HvMIbvi389AsQV6ibKkFc1Ha4lOHAyVTOg4jr+wC6aNj0SRog6FxCYYE5Nh4EdWH2QaDU4R7pDeMCf9sJDUU/BSNVej80faqP0K3kKsNjhmTY405ec+dqDnJsTkcQmVCW35nea+ScGOZqJrfJwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MjveCkQJ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-453398e90e9so1972455e9.1
        for <linux-spi@vger.kernel.org>; Fri, 13 Jun 2025 02:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749806963; x=1750411763; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkMuSosV7oMRxRtp9yYE+2UdziIG4xoxewf16F9X2EY=;
        b=MjveCkQJJxrGSlTKV+eiyVOXZqfXG8DSwlfmmk8AZdqD2TezNvMdavuxkbJCcrCzmJ
         ozKgYVdpMuU8TPb79siT9bvIDQfVeRrKxPq7hBKgwum63b/R0L23MccPgkNgeahuLytp
         ZVoB6IP0VgwKYkjxEypttKTWTjtTqE6fww1cLOgEqYUbHKmSyUId7CXKaiByOfULkDfy
         RXIHB5kZeQUAYObAmueqRqkgWrDjcTnLzA9/clx1TlkjIrnP3WmSlTWDHPQdYT51CNoL
         942izHKE4T+cVFlw6o/LAbXmIXidkBN2WPpZzTJz7OVFT0m86nCFt2pSdDNKBNbjM1mG
         rJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749806963; x=1750411763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkMuSosV7oMRxRtp9yYE+2UdziIG4xoxewf16F9X2EY=;
        b=jvqoNupbR49/XCtrZtEP0LorhfHICHEVoqa/XKakSpmEytenH7pMXnwBmIxjSntlcf
         AV/6TYM4rMXW+wX4rbnO9l3sVT2ZkkF/TP0yCvJsY0BmGtpfTsayzFLOPCibhobnb9m0
         mCw5QWAIm2PLjitITv3ltZGXh0SQEZKKZKWqIWQEKPCk9Da3LZExdcXuqFm7+EL+RC72
         cr/WPNlXFsriNXUHOvEZVwTopIkd1o7UIvtztKA1GiOCL58TKhtLwc4QM4wbYFz1fy/p
         wKsyCBf6r28FAmvSWZLeINRPGeFEGSLfA69WZDWtUy6GgQij7h+6WVSnr/iwErEIPibS
         GxKA==
X-Forwarded-Encrypted: i=1; AJvYcCWMH1GYcS2DUIAt35l0T3YtQ4NivG94sD9CUql4whbPT+XDko7n2uMBFV4NbBNs0Nl5btLDirueuFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0xBtAQ1lX15q/awRtvjGzWQNcXSXSdquf1TkyW9lVtycZn9WO
	nJc5gj2N6lebJD5YxI3s7K7AZkaqsNtHd9RKXFFbaxoBE2nfnRqusWhzYqSNq1Js5ao=
X-Gm-Gg: ASbGncuYzBCJexzWfCRLl8se3OAZfEInp9zwp1ATDuy76Ba0Y54DDEmJB2XTf5OYT2S
	TlkvfY7tp0lMByggRF2Bi9VkXNnlCG5D65DRd0vWMUO1h+dzveab+UXt1LYkq3ZVczziJFJOYtb
	ShD6v3jXrzIk8iLEhemxALjDERCYyGlT2uY51c64zRcpVMqkUhuTcb393u6f41r7p5nDyWFJcD2
	kjGP36uu2kTQ6WdGZj/FORBNrrhckKh26sJgsC7aCOQj7xo3Ml8yb70o1UM+6RNkhizJhEmkVpU
	N99ld8cel6osoi5Iu1QneI7TuEFLeWvuC64X2X+vDcqfVoAiPUmCe/67+OCbTtSfmZL6biw=
X-Google-Smtp-Source: AGHT+IEsyyMaonG3OncFCbaWDdIJZCvvUaIQLI58D11q65RDAUSxHg9lX/idRHq3zl5QhSt6SMknHQ==
X-Received: by 2002:a05:6000:230e:b0:3a5:276b:1ec0 with SMTP id ffacd0b85a97d-3a56870835emr1942312f8f.45.1749806962900;
        Fri, 13 Jun 2025 02:29:22 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b08a2bsm1805946f8f.62.2025.06.13.02.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 02:29:22 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 13 Jun 2025 10:28:56 +0100
Subject: [PATCH v2 1/5] spi: spi-fsl-dspi: Clear completion counter before
 initiating transfer
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-james-nxp-spi-dma-v2-1-017eecf24aab@linaro.org>
References: <20250613-james-nxp-spi-dma-v2-0-017eecf24aab@linaro.org>
In-Reply-To: <20250613-james-nxp-spi-dma-v2-0-017eecf24aab@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Arnd Bergmann <arnd@arndb.de>, Larisa Grigore <larisa.grigore@nxp.com>, 
 Frank Li <Frank.li@nxp.com>, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

In target mode, extra interrupts can be received between the end of a
transfer and halting the module if the host continues sending more data.
If the interrupt from this occurs after the reinit_completion() then the
completion counter is left at a non-zero value. The next unrelated
transfer initiated by userspace will then complete immediately without
waiting for the interrupt or writing to the RX buffer.

Fix it by resetting the counter before the transfer so that lingering
values are cleared. This is done after clearing the FIFOs and the
status register but before the transfer is initiated, so no interrupts
should be received at this point resulting in other race conditions.

Fixes: 4f5ee75ea171 ("spi: spi-fsl-dspi: Replace interruptible wait queue with a simple completion")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 04c88d090c4d..744dfc561db2 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1122,11 +1122,19 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 		if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
 			status = dspi_dma_xfer(dspi);
 		} else {
+			/*
+			 * Reset completion counter to clear any extra
+			 * complete()s from spurious interrupts that may have
+			 * happened after the last message's completion but
+			 * before the module was fully in stop mode.
+			 */
+			if (dspi->irq)
+				reinit_completion(&dspi->xfer_done);
+
 			dspi_fifo_write(dspi);
 
 			if (dspi->irq) {
 				wait_for_completion(&dspi->xfer_done);
-				reinit_completion(&dspi->xfer_done);
 			} else {
 				do {
 					status = dspi_poll(dspi);

-- 
2.34.1


