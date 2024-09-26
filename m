Return-Path: <linux-spi+bounces-5001-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2737B98758C
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 16:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F211F2167F
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 14:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8C415445E;
	Thu, 26 Sep 2024 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhV/04VR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBC11531F9;
	Thu, 26 Sep 2024 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360716; cv=none; b=galnVrf4C+DXbOCQfbSSOkrLgSXUuBVdZODtYTGA3Hx+TE4sVTxLKemqj2oyHaTVaXtuX36CbB5t8zEtKiGgrVEPyFtMxuPJtLxiXBV0OIon/GQKaNH4uyAm/X/2i3aHfsKf4+mV1N+Pe3/6RFjjo1tUAyB6rzz0Z+lOjTHyGag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360716; c=relaxed/simple;
	bh=4HS0BLQDWQ5+Pw4Bu39Lc5Cng7KYv0KoOc6kakqE+1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gjJiruH2H4T2cLgxhldbn9eXdKS3krktRLyX1z9EXfM+GnqUndFfjzyS+yYNF8437kb24l7nYtrakA+jloUeZAeS4xjJd59G/WbTBmK0f4IeKr3+PEbGB7fVe02V7PpNXZ5VA1mjwc3xhIKnslH5YNubq7bva3wFYY/ICxZAoCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhV/04VR; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718816be6cbso930293b3a.1;
        Thu, 26 Sep 2024 07:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727360715; x=1727965515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/MUwzKscwhtX7s3jSH4IlHx8F0q+vgLMrLzXFhkBRw=;
        b=EhV/04VRpDRxoZ2NdsewKgwQmKQT3t/Y8AcaERj6zs3jll6S4ZJD9JIty+2aqvoyPb
         vpnWpTAguIJU7B2yWkDnkWn74cv5MNgbOHbso7/1GhRE4SgYPF1Ya9pDVowcKwem81zE
         Cnbk00yLmZSBNL5lrKWzM63POnFgtabKrJkQEkD7MfqhpCuzBljLPNr5UXivhEmu3La1
         VOZ1Y86yN8RKnEsQLhCUPoAZcPspIdHA57lC4Rp6OFgMQP+n+bqvtyy9DE7iMTSdOtXP
         XE3we4TUpsPKMu9fkc0D7ZCp74cOuOmqyGt1Eg9NefRYc16RbqmJs5ILCmEdXMxg4dIQ
         RkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727360715; x=1727965515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/MUwzKscwhtX7s3jSH4IlHx8F0q+vgLMrLzXFhkBRw=;
        b=fgtsti9mO31fDg52LK4kv1XM6LONsHCnOWLoiibhbnm2FNw5L+KdkaZVX8fuBhk0fR
         g5TTtVcvjMvKcLc/Q0T32NaN6gtfC6w2dRDjz6rI/HfFbJrtquOVx6F15Z8OSMAGp94F
         zrnIMW6ggYObEbjScgyZ+dT0fNouUFlZXzHVTJZdPUhkTnMmAoEBlhPeAsd+GMdmtTV4
         lzLozp3VRTJ7SMXGMjHGKrc3pfoIQ1dHWIEMrSBnSi2EqwtM0V4I0V4Ur+SSzBcxYKAT
         bdQUhCzJQRDTpDAmmjXK4NNrQZMrJJhJZu1umlU304ZSBHhrGG3faB84NfhX/gYvSzWW
         MuHg==
X-Forwarded-Encrypted: i=1; AJvYcCV2OY1BtGECPDS5xAeIGqiQVheuLPG53fDF8NeSa356cNSxPtkrePuULzcZXkZzuF7E37cncCBxBO5gLCg=@vger.kernel.org, AJvYcCWVcIy4xMtAxtWPs/wq4eZEsS3hglsQOIzSKamhIpv5EL0y6ds4qXxCMqhTj5w3QiTWsGl+n0yR/kc6@vger.kernel.org
X-Gm-Message-State: AOJu0YxPshhq4ooTZX/Boyba/VK9nYlnArz5Vy/13DLUotY2sELJ33FR
	m1Jgl7gEWRx413CbqA2MREkdMu1s1zrr8t2udD1+IvptBQrcsELL
X-Google-Smtp-Source: AGHT+IGS0nM82au/EzeP06wausitoOEDIM3uRThhNjvR3ugckuZHWCaNJRiYUN2+/U97e/3zZ/d4TA==
X-Received: by 2002:a05:6a00:9284:b0:718:db7c:3a49 with SMTP id d2e1a72fcca58-71b0ac993b2mr8763854b3a.27.1727360714488;
        Thu, 26 Sep 2024 07:25:14 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c732c8sm4360707a12.71.2024.09.26.07.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 07:25:14 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 2374780529;
	Thu, 26 Sep 2024 22:33:01 +0800 (CST)
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
Subject: [PATCH v10 2/6] spi: spi-mem: Allow specifying the byte order in Octal DTR mode
Date: Thu, 26 Sep 2024 22:19:52 +0800
Message-Id: <20240926141956.2386374-3-alvinzhou.tw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240926141956.2386374-1-alvinzhou.tw@gmail.com>
References: <20240926141956.2386374-1-alvinzhou.tw@gmail.com>
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
runtime, addressing the flash's endianness requirements. Provide a
way for the upper layers to specify the byte order in Octal DTR mode.

Merge Tudor's patch and add modifications for suiting newer version
of Linux kernel.

Suggested-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
Signed-off-by: AlvinZhou <alvinzhou@mxic.com.tw>
Acked-by: Mark Brown <broonie@kernel.org>
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


