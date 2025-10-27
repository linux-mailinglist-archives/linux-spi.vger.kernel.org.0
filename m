Return-Path: <linux-spi+bounces-10857-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD99C0E10D
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 14:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C450407DF2
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 13:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05533279329;
	Mon, 27 Oct 2025 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="dR3M/IXZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E5C272E5A
	for <linux-spi@vger.kernel.org>; Mon, 27 Oct 2025 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571827; cv=none; b=PYhwF/73M1K7W4ZlsI3+fG1gVS2lFA2/RYTovV2KDBZT/1fvF89JnYXi+hQGVvZAL0KVxk3jVYAjjOiELH+ZQGJeJ7e3QI1I7XcN2V1btVMqAPDXmMEfoLJkJBp13wZXy9v21X5Yf1lITxZWa6EoqVVVRLt/YpaIFC2zOk+5kHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571827; c=relaxed/simple;
	bh=BwADLFKGpa+de95hFRvgOEPMyxxO0x+ASxPYf2FXvD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qptlTrzlUj7eFAY9LLHoTDPUZaYEqjRGWAioziEwGnCS+hN6xDlKozNsuyhYYxqjPGmb3IxY9f1CqB/IJERIC3BVX6Xurefg/mzzLzJbBiOT7qkniZRPdIi0bPam3nIS1W1wms/uTEwjmAPt++42ZulZllgmINJH+Z39xzdbPUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=dR3M/IXZ; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-430c17e29d9so19346725ab.1
        for <linux-spi@vger.kernel.org>; Mon, 27 Oct 2025 06:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761571825; x=1762176625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPbR25sftlpl2ir5v+hHNY+KLBX0TEvDp8d/P1ZTVnE=;
        b=dR3M/IXZtU2s58ejwIK/zWwDNFBAW9xP5a7R8ql66X2FR5zC/jib2m2nwDAaeDc4T7
         xz+eeI/RX2oa2wJCBa/5P0x2IO0ODKaea+5Sy1byT6NudKbRi8stRNLnxWSqo+XZOdFI
         yG10ONE9D7uMBAfCm0vptWN0xcZA6wYbcSqlsLN7Ovt9YMGEc4Q1LrLMDmoFTJoM98SW
         wXjzWCeo5HN/IC+lX+VFze656vTvbZ4vmAylMZVYnoOBkR+r9d7lcdJAsWZtbaZY+1Cn
         e3AiXXHsFUTqkBhdXXCuV0rJ9/Ml+vaavvXU+I37zXsr/l/MzqbEhW+SGalCTRwInm/v
         C9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761571825; x=1762176625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPbR25sftlpl2ir5v+hHNY+KLBX0TEvDp8d/P1ZTVnE=;
        b=rAlxWTOxLDBKFr9EEd6puZQy4fsdYns1x3MPEGjNNCdgCpcOva0tQsv72F2nIwHnWM
         MErSI+KldCp3XvlSonUvHkyp7TfJee6Z063ee0zz491pZM+oNlqFdo7xxESIB1tbQECq
         bZGKHwRMxXZkiPg6+Uc/HrFwJo1Q/pC9JPPcLIjKe+JV55ST6INp7kZZ6Yck+lCEyHRk
         bRTWZ4FYiWmY/gM+/x/sC48OGL2jP7r/CsYt+y7TfZvJyJcGmBwqYl5S0AAD+OkRAGn+
         IEJaIVGQFWmKcFt9/zdblZ0aTAm6mb4au/iMbcFo8t3FsocJugq6yQRkUQXt6C97/Ct8
         CtWw==
X-Forwarded-Encrypted: i=1; AJvYcCUu7gl37PUAICtCGMMBqVvYxTUn0qVF9epcWZAZiHhYK2tB7bTBms8hhqT91dh1/vv9CVRR7svEuf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyunR1q2WFneypurP826HwFggG4znRg3jkP0WW3ykkawyuhBOpK
	t1hZYuglwnkVeU4i0ko5yfnqyxkN6EepmclUiILwL77tVvCf7aZfE4NzElxTpNiUEmE=
X-Gm-Gg: ASbGnctgmT9WpoofenCYdn4kAx3IYUEH28srYcqVf90NKSNba2LYgJ/nZdxayBxeemG
	V1K75TbNhDA0TDVdzygT1qhIiHm1c1zPu6oaittoSoyTCeVCwi45+x8UWJjnso4jzDj6owuTdxW
	rOlSpMd7xjRADcTbvQCQuymPcv4cskF1d2gzBzIXAL7w2J8w3XudDm9rbUJIJLs9L8ySazsV7qv
	VZ1ToXzcL6a7RrmUT6G5PtD/HUbJzvgRHeHLVu/HyiS4Ms6gdItAgPwyyPdxhEouvzS+gdAG6zJ
	BL+rLEuwXh8ITQv4mJJiPTrczRSAZpL5c9ocvLsLZF6q9B8V3aP5JQwCLuciDUdj2i7tbTqUnXz
	Q3Y94mqEQWMaN5KbZKkx0XNQ89qHX4JLcXN3l4XtT9TQd+UQ5tJz566SqlrBIeMCClDR+90kNPZ
	axGMV7KTc2ueoK7Ga2UlrFSA/SEH+2GmLnYyFMh69HLCk=
X-Google-Smtp-Source: AGHT+IE4vZfshbOMDVZNKh1eoFq+Ds25y5NT2j8sGmj2MHLjX5lybRWfL/HsmrZ3kz3tWd7cuHz3wQ==
X-Received: by 2002:a05:6e02:16c6:b0:430:a7d5:235f with SMTP id e9e14a558f8ab-4320f77378dmr1192385ab.15.1761571825149;
        Mon, 27 Oct 2025 06:30:25 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea78e2fd4sm3093057173.26.2025.10.27.06.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:30:22 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: han.xu@nxp.com,
	broonie@kernel.org
Cc: dlan@gentoo.org,
	Frank.li@nxp.com,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 6/9] spi: fsl-qspi: introduce sfa_size devtype data
Date: Mon, 27 Oct 2025 08:30:04 -0500
Message-ID: <20251027133008.360237-7-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251027133008.360237-1-elder@riscstar.com>
References: <20251027133008.360237-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In fsl_qspi_default_setup(), four registers define the size of blocks of
data to written to each of four chips that comprise SPI NOR flash storage.
They are currently defined to be the same as the AHB buffer size.

The SpacemiT QSPI has an AHB buffer size of 512 bytes, but requires these
four sizes to be multiples of 1024 bytes.

Define a new field sfa_size in the fsl_qspi_devtype_data structure that, if
non-zero, will be used instead of the AHB buffer size to define the size of
these chip regions.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/spi/spi-fsl-qspi.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 2c030dd6facc7..46a3187b33548 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -207,6 +207,7 @@ struct fsl_qspi_devtype_data {
 	unsigned int txfifo;
 	int invalid_mstrid;
 	unsigned int ahb_buf_size;
+	unsigned int sfa_size;
 	unsigned int quirks;
 	bool little_endian;
 };
@@ -737,6 +738,7 @@ static int fsl_qspi_default_setup(struct fsl_qspi *q)
 {
 	void __iomem *base = q->iobase;
 	u32 reg, addr_offset = 0;
+	u32 sfa_size;
 	int ret;
 
 	/* disable and unprepare clock to avoid glitch pass to controller */
@@ -795,17 +797,17 @@ static int fsl_qspi_default_setup(struct fsl_qspi *q)
 	 * In HW there can be a maximum of four chips on two buses with
 	 * two chip selects on each bus. We use four chip selects in SW
 	 * to differentiate between the four chips.
-	 * We use ahb_buf_size for each chip and set SFA1AD, SFA2AD, SFB1AD,
-	 * SFB2AD accordingly.
+	 *
+	 * By default we write the AHB buffer size to each chip, but
+	 * a different size can be specified with devtype_data->sfa_size.
+	 * The SFA1AD, SFA2AD, SFB1AD, and SFB2AD registers define the
+	 * top (end) of these four regions.
 	 */
-	qspi_writel(q, q->devtype_data->ahb_buf_size + addr_offset,
-		    base + QUADSPI_SFA1AD);
-	qspi_writel(q, q->devtype_data->ahb_buf_size * 2 + addr_offset,
-		    base + QUADSPI_SFA2AD);
-	qspi_writel(q, q->devtype_data->ahb_buf_size * 3 + addr_offset,
-		    base + QUADSPI_SFB1AD);
-	qspi_writel(q, q->devtype_data->ahb_buf_size * 4 + addr_offset,
-		    base + QUADSPI_SFB2AD);
+	sfa_size = q->devtype_data->sfa_size ? : q->devtype_data->ahb_buf_size;
+	qspi_writel(q, addr_offset + 1 * sfa_size, base + QUADSPI_SFA1AD);
+	qspi_writel(q, addr_offset + 2 * sfa_size, base + QUADSPI_SFA2AD);
+	qspi_writel(q, addr_offset + 3 * sfa_size, base + QUADSPI_SFB1AD);
+	qspi_writel(q, addr_offset + 4 * sfa_size, base + QUADSPI_SFB2AD);
 
 	q->selected = -1;
 
-- 
2.48.1


