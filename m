Return-Path: <linux-spi+bounces-937-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C556D845460
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 10:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F789B2BEF7
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 09:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AB84DA09;
	Thu,  1 Feb 2024 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDLkS49r"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D5E4D9F3
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780644; cv=none; b=fy50nANTEbHt3KhQRbFXHEkYzqijFoUToYRYm7NHb3CUjVekAIf6aevSoLnTpkskG5+1lYd3vH3hIXNmpQ1z7Z2l+2O+eZ201yEh1LG/C2JToVTMx6a4/Y/vhBjmRDVPzif979F/hkGXQXLcRV0rLHQgmbMcUTXUw8UUduTIYOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780644; c=relaxed/simple;
	bh=sszkkiZn/RtQvZkMs6QRmdn9w4nqfNW5BJolls13MWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FeJuNVmaqSlreOAMyEQRB3xbc80KDcGeMk/PGAkxTUikSVJUWm+qCNHHZjvYuKKUBwub23u20Z80zdk+Si8fDWAED+Dnlu4uFCDHRSw1gR0UpZ3JgaRGhMT3/mgtMHr8ftvw6VUkP9x73kxUJSNWLbq7U9aqeuJzbhcTUR05pf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDLkS49r; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d958e0d73dso1540505ad.1
        for <linux-spi@vger.kernel.org>; Thu, 01 Feb 2024 01:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706780642; x=1707385442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IoiHjEiMC3UMdObp3d7N54tn3HfFZxLoxbXJN0bZHnQ=;
        b=BDLkS49rA19NhAqgv2RqDVnKMWMfIIy17gSXj2OjARTlxaMIJAR4WlFVEsx5NWQX6C
         6gYvjZpxR9oA5tRFTn56QxEo/ek+MAFHLh/3Elq7CYNvu54QNRfZhByIiI44Xmdtpc0R
         RsJtUoMJdbrF0hFKSdHnNdnF6jZ8j1MHiGHtnWHUHkOsX1k6Vj7a34QiTXfcd2Qdl9B6
         WoEvjPpSi72lxu4KGLRmgnU7ly+oFZcQbuoeB0rcnl4BvrIhxd6aPHxhxOC5OWXIjrqD
         LEmGoMFOVICtyMSpZFsJ7lun1sX3dUVdiV8UPRFQ7W99wcLVWYH4JeeKFt9xyVwAKMo2
         G3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706780642; x=1707385442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IoiHjEiMC3UMdObp3d7N54tn3HfFZxLoxbXJN0bZHnQ=;
        b=SF5NG0wiJtwQdtgu5Ze+wlYy9bDgMNjaT3g/0rxTTech+VfEgIwSuyvOed0EI37Nqf
         YAhx1n+eXZYaTfVrzZ2tmKI0+JZM8OrtzrlvYdO/Io7mrR/27J+bKWiAI8qTSbK99gxN
         8KUA7+hxP1pVSLPQZLMjpIrxTwiM5AtRHAfVc+EniTodiTlc2GcO8A7FyJ9yYw9KLQV3
         Mjp867ZVFZ0yy7JOWAOoT18Ad9yJQUhNhA89Q4ICogNzDTOqs/qKn59m76husMQ9hjB1
         jlxtSD4mL8Q21R0l9J91SNkYrBBOAr0Tg73CsaIixhZ4ARsnKt6Z1gyvZYnMD61yhfkd
         N1pg==
X-Gm-Message-State: AOJu0YyZsNHk7pLJBg5YdLL3Wp38NVvH8gyryBfrHA4EfmmaloFGJOQh
	/QGBup5PuOqDc03Xp3TIsJjC9PF9+cghh7iDDMgIhJmyYsqul7Nb
X-Google-Smtp-Source: AGHT+IGpofVE8+1A4v18ik09Z9DQ6s7IB9a8JzcJEF7L9/ME+uTbuwDmEMtorXGNustkpH/CxCVKuw==
X-Received: by 2002:a17:903:18b:b0:1d8:cfc9:a323 with SMTP id z11-20020a170903018b00b001d8cfc9a323mr5720590plg.34.1706780641761;
        Thu, 01 Feb 2024 01:44:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVxmBobAx6Trzn8ZtUNlOZOeK/OiTwOnOUUmmnVRQALXxlEpjup6DuU73K30cva7xNJWBlVigk0TX7fquX7BBaQghHKv05cJAUeQ0zPt8Khg5bIAYD0MIIVPKbfgfsKQDJGEsMyAA7I9JVPSqdX9b10u8Xz58vDiinhGkWwaPEOH8b5D4SmxCFgYEY6eFrB0SOpAZ4yBcLaYinTF5kAYKPyh7HQBEtA/e1j+wXvNczq5RbAnqDtyuH/3pISIjtHJ7lbs36SLe+VIvfJVSgJ+BlkbqrMtTJ0Vq0Fkz00LQDH5UAci2CrYQNyHqew2B8i00IPtA==
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id y19-20020a170902ed5300b001d8b0750940sm9301170plb.175.2024.02.01.01.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 01:44:01 -0800 (PST)
Received: from hqs-appsw-appswa2.mp600.macronix.com (linux-patcher [172.17.236.35])
	by twhmp6px (Postfix) with ESMTPS id D21C2808AB;
	Thu,  1 Feb 2024 17:50:01 +0800 (CST)
From: Jaime Liao <jaimeliao.tw@gmail.com>
To: linux-mtd@lists.infradead.org,
	linux-spi@vger.kernel.org,
	tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	broonie@kernel.org
Cc: leoyu@mxic.com.tw,
	jaimeliao@mxic.com.tw
Subject: [PATCH v8 2/9] spi: spi-mem: Allow specifying the byte order in Octal DTR mode
Date: Thu,  1 Feb 2024 17:43:46 +0800
Message-Id: <20240201094353.33281-3-jaimeliao.tw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240201094353.33281-1-jaimeliao.tw@gmail.com>
References: <20240201094353.33281-1-jaimeliao.tw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: JaimeLiao <jaimeliao@mxic.com.tw>

There are NOR flashes (Macronix) that swap the bytes on a 16-bit
boundary when configured in Octal DTR mode. The byte order of
16-bit words is swapped when read or written in Octal Double
Transfer Rate (DTR) mode compared to Single Transfer Rate (STR)
modes. If one writes D0 D1 D2 D3 bytes using 1-1-1 mode, and uses
8D-8D-8D SPI mode for reading, it will read back D1 D0 D3 D2.
Swapping the bytes may introduce some endianness problems. It can
affect the boot sequence if the entire boot sequence is not handled
in either 8D-8D-8D mode or 1-1-1 mode. So we must swap the bytes
back to have the same byte order as in STR modes. Fortunately there
are controllers that could swap the bytes back at runtime,
addressing the flash's endiannesses requirements. Provide a way for
the upper layers to specify the byte order in Octal DTR mode.

Merge Tudor's patch and add modifications for suiting newer version
of Linux kernel.

Suggested-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
---
 drivers/spi/spi-mem.c       | 4 ++++
 include/linux/spi/spi-mem.h | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 2dc8ceb85374..f8120f6b288f 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -172,6 +172,10 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 		if (!spi_mem_controller_is_capable(ctlr, dtr))
 			return false;
 
+		if (op->data.swap16 &&
+		    !spi_mem_controller_is_capable(ctlr, swap16))
+			return false;
+
 		if (op->cmd.nbytes != 2)
 			return false;
 	} else {
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index f866d5c8ed32..8df44fbc9d99 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -89,6 +89,8 @@ enum spi_mem_data_dir {
  * @dummy.dtr: whether the dummy bytes should be sent in DTR mode or not
  * @data.buswidth: number of IO lanes used to send/receive the data
  * @data.dtr: whether the data should be sent in DTR mode or not
+ * @data.swap16: whether the byte order of 16-bit words is swapped when read
+ *		 or written in Octal DTR mode compared to STR mode.
  * @data.ecc: whether error correction is required or not
  * @data.dir: direction of the transfer
  * @data.nbytes: number of data bytes to send/receive. Can be zero if the
@@ -123,6 +125,7 @@ struct spi_mem_op {
 	struct {
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 swap16 : 1;
 		u8 ecc : 1;
 		u8 __pad : 6;
 		enum spi_mem_data_dir dir;
@@ -296,10 +299,13 @@ struct spi_controller_mem_ops {
 /**
  * struct spi_controller_mem_caps - SPI memory controller capabilities
  * @dtr: Supports DTR operations
+ * @swap16: Supports swapping bytes on a 16 bit boundary when configured in
+ *	    Octal DTR
  * @ecc: Supports operations with error correction
  */
 struct spi_controller_mem_caps {
 	bool dtr;
+	bool swap16;
 	bool ecc;
 };
 
-- 
2.25.1


