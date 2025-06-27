Return-Path: <linux-spi+bounces-8799-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9303DAEB48F
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 12:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7408D7A3143
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 10:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FDB298CD5;
	Fri, 27 Jun 2025 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mhGDS2xQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526202980BF
	for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 10:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019734; cv=none; b=l+5XVEMVB839c5KoMclUtcdOwZJXI5H8/5tkeXm3xn1xE6T6snyCm9tYPAn3ifwJeMxH6wCoPQhhJEPjSIl0luOWaFhS04YpWfKGCyYO4QLKEceQWhQRlX9jttTyduoaAVxkcSb4AqdEbITM95WAY+W9zRzmyGimzlykuUOKUoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019734; c=relaxed/simple;
	bh=u3+3xTgg8ySwFwJSh4UIH/QbNDMkPzATVebHq3ynfNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uoqwG6hQ6iYEF6tUTYXqU8n8jTgMywAg+ojQXD/KAlKeHFHgJ8bczkjF/d5ung8Ab5PplAwiYqJKWQfFEUoSrh198P5QUZr18n3TLkFGa6yTUA/rVrmzgHgAQO+JCH/l34Q8l5HmjQnPE+/eZcDDkR90duSZBFwVJaAPSrG0GuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mhGDS2xQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-453608ed113so19135785e9.0
        for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 03:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751019730; x=1751624530; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vCVCFwjAnkMVnM2TrNuY2f6SQdKDIj82hiVpU3a366c=;
        b=mhGDS2xQ4Ae8/i8Ev03u2s7nAz6l9VFRC/xnP8E5rxjADgdo3dy8S4EpK4NA/JPHjS
         Kz0OpVgvoJqdaY2UItq0iK9hf5Q5uppsX8WnsllTEJH61VswDsSDTXOpA75DgMH3X6Lj
         0VanKMBsv7wn9W8uPvOXcsACqaECZuEdR1CcNwG4UbkQ9805gs7ytJO9wu0RDFXo2NVF
         biv/PohKBege3Irh4DLwzeKaoHAkFsXK3NDUB+7vHzmNd2w0unXj2KxEDa93Nlnap3o/
         W9koUDwvAJxJEAZyiEk5q7UcjC8cT2hMhAbfDczE6hTuejrWbTjF3kHtHFso378Didkh
         hdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751019730; x=1751624530;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCVCFwjAnkMVnM2TrNuY2f6SQdKDIj82hiVpU3a366c=;
        b=EYQhzWhPlpQtIF17niaf4riXhujUeWH/r+Jcc3xScns1hnX90tIjlXtNwozuRkaNQM
         oRw01kW3qquC77T1gslSb3d+55X3/5xL3rCHns5JEnRxHK8LT7g4NmDpjpb7iYJff/IR
         T0+cUcUPaG4qHGWpt0oAwUorOiiu5qc9xjsOhkOkNOEfzjwO2Vu6TQ6Nm336iGHVOTZp
         m7tC+GBgZN0jiF/IrjwU5YhsScu1mqm4dZZD8k4Tn5IRJix5DS44WNJD9g/nccnzL/oj
         w/dIFLpFSr7f+X7UCCQa/Y6vNiPzJeUfLRK3VfcvNj/2dO4UxaYaKoUXz0q6ZVdXDNTF
         cxRw==
X-Gm-Message-State: AOJu0YxAc8n3BuaF4H6FKk9m1OvdA6QE2BQw/Uu2EgNvf7SOxFaxUyN1
	i91DxNzoqqQdVEfpkQVXv15q21G6vmoLoZcOMAyPj93qhA4mZeVyll5pErKLR2LNoh0=
X-Gm-Gg: ASbGncsdAQrxL2z5y9FlhwA7x0UYOqDk+OAvwFlAvUYh7MZEdRJWg75fzf42w5MBBtq
	oqehD0qn+wRf+q8xIEpY4CJ7sPYNSpBQP1ehAbEYlfwBuZ3cuXnvu/GncTBL1xtFw+oTUtptrQv
	WKP72G7hfOn9+qdu63zAg3hXOadTWxbU8M5m7kVh7fbC/OP2sZhv7ZVnfm7Es/JqKbzpBB3k1YJ
	TyUk5u7CCVm2ebxrywTv3jHJFSpczNql+9B7syj8Y3ITMb2lOY8oJ6LuOX267wInJo/G1uliDa6
	lNlLE5RAwHShsZ9a6Ax6GNwpo5DuE4lyQ7D4v/5b5wnQM64IWVZV30DHRLwpIw36uz2J1SE=
X-Google-Smtp-Source: AGHT+IFkxpAvv3NX+mkvbpnx8oeFvyJPpp2vOli48509Lsv+DaI/U3dnvJcfYEQZDOvJnNBBW4GAGA==
X-Received: by 2002:a05:600c:a087:b0:453:a88:d509 with SMTP id 5b1f17b1804b1-4538ee42c26mr35820825e9.10.1751019730502;
        Fri, 27 Jun 2025 03:22:10 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3a5599sm47250955e9.13.2025.06.27.03.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 03:22:10 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 27 Jun 2025 11:21:37 +0100
Subject: [PATCH v4 1/6] spi: spi-fsl-dspi: Clear completion counter before
 initiating transfer
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-james-nxp-spi-dma-v4-1-178dba20c120@linaro.org>
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
In-Reply-To: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
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
 drivers/spi/spi-fsl-dspi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 04c88d090c4d..4bd4377551b5 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1122,11 +1122,20 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 		if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
 			status = dspi_dma_xfer(dspi);
 		} else {
+			/*
+			 * Reinitialize the completion before transferring data
+			 * to avoid the case where it might remain in the done
+			 * state due to a spurious interrupt from a previous
+			 * transfer. This could falsely signal that the current
+			 * transfer has completed.
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


