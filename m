Return-Path: <linux-spi+bounces-3893-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C15E9346DF
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jul 2024 05:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F8B28236F
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jul 2024 03:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F80F3F8F7;
	Thu, 18 Jul 2024 03:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhwE3yFV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7DF38F91;
	Thu, 18 Jul 2024 03:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721274468; cv=none; b=kzL1edbuNwfzjiODPrsafnFfLxoAPwKO+/YfWVH95rqFWIliHb5I9qyj8Nu6TYH1CwpVMWV9pM7nNqiPlgPhpNnlHm6j4H+1O/F6E1HKYPid4kE60CE0MHC6ghpAzCp3nAWBxQzTdyNSXOBx6F9tnSmQBiKe5acomgo6imKsNZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721274468; c=relaxed/simple;
	bh=G2dxNbG4cgMahPFPA7uDxxGN/vaF2v3jj/lh8Sbhkoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qjOkXF/fzvgVJBda6SbA7kYg+kmYSYf6vZTGZOE9ZNpxVuRxhwHZTop7jL3ccaViRin672k1xIuU0yGFGDnONUf3AG8vYpPTCIlucjEpNV7ffuqLDFmzL8R/CqbEh0Nd26ZlybylIWur8MuA8ND5jvWxoeHJXcHySSkZXqxDjw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhwE3yFV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fbfb7cdb54so3110885ad.2;
        Wed, 17 Jul 2024 20:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721274466; x=1721879266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiGhB9iAlrnpuT0nNXOC/VcBouLV1340qQn/2ASaTHE=;
        b=DhwE3yFVmPQW0INBwYVmcjPtZRt85HBX/ci3HFqeGKC1nfsLrfpfdA5r9gtDKksXUA
         le+wOiVYvVlq+7+cYR7+6iariQaEhxjnR4skBajU1vlLyCjNIpkixy0C/WIkQCHfuyxj
         59/bXubuxlwoOVL6pWzHrWmE2R57tb8o4ii+cVEcuKai6jE2M5J+bYr8mFeV5ekISR1w
         PYNpAxnQj/LiQzXXab0DnhJ2T/BWNjM1GIwAX/2UCTXeDxGbSYkDaN4osZt6MZPGaiKp
         58IItdNc/xQI8VR9Ds1J2YieCdIBXcifhfhVh/7T4/ZQsKkYb/ksxlnq7aImU/eA+TmJ
         /Njg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721274466; x=1721879266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiGhB9iAlrnpuT0nNXOC/VcBouLV1340qQn/2ASaTHE=;
        b=dXOJTamPdT1N94CNhZgDehbP5WEQy+GI+s9XlfnDxnemhWZ08NjR9U66yYUG94icH2
         fqS0hCORbXuXt+fzLLJgxwQlaMVE7ZXdC8MEB0UjnuT+aAaoGNvuxb1j7JurlSTtxNuz
         6p09ZbHQ2Vdvu6WMyl5Dp1t0IcvmojHbIwN/Jw2KzC4v8+elGCKz3c7p2W0dosTYv4Nw
         IdAcm6VMx8oP9nZ3FRirh0Jz/g0MRAjhxfCrMVj9wpqAbkZOE8abjtvQGy4/Y0i7rhiK
         xc3iE05UaqNVoy17+k5E4z6J0MExg3tM2FaDieOPyb8PeydbAt0MEzMAaS8zVJko1xkm
         lSCA==
X-Forwarded-Encrypted: i=1; AJvYcCV4cFAzCCVzfwfTZSthedX/jl9C7TSS0ufJNCOQNKm5uA+bgmbzmVSyfC7iT44oPCW0OYoPRs70SRvzXUsGQtwOd39XSycXWWb6UgjV5q63j6MwTLB5ZAyqWYK9h1AhkYVx5H7CA9ge
X-Gm-Message-State: AOJu0Yw2ctRo4IVSjKkuxS9t9dBUaZE5Tz2TelKW5cF0ToEMLYgVfpZB
	HFAxTht6/TTI/G3Ach7tcdOTYm9K9rJWIMj2sEtRd2Gdp0uDiwwb
X-Google-Smtp-Source: AGHT+IHZgl9U0WUl8+4EuXclgpCb+62yP5nP7OnVXEfj9sPDD1BYRn8ossNcYdB2xJD+qRTSocLQsw==
X-Received: by 2002:a17:902:dacc:b0:1fc:5ed5:ff51 with SMTP id d9443c01a7336-1fc5ed60186mr7628615ad.43.1721274465384;
        Wed, 17 Jul 2024 20:47:45 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc54069156sm15587545ad.242.2024.07.17.20.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 20:47:45 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 72F7A805EF;
	Thu, 18 Jul 2024 11:56:56 +0800 (CST)
From: AlvinZhou <alvinzhou.tw@gmail.com>
To: linux-mtd@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	broonie@kernel.org
Cc: chengminglin@mxic.com.tw,
	leoyu@mxic.com.tw,
	AlvinZhou <alvinzhou@mxic.com.tw>,
	JaimeLiao <jaimeliao@mxic.com.tw>
Subject: [PATCH v9 2/6] spi: spi-mem: Allow specifying the byte order in Octal DTR mode
Date: Thu, 18 Jul 2024 11:46:10 +0800
Message-Id: <20240718034614.484018-3-alvinzhou.tw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240718034614.484018-1-alvinzhou.tw@gmail.com>
References: <20240718034614.484018-1-alvinzhou.tw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: AlvinZhou <alvinzhou@mxic.com.tw>

From: Tudor Ambarus <tudor.ambarus@linaro.org>

There are NOR flashes (Macronix) that swap the bytes on a 16-bit
boundary when configured in Octal DTR mode. The byte order of
16-bit words is swapped when read or written in Octal Double
Transfer Rate (DTR) mode compared to Single Transfer Rate (STR)
modes. If one writes D0 D1 D2 D3 bytes using 1-1-1 mode, and uses
8D-8D-8D SPI mode for reading, it will read back D1 D0 D3 D2.
Swapping the bytes may introduce some endianness problems. It can
affect the boot sequence if the entire boot sequence is not handled
in either 8D-8D-8D mode or 1-1-1 mode. Therefore, it is necessary
to swap the bytes back to ensure the same byte order as in STR modes.
Fortunately there are controllers that could swap the bytes back at
runtime, addressing the flash's endiannesses requirements. Provide a
way for the upper layers to specify the byte order in Octal DTR mode.

Merge Tudor's patch and add modifications for suiting newer version
of Linux kernel.

Suggested-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
Signed-off-by: AlvinZhou <alvinzhou@mxic.com.tw>
---
 drivers/spi/spi-mem.c       | 3 +++
 include/linux/spi/spi-mem.h | 8 +++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 17b8baf749e6..abc6792e738c 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -172,6 +172,9 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 		if (!spi_mem_controller_is_capable(ctlr, dtr))
 			return false;
 
+		if (op->data.swap16 && !spi_mem_controller_is_capable(ctlr, swap16))
+			return false;
+
 		if (op->cmd.nbytes != 2)
 			return false;
 	} else {
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index f866d5c8ed32..c46d2b8029be 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -90,6 +90,8 @@ enum spi_mem_data_dir {
  * @data.buswidth: number of IO lanes used to send/receive the data
  * @data.dtr: whether the data should be sent in DTR mode or not
  * @data.ecc: whether error correction is required or not
+ * @data.swap16: whether the byte order of 16-bit words is swapped when read
+ *		 or written in Octal DTR mode compared to STR mode.
  * @data.dir: direction of the transfer
  * @data.nbytes: number of data bytes to send/receive. Can be zero if the
  *		 operation does not involve transferring data
@@ -124,7 +126,8 @@ struct spi_mem_op {
 		u8 buswidth;
 		u8 dtr : 1;
 		u8 ecc : 1;
-		u8 __pad : 6;
+		u8 swap16 : 1;
+		u8 __pad : 5;
 		enum spi_mem_data_dir dir;
 		unsigned int nbytes;
 		union {
@@ -297,10 +300,13 @@ struct spi_controller_mem_ops {
  * struct spi_controller_mem_caps - SPI memory controller capabilities
  * @dtr: Supports DTR operations
  * @ecc: Supports operations with error correction
+ * @swap16: Supports swapping bytes on a 16 bit boundary when configured in
+ *	    Octal DTR
  */
 struct spi_controller_mem_caps {
 	bool dtr;
 	bool ecc;
+	bool swap16;
 };
 
 #define spi_mem_controller_is_capable(ctlr, cap)	\
-- 
2.25.1


